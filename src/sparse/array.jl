# sparse arrays
#
# The ordinary formats (vectors, CSR, CSC and COO matrices) are GPUArrays' generic sparse
# types with `ROCVector` storage, so every operation GPUArrays implements works on them.
# The rocSPARSE-specific BSR format is defined here.

export ROCSparseMatrixCSC, ROCSparseMatrixCSR, ROCSparseMatrixBSR, ROCSparseMatrixCOO
export ROCSparseMatrix, AbstractROCSparseMatrix, ROCSparseVector, ROCSparseVecOrMat

using GPUArrays: GPUSparseVector, GPUSparseMatrixCSR, GPUSparseMatrixCSC, GPUSparseMatrixCOO


## canonical formats

"""
    ROCSparseVector{Tv,Ti}

A sparse vector with values of type `Tv` and indices of type `Ti` stored in `ROCVector`s:
GPUArrays' `GPUSparseVector` with AMDGPU storage.
"""
const ROCSparseVector{Tv,Ti} = GPUSparseVector{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}

"""
    ROCSparseMatrixCSR{Tv,Ti}

A sparse matrix in compressed sparse row format stored in `ROCVector`s: GPUArrays'
`GPUSparseMatrixCSR` with AMDGPU storage. Most rocSPARSE routines work best with this
format.
"""
const ROCSparseMatrixCSR{Tv,Ti} = GPUSparseMatrixCSR{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}

"""
    ROCSparseMatrixCSC{Tv,Ti}

A sparse matrix in compressed sparse column format stored in `ROCVector`s: GPUArrays'
`GPUSparseMatrixCSC` with AMDGPU storage, the layout of `SparseMatrixCSC`. This is what
`roc` makes of a `SparseMatrixCSC`.
"""
const ROCSparseMatrixCSC{Tv,Ti} = GPUSparseMatrixCSC{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}

"""
    ROCSparseMatrixCOO{Tv,Ti}

A sparse matrix in coordinate format, sorted by row, stored in `ROCVector`s: GPUArrays'
`GPUSparseMatrixCOO` with AMDGPU storage.
"""
const ROCSparseMatrixCOO{Tv,Ti} = GPUSparseMatrixCOO{Tv,Ti,<:ROCVector{Ti},<:ROCVector{Tv}}

const ROCCanonicalMatrix{Tv,Ti} =
    Union{ROCSparseMatrixCSR{Tv,Ti},ROCSparseMatrixCSC{Tv,Ti},ROCSparseMatrixCOO{Tv,Ti}}
const ROCCanonicalSparse{Tv,Ti} = Union{ROCSparseVector{Tv,Ti},ROCCanonicalMatrix{Tv,Ti}}


## rocSPARSE-specific formats

abstract type AbstractROCVendorSparseMatrix{Tv,Ti} <: GPUArrays.AbstractGPUSparseMatrix{Tv,Ti} end

