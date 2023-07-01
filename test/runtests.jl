using Distributed
using Test

include("setup.jl")

@testset "AMDGPU" begin

# Run tests in parallel
np = 1 # Threads.nthreads()
ws = Int[]
ws_pids = Int[]
if np == 1
    push!(ws, 1)
    push!(ws_pids, getpid())
else
    for i in 1:np
        w = first(addprocs(1; exeflags=AMDGPU.julia_exeflags()))
        @everywhere [w] include("setup.jl")
        pid = remotecall_fetch(getpid, w)
        push!(ws, w)
        push!(ws_pids, pid)
    end
end
atexit() do
    for (w, pid) in zip(ws, ws_pids)
        w == 1 && continue
        @info "Shutting down worker $w"
        try
            # Try to gracefully terminate the process
            rmprocs(w; waitfor=3)
        catch err
            @warn "Forcing down worker $w"
            # Send a loving SIGKILL
            ccall(:kill, Cint, (Cint, Cint), pid, 9)
        end
    end
end
failed = Ref(false)
tests = Pair{String,Function}[]
tasks = Dict{Int,String}()

@test length(AMDGPU.devices()) > 0
@info "Testing using device $(AMDGPU.default_device())"
AMDGPU.versioninfo()

@info "Running tests with $(length(ws)) workers"

push!(tests, "HSA" => ()->begin
    include("hsa/utils.jl")
    include("hsa/getinfo.jl")
    include("hsa/device.jl")
end)
push!(tests, "Codegen" => ()->begin
    include("codegen/synchronization.jl")
    include("codegen/trap.jl")
end)
# if AMDGPU.Runtime.LOGGING_STATIC_ENABLED
#     push!(tests, "Logging" => ()->include("logging.jl"))
# else
#     @warn """
#     Logging is statically disabled, skipping logging tests.
#     This can be fixed by calling `AMDGPU.Runtime.enable_logging!()` and re-running tests.
#     """
#     @test_skip "Logging"
# end
push!(tests, "Device Functions" => ()->begin
    include("device/launch.jl")
    include("device/array.jl")
    include("device/vadd.jl")
    include("device/memory.jl")
    include("device/indexing.jl")
    include("device/math.jl")
    include("device/wavefront.jl")
    include("device/execution_control.jl")
    include("device/exceptions.jl")
    include("device/hostcall.jl")
    # include("device/output.jl")
end)
push!(tests, "Multitasking" => ()->include("tls.jl"))
push!(tests, "ROCArray - Base" => ()->include("rocarray/base.jl"))
push!(tests, "ROCArray - Broadcast" => ()->include("rocarray/broadcast.jl"))
if CI
    push!(tests, "ROCm libraries are functional" => ()->begin
        @test AMDGPU.functional(:rocblas)
        @test AMDGPU.functional(:rocrand)
        if !AMDGPU.use_artifacts
            # We don't have artifacts for these
            @test AMDGPU.functional(:rocfft)
        end
    end)
end
push!(tests, "rocBLAS" => ()->begin
    if AMDGPU.functional(:rocblas)
        include("rocarray/blas.jl")
    else
        @test_skip "rocBLAS"
    end
end)
push!(tests, "rocRAND" => ()->begin
    if AMDGPU.functional(:rocrand)
        include("rocarray/random.jl")
    else
        @test_skip "rocRAND"
    end
end)
# # FIXME outdated library
# push!(tests, "rocFFT" => ()->begin
#     if AMDGPU.functional(:rocfft)
#         include("rocarray/fft.jl")
#     else
#         @test_skip "rocFFT"
#     end
# end)
push!(tests, "NMF" => ()->begin
    if AMDGPU.functional(:rocblas)
        include("rocarray/nmf.jl")
    else
        @test_skip "NMF"
    end
end)
push!(tests, "MIOpen" => ()->begin
    if AMDGPU.functional(:MIOpen)
        include("dnn/miopen.jl")
    else
        @test_skip "MIOpen"
    end
end)
push!(tests, "External Packages" => ()->include("external/forwarddiff.jl"))
for (i, name) in enumerate(keys(TestSuite.tests))
    push!(tests, "GPUArrays TestSuite - $name" =>
        () -> TestSuite.tests[name](ROCArray))
end
push!(tests, "KernelAbstractions" => ()->begin
    Testsuite.testsuite(
        ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
        skip_tests=Set(["sparse"]))
end)
# push!(tests, "TT" => () -> begin
#     @testset "sliced setindex, CPU source" begin
#         x = ROCArray(zeros(Float32, (2, 3, 4)))
#         y = ROCArray(rand(Float32, (2, 3)))
#         x[:, :, 2] = y
#         @test Array(x[:, :, 2]) == Array(y)
#     end

#     # @testset "Conv" begin
#     #     KernelAbstractions.@kernel function convert_kernel!(A, B)
#     #         tid = KernelAbstractions.@index(Global, Linear)
#     #         tid = Int64(Int32(tid))

