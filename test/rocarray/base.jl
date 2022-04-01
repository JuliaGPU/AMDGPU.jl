@testset "Base" begin

@testset "ones/zeros" begin
    @test AMDGPU.ones(4, 3) isa ROCArray
    @test AMDGPU.zeros(3, 4) isa ROCArray
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

@testset "unsafe_wrap" begin
    A = rand(4, 3)
    A_orig = copy(A)
    RA = Base.unsafe_wrap(ROCArray, pointer(A), size(A))
    @test RA.buf.agent == get_default_agent()
    @test RA isa ROCArray{Float64,2}

    # GPU pointer works
    RA .+= 1.0

    # Host pointer is updated
    @test A ≈ A_orig .+ 1.0

    # Base.show
    @test (println(devnull, RA); true)

    # Mem.download!
    B = zeros(4, 3)
    copyto!(B, RA)
    @test B ≈ Array(RA)

    # Mem.upload!
    C = rand(4, 3)
    copyto!(RA, C)
    @test Array(RA) ≈ C

    # Mem.transfer!
    D = rand(4, 3)
    D_orig = copy(D)
    RD = Base.unsafe_wrap(ROCArray, pointer(D), size(D))
    copyto!(RD, RA)
    @test Array(RD) ≈ Array(RA) ≈ C
end

end
