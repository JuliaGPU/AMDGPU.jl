# Raw memory management
# Copied from CUDAdrv.jl

# NOTE: Mostly implemented for compatibility and ease-of-use, however we're
# currently not nearly as featureful as the original, which should change
# where possible.

export Mem

module Mem

using ..HSARuntime
using ..HSARuntime.HSA
import HSARuntime: check, get_region, AGENTS

## buffer type

struct Buffer
    ptr::Ptr{Cvoid}
    bytesize::Int
    agent::HSAAgent
    coherent::Bool
end

Base.unsafe_convert(::Type{Ptr{T}}, buf::Buffer) where {T} = convert(Ptr{T}, buf.ptr)

function view(buf::Buffer, bytes::Int)
    bytes > buf.bytesize && throw(BoundsError(buf, bytes))
    return Buffer(buf.ptr+bytes, buf.bytesize-bytes, buf.agent)
end

## refcounting

const refcounts = Dict{Buffer, Int}()

function refcount(buf::Buffer)
    get(refcounts, Base.unsafe_convert(Ptr{Cvoid}, buf), 0)
end

"""
    retain(buf)

Increase the refcount of a buffer.
"""
function retain(buf::Buffer)
    refcount = get!(refcounts, buf, 0)
    refcounts[buf] = refcount + 1
    return
end

"""
    release(buf)

Decrease the refcount of a buffer. Returns `true` if the refcount has dropped to 0, and
some action needs to be taken.
"""
function release(buf::Buffer)
    haskey(refcounts, buf) || error("Release of unmanaged $buf")
    refcount = refcounts[buf]
    @assert refcount > 0 "Release of dead $buf"
    refcounts[buf] = refcount - 1
    return refcount==1
end


## memory info

"""
    info()

Returns a tuple of two integers, indicating respectively the free and total amount of memory
(in bytes) available for allocation on the agent.
"""
function info()
    free_ref = Ref{Csize_t}()
    total_ref = Ref{Csize_t}()
    # FIXME: I'm not sure HSA has an API for this...
    return convert(Int, free_ref[]), convert(Int, total_ref[])
end

"""
    free()

Returns the free amount of memory (in bytes), available for allocation on the agent.
"""
free() = info()[1]

"""
    total()

Returns the total amount of memory (in bytes), available for allocation on the agent.
"""
total() = info()[2]

"""
    used()

Returns the used amount of memory (in bytes), allocated on the agent.
"""
used() = total()-free()

"""
    pointerinfo(ptr::Ptr)
    pointerinfo(buf::Buffer)
    pointerinfo(a::Array)

Retrieve information about the allocation referenced by the given pointer.
"""
function pointerinfo(ptr::Ptr)
    ptrinfo = Ref{HSA.PointerInfo}()

    HSA.amd_pointer_info(Ptr{Cvoid}(ptr), ptrinfo, C_NULL, Ptr{UInt32}(C_NULL), C_NULL) |> check

    return ptrinfo[]
end
pointerinfo(buf::Buffer) = pointerinfo(buf.ptr)
pointerinfo(a::Array) = pointerinfo(pointer(a))

## Page-locking

"""
    lock(ptr::Ptr, bytesize::Integer, agent::HSAAgent)
    lock(ptr, bytesize)
    lock(a::Array, agent)
    lock(a)

Page-lock a host pointer allocated by the OS allocator and return a new pointer from
the given `agent`. For more information, see `hsa_amd_memory_lock()`.

See also: [`unlock`](@ref)
"""
function lock(ptr::Ptr, bytesize::Integer, agent::HSAAgent)
    plocked = Ref{Ptr{Cvoid}}()
    HSA.amd_memory_lock(Ptr{Cvoid}(ptr), bytesize, Ref(agent.agent), 1, plocked) |> check
    return plocked[]
end
lock(ptr, bytesize) = lock(ptr, bytesize, get_default_agent())
lock(a::Array, agent::HSAAgent) = lock(pointer(a), sizeof(a), agent)
lock(a::Array) = lock(pointer(a), sizeof(a), get_default_agent())

"""
    unlock(ptr::Ptr)
    unlock(a::Array)

Unlock the host pointer previously page-locked with [`lock`](@ref).
NB: `ptr` should be the original locked host pointer and not the pointer returned by `lock`!
"""
function unlock(ptr::Ptr)
    HSA.amd_memory_unlock(Ptr{Cvoid}(ptr)) |> check
end
unlock(a::Array) = unlock(pointer(a))

## generic interface (for documentation purposes)

"""
Allocate linear memory on the device and return a buffer to the allocated memory. The
allocated memory is suitably aligned for any kind of variable. The memory will not be freed
automatically, use [`free(::Buffer)`](@ref) for that.
"""
function alloc end

"""
Free device memory.
"""
function free end

"""
Initialize device memory with a repeating value.
"""
function set! end

"""
Upload memory from host to device.
Executed asynchronously on `queue` if `async` is true.
"""
function upload end
@doc (@doc upload) upload!

"""
Download memory from device to host.
Executed asynchronously on `queue` if `async` is true.
"""
function download end
@doc (@doc download) download!

"""
Transfer memory from device to device.
Executed asynchronously on `queue` if `async` is true.
"""
function transfer end
@doc (@doc transfer) transfer!


## pointer-based

