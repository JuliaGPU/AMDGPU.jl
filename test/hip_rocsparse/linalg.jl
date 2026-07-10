using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray
using AMDGPU.rocSPARSE
using SparseArrays
using LinearAlgebra
using Adapt

@assert AMDGPU.functional(:rocsparse)

@testset "opnorm" for T in (Float32, Float64, ComplexF32, ComplexF64)
    S = sprand(T, 10, 10, 0.1)
    dS_csc = ROCSparseMatrixCSC(S)
    dS_csr = ROCSparseMatrixCSR(S)
    @test opnorm(S, Inf) ≈ opnorm(dS_csc, Inf)
    @test opnorm(S, Inf) ≈ opnorm(dS_csr, Inf)
end

@testset "triu/tril ($typ)" for typ in (
    ROCSparseMatrixCOO, ROCSparseMatrixCSR, ROCSparseMatrixCSC,
)
    for T in (Float32, Float64, ComplexF32, ComplexF64)
        n = 10
        A = sprand(T, n, n, 0.5)
        dA = typ(A)

        for k in (-2, -1, 0, 1, 2)
            @test SparseMatrixCSC(typ(triu(dA, k))) ≈ triu(A, k)
            @test SparseMatrixCSC(typ(tril(dA, k))) ≈ tril(A, k)
        end
        # default k=0
        @test SparseMatrixCSC(typ(triu(dA))) ≈ triu(A)
        @test SparseMatrixCSC(typ(tril(dA))) ≈ tril(A)
    end
end

@testset "triu/tril with transpose/adjoint" begin
    for T in (Float32, ComplexF32)
        n = 8
        A  = sprand(T, n, n, 0.5)
        dA = ROCSparseMatrixCSR(A)
        for wrap in (transpose, adjoint)
            dAt = wrap(dA)
            At  = wrap(A)
            @test SparseMatrixCSC(ROCSparseMatrixCSC(triu(dAt))) ≈ triu(At)
            @test SparseMatrixCSC(ROCSparseMatrixCSC(tril(dAt))) ≈ tril(At)
        end
    end
end

@testset "kron (COO×COO)" begin
    for T in (Float32, Float64)
        A = sprand(T, 4, 5, 0.5)
        B = sprand(T, 3, 2, 0.5)
        dA = ROCSparseMatrixCOO(A)
        dB = ROCSparseMatrixCOO(B)
        @test SparseMatrixCSC(ROCSparseMatrixCSC(kron(dA, dB))) ≈ kron(A, B)
    end
end

@testset "kron (COO×Diagonal)" begin
    for T in (Float32, Float64)
        A = sprand(T, 4, 4, 0.5)
        D = Diagonal(rand(T, 3))
        dA = ROCSparseMatrixCOO(A)
        dD = adapt(ROCArray, D)
        @test SparseMatrixCSC(ROCSparseMatrixCSC(kron(dA, dD))) ≈ kron(A, D)
        @test SparseMatrixCSC(ROCSparseMatrixCSC(kron(dD, dA))) ≈ kron(D, A)
    end
end

@testset "kron (CSR/CSC via COO)" begin
    for T in (Float32,), typ in (ROCSparseMatrixCSR, ROCSparseMatrixCSC)
        A = sprand(T, 3, 3, 0.5)
        B = sprand(T, 2, 2, 0.5)
        dA = typ(A)
        dB = typ(B)
        @test SparseMatrixCSC(typ(kron(dA, dB))) ≈ kron(A, B)
    end
end
