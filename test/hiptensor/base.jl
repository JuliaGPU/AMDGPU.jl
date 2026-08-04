@testset "base" begin

using LinearAlgebra, Random, AMDGPU

if AMDGPU.hipTENSOR.has_hiptensor()
    @test AMDGPU.hipTENSOR.version() isa VersionNumber

    @testset "type basics" begin
        N = 2
        dmax = 2^div(18,N)
        dims = rand(2:dmax, N)
        p = randperm(N)
        indsA = collect(('a':'z')[1:N])
        dimsA = dims
        A = rand(Float64, dimsA...)
        dA = ROCArray(A)
        p = randperm(N)
        indsA = collect(('a':'z')[1:N])
        ctA = AMDGPU.hipTENSOR.hipTensor(dA, indsA)
        @test length(ctA) == length(A)
        @test size(ctA) == size(A)
        @test size(ctA, 1) == size(A, 1)
        @test ndims(ctA) == ndims(A)
        @test strides(ctA) == strides(A)
        @test eltype(ctA) == eltype(A)
    end
end

end
