using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray, roc
using AMDGPU.rocSPARSE
using SparseArrays
using LinearAlgebra
using Adapt

@assert AMDGPU.functional(:rocsparse)

@testset "sparse" begin
    n, m = 4, 4
    I = [1,2,3] |> roc
    J = [2,3,4] |> roc
    V = Float32[1,2,3] |> roc

    dense = rand(3,3) |> roc

    # check defaults
    @test sparse(I, J, V) isa ROCSparseMatrixCSC
    @test sparse(dense) isa ROCSparseMatrixCSC

    for (fmt, T) in  [
        (:coo, ROCSparseMatrixCOO),
        (:csc, ROCSparseMatrixCSC),
        (:csr, ROCSparseMatrixCSR),
        (:bsr, ROCSparseMatrixBSR),
    ]
        if fmt != :bsr # bsr not supported
            x = sparse(I, J, V; fmt=fmt)
            @test x isa T{Float32}
            @test size(x) == (3, 4)

            x = sparse(I, J, V, m, n; fmt=fmt)
            @test x isa T{Float32}
            @test  size(x) == (4, 4)
        end

        if fmt != :coo # dense to COO not implemented
            x = sparse(dense; fmt=fmt)
            @test x isa T{Float32}
            @test collect(x) == collect(dense)
        end
    end
end

@testset "sparse with Int32 indices" begin
    I = Int32[1,2,3] |> roc
    J = Int32[2,3,4] |> roc
    V = Float32[1,2,3] |> roc

    @test sparse(I, J, V) isa ROCSparseMatrixCSC
    for fmt in (:coo, :csc, :csr)
        x = sparse(I, J, V; fmt=fmt)
        @test size(x) == (3, 4)
    end

    m, n = Int32(4), Int32(4)
    for fmt in (:coo, :csc, :csr)
        x = sparse(I, J, V, m, n; fmt=fmt)
        @test size(x) == (4, 4)
    end
end

@testset "unsorted sparse (AMDGPU.jl#1407)" begin
    I = [1, 1, 2, 3, 3, 4, 5, 4, 6, 4, 5, 6, 6, 6]
    J = [4, 6, 4, 5, 6, 6, 6, 1, 1, 2, 3, 3, 4, 5]

    # ensure we cover both the ROCSPARSE-based and native COO row sort
    for typ in (Float32, Float64)
        A = sparse(I, J, ones(typ, length(I)), 6, 6)
        Agpu = sparse(I |> roc, J |> roc, ones(typ, length(I)) |> roc, 6, 6)
        @test SparseMatrixCSC(Agpu) == A
    end
end

@testset "Adapt sparse arrays to ROCBackend" begin
    A = spdiagm(0 => ones(5), -1 => -ones(4), 1 => -ones(4))
    @test adapt(ROCBackend(), A) isa ROCSparseMatrixCSC

    v = sparsevec([1, 3, 5], [1.0, 2.0, 3.0], 5)
    @test adapt(ROCBackend(), v) isa ROCSparseVector

    dA = adapt(ROCBackend(), A)
    @test adapt(ROCBackend(), dA) === dA
end

@testset "ROCSparseMatrix(::Diagonal)" begin
    X = Diagonal(rand(10))
    dX = roc(X)
    dY = ROCSparseMatrixCSC{Float64, Int32}(dX)
    dZ = ROCSparseMatrixCSR{Float64, Int32}(dX)
    @test SparseMatrixCSC(dY) ≈ SparseMatrixCSC(dZ)
    @test SparseMatrixCSC(ROCSparseMatrixCSC(X)) ≈ SparseMatrixCSC(ROCSparseMatrixCSR(X))
end
