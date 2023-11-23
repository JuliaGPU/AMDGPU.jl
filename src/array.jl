mutable struct ROCArray{T, N, B} <: AbstractGPUArray{T, N}
    buf::DataRef{B}
    dims::Dims{N}
    offset::Int # Offset is in number of elements (not bytes).

    function ROCArray{T, N, B}(
        ::UndefInitializer, dims::Dims{N},
    ) where {T, N, B <: Union{Mem.HIPBuffer, Mem.HostBuffer}}
        @assert isbitstype(T) "ROCArray only supports bits types"
        buf = B(prod(dims) * sizeof(T); stream=stream())
        xs = new{T, N, B}(DataRef(_free_buf, buf), dims, 0)
        finalizer(unsafe_finalize!, xs)
        return xs
    end

    function ROCArray{T, N}(
        buf::DataRef{B}, dims::Dims{N}; offset::Integer = 0,
    ) where {T, N, B <: Union{Mem.HIPBuffer, Mem.HostBuffer}}
        @assert isbitstype(T) "ROCArray only supports bits types"
        xs = new{T, N, B}(buf, dims, offset)
        finalizer(unsafe_finalize!, xs)
        return xs
    end
end

# Passed to `DataRef` to handle freeing.
function _free_buf(buf, stream_ordered::Bool)
    s = stream_ordered ? AMDGPU.stream() : AMDGPU.default_stream()
    Mem.free(buf; stream=s)
end

unsafe_free!(x::ROCArray) = GPUArrays.unsafe_free!(x.buf, true)
unsafe_finalize!(x::ROCArray) = GPUArrays.unsafe_free!(x.buf, false) # Use global stream.

"""
    device(A::ROCArray) -> HIPDevice

Return the device associated with the array `A`.
"""
device(A::ROCArray) = A.buf[].device

## aliases

const ROCVector{T} = ROCArray{T,1}
const ROCMatrix{T} = ROCArray{T,2}
const ROCVecOrMat{T} = Union{ROCVector{T},ROCMatrix{T}}
const DenseROCArray{T,N} = ROCArray{T,N}
const DenseROCVector{T} = DenseROCArray{T,1}
const DenseROCMatrix{T} = DenseROCArray{T,2}
const DenseROCVecOrMat{T} = Union{DenseROCVector{T}, DenseROCMatrix{T}}

# strided arrays
const StridedSubROCArray{T,N,I<:Tuple{Vararg{Union{
    Base.RangeIndex, Base.ReshapedUnitRange, Base.AbstractCartesianIndex,
}}}} = SubArray{T,N,<:ROCArray,I}
const StridedROCArray{T,N} = Union{ROCArray{T,N}, StridedSubROCArray{T,N}}
const StridedROCVector{T} = StridedROCArray{T,1}
const StridedROCMatrix{T} = StridedROCArray{T,2}
const StridedROCVecOrMat{T} = Union{StridedROCVector{T}, StridedROCMatrix{T}}

# anything that's (secretly) backed by a ROCArray
AnyROCArray{T,N} = Union{ROCArray{T,N}, WrappedArray{T,N,ROCArray,ROCArray{T,N}}}
AnyROCVector{T} = AnyROCArray{T,1}
AnyROCMatrix{T} = AnyROCArray{T,2}
AnyROCVecOrMat{T} = Union{AnyROCVector{T}, AnyROCMatrix{T}}

## constructors

# type and dimensionality specified, accepting dims as tuples of Ints
function ROCArray{T,N}(::UndefInitializer, dims::Dims{N}) where {T,N}
    buf = Mem.HIPBuffer(prod(dims) * sizeof(T); stream=stream())
    ROCArray{T, N}(DataRef(_free_buf, buf), dims)
end

# buffer, type and dimensionality specified
ROCArray{T,N,B}(::UndefInitializer, dims::NTuple{N, Integer}) where {T,N,B} =
    ROCArray{T,N,B}(undef, convert(Tuple{Vararg{Int}}, dims))
ROCArray{T,N,B}(::UndefInitializer, dims::Vararg{Integer, N}) where {T,N,B} =
    ROCArray{T,N,B}(undef, convert(Tuple{Vararg{Int}}, dims))

# type and dimensionality specified
ROCArray{T,N}(::UndefInitializer, dims::NTuple{N, Integer}) where {T,N} =
    ROCArray{T,N}(undef, convert(Tuple{Vararg{Int}}, dims))
ROCArray{T,N}(::UndefInitializer, dims::Vararg{Integer, N}) where {T,N} =
    ROCArray{T,N}(undef, convert(Tuple{Vararg{Int}}, dims))

# type but not dimensionality specified
ROCArray{T}(::UndefInitializer, dims::NTuple{N, Integer}) where {T,N} =
    ROCArray{T,N}(undef, convert(Tuple{Vararg{Int}}, dims))
ROCArray{T}(::UndefInitializer, dims::Vararg{Integer, N}) where {T, N} =
    ROCArray{T,N}(undef, convert(Tuple{Vararg{Int}}, dims))

# from Base arrays
function ROCArray{T,N}(x::Array{T,N}, dims::Dims{N}) where {T,N}
    r = ROCArray{T,N}(undef, dims)
    Mem.upload!(r.buf[], pointer(x), sizeof(x); stream=stream())
    return r
end

# empty vector constructor
ROCArray{T,1}() where {T} = ROCArray{T,1}(undef, 0)

