using AMDGPU
using Adapt
using AMDGPU.rocSparse
using SparseArrays


@testset "generic mv!" for T in [Float32, Float64, ComplexF32, ComplexF64]
    A = sprand(T, 10, 10, 0.1)
    x = rand(T, 10)
    y = similar(x)
    dx = adapt(ROCArray, x)
    dy = adapt(ROCArray, y)

    dA = adapt(ROCArray, A)
    mv!('N', T(1.0), dA, dx, T(0.0), dy, 'O')
    @test Array(dy) ≈ A * x

    dA = ROCSparseMatrixCSR(dA)
    mv!('N', T(1.0), dA, dx, T(0.0), dy, 'O')
    @test Array(dy) ≈ A * x
end

@testset "mm algo=$algo" for algo in [
    rocSparse.rocsparse_spmm_alg_default,
    rocSparse.rocsparse_spmm_alg_csr,
    rocSparse.rocsparse_spmm_alg_csr_merge,
    rocSparse.rocsparse_spmm_alg_csr_row_split,
]
    @testset "mm $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
        A = sprand(T, 10, 10, 0.1)
        B = rand(T, 10, 2)
        C = rand(T, 10, 2)
        dA = ROCSparseMatrixCSR(A)
        dB = ROCArray(B)
        dC = ROCArray(C)

        alpha = 1.2
        beta = 1.3
        mm!('N', 'N', alpha, dA, dB, beta, dC, 'O', algo)
        @test alpha * A * B + beta * C ≈ collect(dC)
    end
end

@testset "mv algo=$algo" for algo in [
    rocSparse.rocsparse_spmv_alg_default,
    rocSparse.rocsparse_spmv_alg_coo,
    rocSparse.rocsparse_spmv_alg_ell,
]
    @testset "mv $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
        A = sprand(T, 10, 10, 0.1)
        B = rand(T, 10)
        C = rand(T, 10)
        dA = ROCSparseMatrixCSR(A)
        dB = ROCArray(B)
        dC = ROCArray(C)

        alpha = 1.2
        beta = 1.3
        mv!('N', alpha, dA, dB, beta, dC, 'O', algo)
        @test alpha * A * B + beta * C ≈ collect(dC)
    end
end
