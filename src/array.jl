"""
    ROCArray{T,N,B} <: AbstractGPUArray{T,N}

`N`-dimensional dense array of element type `T` stored in GPU-accessible memory of
type `B`. `ROCArray` implements Julia's `AbstractArray` interface, so
broadcasting, reductions, and linear algebra run on the GPU.

The memory type `B` is one of:

- `Mem.HIPBuffer`: device memory (the default, see [`AMDGPU.default_memory`](@ref));
- `Mem.UnifiedBuffer`: unified memory, accessible from both the CPU and the GPU;
- `Mem.HostBuffer`: page-locked host memory that the GPU can access.

Copy a host array to the device by wrapping it, or allocate directly:

```julia
ROCArray([1, 2, 3])             # copy a host array to the device
ROCArray{Float32}(undef, 4, 4)  # uninitialized 4×4 device matrix
ROCArray{Float32, 2, AMDGPU.Mem.UnifiedBuffer}(undef, 4, 4)  # in unified memory
```

Move data back to the host with `Array(x)`. See also [`roc`](@ref), which
copies to the device while narrowing floating-point types to 32-bit, and the
`AMDGPU.zeros` / `AMDGPU.ones` / `AMDGPU.rand` constructors.
"""
mutable struct ROCArray{T, N, B} <: AbstractGPUArray{T, N}
    buf::DataRef{Managed{B}}
    dims::Dims{N}
    offset::Int  # offset of the data in memory, in bytes
    # size of the data in memory, in bytes, excluding any selector bytes. for arrays of
    # isbits unions, this is where the array's selector bytes start (see `typetagdata`)
    maxsize::Int

    function ROCArray{T, N, B}(::UndefInitializer, dims::Dims{N}) where {T, N, B <: Mem.AbstractAMDBuffer}
        check_eltype("ROCArray", T)
        maxsize::Int64 = prod(dims) * aligned_sizeof(T)
        # arrays of isbits unions keep one selector byte per element past the data
        bufsize = Base.isbitsunion(T) ? maxsize + prod(dims) : maxsize
        ref = GPUArrays.cached_alloc((ROCArray, AMDGPU.device(), B, bufsize)) do
            @debug "Allocate `T=$T`, `dims=$dims`: $(Base.format_bytes(bufsize))"
            DataRef(pool_free, pool_alloc(B, bufsize))
        end
        return finalizer(unsafe_free!, new{T, N, B}(ref, dims, 0, maxsize))
    end

    function ROCArray{T, N}(buf::DataRef{Managed{B}}, dims::Dims{N};
                            maxsize::Integer = prod(dims) * aligned_sizeof(T),
                            offset::Integer = 0) where {T, N, B <: Mem.AbstractAMDBuffer}
        check_eltype("ROCArray", T)
        xs = new{T, N, B}(buf, dims, offset, maxsize)
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
#    these are stored contiguously, with one selector byte per element past the data
#    (handled by us, see `typetagdata`)
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
    # the selector bytes are indexed by element, so advance them here: the byte offset
    # can't tell how many elements of zero size (like unions of singletons) were skipped.
    # union arrays only derive arrays of the same element type, as `reinterpret` rejects them
    maxsize = Base.isbitsunion(T) ? x.maxsize + offset : x.maxsize
    offset = x.offset + offset * aligned_sizeof(T)
    ROCArray{T, N}(ref, dims; maxsize, offset)
end

"""
    device(A::ROCArray) -> HIPDevice

Return the device associated with the array `A`.
"""
device(A::ROCArray) = A.buf[].mem.device

## synchronization

"""
    synchronize(A::ROCArray)

Wait until the operations on the stream that last used the memory of `A` have completed.
"""
synchronize(A::ROCArray) = synchronize(A.buf[])

