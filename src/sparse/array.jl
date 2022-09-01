# custom extension of ROCArray in ROCM for sparse vectors/matrices
# using CSC format for interop with Julia's native sparse functionality

export ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR, ROCSparseMatrixCOO,
       ROCSparseMatrix, AbstractROCSparseMatrix,
       ROCSparseVector,
       ROCSparseVecOrMat

using LinearAlgebra: BlasFloat
using SparseArrays: nonzeroinds, dimlub

abstract type AbstractROCSparseArray{Tv, Ti, N} <: AbstractSparseArray{Tv, Ti, N} end
const AbstractROCSparseVector{Tv, Ti} = AbstractROCSparseArray{Tv, Ti, 1}
const AbstractROCSparseMatrix{Tv, Ti} = AbstractROCSparseArray{Tv, Ti, 2}

Base.convert(T::Type{<:AbstractROCSparseArray}, m::AbstractArray) = m isa T ? m : T(m)

mutable struct ROCSparseVector{Tv, Ti} <: AbstractROCSparseVector{Tv, Ti}
    iPtr::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    len::Int
    nnz::Ti

    function ROCSparseVector{Tv, Ti}(iPtr::ROCVector{<:Integer}, nzVal::ROCVector,
                                     len::Integer) where {Tv, Ti <: Integer}
        new{Tv, Ti}(iPtr, nzVal, len, length(nzVal))
    end
end

function AMDGPU.unsafe_free!(xs::ROCSparseVector)
    unsafe_free!(nonzeroinds(xs))
    unsafe_free!(nonzeros(xs))
    return
end

mutable struct ROCSparseMatrixCSC{Tv, Ti} <: AbstractROCSparseMatrix{Tv, Ti}
    colPtr::ROCVector{Ti}
    rowVal::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Ti

    function ROCSparseMatrixCSC{Tv, Ti}(colPtr::ROCVector{<:Integer}, rowVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,<:Integer}) where {Tv, Ti <: Integer}
        new{Tv, Ti}(colPtr, rowVal, nzVal, dims, length(nzVal))
    end
end

ROCSparseMatrixCSC(A::ROCSparseMatrixCSC) = A

function AMDGPU.unsafe_free!(xs::ROCSparseMatrixCSC)
    unsafe_free!(xs.colPtr)
    unsafe_free!(rowvals(xs))
    unsafe_free!(nonzeros(xs))
    return
end

"""
    ROCSparseMatrixCSR{Tv, Ti} <: AbstractROCSparseMatrix{Tv, Ti}

Container to hold sparse matrices in compressed sparse row (CSR) format on the
GPU.

!!! note
    Most ROCSPARSE operations work with CSR formatted matrices, rather
    than CSC.
"""
mutable struct ROCSparseMatrixCSR{Tv, Ti} <: AbstractROCSparseMatrix{Tv, Ti}
    rowPtr::ROCVector{Ti}
    colVal::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Ti

    function ROCSparseMatrixCSR{Tv, Ti}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,Int}) where {Tv, Ti<:Integer}
        new{Tv, Ti}(rowPtr, colVal, nzVal, dims, length(nzVal))
    end
end

ROCSparseMatrixCSR(A::ROCSparseMatrixCSR) = A

function AMDGPU.unsafe_free!(xs::ROCSparseMatrixCSR)
    unsafe_free!(xs.rowPtr)
    unsafe_free!(xs.colVal)
    unsafe_free!(nonzeros(xs))
    return
end

"""
Container to hold sparse matrices in block compressed sparse row (BSR) format on
the GPU. BSR format is also used in Intel MKL, and is suited to matrices that are
"block" sparse - rare blocks of non-sparse regions.
"""
mutable struct ROCSparseMatrixBSR{Tv, Ti} <: AbstractROCSparseMatrix{Tv, Ti}
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

