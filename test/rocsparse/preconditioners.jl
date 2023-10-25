n = 32
blockdim = 4

@testset "Preconditioners" begin
    @testset "$SparseMatrixType" for SparseMatrixType in (ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR)
        @testset "ILU(0) -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            A = rand(elty,n,n) + I
            A = sparse(A)
            d_A = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(A), blockdim) : SparseMatrixType(A)
            d_P = rocSPARSE.ilu0(d_A, '0')
            @test mapreduce(isfinite, &, collect(nonzeros(d_P)))
        end

        @testset "IC(0) -- $elty" for elty in (Float32, Float64, ComplexF32, ComplexF64)
            A = rand(elty,n,n)
            A = A * A'
            d_A = SparseMatrixType == ROCSparseMatrixBSR ? SparseMatrixType(ROCSparseMatrixCSR(A), blockdim) : SparseMatrixType(A)
            d_P = rocSPARSE.ic0(d_A, '0')
            @test mapreduce(isfinite, &, collect(nonzeros(d_P)))
        end
    end
end