"""
    enable_synchronization!(A::ROCArray, enable::Bool=true) -> A

By default, using a `ROCArray` on another stream than the one that used it last (launching
a kernel, copying, or taking its pointer) first synchronizes that stream from the host, so
that operations on different streams are ordered. This may be unwanted when, e.g., disjoint
parts of an array are processed concurrently on different streams. This function disables
(`enable=false`) or re-enables this implicit synchronization. The memory is still recorded
as used by the stream that uses it last.

!!! warning

    This affects all `ROCArray`s that refer to the same memory (e.g. views and reshapes).
    While implicit synchronization is disabled, ordering operations on different streams,
    and synchronizing before accessing the memory from the host or freeing it, is up to the
    user: unsafe use results in data races. Re-enabling it does not wait for operations
    that used the memory on other streams in the meantime.

See also [`AMDGPU.synchronization_enabled`](@ref), [`AMDGPU.synchronize`](@ref).
"""
function enable_synchronization!(A::ROCArray, enable::Bool=true)
    managed = A.buf[]
    Base.@lock managed.lock managed.synchronizing = enable
    return A
end

"""
    synchronization_enabled(A::ROCArray) -> Bool

Whether the implicit synchronization of the memory of `A` is enabled
(see [`AMDGPU.enable_synchronization!`](@ref)).
"""
synchronization_enabled(A::ROCArray) = A.buf[].synchronizing

"""
    AMDGPU.memory_type(A::ROCArray)
    AMDGPU.memory_type(::Type{<:ROCArray})

The type of memory that backs `A`: `Mem.HIPBuffer` (device memory), `Mem.UnifiedBuffer`
or `Mem.HostBuffer`. See also [`is_device`](@ref), [`is_unified`](@ref), [`is_host`](@ref).
"""
memory_type(x::ROCArray) = memory_type(typeof(x))
memory_type(::Type{<:ROCArray{<:Any, <:Any, B}}) where B = B
memory_type(::Type{<:ROCArray}) = Any

const buftype = memory_type

"""
    is_device(A::ROCArray) -> Bool

Whether `A` is backed by device memory (`Mem.HIPBuffer`), which only the GPU can access.
"""
is_device(a::ROCArray) = memory_type(a) == Mem.HIPBuffer

"""
    is_unified(A::ROCArray) -> Bool

Whether `A` is backed by unified memory (`Mem.UnifiedBuffer`), which both the CPU and the
GPU can access.
"""
is_unified(a::ROCArray) = memory_type(a) == Mem.UnifiedBuffer

"""
    is_host(A::ROCArray) -> Bool

Whether `A` is backed by page-locked host memory (`Mem.HostBuffer`) that the GPU can access.
"""
is_host(a::ROCArray) = memory_type(a) == Mem.HostBuffer

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

"""
    AMDGPU.default_memory

The type of memory that backs a `ROCArray` when none is specified, as in
`ROCArray{Float32}(undef, 4)` or `ROCArray([1, 2, 3])`: `Mem.HIPBuffer` (device memory)
unless changed with the `default_memory` preference, which can be set to `"device"`,
`"unified"` or `"host"`:

```julia
using Preferences, AMDGPU
set_preferences!(AMDGPU, "default_memory" => "unified")  # takes effect after a restart
```
"""
const default_memory = let str = @load_preference("default_memory", "device")
    if str == "device"
        Mem.HIPBuffer
    elseif str == "unified"
        Mem.UnifiedBuffer
    elseif str == "host"
        Mem.HostBuffer
    else
        error("unknown default memory type: $str")
    end
end

# unspecified memory type
function ROCArray{T,N}(::UndefInitializer, dims::Dims{N}) where {T,N}
    ROCArray{T, N, default_memory}(undef, dims)
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
    return (UInt(Mem.device_ptr(x.buf[].mem)), x.offset)
end

Base.unaliascopy(x::ROCArray) = copy(x)

## interop with Julia arrays

function ROCArray{T,N,B}(x::AbstractArray{<:Any,N}) where {T,N,B}
    r = ROCArray{T,N,B}(undef, size(x))
    copyto!(r, convert(Array{T}, x))
    return r
end

ROCArray{T,N}(x::AbstractArray{<:Any,N}) where {T,N} = ROCArray{T,N,default_memory}(x)

