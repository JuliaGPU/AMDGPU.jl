# Contiguous on-device arrays

import ..AMDGPU.Adapt: WrappedArray

export ROCDeviceArray, ROCDeviceVector, ROCDeviceMatrix

"""
    ROCDeviceArray(dims, ptr, [maxsize])
    ROCDeviceArray{T}(dims, ptr)
    ROCDeviceArray{T,A}(dims, ptr)
    ROCDeviceArray{T,A,N}(dims, ptr, [maxsize])

Construct an `N`-dimensional dense ROC device array with element type `T`
wrapping a pointer, where `N` is determined from the length of `dims` and `T`
is determined from the type of `ptr`. `dims` may be a single scalar, or a
tuple of integers corresponding to the lengths in each dimension). If the rank
`N` is supplied explicitly as in `Array{T,N}(dims)`, then it must match the
length of `dims`. The same applies to the element type `T`, which should match
the type of the pointer `ptr`.

Arrays of isbits unions keep one selector byte per element past their data;
`maxsize` is the distance in bytes from `ptr` to those bytes, which defaults to
the size of the data.
"""
ROCDeviceArray

# NOTE: we can't support the typical `tuple or series of integer` style
# construction, because we're currently requiring a trailing pointer argument.

struct ROCDeviceArray{T,N,A} <: DenseArray{T,N}
    # NOTE: `dims` is a mandatory name for things like `strides(xd)` to work.
    dims::Dims{N}
    ptr::LLVMPtr{T,A}
    len::Int
    # distance from `ptr` to the selector bytes of an array of isbits unions (see
    # `typetagdata`); the size of the data for an array starting at the beginning of
    # its memory
    maxsize::Int

    # inner constructors, fully parameterized, exact types (ie. Int not <:Integer)
    function ROCDeviceArray{T,N,A}(dims::Dims{N}, ptr::LLVMPtr{T,A},
                                   maxsize::Int = prod(dims) * aligned_sizeof(T)) where {T,A,N}
        new(dims, ptr, prod(dims), maxsize)
    end
end

const ROCDeviceVector = ROCDeviceArray{T,1,A} where {T,A}
const ROCDeviceMatrix = ROCDeviceArray{T,2,A} where {T,A}

const AnyROCDeviceArray{T,N,A} = Union{ROCDeviceArray{T,N,A}, WrappedArray{T,N,ROCDeviceArray,ROCDeviceArray{T,N,A}}}
const AnyROCDeviceVector{T,A} = AnyROCDeviceArray{T,1,A}
const AnyROCDeviceMatrix{T,A} = AnyROCDeviceArray{T,2,A}

# outer constructors, non-parameterized
ROCDeviceArray(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}, maxsize::Int = prod(dims) * aligned_sizeof(T)) where {T,A,N} =
    ROCDeviceArray{T,N,A}(dims, p, maxsize)
