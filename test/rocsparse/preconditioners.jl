n = 32
p = 5
blockdim = 4

@testset "Preconditioners" begin
    @testset "$SparseMatrixType" for SparseMatrixType in (ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR)
        @testset "ILU(0) -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            A = rand(elty,n,n) + I
            A = sparse(A)
            d_A = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(A), blockdim) : SparseMatrixType(A)
            d_P = rocSPARSE.ilu0(d_A, 'O')
            @test mapreduce(isfinite, &, collect(nonzeros(d_P)))
        end

        @testset "IC(0) -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            A = rand(elty,n,n)
            A = A * A'
            A = sparse(A)
            d_A = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(A), blockdim) : SparseMatrixType(A)
            d_P = rocSPARSE.ic0(d_A, 'O')
            @test mapreduce(isfinite, &, collect(nonzeros(d_P)))
        end
    end
end

@testset "Triangular solves" begin
    @testset "$SparseMatrixType" for SparseMatrixType in (ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR)
        @testset "y = T \\ x -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            @testset "trans = $trans" for (trans, op) in (('N', identity), ('T', transpose), ('C', adjoint))
                (SparseMatrixType == ROCSparseMatrixCSC) && (trans == 'C') && (elty <: Complex) && continue
                @testset "uplo = $uplo" for uplo in ('L', 'U')
                    @testset "diag = $diag" for diag in ('N', 'U')
                        T = rand(elty,n,n)
                        T = uplo == 'L' ? tril(T) : triu(T)
                        T = diag == 'N' ? T : T - Diagonal(T) + I
                        T = sparse(T)
                        d_T = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(T), blockdim) : SparseMatrixType(T)
                        x = rand(elty,n)
                        d_x = ROCVector{elty}(x)
                        d_y = rocSPARSE.sv2(trans, uplo, diag, d_T, d_x, 'O')
                        y = op(T) \ x
                        @test collect(d_y) ≈ y
                    end
                end
            end
        end

        @testset "Y = T \\ X -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            @testset "transT = $transT" for (transT, opT) in (('N', identity), ('T', transpose), ('C', adjoint))
                @testset "transX = $transX" for (transX, opX) in (('N', identity), ('T', transpose), ('C', adjoint))
                    (SparseMatrixType == ROCSparseMatrixCSC) && (trans == 'C') && (elty <: Complex) && continue
                    @testset "uplo = $uplo" for uplo in ('L', 'U')
                        @testset "diag = $diag" for diag in ('N', 'U')
                            T = rand(elty,n,n)
                            T = uplo == 'L' ? tril(T) : triu(T)
                            T = diag == 'N' ? T : T - Diagonal(T) + I
                            T = sparse(T)
                            d_T = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(T), blockdim) : SparseMatrixType(T)
                            X = transX == 'N' ? rand(elty,n,p) : rand(elty,p,n)
                            d_X = ROCMatrix{elty}(X)
                            d_Y = rocSPARSE.sm2(transT, transX, uplo, diag, d_T, d_X, 'O')
                            Y = opT(T) \ opX(X)
                            @test collect(d_Y) ≈ Y
                        end
                    end
                end
            end
        end
    end
end
