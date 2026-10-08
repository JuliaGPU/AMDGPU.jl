"""
    ROCArray{T,N,B} <: AbstractGPUArray{T,N}

`N`-dimensional dense array of element type `T` stored in GPU memory (backed by
buffer type `B`). `ROCArray` implements Julia's `AbstractArray` interface, so
broadcasting, reductions, and linear algebra run on the GPU.

Copy a host array to the device by wrapping it, or allocate directly:

```julia
ROCArray([1, 2, 3])             # copy a host array to the device
ROCArray{Float32}(undef, 4, 4)  # uninitialized 4×4 device matrix
```

Move data back to the host with `Array(x)`. See also [`roc`](@ref), which
copies to the device while narrowing floating-point types to 32-bit, and the
`AMDGPU.zeros` / `AMDGPU.ones` / `AMDGPU.rand` constructors.
"""
mutable struct ROCArray{T, N, B} <: AbstractGPUArray{T, N}
    buf::DataRef{Managed{B}}
    dims::Dims{N}
    offset::Int # offset of the data in memory, in bytes

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
    offset = x.offset + offset * aligned_sizeof(T)
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

## alias detection

# GPUArrays implements `Base.dataids` and `Base.mightalias` from where an array lives. Not
# using `pointer(x)`, which takes ownership of the memory for the current stream.
function GPUArrays.memory_location(x::ROCArray)
    mem = x.buf[].mem
    return (UInt(mem isa Mem.HostBuffer ? mem.dev_ptr : mem.ptr), x.offset)
end

Base.unaliascopy(x::ROCArray) = copy(x)

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
    GC.@preserve dest source Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stm)
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
    GC.@preserve dest source Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stream())
    return dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    GC.@preserve dest source Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stream())
    return dest
end

# Element types whose bit pattern a HIP memset can replicate directly,
# letting `fill!` skip kernel compilation entirely.
const MemsetTypes = Union{
    UInt8, Int8,
    UInt16, Int16, Float16,
    UInt32, Int32, Float32}

memset_type(::Type{T}) where T = aligned_sizeof(T) == 1 ? UInt8 :
    (aligned_sizeof(T) == 2 ? UInt16 : UInt32)

function Base.fill!(A::ROCArray{T}, x) where T <: MemsetTypes
    isempty(A) && return A
    U = memset_type(T)
    Mem.memset!(pointer(A), reinterpret(U, convert(T, x)), length(A); stream=stream())
    return A
end

function Base.copy(X::ROCArray{T}) where T
    Xnew = ROCArray{T}(undef, size(X))
    copyto!(Xnew, 1, X, 1, length(X))
    return Xnew
end

"""
    unsafe_wrap(ROCArray, ptr::Ptr{T}, dims; own=false)
    unsafe_wrap(ROCArray, a::Array)

Wrap a `ROCArray` around existing memory, without copying it. `ptr` can point to device
memory or to host memory; host memory that is not yet page-locked is registered with
`hipHostRegister` for as long as the wrapper exists, which can be slow.

When wrapping an `Array`, the returned `ROCArray` keeps it alive. When wrapping a pointer,
the caller has to keep the memory valid for as long as the `ROCArray` is used. If `own` is
set, the memory is freed (or, for registered host memory, unregistered) when the
`ROCArray` is freed, as soon as the device is done using it.

Device operations execute asynchronously, so synchronize (e.g., using
`AMDGPU.synchronize()`) before accessing wrapped host memory on the host.
"""
function Base.unsafe_wrap(
    ::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    own::Bool = false,
) where {T,N}
    return wrap_memory(ptr, dims, own)
end

# `owner` is kept alive for as long as the wrapper
function wrap_memory(ptr::Ptr{T}, dims::NTuple{N, <:Integer}, own::Bool,
                     owner = nothing) where {T,N}
    check_eltype("unsafe_wrap(ROCArray, ...)", T)

    memtype = Mem.memory_type(Ptr{Cvoid}(ptr))
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
    if B == Mem.HostBuffer && sz == 0
        # registering an empty range is invalid
        buf = Mem.HostBuffer()
    else
        buf = B(Ptr{Cvoid}(ptr), sz; own)
    end
    managed = Managed(buf)
    finalize_buffer = if buf isa Mem.HostBuffer && buf.ptr != C_NULL &&
                         (own || Mem.is_registered(buf.ptr))
        # constructing the buffer registered the memory (or took another reference to an
        # existing registration), which needs to be undone even if we don't own it
        release_after_use(() -> release_host_memory(managed, own), owner)
    elseif own
        pool_free
    elseif owner !== nothing
        release_after_use(Returns(nothing), owner)
    else
        Returns(nothing)
    end
    dref = DataRef(finalize_buffer, managed)
    return ROCArray{T, N}(dref, dims)
end

# Returns a finalizer for the `Managed` memory of a wrapper, which calls `release` and lets
# go of `owner` once the device is done with that memory.
#
# Waiting for the device is not possible from a finalizer: finalizers cannot yield, and
# blocking could deadlock with a kernel waiting for the host to service a hostcall. Instead,
# a host function launched on the stream that last used the memory signals an async
# condition when the device reaches it, and the task waiting for that condition performs
# the release. That task keeps `owner` alive, so if the condition can't be signalled, the
# memory is leaked rather than released while it may still be in use. The task is not
# affected by cancellation of the scope that wrapped the memory.
function release_after_use(release, owner)
    released = Threads.Atomic{Bool}(false)
    release_once() = Threads.atomic_xchg!(released, true) || release()
    done = Threads.Atomic{Bool}(false)
    cond = Base.AsyncCondition() do cond
        close(cond)
        GC.@preserve owner release_once()
        done[] = true
    end
    return managed -> release_when_done(managed, release_once, cond, done)
