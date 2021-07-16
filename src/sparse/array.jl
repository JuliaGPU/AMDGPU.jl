export ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR, ROCSparseMatrixCOO,
       ROCSparseMatrix, AbstractROCSparseMatrix,
       ROCSparseVector

const DenseROCArray = ROCArray
using LinearAlgebra: BlasFloat
# using SparseArrays: nonzeroinds, dimlub
using SparseArrays

abstract type AbstractROCSparseArray{Tv, N} <: AbstractSparseArray{Tv, Cint, N} end
const AbstractROCSparseVector{Tv} = AbstractROCSparseArray{Tv,1}
const AbstractROCSparseMatrix{Tv} = AbstractROCSparseArray{Tv,2}

Base.convert(T::Type{<:AbstractROCSparseArray}, m::AbstractArray) = m isa T ? m : T(m)

mutable struct ROCSparseVector{Tv} <: AbstractROCSparseVector{Tv}
    iPtr::ROCVector{Cint}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Cint

    function ROCSparseVector{Tv}(iPtr::ROCVector{<:Integer}, nzVal::ROCVector,
                                dims::Integer) where Tv
        new(iPtr, nzVal, (dims,1), length(nzVal))
    end
end

# function CUDA.unsafe_free!(xs::ROCSparseVector)
#     unsafe_free!(nonzeroinds(xs))
#     unsafe_free!(nonzeros(xs))
#     return
# end

mutable struct ROCSparseMatrixCSC{Tv} <: AbstractROCSparseMatrix{Tv}
    colPtr::ROCVector{Cint}
    rowVal::ROCVector{Cint}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Cint

    function ROCSparseMatrixCSC{Tv}(colPtr::ROCVector{<:Integer}, rowVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,<:Integer}) where Tv
        new(colPtr, rowVal, nzVal, dims, length(nzVal))
    end
end

# function CUDA.unsafe_free!(xs::ROCSparseMatrixCSC)
#     unsafe_free!(xs.colPtr)
#     unsafe_free!(rowvals(xs))
#     unsafe_free!(nonzeros(xs))
#     return
# end

"""
Container to hold sparse matrices in compressed sparse row (CSR) format on the
GPU.
**Note**: Most CUSPARSE operations work with CSR formatted matrices, rather
than CSC.
"""
mutable struct ROCSparseMatrixCSR{Tv} <: AbstractROCSparseMatrix{Tv}
    rowPtr::ROCVector{Cint}
    colVal::ROCVector{Cint}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Cint

    function ROCSparseMatrixCSR{Tv}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,<:Integer}) where Tv
        new(rowPtr, colVal, nzVal, dims, length(nzVal))
    end
end

# function CUDA.unsafe_free!(xs::ROCSparseMatrixCSR)
#     unsafe_free!(xs.rowPtr)
#     unsafe_free!(xs.colVal)
#     unsafe_free!(nonzeros(xs))
#     return
# end

"""
Container to hold sparse matrices in block compressed sparse row (BSR) format on
the GPU. BSR format is also used in Intel MKL, and is suited to matrices that are
"block" sparse - rare blocks of non-sparse regions.
"""
mutable struct ROCSparseMatrixBSR{Tv} <: AbstractROCSparseMatrix{Tv}
    rowPtr::ROCVector{Cint}
    colVal::ROCVector{Cint}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    blockDim::Cint
    dir::rocsparse_direction
    nnz::Cint

    function ROCSparseMatrixBSR{Tv}(rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
                                   nzVal::ROCVector, dims::NTuple{2,<:Integer},
                                   blockDim::Integer, dir::rocsparse_direction, nnz::Integer) where Tv
        new(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)
    end
end

# function CUDA.unsafe_free!(xs::ROCSparseMatrixBSR)
#     unsafe_free!(xs.rowPtr)
#     unsafe_free!(xs.colVal)
#     unsafe_free!(nonzeros(xs))
#     return
# end

"""
Container to hold sparse matrices in coordinate (COO) format on the GPU. COO
format is mainly useful to initially construct sparse matrices, afterwards
switch to [`ROCSparseMatrixCSR`](@ref) for more functionality.
"""
mutable struct ROCSparseMatrixCOO{Tv} <: AbstractROCSparseMatrix{Tv}
    rowInd::ROCVector{Cint}
    colInd::ROCVector{Cint}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    nnz::Cint

    function ROCSparseMatrixCOO{Tv}(rowInd::ROCVector{Cint}, colInd::ROCVector{Cint},
                                   nzVal::ROCVector{Tv}, dims::NTuple{2,Int}=(dimlub(rowInd),dimlub(colInd)),
                                   nnz::Cint=Cint(length(nzVal))) where Tv
        new(rowInd,colInd,nzVal,dims,nnz)
    end
