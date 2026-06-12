using AMDGPU
using AMDGPU: Device, Runtime, @allowscalar
import AMDGPU.Device: HostCallHolder, hostcall!

using ParallelTestRunner
using Test

import Pkg
import InteractiveUtils

AMDGPU.allowscalar(false)

# Force 4 workers if running on buildkite
if parse(Bool, get(ENV, "BUILDKITE", "false"))
    if !any(startswith("--jobs"), ARGS)
        push!(ARGS, "--jobs=4")
    end
end

# Default to 4 workers if running on machine with <= 32GB RAM and not on CI
if !any(startswith("--jobs"), ARGS) && (Sys.total_memory() <= 32*2^30)
   push!(ARGS, "--jobs=4")
end

@info "System information:\n"
InteractiveUtils.versioninfo()
AMDGPU.versioninfo()

include(joinpath(@__DIR__, "..", ".pkg", "platform_augmentation.jl"))

@testset "platform augmentation" begin
    @test rocm_arch_string(120000) == "gfx1200"
    @test rocm_arch_string(120001) == "gfx1201"
    @test rocm_arch_string(90010) == "gfx90a"
    @test rocm_arch_from_device_name("AMD Radeon 8050S Graphics") == "gfx1151"
    @test rocm_arch_from_device_name("AMD Radeon 890M Graphics") == "gfx1150"
    @test rocm_arch_from_device_name("AMD Radeon RX 9070 XT") == "gfx120X"
    @test rocm_arch_from_device_name("NVIDIA GeForce RTX 4090") == ""
    @test rocm_arch_comparison_strategy("gfx120X_all", "gfx1200", false, false)
    @test rocm_arch_comparison_strategy("gfx120X_all", "gfx1201", false, false)
    @test rocm_arch_comparison_strategy("gfx120X_all", "gfx120X", false, false)
    @test rocm_arch_comparison_strategy("gfx90X_dcgpu", "gfx90a", false, false)
    @test rocm_arch_comparison_strategy("gfx94X_dcgpu", "gfx942", false, false)
    @test !rocm_arch_comparison_strategy("gfx120X_all", "gfx1100", false, false)
    @test !rocm_arch_comparison_strategy("none", "gfx1200", false, false)
end

# Autodiscovered tests
testsuite = find_tests(@__DIR__)

## GPUArrays test suite
import GPUArrays
gpuarrays = pathof(GPUArrays)
gpuarrays_root = dirname(dirname(gpuarrays))
gpuarrays_testsuite = joinpath(gpuarrays_root, "test", "testsuite.jl")
include(gpuarrays_testsuite)
for name in keys(TestSuite.tests)
    testsuite["gpuarrays/$name"] = :(TestSuite.tests[$name](AMDGPU.ROCArray))
end

# Filter tests for HIP libraries that are not available.
for (lib, pred) in [
    :MIOpen    => name -> startswith(name, "hip_dnn/"),
    :rocsparse => name -> startswith(name, "hip_rocsparse/"),
    :rocblas   => name -> name == "hip_rocarray/blas",
    :rocfft    => name -> name == "hip_rocarray/fft",
    :rocrand   => name -> name == "hip_rocarray/random",
    :rocsolver => name -> name == "hip_rocarray/solver",
]
    if !AMDGPU.functional(lib)
        @info "$lib is unavailable, skipping related tests."
        filter!(((name, _),) -> !pred(name), testsuite)
    end
end

@info "Available tests:\n" * join(sort(collect(keys(testsuite))), "\n")

args = parse_args(ARGS)

# Don't run Enzyme tests by default
if filter_tests!(testsuite, args)
    delete!(testsuite, "enzyme_tests")
end

if any(name -> startswith(name, "enzyme"), keys(testsuite))
    @info "Running Enzyme tests\n"
    Pkg.add(["EnzymeCore", "Enzyme"])
end

# Hostcall tests must run on main thread (not in parallel workers). To be addressed by https://github.com/JuliaTesting/ParallelTestRunner.jl/issues/77
delete!(testsuite, "device/hostcall")
delete!(testsuite, "device/output")

# Code to run in each test's sandbox module before running the test
init_code = quote
    import GPUArrays
    using AMDGPU
    include($gpuarrays_testsuite)
    testf(f, xs...; kwargs...) = TestSuite.compare(f, AMDGPU.ROCArray, xs...; kwargs...)

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
end

runtests(AMDGPU, args; testsuite, init_code)

# Hostcall tests must run on main thread (not in parallel workers). To be addressed by https://github.com/JuliaTesting/ParallelTestRunner.jl/issues/77
if any(name -> startswith(name, "core"), keys(testsuite)) && Sys.islinux()
    @info "Testing `Hostcalls` on the main thread."
    @testset "Hostcalls" begin
        include("device/hostcall.jl")
        include("device/output.jl")
    end
end
