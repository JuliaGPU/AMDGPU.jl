mutable struct ROCArray{T, N, B} <: AbstractGPUArray{T, N}
    buf::DataRef{Managed{B}}
    dims::Dims{N}
    offset::Int # Offset is in number of elements (not bytes).

    function ROCArray{T, N, B}(::UndefInitializer, dims::Dims{N}) where {T, N, B <: Mem.AbstractAMDBuffer}
        check_eltype("ROCArray", T)
        sz::Int64 = prod(dims) * aligned_sizeof(T)
        ref = GPUArrays.cached_alloc((ROCArray, AMDGPU.device(), B, sz)) do
            @debug "Allocate `T=$T`, `dims=$dims`: $(Base.format_bytes(sz))"
            DataRef(pool_free, pool_alloc(B, sz))
        end
        return finalizer(unsafe_free!, new{T, N, B}(ref, dims, 0))
    end

    function ROCArray{T, N}(buf::DataRef{Managed{B}}, dims::Dims{N}; offset::Integer = 0) where {T, N, B <: Mem.AbstractAMDBuffer}
        check_eltype("ROCArray", T)
        xs = new{T, N, B}(buf, dims, offset)
        return finalizer(unsafe_free!, xs)
    end
end

function hasfieldcount(@nospecialize(dt))
    try
        fieldcount(dt)
    catch
        return false
    end
    return true
end

explain_nonisbits(@nospecialize(T), depth=0) = "  "^depth * "$T is not a bitstype\n"

function explain_eltype(@nospecialize(T), depth=0; maxdepth=10)
    depth > maxdepth && return ""

    if T isa Union
      msg = "  "^depth * "$T is a union that's not allocated inline\n"
      for U in Base.uniontypes(T)
        if !Base.allocatedinline(U)
          msg *= explain_eltype(U, depth+1)
        end
      end
    elseif Base.ismutabletype(T) && Base.datatype_fieldcount(T) != 0
      msg = "  "^depth * "$T is a mutable type\n"
    elseif hasfieldcount(T)
      msg = "  "^depth * "$T is a struct that's not allocated inline\n"
      for U in fieldtypes(T)
          if !Base.allocatedinline(U)
              msg *= explain_nonisbits(U, depth+1)
          end
      end
    else
      msg = "  "^depth * "$T is not allocated inline\n"
    end
    return msg
end

# ROCArray only supports element types that are allocated inline (`Base.allocatedinline`).
# These come in three forms:
# 1. plain bitstypes (`Int`, `(Float32, Float64)`, plain immutable structs, etc).
#    these are simply stored contiguously in memory.
# 2. structs of unions (`struct Foo; x::Union{Int, Float32}; end`)
#    these are stored with a selector at the end (handled by Julia).
# 3. bitstype unions (`Union{Int, Float32}`, etc)
#    these are stored contiguously and require a selector array (handled by us)
# As well as "mutable singleton" types like `Symbol` that use pointer-identity

function valid_type(@nospecialize(T))
  if Base.allocatedinline(T)
    if hasfieldcount(T)
      return all(valid_type, fieldtypes(T))
    end
    return true
  elseif Base.ismutabletype(T)
    return Base.datatype_fieldcount(T) == 0
  end
  return false
end


@inline function check_eltype(name, T)
  if !valid_type(T)
    explanation = explain_eltype(T)
    error("""
      $name only supports element types that are allocated inline.
      $explanation""")
  end
end

GPUArrays.storage(a::ROCArray) = a.buf

function GPUArrays.derive(::Type{T}, x::ROCArray, dims::Dims{N}, offset::Int) where {N, T}
    ref = copy(x.buf)
    offset += (x.offset * Base.elsize(x)) ÷ aligned_sizeof(T)
    ROCArray{T, N}(ref, dims; offset)
end

"""
    device(A::ROCArray) -> HIPDevice

Return the device associated with the array `A`.
"""
device(A::ROCArray) = A.buf[].mem.device

buftype(x::ROCArray) = buftype(typeof(x))
buftype(::Type{<:ROCArray{<:Any, <:Any, B}}) where B = B # TODO check `@isdefined`?

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
    ROCArray{T, N, Mem.HIPBuffer}(undef, dims)
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

