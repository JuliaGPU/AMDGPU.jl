@testset "generic mv!" for T in (Float32, Float64, ComplexF32, ComplexF64)
    A = sprand(T, 10, 10, 0.1)
    x = rand(T, 10)
    dx = adapt(ROCArray, x)

    dA = adapt(ROCArray, A)
    dy = ROCArray(zeros(T, 10))
    mv!('N', T(1.0), dA, dx, T(0.0), dy, 'O')
    @test Array(dy) ≈ A * x

    dA = ROCSparseMatrixCSR(dA)
    dy = ROCArray(zeros(T, 10))
    mv!('N', T(1.0), dA, dx, T(0.0), dy, 'O')
    @test Array(dy) ≈ A * x
end

@testset "mm algo=$algo" for algo in (
    rocSPARSE.rocsparse_spmm_alg_default,
    rocSPARSE.rocsparse_spmm_alg_csr,
    rocSPARSE.rocsparse_spmm_alg_csr_merge,
    rocSPARSE.rocsparse_spmm_alg_csr_row_split,
)
    @testset "mm $T" for T in (Float32, Float64, ComplexF32, ComplexF64)
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

for SparseMatrixType in (ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO)

    @testset "$SparseMatrixType -- mv! algo=$algo" for algo in (rocSPARSE.rocsparse_spmv_alg_default,)
        @testset "mv! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
                SparseMatrixType == ROCSparseMatrixCSC && T <: Complex && transa == 'C' && continue
                A = sprand(T, 20, 10, 0.1)
                B = transa == 'N' ? rand(T, 10) : rand(T, 20)
                C = transa == 'N' ? rand(T, 20) : rand(T, 10)
                dA = SparseMatrixType(A)
                dB = ROCArray(B)
                dC = ROCArray(C)

                alpha = rand(T)
                beta = rand(T)
                mv!(transa, alpha, dA, dB, beta, dC, 'O', algo)
                @test alpha * opa(A) * B + beta * C ≈ collect(dC)
            end
        end
    end

    @testset "$SparseMatrixType -- mm! algo=$algo" for algo in (rocSPARSE.rocsparse_spmm_alg_default,)
        @testset "mm! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
                for (transb, opb) in [('N', identity), ('T', transpose), ('C', adjoint)]
                    SparseMatrixType == ROCSparseMatrixCSC && T <: Complex && transa == 'C' && continue
                    SparseMatrixType == ROCSparseMatrixCOO && transa != 'N' && continue
                    A = sprand(T, 10, 10, 0.1)
                    B = transb == 'N' ? rand(T, 10, 2) : rand(T, 2, 10)
                    C = rand(T, 10, 2)
                    dA = SparseMatrixType(A)
                    dB, dC = ROCArray(B), ROCArray(C)

                    alpha, beta = rand(T), rand(T)
                    mm!(transa, transb, alpha, dA, dB, beta, dC, 'O', algo)
                    @test alpha * opa(A) * opb(B) + beta * C ≈ collect(dC)
                end
            end
        end
    end
end
