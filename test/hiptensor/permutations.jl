using Test, AMDGPU
using LinearAlgebra, Random

if AMDGPU.hipTENSOR.has_hiptensor()

    @testset "permutations" begin

    using AMDGPU.hipTENSOR: permute!

    AMDGPU.hipTENSOR.hiptensorLoggerSetLevel(AMDGPU.hipTENSOR.hiptensorLogLevel_t(UInt32(16)))
    AMDGPU.hipTENSOR.hiptensorLoggerOpenFile("tensor.log")

    eltypes = [(Float16, Float16),
               #=(Float16, Float32),
               (Float32, Float16),
               (Float32, Float32),
               (Float64, Float64),
               (Float32, Float64),
               (Float64, Float32),
               (ComplexF32, ComplexF32),
               (ComplexF64, ComplexF64),
               (ComplexF32, ComplexF64),
               (ComplexF64, ComplexF32)=#
               ]

    @testset for N=2#:5
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

            # simple case
            opA = AMDGPU.hipTENSOR.OP_IDENTITY
            dC = permute!(one(eltyA), dA, indsA, opA, dC, indsC)
            C  = collect(dC)
            @test C == permutedims(A, p) # exact equality

            # with scalar
            α  = rand(eltyA)
            dC = permute!(α, dA, indsA, opA, dC, indsC)
            C  = collect(dC)
            @test C ≈ α * permutedims(A, p) # approximate, floating point rounding
        end
    end

    end
end
