fmt = Dict(ROCSparseMatrixCSC => :csc,
           ROCSparseMatrixCSR => :csr,
           ROCSparseMatrixCOO => :coo)

for SparseMatrixType in [ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixCOO]
    @testset "$SparseMatrixType -- densetosparse algo=$algo" for algo in [rocSPARSE.rocsparse_dense_to_sparse_alg_default]
        @testset "densetosparse $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            A_sparse = sprand(T, 10, 20, 0.5)
            A_dense = Matrix{T}(A_sparse)
            dA_dense = ROCMatrix{T}(A_dense)
            dA_sparse = rocSPARSE.densetosparse(dA_dense, fmt[SparseMatrixType], 'O', algo)
            @test A_sparse ≈ collect(dA_sparse)
        end
    end
    @testset "$SparseMatrixType -- sparsetodense algo=$algo" for algo in [rocSPARSE.rocsparse_sparse_to_dense_alg_default]
        @testset "sparsetodense $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            A_dense = rand(T, 10, 20)
            A_sparse = sparse(A_dense)
            dA_sparse = SparseMatrixType(A_sparse)
            dA_dense = rocSPARSE.sparsetodense(dA_sparse, 'O', algo)
            @test A_dense ≈ collect(dA_dense)
        end
    end
end

@testset "gather! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
    X = sprand(T, 20, 0.5)
    dX = ROCSparseVector{T}(X)
    Y = rand(T, 20)
    dY = ROCVector{T}(Y)
    rocSPARSE.gather!(dX, dY, 'O')
    Z = copy(X)
    for i = 1:nnz(X)
        Z[X.nzind[i]] = Y[X.nzind[i]]
    end
    @test Z ≈ sparse(collect(dX))
end

@testset "scatter! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
    X = sprand(T, 20, 0.5)
    dX = ROCSparseVector{T}(X)
    Y = rand(T, 20)
    dY = ROCVector{T}(Y)
    rocSPARSE.scatter!(dY, dX, 'O')
    Z = copy(Y)
    for i = 1:nnz(X)
        Z[X.nzind[i]] = X.nzval[i]
    end
    @test Z ≈ collect(dY)
end

@testset "axpby! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
    X = sprand(T, 20, 0.5)
    dX = ROCSparseVector{T}(X)
    Y = rand(T, 20)
    dY = ROCVector{T}(Y)
    alpha = rand(T)
    beta = rand(T)
    rocSPARSE.axpby!(alpha, dX, beta, dY, 'O')
    @test alpha * X + beta * Y ≈ collect(dY)
end

@testset "rot! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
    X = sprand(T, 20, 0.5)
    dX = ROCSparseVector{T}(X)
    Y = rand(T, 20)
    dY = ROCVector{T}(Y)
    c = rand(T)
    s = rand(T)
    rocSPARSE.rot!(dX, dY, c, s, 'O')
    W = copy(X)
    Z = copy(Y)
    for i = 1:nnz(X)
        W[X.nzind[i]] =  c * X.nzval[i] + s * Y[X.nzind[i]]
        Z[X.nzind[i]] = -s * X.nzval[i] + c * Y[X.nzind[i]]
    end
    @test W ≈ collect(dX)
    @test Z ≈ collect(dY)
end

@testset "vv! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
    for (transx, opx) in [('N', identity), ('C', conj)]
        T <: Real && transx == 'C' && continue
        X = sprand(T, 20, 0.5)
        dX = ROCSparseVector{T}(X)
        Y = rand(T, 20)
        dY = ROCVector{T}(Y)
        result = rocSPARSE.vv!(transx, dX, dY, 'O')
        @test sum(opx(X[i]) * Y[i] for i=1:20) ≈ result
    end
end

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
            @testset "transa = $transa" for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
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
            @testset "transa = $transa" for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
                @testset "transb = $transb" for (transb, opb) in [('N', identity), ('T', transpose), ('C', adjoint)]
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

    @testset "$SparseMatrixType -- sv! algo=$algo" for algo in (rocSPARSE.rocsparse_spsv_alg_default,)
        @testset "sv! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            @testset "transa = $transa" for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
                SparseMatrixType == ROCSparseMatrixCSC && T <: Complex && transa == 'C' && continue
                @testset "uplo = $uplo" for uplo in ('L', 'U')
                    @testset "diag = $diag" for diag in ('U', 'N')
                        A = rand(T, 10, 10)
                        A = uplo == 'L' ? tril(A) : triu(A)
                        A = diag == 'U' ? A - Diagonal(A) + I : A
                        A = sparse(A)
                        dA = SparseMatrixType(A)
                        B = rand(T, 10)
                        C = rand(T, 10)
                        dB = ROCArray(B)
                        dC = ROCArray(C)
                        alpha = rand(T)
                        rocSPARSE.sv!(transa, uplo, diag, alpha, dA, dB, dC, 'O', algo)
                        @test opa(A) \ (alpha * B) ≈ collect(dC)
                    end
                end
            end
        end
    end

    @testset "$SparseMatrixType -- sm! algo=$algo" for algo in (rocSPARSE.rocsparse_spsm_alg_default,)
        @testset "sm! $T" for T in [Float32, Float64, ComplexF32, ComplexF64]
            @testset "transa = $transa" for (transa, opa) in [('N', identity), ('T', transpose), ('C', adjoint)]
                SparseMatrixType == ROCSparseMatrixCSC && T <: Complex && transa == 'C' && continue
                @testset "transb = $transb" for (transb, opb) in [('N', identity), ('T', transpose)]
                    @testset "uplo = $uplo" for uplo in ('L', 'U')
                        @testset "diag = $diag" for diag in ('U', 'N')
                            A = rand(T, 10, 10)
                            A = uplo == 'L' ? tril(A) : triu(A)
                            A = diag == 'U' ? A - Diagonal(A) + I : A
                            A = sparse(A)
                            dA = SparseMatrixType(A)
                            B = transb == 'N' ? rand(T, 10, 2) : rand(T, 2, 10)
                            C = rand(T, 10, 2)
                            dB = ROCArray(B)
                            dC = ROCArray(C)
                            alpha = rand(T)
                            rocSPARSE.sm!(transa, transb, uplo, diag, alpha, dA, dB, dC, 'O', algo)

                            if AMDGPU.HIP.runtime_version() ≥ v"6.2"
                                @test opa(A) \ (alpha * opb(B)) ≈ collect(dC)
                            # TODO remove once we support only ROCm 6.2+
                            else
                                if transb == 'T'
                                    @test_broken opa(A) \ (alpha * opb(B)) ≈ collect(dC)
                                else
                                    @test opa(A) \ (alpha * opb(B)) ≈ collect(dC)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