Base.similar(a::ROCArray{T,N}) where {T,N} = ROCArray{T,N}(undef, size(a))
Base.similar(::ROCArray{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
Base.similar(::ROCArray, ::Type{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)

## array interface

Base.elsize(::Type{<:ROCArray{T}}) where {T} = sizeof(T)
Base.size(x::ROCArray) = x.dims
Base.sizeof(x::ROCArray) = Base.elsize(x) * length(x)

## interop with Julia arrays

ROCArray{T,N}(x::AbstractArray{S,N}) where {T,N,S} =
    ROCArray{T,N}(convert(Array{T}, x), size(x))

# underspecified constructors
ROCArray(A::AbstractArray{T,N}) where {T,N} = ROCArray{T,N}(A)
ROCArray{T}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}(xs)
(::Type{ROCArray{T,N} where T})(x::AbstractArray{S,N}) where {S,N} = ROCArray{S,N}(x)

# idempotency
ROCArray{T,N}(xs::ROCArray{T,N}) where {T,N} = xs

## conversions

Base.convert(::Type{T}, x::T) where T <: ROCArray = x

## memory operations

function Base.copyto!(
    dest::Array{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer;
    async::Bool = false,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    strm = stream()
    Mem.download!(
        pointer(dest, d_offset),
        Mem.view(source.buf[], (source.offset + s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=strm, async)
    dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    Mem.upload!(
        Mem.view(dest.buf[], (dest.offset + d_offset - 1) * sizeof(T)),
        pointer(source, s_offset), amount * sizeof(T); stream=stream())
    dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    Mem.transfer!(
        Mem.view(dest.buf[], (dest.offset + d_offset - 1) * sizeof(T)),
        Mem.view(source.buf[], (source.offset + s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=stream())
    dest
end

# TODO: Workaround for hanging copy() broadcast kernel
function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
end

# TODO docs
function Base.unsafe_wrap(
    ::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    lock::Bool = true,
) where {T,N}
    @assert isbitstype(T) "Cannot wrap a non-bitstype pointer as a ROCArray"
    sz = prod(dims) * sizeof(T)
    buf = lock ?
        Mem.HostBuffer(Ptr{Cvoid}(ptr), sz) :
        Mem.HIPBuffer(Ptr{Cvoid}(ptr), sz)
    ROCArray{T, N}(DataRef(_free_buf, buf), dims)
end

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims; kwargs...) where T =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

## interop with CPU arrays

# We don't convert isbits types in `adapt`, since they are already
# considered GPU-compatible.

Adapt.adapt_storage(::Type{ROCArray}, xs::AT) where {AT<:AbstractArray} =
    isbitstype(AT) ? xs : convert(ROCArray, xs)

# if an element type is specified, convert to it
Adapt.adapt_storage(::Type{<:ROCArray{T}}, xs::AT) where {T, AT<:AbstractArray} =
    isbitstype(AT) ? xs : convert(ROCArray{T}, xs)

Adapt.adapt_storage(::Type{Array}, xs::ROCArray) = convert(Array, xs)


## Float32-preferring conversion

struct Float32Adaptor end

Adapt.adapt_storage(::Float32Adaptor, xs::AbstractArray) =
    isbits(xs) ? xs : convert(ROCArray, xs)

Adapt.adapt_storage(::Float32Adaptor, xs::AbstractArray{<:AbstractFloat}) =
    isbits(xs) ? xs : convert(ROCArray{Float32}, xs)

Adapt.adapt_storage(::Float32Adaptor, xs::AbstractArray{<:Complex{<:AbstractFloat}}) =
    isbits(xs) ? xs : convert(ROCArray{ComplexF32}, xs)

# not for Float16
Adapt.adapt_storage(::Float32Adaptor, xs::AbstractArray{Float16}) =
    isbits(xs) ? xs : convert(ROCArray, xs)

roc(xs) = adapt(Float32Adaptor(), xs)

function Base.unsafe_convert(::Type{Ptr{T}}, x::ROCArray{T}) where T
    # TODO have specialized convert function for buffers:
    # convert(hipPtr, buf) -> dev ptr
    tmp = typeof(x.buf[]) <: Mem.HIPBuffer ? x.buf[] : x.buf[].dev_ptr
    Base.unsafe_convert(Ptr{T}, tmp) + x.offset * sizeof(T)
end

# some nice utilities

ones(dims...) = ones(Float32, dims...)
ones(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), one(T))
zeros(dims...) = zeros(Float32, dims...)
zeros(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), zero(T))
fill(v, dims...) = fill!(ROCArray{typeof(v)}(undef, dims...), v)
fill(v, dims::Dims) = fill!(ROCArray{typeof(v)}(undef, dims...), v)

"""
    resize!(a::ROCVector, n::Integer)

Resize `a` to contain `n` elements. If `n` is smaller than the current
collection length, the first `n` elements will be retained. If `n` is larger,
the new elements are not guaranteed to be initialized.

Note that this operation is only supported on managed buffers, i.e., not on
arrays that are created by `unsafe_wrap`.
"""
function Base.resize!(A::ROCVector{T}, n::Integer) where T
    # TODO
    #   1. Specialize ROCArray on storage type.
    #   2. Check that it is not HostBuffer.
    # if A.buf.host_ptr != C_NULL
    #     throw(ArgumentError("Cannot resize an unowned `ROCVector`"))
    # end

    # TODO: add additional space to allow for quicker resizing
    n == length(A) && return A

    maxsize = n * sizeof(T)
    bufsize = Base.isbitsunion(T) ? (maxsize + n) : maxsize
    new_buf = Mem.HIPBuffer(bufsize; stream=stream())

    copy_size = min(length(A), n) * sizeof(T)
    if copy_size > 0
        Mem.transfer!(new_buf, A.buf[], copy_size; stream=stream())
    end

    # Free old buffer.
    unsafe_free!(A)

    A.buf = DataRef(_free_buf, new_buf)
    A.dims = (n,)
    A.offset = 0
    return A
end
