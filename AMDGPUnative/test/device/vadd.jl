# The original test :)
@testset "Vector Addition Kernel" begin
    function vadd(a,b,c)
        i = workitemIdx().x
        c[i] = a[i] + b[i]
        sync_workgroup()
        return nothing
    end

    dims = (8,)
    a = round.(rand(Float32, dims) * 100)
    b = round.(rand(Float32, dims) * 100)

    d_a = HSAArray(a)
    d_b = HSAArray(b)
    d_c = similar(d_a)
    len = prod(dims)

    @debug begin
        @show d_a.handle
        @show d_b.handle
        @show d_c.handle

        aspace = AMDGPUnative.AS.Global
        arrdims = ndims(a)
        arrT = ROCDeviceArray{Float32,arrdims,aspace}
        @debug "LLVM IR"
        AMDGPUnative.code_llvm(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
        @debug "GCN Device Code"
        AMDGPUnative.code_gcn(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
        ""
    end

    wait(@roc groupsize=len vadd(d_a, d_b, d_c))
    @debug begin
        @show d_a
        @show d_b
        @show d_c
        ""
    end
    c = Array(d_c)
    @test a+b ≈ c
end
