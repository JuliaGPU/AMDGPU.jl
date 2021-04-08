@testset "Base" begin

@testset "view" begin
    xs = copy!(ROCVector{Int}(undef, 4), 1:4)
    a = view(xs, 1:2)
    b = view(xs, 3:4)
    @test a isa ROCVector{Int}
    @test b isa ROCVector{Int}
    @test collect(a)::Vector{Int} == 1:2
    @test collect(b)::Vector{Int} == 3:4
    @test a[[1, 2]] == 1:2
    @test b[[1, 2]] == 3:4
end

end
