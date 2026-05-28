module AMDGPUSparseMatricesCSRExt

using AMDGPU
import AMDGPU.rocSPARSE:
    ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO, ROCSparseMatrixBSR,
    SparseMatrixCSC
using SparseMatricesCSR
import SparseMatricesCSR: SparseMatrixCSR
import Adapt

# CPU → GPU
# NOTE: `SparseMatricesCSR.SparseMatrixCSR{Bi,Tv,Ti}` has a type parameter `Bi` for the index base (0 or 1),
# but `ROCSPARSE` expects 1-based pointer. Therefore, we restrict dispatch to `SparseMatrixCSR{1}`.
AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSR{1}) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(
        AMDGPU.ROCVector{Cint}(Mat.rowptr),
        AMDGPU.ROCVector{Cint}(Mat.colval),
        AMDGPU.ROCVector{T}(Mat.nzval),
        size(Mat),
    )
AMDGPU.rocSPARSE.ROCSparseMatrixCSR(Mat::SparseMatrixCSR{1, T}) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat)

AMDGPU.rocSPARSE.ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSR{1}) where {T} = ROCSparseMatrixCSC(ROCSparseMatrixCSR{T}(Mat))
AMDGPU.rocSPARSE.ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSR{1}) where {T} = ROCSparseMatrixCOO(ROCSparseMatrixCSR{T}(Mat))
AMDGPU.rocSPARSE.ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSR{1}, blockdim) where {T} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(Mat), blockdim)

# Error for unsupported index base.
@noinline _unsupported_index_base(::SparseMatrixCSR{Bi}) where {Bi} = throw(ArgumentError(
    "`ROCSPARSE` expects 1-based index `SparseMatrixCSR{1}` to be converted to rocSPARSE types, " *
    "but got a $Bi-based `SparseMatrixCSR{$Bi}`."))

AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSR(Mat::SparseMatrixCSR) = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSR, ::Any) where {T} = _unsupported_index_base(Mat)

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
