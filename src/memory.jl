# Raw memory management
# Copied from CUDAdrv.jl

# NOTE: Mostly implemented for compatibility and ease-of-use, however we're
# currently not nearly as featureful as the original, which should change
# where possible.

export Mem

module Mem

using ..AMDGPU
using ..AMDGPU.HSA
import AMDGPU: check, get_region, get_memory_pool, AGENTS, ROCDim, ROCDim3

## buffer type

struct Buffer
    ptr::Ptr{Cvoid}
    host_ptr::Ptr{Cvoid}
    bytesize::Int
    agent::HSAAgent
    coherent::Bool
    pool_alloc::Bool
end

Base.unsafe_convert(::Type{Ptr{T}}, buf::Buffer) where {T} = convert(Ptr{T}, buf.ptr)

function view(buf::Buffer, bytes::Int)
    bytes > buf.bytesize && throw(BoundsError(buf, bytes))
    return Buffer(buf.ptr+bytes,
                  buf.host_ptr != C_NULL ? buf.host_ptr+bytes : C_NULL,
                  buf.bytesize-bytes, buf.agent, buf.coherent, buf.pool_alloc)
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
    ptrinfo = Ref{HSA.AMDPointerInfo}()
    ptrinfo_ptr = Base.unsafe_convert(Ptr{HSA.AMDPointerInfo}, ptrinfo)
    ccall(:memset, Ptr{Cvoid},
                   (Ptr{HSA.AMDPointerInfo}, UInt8, Csize_t),
                   ptrinfo_ptr, UInt8(0), sizeof(HSA.AMDPointerInfo))
    unsafe_store!(reinterpret(Ptr{Csize_t}, ptrinfo_ptr), sizeof(HSA.AMDPointerInfo))
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
    ccall(:memset, Ptr{Cvoid},
                   (Ptr{Ptr{Cvoid}}, UInt8, Csize_t),
                   Base.unsafe_convert(Ptr{Ptr{Cvoid}}, plocked), UInt8(0), sizeof(Ptr{Cvoid}))
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
    alloc(bytesize::Integer; coherent=false) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on the default agent.

    alloc(agent::HSAAgent, bytesize::Integer; coherent=false) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on `agent`.

When using the above two methods, allocations are not coherent by default,
meaning that the allocated buffer is only accessible from the given agent.

If `coherent` is set to `true`, the allocated buffer will be accessible from
all HSA agents, including the host CPU.  Even though this is convenient, it can
sometimes be slower than explicit memory transfers if memory accesses are not
carefully managed.

    alloc(agent::HSAAgent, pool::HSAMemoryPool, bytesize::Integer) -> Buffer
    alloc(agent::HSAAgent, region::HSARegion, bytesize::Integer) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on the region `region` or
memory pool `pool`.
"""
function alloc(agent::HSAAgent, bytesize::Integer; coherent=false)
    bytesize == 0 && return Buffer(C_NULL, C_NULL, 0, agent, coherent, false)

    region_kind = if coherent
        :finegrained
    else
        :coarsegrained
    end

    if region_kind != :coarsegrained
        region = get_region(agent, region_kind)
        return alloc(agent, region, bytesize)
    else
        pool = get_memory_pool(agent, region_kind)
        return alloc(agent, pool, bytesize)
        # On AMD this is a no-op and we need to make sure that we use the right region instead.
        # check(HSA.memory_assign_agent(buf.ptr, agent.agent, HSA.ACCESS_PERMISSION_RW))
    end
end
function alloc(agent::HSAAgent, pool::AMDGPU.HSAMemoryPool, bytesize::Integer)
    ptr_ref = Ref{Ptr{Cvoid}}()
    check(HSA.amd_memory_pool_allocate(pool.pool, bytesize, 0, ptr_ref))
    return Buffer(ptr_ref[], C_NULL, bytesize, agent, AMDGPU.pool_accessible_by_all(pool), true)
end
function alloc(agent::HSAAgent, region::AMDGPU.HSARegion, bytesize::Integer)
    ptr_ref = Ref{Ptr{Cvoid}}()
    check(HSA.memory_allocate(region.region, bytesize, ptr_ref))
    return Buffer(ptr_ref[], C_NULL, bytesize, agent, AMDGPU.region_host_accessible(region), false)
end
alloc(bytesize; kwargs...) = alloc(get_default_agent(), bytesize; kwargs...)

function free(buf::Buffer)
    if buf.ptr != C_NULL
        if buf.host_ptr == C_NULL
            # HSA-backed
            if buf.pool_alloc
                check(HSA.amd_memory_pool_free(buf.ptr))
            else
                check(HSA.memory_free(buf.ptr))
            end
        else
            # Wrapped
            unlock(buf.ptr)
        end
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
    nbytes > 0 || return
    if dst.host_ptr == C_NULL
        HSA.memory_copy(Ptr{T}(dst.ptr), src, nbytes) |> check
    else
        Base.unsafe_copyto!(reinterpret(Ptr{UInt8}, dst.host_ptr),
                            reinterpret(Ptr{UInt8}, src),
                            nbytes)
    end
end

"""
    download!(dst::Ref, src::Buffer, nbytes::Integer)