"""
Container to hold sparse matrices in coordinate (COO) format on the GPU. COO
format is mainly useful to initially construct sparse matrices, afterwards
switch to [`ROCSparseMatrixCSR`](@ref) for more functionality.
"""
mutable struct ROCSparseMatrixCOO{Tv, Ti} <: AbstractROCSparseMatrix{Tv, Ti}
    rowInd::ROCVector{Ti}
    colInd::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Ti

    function ROCSparseMatrixCOO{Tv, Ti}(rowInd::ROCVector{<:Integer}, colInd::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,Int}=(dimlub(rowInd),dimlub(colInd)),
                                   nnz::Integer=length(nzVal)) where {Tv, Ti}
        new{Tv, Ti}(rowInd,colInd,nzVal,dims,nnz)
    end
end

ROCSparseMatrixCOO(A::ROCSparseMatrixCOO) = A

"""
Utility union type of [`ROCSparseMatrixCSC`](@ref), [`ROCSparseMatrixCSR`](@ref),
[`ROCSparseMatrixBSR`](@ref), [`ROCSparseMatrixCOO`](@ref).
"""
const ROCSparseMatrix{Tv, Ti} = Union{
    ROCSparseMatrixCSC{Tv, Ti},
    ROCSparseMatrixCSR{Tv, Ti},
    ROCSparseMatrixBSR{Tv, Ti},
    ROCSparseMatrixCOO{Tv, Ti}
}

const ROCSparseVecOrMat = Union{ROCSparseVector, ROCSparseMatrix}


# NOTE: we use Cint as default Ti on CUDA instead of Int to provide
# maximum compatiblity to old CUSPARSE APIs
# The same pattern was followed for AMDGPU as well
function ROCSparseVector{Tv}(iPtr::ROCVector{<:Integer}, nzVal::ROCVector, len::Integer) where {Tv}
    ROCSparseVector{Tv, Cint}(convert(ROCVector{Cint}, iPtr), nzVal, len)
end

function ROCSparseMatrixCSC{Tv}(colPtr::ROCVector{<:Integer}, rowVal::ROCVector{<:Integer},
                               nzVal::ROCVector, dims::NTuple{2,<:Integer}) where {Tv}
    ROCSparseMatrixCSC{Tv, Cint}(colPtr, rowVal, nzVal, dims)
end

function ROCSparseMatrixCSR{Tv}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                               nzVal::ROCVector, dims::NTuple{2,Int}) where {Tv}
    ROCSparseMatrixCSR{Tv, Cint}(rowPtr, colVal, nzVal, dims)
end

function ROCSparseMatrixBSR{Tv}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                               nzVal::ROCVector, dims::NTuple{2,<:Integer},
                               blockDim::Integer, dir::SparseChar, nnz::Integer) where {Tv}
    ROCSparseMatrixBSR{Tv, Cint}(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)
end

function ROCSparseMatrixCOO{Tv}(rowInd::ROCVector{<:Integer}, colInd::ROCVector{<:Integer},
                               nzVal::ROCVector, dims::NTuple{2,Int}=(dimlub(rowInd),dimlub(colInd)),
                               nnz::Integer=length(nzVal)) where {Tv}
    ROCSparseMatrixCOO{Tv, Cint}(rowInd,colInd,nzVal,dims,nnz)
end

## convenience constructors
ROCSparseVector(iPtr::DenseROCArray{<:Integer}, nzVal::DenseROCArray{T}, len::Integer) where {T} =
    ROCSparseVector{T}(iPtr, nzVal, len)

ROCSparseMatrixCSC(colPtr::DenseROCArray{<:Integer}, rowVal::DenseROCArray{<:Integer},
                  nzVal::DenseROCArray{T}, dims::NTuple{2,Int}) where {T} =
    ROCSparseMatrixCSC{T}(colPtr, rowVal, nzVal, dims)

ROCSparseMatrixCSR(rowPtr::DenseROCArray, colVal::DenseROCArray, nzVal::DenseROCArray{T}, dims::NTuple{2,Int}) where T =
    ROCSparseMatrixCSR{T}(rowPtr, colVal, nzVal, dims)

