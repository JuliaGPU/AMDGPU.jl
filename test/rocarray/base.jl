@testset "Base" begin

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
        @test RA.buf.device == AMDGPU.device()
        @test AMDGPU.device(RA)  == AMDGPU.device()
        @test RA isa ROCArray{Float64, 2}
        # pointer gives device mapped pointer, not host.
        @test pointer(RA) == RA.buf.dev_ptr

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

        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd1))) == false
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == false

        AMDGPU.unsafe_free!(xd2)

        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd1))) == false
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == false
    end
end

@testset "unsafe_free" begin
    A = AMDGPU.ones(4, 3)
    AMDGPU.unsafe_free!(A)
    finalize(A)
end

@testset "Refcounting" begin
    refcount_live(A) = (get(AMDGPU.Mem.refcounts, A.buf._id, 0),
                        get(AMDGPU.Mem.liveness, A.buf._id, false))

    for (f, switch) in [(A->view(A, 2:4), false),
                        (A->resize!(A, 8), true),
                        (A->reinterpret(UInt8, A), false),
                        (A->reshape(A, 4, 4), false)]

        # Safe free
        A = AMDGPU.ones(16)
        @test refcount_live(A) == (1, true)
        B = f(A)
        @test A.buf.ptr == B.buf.ptr
        @test refcount_live(A) == refcount_live(B)
        @test refcount_live(B) == (2-switch, true)
        finalize(B)
        @test refcount_live(B) == (1-switch, !switch)
        finalize(A)
        @test refcount_live(B) == (0, false)

        # Unsafe free original
        A = AMDGPU.ones(16)
        B = f(A)
        AMDGPU.unsafe_free!(A)
        @test refcount_live(B) == (2-switch, false)
        finalize(B)
        @test refcount_live(B) == (1-switch, false)
        finalize(A)
        @test refcount_live(B) == (0, false)

        # Unsafe free derived
        A = AMDGPU.ones(16)
        B = f(A)
        AMDGPU.unsafe_free!(B)
        @test refcount_live(B) == (2-switch, false)
        finalize(A)
        @test refcount_live(B) == (1-switch, false)
        finalize(B)
        @test refcount_live(B) == (0, false)

        # Unsafe free original and derived
        A = AMDGPU.ones(16)
        B = f(A)
        AMDGPU.unsafe_free!(A)
        AMDGPU.unsafe_free!(B)
        @test refcount_live(B) == (2-switch, false)
        finalize(A)
        @test refcount_live(B) == (1-switch, false)
        finalize(B)
        @test refcount_live(B) == (0, false)
    end

    # Chained Safe free
    A = AMDGPU.ones(16)
    @test refcount_live(A) == (1, true)
    B = reshape(A, 4, 4)
    @test refcount_live(A) == (2, true)
    C = reshape(B, 2, 8)
    @test refcount_live(A) == (3, true)
    finalize(B)
    @test refcount_live(A) == (2, true)
    finalize(A)
    @test refcount_live(A) == (1, true)
    finalize(C)
    @test refcount_live(A) == (0, false)

    # Chained Unsafe free
    A = AMDGPU.ones(16)
    @test refcount_live(A) == (1, true)
    B = reshape(A, 4, 4)
    @test refcount_live(A) == (2, true)
    C = reshape(B, 2, 8)
    @test refcount_live(A) == (3, true)
    AMDGPU.unsafe_free!(A)
    @test refcount_live(A) == (3, false)
    finalize(B)
    @test refcount_live(A) == (2, false)
    finalize(A)
    @test refcount_live(A) == (1, false)
    finalize(C)
    @test refcount_live(A) == (0, false)
end

