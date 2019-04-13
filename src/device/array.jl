# Contiguous on-device arrays

export ROCDeviceArray, ROCDeviceVector, ROCDeviceMatrix, ROCBoundsError


## construction

"""
    ROCDeviceArray(dims, ptr)
    ROCDeviceArray{T}(dims, ptr)
    ROCDeviceArray{T,A}(dims, ptr)
    ROCDeviceArray{T,A,N}(dims, ptr)

Construct an `N`-dimensional dense ROC device array with element type `T`
wrapping a pointer, where `N` is determined from the length of `dims` and `T`
is determined from the type of `ptr`. `dims` may be a single scalar, or a
tuple of integers corresponding to the lengths in each dimension). If the rank
`N` is supplied explicitly as in `Array{T,N}(dims)`, then it must match the
length of `dims`. The same applies to the element type `T`, which should match
the type of the pointer `ptr`.
"""
ROCDeviceArray

# NOTE: we can't support the typical `tuple or series of integer` style
# construction, because we're currently requiring a trailing pointer argument.

struct ROCDeviceArray{T,N,A} <: AbstractArray{T,N}
    shape::Dims{N}
    ptr::DevicePtr{T,A}

    # inner constructors, fully parameterized, exact types (ie. Int not <:Integer)
    ROCDeviceArray{T,N,A}(shape::Dims{N}, ptr::DevicePtr{T,A}) where {T,A,N} = new(shape,ptr)
end

const ROCDeviceVector = ROCDeviceArray{T,1,A} where {T,A}
const ROCDeviceMatrix = ROCDeviceArray{T,2,A} where {T,A}

# outer constructors, non-parameterized
ROCDeviceArray(dims::NTuple{N,<:Integer}, p::DevicePtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceArray(len::Integer,              p::DevicePtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, partially parameterized
ROCDeviceArray{T}(dims::NTuple{N,<:Integer},   p::DevicePtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceArray{T}(len::Integer,                p::DevicePtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)
ROCDeviceArray{T,N}(dims::NTuple{N,<:Integer}, p::DevicePtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceVector{T}(len::Integer,               p::DevicePtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, fully parameterized
ROCDeviceArray{T,N,A}(dims::NTuple{N,<:Integer}, p::DevicePtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(Int.(dims), p)
ROCDeviceVector{T,A}(len::Integer,               p::DevicePtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((Int(len),), p)


## getters

Base.pointer(a::ROCDeviceArray) = a.ptr

Base.size(g::ROCDeviceArray) = g.shape
Base.length(g::ROCDeviceArray) = prod(g.shape)


## conversions

Base.unsafe_convert(::Type{DevicePtr{T,A}}, a::ROCDeviceArray{T,N,A}) where {T,A,N} = pointer(a)


## indexing
# FIXME: Boundschecking

@inline function Base.getindex(A::ROCDeviceArray{T}, index::Integer) where {T}
    #@boundscheck checkbounds(A, index)
    align = datatype_align(T)
    Base.unsafe_load(pointer(A), index, Val(align))::T
end

@inline function Base.setindex!(A::ROCDeviceArray{T}, x, index::Integer) where {T}
    #@boundscheck checkbounds(A, index)
    align = datatype_align(T)
    Base.unsafe_store!(pointer(A), x, index, Val(align))
end


## other

Base.show(io::IO, a::ROCDeviceVector) =
    print(io, "$(length(a))-element device array at $(pointer(a))")
Base.show(io::IO, a::ROCDeviceArray) =
    print(io, "$(join(a.shape, '×')) device array at $(pointer(a))")

Base.show(io::IO, mime::MIME"text/plain", a::ROCDeviceArray) = show(io, a)

@inline function Base.unsafe_view(A::ROCDeviceVector{T}, I::Vararg{Base.ViewIndex,1}) where {T}
    ptr = pointer(A) + (I[1].start-1)*sizeof(T)
    len = I[1].stop - I[1].start + 1
    return ROCDeviceArray(len, ptr)
end

@inline function Base.iterate(A::ROCDeviceArray, i=1)
    if (i % UInt) - 1 < length(A)
        (@inbounds A[i], i + 1)
    else
        nothing
    end
end
