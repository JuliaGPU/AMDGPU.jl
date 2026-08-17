using Test, AMDGPU
using LinearAlgebra, Random

if AMDGPU.hipTENSOR.has_hiptensor()

    @testset "permutations" begin

    using AMDGPU.hipTENSOR: permute!

    # hipTENSOR 2.2 only implements permutations between tensors of the same real element
    # type, see `AMDGPU.hipTENSOR.permutation_compute_types`
    eltypes = [(Float16, Float16),
               (Float32, Float32),
               ]

    @testset for N=2:5
        @testset for (eltyA, eltyC) in eltypes
            # setup
            dmax = 2^div(18,N)
            dims = rand(2:dmax, N)
            p = randperm(N)
            indsA = collect(('a':'z')[1:N])
            indsC = indsA[p]
            dimsA = dims
            dimsC = dims[p]
            A = rand(eltyA, dimsA...)
            dA = ROCArray(A)
            dC = similar(dA, eltyC, dimsC...)
            opA = AMDGPU.hipTENSOR.OP_IDENTITY

            @testset "simple case" begin
                dC = permute!(one(eltyA), dA, indsA, opA, dC, indsC)
                C  = collect(dC)
                @test C == permutedims(A, p) # exact equality
            end

            @testset "using integers as indices" begin
                dC = permute!(one(eltyA), dA, 1:N, opA, dC, p)
                C  = collect(dC)
                @test C == permutedims(A, p) # exact equality
            end

            @testset "with scalar" begin
                α  = rand(eltyA)
                dC = permute!(α, dA, indsA, opA, dC, indsC)
                C  = collect(dC)
                @test C ≈ α * permutedims(A, p) # approximate, floating point rounding
            end
        end
    end

    end
end
