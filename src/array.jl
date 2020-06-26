# Toy array type for simple tests
# Actual applications should use ROCArray

mutable struct HSAArray{T,N} <: AbstractArray{T,N}
    size::Dims{N}
    buffer::Mem.Buffer
end

# TODO: Support non-isbitstype allocations
function HSAArray(agent::HSAAgent, ::Type{T}, size::NTuple{N,Int}) where {T,N}
    @assert isprimitivetype(T) "$T is not a primitive type"
    @assert all(x->x>0, size) "Invalid array size: $size"

    nbytes = sizeof(T) * prod(size)

    # Always allocated as coherent memory since fill(), getindex(), and setindex!()
    # access the buffer pointer directly.
    buffer = Mem.alloc(agent, nbytes; coherent=true)
    
    arr = HSAArray{T,N}(size, buffer)

    finalizer(arr) do arr
        Mem.free(buffer)
    end

    return arr
end

HSAArray(::Type{T}, size::NTuple{N,Int}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], T, size)

### HSAArray Methods ###

HSAArray(arr::Array{T,N}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], arr)

function HSAArray(agent::HSAAgent, arr::Array{T,N}) where {T,N}
    harr = HSAArray(agent, T, size(arr))
    Mem.upload!(harr.buffer, arr)
    return harr
end

function Array(harr::HSAArray{T,N}) where {T,N}
    array = Array{T}(undef, size(harr))
    Mem.download!(array, harr.buffer)
    array
end

Base.pointer(arr::HSAArray{T,N}) where {T, N} = Ptr{T}(arr.buffer.ptr)
Base.IndexStyle(::Type{<:HSAArray}) = Base.IndexLinear()
Base.IndexStyle(::HSAArray) = Base.IndexLinear()

function Base.iterate(A::HSAArray, i=1) # copy-pasta from Base
    Base.@_inline_meta
    (i % UInt) - 1 < length(A) ? (@inbounds A[i], i + 1) : nothing
end

Base.similar(arr::HSAArray{T,N}) where {T,N} =
    HSAArray(T, size(arr))
Base.similar(agent, arr::HSAArray{T,N}) where {T,N} =
    HSAArray(agent, T, size(arr))

Base.size(arr::HSAArray) = arr.size
Base.length(arr::HSAArray) = sum(size(arr))

function Base.fill!(arr::HSAArray{T,N}, value::T) where {T,N}
    for idx in 1:length(arr)
        arr[idx] = value
    end
end

@inline function Base.getindex(arr::HSAArray{T,N}, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_load(pointer(arr), idx)::T
end

@inline function Base.setindex!(arr::HSAArray{T,N}, value, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_store!(pointer(arr), value, idx)
end

