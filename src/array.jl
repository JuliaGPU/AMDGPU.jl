mutable struct ROCArray{T,N} <: AbstractArray{T,N}
    size::Dims{N}
    handle::Ptr{T}
end

const ROCVector{T} = ROCArray{T,1}
const ROCMatrix{T} = ROCArray{T,2}
const ROCVecOrMat{T} = Union{ROCVector{T},ROCMatrix{T}}

# TODO: Support non-isbitstype allocations
function ROCArray(agent::HSAAgent, ::Type{T}, size::NTuple{N,Int}) where {T,N}
    @assert isbitstype(T) "$T is not a primitive type"
    @assert all(x->x>0, size) "Invalid array size: $size"
    region = get_region(agent, :finegrained)
    nbytes = sizeof(T) * prod(size)
    handle = Ref{Ptr{T}}()
    HSA.memory_allocate(region[], nbytes, handle) |> check
    arr = ROCArray{T,N}(size, handle[])
    finalizer(arr) do arr
        HSA.memory_free(arr.handle) |> check
    end
    return arr
end
ROCArray(::Type{T}, size::NTuple{N,Int}) where {T,N} =
    ROCArray(DEFAULT_AGENT[], T, size)

function ROCArray(agent::HSAAgent, arr::Array{T,N}) where {T,N}
    rarr = ROCArray(agent, T, size(arr))
    for idx in eachindex(arr)
        rarr[idx] = arr[idx]
    end
    return rarr
end
ROCArray(arr::Array{T,N}) where {T,N} =
    ROCArray(DEFAULT_AGENT[], arr)

function Array(rarr::ROCArray{T,N}) where {T,N}
    arr = Array{T}(undef, size(rarr))
    # FIXME: Use Mem
    ref_arr = Ref(arr)
    GC.@preserve ref_arr begin
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            ref_arr, rarr.handle, sizeof(arr))
    end
    return rarr
end

Base.pointer(arr::ROCArray) = arr.handle
Base.cconvert(::Type{Ptr{T}}, x::ROCArray{T}) where T = x.handle
Base.cconvert(::Type{Ptr{Nothing}}, x::ROCArray) = x.handle
Base.IndexStyle(::Type{<:ROCArray}) = Base.IndexLinear()
Base.IndexStyle(::ROCArray) = Base.IndexLinear()
function Base.iterate(A::ROCArray, i=1) # copy-pasta from Base
    Base.@_inline_meta
    (i % UInt) - 1 < length(A) ? (@inbounds A[i], i + 1) : nothing
end
Base.similar(arr::ROCArray{T,N}) where {T,N} =
    ROCArray(T, size(arr))
Base.similar(agent::HSAAgent, arr::ROCArray{T,N}) where {T,N} =
    ROCArray(agent, T, size(arr))
Base.similar(arr::ROCArray{T1,N}, ::Type{T2}, dims::Dims) where {T1,N,T2} =
    similar(DEFAULT_AGENT[], arr, T2, dims)
function Base.similar(agent::HSAAgent, arr::ROCArray{T1,N}, ::Type{T2}, dims::Dims) where {T1,N,T2}
    ROCArray(agent, T2, dims)
end

# copy-pasta from Base
function Base.stride(arr::ROCArray, i::Int)
    if i > ndims(arr)
        return length(ar)
    end
    s = 1
    for n = 1:(i-1)
        s *= size(arr, n)
    end
    return s
end

Base.size(arr::ROCArray) = arr.size
Base.length(arr::ROCArray) = prod(size(arr))

function Base.fill!(arr::ROCArray{T,N}, value::T) where {T,N}
    for idx in 1:length(arr)
        arr[idx] = value
    end
