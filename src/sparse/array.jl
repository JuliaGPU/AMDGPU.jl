# Ordinary sparse arrays use GPUArrays' canonical storage. BSR retains its
# backend format; descriptors and unfinished vendor outputs are separate resources.
using SparseArrays
using SparseArrays: nonzeroinds, nonzeros, rowvals, getcolptr
using LinearAlgebra: BlasFloat, AdjOrTrans
import AMDGPU: ROCArray
using GPUArrays: GPUSparseVector, GPUSparseMatrixCSR, GPUSparseMatrixCSC, GPUSparseMatrixCOO

export ROCSparseVector, ROCSparseMatrixCSR, ROCSparseMatrixCSC, ROCSparseMatrixCOO,
       ROCSparseMatrixBSR, ROCSparseMatrix, ROCSparseVecOrMat,
       AbstractROCSparseMatrix

const ROCSparseVector{Tv,Ti} = GPUSparseVector{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}
const ROCSparseMatrixCSR{Tv,Ti} = GPUSparseMatrixCSR{Tv,Ti,<:ROCVector{<:Integer},<:ROCVector{Ti},<:ROCVector{Tv}}
const ROCSparseMatrixCSC{Tv,Ti} = GPUSparseMatrixCSC{Tv,Ti,<:ROCVector{<:Integer},<:ROCVector{Ti},<:ROCVector{Tv}}
const ROCSparseMatrixCOO{Tv,Ti} = GPUSparseMatrixCOO{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}
const ROCCanonicalMatrix{Tv,Ti} = Union{ROCSparseMatrixCSR{Tv,Ti},ROCSparseMatrixCSC{Tv,Ti},ROCSparseMatrixCOO{Tv,Ti}}
const ROCCanonicalSparse{Tv,Ti} = Union{ROCSparseVector{Tv,Ti},ROCCanonicalMatrix{Tv,Ti}}

abstract type _AbstractROCVendorSparseMatrix{Tv,Ti} <: GPUArrays.AbstractGPUSparseMatrix{Tv,Ti} end

mutable struct ROCSparseMatrixBSR{Tv, Ti} <: _AbstractROCVendorSparseMatrix{Tv, Ti}
    rowPtr::ROCVector{Ti}
    colVal::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    blockDim::Ti
    dir::SparseChar
    nnzb::Ti

    function ROCSparseMatrixBSR{Tv, Ti}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,<:Integer},
                                   blockDim::Integer, dir::SparseChar, nnz::Integer) where {Tv, Ti<:Integer}
        all(>=(0),dims) && blockDim>0 || throw(ArgumentError("invalid BSR dimensions or block size"))
        dir in ('R','C') || throw(ArgumentError("invalid BSR block direction"))
        mb,nb=cld.(dims,blockDim)
        GPUArrays.check_sparse_dims(Ti,(mb,nb,Int(blockDim)))
        GPUArrays.check_sparse_nnz(Ti,nnz)
        length(rowPtr)==Base.checked_add(mb,1) && length(colVal)==nnz &&
            length(nzVal)==Base.checked_mul(nnz,Base.checked_mul(blockDim,blockDim)) ||
            throw(ArgumentError("BSR buffer lengths do not match block dimensions and count"))
        GPUArrays.check_sparse_values(Tv,nzVal)
        new{Tv, Ti}(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)
    end
end

ROCSparseMatrixBSR(A::ROCSparseMatrixBSR) = A

function AMDGPU.unsafe_free!(xs::ROCSparseMatrixBSR)
    unsafe_free!(xs.rowPtr)
    unsafe_free!(xs.colVal)
    unsafe_free!(nonzeros(xs))
    return
end


const ROCSparseMatrix{Tv,Ti} = Union{ROCSparseMatrixCSR{Tv,Ti},ROCSparseMatrixCSC{Tv,Ti},
                                   ROCSparseMatrixCOO{Tv,Ti},ROCSparseMatrixBSR{Tv,Ti}}
