using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray
using AMDGPU.rocSPARSE
using SparseArrays
using LinearAlgebra

@assert AMDGPU.functional(:rocsparse)

@testset "opnorm" for T in (Float32, Float64, ComplexF32, ComplexF64)
    S = sprand(T, 10, 10, 0.1)
    dS_csc = ROCSparseMatrixCSC(S)
    dS_csr = ROCSparseMatrixCSR(S)
    @test opnorm(S, Inf) ≈ opnorm(dS_csc, Inf)
    @test opnorm(S, Inf) ≈ opnorm(dS_csr, Inf)
end
