using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import AMDGPU.Device: HostCallHolder, hostcall!

import Pkg
import PrettyTables
import InteractiveUtils

using ParallelTestRunner
using Test

AMDGPU.allowscalar(false)

# Test names for filtering (excluding enzyme by default)
const DEFAULT_TESTS = ["core", "device", "hip", "external", "gpuarrays", "kernelabstractions", "wmma"]

function parse_flags!(args, flag; default = nothing, typ = typeof(default))
    for f in args
        startswith(f, flag) || continue

        if f != flag
            val = split(f, '=')[2]
            if !(typ === nothing || typ <: AbstractString)
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
    Usage: runtests.jl [--help] [--list] [--jobs=N] [TESTS...]

        --help             Show this text.
        --jobs=N           Launch `N` processes to perform tests (defaults to dynamically inspecting nthreads and RAM availability of the CPU)
        --list             List all available tests.

        Remaining arguments filter the tests that will be executed.""")
    exit(0)
end

do_list, _ = parse_flags!(ARGS, "--list")
if do_list
    println("Available tests to run: $DEFAULT_TESTS, enzyme.")
    exit(0)
end

# No options should remain (except test names).
optlike_args = filter(startswith("-"), ARGS)
if !isempty(optlike_args)
    error("""
    Unknown test options: `$(join(optlike_args, " "))`.
    Try `--help` for usage instructions.
    """)
end

# Determine which tests to run
const TARGET_TESTS = isempty(ARGS) ? DEFAULT_TESTS : ARGS

if "enzyme" in TARGET_TESTS
    Pkg.add(["EnzymeCore", "Enzyme"])
end

InteractiveUtils.versioninfo()
AMDGPU.versioninfo()

@info "Test suite info"
data = String["$(AMDGPU.device())" join(TARGET_TESTS, ", ");]
PrettyTables.pretty_table(data; column_labels=["Device", "Tests"],
                          fit_table_in_display_vertically=false,
                          fit_table_in_display_horizontally=false)

# Run tests with ParallelTestRunner
runtests(AMDGPU, ARGS)

# Hostcall tests must run on main thread (not in parallel workers)
if "core" in TARGET_TESTS && Sys.islinux()
    @info "Testing `Hostcalls` on the main thread."
    @testset "Hostcalls" begin
        include("device/hostcall.jl")
        include("device/output.jl")
    end
end
