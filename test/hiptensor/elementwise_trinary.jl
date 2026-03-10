using Test, AMDGPU
using LinearAlgebra

if AMDGPU.hipTENSOR.has_hiptensor()
    @testset "elementwise trinary" begin

    using AMDGPU.hipTENSOR: elementwise_trinary_execute!

    eltypes = [(Float16, Float16, Float16),
               (Float32, Float32, Float32),
               (Float64, Float64, Float64),
               (ComplexF32, ComplexF32, ComplexF32),
               (ComplexF64, ComplexF64, ComplexF64),
               (Float32, Float32, Float16),
               #(Float64, Float64, Float32),
               (ComplexF64, ComplexF64, ComplexF32)]

    @testset for N=2:5
        @testset for (eltyA, eltyB, eltyC) in eltypes
            @show eltyA, eltyB, eltyC, N
            flush(stdout)
            # setup
            eltyD = eltyC
            dmax = 2^div(18,N)
            dims = rand(2:dmax, N)
            pA = randperm(N)
            ipA = invperm(pA)
            pB = randperm(N)
            ipB = invperm(pB)
            indsC = collect(('a':'z')[1:N])
            dimsC = dims
            indsA = indsC[ipA]
            dimsA = dims[ipA]
            indsB = indsC[ipB]
            dimsB = dims[ipB]
            A = rand(eltyA, dimsA...)
            dA = ROCArray(A)
            B = rand(eltyB, dimsB...)
            dB = ROCArray(B)
            C = rand(eltyC, dimsC...)
            dC = ROCArray(C)
            dD = similar(dC)

            # simple case
            opA = AMDGPU.hipTENSOR.OP_IDENTITY
            opB = AMDGPU.hipTENSOR.OP_IDENTITY
            opC = AMDGPU.hipTENSOR.OP_IDENTITY
            opAB = AMDGPU.hipTENSOR.OP_ADD
            opABC = AMDGPU.hipTENSOR.OP_ADD
            dD = elementwise_trinary_execute!(1, dA, indsA, opA, 1, dB, indsB, opB,
                                              1, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ permutedims(A, pA) + permutedims(B, pB) + C

            # using integers as indices
            dD = elementwise_trinary_execute!(1, dA, ipA, opA, 1, dB, ipB, opB,
                                              1, dC, 1:N, opC, dD, 1:N, opAB, opABC)
            D = collect(dD)
            @test D ≈ permutedims(A, pA) + permutedims(B, pB) + C

            # multiplication as binary operator
            opAB = AMDGPU.hipTENSOR.OP_MUL
            opABC = AMDGPU.hipTENSOR.OP_ADD
            dD = elementwise_trinary_execute!(1, dA, indsA, opA, 1, dB, indsB, opB,
                                              1, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ (eltyD.(permutedims(A, pA)) .* eltyD.(permutedims(B, pB))) + C

            opAB = AMDGPU.hipTENSOR.OP_ADD
            opABC = AMDGPU.hipTENSOR.OP_MUL
            dD = elementwise_trinary_execute!(1, dA, indsA, opA, 1, dB, indsB, opB,
                                              1, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ (eltyD.(permutedims(A, pA)) + eltyD.(permutedims(B, pB))) .* C

            opAB = AMDGPU.hipTENSOR.OP_MUL
            opABC = AMDGPU.hipTENSOR.OP_MUL
            dD = elementwise_trinary_execute!(1, dA, indsA, opA, 1, dB, indsB, opB,
                                              1, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ eltyD.(permutedims(A, pA)) .* eltyD.(permutedims(B, pB)) .* C

            # with non-trivial coefficients and conjugation
            α = rand(eltyD)
            β = rand(eltyD)
            γ = rand(eltyD)
            opA = eltyA <: Complex ? AMDGPU.hipTENSOR.OP_CONJ :
                                    AMDGPU.hipTENSOR.OP_IDENTITY
            opAB = AMDGPU.hipTENSOR.OP_ADD
            opABC = AMDGPU.hipTENSOR.OP_ADD
            dD = elementwise_trinary_execute!(α, dA, indsA, opA, β, dB, indsB, opB,
                                              γ, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ α * conj.(permutedims(A, pA)) + β * permutedims(B, pB) + γ * C

            opB = eltyB <: Complex ? AMDGPU.hipTENSOR.OP_CONJ : AMDGPU.hipTENSOR.OP_IDENTITY
            opAB = AMDGPU.hipTENSOR.OP_ADD
            opABC = AMDGPU.hipTENSOR.OP_ADD
            dD = elementwise_trinary_execute!(α, dA, indsA, opA, β, dB, indsB, opB,
                                              γ, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ α * conj.(permutedims(A, pA)) + β * conj.(permutedims(B, pB)) + γ * C
            opA = AMDGPU.hipTENSOR.OP_IDENTITY
            opAB = AMDGPU.hipTENSOR.OP_MUL
            opABC = AMDGPU.hipTENSOR.OP_ADD
            dD = elementwise_trinary_execute!(α, dA, indsA, opA, β, dB, indsB, opB,
                                              γ, dC, indsC, opC, dD, indsC, opAB, opABC)
            D = collect(dD)
            @test D ≈ (α * permutedims(A, pA)) .* (β * conj.(permutedims(B, pB))) + γ * C

            # test in-place, and more complicated unary and binary operations
            opA = eltyA <: Complex ? AMDGPU.hipTENSOR.OP_IDENTITY : AMDGPU.hipTENSOR.OP_SQRT
            opB = eltyB <: Complex ? AMDGPU.hipTENSOR.OP_IDENTITY : AMDGPU.hipTENSOR.OP_SQRT
            # because we use rand, entries of A will be positive when elty is real
            opC = eltyC <: Complex ? AMDGPU.hipTENSOR.OP_CONJ : AMDGPU.hipTENSOR.OP_IDENTITY
            opAB = eltyD <: Complex ? AMDGPU.hipTENSOR.OP_MUL : AMDGPU.hipTENSOR.OP_MIN
            opABC = eltyD <: Complex ? AMDGPU.hipTENSOR.OP_ADD : AMDGPU.hipTENSOR.OP_MAX
            α = rand(eltyD)
            β = rand(eltyD)
            γ = rand(eltyD)
            dD = elementwise_trinary_execute!(α, dA, indsA, opA, β, dB, indsB, opB,
                                              γ, dC, indsC, opC, dC, indsC, opAB, opABC)
            D = collect(dD)
            if eltyD <: Complex
                if eltyA <: Complex && eltyB <: Complex
                    @test D ≈ (α * permutedims(A, pA)) .*
                              (β * permutedims(B, pB)) + γ * conj.(C)
                elseif eltyB <: Complex
                    @test D ≈ (α * sqrt.(eltyD.(permutedims(A, pA)))) .*
                              (β * permutedims(B, pB)) + γ * conj.(C)
                elseif eltyB <: Complex
                    @test D ≈ (α * permutedims(A, pA)) .*
                              (β * sqrt.(eltyD.(permutedims(B, pB)))) + γ * conj.(C)
                else
                    @test D ≈ (α * sqrt.(eltyD.(permutedims(A, pA)))) .*
                              (β * sqrt.(eltyD.(permutedims(B, pB)))) + γ * conj.(C)
                end
            else
                @test D ≈ max.(min.(α * sqrt.(eltyD.(permutedims(A, pA))),
                                    β * sqrt.(eltyD.(permutedims(B, pB)))),
                                γ * C)
            end
        end
    end

    end
end
