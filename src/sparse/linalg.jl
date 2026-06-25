using LinearAlgebra

# triu/tril for COO: mask entries by position; GPUArrays' generic CSR/CSC implementations route through coo_type, so this covers all formats.
function LinearAlgebra.triu(A::ROCSparseMatrixCOO, k::Integer=0)
    mask = A.rowInd .+ k .<= A.colInd
    sparse(A.rowInd[mask], A.colInd[mask], A.nzVal[mask], size(A)..., fmt=:coo)
end

function LinearAlgebra.tril(A::ROCSparseMatrixCOO, k::Integer=0)
    mask = A.rowInd .+ k .>= A.colInd
    sparse(A.rowInd[mask], A.colInd[mask], A.nzVal[mask], size(A)..., fmt=:coo)
end

# kron for COO: Kronecker product via repeat/broadcast on the index and value arrays.
function LinearAlgebra.kron(A::ROCSparseMatrixCOO{T,Ti}, B::ROCSparseMatrixCOO{T,Ti}) where {T,Ti}
    mA, nA = size(A)
    mB, nB = size(B)
    out_shape = (mA * mB, nA * nB)
    Annz = Int64(A.nnz)
    Bnnz = Int64(B.nnz)
    if Annz == 0 || Bnnz == 0
        return ROCSparseMatrixCOO(
            ROCVector{Ti}(undef, 0), ROCVector{Ti}(undef, 0),
            ROCVector{T}(undef, 0), out_shape)
    end
    row  = repeat((A.rowInd .- 1) .* mB, inner=Bnnz)
    col  = repeat((A.colInd .- 1) .* nB, inner=Bnnz)
    data = repeat(A.nzVal, inner=Bnnz)
    row  .+= repeat(B.rowInd .- 1, outer=Annz) .+ 1
    col  .+= repeat(B.colInd .- 1, outer=Annz) .+ 1
    data .*= repeat(B.nzVal, outer=Annz)
    sparse(row, col, data, out_shape..., fmt=:coo)
end

function LinearAlgebra.kron(A::ROCSparseMatrixCOO{T,Ti}, B::Diagonal) where {T,Ti}
    mA, nA = size(A)
    mB, nB = size(B)
    out_shape = (mA * mB, nA * nB)
    Annz = Int64(A.nnz)
    Bnnz = nB
    if Annz == 0 || Bnnz == 0
        return ROCSparseMatrixCOO(
            ROCVector{Ti}(undef, 0), ROCVector{Ti}(undef, 0),
            ROCVector{T}(undef, 0), out_shape)
    end
    row  = repeat((A.rowInd .- 1) .* mB, inner=Bnnz)
    col  = repeat((A.colInd .- 1) .* nB, inner=Bnnz)
    data = repeat(A.nzVal, inner=Bnnz)
    row  .+= ROCVector(repeat(0:nB-1, outer=Annz)) .+ 1
    col  .+= ROCVector(repeat(0:nB-1, outer=Annz)) .+ 1
    data .*= repeat(ROCArray(B.diag), outer=Annz)
    sparse(row, col, data, out_shape..., fmt=:coo)
end

function LinearAlgebra.kron(A::Diagonal, B::ROCSparseMatrixCOO{T,Ti}) where {T,Ti}
    mA, nA = size(A)
    mB, nB = size(B)
    out_shape = (mA * mB, nA * nB)
    Annz = nA
    Bnnz = Int64(B.nnz)
    if Annz == 0 || Bnnz == 0
        return ROCSparseMatrixCOO(
            ROCVector{Ti}(undef, 0), ROCVector{Ti}(undef, 0),
            ROCVector{T}(undef, 0), out_shape)
    end
    row  = ROCVector(repeat(collect(Ti, (0:nA-1) .* mB), inner=Bnnz))
    col  = ROCVector(repeat(collect(Ti, (0:nA-1) .* nB), inner=Bnnz))
    data = repeat(ROCArray(A.diag), inner=Bnnz)
    row  .+= repeat(B.rowInd .- 1, outer=Annz) .+ 1
    col  .+= repeat(B.colInd .- 1, outer=Annz) .+ 1
    data .*= repeat(B.nzVal, outer=Annz)
    sparse(row, col, data, out_shape..., fmt=:coo)
end
