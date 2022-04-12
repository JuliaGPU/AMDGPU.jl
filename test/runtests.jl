using AMDGPU
using AMDGPU: HSA, AS
if AMDGPU.functional(:hip)
    using AMDGPU: HIP
end
using GPUCompiler
using LinearAlgebra
using LLVM, LLVM.Interop
using InteractiveUtils
using SpecialFunctions
using Test

using Random
Random.seed!(1)

include("util.jl")

# GPUArrays has a testsuite that isn't part of the main package.
# Include it directly.
import GPUArrays
gpuarrays = pathof(GPUArrays)
gpuarrays_root = dirname(dirname(gpuarrays))
include(joinpath(gpuarrays_root, "test", "testsuite.jl"))
testf(f, xs...; kwargs...) = TestSuite.compare(f, ROCArray, xs...; kwargs...)

import AMDGPU: allowscalar, @allowscalar
allowscalar(false)

CI = parse(Bool, get(ENV, "CI", "false"))

@testset "AMDGPU" begin

@testset "Core" begin
include("pointer.jl")
end

@test AMDGPU.functional()
@assert AMDGPU.functional()

@test length(get_agents()) > 0

@info "Testing using device $(get_default_agent())"

@testset "HSA" begin
    # println("testing hsa/error.jl")
    # @time include("hsa/error.jl")
    # println("testing hsa/agent.jl")
    # @time include("hsa/agent.jl")
    println("testing hsa/memory.jl")
    @time include("hsa/memory.jl")
    println("testing hsa/utils.jl")
    @time include("hsa/utils.jl")
end
@testset "Codegen" begin
    include("codegen/synchronization.jl")
    include("codegen/trap.jl")
end
@testset "Device Functions" begin
    include("device/launch.jl")
    include("device/vadd.jl")
    include("device/memory.jl")
    include("device/indexing.jl")
    include("device/hostcall.jl")
    include("device/output.jl")
    include("device/globals.jl")
    include("device/math.jl")
    include("device/wavefront.jl")
    include("device/execution_control.jl")
    include("device/exceptions.jl")
    include("device/deps.jl")
    include("device/queries.jl")
end
@testset "ROCArray" begin
    include("rocarray/base.jl")
    include("rocarray/broadcast.jl")
    @testset "GPUArrays test suite" begin
        TestSuite.test(ROCArray)
    end
    @testset "ROCm External Libraries" begin
        if CI
            @test AMDGPU.functional(:rocblas)
            @test AMDGPU.functional(:rocrand)
            @test AMDGPU.functional(:rocfft)
        end
        if AMDGPU.functional(:rocblas)
            include("rocarray/blas.jl")
        else
            @test_skip "rocBLAS"
        end
        if AMDGPU.functional(:rocrand)
            include("rocarray/random.jl")
        else
            @test_skip "rocRAND"
        end
        if AMDGPU.functional(:rocfft)
            include("rocarray/fft.jl")
        else
            @test_skip "rocFFT"
        end
        if AMDGPU.functional(:rocblas)
            include("rocarray/nmf.jl")
        else
            @test_skip "NMF"
        end
    end
end
@testset "External Packages" begin
    include("external/forwarddiff.jl")
end

end
