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
    :hiptensor => name -> startswith(name, "hiptensor/"),
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

    const eltypes = [Int16, Int32, Int64,
                     Float16, Float32, Float64,
                     ComplexF16, ComplexF32, ComplexF64,
                     Complex{Int16}, Complex{Int32}, Complex{Int64}]
    # Kernels are compiled with Julia's in-tree LLVM, and the LLVM 18 that Julia 1.12
    # ships with miscompiles Int128 arithmetic on AMDGPU (JuliaGPU/AMDGPU.jl#1002).
    # Only exercise Int128 as a generic element type on newer LLVM versions.
    const int128_supported = Base.libllvm_version >= v"19"
    if int128_supported
        push!(eltypes, Int128)
    end
    TestSuite.supported_eltypes(::Type{<:AMDGPU.ROCArray}) = eltypes

    # LLVM 20 still miscompiles the Int128 multiply-add that GPUArrays' `axpy!` and
    # `axpby!` lower to, so keep Int128 out of that suite. `core/rocarray_broadcast`
    # carries a `@test_broken` that starts failing once the miscompilation is fixed.
    TestSuite.supported_eltypes(
        ::Type{<:AMDGPU.ROCArray}, ::typeof(TestSuite.test_linalg_core),
    ) = filter(!=(Int128), eltypes)

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
