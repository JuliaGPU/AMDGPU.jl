
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

    function ROCArray{T,N}(buf::Mem.Buffer, dims::Dims{N}; offset::Integer=0, own::Bool=true) where {T,N}
        @assert isbitstype(T) "ROCArray only supports bits types"
        xs = new{T,N}(buf, own, dims, offset)
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


## broadcast

using Base.Broadcast: BroadcastStyle, Broadcasted

struct ROCArrayStyle{N} <: AbstractGPUArrayStyle{N} end
ROCArrayStyle(::Val{N}) where N = ROCArrayStyle{N}()
ROCArrayStyle{M}(::Val{N}) where {N,M} = ROCArrayStyle{N}()

BroadcastStyle(::Type{ROCArray{T,N}}) where {T,N} = ROCArrayStyle{N}()

# Allocating the output container
Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}) where {N,T} =
    similar(ROCArray{T}, axes(bc))
Base.similar(bc::Broadcasted{ROCArrayStyle{N}}, ::Type{T}, dims...) where {N,T} =
    ROCArray{T}(undef, dims...)


## memory operations

function Base.copyto!(dest::Array{T}, d_offset::Integer,
                      source::ROCArray{T}, s_offset::Integer,
                      amount::Integer) where T
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    Mem.download!(pointer(dest, d_offset),
                  Mem.view(source.buf, (s_offset-1)*sizeof(T)),
                  amount*sizeof(T))
    dest
end
function Base.copyto!(dest::ROCArray{T}, d_offset::Integer,
                      source::Array{T}, s_offset::Integer,
                      amount::Integer) where T
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    Mem.upload!(Mem.view(dest.buf, (d_offset-1)*sizeof(T)),
                pointer(source, s_offset),
                amount*sizeof(T))
    dest
end
function Base.copyto!(dest::ROCArray{T}, d_offset::Integer,
                      source::ROCArray{T}, s_offset::Integer,
                      amount::Integer) where T
    @boundscheck checkbounds(dest, d_offset+amount-1)
    @boundscheck checkbounds(source, s_offset+amount-1)
    Mem.transfer!(Mem.view(dest.buf, (d_offset-1)*sizeof(T)),
                  Mem.view(source.buf, (s_offset-1)*sizeof(T)),
                  amount*sizeof(T))
    dest
end

# TODO: Workaround for hanging copy() broadcast kernel
function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    Xnew
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

function GPUArrays.unsafe_reinterpret(::Type{T}, A::ROCArray, size::NTuple{N, Integer}; own=A.own) where {T, N}
    ptr = convert(AMDGPU.LLVMPtr{T,AS.Global}, A.buf.ptr)
    buf = Mem.Buffer(ptr, A.buf.bytesize, A.buf.agent, A.buf.coherent)
    ROCArray{T,N}(buf, size; offset=A.offset, own=own)
end
Base.unsafe_convert(::Type{Ptr{T}}, x::ROCArray{T}) where T =
    Base.unsafe_convert(Ptr{T}, x.buf)

#=
function GPUArrays.mapreducedim!(f, op, R::ROCArray, A::AbstractArray, init=nothing)
    if init !== nothing
        fill!(R, init)
    end
    @allowscalar Base.mapreducedim!(f, op, R.data, A)
end
=#
