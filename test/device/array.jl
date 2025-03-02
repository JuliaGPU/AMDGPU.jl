@testset "ROCDeviceArray array interface" begin
    x = ROCArray(zeros(Int, 1, 2, 3, 4))
    xd = rocconvert(x)

    @test typeof(xd) <: DenseArray
    @test hasproperty(xd, :dims)

    @test size(xd) == size(x)
    @test length(xd) == length(x)
    @test strides(xd) == strides(x)
    @test Base.elsize(xd) == Base.elsize(x)
    @test sizeof(xd) == sizeof(x)

    @test Int(pointer(xd)) == Int(pointer(x))
end

@testset "ROCDeviceArray" begin
    RA = ROCArray(rand(4,4))
    RD = rocconvert(RA)
    @test RD isa AMDGPU.Device.ROCDeviceMatrix

    # Host indexing is disallowed
    @test_throws Exception RD[1]
    @test_throws Exception RD[1,1]

    RD_view = @view RD[2:3, 2:3]
    @test RD_view isa SubArray
    @test_throws Exception RD_view[1]
    @test_throws Exception RD_view[1,1]

    RD_adj = RD'
    @test RD_adj isa LinearAlgebra.Adjoint
    @test_throws Exception RD_adj[1]
    @test_throws Exception RD_adj[1,1]

    # Custom show methods are defined
    @test occursin("4×4 device array at", sprint(io -> show(io, RD)))
    @test occursin("2×2 device array view", sprint(io -> show(io, RD_view)))

    adj_repr = sprint(io -> show(io, RD_adj))
    o1 = occursin("4×4 device array wrapper LinearAlgebra.Adjoint", adj_repr)
    # If we are running with `0` workers, LinearAlgebra is already
    # imported in the global scope.
    o2 = occursin("4×4 device array wrapper Adjoint", adj_repr)
    @test o1 || o2
end

@testset "reshape" begin
    function kernel(array)
        i = (workgroupIdx().x-1) * workgroupDim().x + workitemIdx().x
        j = (workgroupIdx().y-1) * workgroupDim().y + workitemIdx().y

        _array2d = reshape(array, 10, 10)
        _array2d[i,j] = i + (j-1)*size(_array2d,1)

        return
    end

    array = zeros(Int64, 100)
    array_dev = ROCArray(array)

    array2d = reshape(array, 10, 10)
    for i in 1:size(array2d,1), j in 1:size(array2d,2)
        array2d[i,j] = i + (j-1)*size(array2d,1)
    end

    @roc groupsize=(10, 10) kernel(array_dev)
    @test array == Array(array_dev)
end

@testset "reshape view" begin
    function kernel!(A)
        i = workitemIdx().x
        B = reshape(view(A, :, i), (size(A, 1),))
        @inbounds B[1] = 9.0
        return
    end

    A = ROCArray{Float64}(undef, 1, 4)
    @roc groupsize=4 kernel!(A)
    @test all(Array(A) .≈ 9.0)
end
