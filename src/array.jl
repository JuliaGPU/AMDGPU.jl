#
# Device functionality
#

## execution

struct ROCArrayBackend <: AbstractGPUBackend end

struct ROCKernelContext <: AbstractKernelContext end

# TODO compare performance with and without it.
# @inline function GPUArrays.launch_heuristic(
#     ::ROCArrayBackend, f::F, args::Vararg{Any, N};
#     elements::Int, elements_per_thread::Int,
# ) where {F, N}
#     kernel = @roc launch=false f(ROCKernelContext(), args...)
#     (; groupsize) = AMDGPU.launch_configuration(kernel)
#     threads = elements_per_thread > 1 ? groupsize : min(256, groupsize)
#     blocks = ceil(Int, elements / threads)
#     (; threads, blocks)
# end

function GPUArrays.gpu_call(::ROCArrayBackend, f, args, threads::Int, blocks::Int; name::Union{String, Nothing})
    groupsize, gridsize = threads, blocks * threads
    wait(@roc groupsize=groupsize gridsize=gridsize name=name f(ROCKernelContext(), args...))
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
    buf::DataRef{Mem.Buffer}
    dims::Dims{N}
    offset::Int # TODO add docs: offset in number of elements
    syncstate::Runtime.SyncState

    function ROCArray{T,N}(
        managed_buf::DataRef{Mem.Buffer}, dims::Dims{N};
        offset::Int = 0, syncstate::Runtime.SyncState = Runtime.SyncState(),
    ) where {T,N}
        @assert isbitstype(T) "ROCArray only supports bits types" # TODO use GPUArrays
        xs = new{T,N}(managed_buf, dims, offset, syncstate)
        finalizer(unsafe_free!, xs) # TODO safe_free!
        return xs
    end
end

# TODO Calling it, should free immediately.
unsafe_free!(x::ROCArray) = GPUArrays.unsafe_free!(x.buf)

function GPUArrays.derive(::Type{T}, N::Int, x::ROCArray, dims::Dims, offset::Int) where T
    ref = copy(x.buf)
    offset += (x.offset * Base.elsize(x)) ÷ sizeof(T)
    ROCArray{T, N}(ref, dims; offset, syncstate=x.syncstate)
end


wait!(x::ROCArray) = wait!(x.syncstate)
mark!(x::ROCArray, s) = mark!(x.syncstate, s)
wait!(xs::Vector{<:ROCArray}) = foreach(wait!, xs)
mark!(xs::Vector{<:ROCArray}, s) = foreach(x->mark!(x,s), xs)
wait!(xs::NTuple{N,<:ROCArray} where N) = foreach(wait!, xs)
mark!(xs::NTuple{N,<:ROCArray} where N, s) = foreach(x->mark!(x,s), xs)
function Adapt.adapt_storage(::Runtime.WaitAdaptor, x::ROCArray)
    Runtime.wait!(x.syncstate)
    x
end
function Adapt.adapt_storage(ma::Runtime.MarkAdaptor, x::ROCArray)
    Runtime.mark!(x.syncstate, ma.s)
    x
end

"""
    device(A::ROCArray) -> ROCDevice

Return the device associated with the array `A`.
"""
device(A::ROCArray) = A.buf[].device

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
    buf = Mem.alloc(prod(dims) * sizeof(T))
    ROCArray{T,N}(DataRef(Mem.free, buf), dims)
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
    Mem.upload!(r.buf[], pointer(x), sizeof(x))
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
ROCArray{T}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}(xs)
(::Type{ROCArray{T,N} where T})(x::AbstractArray{S,N}) where {S,N} = ROCArray{S,N}(x)
ROCArray(A::AbstractArray{T,N}) where {T,N} = ROCArray{T,N}(A)

# idempotency
ROCArray{T,N}(xs::ROCArray{T,N}) where {T,N} = xs

## conversions

Base.convert(::Type{T}, x::T) where T <: ROCArray = x


## memory operations

function Base.copyto!(
    dest::Array{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    wait!(source)
    Mem.download!(
        pointer(dest, d_offset),
        Mem.view(source.buf[], (source.offset + (s_offset - 1)) * sizeof(T)),
        amount * sizeof(T))
    dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    wait!(dest)
    Mem.upload!(
        Mem.view(dest.buf[], (dest.offset + (d_offset - 1)) * sizeof(T)),
        pointer(source, s_offset),
        amount * sizeof(T))
    dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    wait!((dest, source))
    Mem.transfer!(
        Mem.view(dest.buf[], (dest.offset + (d_offset - 1)) * sizeof(T)),
        Mem.view(source.buf[], (source.offset + (s_offset - 1)) * sizeof(T)),
        amount * sizeof(T))
    dest
end

# TODO: Workaround for hanging copy() broadcast kernel
function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
end

function Base.unsafe_wrap(::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N,<:Integer}; device=default_device(), lock::Bool=true) where {T,N}
    @assert isbitstype(T) "Cannot wrap a non-bitstype pointer as a ROCArray"
    sz = prod(dims) * sizeof(T)
    device_ptr = lock ? Mem.lock(ptr, sz, device) : ptr
    buf = Mem.Buffer(
        device_ptr, Ptr{Cvoid}(ptr), device_ptr, sz, device, false, false)
    ROCArray{T, N}(DataRef(Mem.free, buf), dims)
end
Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims; kwargs...) where T =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

## GPUArrays interfaces

GPUArrays.device(x::ROCArray) = x.buf[].device

GPUArrays.backend(::Type{<:ROCArray}) = ROCArrayBackend()

function Base.convert(::Type{ROCDeviceArray{T,N,AS.Global}}, a::ROCArray{T,N}) where {T,N}
    ptr = Base.unsafe_convert(Ptr{T}, a.buf[])
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset * Base.elsize(a))
    ROCDeviceArray{T,N,AS.Global}(a.dims, llvm_ptr)
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
    Base.unsafe_convert(Ptr{T}, x.buf[]) + x.offset * Base.elsize(x)

# some nice utilities

ones(dims...) = ones(Float32, dims...)
ones(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), one(T))
zeros(dims...) = zeros(Float32, dims...)
zeros(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), zero(T))

"""
    resize!(a::ROCVector, n::Integer)

Resize `a` to contain `n` elements. If `n` is smaller than the current
collection length, the first `n` elements will be retained. If `n` is larger,
the new elements are not guaranteed to be initialized.

Note that this operation is only supported on managed buffers, i.e., not on
arrays that are created by `unsafe_wrap`.
"""
function Base.resize!(A::ROCVector{T}, n::Integer) where T
    buf = A.buf[]
    buf.host_ptr != C_NULL && throw(ArgumentError(
        "Cannot resize an unowned `ROCVector`"))
    n == length(A) && return A

    # TODO: add additional space to allow for quicker resizing
    maxsize = n * sizeof(T)
    # type tag array past the data
    bufsize = Base.isbitsunion(T) ? (maxsize + n) : maxsize

    new_buf = Mem.alloc(buf.device, bufsize)
    copy_size = min(length(A), n) * sizeof(T)
    wait!(A)

    copy_size > 0 && Mem.transfer!(new_buf, buf, copy_size)

    unsafe_free!(A) # TODO free immediately

    A.buf = DataRef(Mem.free, new_buf)
    A.dims = (n,)
    A.offset = 0
    return A
end