# keep the memory type of the source
ROCArray{T,N}(xs::ROCArray{<:Any,N,B}) where {T,N,B} = ROCArray{T,N,B}(xs)

# underspecified constructors
ROCArray(A::AbstractArray{T,N}) where {T,N} = ROCArray{T,N}(A)
ROCArray{T}(xs::AbstractArray{S,N}) where {T,N,S} = ROCArray{T,N}(xs)
(::Type{ROCArray{T,N} where T})(x::AbstractArray{S,N}) where {S,N} = ROCArray{S,N}(x)

# copy xs to match Array behavior
ROCArray{T,N,B}(xs::ROCArray{T,N,B}) where {T,N,B} = copy(xs)
ROCArray{T,N}(xs::ROCArray{T,N,B}) where {T,N,B} = copy(xs)

Base.convert(::Type{T}, x::T) where T <: ROCArray = x

## type tags of isbits-union arrays

# Arrays of isbits unions (`Union{Int, Nothing}`, ...) store one selector byte per element
# past the data, `maxsize` bytes into the memory, like `Array` does. The selector is the
# zero-based index of the element's type in `Base.uniontypes(T)`.

@static if VERSION >= v"1.11.0-DEV.753"
function typetagdata(a::Array, i=1)
    # for memory of isbits unions, the reference holds the offset of the data in elements
    ptr_or_offset = Int(a.ref.ptr_or_offset)
    @ccall(jl_genericmemory_typetagdata(a.ref.mem::Any)::Ptr{UInt8}) + ptr_or_offset + i - 1
end
else
typetagdata(a::Array, i=1) = ccall(:jl_array_typetagdata, Ptr{UInt8}, (Any,), a) + i - 1
end

# the address of the selector byte of element `i`, to use on the device (`Mem.HIPBuffer`)
# or on the host (`Mem.HostBuffer`), see `pointer`
function typetagdata(a::ROCArray, i=1; type=Mem.HIPBuffer)
    ptr = if type == Mem.HIPBuffer
        convert(Ptr{UInt8}, a.buf[])
    elseif type == Mem.HostBuffer
        host_pointer(Ptr{UInt8}, a.buf[])
    else
        throw_pointer_type(type)
    end
    return ptr + a.maxsize + i - 1
end

# `type` says where a pointer is going to be used, not what kind of memory backs the array:
# an array in unified memory has a device pointer and a host pointer too (which are equal)
@noinline throw_pointer_type(type) = throw(ArgumentError(
    """invalid pointer type `$type`. The `type` keyword says where the pointer is used:        `Mem.HIPBuffer` for a pointer to use on the GPU, or `Mem.HostBuffer` for a pointer        to use on the CPU (only available for arrays in unified or host memory)."""))

## pointers

"""
    pointer(::ROCArray, [index=1]; [type=Mem.HIPBuffer])

Get the native address of a `ROCArray`, optionally at a given location `index`.

The `type` argument indicates where the pointer will be used: `type=Mem.HIPBuffer` (the
default) gives a pointer for use on the GPU, e.g. by HIP library functions, and
`type=Mem.HostBuffer` gives a pointer for use on the CPU, after waiting for the GPU to
finish the operations that use the array. The latter is only possible for arrays that are
backed by unified or host memory, and throws an `ArgumentError` otherwise.

!!! note

    The `type` argument says where the pointer is used, which is separate from the type of
    memory that backs the array. Arrays backed by `Mem.UnifiedBuffer` or `Mem.HostBuffer`
    can be accessed from both the CPU and GPU, so both types are valid for them (for
    unified memory they give the same address, for host memory different ones). That also
    implies it is not valid to pass `type=Mem.UnifiedBuffer`, as this does not indicate
    where the pointer is used.
"""
@inline function Base.pointer(x::StridedROCArray{T}, i::Integer=1; type=Mem.HIPBuffer) where T
    ptr = if type == Mem.HIPBuffer
        Base.unsafe_convert(Ptr{T}, x)
    elseif type == Mem.HostBuffer
        host_pointer(x)
    else
        throw_pointer_type(type)
    end
    return ptr + Base._memory_offset(x, i)