# Kept for dispatch, but this UnionAll alias can no longer be subtyped.
const AbstractROCSparseMatrix{Tv,Ti} = Union{ROCCanonicalMatrix{Tv,Ti},_AbstractROCVendorSparseMatrix{Tv,Ti}}
const ROCSparseVecOrMat = Union{ROCSparseVector,ROCSparseMatrix}
const ROCSparseMatrixAdjOrTrans = Union{Transpose{<:Any,<:ROCCanonicalMatrix},Adjoint{<:Any,<:ROCCanonicalMatrix}}
const ROCSparseMatrixConvertible = Union{ROCSparseMatrix,ROCSparseMatrixAdjOrTrans}

# Raw constructors borrow canonical buffers and infer the two integer widths. An explicit
# {Tv,Ti} requests uniform indices; value-only forms preserve existing storage widths.
for (alias, generic) in ((:ROCSparseMatrixCSR,:GPUSparseMatrixCSR),
                         (:ROCSparseMatrixCSC,:GPUSparseMatrixCSC),
                         (:ROCSparseMatrixCOO,:GPUSparseMatrixCOO))
    @eval begin
        $alias(p::ROCVector, i::ROCVector, v::ROCVector, dims::NTuple{2,Integer}) =
            $generic(p, i, v, dims)
        $alias{Tv}(p::ROCVector, i::ROCVector, v::ROCVector, dims::NTuple{2,Integer}) where {Tv} =
            $generic(p, i, checked_values(Tv, v), dims)
        $alias{Tv,Ti}(p::ROCVector, i::ROCVector, v::ROCVector, dims::NTuple{2,Integer}) where {Tv,Ti} =
            GPUArrays.with_eltypes($generic(p, i, v, dims), Tv, Ti)
        $alias(A::GPUArrays.GPUSparseArray) = $generic(adapt(ROCArray, A))
        $alias{Tv}(A::GPUArrays.GPUSparseArray) where {Tv} =
            $generic{Tv}(adapt(ROCArray, A))
        $alias{Tv,Ti}(A::GPUArrays.GPUSparseArray) where {Tv,Ti} =
            $generic{Tv,Ti}(adapt(ROCArray, A))
        $alias(A::AbstractArray) = $alias{eltype(A),Cint}(A)
        $alias{Tv}(A::AbstractArray) where {Tv} = $alias{Tv,Cint}(A)
        $alias{Tv,Ti}(A::AbstractArray) where {Tv,Ti} =
            $generic{Tv,Ti}(adapt(ROCArray, A))
    end
end
checked_values(::Type{T}, v) where {T} =
    (GPUArrays.check_sparse_values(T, v); convert(ROCVector{T}, v))

ROCSparseVector(i::ROCVector, v::ROCVector, n::Integer) = GPUSparseVector(i, v, n)
ROCSparseVector{T}(i::ROCVector, v::ROCVector, n::Integer) where {T} =
    GPUSparseVector(i, checked_values(T, v), n)
ROCSparseVector{T,Ti}(i::ROCVector, v::ROCVector, n::Integer) where {T,Ti} =
    GPUArrays.with_eltypes(GPUSparseVector(i, v, n), T, Ti)
ROCSparseVector(A::GPUArrays.GPUSparseArray) = GPUSparseVector(adapt(ROCArray, A))
ROCSparseVector{T}(A::GPUArrays.GPUSparseArray) where {T} = GPUSparseVector{T}(adapt(ROCArray, A))
ROCSparseVector{T,Ti}(A::GPUArrays.GPUSparseArray) where {T,Ti} = GPUSparseVector{T,Ti}(adapt(ROCArray, A))
ROCSparseVector(A::AbstractArray) = ROCSparseVector{eltype(A),Cint}(A)
ROCSparseVector{T}(A::AbstractArray) where {T} = ROCSparseVector{T,Cint}(A)
ROCSparseVector{T,Ti}(A::AbstractArray) where {T,Ti} = GPUSparseVector{T,Ti}(adapt(ROCArray, A))

ROCSparseMatrixCOO(I::ROCVector,J::ROCVector,V::ROCVector)=
    ROCSparseMatrixCOO(I,J,V,(isempty(I) ? 0 : Int(maximum(I)),isempty(J) ? 0 : Int(maximum(J))))
ROCSparseMatrixCOO{T}(I::ROCVector,J::ROCVector,V::ROCVector) where {T}=
    GPUArrays.with_values(ROCSparseMatrixCOO(I,J,V),T)