end

"""
Utility union type of [`ROCSparseMatrixCSC`](@ref), [`ROCSparseMatrixCSR`](@ref),
[`ROCSparseMatrixBSR`](@ref), [`ROCSparseMatrixCOO`](@ref).
"""
const ROCSparseMatrix{T} = Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T}, ROCSparseMatrixBSR{T}, ROCSparseMatrixCOO{T}}


## convenience constructors

ROCSparseVector(iPtr::DenseROCArray{<:Integer}, nzVal::DenseROCArray{T}, dims::Int) where {T} =
    ROCSparseVector{T}(iPtr, nzVal, dims)

ROCSparseMatrixCSC(colPtr::DenseROCArray{<:Integer}, rowVal::DenseROCArray{<:Integer},
                  nzVal::DenseROCArray{T}, dims::NTuple{2,Int}) where {T} =
    ROCSparseMatrixCSC{T}(colPtr, rowVal, nzVal, dims)

ROCSparseMatrixCSR(rowPtr::DenseROCArray, colVal::DenseROCArray, nzVal::DenseROCArray{T}, dims::NTuple{2,Int}) where T =
    ROCSparseMatrixCSR{T}(rowPtr, colVal, nzVal, dims)

ROCSparseMatrixBSR(rowPtr::DenseROCArray, colVal::DenseROCArray, nzVal::DenseROCArray{T}, blockDim, dir, nnz,
                  dims::NTuple{2,Int}) where T =
    ROCSparseMatrixBSR{T}(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)

Base.similar(Vec::ROCSparseVector) = ROCSparseVector(copy(nonzeroinds(Vec)), similar(nonzeros(Vec)), Vec.dims[1])
Base.similar(Mat::ROCSparseMatrixCSC) = ROCSparseMatrixCSC(copy(Mat.colPtr), copy(rowvals(Mat)), similar(nonzeros(Mat)), Mat.dims)
Base.similar(Mat::ROCSparseMatrixCSR) = ROCSparseMatrixCSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat)), Mat.dims)
Base.similar(Mat::ROCSparseMatrixBSR) = ROCSparseMatrixBSR(copy(Mat.rowPtr), copy(Mat.colVal), similar(nonzeros(Mat)), Mat.blockDim, Mat.dir, nnz(Mat), Mat.dims)


## array interface

Base.length(g::ROCSparseVector) = prod(g.dims)
Base.size(g::ROCSparseVector) = g.dims
Base.ndims(g::ROCSparseVector) = 1

Base.length(g::ROCSparseMatrix) = prod(g.dims)
Base.size(g::ROCSparseMatrix) = g.dims
Base.ndims(g::ROCSparseMatrix) = 2

function Base.size(g::ROCSparseVector, d::Integer)
    if d == 1
        return g.dims[d]
    elseif d > 1
        return 1
    else
        throw(ArgumentError("dimension must be ≥ 1, got $d"))
    end
end

function Base.size(g::ROCSparseMatrix, d::Integer)
    if d in [1, 2]
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

function Base.getindex(A::ROCSparseMatrixCSC{T}, i0::Integer, i1::Integer) where T
    m, n = size(A)
    if !(1 <= i0 <= m && 1 <= i1 <= n)
        throw(BoundsError())
    end
    r1 = Int(A.colPtr[i1])
    r2 = Int(A.colPtr[i1+1]-1)
    (r1 > r2) && return zero(T)
    r1 = searchsortedfirst(rowvals(A), i0, r1, r2, Base.Order.Forward)
    ((r1 > r2) || (rowvals(A)[r1] != i0)) ? zero(T) : nonzeros(A)[r1]
end

function Base.getindex(A::ROCSparseMatrixCSR{T}, i0::Integer, i1::Integer) where T
    m, n = size(A)
    if !(1 <= i0 <= m && 1 <= i1 <= n)
        throw(BoundsError())
    end
    c1 = Int(A.rowPtr[i0])
    c2 = Int(A.rowPtr[i0+1]-1)
    (c1 > c2) && return zero(T)
    c1 = searchsortedfirst(A.colVal, i1, c1, c2, Base.Order.Forward)
    ((c1 > c2) || (A.colVal[c1] != i1)) ? zero(T) : nonzeros(A)[c1]
