mutable struct ROCArray{T, N, B} <: AbstractGPUArray{T, N}
    buf::DataRef{Managed{B}}
    dims::Dims{N}
    offset::Int # Offset is in number of elements (not bytes).

    function ROCArray{T, N, B}(::UndefInitializer, dims::Dims{N}) where {T, N, B <: Mem.AbstractAMDBuffer}
        @assert isbitstype(T) "ROCArray only supports bits types"
        sz::Int64 = prod(dims) * sizeof(T)
        ref = GPUArrays.cached_alloc((ROCArray, AMDGPU.device(), B, sz)) do
            @debug "Allocate `T=$T`, `dims=$dims`: $(Base.format_bytes(sz))"
            DataRef(pool_free, pool_alloc(B, sz))
        end
        return finalizer(unsafe_free!, new{T, N, B}(ref, dims, 0))
    end

    function ROCArray{T, N}(buf::DataRef{Managed{B}}, dims::Dims{N}; offset::Integer = 0) where {T, N, B <: Mem.AbstractAMDBuffer}
        @assert isbitstype(T) "ROCArray only supports bits types"
        xs = new{T, N, B}(buf, dims, offset)
        return finalizer(unsafe_free!, xs)
    end
end

GPUArrays.storage(a::ROCArray) = a.buf

function GPUArrays.derive(::Type{T}, x::ROCArray, dims::Dims{N}, offset::Int) where {N, T}
    ref = copy(x.buf)
    offset += (x.offset * Base.elsize(x)) ÷ sizeof(T)
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

Base.elsize(::Type{<:ROCArray{T}}) where {T} = sizeof(T)
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

# TODO rework, to pass pointers, instead of accessing .mem

function Base.copyto!(
    dest::Array{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer;
    async::Bool = false,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)

    @debug "[gpu -> cpu] T=$T, shape=$(size(dest))"
    stm = stream()
    Mem.download!(
        pointer(dest, d_offset),
        Mem.view(convert(Mem.AbstractAMDBuffer, source.buf[]),
            (source.offset + s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=stm)
    async || synchronize(stm)
    dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)

    @debug "[cpu -> gpu] T=$T, shape=$(size(dest))"
    Mem.upload!(
        Mem.view(convert(Mem.AbstractAMDBuffer, dest.buf[]),
            (dest.offset + d_offset - 1) * sizeof(T)),
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
        Mem.view(convert(Mem.AbstractAMDBuffer, dest.buf[]),
            (dest.offset + d_offset - 1) * sizeof(T)),
        Mem.view(convert(Mem.AbstractAMDBuffer, source.buf[]),
            (source.offset + s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=stream())
    dest
end

function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
end

function Base.unsafe_wrap(
    ::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    own::Bool = false,
) where {T,N}
    @assert isbitstype(T) "Cannot wrap a non-bitstype pointer as a ROCArray"

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

    sz = prod(dims) * sizeof(T)
    buf = B(Ptr{Cvoid}(ptr), sz; own)
    dref = DataRef(own ? pool_free : Returns(nothing), Managed(buf))
    return ROCArray{T, N}(dref, dims)
end

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims; kwargs...) where T =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

"""
    Base.unsafe_wrap(::Type{Array}, A::ROCArray, dims)

Wrap a ROCArray backed by unified or host memory as a CPU Array, allowing direct CPU
access without explicit data transfers. This only works for arrays backed by
`HIPUnifiedBuffer` or `HostBuffer`.

!!! warning
    For unified memory arrays, ensure proper synchronization before accessing the wrapped
    array from the host to avoid race conditions.

# Example
```julia
# Create a unified memory array
x = ROCArray{Float32, 1, AMDGPU.Mem.HIPUnifiedBuffer}(undef, 100)
x .= 1.0f0

# Wrap as CPU array
cpu_view = unsafe_wrap(Array, x)
cpu_view[1] = 42.0f0  # Direct CPU access
```
"""
function Base.unsafe_wrap(::Type{Array}, A::ROCArray{T,N,B}) where {T,N,B}
    if B === Mem.HIPUnifiedBuffer || B === Mem.HostBuffer
        ptr = Base.unsafe_convert(Ptr{T}, A)
        return unsafe_wrap(Array, ptr, size(A))
    else
        throw(ArgumentError(
            "unsafe_wrap(Array, ::ROCArray) only supports arrays backed by " *
            "HIPUnifiedBuffer or HostBuffer, got $B"))
    end
end

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
    convert(typ, x.buf[]) + x.offset * sizeof(T)

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

    # Preserve the buffer type (HIPBuffer, HIPUnifiedBuffer, or HostBuffer)
    old_buf = convert(Mem.AbstractAMDBuffer, A.buf[])
    new_buf = if old_buf isa Mem.HIPUnifiedBuffer
        Mem.HIPUnifiedBuffer(bufsize; stream=stream())
    else
        Mem.HIPBuffer(bufsize; stream=stream())
    end

    copy_size = min(length(A), n) * sizeof(T)
    if copy_size > 0
        Mem.transfer!(new_buf, old_buf, copy_size; stream=stream())
    end

    # Free old buffer.
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
    # Get the appropriate device pointer based on buffer type
    buf = convert(Mem.AbstractAMDBuffer, a.buf[])
    ptr = convert(Ptr{T}, typeof(buf) <: Mem.HostBuffer ?
        buf.dev_ptr : buf)
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset * sizeof(T))
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr)
end

Adapt.adapt_storage(::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, x)


## indexing

function Base.getindex(x::ROCArray{T, <:Any, <:Union{Mem.HostBuffer, Mem.HIPUnifiedBuffer}}, I::Int) where T
    @boundscheck checkbounds(x, I)
    unsafe_load(pointer(x, I))
end

function Base.setindex!(x::ROCArray{T, <:Any, <:Union{Mem.HostBuffer, Mem.HIPUnifiedBuffer}}, v, I::Int) where T
    @boundscheck checkbounds(x, I)
    unsafe_store!(pointer(x, I), v)
end