ROCSparseMatrixBSR(rowPtr::DenseROCArray, colVal::DenseROCArray, nzVal::DenseROCArray{T}, blockDim, dir, nnz,
                  dims::NTuple{2,Int}) where T =
    ROCSparseMatrixBSR{T}(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)

ROCSparseMatrixCOO(rowInd::DenseROCArray, colInd::DenseROCArray, nzVal::DenseROCArray{T}, dims::NTuple{2,Int}, nnz) where T =
    ROCSparseMatrixCOO{T}(rowInd, colInd, nzVal, dims, nnz)

Base.similar(Vec::ROCSparseVector) = ROCSparseVector(copy(nonzeroinds(Vec)), similar(nonzeros(Vec)), length(Vec))
Base.similar(Mat::ROCSparseMatrixCSC) = ROCSparseMatrixCSC(copy(Mat.colPtr), copy(rowvals(Mat)), similar(nonzeros(Mat)), size(Mat))
Base.similar(Mat::ROCSparseMatrixCSR) = ROCSparseMatrixCSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat)), size(Mat))
Base.similar(Mat::ROCSparseMatrixBSR) = ROCSparseMatrixBSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat)), Mat.blockDim, Mat.dir, nnz(Mat), size(Mat))
Base.similar(Mat::ROCSparseMatrixCOO) = ROCSparseMatrixCOO(copy(Mat.rowInd), copy(Mat.colInd), similar(nonzeros(Mat)), size(Mat), nnz(Mat))

Base.similar(Vec::ROCSparseVector, T::Type) = ROCSparseVector(copy(nonzeroinds(Vec)), similar(nonzeros(Vec), T), length(Vec))
Base.similar(Mat::ROCSparseMatrixCSC, T::Type) = ROCSparseMatrixCSC(copy(Mat.colPtr), copy(rowvals(Mat)), similar(nonzeros(Mat), T), size(Mat))
Base.similar(Mat::ROCSparseMatrixCSR, T::Type) = ROCSparseMatrixCSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat), T), size(Mat))
Base.similar(Mat::ROCSparseMatrixBSR, T::Type) = ROCSparseMatrixBSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat), T), Mat.blockDim, Mat.dir, nnz(Mat), size(Mat))
Base.similar(Mat::ROCSparseMatrixCOO, T::Type) = ROCSparseMatrixCOO(copy(Mat.rowInd), copy(Mat.colInd), similar(nonzeros(Mat), T), size(Mat), nnz(Mat))


## array interface

Base.length(g::ROCSparseVector) = g.len
Base.size(g::ROCSparseVector) = (g.len,)
Base.ndims(g::ROCSparseVector) = 1

Base.length(g::ROCSparseMatrix) = prod(g.dims)
Base.size(g::ROCSparseMatrix) = g.dims
Base.ndims(g::ROCSparseMatrix) = 2

function Base.size(g::ROCSparseVector, d::Integer)
    if d == 1
        return g.len
    elseif d > 1
        return 1
    else
        throw(ArgumentError("dimension must be ≥ 1, got $d"))
    end
end

function Base.size(g::ROCSparseMatrix, d::Integer)
    if 1 <= d <= 2
        return g.dims[d]
    elseif d > 1
        return 1
    else
        throw(ArgumentError("dimension must be ≥ 1, got $d"))
    end
end

Base.eltype(g::ROCSparseMatrix{T}) where T = T


## sparse array interface

SparseArrays.nnz(g::AbstractROCSparseArray) = g.nnz
SparseArrays.nonzeros(g::AbstractROCSparseArray) = g.nzVal

SparseArrays.nonzeroinds(g::AbstractROCSparseVector) = g.iPtr

SparseArrays.rowvals(g::ROCSparseMatrixCSC) = g.rowVal

