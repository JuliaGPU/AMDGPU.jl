using SparseMatricesCSR
using SparseArrays
using AMDGPU
using AMDGPU.rocSPARSE
using Adapt
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

    @testset "non-1-based SparseMatrixCSR is rejected" begin
        A0 = SparseMatrixCSR{0}(3, 3, Cint[0, 1, 2, 3], Cint[0, 1, 2], [1.0, 2.0, 3.0])
        @test_throws ArgumentError ROCSparseMatrixCSR(A0)
        @test_throws ArgumentError ROCSparseMatrixCSC(A0)
        @test_throws ArgumentError ROCSparseMatrixCOO(A0)
        @test_throws ArgumentError ROCSparseMatrixBSR(A0, 1)
        @test_throws ArgumentError adapt(ROCArray, A0)
    end
end