ROCSparseMatrixCOO{T,Ti}(I::ROCVector,J::ROCVector,V::ROCVector) where {T,Ti}=
    GPUArrays.with_eltypes(ROCSparseMatrixCOO(I,J,V),T,Ti)

# Legacy explicit stored counts are logical lengths, never spare capacity.
function _coo_prefix(I, J, V, dims, n::Integer)
    0 <= n <= min(length(I), length(J), length(V)) ||
        throw(ArgumentError("stored count exceeds supplied COO buffers"))
    if n != length(I) || n != length(J) || n != length(V)
        return GPUSparseMatrixCOO(copy(view(I,1:n)), copy(view(J,1:n)), copy(view(V,1:n)), dims)
    end
    return GPUSparseMatrixCOO(I, J, V, dims)
end
ROCSparseMatrixCOO(I::ROCVector, J::ROCVector, V::ROCVector, dims::NTuple{2,Integer}, n::Integer) =
    _coo_prefix(I,J,V,dims,n)
ROCSparseMatrixCOO{T,Ti}(I::ROCVector, J::ROCVector, V::ROCVector, dims::NTuple{2,Integer}, n::Integer) where {T,Ti} =
    GPUArrays.with_eltypes(_coo_prefix(I,J,V,dims,n),T,Ti)
ROCSparseMatrixCOO{T}(I::ROCVector, J::ROCVector, V::ROCVector, dims::NTuple{2,Integer}, n::Integer) where {T} =
    GPUArrays.with_values(_coo_prefix(I,J,V,dims,n),T)

# roc retains CSC/Int32 defaults and its floating precision policy.
for S in (:SparseMatrixCSC,:SparseVector)
    @eval function Adapt.adapt_structure(to::AMDGPU.Float32Adaptor,A::$S)
        values=adapt(to,nonzeros(A))
        B=adapt(typeof(values),A)
        GPUArrays.sparse_format_type(B){eltype(values),Cint}(B)
    end
end

# Dense construction stays on the device, including explicit memory modes.
for (N, S) in ((1,:ROCSparseVector),(2,:ROCCanonicalMatrix))
    @eval begin
        ROCArray{T,$N,M}(A::$S) where {T,M} = copyto!(ROCArray{T,$N,M}(undef,size(A)),A)
        ROCArray{T,$N,M}(A::$S{T}) where {T,M} = copyto!(ROCArray{T,$N,M}(undef,size(A)),A)
        ROCArray{T,$N}(A::$S) where {T} = copyto!(ROCArray{T,$N}(undef,size(A)),A)
        ROCArray{T,$N}(A::$S{T}) where {T} = copyto!(ROCArray{T,$N}(undef,size(A)),A)
        ROCArray{T}(A::$S) where {T} = ROCArray{T,$N}(A)
        ROCArray(A::$S) = ROCArray{eltype(A),$N}(A)
    end
end

"""
    unsafe_free!(A::ROCCanonicalSparse)

Release all component buffers. The caller must own every buffer exclusively, with no
borrowed views, device representations or retained vendor analysis still using them.
Raw sparse constructors borrow storage, so this operation is not safe for arbitrary inputs.
"""
function AMDGPU.unsafe_free!(A::ROCCanonicalSparse)
    foreach(unsafe_free!, GPUArrays.sparse_buffers(A))
    return nothing
end

Base.size(A::ROCSparseMatrixBSR) = A.dims
Base.length(A::ROCSparseMatrixBSR) = prod(A.dims)
SparseArrays.nnz(A::ROCSparseMatrixBSR) = length(A.nzVal)

SparseArrays.nonzeros(A::ROCSparseMatrixBSR) = A.nzVal
Base.getindex(A::ROCSparseMatrixBSR,::Colon) = ROCSparseMatrixCSC(A)[:]
Base.getindex(A::ROCSparseMatrixBSR,I::AbstractRange{<:Integer}) = ROCSparseMatrixCSC(A)[:][I]
Base.getindex(A::ROCSparseMatrixBSR,I::Union{Integer,AbstractRange,Colon},J::Union{AbstractRange,Colon}) =
    ROCSparseMatrixCSR(A)[I,J]
