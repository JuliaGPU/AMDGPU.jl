module AMDGPUSparseMatricesCSRExt

using AMDGPU
import AMDGPU.rocSPARSE:
    ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO, ROCSparseMatrixBSR,
    SparseMatrixCSC
using SparseMatricesCSR
import SparseMatricesCSR: SparseMatrixCSR
import Adapt

# CPU → GPU
AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSR) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(
        AMDGPU.ROCVector{Cint}(Mat.rowptr),
        AMDGPU.ROCVector{Cint}(Mat.colval),
        AMDGPU.ROCVector{T}(Mat.nzval),
        size(Mat),
    )
AMDGPU.rocSPARSE.ROCSparseMatrixCSR(Mat::SparseMatrixCSR{<:Any, T}) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat)

AMDGPU.rocSPARSE.ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSR) where {T} = ROCSparseMatrixCSC(ROCSparseMatrixCSR{T}(Mat))
AMDGPU.rocSPARSE.ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSR) where {T} = ROCSparseMatrixCOO(ROCSparseMatrixCSR{T}(Mat))
AMDGPU.rocSPARSE.ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSR, blockdim) where {T} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(Mat), blockdim)

# GPU → CPU
SparseMatricesCSR.SparseMatrixCSR(A::ROCSparseMatrixCSR) = SparseMatrixCSR{1}(size(A)..., Array(A.rowPtr), Array(A.colVal), Array(A.nzVal))
SparseMatricesCSR.SparseMatrixCSR(A::ROCSparseMatrixCOO) = SparseMatrixCSR(ROCSparseMatrixCSR(A))
SparseMatricesCSR.SparseMatrixCSR(A::ROCSparseMatrixCSC) = SparseMatrixCSR(ROCSparseMatrixCSR(A))
SparseMatricesCSR.SparseMatrixCSR(A::ROCSparseMatrixBSR) = SparseMatrixCSR(ROCSparseMatrixCSR(A))

# Adapt
Adapt.adapt_storage(::Type{AMDGPU.ROCArray}, xs::SparseMatrixCSR) =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR(xs)
Adapt.adapt_storage(::Type{AMDGPU.ROCArray{T}}, xs::SparseMatrixCSR) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(xs)
Adapt.adapt_storage(::Type{Array}, mat::ROCSparseMatrixCSR) = SparseMatrixCSR(mat)

end