"""
    alloc(bytes::Integer; coherent=false)
    alloc(agent::HSAAgent, bytes::Integer; coherent=false)

Allocate `bytesize` bytes of HSA-managed memory.
Allocations are not coherent by default, meaning that the allocated buffer is
only accessible from the given agent (the default agent if not specified).

If `coherent` is set to `true`, the allocated buffer will be accessible from
all HSA agents, including the host CPU.
This, even though convenient, can sometimes be slower than explicit memory transfers.
"""
function alloc(agent::HSAAgent, bytesize::Integer; coherent=false)
    bytesize == 0 && return Buffer(C_NULL, 0, agent, coherent)

    ptr_ref = Ref{Ptr{Cvoid}}()

    region_kind = if coherent
        :finegrained
    else
        :coarsegrained
    end

    region = get_region(agent, region_kind)
    check(HSA.memory_allocate(region[], bytesize, ptr_ref))
    return Buffer(ptr_ref[], bytesize, agent, coherent)
end
alloc(bytesize; kwargs...) = alloc(get_default_agent(), bytesize; kwargs...)

function free(buf::Buffer)
    if buf.ptr != C_NULL
        check(HSA.memory_free(buf.ptr))
    end
    return
end

"""
    set!(buf::Buffer, value::UInt32, len::Integer)

Write `len` copies of the 32-bit `value` at the start of `buf`.
"""
function set!(buf::Buffer, value::UInt32, len::Integer)
    HSA.amd_memory_fill(buf.ptr, value, len) |> check
end

"""
    upload!(dst::Buffer, src, nbytes::Integer)

Upload `nbytes` memory from `src` at the host to `dst` on the device.
"""
function upload!(dst::Buffer, src::Ptr{T}, nbytes::Integer) where T
    # Page-locking coherent memory results in a ReadOnlyMemoryError.
    plocked = if dst.coherent
        src
    else
        lock(src, nbytes, dst.agent)
    end

    HSA.memory_copy(Ptr{T}(dst.ptr), Ptr{T}(plocked), nbytes) |> check

    if !dst.coherent
        unlock(src)
    end
end

"""
    download!(dst::Ref, src::Buffer, nbytes::Integer)

Download `nbytes` memory from `src` on the device to `dst` on the host.
"""
function download!(dst::Ptr{T}, src::Buffer, nbytes::Integer) where T
    plocked = if src.coherent
        dst
    else
        lock(dst, nbytes, src.agent)
    end

    HSA.memory_copy(Ptr{T}(plocked), Ptr{T}(src.ptr), nbytes) |> check

    if !src.coherent
        unlock(dst)
    end
end

"""
    transfer!(dst::Buffer, src::Buffer, nbytes::Integer)

Transfer `nbytes` of device memory from `src` to `dst`.
"""
function transfer!(dst::Buffer, src::Buffer, nbytes::Integer)
    HSA.memory_copy(dst.ptr, src.ptr, nbytes) |> check
end

## array based

"""
    alloc(src::AbstractArray; alloc_kwargs...)

Allocate space to store the contents of `src`.
"""
function alloc(src::AbstractArray; alloc_kwargs...)
    return alloc(sizeof(src); alloc_kwargs...)
end

"""
    upload!(dst::Buffer, src::AbstractArray)

Upload the contents of an array `src` to `dst`.
"""
function upload!(dst::Buffer, src::AbstractArray)
    GC.@preserve src upload!(dst, pointer(src), sizeof(src))
end

"""
    upload(src::AbstractArray; alloc_kwargs...)::Buffer

Allocates space for and uploads the contents of an array `src`, returning a Buffer.
For the allocation keywoard arguments see [`alloc`](@ref).
"""
function upload(src::AbstractArray; alloc_kwargs...)
    dst = alloc(src; alloc_kwargs...)
    upload!(dst, src)
    return dst
end

"""
    download!(dst::AbstractArray, src::Buffer)

Downloads memory from `src` to the array at `dst`. The amount of memory downloaded is
determined by calling `sizeof` on the array, so it needs to be properly preallocated.
"""
function download!(dst::AbstractArray, src::Buffer)
    GC.@preserve dst download!(pointer(dst), src, sizeof(dst))
    return
end

## type based

function check_type(::Type{Buffer}, T)
    if isa(T, UnionAll) || T.abstract || !isconcretetype(T)
        throw(ArgumentError("cannot represent abstract or non-leaf object"))
    end
    Base.datatype_pointerfree(T) || throw(ArgumentError("cannot handle non-ptrfree objects"))
    sizeof(T) == 0 && throw(ArgumentError("cannot represent singleton objects"))
end

"""
    alloc(T::Type, [count::Integer=1]; alloc_kwargs...)

Allocate space for `count` objects of type `T`.
"""
function alloc(::Type{T}, count::Integer=1; alloc_kwargs...) where {T}
    check_type(Buffer, T)

    return alloc(sizeof(T)*count; alloc_kwargs...)
end

"""
    download(::Type{T}, src::Buffer, [count::Integer=1])::Vector{T}

Download `count` objects of type `T` from the device at `src`, returning a vector.
"""
function download(::Type{T}, src::Buffer, count::Integer=1) where {T}
    dst = Vector{T}(undef, count)
    download!(dst, src)
    return dst
end

# Pretty-printing
function Base.show(io::IO, ptrinfo::HSA.PointerInfo)
    println(io, "Pointer type: $(ptrinfo.type)")
    println(io, "Owner: $(AGENTS[ptrinfo.agentOwner.handle])")
    println(io, "Agent base address: $(ptrinfo.agentBaseAddress)")
    println(io, "Host base address: $(ptrinfo.hostBaseAddress)")
    print(io, "Size (bytes): $(ptrinfo.sizeInBytes)")
end

end # module Mem
