#
# Device functionality
#

## execution

struct ROCArrayBackend <: AbstractGPUBackend end

struct ROCKernelContext <: AbstractKernelContext end

function GPUArrays.gpu_call(::ROCArrayBackend, f, args, threads::Int, blocks::Int;
                            name::Union{String,Nothing})
    groupsize, gridsize = threads, blocks*threads
    wait(@roc groupsize=groupsize gridsize=gridsize f(ROCKernelContext(), args...))
end

## on-device

# indexing

for (f, froc) in (
        (:blockidx, :blockIdx),
        (:blockdim, :blockDim),
        (:threadidx, :threadIdx),
        (:griddim, :gridDimWG)
    )
    @eval GPUArrays.$f(::ROCKernelContext) = AMDGPU.$froc().x
end

# math

@inline GPUArrays.cos(ctx::ROCKernelContext, x) = cos(x)
@inline GPUArrays.sin(ctx::ROCKernelContext, x) = sin(x)
@inline GPUArrays.sqrt(ctx::ROCKernelContext, x) = sqrt(x)
@inline GPUArrays.log(ctx::ROCKernelContext, x) = log(x)

# memory

@inline function GPUArrays.LocalMemory(ctx::ROCKernelContext, ::Type{T}, ::Val{dims}, ::Val{id}) where {T,dims,id}
    ptr = AMDGPU.alloc_special(Val(id), T, AMDGPU.AS.Local, Val(prod(dims)))
    ROCDeviceArray(dims, ptr)
end

# synchronization

@inline function GPUArrays.synchronize_threads(::ROCKernelContext)
    AMDGPU.sync_workgroup()
    return
end


#
# Host abstractions
#

mutable struct ROCArray{T,N} <: AbstractGPUArray{T,N}
    buf::Mem.Buffer
    own::Bool

    dims::Dims{N}
    offset::Int

    syncstate::SyncState

    function ROCArray{T,N}(buf::Mem.Buffer, dims::Dims{N}; offset::Integer=0, own::Bool=true) where {T,N}
        @assert isbitstype(T) "ROCArray only supports bits types"
        xs = new{T,N}(buf, own, dims, offset, SyncState())
        if own
            hsaref!()
            Mem.retain(buf)
            finalizer(unsafe_free!, xs)
        end
        return xs
    end
end

function unsafe_free!(xs::ROCArray)
    Mem.release(xs.buf) && Mem.free(xs.buf)
    hsaunref!()
    return
end

wait!(x::ROCArray) = wait!(x.syncstate)
mark!(x::ROCArray, s) = mark!(x.syncstate, s)
wait!(xs::Vector{<:ROCArray}) = foreach(wait!, xs)
mark!(xs::Vector{<:ROCArray}, s) = foreach(x->mark!(x,s), xs)
wait!(xs::NTuple{N,<:ROCArray} where N) = foreach(wait!, xs)
mark!(xs::NTuple{N,<:ROCArray} where N, s) = foreach(x->mark!(x,s), xs)
function Adapt.adapt_storage(::WaitAdaptor, x::ROCArray)
    wait!(x.syncstate)
    x
end
function Adapt.adapt_storage(ma::MarkAdaptor, x::ROCArray)
    mark!(x.syncstate, ma.s)
    x
end

## aliases

const ROCVector{T} = ROCArray{T,1}
const ROCMatrix{T} = ROCArray{T,2}
const ROCVecOrMat{T} = Union{ROCVector{T},ROCMatrix{T}}

## constructors

# type and dimensionality specified, accepting dims as tuples of Ints
function ROCArray{T,N}(::UndefInitializer, dims::Dims{N}) where {T,N}
    buf = Mem.alloc(prod(dims)*sizeof(T))
    ROCArray{T,N}(buf, dims)
end

# type and dimensionality specified, accepting dims as series of Ints
ROCArray{T,N}(::UndefInitializer, dims::Integer...) where {T,N} = ROCArray{T,N}(undef, dims)

