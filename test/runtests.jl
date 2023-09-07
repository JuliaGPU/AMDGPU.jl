using Distributed
using Test

const TEST_NAMES = ["core", "hip", "ext", "gpuarrays", "kernelabstractions"]

function parse_flags!(args, flag; default = nothing, typ = typeof(default))
    for f in args
        startswith(f, flag) || continue

        if f != flag
            val = split(f, '=')[2]
            if !(typ ≡ nothing || typ <: AbstractString)
                val = parse(typ, val)
            end
        else
            val = default
        end

        filter!(x -> x != f, args)
        return true, val
    end
    return false, default
end

do_help, _ = parse_flags!(ARGS, "--help")
if do_help
    println("""
    Usage: runtests.jl [--help] [--list] [TESTS...]

        --help             Show this text.
        --jobs=N           Launch `N` processes to perform tests (default: Sys.CPU_THREADS ÷ 2).
        --list             List all available tests (default: all).

        Remaining arguments filter the tests that will be executed.""")
    exit(0)
end

do_list, _ = parse_flags!(ARGS, "--list")
if do_list
    println("Available tests to run: $TEST_NAMES.")
    exit(0)
end

set_jobs, jobs = parse_flags!(ARGS, "--jobs"; typ=Int)

# No options should remain.
optlike_args = filter(startswith("-"), ARGS)
if !isempty(optlike_args)
    error("""
    Unknown test options: `$(join(optlike_args, " "))`.
    Try `--help` for usage instructions.
    """)
end

for test_name in ARGS
    test_name in ARGS || error("""
    Unknown test name: `$test_name`.
    Try `--list` for available tests.
    """)
end

const TARGET_TESTS = isempty(ARGS) ? TEST_NAMES : ARGS

include("setup.jl")

@info "Running following tests: $TARGET_TESTS."
@info "Testing using device $(AMDGPU.device())."
AMDGPU.versioninfo()

if "core" in TARGET_TESTS
    @testset verbose=true "Device Functions" begin
        @info "Testing `Device Functions` on the main thread without workers."

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
end

@testset "AMDGPU" begin

@test length(AMDGPU.devices()) > 0

# Run tests in parallel.
np = set_jobs ? jobs : (Sys.CPU_THREADS ÷ 2)
# Limit to 4 workers, otherwise unfortunate things happen (fences timeout).
np = clamp(np, 1, 4)

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

if "core" in TARGET_TESTS
    push!(tests, "HSA" => () -> begin
        include("hsa/utils.jl")
        include("hsa/getinfo.jl")
        include("hsa/device.jl")
    end)
    push!(tests, "Codegen" => () -> begin
        include("codegen/synchronization.jl")
        include("codegen/trap.jl")
    end)
    push!(tests, "Multitasking" => () -> include("tls.jl"))
    push!(tests, "ROCArray - Base" => () -> include("rocarray/base.jl"))
    push!(tests, "ROCArray - Broadcast" => () -> include("rocarray/broadcast.jl"))
end

if "hip" in TARGET_TESTS
    push!(tests, "ROCm libraries are functional" => () -> begin
        @test AMDGPU.functional(:rocblas)
        @test AMDGPU.functional(:rocrand)
        if !AMDGPU.use_artifacts()
            # We don't have artifacts for these
            @test AMDGPU.functional(:rocfft)
        end
    end)
    push!(tests, "rocBLAS" => () -> begin
        if AMDGPU.functional(:rocblas)
            include("rocarray/blas.jl")
        else
            @test_skip "rocBLAS"
        end
    end)
    push!(tests, "rocSOLVER" => () -> begin
        if AMDGPU.functional(:rocsolver)
            include("rocarray/solver.jl")
        else
            @test_skip "rocSOLVER"
        end
    end)
    push!(tests, "rocSPARSE" => () -> begin
        if AMDGPU.functional(:rocsparse)
            include("rocsparse/rocsparse.jl")
        else
            @test_skip "rocSPARSE"
        end
    end)
    push!(tests, "rocRAND" => () -> begin
        if AMDGPU.functional(:rocrand)
            include("rocarray/random.jl")
        else
            @test_skip "rocRAND"
        end
    end)
    push!(tests, "rocFFT" => () -> begin
        if AMDGPU.functional(:rocfft)
            include("rocarray/fft.jl")
        else
            @test_skip "rocFFT"
        end
    end)
    push!(tests, "MIOpen" => () -> begin
        if AMDGPU.functional(:MIOpen)
            include("dnn/miopen.jl")
        else
            @test_skip "MIOpen"
        end
    end)
    push!(tests, "AMDGPU.@elapsed" => () -> begin
        xgpu = AMDGPU.rand(Float32, 100)
        t = AMDGPU.@elapsed xgpu .+= 1
        @test t isa AbstractFloat
        @test t >= 0

        x = rand(Float32, 100)
        t = AMDGPU.@elapsed begin
            copyto!(xgpu, x)
            copyto!(x, xgpu)
        end
        @test t isa AbstractFloat
        @test t >= 0
    end)
    if length(AMDGPU.devices()) > 1
        push!(tests, "HIP Peer Access" => () -> begin
            dev1, dev2, _ = AMDGPU.devices()
            @test AMDGPU.HIP.can_access_peer(dev1, dev2) isa Bool
        end)
    end
end

"ext" in TARGET_TESTS && push!(tests,
    "External Packages" => () -> include("external/forwarddiff.jl"))

if "gpuarrays" in TARGET_TESTS
    for (i, name) in enumerate(sort(collect(keys(TestSuite.tests))))
        push!(tests, "GPUArrays TestSuite - $name" => () -> begin
            TestSuite.tests[name](ROCArray)
            # Multidimensional indexing involves boxing, launching global malloc hostcall.
            # Synchronize to disable it.
            if name == "indexing multidimensional"
                AMDGPU.synchronize(; blocking=false)
            end
        end)
    end
end

if "kernelabstractions" in TARGET_TESTS
    push!(tests, "KernelAbstractions" => ()-> begin
        Testsuite.testsuite(
            ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
            skip_tests=Set(["Printing", "sparse"])) # TODO fix KA printing
        # Disable global malloc hostcall started by conversion tests.
        AMDGPU.synchronize(; blocking=false)
    end)
end

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