Base.getindex(A::ROCSparseMatrixBSR,I::Union{AbstractRange,Colon},J::Integer) = ROCSparseMatrixCSC(A)[I,J]
Base.copy(A::ROCSparseMatrixBSR) = copyto!(similar(A),A)
ROCSparseMatrixBSR{T}(p::ROCVector,i::ROCVector,v::ROCVector,dims,b,dir,n) where {T} =
    ROCSparseMatrixBSR{T,eltype(i)}(p,i,v,dims,b,dir,n)
ROCSparseMatrixBSR(p::ROCVector,i::ROCVector,v::ROCVector{T},b,dir,n,dims) where {T} =
    ROCSparseMatrixBSR{T,eltype(i)}(p,i,v,dims,b,dir,n)
ROCSparseMatrixBSR{T,Ti}(A::ROCSparseMatrixBSR) where {T,Ti} =
    ROCSparseMatrixBSR{T,Ti}(ROCVector{Ti}(A.rowPtr),ROCVector{Ti}(A.colVal),ROCVector{T}(A.nzVal),
                             size(A),A.blockDim,A.dir,A.nnzb)
ROCSparseMatrixBSR{T}(A::ROCSparseMatrixBSR{<:Any,Ti}) where {T,Ti} = ROCSparseMatrixBSR{T,Ti}(A)
ROCSparseMatrixBSR{T,Ti}(A::SparseMatrixCSC,b) where {T,Ti} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T,Ti}(A),b)
ROCSparseMatrixBSR{T}(A::SparseMatrixCSC,b) where {T} = ROCSparseMatrixBSR{T,Cint}(A,b)
ROCSparseMatrixBSR(A::SparseMatrixCSC,b) = ROCSparseMatrixBSR{eltype(A),Cint}(A,b)
SparseArrays.SparseMatrixCSC(A::ROCSparseMatrixBSR) = SparseMatrixCSC(ROCSparseMatrixCSR(A))

Base.similar(Mat::ROCSparseMatrixBSR{Tv, Ti}) where {Tv, Ti} =
    ROCSparseMatrixBSR{Tv, Ti}(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat)), size(Mat), Mat.blockDim, Mat.dir, Mat.nnzb)

Base.similar(Mat::ROCSparseMatrixBSR{<:Any, Ti}, ::Type{T}) where {T, Ti} =
    ROCSparseMatrixBSR{T, Ti}(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat), T), size(Mat), Mat.blockDim, Mat.dir, Mat.nnzb)

Base.similar(Mat::ROCSparseMatrixBSR, ::Type{T}, ::Type{Ti}) where {T, Ti} =
    ROCSparseMatrixBSR{T, Ti}(copyto!(similar(Mat.rowPtr, Ti), Mat.rowPtr), copyto!(similar(Mat.colVal, Ti), Mat.colVal), similar(nonzeros(Mat), T), size(Mat), Mat.blockDim, Mat.dir, Mat.nnzb)

Base.similar(Mat::ROCSparseMatrixBSR{<:Any, Ti}, ::Type{T}, N::Int, M::Int) where {T, Ti} =
    ROCSparseMatrixBSR{T, Ti}(fill!(ROCVector{Ti}(undef, cld(N,Mat.blockDim)+1),one(Ti)), ROCVector{Ti}(undef,0), ROCVector{T}(undef,0), (N,M), Mat.blockDim, Mat.dir, 0)

Base.similar(Mat::ROCSparseMatrixBSR, ::Type{T}, ::Type{Ti}, N::Int, M::Int) where {T, Ti} =
    ROCSparseMatrixBSR{T, Ti}(fill!(ROCVector{Ti}(undef, cld(N,Mat.blockDim)+1),one(Ti)), ROCVector{Ti}(undef,0), ROCVector{T}(undef,0), (N,M), Mat.blockDim, Mat.dir, 0)

Base.similar(Mat::ROCSparseMatrixBSR{Tv}, N::Int, M::Int) where {Tv} = similar(Mat, Tv, N, M)

Base.similar(Mat::ROCSparseMatrixBSR, T::Type, dims::Tuple{Int, Int}) = similar(Mat, T, dims...)

Base.similar(Mat::ROCSparseMatrixBSR, T::Type, Ti::Type, dims::Tuple{Int, Int}) = similar(Mat, T, Ti, dims...)

