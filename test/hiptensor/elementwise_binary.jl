using Test, AMDGPU
using AMDGPU
using LinearAlgebra
using AMDGPU.hipTENSOR: elementwise_binary_execute!, hipTensor

AMDGPU.hipTENSOR.hiptensorLoggerSetLevel(AMDGPU.hipTENSOR.hiptensorLogLevel_t(UInt32(16)))
AMDGPU.hipTENSOR.hiptensorLoggerOpenFile("tensor.log")

eltypes = [#(Float16, Float16),
           #(Float32, Float32),
           (Float64, Float64),
           #=(ComplexF32, ComplexF32),
           (ComplexF64, ComplexF64),
           (ComplexF64, ComplexF32),
           (Float32, Float16),
           (Float64, Float32),=#
           ]

Ns = 2:5

@testset "elementwise binary ($eltyA, $eltyC), N $N" for (eltyA, eltyC) in eltypes, N in Ns
    # setup
    eltyD = eltyC
    #dmax  = 2^div(18,N)
    #dims  = rand(2:dmax, N)
    dims  = fill(4, N)
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

    @testset "simple case" begin
        opA   = AMDGPU.hipTENSOR.OP_IDENTITY
        opC   = AMDGPU.hipTENSOR.OP_IDENTITY
        dD    = similar(dC, eltyD)
        opAC  = AMDGPU.hipTENSOR.OP_ADD
        dD    = elementwise_binary_execute!(one(eltyA), dA, indsA, opA, one(eltyC), dC, indsC, opC, dD, indsC, opAC)
        D     = collect(dD)
        @test D ≈ permutedims(A, p) + C
    end

    #=@testset "using integers as indices" begin
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
        @test D ≈ α * conj.(permutedims(A, p)) + γ * C
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
                @test D ≈ α * permutedims(A, p) + γ * conj.(C)
            else
                @test D ≈ α * sqrt.(eltyD.(permutedims(A, p))) + γ * conj.(C)
            end
        else
            @test D ≈ max.(α * sqrt.(eltyD.(permutedims(A, p))), γ * C)
        end
    end

    # using hipTensor type
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
    @test hD ≈ α * permutedims(A, p) + C

    γ = rand(eltyD)
    ctC_copy = copy(ctC)
    ctD = LinearAlgebra.axpby!(α, ctA, γ, ctC_copy)
    @test ctD == ctC_copy
    hD = collect(ctD.data)
    @test hD ≈ α * permutedims(A, p) + γ * C=#
end