Download `nbytes` memory from `src` on the device to `dst` on the host.
"""
function download!(dst::Ptr{T}, src::Buffer, nbytes::Integer) where T
    nbytes > 0 || return
    if src.host_ptr == C_NULL
        HSA.memory_copy(dst, Ptr{T}(src.ptr), nbytes) |> check
    else
        Base.unsafe_copyto!(reinterpret(Ptr{UInt8}, dst),
                            reinterpret(Ptr{UInt8}, src.host_ptr),
                            nbytes)
    end
end

"""
    transfer!(dst::Buffer, src::Buffer, nbytes::Integer)

Transfer `nbytes` of device memory from `src` to `dst`.
"""
function transfer!(dst::Buffer, src::Buffer, nbytes::Integer)
    nbytes > 0 || return
    if dst.host_ptr != C_NULL && src.host_ptr != C_NULL
        Base.unsafe_copyto!(reinterpret(Ptr{UInt8}, dst.host_ptr),
                            reinterpret(Ptr{UInt8}, src.host_ptr),
                            nbytes)
    elseif dst.host_ptr != C_NULL
        download!(dst.host_ptr, src, nbytes)
    elseif src.host_ptr != C_NULL
        upload!(dst, src.host_ptr, nbytes)
    else
        HSA.memory_copy(dst.ptr, src.ptr, nbytes) |> check
    end
end


"""
    device_type(agent)

Return the type of an HSA agent.
"""
function device_type(agent)
    type = Ref{HSA.DeviceType}()
    HSA.agent_get_info(agent,HSA.AGENT_INFO_DEVICE,type) |> check
    return type[]
end


"""
    unsafe_copy3d!(dst::Ptr{T}, src::Ptr{T}, width, height=1, depth=1;
                   dstPos::ROCDim=(1,1,1), dstPitch=0, dstSlice=0,
                   srcPos::ROCDim=(1,1,1), srcPitch=0, srcSlice=0,
                   async::Bool=false, signal::HSASignal=nothing) where T