# empty vector constructor
ROCArray{T,1}() where {T} = ROCArray{T,1}(undef, 0)

Base.similar(a::ROCArray{T, N, B}) where {T, N, B} =
    ROCArray{T, N, B}(undef, size(a))
Base.similar(::ROCArray{T, <:Any, B}, dims::Base.Dims{N}) where {T, N, B} =
    ROCArray{T, N, B}(undef, dims)
Base.similar(::ROCArray{<:Any, <:Any, B}, ::Type{T}, dims::Base.Dims{N}) where {T, N, B} =
    ROCArray{T, N, B}(undef, dims)

## array interface

Base.elsize(::Type{<:ROCArray{T}}) where {T} = aligned_sizeof(T)
Base.size(x::ROCArray) = x.dims
Base.sizeof(x::ROCArray) = Base.elsize(x) * length(x)
Base.dataids(A::ROCArray) = (UInt(pointer(A)),)

## interop with Julia arrays

function ROCArray{T,N,B}(x::AbstractArray{<:Any,N}) where {T,N,B}
    r = ROCArray{T,N,B}(undef, size(x))
    copyto!(r, convert(Array{T}, x))
    return r
end

ROCArray{T,N}(x::AbstractArray{<:Any,N}) where {T,N} = ROCArray{T,N,Mem.HIPBuffer}(x)

# underspecified constructors
ROCArray(A::AbstractArray{T,N}) where {T,N} = ROCArray{T,N}(A)
ROCArray{T}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}(xs)
(::Type{ROCArray{T,N} where T})(x::AbstractArray{S,N}) where {S,N} = ROCArray{S,N}(x)

ROCArray{T,N}(xs::ROCArray{T,N}) where {T,N} = copy(xs)

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
    stm = stream()
    Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stm)
    async || synchronize(stm)
    return dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stream())
    return dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stream())
    return dest
end

function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    return Xnew
end

function Base.unsafe_wrap(
    ::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    own::Bool = false,
) where {T,N}
    check_eltype("unsafe_wrap(CuArray, ...)", T)

    memtype = Mem.attributes(ptr).type
    B = if memtype == HIP.hipMemoryTypeUnregistered
        Mem.HostBuffer
    elseif memtype == HIP.hipMemoryTypeHost
        Mem.HostBuffer
    elseif memtype == HIP.hipMemoryTypeDevice
        Mem.HIPBuffer
    else
        error("Unsupported memory type `$memtype` for pointer.")
    end

    sz = prod(dims) * aligned_sizeof(T)
    buf = B(Ptr{Cvoid}(ptr), sz; own)
    dref = DataRef(own ? pool_free : Returns(nothing), Managed(buf))
    return ROCArray{T, N}(dref, dims)
end

Base.unsafe_wrap(::Type{<:ROCArray}, ptr::Ptr, dim::Integer; own::Bool=false) =
    unsafe_wrap(ROCArray, ptr, (dim,); own)

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims::NTuple{N, <:Integer}; kwargs...) where {T, N} =
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

Base.unsafe_convert(typ::Type{Ptr{T}}, x::ROCArray{T}) where T =
    convert(typ, x.buf[]) + x.offset * aligned_sizeof(T)

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
    n == length(A) && return A

    maxsize = n * aligned_sizeof(T)
    bufsize = Base.isbitsunion(T) ? (maxsize + n) : maxsize
    new_buf = Mem.HIPBuffer(bufsize; stream=stream())

    copy_size = min(length(A), n) * aligned_sizeof(T)
    copy_size > 0 && Mem.memcpy!(new_buf, pointer(A), copy_size; stream=stream())
    unsafe_free!(A)

    A.buf = DataRef(pool_free, Managed(new_buf))
    A.dims = (n,)
    A.offset = 0
    return A
end

# @roc conversion

function Base.convert(
    ::Type{ROCDeviceArray{T, N, AS.Global}}, a::ROCArray{T, N},
) where {T, N}
    # If HostBuffer, use device pointer.
    buf = convert(Mem.AbstractAMDBuffer, a.buf[])
    ptr = convert(Ptr{T}, typeof(buf) <: Mem.HIPBuffer ?
        buf : buf.dev_ptr)
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset * aligned_sizeof(T))
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr)
end

Adapt.adapt_storage(::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, x)