"""
Container to hold sparse matrices in block compressed sparse row (BSR) format on
the GPU. BSR format is also used in Intel MKL, and is suited to matrices that are
"block" sparse - rare blocks of non-sparse regions.
"""
mutable struct ROCSparseMatrixBSR{Tv,Ti} <: AbstractROCVendorSparseMatrix{Tv,Ti}
    rowPtr::ROCVector{Ti}
    colVal::ROCVector{Ti}
    nzVal::ROCVector{Tv}
    dims::NTuple{2,Int}
    blockDim::Ti
    dir::SparseChar
    nnzb::Ti

    function ROCSparseMatrixBSR{Tv,Ti}(
        rowPtr::ROCVector{<:Integer}, colVal::ROCVector{<:Integer},
        nzVal::ROCVector, dims::NTuple{2,<:Integer},
        blockDim::Integer, dir::SparseChar, nnz::Integer,
    ) where {Tv,Ti<:Integer}
        new{Tv,Ti}(rowPtr, colVal, nzVal, dims, blockDim, dir, nnz)
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
Utility union type of [`ROCSparseMatrixCSC`](@ref), [`ROCSparseMatrixCSR`](@ref),
[`ROCSparseMatrixBSR`](@ref), [`ROCSparseMatrixCOO`](@ref).
"""
const ROCSparseMatrix{Tv,Ti} = Union{ROCSparseMatrixCSR{Tv,Ti},ROCSparseMatrixCSC{Tv,Ti},
                                    ROCSparseMatrixCOO{Tv,Ti},ROCSparseMatrixBSR{Tv,Ti}}

# (the formats are concrete GPUArrays types now, so this can no longer be subtyped)
const AbstractROCSparseMatrix{Tv,Ti} =
    Union{ROCCanonicalMatrix{Tv,Ti},AbstractROCVendorSparseMatrix{Tv,Ti}}

const ROCSparseVecOrMat = Union{ROCSparseVector,ROCSparseMatrix}


## constructors

# From buffers: like SparseArrays' raw constructors, these borrow the buffers (unless
# types need to be converted) and do not verify the structure. The index buffers of a
# matrix share an element type, so differing ones are promoted.
uniform_indices(p::ROCVector{Ti}, i::ROCVector{Ti}) where {Ti} = (p, i)
function uniform_indices(p::ROCVector, i::ROCVector)
    Ti = promote_type(eltype(p), eltype(i))
    (convert(ROCVector{Ti}, p), convert(ROCVector{Ti}, i))
end
for (alias, generic) in ((:ROCSparseMatrixCSR, :GPUSparseMatrixCSR),
                         (:ROCSparseMatrixCSC, :GPUSparseMatrixCSC),
                         (:ROCSparseMatrixCOO, :GPUSparseMatrixCOO))
    @eval begin
        $alias(p::ROCVector{<:Integer}, i::ROCVector{<:Integer}, v::ROCVector,
               dims::NTuple{2,Integer}) =
            $generic(uniform_indices(p, i)..., v, dims)
        $alias{Tv}(p::ROCVector{<:Integer}, i::ROCVector{<:Integer}, v::ROCVector,
                   dims::NTuple{2,Integer}) where {Tv} =
            $generic(uniform_indices(p, i)..., convert(ROCVector{Tv}, v), dims)
        $alias{Tv,Ti}(p::ROCVector{<:Integer}, i::ROCVector{<:Integer}, v::ROCVector,
                      dims::NTuple{2,Integer}) where {Tv,Ti} =
            $generic(convert(ROCVector{Ti}, p), convert(ROCVector{Ti}, i),
                     convert(ROCVector{Tv}, v), dims)
    end
end
ROCSparseVector(i::ROCVector{<:Integer}, v::ROCVector, n::Integer) = GPUSparseVector(i, v, n)
ROCSparseVector{Tv}(i::ROCVector{<:Integer}, v::ROCVector, n::Integer) where {Tv} =
    GPUSparseVector(i, convert(ROCVector{Tv}, v), n)
ROCSparseVector{Tv,Ti}(i::ROCVector{<:Integer}, v::ROCVector, n::Integer) where {Tv,Ti} =
    GPUSparseVector(convert(ROCVector{Ti}, i), convert(ROCVector{Tv}, v), n)

# COO matrices can also be constructed without dimensions, or from the first `n` entries
# of the buffers
ROCSparseMatrixCOO(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector) =
    ROCSparseMatrixCOO(I, J, V, (dimlub(I), dimlub(J)))
ROCSparseMatrixCOO{Tv}(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector) where {Tv} =
    ROCSparseMatrixCOO{Tv}(I, J, V, (dimlub(I), dimlub(J)))
ROCSparseMatrixCOO{Tv,Ti}(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector) where {Tv,Ti} =
    ROCSparseMatrixCOO{Tv,Ti}(I, J, V, (dimlub(I), dimlub(J)))
function coo_prefix(I, J, V, n::Integer)
    0 <= n <= min(length(I), length(J), length(V)) ||
        throw(ArgumentError("$n stored entries exceed the length of the buffers"))
    n == length(I) == length(J) == length(V) && return I, J, V
    return I[1:n], J[1:n], V[1:n]
end
ROCSparseMatrixCOO(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector,
                   dims::NTuple{2,Integer}, n::Integer) =
    ROCSparseMatrixCOO(coo_prefix(I, J, V, n)..., dims)
ROCSparseMatrixCOO{Tv}(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector,
                       dims::NTuple{2,Integer}, n::Integer) where {Tv} =
    ROCSparseMatrixCOO{Tv}(coo_prefix(I, J, V, n)..., dims)
ROCSparseMatrixCOO{Tv,Ti}(I::ROCVector{<:Integer}, J::ROCVector{<:Integer}, V::ROCVector,
                          dims::NTuple{2,Integer}, n::Integer) where {Tv,Ti} =
    ROCSparseMatrixCOO{Tv,Ti}(coo_prefix(I, J, V, n)..., dims)

# From other arrays: move the input to AMDGPU, then convert on the device. As in AMDGPU 2,
# host arrays and dense GPU arrays get `Cint` indices (unless the dimensions or number of
# entries do not fit), and sparse GPU arrays keep their index type. `{Tv,Ti}` selects the
# index type explicitly.
roc_indtype(A::GPUArrays.AbstractGPUSparseArray) = SparseArrays.indtype(A)
roc_indtype(A::Union{Transpose,Adjoint}) = roc_indtype(parent(A))
function roc_indtype(A::AbstractArray)
    n = A isa AbstractSparseArray ? nnz(A) : length(A)
    max(size(A)..., n + 1) <= typemax(Cint) && return Cint
    return A isa AbstractSparseArray ? SparseArrays.indtype(A) : Int
end
for (alias, generic) in ((:ROCSparseVector, :GPUSparseVector),
                         (:ROCSparseMatrixCSR, :GPUSparseMatrixCSR),
                         (:ROCSparseMatrixCSC, :GPUSparseMatrixCSC),
                         (:ROCSparseMatrixCOO, :GPUSparseMatrixCOO))
    @eval begin
        # (conversions to the type of the input return it, as in AMDGPU 2)
        $alias(A::$alias) = A
        $alias{Tv}(A::$alias{Tv}) where {Tv} = A
        $alias{Tv,Ti}(A::$alias{Tv,Ti}) where {Tv,Ti} = A
        $alias(A::AbstractArray) = $alias{eltype(A),roc_indtype(A)}(A)
        $alias{Tv}(A::AbstractArray) where {Tv} = $alias{Tv,roc_indtype(A)}(A)
        $alias{Tv,Ti}(A::AbstractArray) where {Tv,Ti} = $generic{Tv,Ti}(adapt(ROCArray, A))
    end
end

ROCSparseMatrixBSR{T}(p::ROCVector, i::ROCVector, v::ROCVector, dims, b, dir, n) where {T} =
    ROCSparseMatrixBSR{T,eltype(i)}(p, i, v, dims, b, dir, n)
ROCSparseMatrixBSR(p::ROCVector, i::ROCVector, v::ROCVector{T}, b, dir, n, dims) where {T} =
    ROCSparseMatrixBSR{T,eltype(i)}(p, i, v, dims, b, dir, n)
ROCSparseMatrixBSR{T,Ti}(A::ROCSparseMatrixBSR) where {T,Ti} =
    ROCSparseMatrixBSR{T,Ti}(convert(ROCVector{Ti}, A.rowPtr), convert(ROCVector{Ti}, A.colVal),
                             convert(ROCVector{T}, A.nzVal), size(A), A.blockDim, A.dir, A.nnzb)
ROCSparseMatrixBSR{T}(A::ROCSparseMatrixBSR{<:Any,Ti}) where {T,Ti} = ROCSparseMatrixBSR{T,Ti}(A)
ROCSparseMatrixBSR{T}(A::ROCSparseMatrixBSR{T}) where {T} = A
ROCSparseMatrixBSR{T,Ti}(A::ROCSparseMatrixBSR{T,Ti}) where {T,Ti} = A
ROCSparseMatrixBSR{T,Ti}(A::SparseMatrixCSC, b) where {T,Ti} =
    ROCSparseMatrixBSR{T,Ti}(ROCSparseMatrixBSR(ROCSparseMatrixCSR{T,Cint}(A), b))
# (the BSR routines of rocSPARSE only take 32-bit indices, so that is the default)
ROCSparseMatrixBSR{T}(A::SparseMatrixCSC, b) where {T} = ROCSparseMatrixBSR{T,Cint}(A, b)
ROCSparseMatrixBSR(A::SparseMatrixCSC{T}, b) where {T} = ROCSparseMatrixBSR{T,Cint}(A, b)
# other host sparse matrices (e.g. from package extensions) go through CSR
ROCSparseMatrixBSR{T}(A::AbstractSparseMatrix, b) where {T} =
    ROCSparseMatrixBSR(ROCSparseMatrixCSR{T,Cint}(A), b)
ROCSparseMatrixBSR(A::AbstractSparseMatrix{T}, b) where {T} = ROCSparseMatrixBSR{T}(A, b)


## `roc` and `adapt`

# Host sparse arrays move to CSC matrices (or vectors) with `Cint` indices, unless they do
# not fit, as in AMDGPU 2. `adapt(ROCArray{T}, S)` converts the values to `T`, and `roc`
# makes real floating-point values Float32. (GPUArrays' generic rules would keep the index
# type; GPU sparse arrays are adapted by those.)
roc_host_indtype(A::AbstractSparseArray) =
    max(size(A)..., nnz(A) + 1) <= typemax(Cint) ? Cint : SparseArrays.indtype(A)
roc_indices(proto::ROCVector, ::Type{Ti}, inds::Vector) where {Ti} =
    copyto!(similar(proto, Ti, length(inds)), convert(Vector{Ti}, inds))

roc_values(to::Type{<:ROCArray}, v) = adapt(to, v)
roc_values(::AMDGPU.Float32Adaptor, v::Vector{<:AbstractFloat}) = convert(ROCVector{Float32}, v)
roc_values(::AMDGPU.Float32Adaptor, v::Vector) = convert(ROCVector, v)

const ROCAdaptor = Union{AMDGPU.Float32Adaptor, Type{<:ROCArray}}
function Adapt.adapt_structure(to::ROCAdaptor, A::SparseMatrixCSC)
    Ti = roc_host_indtype(A)
    nzVal = roc_values(to, nonzeros(A))
    GPUSparseMatrixCSC(roc_indices(nzVal, Ti, getcolptr(A)), roc_indices(nzVal, Ti, rowvals(A)),
                       nzVal, size(A))
end
function Adapt.adapt_structure(to::ROCAdaptor, x::SparseVector)
    Ti = roc_host_indtype(x)
    nzVal = roc_values(to, nonzeros(x))
    GPUSparseVector(roc_indices(nzVal, Ti, nonzeroinds(x)), nzVal, length(x))
end

# densify on the device (the generic constructors would index every element)
for (N, S) in ((1, :ROCSparseVector), (2, :ROCCanonicalMatrix))
    @eval begin
        ROCArray{T,$N,B}(A::$S) where {T,B} = copyto!(ROCArray{T,$N,B}(undef, size(A)), A)
        ROCArray{T,$N,B}(A::$S{T}) where {T,B} = copyto!(ROCArray{T,$N,B}(undef, size(A)), A)
        ROCArray{T,$N}(A::$S) where {T} = copyto!(ROCArray{T,$N}(undef, size(A)), A)
        ROCArray{T,$N}(A::$S{T}) where {T} = copyto!(ROCArray{T,$N}(undef, size(A)), A)
        ROCArray{T}(A::$S) where {T} = ROCArray{T,$N}(A)
        ROCArray(A::$S) = ROCArray{eltype(A),$N}(A)
    end
end

# AMDGPU 2 stored the number of entries, and named the indices of a vector `iPtr`
@inline function Base.getproperty(x::ROCSparseVector, s::Symbol)
    if s === :iPtr
        Base.depwarn("`x.iPtr` is deprecated, use `SparseArrays.nonzeroinds(x)` instead.", :iPtr)
        return getfield(x, :nzInd)
    elseif s === :nnz
        Base.depwarn("`x.nnz` is deprecated, use `nnz(x)` instead.", :nnz)
        return convert(SparseArrays.indtype(x), nnz(x))
    end
    return getfield(x, s)
end
@inline function Base.getproperty(A::ROCCanonicalMatrix, s::Symbol)
    if s === :nnz
        Base.depwarn("`A.nnz` is deprecated, use `nnz(A)` instead.", :nnz)
        return convert(SparseArrays.indtype(A), nnz(A))
    end
    return getfield(A, s)
end

"""
    unsafe_free!(A::ROCSparseVector)
    unsafe_free!(A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC,ROCSparseMatrixCOO})