# type but not dimensionality specified
ROCArray{T}(::UndefInitializer, dims::Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
ROCArray{T}(::UndefInitializer, dims::Integer...) where {T} =
    ROCArray{T}(undef, convert(Tuple{Vararg{Int}}, dims))

# from Base arrays
function ROCArray{T,N}(x::Array{T,N}, dims::Dims{N}) where {T,N}
    r = ROCArray{T,N}(undef, size(x))
    Mem.upload!(r.buf, pointer(x), sizeof(x))
    return r
end

# type as first argument
# FIXME: Remove me!
#ROCArray(::Type{T}, dims::Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)

# empty vector constructor
ROCArray{T,1}() where {T} = ROCArray{T,1}(undef, 0)

Base.similar(a::ROCArray{T,N}) where {T,N} = ROCArray{T,N}(undef, size(a))
Base.similar(a::ROCArray{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)
Base.similar(a::ROCArray, ::Type{T}, dims::Base.Dims{N}) where {T,N} = ROCArray{T,N}(undef, dims)


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

function Base.copyto!(dest::Array{T}, d_offset::Integer,
                      source::ROCArray{T}, s_offset::Integer,
                      amount::Integer) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    wait!(source)
    Mem.download!(pointer(dest, d_offset),
                  Mem.view(source.buf, source.offset + (s_offset-1)*sizeof(T)),
                  amount*sizeof(T))
    dest
end
function Base.copyto!(dest::ROCArray{T}, d_offset::Integer,
                      source::Array{T}, s_offset::Integer,
                      amount::Integer) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    wait!(dest)
    Mem.upload!(Mem.view(dest.buf, dest.offset + (d_offset-1)*sizeof(T)),
                pointer(source, s_offset),
                amount*sizeof(T))
    dest
end
function Base.copyto!(dest::ROCArray{T}, d_offset::Integer,
                      source::ROCArray{T}, s_offset::Integer,
                      amount::Integer) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    wait!(dest)
    wait!(source)
    Mem.transfer!(Mem.view(dest.buf, dest.offset + (d_offset-1)*sizeof(T)),
                  Mem.view(source.buf, source.offset + (s_offset-1)*sizeof(T)),
                  amount*sizeof(T))
    dest
end

# TODO: Workaround for hanging copy() broadcast kernel
function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
end

## views

# optimize view to return a ROCArray when contiguous

struct Contiguous end
struct NonContiguous end

# NOTE: this covers more cases than the I<:... in Base.FastContiguousSubArray
ROCIndexStyle() = Contiguous()
ROCIndexStyle(I...) = NonContiguous()
ROCIndexStyle(::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(i1::Colon, ::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(i1::AbstractUnitRange, ::Base.ScalarIndex...) = Contiguous()
ROCIndexStyle(i1::Colon, I...) = ROCIndexStyle(I...)

rocviewlength() = ()
@inline rocviewlength(::Real, I...) = rocviewlength(I...) # skip scalar
@inline rocviewlength(i1::AbstractUnitRange, I...) = (Base.unsafe_length(i1), rocviewlength(I...)...)
@inline rocviewlength(i1::AbstractUnitRange, ::Base.ScalarIndex...) = (Base.unsafe_length(i1),)

@inline function Base.view(A::ROCArray, I::Vararg{Any,N}) where {N}
    J = to_indices(A, I)
    @boundscheck begin
        # Base's boundscheck accesses the indices, so make sure they reside on the CPU.
        # this is expensive, but it's a bounds check after all.
        J_cpu = map(j->adapt(Array, j), J)
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

    Mem.retain(a.buf)
    b = ROCArray{T,M}(a.buf, dims, offset=a.offset+offset, own=false)
    finalizer(unsafe_free!, b)
    return b
end

@inline function unsafe_view(A, I, ::NonContiguous)
    Base.unsafe_view(Base._maybe_reshape_parent(A, Base.index_ndims(I...)), I...)
end

#FIXME: add pointer conversions

## reshape

# optimize reshape to return a ROCArray

function Base.reshape(a::ROCArray{T,M}, dims::NTuple{N,Int}) where {T,N,M}
    if prod(dims) != length(a)
        throw(DimensionMismatch("new dimensions $(dims) must be consistent with array size $len"))
    end

    if N == M && dims == size(a)
        return a
    end

    Mem.retain(a.buf)
    b = ROCArray{T,N}(a.buf, dims, offset=a.offset, own=false)
    finalizer(unsafe_free!, b)
    return b
end

# allow missing dimensions with Colon()
if VERSION < v"1.6.0-DEV.1358"
    Base.reshape(parent::ROCArray, dims::Tuple{Vararg{Union{Int,Colon}}}) =
    Base.reshape(parent, Base._reshape_uncolon(parent, dims))
end


## fft

#=
using AbstractFFTs

# defining our own plan type is the easiest way to pass around the plans in FFTW interface
# without ambiguities

struct FFTPlan{T}
    p::T
end

AbstractFFTs.plan_fft(A::ROCArray; kw_args...) = FFTPlan(plan_fft(A.data; kw_args...))
AbstractFFTs.plan_fft!(A::ROCArray; kw_args...) = FFTPlan(plan_fft!(A.data; kw_args...))
AbstractFFTs.plan_bfft!(A::ROCArray; kw_args...) = FFTPlan(plan_bfft!(A.data; kw_args...))
AbstractFFTs.plan_bfft(A::ROCArray; kw_args...) = FFTPlan(plan_bfft(A.data; kw_args...))
AbstractFFTs.plan_ifft!(A::ROCArray; kw_args...) = FFTPlan(plan_ifft!(A.data; kw_args...))
AbstractFFTs.plan_ifft(A::ROCArray; kw_args...) = FFTPlan(plan_ifft(A.data; kw_args...))

function Base.:(*)(plan::FFTPlan, A::ROCArray)
    x = plan.p * A.data
    ROCArray(x)
end
=#


## GPUArrays interfaces

GPUArrays.device(x::ROCArray) = x.buf.agent

GPUArrays.backend(::Type{<:ROCArray}) = ROCArrayBackend()

function Base.convert(::Type{ROCDeviceArray{T,N,AS.Global}}, a::ROCArray{T,N}) where {T,N}
    ptr = Base.unsafe_convert(Ptr{T}, a.buf)
    ROCDeviceArray{T,N,AS.Global}(a.dims, AMDGPU.LLVMPtr{T,AS.Global}(ptr+a.offset))
end
Adapt.adapt_storage(::AMDGPU.Adaptor, x::ROCArray{T,N}) where {T,N} =
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
    Base.unsafe_convert(Ptr{T}, x.buf)

# some nice utilities

ones(dims...) = ones(Float32, dims...)
ones(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), one(T))
zeros(dims...) = zeros(Float32, dims...)
zeros(T::Type, dims...) = fill!(ROCArray{T}(undef, dims...), zero(T))
