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

# TODO
#   need hipPtr to be able to recognize host pointers and register them.
# @testset "unsafe_wrap" begin
#     A = rand(4, 3)
#     A_orig = copy(A)
#     RA = Base.unsafe_wrap(ROCArray, pointer(A), size(A))
#     @test RA.buf.device == AMDGPU.default_device()
#     @test RA isa ROCArray{Float64,2}

#     # GPU pointer works
#     RA .+= 1.0

#     # Host pointer is updated
#     @test A ≈ A_orig .+ 1.0

#     # Base.show
#     @test (println(devnull, RA); true)

#     # Mem.download!
#     B = zeros(4, 3)
#     copyto!(B, RA)
#     @test B ≈ Array(RA)

#     # Mem.upload!
#     C = rand(4, 3)
#     copyto!(RA, C)
#     @test Array(RA) ≈ C

#     # Mem.transfer!
#     D = rand(4, 3)
#     D_orig = copy(D)
#     RD = Base.unsafe_wrap(ROCArray, pointer(D), size(D))
#     copyto!(RD, RA)
#     @test Array(RD) ≈ Array(RA) ≈ C
# end

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

end
