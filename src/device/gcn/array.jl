# Contiguous on-device arrays

import ..AMDGPU.Adapt: WrappedArray

export ROCDeviceArray, ROCDeviceVector, ROCDeviceMatrix, ROCBoundsError

# construction

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
    ptr::LLVMPtr{T,A}
    len::Int

    # inner constructors, fully parameterized, exact types (ie. Int not <:Integer)
    function ROCDeviceArray{T,N,A}(shape::Dims{N}, ptr::LLVMPtr{T,A}) where {T,A,N}
        new(shape, ptr, prod(shape))
    end
end

# Define `khash` function to reduce runtime dispatches.
function Runtime.khash(x::T, h::UInt=UInt(0)) where T <: AMDGPU.Device.ROCDeviceArray
    for s in x.shape
        h = hash(s, h)
    end
    Runtime.khash(x.ptr, h)
end

const ROCDeviceVector = ROCDeviceArray{T,1,A} where {T,A}
const ROCDeviceMatrix = ROCDeviceArray{T,2,A} where {T,A}

# anything that's (secretly) backed by a ROCDeviceArray
const AnyROCDeviceArray{T,N,A} = Union{ROCDeviceArray{T,N,A}, WrappedArray{T,N,ROCDeviceArray,ROCDeviceArray{T,N,A}}}
const AnyROCDeviceVector{T,A} = AnyROCDeviceArray{T,1,A}
const AnyROCDeviceMatrix{T,A} = AnyROCDeviceArray{T,2,A}

# outer constructors, non-parameterized
ROCDeviceArray(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceArray(len::Integer,              p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, partially parameterized
ROCDeviceArray{T}(dims::NTuple{N,<:Integer},   p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceArray{T}(len::Integer,                p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)
ROCDeviceArray{T,N}(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceVector{T}(len::Integer,               p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, fully parameterized
ROCDeviceArray{T,N,A}(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(Int.(dims), p)
ROCDeviceVector{T,A}(len::Integer,               p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((Int(len),), p)

# getters

Base.pointer(a::ROCDeviceArray) = a.ptr
Base.pointer(a::ROCDeviceArray, i::Integer) =
    pointer(a) + (i - 1) * Base.elsize(a)

Base.elsize(::Type{<:ROCDeviceArray{T}}) where {T} = sizeof(T)
Base.size(g::ROCDeviceArray) = g.shape
Base.length(g::ROCDeviceArray) = g.len

# conversions

Base.unsafe_convert(::Type{LLVMPtr{T,A}}, a::ROCDeviceArray{T,N,A}) where {T,A,N} = pointer(a)

# indexing

@generated function alignment(::ROCDeviceArray{T}) where T
    Base.datatype_alignment(T)
end

@device_function @inline function Base.getindex(A::ROCDeviceArray{T}, index::Integer) where {T}
    @boundscheck checkbounds(A, index)
    align = alignment(A)
    Base.unsafe_load(pointer(A), index, Val(align))::T
end

@device_function @inline function Base.setindex!(A::ROCDeviceArray{T}, x, index::Integer) where {T}
    @boundscheck checkbounds(A, index)
    align = alignment(A)
    Base.unsafe_store!(pointer(A), x, index, Val(align))
    return A
end

Base.IndexStyle(::Type{<:ROCDeviceArray}) = Base.IndexLinear()

# comparisons

Base.isequal(a1::R1, a2::R2) where {R1<:ROCDeviceArray,R2<:ROCDeviceArray} =
    R1 == R2 && a1.shape == a2.shape && a1.ptr == a2.ptr

# other

Base.show(io::IO, a::ROCDeviceVector) =
    print(io, "$(length(a))-element device array at $(pointer(a))")
Base.show(io::IO, a::ROCDeviceArray) =
    print(io, "$(join(a.shape, '×')) device array at $(pointer(a))")

Base.show(io::IO, a::SubArray{T,D,P,I,F}) where {T,D,P<:ROCDeviceVector,I,F} =
    print(io, "$(length(a.indices[1]))-element device array view(::$P at $(pointer(parent(a))), $(a.indices[1])) with eltype $T")
Base.show(io::IO, a::SubArray{T,D,P,I,F}) where {T,D,P<:ROCDeviceArray,I,F} =
    print(io, "$(join(map(length, a.indices), '×')) device array view(::$P at $(pointer(parent(a))), $(join(a.indices, ", "))) with eltype $T")

Base.show(io::IO, a::S) where S<:AnyROCDeviceVector =
    print(io, "$(length(a))-element device wrapper $S at $(pointer(parent(a)))")
Base.show(io::IO, a::S) where S<:AnyROCDeviceArray =
    print(io, "$(join(parent(a).shape, '×')) device array wrapper $S at $(pointer(parent(a)))")

Base.show(io::IO, mime::MIME"text/plain", a::S) where S<:AnyROCDeviceArray = show(io, a)

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