Perform a 3D memory copy between pointers `src` and `dst` at respectively position `srcPos` and `dstPos` 
(1-indexed). Both pitch and slice can be specified for both the source and destination. This call is 
executed asynchronously if `async` is set, otherwise `signal` is synchronized.
"""
function unsafe_copy3d!(dst::Ptr{T}, src::Ptr{T}, width, height=1, depth=1;
                        dstPos::ROCDim=(1,1,1), dstPitch=0, dstSlice=0,
                        srcPos::ROCDim=(1,1,1), srcPitch=0, srcSlice=0,
                        async::Bool=false, signal::HSASignal=nothing) where T
    (T == Nothing) && error("Type of Ptr is Nothing")

    dstPtr_info = pointerinfo(dst)
    srcPtr_info = pointerinfo(src)

    if dstPtr_info.type == HSA.EXT_POINTER_TYPE_UNKNOWN || srcPtr_info.type == HSA.EXT_POINTER_TYPE_UNKNOWN
        error("Only device pointers or locked host pointers are supported, see unsafe_wrap and Mem.lock")
    end

    if dstPtr_info.type == HSA.EXT_POINTER_TYPE_HSA && srcPtr_info.type == HSA.EXT_POINTER_TYPE_LOCKED
        device_type(dstPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU || error("dst should point to device memory")
        hsaCopyDir  = HSA.LibHSARuntime.hsaHostToDevice
    elseif dstPtr_info.type == HSA.EXT_POINTER_TYPE_LOCKED && srcPtr_info.type == HSA.EXT_POINTER_TYPE_HSA
        device_type(srcPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU || error("src should point to device memory")
        hsaCopyDir = HSA.LibHSARuntime.hsaDeviceToHost
    elseif dstPtr_info.type == HSA.EXT_POINTER_TYPE_HSA && srcPtr_info.type == HSA.EXT_POINTER_TYPE_HSA
        (device_type(dstPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU && device_type(srcPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU) || error("dst and src should point to device memory")
        hsaCopyDir = HSA.LibHSARuntime.hsaDeviceToDevice
    else
        error("Only device to device, host to device, and device to host memory transfer is supported")
    end

    dstOffset = (sizeof(T)*(dstPos[1]-1), dstPos[2]-1, dstPos[3]-1)
    srcOffset = (sizeof(T)*(srcPos[1]-1), srcPos[2]-1, srcPos[3]-1)

    dstRef       = Ref(HSA.PitchedPtr(dst, dstPitch, dstSlice))
    srcRef       = Ref(HSA.PitchedPtr(src, srcPitch, srcSlice))
    dstOffsetRef = Ref(HSA.Dim3(dstOffset...))
    srcOffsetRef = Ref(HSA.Dim3(srcOffset...))
    rangeRef     = Ref(HSA.Dim3(sizeof(T)*width, height, depth))
    # println("tag 0")
    # dstPtr       = Base.unsafe_convert(Ptr{HSA.PitchedPtr}, dstRef)
    # dstOffsetPtr = Base.unsafe_convert(Ptr{HSA.Dim3},       dstOffsetRef)
    # srcPtr       = Base.unsafe_convert(Ptr{HSA.PitchedPtr}, srcRef)
    # srcOffsetPtr = Base.unsafe_convert(Ptr{HSA.Dim3},       srcOffsetRef)
    # rangePtr     = Base.unsafe_convert(Ptr{HSA.Dim3},       rangeRef)

    # AMDGPU.HSA.amd_memory_async_copy_rect(dstPtr,dstOffsetPtr,srcPtr,srcOffsetPtr,rangePtr,
    #                                       get_default_agent().agent,hsaCopyDir,UInt32(0),C_NULL,signal.signal[]) |> check
    signal = HSASignal()
    AMDGPU.HSA.amd_memory_async_copy_rect(Base.unsafe_convert(Ptr{HSA.PitchedPtr}, dstRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       dstOffsetRef),
                                          Base.unsafe_convert(Ptr{HSA.PitchedPtr}, srcRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       srcOffsetRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       rangeRef),
                                          get_default_agent().agent,hsaCopyDir,UInt32(0),C_NULL,signal.signal[]) |> check

    async || wait(signal)
    return nothing
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
    if isa(T, UnionAll) || isabstracttype(T) || !isconcretetype(T)
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
function Base.show(io::IO, ptrinfo::HSA.AMDPointerInfo)
    println(io, "Pointer type: $(ptrinfo.type)")
    println(io, "Owner: $(AGENTS[ptrinfo.agentOwner.handle])")
    println(io, "Agent base address: $(ptrinfo.agentBaseAddress)")
    println(io, "Host base address: $(ptrinfo.hostBaseAddress)")
    print(io, "Size (bytes): $(ptrinfo.sizeInBytes)")
end

end # module Mem