end

function SparseArrays._spgetindex(m::Integer, nzind::ROCVector{Ti}, nzval::ROCVector{Tv},
                                  i::Integer) where {Tv,Ti}
    ii = searchsortedfirst(nzind, convert(Ti, i))
    (ii <= m && nzind[ii] == i) ? nzval[ii] : zero(Tv)
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
ROCSparseMatrixCSR{T}(Mat::SparseMatrixCSC) where {T} = ROCSparseMatrixCSR(ROCSparseMatrixCSC{T}(Mat))
ROCSparseMatrixBSR{T}(Mat::SparseMatrixCSC, blockdim) where {T} = ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(Mat), blockdim)
ROCSparseMatrixCOO{T}(Mat::SparseMatrixCSC) where {T} = ROCSparseMatrixCOO(ROCSparseMatrixCSR{T}(Mat))

# untyped variants
ROCSparseVector(x::AbstractSparseArray{T}) where {T} = ROCSparseVector{T}(x)
ROCSparseMatrixCSC(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCSC{T}(x)
ROCSparseMatrixCSR(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCSR{T}(x)
ROCSparseMatrixBSR(x::AbstractSparseArray{T}, blockdim) where {T} = ROCSparseMatrixBSR{T}(x, blockdim)
ROCSparseMatrixCOO(x::AbstractSparseArray{T}) where {T} = ROCSparseMatrixCOO{T}(x)

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
    if dst.dims != src.dims
        throw(ArgumentError("Inconsistent Sparse Vector size"))
    end
    copyto!(nonzeroinds(dst), nonzeroinds(src))
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = nnz(src)
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCSC, src::ROCSparseMatrixCSC)
    if dst.dims != src.dims
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.colPtr, src.colPtr)
    copyto!(rowvals(dst), rowvals(src))
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = nnz(src)
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCSR, src::ROCSparseMatrixCSR)
    if dst.dims != src.dims
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowPtr, src.rowPtr)
    copyto!(dst.colVal, src.colVal)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = nnz(src)
    dst
end

function Base.copyto!(dst::ROCSparseMatrixBSR, src::ROCSparseMatrixBSR)
    if dst.dims != src.dims
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowPtr, src.rowPtr)
    copyto!(dst.colVal, src.colVal)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.dir = src.dir
    dst.nnz = nnz(src)
    dst
end

function Base.copyto!(dst::ROCSparseMatrixCOO, src::ROCSparseMatrixCOO)
    if dst.dims != src.dims
        throw(ArgumentError("Inconsistent Sparse Matrix size"))
    end
    copyto!(dst.rowInd, src.rowInd)
    copyto!(dst.colInd, src.colInd)
    copyto!(nonzeros(dst), nonzeros(src))
    dst.nnz = nnz(src)
    dst
end

Base.copy(Vec::ROCSparseVector) = copyto!(similar(Vec), Vec)
Base.copy(Mat::ROCSparseMatrixCSC) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixCSR) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixBSR) = copyto!(similar(Mat), Mat)
Base.copy(Mat::ROCSparseMatrixCOO) = copyto!(similar(Mat), Mat)


# input/output

Base.show(io::IOContext, x::ROCSparseVector) =
    show(io, SparseVector(x))

Base.show(io::IOContext, x::ROCSparseMatrixCSC) =
    show(io, SparseMatrixCSC(x))

Base.show(io::IOContext, x::ROCSparseMatrixCSR) =
    show(io, SparseMatrixCSC(x))

Base.show(io::IOContext, x::ROCSparseMatrixBSR) =
    show(io, ROCSparseMatrixCSR(x))

Base.show(io::IOContext, x::ROCSparseMatrixCOO) =
    show(io, ROCSparseMatrixCSR(x))

Base.show(io::IO, S::AbstractROCSparseMatrix) = Base.show(convert(IOContext, io), S)
function Base.show(io::IO, ::MIME"text/plain", S::AbstractROCSparseMatrix)
    xnnz = nnz(S)
    m, n = size(S)
    print(io, m, "×", n, " ", typeof(S), " with ", xnnz, " stored ",
              xnnz == 1 ? "entry" : "entries")
    if !(m == 0 || n == 0)
        print(io, ":")
        show(IOContext(io, :typeinfo => eltype(S)), S)
    end
end