end
@inline function Base.getindex(arr::ROCArray{T,N}, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_load(pointer(arr), idx)::T
end
@inline function Base.setindex!(arr::ROCArray{T,N}, value, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_store!(pointer(arr), value, idx)
end

#=

mutable struct ROCArray{T,N} <: GPUArray{T,N}
  buf::Mem.Buffer
  own::Bool

  dims::Dims{N}
  offset::Int

  function ROCArray{T,N}(buf::Mem.Buffer, dims::Dims{N}; offset::Integer=0, own::Bool=true) where {T,N}
    xs = new{T,N}(buf, own, dims, offset)
    if own
      Mem.retain(buf)
      finalizer(unsafe_free!, xs)
    end
    return xs
  end
end

function unsafe_free!(xs::ROCArray)
  Mem.release(xs.buf) && dealloc(xs.buf, prod(xs.dims)*sizeof(eltype(xs)))
  return
end

## construction

# type and dimensionality specified, accepting dims as tuples of Ints
ROCArray{T,N}(::UndefInitializer, dims::Dims{N}) where {T,N} =
  ROCArray{T,N}(alloc(prod(dims)*sizeof(T)), dims)

# type and dimensionality specified, accepting dims as series of Ints
ROCArray{T,N}(::UndefInitializer, dims::Integer...) where {T,N} = ROCArray{T,N}(undef, dims)

# type but not dimensionality specified
ROCArray{T}(::UndefInitializer, dims::Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
ROCArray{T}(::UndefInitializer, dims::Integer...) where {T} =
  ROCArray{T}(undef, convert(Tuple{Vararg{Int}}, dims))

# empty vector constructor
ROCArray{T,1}() where {T} = ROCArray{T,1}(undef, 0)


Base.similar(a::ROCArray{T,N}) where {T,N} = ROCArray{T,N}(undef, size(a))
Base.similar(a::ROCArray{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
Base.similar(a::ROCArray, ::Type{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)


"""
  unsafe_wrap(::ROCArray, pointer{T}, dims; own=false, agent::HSAAgent)

Wrap a `ROCArray` object around the data at the address given by `pointer`. The pointer
element type `T` determines the array element type. `dims` is either an integer (for a 1d
array) or a tuple of the array dimensions. `own` optionally specified whether Julia should
take ownership of the memory, calling `free` when the array is no longer referenced. The
`agent` argument determines the ROC agent where the data is allocated in.
"""
function Base.unsafe_wrap(::Union{Type{ROCArray},Type{ROCArray{T}},Type{ROCArray{T,N}}},
                          p::Ptr{T}, dims::NTuple{N,Int};
                          own::Bool=false, agent::HSAAgent=get_default_agent()) where {T,N}
  buf = Mem.Buffer(convert(Ptr{Cvoid}, p), prod(dims) * sizeof(T), agent)
  return ROCArray{T, length(dims)}(buf, dims; own=own)
end
function Base.unsafe_wrap(Atype::Union{Type{ROCArray},Type{ROCArray{T}},Type{ROCArray{T,1}}},
                          p::Ptr{T}, dim::Integer;
                          own::Bool=false, agent::HSAAgent=get_default_agent()) where {T}
  unsafe_wrap(Atype, p, (dim,); own=own, agent=agent)
end


## array interface

Base.elsize(::Type{<:ROCArray{T}}) where {T} = sizeof(T)

Base.size(x::ROCArray) = x.dims
Base.sizeof(x::ROCArray) = Base.elsize(x) * length(x)


## interop with other arrays

ROCArray{T,N}(xs::AbstractArray{T,N}) where {T,N} =
  isbits(xs) ?
    (ROCArray{T,N}(undef, size(xs)) .= xs) :
    copyto!(ROCArray{T,N}(undef, size(xs)), collect(xs))

ROCArray{T,N}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}((x -> T(x)).(xs))

# underspecified constructors
ROCArray{T}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}(xs)
(::Type{ROCArray{T,N} where T})(x::AbstractArray{S,N}) where {S,N} = ROCArray{S,N}(x)
ROCArray(A::AbstractArray{T,N}) where {T,N} = ROCArray{T,N}(A)

# idempotency
ROCArray{T,N}(xs::ROCArray{T,N}) where {T,N} = xs


## conversions

Base.convert(::Type{T}, x::T) where T <: ROCArray = x

function Base._reshape(parent::ROCArray, dims::Dims)
  n = length(parent)
  prod(dims) == n || throw(DimensionMismatch("parent has $n elements, which is incompatible with size $dims"))
  return ROCArray{eltype(parent),length(dims)}(parent.buf, dims;
                                              offset=parent.offset, own=parent.own)
end



## interop with C libraries

"""
  buffer(array::ROCArray [, index])

Get the native address of a ROCArray, optionally at a given location `index`.
Equivalent of `Base.pointer` on `Array`s.
"""
function buffer(xs::ROCArray, index=1)
  extra_offset = (index-1) * Base.elsize(xs)
  Mem.Buffer(xs.buf.ptr + xs.offset + extra_offset,
             sizeof(xs) - extra_offset,
             xs.buf.agent)
end

Base.cconvert(::Type{Ptr{T}}, x::ROCArray{T}) where T = buffer(x)
Base.cconvert(::Type{Ptr{Nothing}}, x::ROCArray) = buffer(x)


## interop with AMDGPU

function Base.convert(::Type{ROCDeviceArray{T,N,AS.Global}}, a::ROCArray{T,N}) where {T,N}
  ptr = Base.unsafe_convert(Ptr{T}, a.buf)
  ROCDeviceArray{T,N,AS.Global}(a.dims, DevicePtr{T,AS.Global}(ptr+a.offset))
end

Adapt.adapt_storage(::AMDGPU.Adaptor, xs::ROCArray{T,N}) where {T,N} =
  convert(ROCDeviceArray{T,N,AS.Global}, xs)



## interop with CPU array

# We don't convert isbits types in `adapt`, since they are already
# considered GPU-compatible.

Adapt.adapt_storage(::Type{<:ROCArray}, xs::AbstractArray) =
  isbits(xs) ? xs : convert(ROCArray, xs)

Adapt.adapt_storage(::Type{<:ROCArray{T}}, xs::AbstractArray{<:Real}) where T <: AbstractFloat =
  isbits(xs) ? xs : convert(ROCArray{T}, xs)

Adapt.adapt_storage(::Type{<:Array}, xs::ROCArray) = convert(Array, xs)

Base.collect(x::ROCArray{T,N}) where {T,N} = copyto!(Array{T,N}(undef, size(x)), x)

function Base.unsafe_copyto!(dest::ROCArray{T}, doffs, src::Array{T}, soffs, n) where T
  Mem.upload!(buffer(dest, doffs), pointer(src, soffs), n*sizeof(T))
  return dest
end

function Base.unsafe_copyto!(dest::Array{T}, doffs, src::ROCArray{T}, soffs, n) where T
  Mem.download!(pointer(dest, doffs), buffer(src, soffs), n*sizeof(T))
  return dest
end

function Base.unsafe_copyto!(dest::ROCArray{T}, doffs, src::ROCArray{T}, soffs, n) where T
  Mem.transfer!(buffer(dest, doffs), buffer(src, soffs), n*sizeof(T))
  return dest
end

function Base.deepcopy_internal(x::ROCArray, dict::IdDict)
  haskey(dict, x) && return dict[x]::typeof(x)
  return dict[x] = copy(x)
end


## utilities

roc(xs) = adapt(ROCArray{Float32}, xs)
Base.getindex(::typeof(roc), xs...) = ROCArray([xs...])

roczeros(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), 0)
rocones(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), 1)
roczeros(dims...) = roczeros(Float32, dims...)
rocones(dims...) = rocones(Float32, dims...)
rocfill(v, dims...) = fill!(ROCArray{typeof(v)}(undef, dims...), v)
rocfill(v, dims::Dims) = fill!(ROCArray{typeof(v)}(undef, dims...), v)

# optimized implementation of `fill!` for types that are directly supported by memset
const MemsetTypes = Dict(1=>UInt8, 2=>UInt16, 4=>UInt32)
const MemsetCompatTypes = Union{UInt8, Int8,
                                UInt16, Int16, Float16,
                                UInt32, Int32, Float32}
function Base.fill!(A::ROCArray{T}, x) where T <: MemsetCompatTypes
  y = reinterpret(MemsetTypes[sizeof(T)], convert(T, x))
  Mem.set!(buffer(A), y, length(A))
  A
end


## generic linear algebra routines

function LinearAlgebra.tril!(A::ROCMatrix{T}, d::Integer = 0) where T
  function kernel!(_A, _d)
    li = (blockIdx().x - 1) * blockDim().x + threadIdx().x
    m, n = size(_A)
    if 0 < li <= m*n
      i, j = Tuple(CartesianIndices(_A)[li])
      if i < j - _d
        _A[i, j] = 0
      end
    end
    return nothing
  end

  grid, group = rocdims(A)
  @roc gridsize=grid groupsize=group kernel!(A, d)
  return A
end

function LinearAlgebra.triu!(A::ROCMatrix{T}, d::Integer = 0) where T
  function kernel!(_A, _d)
    li = (blockIdx().x - 1) * blockDim().x + threadIdx().x
    m, n = size(_A)
    if 0 < li <= m*n
      i, j = Tuple(CartesianIndices(_A)[li])
      if j < i + _d
        _A[i, j] = 0
      end
    end
    return nothing
  end

  grid, group = rocdims(A)
  @roc gridsize=grid groupsize=group kernel!(A, d)
  return A
end
=#