Release the buffers of a sparse array. Constructors from buffers borrow them, so this is
only safe when no other array (or view) uses any of them.
"""
function AMDGPU.unsafe_free!(A::ROCCanonicalSparse)
    foreach(unsafe_free!, GPUArrays.sparse_buffers(A))
    return
end


## BSR array interface

Base.size(A::ROCSparseMatrixBSR) = A.dims
function Base.size(A::ROCSparseMatrixBSR, d::Integer)
    d >= 1 || throw(ArgumentError("dimension must be ≥ 1, got $d"))
    return d <= 2 ? A.dims[d] : 1
end
Base.length(A::ROCSparseMatrixBSR) = prod(A.dims)
SparseArrays.nnz(A::ROCSparseMatrixBSR) = A.nnzb * A.blockDim * A.blockDim
SparseArrays.nonzeros(A::ROCSparseMatrixBSR) = A.nzVal

Base.similar(A::ROCSparseMatrixBSR{Tv,Ti}) where {Tv,Ti} =
    ROCSparseMatrixBSR{Tv,Ti}(copy(A.rowPtr), copy(A.colVal), similar(nonzeros(A)), size(A),
                              A.blockDim, A.dir, A.nnzb)
Base.similar(A::ROCSparseMatrixBSR{<:Any,Ti}, ::Type{T}) where {T,Ti} =
    ROCSparseMatrixBSR{T,Ti}(copy(A.rowPtr), copy(A.colVal), similar(nonzeros(A), T), size(A),
                             A.blockDim, A.dir, A.nnzb)
Base.copy(A::ROCSparseMatrixBSR) =
    ROCSparseMatrixBSR{eltype(A),eltype(A.rowPtr)}(copy(A.rowPtr), copy(A.colVal),
                                                   copy(nonzeros(A)), size(A), A.blockDim,
                                                   A.dir, A.nnzb)

function Base.copyto!(dst::ROCSparseMatrixBSR, src::ROCSparseMatrixBSR)
    size(dst) == size(src) || throw(ArgumentError("Inconsistent Sparse Matrix size"))
    dst === src && return dst
    for (d, s) in ((dst.rowPtr, src.rowPtr), (dst.colVal, src.colVal), (dst.nzVal, src.nzVal))
        resize!(d, length(s))
        copyto!(d, s)
    end
    dst.blockDim = src.blockDim
    dst.dir = src.dir
    dst.nnzb = src.nnzb
    return dst
end

function Base.getindex(A::ROCSparseMatrixBSR{T}, i0::Integer, i1::Integer) where T
    @boundscheck checkbounds(A, i0, i1)
    i0_block, i0_idx = fldmod1(i0, A.blockDim)
    i1_block, i1_idx = fldmod1(i1, A.blockDim)
    block_idx = (i0_idx - 1) * A.blockDim + i1_idx - 1
    c1 = Int(A.rowPtr[i0_block])
    c2 = Int(A.rowPtr[i0_block+1] - 1)
    (c1 > c2) && return zero(T)
    c1 = searchsortedfirst(A.colVal, i1_block, c1, c2, Base.Order.Forward)
    (c1 > c2 || A.colVal[c1] != i1_block) && return zero(T)
    nonzeros(A)[c1+block_idx]
end

# BSR matrices go through CSR for host transfers, densification and display
SparseArrays.SparseMatrixCSC(A::ROCSparseMatrixBSR) = SparseMatrixCSC(ROCSparseMatrixCSR(A))
Base.Array(A::ROCSparseMatrixBSR) = Array(ROCSparseMatrixCSR(A))
Base.collect(A::ROCSparseMatrixBSR) = Array(A)
ROCArray(A::ROCSparseMatrixBSR) = ROCArray(ROCSparseMatrixCSR(A))
ROCArray{T}(A::ROCSparseMatrixBSR) where {T} = ROCArray{T}(ROCSparseMatrixCSR(A))
Adapt.adapt_storage(::Type{Array}, A::ROCSparseMatrixBSR) = SparseMatrixCSC(A)

Base.show(io::IO, A::ROCSparseMatrixBSR) = show(io, SparseMatrixCSC(A))
function Base.show(io::IO, ::MIME"text/plain", A::ROCSparseMatrixBSR)
    xnnz = nnz(A)
    m, n = size(A)
    print(io, m, "×", n, " ", typeof(A), " with ", xnnz, " stored ",
              xnnz == 1 ? "entry" : "entries")
    if !(m == 0 || n == 0)
        println(io, ":")
        Base.print_array(IOContext(io, :typeinfo => eltype(A)), SparseMatrixCSC(A))
    end
end

# (the canonical formats are adapted field by field by GPUArrays)
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
function Adapt.adapt_structure(to::AMDGPU.Runtime.Adaptor, A::ROCSparseMatrixBSR{T,Ti}) where {T,Ti}
    p, i, v = adapt(to, A.rowPtr), adapt(to, A.colVal), adapt(to, A.nzVal)
    ROCSparseDeviceMatrixBSR{T,Ti,typeof(p),typeof(v)}(p, i, v, size(A), A.blockDim, A.dir, A.nnzb)
end