LinearAlgebra.issymmetric(M::Union{ROCSparseMatrixCSC,ROCSparseMatrixCSR}) = false
LinearAlgebra.ishermitian(M::Union{ROCSparseMatrixCSC,ROCSparseMatrixCSR}) = false
LinearAlgebra.issymmetric(M::Symmetric{ROCSparseMatrixCSC}) = true
LinearAlgebra.ishermitian(M::Hermitian{ROCSparseMatrixCSC}) = true

LinearAlgebra.istriu(M::UpperTriangular{T,S}) where {T<:BlasFloat, S<:AbstractROCSparseMatrix} = true
LinearAlgebra.istril(M::UpperTriangular{T,S}) where {T<:BlasFloat, S<:AbstractROCSparseMatrix} = false
LinearAlgebra.istriu(M::LowerTriangular{T,S}) where {T<:BlasFloat, S<:AbstractROCSparseMatrix} = false
LinearAlgebra.istril(M::LowerTriangular{T,S}) where {T<:BlasFloat, S<:AbstractROCSparseMatrix} = true

Hermitian{T}(Mat::ROCSparseMatrix{T}) where T = Hermitian{T,typeof(Mat)}(Mat,'U')

SparseArrays.nnz(g::ROCSparseMatrixBSR) = g.nnzb * g.blockDim * g.blockDim


## indexing

# translations
Base.getindex(A::AbstractROCSparseVector, ::Colon)          = copy(A)
Base.getindex(A::AbstractROCSparseMatrix, ::Colon, ::Colon) = copy(A)
Base.getindex(A::AbstractROCSparseMatrix, i, ::Colon)       = getindex(A, i, 1:size(A, 2))
Base.getindex(A::AbstractROCSparseMatrix, ::Colon, i)       = getindex(A, 1:size(A, 1), i)
Base.getindex(A::AbstractROCSparseMatrix, I::Tuple{Integer,Integer}) = getindex(A, I[1], I[2])

# column slices
function Base.getindex(x::ROCSparseMatrixCSC, ::Colon, j::Integer)
    checkbounds(x, :, j)
    r1 = convert(Int, x.colPtr[j])
    r2 = convert(Int, x.colPtr[j+1]) - 1
    ROCSparseVector(rowvals(x)[r1:r2], nonzeros(x)[r1:r2], size(x, 1))
end

function Base.getindex(x::ROCSparseMatrixCSR, i::Integer, ::Colon)
    checkbounds(x, i, :)
    c1 = convert(Int, x.rowPtr[i])
    c2 = convert(Int, x.rowPtr[i+1]) - 1
    ROCSparseVector(x.colVal[c1:c2], nonzeros(x)[c1:c2], size(x, 2))
end

# row slices
Base.getindex(A::ROCSparseMatrixCSC, i::Integer, ::Colon) = ROCSparseVector(sparse(A[i, 1:end]))  # TODO: optimize
Base.getindex(A::ROCSparseMatrixCSR, ::Colon, j::Integer) = ROCSparseVector(sparse(A[1:end, j]))  # TODO: optimize

function Base.getindex(A::ROCSparseVector{Tv, Ti}, i::Integer) where {Tv, Ti}
    @boundscheck checkbounds(A, i)
    ii = searchsortedfirst(A.iPtr, convert(Ti, i))
    (ii > nnz(A) || A.iPtr[ii] != i) && return zero(Tv)
    A.nzVal[ii]
end

