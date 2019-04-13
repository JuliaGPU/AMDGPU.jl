using AMDGPUnative
const AG = AMDGPUnative
using LLVM, LLVM.Interop
using HSARuntime
using InteractiveUtils
using Test

HSARuntime.set_default_agent!()
agent_isa = get_first_isa(get_default_agent())
@show agent_isa

@testset "Vector Addition Kernel" begin
    function vadd(a,b,c)
        i = threadIdx().x
        c[i] = a[i] + b[i]
        return nothing
    end

    dims = (8,)
    a = round.(rand(Float32, dims) * 100)
    b = round.(rand(Float32, dims) * 100)

    d_a = HSAArray(a)
    d_b = HSAArray(b)
    d_c = similar(d_a)
    len = prod(dims)

    @show d_a.handle
    @show d_b.handle
    @show d_c.handle

    aspace = AMDGPUnative.AS.Global
    arrdims = ndims(a)
    @info "LLVM IR"
    AMDGPUnative.code_llvm(vadd, Tuple{ROCDeviceArray{Float32,arrdims,aspace},ROCDeviceArray{Float32,arrdims,aspace},ROCDeviceArray{Float32,arrdims,aspace}}; kernel=true)
    @info "GCN Device Code"
    AMDGPUnative.code_gcn(vadd, Tuple{ROCDeviceArray{Float32,arrdims,aspace},ROCDeviceArray{Float32,arrdims,aspace},ROCDeviceArray{Float32,arrdims,aspace}}; kernel=true)

    @roc groupsize=len gridsize=len vadd(d_a, d_b, d_c)
    @show d_a
    @show d_b
    @show d_c
    c = Array(d_c)
    @test a+b ≈ c
end