#     #         @inbounds B[tid, 1] = ceil(Int8, A[tid])
#     #         @inbounds B[tid, 2] = ceil(Int16, A[tid])
#     #         @inbounds B[tid, 3] = ceil(Int32, A[tid])
#     #         @inbounds B[tid, 4] = ceil(Int64, A[tid])
#     #         @inbounds B[tid, 5] = ceil(Int128, A[tid])
#     #         @inbounds B[tid, 6] = ceil(UInt8, A[tid])
#     #         @inbounds B[tid, 7] = ceil(UInt16, A[tid])
#     #         @inbounds B[tid, 8] = ceil(UInt32, A[tid])
#     #         @inbounds B[tid, 9] = ceil(UInt64, A[tid])
#     #         @inbounds B[tid, 10] = ceil(UInt128, A[tid])

#     #         @inbounds B[tid, 11] = floor(Int8, A[tid])
#     #         @inbounds B[tid, 12] = floor(Int16, A[tid])
#     #         @inbounds B[tid, 13] = floor(Int32, A[tid])
#     #         @inbounds B[tid, 14] = floor(Int64, A[tid])
#     #         @inbounds B[tid, 15] = floor(Int128, A[tid])
#     #         @inbounds B[tid, 16] = floor(UInt8, A[tid])
#     #         @inbounds B[tid, 17] = floor(UInt16, A[tid])
#     #         @inbounds B[tid, 18] = floor(UInt32, A[tid])
#     #         @inbounds B[tid, 19] = floor(UInt64, A[tid])
#     #         @inbounds B[tid, 20] = floor(UInt128, A[tid])

#     #         @inbounds B[tid, 21] = round(Int8, A[tid])
#     #         @inbounds B[tid, 22] = round(Int16, A[tid])
#     #         @inbounds B[tid, 23] = round(Int32, A[tid])
#     #         @inbounds B[tid, 24] = round(Int64, A[tid])
#     #         @inbounds B[tid, 25] = round(Int128, A[tid])
#     #         @inbounds B[tid, 26] = round(UInt8, A[tid])
#     #         @inbounds B[tid, 27] = round(UInt16, A[tid])
#     #         @inbounds B[tid, 28] = round(UInt32, A[tid])
#     #         @inbounds B[tid, 29] = round(UInt64, A[tid])
#     #         @inbounds B[tid, 30] = round(UInt128, A[tid])
#     #     end

#     #     A = ROCArray([Base.rand(Float64)])
#     #     B = ROCArray(Base.zeros(Float64, 1, 30))
#     #     convert_kernel!(ROCBackend())(A, B; ndrange=1)
#     #     AMDGPU.synchronize()
#     # end
# end)

function run_worker(w)
    while !isempty(tests)
        name, task = popfirst!(tests)
        tasks[w] = name
        try
            remotecall_fetch(w, name, task) do name, task
                @testset "$name" begin
                    printstyled("Running $name\n"; color=:blue)
                    task()
                end
            end
        catch err
            while err isa RemoteException || err isa CapturedException
                if err isa RemoteException
                    err = err.captured
                elseif err isa CapturedException
                    err = err.ex
                end
            end
            if err isa TestSetException
                failed[] = true
                continue
            end
            if err isa InterruptException || err isa ProcessExitedException
                rethrow(err)
            end
            @error "Test failure for: $name" exception=err
        finally
            delete!(tasks, w)
        end
    end
end
function handle_worker(w, pid)
    try
        run_worker(w)
    catch err
        if err isa InterruptException
            exit(1)
        elseif err isa ProcessExitedException
            failed[] = true
            w_idx = findfirst(==(w), ws)
            deleteat!(ws, w_idx)
            deleteat!(ws_pids, w_idx)
            printstyled("Worker $w ($pid) died\n"; color=:red)
            start_worker!()
        else
            failed[] = true
            rethrow(err)
        end
    end
end
function start_worker!()
    w = first(addprocs(1; exeflags=AMDGPU.julia_exeflags()))
    @everywhere [w] include("setup.jl")
    pid = remotecall_fetch(getpid, w)
    push!(ws, w)
    push!(ws_pids, pid)
    printstyled("Started worker $w ($pid)\n"; color=:blue)
    errormonitor(@async handle_worker(w, pid))
end

for (w, pid) in zip(ws, ws_pids)
    errormonitor(@async handle_worker(w, pid))
end

try
    while !isempty(tests) || !isempty(tasks)
        sleep(1)
    end
catch err
    failed[] = true
    if !(err isa InterruptException)
        rethrow(err)
    end
end

if failed[]
    printstyled("FAILED\n"; color=:red, bold=true)
    exit(1)
else
    printstyled("SUCCESS\n"; color=:green, bold=true)
    exit(0)
end

end