end

host_pointer(x::ROCArray{T}) where T = host_pointer(Ptr{T}, x.buf[]) + x.offset
host_pointer(V::SubArray{T,N,P,<:Tuple{Vararg{Base.RangeIndex}}}) where {T,N,P<:ROCArray} =
    host_pointer(parent(V)) + Base._memory_offset(parent(V), map(first, V.indices)...)
host_pointer(V::StridedSubROCArray{T}) where T =
    host_pointer(parent(V)) + (Base.first_index(V) - 1) * aligned_sizeof(T)

## indexing

# Unified and host memory can be accessed from the CPU, so indexing scalars does not
# need to copy from the device (and thus isn't subject to `allowscalar`).
const HostAccessibleBuffer = Union{Mem.UnifiedBuffer, Mem.HostBuffer}

function Base.getindex(x::ROCArray{T, <:Any, <:HostAccessibleBuffer}, I::Int) where T
    @boundscheck checkbounds(x, I)
    # the selector bytes of isbits unions are stored separately, so let `copyto!` handle them
    Base.isbitsunion(T) && return @inbounds copyto!(Array{T}(undef, 1), 1, x, I, 1)[1]
    GC.@preserve x unsafe_load(pointer(x, I; type=Mem.HostBuffer))
end

function Base.setindex!(x::ROCArray{T, <:Any, <:HostAccessibleBuffer}, v, I::Int) where T
    @boundscheck checkbounds(x, I)
    if Base.isbitsunion(T)
        @inbounds copyto!(x, I, T[v], 1, 1)
    else
        GC.@preserve x unsafe_store!(pointer(x, I; type=Mem.HostBuffer), v)
    end
    return x
end

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
    GC.@preserve dest source begin
        Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stm)
        if Base.isbitsunion(T)
            Mem.memcpy!(typetagdata(dest, d_offset), typetagdata(source, s_offset), amount; stream=stm)
        end
    end
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
    stm = stream()
    GC.@preserve dest source begin
        Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stm)
        if Base.isbitsunion(T)
            Mem.memcpy!(typetagdata(dest, d_offset), typetagdata(source, s_offset), amount; stream=stm)
        end
    end
    return dest
end

