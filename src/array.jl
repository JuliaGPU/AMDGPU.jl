#
# Device functionality
#

## execution

struct ROCArrayBackend <: AbstractGPUBackend end

struct ROCKernelContext <: AbstractKernelContext end

@inline function GPUArrays.gpu_call(
    ::ROCArrayBackend, f, args, threads::Int, blocks::Int;
    name::Union{String, Nothing},
)
    @roc gridsize=blocks groupsize=threads name=name f(ROCKernelContext(), args...)
end

## on-device

# indexing

for (f, froc) in (
    (:blockidx, :blockIdx),
    (:blockdim, :blockDim),
    (:threadidx, :threadIdx),
    (:griddim, :gridGroupDim)
)
    @eval @inline GPUArrays.$f(::ROCKernelContext) = AMDGPU.$froc().x
end

# math

@inline GPUArrays.cos(::ROCKernelContext, x) = cos(x)
@inline GPUArrays.sin(::ROCKernelContext, x) = sin(x)
@inline GPUArrays.sqrt(::ROCKernelContext, x) = sqrt(x)
@inline GPUArrays.log(::ROCKernelContext, x) = log(x)

# memory

@inline function GPUArrays.LocalMemory(::ROCKernelContext, ::Type{T}, ::Val{dims}, ::Val{id}) where {T,dims,id}
    ptr = AMDGPU.Device.alloc_special(Val{id}(), T, Val{AMDGPU.AS.Local}(), Val{prod(dims)}())
    ROCDeviceArray(dims, ptr)
end

# synchronization

@inline function GPUArrays.synchronize_threads(::ROCKernelContext)
    sync_workgroup()
    return
end

#
# Host abstractions
#

mutable struct ROCArray{T,N} <: AbstractGPUArray{T,N}
    buf::Mem.HIPBuffer
    dims::Dims{N}
    offset::Int

    function ROCArray{T,N}(
        buf::Mem.HIPBuffer, dims::Dims{N}; offset::Integer = 0,
    ) where {T,N}
        @assert isbitstype(T) "ROCArray only supports bits types"
        xs = new{T,N}(buf, dims, offset)
        Mem.retain(buf)
        finalizer(_safe_free!, xs)
        return xs
    end
end

_safe_free!(xs::ROCArray) = Mem.release(xs.buf; stream=default_stream())

unsafe_free!(xs::ROCArray) = Mem.free_if_live(xs.buf; stream=stream())

"""
    device(A::ROCArray) -> HIPDevice

Return the device associated with the array `A`.
"""
device(A::ROCArray) = A.buf.device

## aliases

const ROCVector{T} = ROCArray{T,1}
const ROCMatrix{T} = ROCArray{T,2}
const ROCVecOrMat{T} = Union{ROCVector{T},ROCMatrix{T}}

# anything that's (secretly) backed by a ROCArray
AnyROCArray{T,N} = Union{ROCArray{T,N}, WrappedArray{T,N,ROCArray,ROCArray{T,N}}}
AnyROCVector{T} = AnyROCArray{T,1}
AnyROCMatrix{T} = AnyROCArray{T,2}
AnyROCVecOrMat{T} = Union{AnyROCVector{T}, AnyROCMatrix{T}}

## constructors

# type and dimensionality specified, accepting dims as tuples of Ints
function ROCArray{T,N}(::UndefInitializer, dims::Dims{N}) where {T,N}
    buf = Mem.HIPBuffer(prod(dims) * sizeof(T); stream=stream())
    ROCArray{T, N}(buf, dims)
end

# type and dimensionality specified, accepting dims as series of Ints
ROCArray{T,N}(::UndefInitializer, dims::Integer...) where {T,N} = ROCArray{T,N}(undef, dims)

