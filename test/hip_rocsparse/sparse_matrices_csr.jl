using SparseMatricesCSR
using SparseArrays
using AMDGPU
using AMDGPU.rocSPARSE
using Test

@assert AMDGPU.functional(:rocsparse)

@testset "SparseMatricesCSRExt" begin

    for (n, bd, p) in [(100, 5, 0.02), (5, 1, 0.8), (4, 2, 0.5)]
        @testset "conversions between ROCSparseMatrices (n, bd, p) = ($n, $bd, $p)" begin
            _A = sprand(n, n, p)
            A = SparseMatrixCSR(_A)
            blockdim = bd
            for ROCSparseMatrixType1 in (ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixCOO, ROCSparseMatrixBSR)
                dA1 = ROCSparseMatrixType1 == ROCSparseMatrixBSR ? ROCSparseMatrixType1(A, blockdim) : ROCSparseMatrixType1(A)
                @testset "conversion $ROCSparseMatrixType1 --> SparseMatrixCSR" begin
                    @test SparseMatrixCSR(dA1) ≈ A
                end
                for ROCSparseMatrixType2 in (ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixCOO, ROCSparseMatrixBSR)
                    ROCSparseMatrixType1 == ROCSparseMatrixType2 && continue
                    dA2 = ROCSparseMatrixType2 == ROCSparseMatrixBSR ? ROCSparseMatrixType2(dA1, blockdim) : ROCSparseMatrixType2(dA1)
                    @testset "conversion $ROCSparseMatrixType1 --> $ROCSparseMatrixType2" begin
                        @test collect(dA1) ≈ collect(dA2)
                    end
                end
            end
        end
    end
end