function Base.copyto!(
    dest::ROCArray{T}, d_offset::Integer,
    source::ROCArray{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    stm = stream()
    GC.@preserve dest source begin
        Mem.memcpy!(pointer(dest, d_offset), pointer(source, s_offset), amount * aligned_sizeof(T); stream=stm)
        if Base.isbitsunion(T)
            Mem.memcpy!(typetagdata(dest, d_offset), typetagdata(source, s_offset), amount; stream=stm)
        end
    end
    return dest
end

# optimization: memcpy on the CPU for Array <-> unified or host arrays, which saves a
# round trip through the HIP runtime. taking the host pointer waits for the device.

function Base.copyto!(
    dest::Array{T}, d_offset::Integer,
    source::ROCArray{T, <:Any, <:HostAccessibleBuffer}, s_offset::Integer, amount::Integer;
    async::Bool = false,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    GC.@preserve dest source begin
        unsafe_copyto!(pointer(dest, d_offset),
                       pointer(source, s_offset; type=Mem.HostBuffer), amount)
        if Base.isbitsunion(T)
            unsafe_copyto!(typetagdata(dest, d_offset),
                           typetagdata(source, s_offset; type=Mem.HostBuffer), amount)
        end
    end
    return dest
end

function Base.copyto!(
    dest::ROCArray{T, <:Any, <:HostAccessibleBuffer}, d_offset::Integer,
    source::Array{T}, s_offset::Integer, amount::Integer,
) where T
    amount == 0 && return dest
    @boundscheck checkbounds(dest, d_offset + amount - 1)
    @boundscheck checkbounds(source, s_offset + amount - 1)
    GC.@preserve dest source begin
        unsafe_copyto!(pointer(dest, d_offset; type=Mem.HostBuffer),
                       pointer(source, s_offset), amount)
        if Base.isbitsunion(T)
            unsafe_copyto!(typetagdata(dest, d_offset; type=Mem.HostBuffer),
                           typetagdata(source, s_offset), amount)
        end
    end
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
    # memset can't write the selector bytes of unions of these types
    Base.isbitsunion(T) && return invoke(fill!, Tuple{GPUArrays.AnyGPUArray, Any}, A, x)
    isempty(A) && return A
    U = memset_type(T)
    Mem.memset!(pointer(A), reinterpret(U, convert(T, x)), length(A); stream=stream())
    return A
end

function Base.copy(X::ROCArray)
    # `similar` keeps the buffer type, so a copy of a host-memory array stays in host memory
    Xnew = similar(X)
    copyto!(Xnew, 1, X, 1, length(X))
    return Xnew
end

"""
    unsafe_wrap(ROCArray, ptr::Ptr{T}, dims; own=false)
    unsafe_wrap(ROCArray, a::Array)
    unsafe_wrap(ROCArray{T,N,B}, ptr::Ptr{T}, dims; own=false)
    unsafe_wrap(ROCArray{T,N,B}, a::Array)

Wrap a `ROCArray` around existing memory, without copying it. `ptr` can point to device
memory, to unified memory or to host memory; host memory that is not yet page-locked is
registered with `hipHostRegister` for as long as the wrapper exists, which can be slow.

The memory type `B` of the wrapper is that of the memory (`Mem.HostBuffer` for host
memory), and an `ArgumentError` is thrown if another one is asked for. The exception is
`B = Mem.UnifiedBuffer` for host memory that HIP does not manage, which wraps it as unified
memory without registering it. This needs a device that can access pageable host memory
(`hipDeviceAttributePageableMemoryAccess`) and throws an `ArgumentError` on others.

When wrapping an `Array`, the returned `ROCArray` keeps it alive. When wrapping a pointer,
the caller has to keep the memory valid for as long as the `ROCArray` is used. If `own` is
set, the memory is freed (or, for registered host memory, unregistered) when the
`ROCArray` is freed, as soon as the device is done using it.

Device operations execute asynchronously, so synchronize (e.g., using
`AMDGPU.synchronize()`) before accessing wrapped host memory on the host.
"""
function Base.unsafe_wrap(
    AT::Type{<:ROCArray}, ptr::Ptr{T}, dims::NTuple{N, <:Integer};
    own::Bool = false,
) where {T,N}
    return wrap_memory(ptr, dims, own, nothing, memory_type(AT))
end

# whether kernels can access host memory that HIP does not know about
supports_hmm(dev::HIPDevice) =
    HIP.attribute(dev, HIP.hipDeviceAttributePageableMemoryAccess) == 1

# `owner` is kept alive for as long as the wrapper
# `requested` is the memory type that was asked for, or `Any`
function wrap_memory(ptr::Ptr{T}, dims::NTuple{N, <:Integer}, own::Bool,
                     owner = nothing, requested = Any) where {T,N}
    check_eltype("unsafe_wrap(ROCArray, ...)", T)
    # the selector bytes of such arrays live past the data, outside of the wrapped memory
    Base.isbitsunion(T) && throw(ArgumentError(
        "unsafe_wrap(ROCArray, ...) does not support isbits-union element types like $T"))

    attrs = Mem.pointer_attributes(Ptr{Cvoid}(ptr))
    memtype = attrs.type
    B = if Mem.is_managed(attrs)
        Mem.UnifiedBuffer
    elseif memtype == HIP.hipMemoryTypeUnregistered
        Mem.HostBuffer
    elseif memtype == HIP.hipMemoryTypeHost
        Mem.HostBuffer
    elseif memtype == HIP.hipMemoryTypeDevice
        Mem.HIPBuffer
    else
        error("Unsupported memory type `$memtype` for pointer.")
    end
    if requested !== Any && requested != B
        if requested == Mem.UnifiedBuffer && memtype == HIP.hipMemoryTypeUnregistered
            # devices that can access pageable memory treat host memory as unified memory
            supports_hmm(AMDGPU.device()) || throw(ArgumentError(
                "Cannot wrap system memory as unified memory on your system"))
            B = Mem.UnifiedBuffer
        else
            kind = B == Mem.HIPBuffer ? "device" : B == Mem.UnifiedBuffer ? "unified" : "host"
            throw(ArgumentError("Cannot wrap $kind memory as $requested"))
        end
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
        used = managed.stream
        AMDGPU.context!(used.ctx) do
            # a destroyed stream may still have work in flight. our streams are blocking,
            # so the default stream waits for that work.
            stream = HIP.isvalid(used) ? used : AMDGPU.default_stream()
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

Base.unsafe_wrap(AT::Type{<:ROCArray}, ptr::Ptr, dim::Integer; own::Bool=false) =
    unsafe_wrap(AT, ptr, (dim,); own)

Base.unsafe_wrap(::Type{ROCArray{T}}, ptr::Ptr, dims::NTuple{N, <:Integer}; kwargs...) where {T, N} =
    unsafe_wrap(ROCArray, Base.unsafe_convert(Ptr{T}, ptr), dims; kwargs...)

# array input: keep the array alive for as long as the wrapper
Base.unsafe_wrap(::Union{Type{ROCArray}, Type{ROCArray{T}}, Type{ROCArray{T, N}}},
                 a::Array{T, N}) where {T, N} =
    wrap_memory(pointer(a), size(a), false, a)
Base.unsafe_wrap(::Type{ROCArray{T, N, B}}, a::Array{T, N}) where {T, N, B} =
    wrap_memory(pointer(a), size(a), false, a, B)

"""
    unsafe_wrap(Array, a::ROCArray)

Wrap an `Array` around the memory of a `ROCArray`, without copying it. This is only
possible for arrays backed by unified or host memory, i.e., with memory type
`Mem.UnifiedBuffer` or `Mem.HostBuffer`.

!!! warning

    The returned `Array` does **not** keep the `ROCArray` alive. The caller has to keep a
    reference to the `ROCArray` for as long as the `Array`, or anything derived from it,
    is used; otherwise the `Array` may end up referring to freed memory. Device operations
    execute asynchronously: wrapping waits for the ones that have been launched, but
    after using the `ROCArray` again, synchronize (e.g., using `AMDGPU.synchronize(a)`)
    before accessing the returned array.
"""
function Base.unsafe_wrap(
    ::Union{Type{Array}, Type{Array{T}}, Type{Array{T, N}}},
    a::ROCArray{T, N, <:HostAccessibleBuffer},
) where {T, N}
    # an `Array` keeps its selector bytes elsewhere than the `ROCArray` does
    Base.isbitsunion(T) && throw(ArgumentError(
        "unsafe_wrap(Array, ...) does not support isbits-union element types like $T"))
    return unsafe_wrap(Array, pointer(a; type=Mem.HostBuffer), size(a))
end
Base.unsafe_wrap(::Union{Type{Array}, Type{Array{T}}, Type{Array{T, N}}},
                 a::ROCArray{T, N}) where {T, N} =
    throw(ArgumentError("Can only create a CPU array object from a unified or host ROCArray"))

## interop with CPU arrays

# We don't convert isbits types in `adapt`, since they are already
# considered GPU-compatible.

# Type parameters that are specified are preserved, the others are taken from the source
# array (or the default buffer type). Any subset can be given, e.g. `ROCArray{<:Any,<:Any,B}`.
adapt_eltype(::Type{<:ROCArray{T}}, xs) where {T} = T
adapt_eltype(::Type{<:ROCArray}, xs) = eltype(xs)
adapt_ndims(::Type{<:ROCArray{<:Any,N}}, xs) where {N} = N
adapt_ndims(::Type{<:ROCArray}, xs) = ndims(xs)
adapt_buftype(::Type{<:ROCArray{<:Any,<:Any,B}}, xs) where {B} = B
adapt_buftype(::Type{<:ROCArray}, xs) = xs isa ROCArray ? memory_type(xs) : default_memory

function Adapt.adapt_storage(::Type{A}, xs::AT) where {A<:ROCArray,AT<:AbstractArray}
    isbitstype(AT) && return xs
    B = ROCArray{adapt_eltype(A, xs),adapt_ndims(A, xs),adapt_buftype(A, xs)}
    # parameters taken from the source may violate bounds in `A`, e.g. `ROCArray{<:Real}`
    B <: A || throw(ArgumentError("cannot adapt a $AT to $A"))
    return convert(B, xs)
end

Adapt.adapt_storage(::Type{Array}, xs::ROCArray) = convert(Array, xs)


## Float32-preferring conversion

# `B` is the type of memory that backs the converted arrays. If it is `Nothing`, arrays
# that are already `ROCArray`s keep their memory, and other arrays use the default one.
struct Float32Adaptor{B} end
Float32Adaptor() = Float32Adaptor{Nothing}()

adapt_buftype(::Float32Adaptor{Nothing}, xs) = adapt_buftype(ROCArray, xs)
adapt_buftype(::Float32Adaptor{B}, xs) where {B} = B

# like the constructors, but without copying arrays that already have the right type
float32_adapt(to::Float32Adaptor, ::Type{T}, xs::AbstractArray{<:Any,N}) where {T,N} =
    isbits(xs) ? xs : convert(ROCArray{T,N,adapt_buftype(to, xs)}, xs)

Adapt.adapt_storage(to::Float32Adaptor, xs::AbstractArray{T}) where {T} =
    float32_adapt(to, T, xs)
Adapt.adapt_storage(to::Float32Adaptor, xs::AbstractArray{<:AbstractFloat}) =
    float32_adapt(to, Float32, xs)
Adapt.adapt_storage(to::Float32Adaptor, xs::AbstractArray{<:Complex{<:AbstractFloat}}) =
    float32_adapt(to, ComplexF32, xs)

# not for Float16
Adapt.adapt_storage(to::Float32Adaptor, xs::AbstractArray{Float16}) =
    float32_adapt(to, Float16, xs)

"""
    roc(x; device=false, unified=false, host=false)

Adapt `x` for the GPU: convert arrays to [`ROCArray`](@ref) while **narrowing
floating-point element types to 32-bit** (`Float64`→`Float32`,
`ComplexF64`→`ComplexF32`; `Float16` is left unchanged, other element types are
preserved). Like `Adapt.adapt`, it recurses into custom structs and converts
their array fields.

The keyword arguments select the type of memory that backs the arrays: `device`
for device memory, `unified` for unified memory that both the CPU and the GPU can
access, and `host` for page-locked host memory. At most one of them can be set;
by default, arrays use the [`AMDGPU.default_memory`](@ref), and arrays that are
already `ROCArray`s keep their memory.

This mirrors CUDA.jl's `cu`. Reach for it when single precision is preferred
(e.g. for performance); use the [`ROCArray`](@ref) constructor directly to keep
the original element type.

```julia
roc([1.0, 2.0])                # 2-element ROCArray{Float32}
roc(1:3)                       # non-float eltype preserved: ROCArray{Int64}
roc([1.0, 2.0]; unified=true)  # backed by unified memory
```
"""
@inline function roc(xs; device::Bool=false, unified::Bool=false, host::Bool=false)
    if device + unified + host > 1
        throw(ArgumentError("Can only specify one of `device`, `unified`, or `host`"))
    end
    memory = if device
        Mem.HIPBuffer
    elseif unified
        Mem.UnifiedBuffer
    elseif host
        Mem.HostBuffer
    else
        Nothing
    end
    adapt(Float32Adaptor{memory}(), xs)
end

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

The new storage has the same memory type as `a`, so an array in unified or host memory
stays in that kind of memory. Resizing always allocates new memory,
which detaches `a` from memory it was wrapped around with `unsafe_wrap`.
"""
function Base.resize!(A::ROCVector{T, B}, n::Integer) where {T, B}
    n == length(A) && return A

    maxsize = n * aligned_sizeof(T)
    # arrays of isbits unions keep one selector byte per element past the data
    bufsize = Base.isbitsunion(T) ? maxsize + n : maxsize
    managed = pool_alloc(B, bufsize)

    # copy the existing elements, and their selector bytes.
    # `convert(Ptr, managed)` gives the device-visible pointer for host memory
    m = min(length(A), n)
    if m > 0
        Mem.memcpy!(convert(Ptr{T}, managed), pointer(A), m * aligned_sizeof(T); stream=stream())
        if Base.isbitsunion(T)
            Mem.memcpy!(convert(Ptr{UInt8}, managed) + maxsize, typetagdata(A), m; stream=stream())
        end
    end
    unsafe_free!(A)

    A.buf = DataRef(pool_free, managed)
    A.dims = (n,)
    A.offset = 0
    A.maxsize = maxsize
    return A
end

# @roc conversion

# the device array addresses its selector bytes relative to its first element
device_maxsize(a::ROCArray) = a.maxsize - a.offset

function Base.convert(
    ::Type{ROCDeviceArray{T, N, AS.Global}}, a::ROCArray{T, N},
) where {T, N}
    buf = convert(Mem.AbstractAMDBuffer, a.buf[])
    ptr = convert(Ptr{T}, Mem.device_ptr(buf))
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset)
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr, device_maxsize(a))
end

function Adapt.adapt_storage(to::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N}
    managed = x.buf[]
    to.stream === nothing || take_ownership_fast!(managed, to.stream)
    buf = managed.mem
    ptr = convert(Ptr{T}, Mem.device_ptr(buf))
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + x.offset)
    return ROCDeviceArray{T, N, AS.Global}(x.dims, llvm_ptr, device_maxsize(x))
end

# CPU arrays would otherwise only be rejected by the compiler, with an error that dumps the
# full argument type
Adapt.adapt_storage(::Runtime.Adaptor, xs::Array) =
    throw(ArgumentError("""cannot use a CPU array ($(typeof(xs))) in an AMDGPU kernel.
                           Convert it to a GPU array first, e.g. using `ROCArray(x)`."""))

## fine-grained memory

"""
    AMDGPU.uses_fine_grained_memory(x) -> Bool

Whether `x` is, wraps or holds (in a field, or a variable that a closure captures) a
`ROCArray` backed by fine-grained memory: unified memory, or host memory such as
`unsafe_wrap` gives.
Kernels that use such arrays are compiled without the `atomic_memory_assumptions`.

Only immutable structs, tuples and `Ref`s are searched, like when converting kernel arguments.
"""
@inline uses_fine_grained_memory(::ROCArray{<:Any, <:Any, B}) where {B} = Mem.is_fine_grained(B)
uses_fine_grained_memory(r::Base.RefValue) = isassigned(r) && uses_fine_grained_memory(r[])
@generated function uses_fine_grained_memory(x::T) where {T}
    # only fields that can hold an array are looked at, and the memory type of an array is
    # part of its type, so that this folds to a constant for concretely typed arguments:
    # it runs on every kernel launch
    can_hold_arrays(T) || return false
    ex = false
    for i in 1:fieldcount(T)
        FT = fieldtype(T, i)
        isconcretetype(FT) && !(FT <: ROCArray) && !can_hold_arrays(FT) && continue
        ex = :($ex || (isdefined(x, $i) && uses_fine_grained_memory(getfield(x, $i))))
    end
    return :(Base.@_inline_meta; $ex)
end

# immutable structs (which includes tuples and closures) with fields that aren't plain data
can_hold_arrays(@nospecialize(T)) =
    T isa DataType && isstructtype(T) && !ismutabletype(T) && !isbitstype(T)
