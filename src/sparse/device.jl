# on-device sparse array functionality

using SparseArrays

# NOTE: this functionality is currently very bare-bones, only defining the array types
#       without any device-compatible sparse array functionality


# core types

export ROCSparseDeviceVector, ROCSparseDeviceMatrixCSC, ROCSparseDeviceMatrixCSR,
       ROCSparseDeviceMatrixBSR, ROCSparseDeviceMatrixCOO

struct ROCSparseDeviceVector{Tv,Ti, A} <: AbstractSparseVector{Tv,Ti}
    iPtr::ROCDeviceVector{Ti, A}
    nzVal::ROCDeviceVector{Tv, A}
    len::Int
    nnz::Ti
end

Base.length(g::ROCSparseDeviceVector) = prod(g.dims)
Base.size(g::ROCSparseDeviceVector) = (g.len,)
Base.ndims(g::ROCSparseDeviceVector) = 1
Base.hash(x::T, h::UInt) where T<:ROCSparseDeviceVector = foldr(hash, (x.iPtr, x.nzVal, x.len, x.nnz, T, h))
SparseArrays.nnz(g::ROCSparseDeviceVector) = g.nnz

struct ROCSparseDeviceMatrixCSC{Tv,Ti,A} <: AbstractSparseMatrix{Tv,Ti}
    colPtr::ROCDeviceVector{Ti, A}
    rowVal::ROCDeviceVector{Ti, A}
    nzVal::ROCDeviceVector{Tv, A}
    dims::NTuple{2,Int}
    nnz::Ti
end

Base.length(g::ROCSparseDeviceMatrixCSC) = prod(g.dims)
Base.size(g::ROCSparseDeviceMatrixCSC) = g.dims
Base.ndims(g::ROCSparseDeviceMatrixCSC) = 2
Base.hash(x::T, h::UInt) where T<:ROCSparseDeviceMatrixCSC = foldr(hash, (x.colPtr, x.rowVal, x.nzVal, x.dims, x.nnz, T, h))
SparseArrays.nnz(g::ROCSparseDeviceMatrixCSC) = g.nnz

struct ROCSparseDeviceMatrixCSR{Tv,Ti,A} <: AbstractSparseMatrix{Tv,Ti}
    rowPtr::ROCDeviceVector{Ti, A}
    colVal::ROCDeviceVector{Ti, A}
    nzVal::ROCDeviceVector{Tv, A}
    dims::NTuple{2, Int}
    nnz::Ti
end

Base.length(g::ROCSparseDeviceMatrixCSR) = prod(g.dims)
Base.size(g::ROCSparseDeviceMatrixCSR) = g.dims
Base.ndims(g::ROCSparseDeviceMatrixCSR) = 2
Base.hash(x::T, h::UInt) where T<:ROCSparseDeviceMatrixCSR = foldr(hash, (x.rowPtr, x.colVal, x.nzVal, x.dims, x.nnz, T, h))
SparseArrays.nnz(g::ROCSparseDeviceMatrixCSR) = g.nnz

struct ROCSparseDeviceMatrixBSR{Tv,Ti,A} <: AbstractSparseMatrix{Tv,Ti}
    rowPtr::ROCDeviceVector{Ti, A}
    colVal::ROCDeviceVector{Ti, A}
    nzVal::ROCDeviceVector{Tv, A}
    dims::NTuple{2,Int}
    blockDim::Ti
    dir::Char
    nnz::Ti
end

Base.length(g::ROCSparseDeviceMatrixBSR) = prod(g.dims)
Base.size(g::ROCSparseDeviceMatrixBSR) = g.dims
Base.ndims(g::ROCSparseDeviceMatrixBSR) = 2
Base.hash(x::T, h::UInt) where T<:ROCSparseDeviceMatrixBSR = foldr(hash, (x.rowPtr, x.colVal, x.nzVal, x.dims, x.blockDim, x.dir, x.nnz, T, h))
SparseArrays.nnz(g::ROCSparseDeviceMatrixBSR) = g.nnz

struct ROCSparseDeviceMatrixCOO{Tv,Ti,A} <: AbstractSparseMatrix{Tv,Ti}
    rowInd::ROCDeviceVector{Ti, A}
    colInd::ROCDeviceVector{Ti, A}
    nzVal::ROCDeviceVector{Tv, A}
    dims::NTuple{2,Int}
    nnz::Ti
end

Base.length(g::ROCSparseDeviceMatrixCOO) = prod(g.dims)
Base.size(g::ROCSparseDeviceMatrixCOO) = g.dims
Base.ndims(g::ROCSparseDeviceMatrixCOO) = 2
Base.hash(x::T, h::UInt) where T<:ROCSparseDeviceMatrixCOO = foldr(hash, (x.rowInd, x.colInd, x.nzVal, x.dims, x.nnz, T, h))
SparseArrays.nnz(g::ROCSparseDeviceMatrixCOO) = g.nnz


# input/output

function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseDeviceVector)
    println(io, "$(length(A))-element device sparse vector at:")
    println(io, "  iPtr: $(A.iPtr)")
    print(io,   "  nzVal: $(A.nzVal)")
end

function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseDeviceMatrixCSR)
    println(io, "$(length(A))-element device sparse matrix CSR at:")
    println(io, "  rowPtr: $(A.rowPtr)")
    println(io, "  colVal: $(A.colVal)")
    print(io,   "  nzVal:  $(A.nzVal)")
end

function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseDeviceMatrixCSC)
    println(io, "$(length(A))-element device sparse matrix CSC at:")
    println(io, "  colPtr: $(A.colPtr)")
    println(io, "  rowVal: $(A.rowVal)")
    print(io,   "  nzVal:  $(A.nzVal)")
end

function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseDeviceMatrixBSR)
    println(io, "$(length(A))-element device sparse matrix BSR at:")
    println(io, "  rowPtr: $(A.rowPtr)")
    println(io, "  colVal: $(A.colVal)")
    print(io,   "  nzVal:  $(A.nzVal)")
end

function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseDeviceMatrixCOO)
    println(io, "$(length(A))-element device sparse matrix COO at:")
    println(io, "  rowPtr: $(A.rowPtr)")
    println(io, "  colInd: $(A.colInd)")
    print(io,   "  nzVal:  $(A.nzVal)")
end
