module AMDGPUSparseMatricesCSRExt

using AMDGPU
using GPUArrays
import AMDGPU.rocSPARSE:
    ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO, ROCSparseMatrixBSR,
    SparseMatrixCSC
using SparseMatricesCSR
import SparseMatricesCSR: SparseMatrixCSR
import Adapt

# CPU → GPU
# NOTE: `SparseMatricesCSR.SparseMatrixCSR{Bi,Tv,Ti}` has a type parameter `Bi` for the index base (0 or 1),
# but `ROCSPARSE` expects 1-based pointer. Therefore, we restrict dispatch to `SparseMatrixCSR{1}`.
function AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T,Ti}(Mat::SparseMatrixCSR{1}) where {T,Ti}
    GPUArrays.check_sparse_dims(Ti,size(Mat))
    GPUArrays.check_sparse_nnz(Ti,length(Mat.nzval))
    GPUArrays.check_sparse_values(T,Mat.nzval)
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(
        AMDGPU.ROCVector{Ti}(Mat.rowptr),
        AMDGPU.ROCVector{Ti}(Mat.colval),
        AMDGPU.ROCVector{T}(Mat.nzval),
        size(Mat),
    )
end
AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSR{1}) where {T} = ROCSparseMatrixCSR{T,Cint}(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSR(Mat::SparseMatrixCSR{1, T}) where {T} =
    AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat)

AMDGPU.rocSPARSE.ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSR{1}) where {T} = ROCSparseMatrixCSC(ROCSparseMatrixCSR{T}(Mat))
AMDGPU.rocSPARSE.ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSR{1}) where {T} = ROCSparseMatrixCOO(ROCSparseMatrixCSR{T}(Mat))
for format in (:ROCSparseMatrixCSC,:ROCSparseMatrixCOO)
    @eval AMDGPU.rocSPARSE.$format{T,Ti}(Mat::SparseMatrixCSR{1}) where {T,Ti} =
        $format{T,Ti}(ROCSparseMatrixCSR{T,Ti}(Mat))
end
AMDGPU.rocSPARSE.ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSR{1}, blockdim) where {T} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(Mat), blockdim)
AMDGPU.rocSPARSE.ROCSparseMatrixBSR(Mat::SparseMatrixCSR,blockdim) =
    ROCSparseMatrixBSR(ROCSparseMatrixCSR(Mat),blockdim)

# Error for unsupported index base.
@noinline _unsupported_index_base(::SparseMatrixCSR{Bi}) where {Bi} = throw(ArgumentError(
    "`ROCSPARSE` expects 1-based index `SparseMatrixCSR{1}` to be converted to rocSPARSE types, " *
    "but got a $Bi-based `SparseMatrixCSR{$Bi}`."))

AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSR{T,Ti}(Mat::SparseMatrixCSR) where {T,Ti} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSR(Mat::SparseMatrixCSR) = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSR) where {T} = _unsupported_index_base(Mat)
AMDGPU.rocSPARSE.ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSR, ::Any) where {T} = _unsupported_index_base(Mat)

# GPU → CPU
function SparseMatricesCSR.SparseMatrixCSR(A::ROCSparseMatrixCSR)
    Ti=promote_type(eltype(A.rowPtr),eltype(A.colVal))
    SparseMatrixCSR{1}(size(A)...,Vector{Ti}(Array(A.rowPtr)),Vector{Ti}(Array(A.colVal)),Array(A.nzVal))
end
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