function Base.getindex(A::ROCSparseMatrixCSC{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    r1 = Int(A.colPtr[i1])
    r2 = Int(A.colPtr[i1+1]-1)
    (r1 > r2) && return zero(T)
    r1 = searchsortedfirst(rowvals(A), i0, r1, r2, Base.Order.Forward)
    (r1 > r2 || rowvals(A)[r1] != i0) && return zero(T)
    nonzeros(A)[r1]
end

function Base.getindex(A::ROCSparseMatrixCSR{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    c1 = Int(A.rowPtr[i0])
    c2 = Int(A.rowPtr[i0+1]-1)
    (c1 > c2) && return zero(T)
    c1 = searchsortedfirst(A.colVal, i1, c1, c2, Base.Order.Forward)
    (c1 > c2 || A.colVal[c1] != i1) && return zero(T)
    nonzeros(A)[c1]
end

function Base.getindex(A::ROCSparseMatrixCOO{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    r1 = searchsortedfirst(A.rowInd, i0, Base.Order.Forward)
    (r1 > length(A.rowInd) || A.rowInd[r1] > i0) && return zero(T)
    r2 = searchsortedfirst(A.rowInd, i0+1, Base.Order.Forward)
    c1 = searchsortedfirst(A.colInd, i1, r1, r2, Base.Order.Forward)
    (c1 > r2 || A.colInd[c1] > i1) && return zero(T)
    nonzeros(A)[c1]
end

function Base.getindex(A::ROCSparseMatrixBSR{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    i0_block, i0_idx = fldmod1(i0, A.blockDim)
    i1_block, i1_idx = fldmod1(i1, A.blockDim)
    block_idx = (i0_idx - 1) * A.blockDim + i1_idx - 1
    c1 = Int(A.rowPtr[i0_block])
    c2 = Int(A.rowPtr[i0_block+1]-1)
    (c1 > c2) && return zero(T)
    c1 = searchsortedfirst(A.colVal, i1_block, c1, c2, Base.Order.Forward)
    (c1 > c2 || A.colVal[c1] != i1_block) && return zero(T)
    nonzeros(A)[c1+block_idx]
end


## interop with sparse CPU arrays

# cpu to gpu
# NOTE: we eagerly convert the indices to Cint here to avoid additional conversion later on
ROCSparseVector{T}(Vec::SparseVector) where {T} =
    ROCSparseVector(ROCVector{Cint}(Vec.nzind), ROCVector{T}(Vec.nzval), length(Vec))
ROCSparseVector{T}(Mat::SparseMatrixCSC) where {T} =
    size(Mat,2) == 1 ?
        ROCSparseVector(ROCVector{Cint}(Mat.rowval), ROCVector{T}(Mat.nzval), size(Mat)[1]) :
        throw(ArgumentError("The input argument must have a single column"))
ROCSparseMatrixCSC{T}(Vec::SparseVector) where {T} =
    ROCSparseMatrixCSC{T}(ROCVector{Cint}([1]), ROCVector{Cint}(Vec.nzind),
                         ROCVector{T}(Vec.nzval), size(Vec))
ROCSparseMatrixCSC{T}(Mat::SparseMatrixCSC) where {T} =
    ROCSparseMatrixCSC{T}(ROCVector{Cint}(Mat.colptr), ROCVector{Cint}(Mat.rowval),
                         ROCVector{T}(Mat.nzval), size(Mat))
ROCSparseMatrixCSR{T}(Mat::Transpose{Tv, <:SparseMatrixCSC}) where {T, Tv} =
    ROCSparseMatrixCSR{T}(ROCVector{Cint}(parent(Mat).colptr), ROCVector{Cint}(parent(Mat).rowval),
                         ROCVector{T}(parent(Mat).nzval), size(Mat))
ROCSparseMatrixCSR{T}(Mat::Adjoint{Tv, <:SparseMatrixCSC}) where {T, Tv} =
    ROCSparseMatrixCSR{T}(ROCVector{Cint}(parent(Mat).colptr), ROCVector{Cint}(parent(Mat).rowval),
                         ROCVector{T}(conj.(parent(Mat).nzval)), size(Mat))
ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSC) where {T} = ROCSparseMatrixCSR(ROCSparseMatrixCSC{T}(Mat))
ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSC, blockdim) where {T} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(Mat), blockdim)
ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSC) where {T} = ROCSparseMatrixCOO(ROCSparseMatrixCSR{T}(Mat))

# untyped variants
ROCSparseVector(x::AbstractSparseArray{T}) where {T} = ROCSparseVector{T}(x)
ROCSparseMatrixCSC(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCSC{T}(x)
ROCSparseMatrixCSR(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCSR{T}(x)
ROCSparseMatrixBSR(x::AbstractSparseArray{T}, blockdim) where {T} = ROCSparseMatrixBSR{T}(x, blockdim)
ROCSparseMatrixCOO(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCOO{T}(x)
ROCSparseMatrixCSR(x::Transpose{T}) where {T} = ROCSparseMatrixCSR{T}(x)
ROCSparseMatrixCSR(x::Adjoint{T}) where {T} = ROCSparseMatrixCSR{T}(x)
ROCSparseMatrixCSC(x::Transpose{T}) where {T} = ROCSparseMatrixCSC{T}(x)
ROCSparseMatrixCSC(x::Adjoint{T}) where {T} = ROCSparseMatrixCSC{T}(x)

# gpu to cpu
SparseVector(x::ROCSparseVector) = SparseVector(length(x), Array(nonzeroinds(x)), Array(nonzeros(x)))
SparseMatrixCSC(x::ROCSparseMatrixCSC) = SparseMatrixCSC(size(x)..., Array(x.colPtr), Array(rowvals(x)), Array(nonzeros(x)))
SparseMatrixCSC(x::ROCSparseMatrixCSR) = SparseMatrixCSC(ROCSparseMatrixCSC(x))  # no direct conversion
SparseMatrixCSC(x::ROCSparseMatrixBSR) = SparseMatrixCSC(ROCSparseMatrixCSR(x))  # no direct conversion
SparseMatrixCSC(x::ROCSparseMatrixCOO) = SparseMatrixCSC(ROCSparseMatrixCSR(x))  # no direct conversion

# collect to Array
Base.collect(x::ROCSparseVector) = collect(SparseVector(x))
Base.collect(x::ROCSparseMatrixCSC) = collect(SparseMatrixCSC(x))
Base.collect(x::ROCSparseMatrixCSR) = collect(SparseMatrixCSC(x))
Base.collect(x::ROCSparseMatrixBSR) = collect(ROCSparseMatrixCSR(x))  # no direct conversion
Base.collect(x::ROCSparseMatrixCOO) = collect(ROCSparseMatrixCSR(x))  # no direct conversion

Adapt.adapt_storage(::Type{ROCArray}, xs::SparseVector) = ROCSparseVector(xs)
Adapt.adapt_storage(::Type{ROCArray}, xs::SparseMatrixCSC) = ROCSparseMatrixCSC(xs)
Adapt.adapt_storage(::Type{ROCArray{T}}, xs::SparseVector) where {T} = ROCSparseVector{T}(xs)
Adapt.adapt_storage(::Type{ROCArray{T}}, xs::SparseMatrixCSC) where {T} = ROCSparseMatrixCSC{T}(xs)

Adapt.adapt_storage(::AMDGPU.Float32Adaptor, xs::AbstractSparseArray) =
  adapt(ROCArray, xs)
Adapt.adapt_storage(::AMDGPU.Float32Adaptor, xs::AbstractSparseArray{<:AbstractFloat}) =
  adapt(ROCArray{Float32}, xs)

Adapt.adapt_storage(::Type{Array}, xs::ROCSparseVector) = SparseVector(xs)
Adapt.adapt_storage(::Type{Array}, xs::ROCSparseMatrixCSC) = SparseMatrixCSC(xs)


## copying between sparse GPU arrays

function Base.copyto!(dst::ROCSparseVector, src::ROCSparseVector)
    if length(dst) != length(src)
        throw(ArgumentError("Inconsistent Sparse Vector size"))
    end
    copyto!(nonzeroinds(dst), nonzeroinds(src))
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = src.nnz
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCSC, src::ROCSparseMatrixCSC)
    if size(dst) != size(src)
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.colPtr, src.colPtr)
    copyto!(rowvals(dst), rowvals(src))
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = src.nnz
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCSR, src::ROCSparseMatrixCSR)
    if size(dst) != size(src)
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowPtr, src.rowPtr)
    copyto!(dst.colVal, src.colVal)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = src.nnz
    dst
end

function Base.copyto!(dst::ROCSparseMatrixBSR, src::ROCSparseMatrixBSR)
    if size(dst) != size(src)
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowPtr, src.rowPtr)
    copyto!(dst.colVal, src.colVal)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.dir = src.dir
    dst.nnzb = src.nnzb
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCOO, src::ROCSparseMatrixCOO)
    if size(dst) != size(src)
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowInd, src.rowInd)
    copyto!(dst.colInd, src.colInd)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = src.nnz
    dst
