using Test, AMDGPU
using AMDGPU
using LinearAlgebra
using AMDGPU.hipTENSOR: elementwise_binary_execute!, hipTensor

if AMDGPU.hipTENSOR.has_hiptensor()

    @testset "elementwise binary" begin

    # hipTENSOR 2.2 only implements the elementwise operations for uniformly typed real
    # operands, see `AMDGPU.hipTENSOR.elementwise_binary_compute_types`
    eltypes = [(Float16, Float16),
               (Float32, Float32),
               (Float64, Float64),
               ]

    Ns = 2:5

    @testset "($eltyA, $eltyC), N $N" for (eltyA, eltyC) in eltypes, N in Ns
        # setup
        eltyD = eltyC
        dmax  = 2^div(18,N)
        dims  = rand(2:dmax, N)
        p     = randperm(N)
        indsA = collect(('a':'z')[1:N])
        indsC = indsA[p]
        dimsA = dims
        dimsC = dims[p]
        A     = rand(eltyA, dimsA...)
        dA    = ROCArray(A)
        C     = rand(eltyC, dimsC...)
        dC    = ROCArray(C)
        AMDGPU.synchronize()

        # hipTENSOR 2.2 rounds the α/γ scalars of the elementwise operations to single
        # precision even when the compute descriptor is a double precision one, so results
        # involving them are only accurate to about `eps(Float32)`
        rtol = eltyD == Float64 ? 1e-6 : Base.rtoldefault(eltyD)

        @testset "simple case" begin
            opA   = AMDGPU.hipTENSOR.OP_IDENTITY
            opC   = AMDGPU.hipTENSOR.OP_IDENTITY
            dD    = similar(dC, eltyD)
            opAC  = AMDGPU.hipTENSOR.OP_ADD
            dD    = elementwise_binary_execute!(one(eltyA), dA, indsA, opA, one(eltyC), dC, indsC, opC, dD, indsC, opAC)
            D     = collect(dD)
            @test D ≈ permutedims(A, p) + C
        end

        @testset "using integers as indices" begin
            opA   = AMDGPU.hipTENSOR.OP_IDENTITY
            opC   = AMDGPU.hipTENSOR.OP_IDENTITY
            dD    = similar(dC, eltyD)
            opAC  = AMDGPU.hipTENSOR.OP_ADD
            dD    = elementwise_binary_execute!(1, dA, 1:N, opA, 1, dC, p, opC, dD, p, opAC)
            D     = collect(dD)
            @test D ≈ permutedims(A, p) + C
        end

        @testset "multiplication as binary operator" begin
            opA   = AMDGPU.hipTENSOR.OP_IDENTITY
            opC   = AMDGPU.hipTENSOR.OP_IDENTITY
            dD    = similar(dC, eltyD)
            opAC  = AMDGPU.hipTENSOR.OP_MUL
            dD    = elementwise_binary_execute!(1, dA, indsA, opA, 1, dC, indsC, opC, dD, indsC, opAC)
            D     = collect(dD)
            @test D ≈ permutedims(A, p) .* C
        end

        @testset "with non-trivial coefficients and conjugation" begin
            dD   = similar(dC, eltyD)
            opA  = eltyA <: Complex ? AMDGPU.hipTENSOR.OP_CONJ : AMDGPU.hipTENSOR.OP_IDENTITY
            opC  = AMDGPU.hipTENSOR.OP_IDENTITY
            opAC = AMDGPU.hipTENSOR.OP_ADD
            α    = rand(eltyD)
            γ    = rand(eltyD)
            dD   = elementwise_binary_execute!(α, dA, indsA, opA, γ, dC, indsC, opC, dD, indsC, opAC)
            D    = collect(dD)
            @test D ≈ α * conj.(permutedims(A, p)) + γ * C rtol=rtol
        end

        @testset "test in-place, and more complicated unary and binary operations" begin
            opA = eltyA <: Complex ? AMDGPU.hipTENSOR.OP_IDENTITY : AMDGPU.hipTENSOR.OP_SQRT
            # because we use rand, entries of A will be positive when elty is real
            opC = eltyC <: Complex ? AMDGPU.hipTENSOR.OP_CONJ : AMDGPU.hipTENSOR.OP_IDENTITY
            opAC = eltyD <: Complex ? AMDGPU.hipTENSOR.OP_ADD : AMDGPU.hipTENSOR.OP_MAX
            α = rand(eltyD)
            γ = rand(eltyD)
            dD = elementwise_binary_execute!(α, dA, indsA, opA, γ, dC, indsC, opC, dC, indsC, opAC)
            D = collect(dC)
            if eltyD <: Complex
                if eltyA <: Complex
                    @test D ≈ α * permutedims(A, p) + γ * conj.(C) rtol=rtol
                else
                    @test D ≈ α * sqrt.(eltyD.(permutedims(A, p))) + γ * conj.(C) rtol=rtol
                end
            else
                @test D ≈ max.(α * sqrt.(eltyD.(permutedims(A, p))), γ * C) rtol=rtol
            end
        end

        @testset "using hipTensor objects" begin
            dA = ROCArray(A)
            dC = ROCArray(C)
            ctA = hipTensor(dA, indsA)
            ctC = hipTensor(dC, indsC)
            ctD = ctA + ctC
            hD = collect(ctD.data)
            @test hD ≈ permutedims(A, p) + C
            ctD = ctA - ctC
            hD = collect(ctD.data)
            @test hD ≈ permutedims(A, p) - C

            α = rand(eltyD)
            ctC_copy = copy(ctC)
            ctD = LinearAlgebra.axpy!(α, ctA, ctC_copy)
            @test ctD == ctC_copy
            hD = collect(ctD.data)
            @test hD ≈ α * permutedims(A, p) + C rtol=rtol

            γ = rand(eltyD)
            ctC_copy = copy(ctC)
            ctD = LinearAlgebra.axpby!(α, ctA, γ, ctC_copy)
            @test ctD == ctC_copy
            hD = collect(ctD.data)
            @test hD ≈ α * permutedims(A, p) + γ * C rtol=rtol
        end
    end

    end
end
