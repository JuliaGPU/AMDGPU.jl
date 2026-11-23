using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray
using AMDGPU.rocSPARSE
using SparseArrays
using LinearAlgebra
using Adapt

@assert AMDGPU.functional(:rocsparse)

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

@testset "mv! reuses the analysis: $SparseMatrixType" for SparseMatrixType in (
    ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO,
)
    T = Float32
    m, n = 300, 200
    # one row far longer than the others
    A = sprand(T, m, n, 0.02)
    A[7, :] .= rand(T, n)
    dA = SparseMatrixType(A)
    plans = dA.analysis_cache.plans
    @test isempty(plans)

    for _ in 1:3
        x, y = rand(T, n), rand(T, m)
        dy = ROCArray(y)
        mv!('N', T(2), dA, ROCArray(x), T(3), dy, 'O')
        @test Array(dy) ≈ 2 * A * x + 3 * y
        @test length(plans) == 1
    end

    # another operation gets an analysis of its own, and both stay available
    x, y = rand(T, m), rand(T, n)
    dy = ROCArray(y)
    mv!('T', T(2), dA, ROCArray(x), T(3), dy, 'O')
    @test Array(dy) ≈ 2 * transpose(A) * x + 3 * y
    @test length(plans) == 2
    x = rand(T, n)
    dy = ROCArray(zeros(T, m))
    mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
    @test Array(dy) ≈ A * x
    @test length(plans) == 2

    # the values are read at each product
    nonzeros(dA) .*= 2
    mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
    @test Array(dy) ≈ 2 * A * x
    @test length(plans) == 2

    # a new sparsity pattern is analyzed again
    B = A[m:-1:1, :]
    if SparseMatrixType != ROCSparseMatrixCSC
        copyto!(dA, SparseMatrixType(B))
        @test isempty(plans)
        mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
        @test Array(dy) ≈ B * x
        @test length(plans) == 1
    end
    B = sprand(T, m, n, 0.02)
    B[11, :] .= rand(T, n)
    dB = SparseMatrixType(B)
    for name in fieldnames(SparseMatrixType)
        name == :analysis_cache && continue
        setproperty!(dA, name, getproperty(dB, name))
        @test isempty(plans)
    end
    mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
    @test Array(dy) ≈ B * x
    @test length(plans) == 1

    @test rocSPARSE.reset_analysis_cache!(dA) === dA
    @test isempty(plans)
    mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
    @test Array(dy) ≈ B * x
end

@testset "mv! with beta = 0 ignores Y: $SparseMatrixType, transa = $transa" for SparseMatrixType in (
        ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO,
    ), (transa, opa) in (('N', identity), ('T', transpose))
    T = Float32
    m, n = 20_000, 20_000
    # a row and a column long enough for rocSPARSE to split their sums over several threads
    A = sprand(T, m, n, 1e-3)
    A[7, :] .= rand(T, n)
    A[:, 11] .= rand(T, m)
    dA = SparseMatrixType(A)
    x = transa == 'N' ? rand(T, n) : rand(T, m)
    expected = opa(A) * x
    for y in (T(NaN), T(Inf), T(1e12))
        dy = AMDGPU.fill(y, length(expected))
        mv!(transa, T(1), dA, ROCArray(x), T(0), dy, 'O')
        @test Array(dy) ≈ expected
    end
end

@testset "mm! reuses the analysis: $SparseMatrixType" for SparseMatrixType in (
    ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO,
)
    T = Float32
    m, n = 300, 200
    # one row far longer than the others
    A = sprand(T, m, n, 0.02)
    A[7, :] .= rand(T, n)
    dA = SparseMatrixType(A)
    plans = dA.analysis_cache.plans

    for _ in 1:3
        B, C = rand(T, n, 4), rand(T, m, 4)
        dC = ROCArray(C)
        mm!('N', 'N', T(2), dA, ROCArray(B), T(3), dC, 'O')
        @test Array(dC) ≈ 2 * A * B + 3 * C
        @test length(plans) == 1
    end

    # dense matrices of another size get an analysis of their own
    B, C = rand(T, n, 6), rand(T, m, 6)
    dC = ROCArray(C)
    mm!('N', 'N', T(2), dA, ROCArray(B), T(3), dC, 'O')
    @test Array(dC) ≈ 2 * A * B + 3 * C
    @test length(plans) == 2

    # so does the product with a vector
    x = rand(T, n)
    dy = ROCArray(zeros(T, m))
    mv!('N', T(1), dA, ROCArray(x), T(0), dy, 'O')
    @test Array(dy) ≈ A * x
    @test length(plans) == 3

    # dense times sparse keeps its analysis on the sparse matrix
    if SparseMatrixType != ROCSparseMatrixCOO
        D, C = rand(T, 5, m), rand(T, 5, n)
        for _ in 1:2
            dC = ROCArray(C)
            mm!('N', 'N', T(2), ROCArray(D), dA, T(3), dC, 'O')
            @test Array(dC) ≈ 2 * D * A + 3 * C
            @test length(plans) == 4
        end
    end

    # only the analyses of the most recent sizes are kept
    empty!(plans)
    x, y = rand(T, n), rand(T, m)
    for k in 1:(rocSPARSE.MAX_ANALYSIS_PLANS + 3)
        B = rand(T, n, k)
        dC = ROCArray(zeros(T, m, k))
        mm!('N', 'N', T(1), dA, ROCArray(B), T(0), dC, 'O')
        @test Array(dC) ≈ A * B
        # a plan in use is not the one that is dropped
        dy = ROCArray(y)
        mv!('N', T(2), dA, ROCArray(x), T(3), dy, 'O')
        @test Array(dy) ≈ 2 * A * x + 3 * y
    end
    @test length(plans) == rocSPARSE.MAX_ANALYSIS_PLANS
    @test count(plan -> plan.key isa rocSPARSE.SpMVKey, plans) == 1

    # a new sparsity pattern is analyzed again
    B = rand(T, n, 4)
    dC = ROCArray(zeros(T, m, 4))
    A2 = sprand(T, m, n, 0.02)
    dA2 = SparseMatrixType(A2)
    for name in fieldnames(SparseMatrixType)
        name == :analysis_cache && continue
        setproperty!(dA, name, getproperty(dA2, name))
    end
    @test isempty(plans)
    mm!('N', 'N', T(1), dA, ROCArray(B), T(0), dC, 'O')
    @test Array(dC) ≈ A2 * B
end

@testset "mm! with beta = 0 ignores C: $SparseMatrixType, transa = $transa" for SparseMatrixType in (
        ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO,
    ), (transa, opa) in (('N', identity), ('T', transpose))
    SparseMatrixType == ROCSparseMatrixCOO && transa != 'N' && continue
    T = Float32
    m, n = 2_000, 200_000
    # a row long enough for rocSPARSE to split its sum over several threads
    A = sprand(T, m, n, 1e-4)
    A[7, :] .= rand(T, n)
    dA = SparseMatrixType(A)
    B = transa == 'N' ? rand(T, n, 3) : rand(T, m, 3)
    expected = opa(A) * B
    for c in (T(NaN), T(Inf), T(1e12))
        dC = AMDGPU.fill(c, size(expected))
        mm!(transa, 'N', T(1), dA, ROCArray(B), T(0), dC, 'O')
        @test Array(dC) ≈ expected
    end
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
