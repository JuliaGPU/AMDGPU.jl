using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray
using AMDGPU.rocSPARSE
using SparseArrays

@assert AMDGPU.functional(:rocsparse)

m, n = 2, 3
p = 0.5

for elty in [Int32, Int64, Float32, Float64]
    @testset "$typ($elty)" for typ in [ROCSparseMatrixCSR, ROCSparseMatrixCSC]
        x = sprand(elty, m, n, p)
        dx = typ(x)

        # zero-preserving
        y = x .* elty(1)
        dy = dx .* elty(1)
        @test dy isa typ{elty}
        @test y == SparseMatrixCSC(dy)

        # not zero-preserving
        y = x .+ elty(1)
        dy = dx .+ elty(1)
        @test dy isa ROCArray{elty}
        @test y == Array(dy)

        # involving something dense
        y = x .* ones(elty, m, n)
        dy = dx .* AMDGPU.ones(elty, m, n)
        @test dy isa ROCArray{elty}
        @test y == Array(dy)

        # multiple inputs
        y = sprand(elty, m, n, p)
        dy = typ(y)
        z = x .* y .* elty(2)
        dz = dx .* dy .* elty(2)
        @test dz isa typ{elty}
        @test z == SparseMatrixCSC(dz)
    end
end

@testset "bug: type conversions" begin
    x = ROCSparseMatrixCSR(sparse([1, 2], [2, 1], [5.0, 5.0]))
    y = Int.(x)
    @test eltype(y) == Int
end
