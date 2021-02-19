using AMDGPU
using AMDGPU: HSA, AS, HIP
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

import AMDGPU: allowscalar, @allowscalar
allowscalar(false)

@info "Testing using device $(get_default_agent())"

@testset "AMDGPU" begin

@testset "Core" begin
@test_skip include("pointer.jl")
end

if AMDGPU.configured
    @test length(get_agents()) > 0
    if length(get_agents()) > 0
        @testset "HSA" begin
            include("hsa/error.jl")
            include("hsa/agent.jl")
            include("hsa/memory.jl")
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
        end
        @testset "ROCArray" begin
            @testset "GPUArrays test suite" begin
                #TestSuite.test(ROCArray)
                for name in keys(TestSuite.tests)
                    occursin("broadcast", name) && continue
                    name == "indexing" && continue
                    name == "linear algebra" && continue
                    name == "iterator constructors" && continue
                    name == "uniformscaling" && continue
                    name == "fft" && continue
                    name == "random" && continue
                    name == "base" && continue
                    name == "mapreduce derivatives" && continue
                    @testset "$name" begin
                        TestSuite.tests[name](ROCArray)
                    end
                end
            end
            @testset "ROCm External Libraries" begin
                if parse(Bool, get(ENV, "CI", "false"))
                    @test isdefined(AMDGPU, :rocBLAS)
                    @test isdefined(AMDGPU, :rocFFT)
                    @test isdefined(AMDGPU, :rocRAND)
                end
                isdefined(AMDGPU, :rocBLAS) ? include("rocarray/blas.jl") : @test_skip "rocBLAS"
                isdefined(AMDGPU, :rocFFT) ? include("rocarray/fft.jl") : @test_skip "rocFFT"
                isdefined(AMDGPU, :rocRAND) ? include("rocarray/random.jl") : @test_skip "rocRAND"
            end
        end
        @testset "External Packages" begin
            include("external/forwarddiff.jl")
        end
    end
else
    @warn("AMDGPU.jl has not been configured; skipping on-device tests.")
end

end