end

Base.copy(Vec::ROCSparseVector) = copyto!(similar(Vec), Vec)
Base.copy(Mat::ROCSparseMatrixCSC) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixCSR) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixBSR) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixCOO) = copyto!(similar(Mat), Mat)


# input/output

for (gpu, cpu) in [ROCSparseVector => SparseVector]
    @eval function Base.show(io::IO, ::MIME"text/plain", x::$gpu)
        xnnz = length(nonzeros(x))
        print(io, length(x), "-element ", typeof(x), " with ", xnnz,
            " stored ", xnnz == 1 ? "entry" : "entries")
        if xnnz != 0
            println(io, ":")
            show(IOContext(io, :typeinfo => eltype(x)), $cpu(x))
        end
    end
end

for (gpu, cpu) in [ROCSparseMatrixCSC => SparseMatrixCSC,
                   ROCSparseMatrixCSR => SparseMatrixCSC,
                   ROCSparseMatrixBSR => SparseMatrixCSC,
                   ROCSparseMatrixCOO => SparseMatrixCSC]
    @eval Base.show(io::IOContext, x::$gpu) =
        show(io, $cpu(x))

    @eval function Base.show(io::IO, mime::MIME"text/plain", S::$gpu)
        xnnz = nnz(S)
        m, n = size(S)
        print(io, m, "×", n, " ", typeof(S), " with ", xnnz, " stored ",
                  xnnz == 1 ? "entry" : "entries")
        if !(m == 0 || n == 0)
            println(io, ":")
            io = IOContext(io, :typeinfo => eltype(S))
            if ndims(S) == 1
                show(io, $cpu(S))
            else
                # so that we get the nice Braille pattern
                Base.print_array(io, $cpu(S))
            end
        end
    end
