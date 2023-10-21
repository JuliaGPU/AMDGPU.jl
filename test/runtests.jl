using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import AMDGPU.Device: HostCallHolder, hostcall!

using LinearAlgebra
using ReTestItems
using Test

macro grab_output(ex, io=stdout)
    quote
        mktemp() do fname, fout
            ret = nothing
            open(fname, "w") do fout
                if $io == stdout
                    redirect_stdout(fout) do
                        ret = $(esc(ex))
                    end
                elseif $io == stderr
                    redirect_stderr(fout) do
                        ret = $(esc(ex))
                    end
                end
            end
            ret, read(fname, String)
        end
    end
end

AMDGPU.allowscalar(false)

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

@info "Running following tests: $TARGET_TESTS."

# Run tests in parallel.
np = set_jobs ? jobs : (Sys.CPU_THREADS ÷ 2)
# Limit to 4 workers, otherwise unfortunate things happen (fences timeout).
np = clamp(np, 1, 4)

@info "Running tests with $np workers."
@info "Testing using device $(AMDGPU.device())."
AMDGPU.versioninfo()

if "core" in TARGET_TESTS
    @testset verbose=true "Device Functions" begin
        @info "Testing `Device Functions` on the main thread without workers."

        include("device/synchronization.jl")
        # include("device/launch.jl")
        # include("device/array.jl")
        # include("device/vadd.jl")
        # include("device/memory.jl")
        # include("device/indexing.jl")
        # include("device/math.jl")
        # include("device/wavefront.jl")
        # include("device/execution_control.jl")
        # include("device/exceptions.jl")
        # include("device/hostcall.jl")
        # include("device/output.jl")
    end
end

# CI = parse(Bool, get(ENV, "CI", "false"))

# runtests(AMDGPU; nworkers=np, nworker_threads=1, testitem_timeout=60 * 30) do ti
#     for tt in TARGET_TESTS
#         startswith(ti.name, tt) && return true
#     end
#     return false
# end
