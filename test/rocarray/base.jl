@testset "Base" begin

@testset "Specifying buffer type" begin
    B = AMDGPU.Runtime.Mem.HIPBuffer
    x = ROCArray{Float32, 2, B}(undef, 16, 12)
    @test size(x) == (16, 12)
    @test x.buf[] isa B
    x = ROCArray{Float32, 2, B}(undef, (16, 12))
    @test size(x) == (16, 12)
    @test x.buf[] isa B
end

@testset "ones/zeros" begin
    x = @inferred AMDGPU.ones(4, 3)
    @test x isa ROCArray
    x = @inferred AMDGPU.zeros(3, 4)
    @test x isa ROCArray
end

@testset "view" begin
    xs = copyto!(ROCVector{Int}(undef, 4), 1, collect(1:4), 1, 4)
    a = view(xs, 1:2)
    b = view(xs, 3:4)
    @test a isa ROCVector{Int}
    @test b isa ROCVector{Int}
    @test collect(a)::Vector{Int} == 1:2
    @test collect(b)::Vector{Int} == 3:4
    @allowscalar begin
        @test a[[1, 2]] == 1:2
        @test b[[1, 2]] == 3:4
    end

    b_cpu = Vector{Int}(undef, 2)
    @test copyto!(b_cpu, 1, b, 1, 2) === b_cpu
    @test b_cpu == 3:4

    c = ROCVector{Int}(undef, 2)
    @test copyto!(c, 1, b, 1, 2) === c
    @test collect(c) == 3:4
end

@testset "resize!" begin
    a_h = Array(range(1, 10))
    a_d = a_h |> roc
    # Resize up
    resize!(a_h, 15)
    resize!(a_d, 15)
    # Set the appended bytes to the same value on both host and device
    a_h[10:15] .= 15
    a_d[10:15] .= 15
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
    # Keep the size as is
    resize!(a_h, 15)
    resize!(a_d, 15)
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
    # Resize down
    resize!(a_h, 3)
    resize!(a_d, 3)
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
end

@testset "unsafe_wrap" begin
    @testset "Wrap host array" begin
        A = rand(4, 4)
        A_orig = copy(A)

        RA = Base.unsafe_wrap(ROCArray, pointer(A), size(A))
        @test AMDGPU.device(RA) == AMDGPU.device()
        @test RA isa ROCArray{Float64, 2}
        # pointer gives device mapped pointer, not host.
        @test pointer(RA) == RA.buf[].dev_ptr

        # ROCArray -> Array copy.
        B = zeros(4, 4)
        copyto!(B, RA)
        @test B ≈ Array(RA)

        # GPU pointer works.
        AMDGPU.@sync RA .+= 1.0

        # Host pointer is updated.
        @test A ≈ A_orig .+ 1.0

        # Base.show
        @test (println(devnull, RA); true)

        # ROCArray -> ROCArray copy.
        D = rand(4, 4)
        RD = Base.unsafe_wrap(ROCArray, pointer(D), size(D))
        copyto!(RD, RA)
        @test Array(RD) ≈ Array(RA)

        # Can use in HIP libraries.
        @test Array(RA * RA) ≈ Array(A * A)
    end

    @testset "Wrap device array" begin
        x = AMDGPU.rand(Float32, 4, 4)
        xhost = Array(x)
        xd = unsafe_wrap(ROCArray, pointer(x), size(x); lock=false)

        xd .+= 1f0
        @test Array(x) ≈ Array(xd) ≈ xhost .+ 1f0

        y = AMDGPU.zeros(Float32, 4, 4)
        copyto!(y, xd)
        @test Array(y) ≈ Array(xd)

        # Can use in HIP libraries.
        @test Array(xd * xd) ≈ Array(x * x)
    end

    @testset "Multiple wraps of the same array" begin
        x = zeros(Float32, 16)
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(x))) == false

        xd1 = unsafe_wrap(ROCArray, pointer(x), size(x))
        xd2 = unsafe_wrap(ROCArray, pointer(x), size(x))

        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd1))) == true
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == true

        AMDGPU.unsafe_free!(xd1)
        @test_throws ArgumentError pointer(xd1)
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == false

        AMDGPU.unsafe_free!(xd2)
        @test_throws ArgumentError pointer(xd2)
    end
end

@testset "unsafe_free" begin
    A = AMDGPU.ones(4, 3)
    AMDGPU.unsafe_free!(A)
    finalize(A)
end

@testset "accumulate" begin
    for n in (0, 1, 2, 3, 10, 10_000, 16384, 16384 + 1)
        x = rand(n)
        xd = ROCArray(x)
        init = rand()
        @test Array(accumulate(+, xd)) ≈ accumulate(+, x)
        @test Array(accumulate(+, xd; init)) ≈ accumulate(+, x; init)
    end

    # Multidimensional.
    for (sizes, dims) in (
        (2,) => 2,
        (3, 4, 5) => 2,
        (1, 70, 50, 20) => 3,
    )
        x = rand(Int, sizes)
        xd = ROCArray(x)
        @test Array(accumulate(+, xd; dims)) ≈ accumulate(+, x; dims)
        @test Array(accumulate(+, xd; dims)) ≈ accumulate(+, x; dims)
    end

    # In-place.
    x = rand(2)
    xd = ROCArray(x)
    accumulate!(+, x, copy(x))
    accumulate!(+, xd, copy(xd))
    @test Array(xd) ≈ x

    # Specialized.
    @test Array(cumsum(xd)) ≈ cumsum(x)
    @test Array(cumprod(xd)) ≈ cumprod(x)
end

@testset "Atomics" begin
    function ker_atomic_max!(target, source, indices)
        i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
        idx = indices[i]
        v = source[i]
        AMDGPU.@atomic max(target[idx], v)
        return
    end

    n, bins = 1024, 32
    source = rand(UInt32, n)
    indices = rand(1:bins, n)
    target = zeros(UInt32, bins)
    for i in 1:n
        idx = indices[i]
        target[idx] = max(target[idx], source[i])
    end

    dsource, dindices, dtarget = ROCArray.((source, indices, target))
    @roc groupsize=256 gridsize=4 ker_atomic_max!(dtarget, dsource, dindices)
    @test Array(dtarget) == target
end

include("sorting.jl")
include("reverse.jl")
include("indexing.jl")

if length(AMDGPU.devices()) > 1
    include("multi_gpu.jl")
else
    @test_skip "Multi-GPU"
end

end