end


# interop with device arrays

function Adapt.adapt_structure(to::AMDGPU.Adaptor, x::ROCSparseVector)
    return ROCSparseDeviceVector(
        adapt(to, x.iPtr),
        adapt(to, x.nzVal),
        length(x), x.nnz
    )
end

function Adapt.adapt_structure(to::AMDGPU.Adaptor, x::ROCSparseMatrixCSR)
    return ROCSparseDeviceMatrixCSR(
        adapt(to, x.rowPtr),
        adapt(to, x.colVal),
        adapt(to, x.nzVal),
        size(x), x.nnz
    )
end

function Adapt.adapt_structure(to::AMDGPU.Adaptor, x::ROCSparseMatrixCSC)
    return ROCSparseDeviceMatrixCSC(
        adapt(to, x.colPtr),
        adapt(to, x.rowVal),
        adapt(to, x.nzVal),
        size(x), x.nnz
    )
end

function Adapt.adapt_structure(to::AMDGPU.Adaptor, x::ROCSparseMatrixBSR)
    return ROCSparseDeviceMatrixBSR(
        adapt(to, x.rowPtr),
        adapt(to, x.colVal),
        adapt(to, x.nzVal),
        size(x), x.blockDim,
        x.dir, x.nnzb
    )
end

function Adapt.adapt_structure(to::AMDGPU.Adaptor, x::ROCSparseMatrixCOO)
    return ROCSparseDeviceMatrixCOO(
        adapt(to, x.rowInd),
        adapt(to, x.colInd),
        adapt(to, x.nzVal),
        size(x), x.nnz
    )
end