ROCDeviceArray(len::Integer,              p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, partially parameterized
ROCDeviceArray{T}(dims::NTuple{N,<:Integer},   p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceArray{T}(len::Integer,                p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)
ROCDeviceArray{T,N}(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}) where {T,A,N} = ROCDeviceArray{T,N,A}(dims, p)
ROCDeviceVector{T}(len::Integer,               p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((len,), p)

# outer constructors, fully parameterized
ROCDeviceArray{T,N,A}(dims::NTuple{N,<:Integer}, p::LLVMPtr{T,A}, maxsize::Int = prod(dims) * aligned_sizeof(T)) where {T,A,N} =
    ROCDeviceArray{T,N,A}(Int.(dims), p, maxsize)
ROCDeviceVector{T,A}(len::Integer,               p::LLVMPtr{T,A}) where {T,A}   = ROCDeviceVector{T,A}((Int(len),), p)

Base.pointer(a::ROCDeviceArray{T, <: Any, A}) where {T, A} =
    Base.unsafe_convert(LLVMPtr{T, A}, a)
@inline Base.pointer(a::ROCDeviceArray{T, <: Any, A}, i::Integer) where {T, A} =
    Base.unsafe_convert(LLVMPtr{T, A}, a) + Base._memory_offset(a, i)

Base.unsafe_convert(::Type{LLVMPtr{T, A}}, a::ROCDeviceArray{T, <: Any, A}) where {T, A} = a.ptr

# the selector byte of element `i` of an array of isbits unions
typetagdata(a::ROCDeviceArray{<:Any, <:Any, A}, i=1) where {A} =
    reinterpret(LLVMPtr{UInt8, A}, a.ptr + a.maxsize) + i - one(i)

Base.elsize(::Type{<:ROCDeviceArray{T}}) where {T} = aligned_sizeof(T)
Base.size(g::ROCDeviceArray) = g.dims
Base.sizeof(x::ROCDeviceArray) = Base.elsize(x) * length(x)
Base.length(g::ROCDeviceArray) = g.len

# indexing

Base.IndexStyle(::Type{<:ROCDeviceArray}) = Base.IndexLinear()

@generated function alignment(::ROCDeviceArray{T}) where T
    if Base.isbitsunion(T)
        _, sz, al = Base.uniontype_layout(T)
        al
    else
        Base.datatype_alignment(T)
    end
end

# element accessors; the bounds are checked by `getindex` and `setindex!`

@inline function arrayref(A::ROCDeviceArray{T}, index::Integer) where {T}
    if Base.isbitsunion(T)
        arrayref_union(A, index)
    else
        Base.unsafe_load(pointer(A), index, Val(alignment(A)))
    end
end

# the selector byte tells which member of the union to load the element as
@inline @generated function arrayref_union(A::ROCDeviceArray{T, <: Any, AS}, index::Integer) where {T, AS}
    typs = Base.uniontypes(T)

    # generate code that conditionally loads a value based on the selector value.
    # lacking noreturn, we return T to avoid inference thinking this can return Nothing.
    ex = :(Base.llvmcall("unreachable", $T, Tuple{}))
    for (sel, typ) in Iterators.reverse(enumerate(typs))
        ex = quote
            if selector == $(UInt8(sel - 1))
                Base.unsafe_load(reinterpret(LLVMPtr{$typ, AS}, data_ptr), 1, Val(align))
            else
                $ex
            end
        end
    end

    quote
        selector = Base.unsafe_load(typetagdata(A, index))
        align = alignment(A)
        data_ptr = pointer(A, index)
        return $ex
    end
end

@inline function arrayset(A::ROCDeviceArray{T}, x::T, index::Integer) where {T}
    if Base.isbitsunion(T)
        arrayset_union(A, x, index)
    else
        Base.unsafe_store!(pointer(A), x, index, Val(alignment(A)))
    end
    return A
end

# store the value as its own type, and record that type in the selector byte
@inline @generated function arrayset_union(A::ROCDeviceArray{T, <: Any, AS}, x::T, index::Integer) where {T, AS}
    typs = Base.uniontypes(T)
    sel = findfirst(isequal(x), typs)

    quote
        Base.unsafe_store!(typetagdata(A, index), $(UInt8(sel - 1)))
        align = alignment(A)
        data_ptr = pointer(A, index)
        Base.unsafe_store!(reinterpret(LLVMPtr{$x, AS}, data_ptr), x, 1, Val(align))
        return
    end
end

@device_function @inline function Base.getindex(A::ROCDeviceArray{T}, index::Integer) where {T}
    @boundscheck checkbounds(A, index)
    arrayref(A, index)::T
end

@device_function @inline function Base.setindex!(A::ROCDeviceArray{T}, x, index::Integer) where {T}
    @boundscheck checkbounds(A, index)
    arrayset(A, convert(T, x)::T, index)
    return A
end

Base.isequal(a1::R1, a2::R2) where {R1<:ROCDeviceArray,R2<:ROCDeviceArray} =
    R1 == R2 && a1.dims == a2.dims && a1.ptr == a2.ptr

# other

Base.show(io::IO, a::ROCDeviceVector) =
    print(io, "$(length(a))-element device array at $(pointer(a))")
Base.show(io::IO, a::ROCDeviceArray) =
    print(io, "$(join(a.dims, '×')) device array at $(pointer(a))")

Base.show(io::IO, a::SubArray{T,D,P,I,F}) where {T,D,P<:ROCDeviceVector,I,F} =
    print(io, "$(length(a.indices[1]))-element device array view(::$P at $(pointer(parent(a))), $(a.indices[1])) with eltype $T")
Base.show(io::IO, a::SubArray{T,D,P,I,F}) where {T,D,P<:ROCDeviceArray,I,F} =
    print(io, "$(join(map(length, a.indices), '×')) device array view(::$P at $(pointer(parent(a))), $(join(a.indices, ", "))) with eltype $T")

Base.show(io::IO, a::S) where S<:AnyROCDeviceVector =
    print(io, "$(length(a))-element device array wrapper $S at $(pointer(parent(a)))")
Base.show(io::IO, a::S) where S<:AnyROCDeviceArray =
    print(io, "$(join(parent(a).dims, '×')) device array wrapper $S at $(pointer(parent(a)))")

Base.show(io::IO, mime::MIME"text/plain", a::S) where S<:AnyROCDeviceArray = show(io, a)

@inline function Base.iterate(A::ROCDeviceArray, i = 1)
    if (i % UInt) - 1 < length(A)
        (@inbounds A[i], i + 1)
    else
        nothing
    end
end

## reshape

function Base.reshape(a::ROCDeviceArray{T,M,A}, dims::NTuple{N,Int}) where {T,N,M,A}
    if prod(dims) != length(a)
        throw(nothing) # standing for: throw(DimensionMismatch("new dimensions (argument `dims`) must be consistent with array size (`size(a)`)"))
    end
    if N == M && dims == size(a)
        return a
    end
    _derived_array(a, T, dims)
end

# create a derived device array (reinterpreted or reshaped) that's still a ROCDeviceArray
@inline function _derived_array(a::ROCDeviceArray{<:Any,<:Any,A}, ::Type{T}, dims::Dims{N}) where {T, N, A}
    return ROCDeviceArray{T,N,A}(dims, a.ptr, a.maxsize)
end
