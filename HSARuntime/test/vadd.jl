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

    wait(@roc groupsize=len gridsize=len vadd(d_a, d_b, d_c))
    c = Array(d_c)
    @test a+b ≈ c
end