end

function release_when_done(managed::Managed, release, cond::Base.AsyncCondition,
                           done::Threads.Atomic{Bool})
    # if the stream has been handed to another task since it last used the memory, that
    # work has finished, and the stream may now be used (or captured) by the other task
    if !managed.dirty || recycled(managed)
        GC.in_finalizer() || release()
        ccall(:uv_async_send, Cint, (Ptr{Cvoid},), cond)
        return
    end
    try
        stream = managed.stream
        AMDGPU.context!(stream.ctx) do
            # a destroyed stream may still have work in flight. our streams are blocking,
            # so the default stream waits for that work.
            HIP.isvalid(stream) || (stream = AMDGPU.default_stream())
            if HIP.is_capturing(stream)
                # a host function launched on a capturing stream would become part of the
                # graph, so retry after the capture. finalizers can't switch tasks, but
                # they can schedule them. note that this can't be checked atomically, so a
                # capture started concurrently by another thread may still record it.
                @async begin
                    while AMDGPU.context!(() -> HIP.is_capturing(stream), stream.ctx)
                        sleep(0.01)
                    end
                    release_when_done(managed, release, cond, done)
                end
            elseif !GC.in_finalizer() && HIP.query(stream) == HIP.hipSuccess
                # freed explicitly after the device is done with the memory: release it now
                release()
                ccall(:uv_async_send, Cint, (Ptr{Cvoid},), cond)
            else
                # another stream may be capturing, which launching on this one doesn't affect
                HIP.relaxed_capture_mode() do
                    HIP.hipLaunchHostFunc(stream, cglobal(:uv_async_send), cond)
                end
                # when freed explicitly, wait for the release, so that the memory can be
                # wrapped again right away
                GC.in_finalizer() || wait_for_release(done, stream)
            end
        end
    catch ex
        Base.showerror_nostdio(ex, "WARNING: Error while releasing wrapped memory; leaking it")
        Base.show_backtrace(Core.stdout, catch_backtrace())
        Core.println()
    end
    return
end

function wait_for_release(done::Threads.Atomic{Bool}, stream::HIPStream)
    while !done[]
        # if the device fails, the host function never runs
        HIP.isvalid(stream) || return
        status = HIP.query(stream)
        (status == HIP.hipSuccess || status == HIP.hipErrorNotReady) || return
        sleep(0.001)
    end
    return
end

function release_host_memory(managed::Managed{Mem.HostBuffer}, own::Bool)
    buf = managed.mem
    try
        if own
            pool_free(managed)
        else
            AMDGPU.context!(() -> Mem.unregister(buf.ptr), buf.ctx)
        end
    catch ex
        @error "Error while releasing $(Base.format_bytes(buf.bytesize)) of wrapped host memory" exception=(ex, catch_backtrace())
    end
    return
end

Base.unsafe_wrap(::Type{<:ROCArray}, ptr::Ptr, dim::Integer; own::Bool=false) =
    unsafe_wrap(ROCArray, ptr, (dim,); own)

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims::NTuple{N, <:Integer}; kwargs...) where {T, N} =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

# array input: keep the array alive for as long as the wrapper
Base.unsafe_wrap(::Union{Type{ROCArray}, Type{ROCArray{T}}, Type{ROCArray{T, N}}},
                 a::Array{T, N}) where {T, N} =
    wrap_memory(pointer(a), size(a), false, a)

"""
    unsafe_wrap(Array, a::ROCArray)

Wrap an `Array` around the memory of a `ROCArray`, without copying it. This is only
possible for arrays backed by host memory, i.e., with buffer type `Mem.HostBuffer`.

!!! warning

    The returned `Array` does **not** keep the `ROCArray` alive. The caller has to keep a
    reference to the `ROCArray` for as long as the `Array`, or anything derived from it,
    is used; otherwise the `Array` may end up referring to freed memory. Device operations
    execute asynchronously, so synchronize before accessing the returned array.
"""
function Base.unsafe_wrap(::Type{Array}, a::ROCArray{T, N, Mem.HostBuffer}) where {T, N}
    ptr = convert(Ptr{T}, a.buf[].mem.ptr) + a.offset
    return unsafe_wrap(Array, ptr, size(a))
end
Base.unsafe_wrap(::Type{Array}, a::ROCArray) =
    throw(ArgumentError("Can only wrap an Array around a ROCArray backed by host memory"))

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

"""
    roc(x)

Adapt `x` for the GPU: convert arrays to [`ROCArray`](@ref) while **narrowing
floating-point element types to 32-bit** (`Float64`→`Float32`,
`ComplexF64`→`ComplexF32`; `Float16` is left unchanged, other element types are
preserved). Like `Adapt.adapt`, it recurses into custom structs and converts
their array fields.

This mirrors CUDA.jl's `cu`. Reach for it when single precision is preferred
(e.g. for performance); use the [`ROCArray`](@ref) constructor directly to keep
the original element type.

```julia
roc([1.0, 2.0])    # 2-element ROCArray{Float32}
roc(1:3)           # non-float eltype preserved: ROCArray{Int64}
```
"""
roc(xs) = adapt(Float32Adaptor(), xs)

Base.unsafe_convert(typ::Type{Ptr{T}}, x::ROCArray{T}) where T =
    convert(typ, x.buf[]) + x.offset

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
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset)
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr)
end

function Adapt.adapt_storage(to::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N}
    managed = x.buf[]
    to.stream === nothing || take_ownership_fast!(managed, to.stream)
    buf = managed.mem
    ptr = convert(Ptr{T}, typeof(buf) <: Mem.HIPBuffer ? buf : buf.dev_ptr)
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + x.offset)
    return ROCDeviceArray{T, N, AS.Global}(x.dims, llvm_ptr)
end