@testset "unsafe_copy3d!" begin
    @testset "Full copy" begin
        T = Int32
        src = ROCArray(ones(T, 4, 4, 4))
        dst = ROCArray(zeros(T, 4, 4, 4))
        Mem.unsafe_copy3d!(
            pointer(dst), typeof(dst.buf),
            pointer(src), typeof(src.buf),
            length(src))
        @test Array(src) == Array(dst)
    end

    @testset "3D Copy middle part of y-z planes, each dimension is different in size" begin
        nx, ny, nz = 4, 6, 8
        src = ROCArray(collect(reshape(1:(nx * ny * nz), nx, ny, nz)))
        dst = ROCArray(zeros(Int, nx, ny, nz))
        Mem.unsafe_copy3d!(
            pointer(dst), typeof(dst.buf),
            pointer(src), typeof(src.buf),
            1, 4, 4;
            dstPos=(1, 2, 3), srcPos=(1, 2, 3),
            dstPitch=nx * sizeof(Int), dstHeight=ny,
            srcPitch=nx * sizeof(Int), srcHeight=ny)
        @test Array(src)[1, 2:5, 3:6] == Array(dst)[1, 2:5, 3:6]
    end

    @testset "3D Copy middle part of x-y-z planes, each dimension is different in size" begin
        nx, ny, nz = 4, 6, 8
        src = ROCArray(collect(reshape(1:(nx * ny * nz), nx, ny, nz)))
        dst = ROCArray(zeros(Int, nx, ny, nz))
        Mem.unsafe_copy3d!(
            pointer(dst), typeof(dst.buf),
            pointer(src), typeof(src.buf),
            2, 4, 4;
            dstPos=(2, 2, 3), srcPos=(2, 2, 3),
            dstPitch=nx * sizeof(Int), dstHeight=ny,
            srcPitch=nx * sizeof(Int), srcHeight=ny)
        @test Array(src)[2:3, 2:5, 3:6] == Array(dst)[2:3, 2:5, 3:6]
    end

    @testset "3D -> 2D -> 3D copy" begin
        nx, ny, nz = 2, 3, 4
        T = Int
        P = ROCArray(reshape(1:(2 * 3 * 4), nx, ny, nz))

        for dim in 1:3
            if dim == 1
                ranges = [2:2, 1:size(P,2), 1:size(P,3)]
                buf = zeros(T, size(P,2), size(P,3))
                buf_view_shape = (1, size(P,2), size(P,3))
            elseif dim == 2
                ranges = [1:size(P,1), 3:3, 1:size(P,3)]
                buf = zeros(T, size(P,1), size(P,3))
                buf_view_shape = (size(P,1), 1, size(P,3))
            elseif dim == 3
                ranges = [1:size(P,1), 1:size(P,2), 3:3]
                buf = zeros(T, size(P,1), size(P,2))
                buf_view_shape = (size(P,1), size(P,2), 1)
            end

            # Reshape 2D to 3D for simplicity.
            buf_view = reshape(buf, buf_view_shape)

            AMDGPU.Mem.unsafe_copy3d!(
                pointer(buf), AMDGPU.Mem.HostBuffer,
                pointer(P), typeof(P.buf),
                length(ranges[1]), length(ranges[2]), length(ranges[3]);
                srcPos=(ranges[1][1], ranges[2][1], ranges[3][1]),
                dstPitch=sizeof(T) * size(buf_view, 1), dstHeight=size(buf_view, 2),
                srcPitch=sizeof(T) * size(P, 1), srcHeight=size(P, 2))

            if dim == 1
                @assert buf == Array(P)[2, :, :]
            elseif dim == 2
                @assert buf == Array(P)[:, 3, :]
            elseif dim == 3
                @assert buf == Array(P)[:, :, 3]
            end

            # host to device
            P2 = similar(P)

            AMDGPU.Mem.unsafe_copy3d!(
                pointer(P2), typeof(P2.buf),
                pointer(buf), AMDGPU.Mem.HostBuffer,
                length(ranges[1]), length(ranges[2]), length(ranges[3]);
                dstPos=(ranges[1][1], ranges[2][1], ranges[3][1]),
                dstPitch=sizeof(T) * size(P2,1), dstHeight=size(P2, 2),
                srcPitch=sizeof(T) * size(buf_view, 1), srcHeight=size(buf_view, 2))

            if dim == 1
                @assert Array(P2)[2, :, :] == Array(P)[2, :, :]
            elseif dim == 2
                @assert Array(P2)[:, 3, :] == Array(P)[:, 3, :]
            elseif dim == 3
                @assert Array(P2)[:, :, 3] == Array(P)[:, :, 3]
            end
        end
    end
end

end
