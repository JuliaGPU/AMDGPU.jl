@static if VERSION < v"1.11"
    using Pkg
    Pkg.add(url="https://github.com/JuliaGPU/KernelAbstractions.jl", rev="main")
end

using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import AMDGPU.Device: HostCallHolder, hostcall!

import Pkg
import PrettyTables
import InteractiveUtils

using LinearAlgebra
using ReTestItems
using Test

import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

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

# const TEST_NAMES = ["core", "hip", "ext", "gpuarrays", "kernelabstractions", "enzyme"]
const TEST_NAMES = ["kernelabstractions"]

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

# Do not run Enzyme tests by default.
const TARGET_TESTS = isempty(ARGS) ?
    [t for t in TEST_NAMES if t != "enzyme"] :
    ARGS

if "enzyme" in TARGET_TESTS
    Pkg.add(["EnzymeCore", "Enzyme"])
end

# Configure number of test workers.
np = set_jobs ? jobs : Sys.CPU_THREADS
np = clamp(np, 1, 4)
np = min(np, length(TARGET_TESTS))

InteractiveUtils.versioninfo()
AMDGPU.versioninfo()

@info "Test suite info"
data = String["$np" "$(AMDGPU.device())" join(TARGET_TESTS, ", ");]
PrettyTables.pretty_table(data; column_labels=["Workers", "Device", "Tests"],
                          fit_table_in_display_vertically=false,
                          fit_table_in_display_horizontally=false)

# Hack to define GPUArrays `@testitems` dynamically - by writing them to a file.
function write_gpuarrays_tests()
    template = """
    @testsetup module TSGPUArrays
        export gpuarrays_test

        import GPUArrays, AMDGPU
        include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

        gpuarrays_test(test_name::String) = TestSuite.tests[test_name](AMDGPU.ROCArray)
    end
    """
    for test_name in keys(TestSuite.tests)
        template = """
        $template
        @testitem "gpuarrays - $test_name" setup=[TSGPUArrays] begin gpuarrays_test("$test_name") end
        """
    end

    test_file = joinpath(dirname(@__FILE__), "gpuarrays_generated_tests.jl")
    open(io -> write(io, template), test_file, "w")
    @info "Writing GPUArrays test file: `$test_file`."
    return
end
write_gpuarrays_tests()

runtests(AMDGPU; nworkers=np, nworker_threads=1, testitem_timeout=60 * 30) do ti
    for tt in TARGET_TESTS
        startswith(ti.name, tt) && return true
    end
    return false
end

if "core" in TARGET_TESTS && Sys.islinux()
    @info "Testing `Hostcalls` on the main thread."
    @testset "Hostcalls" begin
        include("device/hostcall.jl")
        include("device/output.jl")
    end
end
