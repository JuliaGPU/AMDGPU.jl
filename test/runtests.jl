using AMDGPU
using AMDGPU: HSA, AS
using GPUCompiler
using LinearAlgebra
using LLVM, LLVM.Interop
using InteractiveUtils
using SpecialFunctions
using Test

#using Pkg
#Pkg.add(PackageSpec(;name="GPUCompiler",rev="master"))

include("util.jl")

# copy-pasta from GPUArrays/src/testsuite.jl
convert_array(f, x) = f(x)
convert_array(f, x::Base.RefValue) = x[]
function compare(f, AT::Type{ROCArray}, xs...; kwargs...)
    cpu_in = convert_array.(copy, xs)
    gpu_in = convert_array.(AT, xs)
    cpu_out = f(cpu_in...; kwargs...)
    gpu_out = f(gpu_in...; kwargs...)
    collect(cpu_out) ≈ collect(gpu_out)
end
# copy-pasta from CuArrays/test/runtests.jl
testf(f, xs...; kwargs...) = compare(f, ROCArray, xs...; kwargs...)

agent_name = AMDGPU.get_name(get_default_agent())
agent_isa = get_first_isa(get_default_agent())
@info "Testing using device $agent_name with ISA $agent_isa"

@testset "AMDGPU" begin

@testset "Core" begin
include("pointer.jl")
end

if AMDGPU.configured
    @test length(get_agents()) > 0
    if length(get_agents()) > 0
        @testset "HSA" begin
            include("hsa/error.jl")
            include("hsa/agent.jl")
            include("hsa/array.jl")
            include("hsa/memory.jl")
            include("hsa/global.jl")
        end
        @testset "Codegen" begin
            include("codegen/synchronization.jl")
            include("codegen/trap.jl")
        end
        @testset "Device" begin
            include("device/launch.jl")
            include("device/vadd.jl")
            include("device/memory.jl")
            include("device/indexing.jl")
            include("device/hostcall.jl")
            include("device/output.jl")
            include("device/globals.jl")
            include("device/math.jl")
        end
        @testset "ROCArray" begin
            @testset "ROCm External Libraries" begin
                isdefined(AMDGPU, :rocBLAS) ? include("rocarray/blas.jl") : @test_skip "rocBLAS"
                isdefined(AMDGPU, :rocFFT) ? include("rocarray/fft.jl") : @test_skip "rocFFT"
            end
        end
    end
else
    @warn("AMDGPU.jl has not been configured; skipping on-device tests.")
end

end
