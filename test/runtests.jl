using Distributed
using Test

include("setup.jl")

@info "Testing using device $(AMDGPU.default_device())"
AMDGPU.versioninfo()

@info "Testing Device Functions on the main thread without workers..."
@testset verbose=true "Device Functions" begin
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
    include("device/output.jl")
end

@testset "AMDGPU" begin

@test length(AMDGPU.devices()) > 0

# Run tests in parallel

np = 4
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

@info "Running tests with $(length(ws)) workers with flags: $(AMDGPU.julia_exeflags())"

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
push!(tests, "Multitasking" => ()->include("tls.jl"))
push!(tests, "ROCArray - Base" => ()->include("rocarray/base.jl"))
push!(tests, "ROCArray - Broadcast" => ()->include("rocarray/broadcast.jl"))
if CI
    push!(tests, "ROCm libraries are functional" => ()->begin
        @test AMDGPU.functional(:rocblas)
        @test AMDGPU.functional(:rocrand)
        if !AMDGPU.use_artifacts()
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
push!(tests, "rocFFT" => ()->begin
    if AMDGPU.functional(:rocfft)
        include("rocarray/fft.jl")
    else
        @test_skip "rocFFT"
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
for (i, name) in enumerate(sort(collect(keys(TestSuite.tests))))
    push!(tests, "GPUArrays TestSuite - $name" => () -> begin
        TestSuite.tests[name](ROCArray)
        # Multidimensional indexing contains boxing,
        # launching global malloc hostcall.
        # Synchronize to disable it.
        if name == "indexing multidimensional"
            AMDGPU.synchronize(; blocking=false)
        end
    end)
end
push!(tests, "KernelAbstractions" => ()-> begin
    Testsuite.testsuite(
        ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
        skip_tests=Set(["Printing", "sparse"])) # TODO fix KA printing
    # Disable global malloc hostcall started by conversion tests.
    AMDGPU.synchronize(; blocking=false)
end)

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
