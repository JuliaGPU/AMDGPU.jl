using ROCArrays
using HSARuntime
using LinearAlgebra
using Test

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

const agent = HSARuntime.get_default_agent()
agent_name = HSARuntime.get_name(agent)
agent_isa = HSARuntime.get_first_isa(agent)
@info "Testing using device $agent_name with ISA $agent_isa"

@testset "ROCArrays" begin

@testset "ROCArrays External Libraries" begin
    isdefined(ROCArrays, :rocBLAS) ? include("blas.jl") : @test_skip "rocBLAS"
end

end # @testset "ROCArrays"