Base.similar(Mat::ROCSparseMatrixBSR, dims::Tuple{Int, Int}) = similar(Mat, dims...)

function Base.copyto!(dst::ROCSparseMatrixBSR,src::ROCSparseMatrixBSR)
    dst === src && return dst
    size(dst)==size(src) || throw(ArgumentError("Inconsistent Sparse Matrix size"))
    buffers(A)=(A.rowPtr,A.colVal,A.nzVal)
    any(d -> any(s -> Base.mightalias(d,s),buffers(src)),buffers(dst)) &&
        (src=copy(src))
    Ti=eltype(dst.rowPtr)
    GPUArrays.check_sparse_dims(Ti,(cld(size(src,1),src.blockDim),cld(size(src,2),src.blockDim),Int(src.blockDim)))
    GPUArrays.check_sparse_nnz(Ti,src.nnzb)
    GPUArrays.check_sparse_values(eltype(dst),src.nzVal)
    # Convert every input before any destination resize or write.
    p=GPUArrays.convert_index_buffer(Ti,src.rowPtr)
    i=GPUArrays.convert_index_buffer(eltype(dst.colVal),src.colVal)
    v=GPUArrays.convert_buffer(eltype(dst),src.nzVal)
    GPUArrays.replace_buffer!(dst.rowPtr,p)
    GPUArrays.replace_buffer!(dst.colVal,i)
    GPUArrays.replace_buffer!(dst.nzVal,v)
    dst.blockDim=src.blockDim
    dst.dir=src.dir
    dst.nnzb=src.nnzb
    return dst
end


function Base.getindex(A::ROCSparseMatrixBSR{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    i0_block, i0_idx = fldmod1(i0, A.blockDim)
    i1_block, i1_idx = fldmod1(i1, A.blockDim)
    block_idx = A.dir == 'R' ? (i0_idx-1)*A.blockDim+i1_idx : (i1_idx-1)*A.blockDim+i0_idx
    c1 = Int(A.rowPtr[i0_block])
    c2 = Int(A.rowPtr[i0_block+1]-1)
    result = zero(T)
    for k in c1:c2
        if A.colVal[k] == i1_block
            value = nonzeros(A)[(k-1)*A.blockDim*A.blockDim+block_idx]
            result = T === Bool ? result | value : result + value
        end
    end
    return result
end

# matrix slices

# Vendor-only device representations remain backend owned.
struct ROCSparseDeviceMatrixBSR{Tv,Ti,Vi,Vv} <: SparseArrays.AbstractSparseMatrix{Tv,Ti}
    rowPtr::Vi
    colVal::Vi
    nzVal::Vv
    dims::Dims{2}
    blockDim::Ti
    dir::Char
    nnz::Ti
end
Base.size(A::ROCSparseDeviceMatrixBSR) = A.dims
SparseArrays.nnz(A::ROCSparseDeviceMatrixBSR) = length(A.nzVal)
SparseArrays.nonzeros(A::ROCSparseDeviceMatrixBSR) = A.nzVal
function Adapt.adapt_structure(to::AMDGPU.Runtime.Adaptor,A::ROCSparseMatrixBSR{T,Ti}) where {T,Ti}
    p,i,v = adapt(to,A.rowPtr),adapt(to,A.colVal),adapt(to,A.nzVal)
    ROCSparseDeviceMatrixBSR{T,Ti,typeof(p),typeof(v)}(p,i,v,size(A),A.blockDim,A.dir,A.nnzb)
end

# BSR transfers go through the canonical CSR converter; never iterate device scalars.
Base.Array(A::ROCSparseMatrixBSR) = Array(ROCSparseMatrixCSR(A))
Base.collect(A::ROCSparseMatrixBSR) = Array(A)
AMDGPU.ROCArray(A::ROCSparseMatrixBSR) = ROCArray(ROCSparseMatrixCSR(A))
AMDGPU.ROCArray{T}(A::ROCSparseMatrixBSR) where {T} = ROCArray{T}(ROCSparseMatrixCSR(A))
Adapt.adapt_structure(::Type{Array}, A::ROCSparseMatrixBSR) = SparseMatrixCSC(A)