# type but not dimensionality specified
ROCArray{T}(::UndefInitializer, dims::Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
ROCArray{T}(::UndefInitializer, dims::Integer...) where {T} =
    ROCArray{T}(undef, convert(Tuple{Vararg{Int}}, dims))

# from Base arrays
function ROCArray{T,N}(x::Array{T,N}, dims::Dims{N}) where {T,N}
    r = ROCArray{T,N}(undef, dims)
    Mem.upload!(r.buf, pointer(x), sizeof(x); stream=stream())
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
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    strm = stream()
    Mem.download!(
        pointer(dest, d_offset),
        Mem.view(source.buf, source.offset + (s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=strm)
    async || AMDGPU.synchronize(strm)
    dest
end
function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    Mem.upload!(
        Mem.view(dest.buf, dest.offset + (d_offset - 1) * sizeof(T)),
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
        Mem.view(dest.buf, dest.offset + (d_offset - 1) * sizeof(T)),
        Mem.view(source.buf, source.offset + (s_offset - 1) * sizeof(T)),
        amount * sizeof(T); stream=stream())
    dest
end

# TODO: Workaround for hanging copy() broadcast kernel
function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
end

function Base.unsafe_wrap(
    ::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    lock::Bool = true,
) where {T,N}
    @assert isbitstype(T) "Cannot wrap a non-bitstype pointer as a ROCArray"
    # TODO specialize ROCArray on a buffer type and pass HostBuffer.
    sz = prod(dims) * sizeof(T)
    dptr = if lock
        HIP.hipHostRegister(ptr, sz, HIP.hipHostRegisterMapped) |> HIP.check
        Mem.device_ptr(Mem.HostBuffer(ptr, sz))
    else
        Ptr{Cvoid}(ptr)
    end
    return ROCArray{T, N}(Mem.HIPBuffer(dptr, sz), dims)
end

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims; kwargs...) where T =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

## views

# optimize view to return a ROCArray when contiguous

struct Contiguous end
struct NonContiguous end

# NOTE: this covers more cases than the I<:... in Base.FastContiguousSubArray
ROCIndexStyle() = Contiguous()
ROCIndexStyle(I...) = NonContiguous()
ROCIndexStyle(::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(::Colon, ::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(::AbstractUnitRange, ::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(::Colon, I...) = ROCIndexStyle(I...)

rocviewlength() = ()
@inline rocviewlength(::Real, I...) = rocviewlength(I...) # skip scalar
@inline rocviewlength(i1::AbstractUnitRange, I...) = (length(i1), rocviewlength(I...)...)
@inline rocviewlength(i1::AbstractUnitRange, ::Base.ScalarIndex...) = (length(i1),)

# We don't really want an array, so don't call `adapt(Array, ...)`,
# but just want ROCArray indices to get downloaded back to the CPU.
# this makes sure we preserve array-like containers, like Base.Slice.
struct BackToCPU end
Adapt.adapt_storage(::BackToCPU, xs::ROCArray) = convert(Array, xs)

@inline function Base.view(A::ROCArray, I::Vararg{Any,N}) where {N}
    J = to_indices(A, I)
    @boundscheck begin
        # Base's boundscheck accesses the indices, so make sure they reside on the CPU.
        # this is expensive, but it's a bounds check after all.
        J_cpu = map(j->adapt(BackToCPU(), j), J)
        checkbounds(A, J_cpu...)
    end
    J_gpu = map(j->adapt(ROCArray, j), J)
    unsafe_view(A, J_gpu, ROCIndexStyle(I...))
end

@inline function unsafe_view(A, I, ::Contiguous)
    unsafe_contiguous_view(Base._maybe_reshape_parent(A, Base.index_ndims(I...)), I, rocviewlength(I...))
end
@inline function unsafe_contiguous_view(a::ROCArray{T}, I::NTuple{N,Base.ViewIndex}, dims::NTuple{M,Integer}) where {T,N,M}
    offset = Base.compute_offset1(a, 1, I) * sizeof(T)
    ROCArray{T,M}(a.buf, dims; offset=a.offset + offset)
end

@inline function unsafe_view(A, I, ::NonContiguous)
    Base.unsafe_view(Base._maybe_reshape_parent(A, Base.index_ndims(I...)), I...)
end

#FIXME: add pointer conversions

## reshape

# optimize reshape to return a ROCArray

function Base.reshape(a::ROCArray{T,M}, dims::NTuple{N,Int}) where {T,N,M}
    if prod(dims) != length(a)
        throw(DimensionMismatch("new dimensions $dims must be consistent with array size $(size(a))"))
    end

    if N == M && dims == size(a)
        return a
    end
    ROCArray{T,N}(a.buf, dims; offset=a.offset)
end

## GPUArrays interfaces

GPUArrays.device(x::ROCArray) = x.buf.device

GPUArrays.backend(::Type{<:ROCArray}) = ROCArrayBackend()

function Base.convert(::Type{ROCDeviceArray{T,N,AS.Global}}, a::ROCArray{T,N}) where {T,N}
    ptr = Base.unsafe_convert(Ptr{T}, a.buf)
    ROCDeviceArray{T,N,AS.Global}(a.dims, AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset))
end
Adapt.adapt_storage(::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, x)


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


Base.unsafe_convert(::Type{Ptr{T}}, x::ROCArray{T}) where T =
    Base.unsafe_convert(Ptr{T}, x.buf) + x.offset

# some nice utilities

ones(dims...) = ones(Float32, dims...)
ones(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), one(T))
zeros(dims...) = zeros(Float32, dims...)
zeros(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), zero(T))

# create a derived array (reinterpreted or reshaped) that's still a ROCArray
# TODO: Move this to GPUArrays?
@inline function _derived_array(::Type{T}, N::Int, a::ROCArray, osize::Dims) where {T}
    return ROCArray{T,N}(a.buf, osize; offset=a.offset)
end

## reinterpret

function Base.reinterpret(::Type{T}, a::ROCArray{S,N}) where {T,S,N}
    err = _reinterpret_exception(T, a)
    err === nothing || throw(err)

    if sizeof(T) == sizeof(S) # for N == 0
        osize = size(a)
    else
        isize = size(a)
        size1 = div(isize[1] * sizeof(S), sizeof(T))
        osize = tuple(size1, Base.tail(isize)...)
    end

    return _derived_array(T, N, a, osize)
end

function _reinterpret_exception(::Type{T}, a::AbstractArray{S,N}) where {T,S,N}
    if !isbitstype(T) || !isbitstype(S)
        return _ROCReinterpretBitsTypeError{T,typeof(a)}()
    end
    if N == 0 && sizeof(T) != sizeof(S)
        return _ROCReinterpretZeroDimError{T,typeof(a)}()
    end
    if N != 0 && sizeof(S) != sizeof(T)
        ax1 = axes(a)[1]
        dim = length(ax1)
        if Base.rem(dim*sizeof(S),sizeof(T)) != 0
            return _ROCReinterpretDivisibilityError{T,typeof(a)}(dim)
        end
        if first(ax1) != 1
            return _ROCReinterpretFirstIndexError{T,typeof(a),typeof(ax1)}(ax1)
        end
    end
    return nothing
end

struct _ROCReinterpretBitsTypeError{T,A} <: Exception end
function Base.showerror(io::IO, ::_ROCReinterpretBitsTypeError{T,<:AbstractArray{S}}) where {T, S}
    print(io, "cannot reinterpret an `$(S)` array to `$(T)`, because not all types are bitstypes")
end

struct _ROCReinterpretZeroDimError{T,A} <: Exception end
function Base.showerror(io::IO, ::_ROCReinterpretZeroDimError{T,<:AbstractArray{S,N}}) where {T, S, N}
    print(io, "cannot reinterpret a zero-dimensional `$(S)` array to `$(T)` which is of a different size")
end

struct _ROCReinterpretDivisibilityError{T,A} <: Exception
    dim::Int
end
function Base.showerror(io::IO, err::_ROCReinterpretDivisibilityError{T,<:AbstractArray{S,N}}) where {T, S, N}
    dim = err.dim
    print(io, """
          cannot reinterpret an `$(S)` array to `$(T)` whose first dimension has size `$(dim)`.
          The resulting array would have non-integral first dimension.
          """)
end

struct _ROCReinterpretFirstIndexError{T,A,Ax1} <: Exception
    ax1::Ax1
end
function Base.showerror(io::IO, err::_ROCReinterpretFirstIndexError{T,<:AbstractArray{S,N}}) where {T, S, N}
    ax1 = err.ax1
    print(io, "cannot reinterpret a `$(S)` array to `$(T)` when the first axis is $ax1. Try reshaping first.")
end

## reinterpret(reshape)

function Base.reinterpret(::typeof(reshape), ::Type{T}, a::ROCArray) where {T}
    N, osize = _base_check_reshape_reinterpret(T, a)
    return _derived_array(T, N, a, osize)
end

# taken from reinterpretarray.jl
# TODO: move these Base definitions out of the ReinterpretArray struct for reuse
function _base_check_reshape_reinterpret(::Type{T}, a::ROCArray{S}) where {T,S}
    isbitstype(T) || throwbits(S, T, T)
    isbitstype(S) || throwbits(S, T, S)
    if sizeof(S) == sizeof(T)
        N = ndims(a)
        osize = size(a)
    elseif sizeof(S) > sizeof(T)
        d, r = divrem(sizeof(S), sizeof(T))
        r == 0 || throwintmult(S, T)
        N = ndims(a) + 1
        osize = (d, size(a)...)
    else
        d, r = divrem(sizeof(T), sizeof(S))
        r == 0 || throwintmult(S, T)
        N = ndims(a) - 1
        N > -1 || throwsize0(S, T, "larger")
        axes(a, 1) == Base.OneTo(sizeof(T) ÷ sizeof(S)) || throwsize1(a, T)
        osize = size(a)[2:end]
    end
    return N, osize
end

@noinline function throwbits(S::Type, T::Type, U::Type)
    throw(ArgumentError("cannot reinterpret `$(S)` as `$(T)`, type `$(U)` is not a bits type"))
end

@noinline function throwintmult(S::Type, T::Type)
    throw(ArgumentError("`reinterpret(reshape, T, a)` requires that one of `sizeof(T)` (got $(sizeof(T))) and `sizeof(eltype(a))` (got $(sizeof(S))) be an integer multiple of the other"))
end

@noinline function throwsize0(S::Type, T::Type, msg)
    throw(ArgumentError("cannot reinterpret a zero-dimensional `$(S)` array to `$(T)` which is of a $msg size"))
end

@noinline function throwsize1(a::AbstractArray, T::Type)
    throw(ArgumentError("`reinterpret(reshape, $T, a)` where `eltype(a)` is $(eltype(a)) requires that `axes(a, 1)` (got $(axes(a, 1))) be equal to 1:$(sizeof(T) ÷ sizeof(eltype(a))) (from the ratio of element sizes)"))
end

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
    bufsize = if Base.isbitsunion(T)
        # type tag array past the data
        maxsize + n
    else
        maxsize
    end
    new_buf = Mem.HIPBuffer(bufsize; stream=stream())

    copy_size = min(length(A), n) * sizeof(T)
    if copy_size > 0
        Mem.transfer!(new_buf, A.buf, copy_size; stream=stream())
    end

    # Release old buffer
    _safe_free!(A)
    # N.B. Manually retain new buffer (this is normally done in ROCArray ctor)
    Mem.retain(new_buf)

    A.buf = new_buf
    A.dims = (n,)
    A.offset = 0
    return A
end
