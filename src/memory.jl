# Raw memory management
# Copied from CUDAdrv.jl

# NOTE: Mostly implemented for compatibility and ease-of-use, however we're
# currently not nearly as featureful as the original, which should change
# where possible.

export Mem

module Mem


using ..HSARuntime
using ..HSARuntime.HSA
import HSARuntime: check, get_region


## buffer type

struct Buffer
    ptr::Ptr{Cvoid}
    bytesize::Int
    agent::HSAAgent
end

Base.unsafe_convert(::Type{Ptr{T}}, buf::Buffer) where {T} = convert(Ptr{T}, buf.ptr)

function view(buf::Buffer, bytes::Int)
    bytes > buf.bytesize && throw(BoundsError(buf, bytes))
    return Mem.Buffer(buf.ptr+bytes, buf.bytesize-bytes, buf.agent)
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
    alloc(bytes::Integer)

Allocate `bytesize` bytes of fine-grained memory.
"""
function alloc(agent::HSAAgent, bytesize::Integer)
    bytesize == 0 && return Buffer(C_NULL, 0, agent)

    ptr_ref = Ref{Ptr{Cvoid}}()
    region = get_region(agent, :finegrained)
    check(HSA.memory_allocate(region[], bytesize, ptr_ref))
    return Buffer(ptr_ref[], bytesize, agent)
end
alloc(bytesize) = alloc(get_default_agent(), bytesize)

function free(buf::Buffer)
    if buf.ptr != C_NULL
        check(HSA.memory_free(buf.ptr))
    end
    return
end

"""
    set!(buf::Buffer, value::T, len::Integer)

Initialize device memory by copying the value `val` for `len` times.
"""
function set!(buf::Buffer, value::T, len::Integer) where T<:Unsigned
    ccall(:memset, Cvoid,
          (Ptr{Cvoid}, T, Csize_t),
          buf.ptr, value, len*sizeof(T))
end

"""
    upload!(dst::Buffer, src, nbytes::Integer)

Upload `nbytes` memory from `src` at the host to `dst` on the device.
"""
function upload!(dst::Buffer, src::Ref, nbytes::Integer)
    ccall(:memcpy, Cvoid,
          (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
          dst.ptr, src, nbytes)
end

"""
    download!(dst::Ref, src::Buffer, nbytes::Integer)

Download `nbytes` memory from `src` on the device to `dst` on the host.
"""
function download!(dst::Ref, src::Buffer, nbytes::Integer)
    ccall(:memcpy, Cvoid,
          (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
          dst, src.ptr, nbytes)
end

"""
    transfer!(dst::Buffer, src::Buffer, nbytes::Integer)

Transfer `nbytes` of device memory from `src` to `dst`.
"""
function transfer!(dst::Buffer, src::Buffer, nbytes::Integer)
    ccall(:memcpy, Cvoid,
          (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
          dst.ptr, src.ptr, nbytes)
end


## array based

"""
    alloc(src::AbstractArray)

Allocate space to store the contents of `src`.
"""
function alloc(src::AbstractArray)
    return alloc(sizeof(src))
end

"""
    upload!(dst::Buffer, src::AbstractArray)

Upload the contents of an array `src` to `dst`.
"""
function upload!(dst::Buffer, src::AbstractArray)
    upload!(dst, Ref(src, 1), sizeof(src))
end

"""
    upload(src::AbstractArray)::Buffer

Allocates space for and uploads the contents of an array `src`, returning a Buffer.
"""
function upload(src::AbstractArray)
    dst = alloc(src)
    upload!(dst, src)
    return dst
end

"""
    download!(dst::AbstractArray, src::Buffer)

Downloads memory from `src` to the array at `dst`. The amount of memory downloaded is
determined by calling `sizeof` on the array, so it needs to be properly preallocated.
"""
function download!(dst::AbstractArray, src::Buffer)
    ref = Ref(dst, 1)
    download!(ref, src, sizeof(dst))
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
    alloc(T::Type, [count::Integer=1])

Allocate space for `count` objects of type `T`.
"""
function alloc(::Type{T}, count::Integer=1) where {T}
    check_type(Buffer, T)

    return alloc(sizeof(T)*count)
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

end
