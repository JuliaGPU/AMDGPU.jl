# Raw memory management
# Copied from CUDAdrv.jl

import AMDGPU
import AMDGPU: HSA
if AMDGPU.hip_configured
import AMDGPU: HIP
end
import AMDGPU: Runtime
import .Runtime: ROCDevice, ROCSignal, ROCMemoryRegion, ROCMemoryPool, ROCDim, ROCDim3
import .Runtime: DEVICES, check, get_region, get_memory_pool, get_handle
using Preferences

## buffer type

struct Buffer
    ptr::Ptr{Cvoid}
    host_ptr::Ptr{Cvoid}
    base_ptr::Ptr{Cvoid}
    bytesize::Int
    device::ROCDevice
    coherent::Bool
    pool_alloc::Bool
end
Buffer(ptr::Ptr{Cvoid}, device::ROCDevice, bytesize::Int; host_ptr=C_NULL, base_ptr=ptr,
       coherent::Bool=false, pool_alloc::Bool=!coherent) =
    Buffer(ptr, host_ptr, base_ptr, bytesize, device, coherent, pool_alloc)

Base.unsafe_convert(::Type{Ptr{T}}, buf::Buffer) where {T} = convert(Ptr{T}, buf.ptr)

function view(buf::Buffer, bytes::Int)
    bytes > buf.bytesize && throw(BoundsError(buf, bytes))
    return Buffer(buf.ptr+bytes,
                  buf.host_ptr != C_NULL ? buf.host_ptr+bytes : C_NULL,
                  buf.base_ptr,
                  buf.bytesize-bytes, buf.device, buf.coherent, buf.pool_alloc)
end

## refcounting

const refcounts = Dict{Ptr{Cvoid}, Threads.Atomic{Int}}()
const refcounts_lock = Threads.ReentrantLock()

function refcount(buf::Buffer)
    Base.lock(refcounts_lock) do
        get(refcounts, buf.base_ptr, Threads.Atomic{Int}(0))
    end[]
end

"""
    retain(buf::Buffer)

Increase the refcount of a buffer.
"""
function retain(buf::Buffer)
    count = Base.lock(refcounts_lock) do
        get!(refcounts, buf.base_ptr, Threads.Atomic{Int}(0))
    end
    Threads.atomic_add!(count, 1)
    return
end

"""
    release(buf::Buffer)

Decrease the refcount of a buffer. Returns `true` if the refcount has dropped
to 0, and some action needs to be taken.
"""
function release(buf::Buffer)
    while !Base.trylock(refcounts_lock) end
    count = try
        get(refcounts, buf.base_ptr, Threads.Atomic{Int}(0))
    finally
        Base.unlock(refcounts_lock)
    end
    old = Threads.atomic_sub!(count, 1)
    return (old == 1)
end

"""
    untrack(buf::Buffer)

Removing refcount tracking information for a buffer.
"""
function untrack(buf::Buffer)
    while !Base.trylock(refcounts_lock) end
    try
        delete!(refcounts, buf.base_ptr)
    finally
        Base.unlock(refcounts_lock)
    end
end


## memory info

"""
    info()

Returns a tuple of two integers, indicating respectively the free and total amount of memory
(in bytes) available for allocation on the device.
"""
function info()
    free_ref = Ref{Csize_t}()
    total_ref = Ref{Csize_t}()
    # FIXME: I'm not sure HSA has an API for this...
    return convert(Int, free_ref[]), convert(Int, total_ref[])
end

"""
    free()

Returns the free amount of memory (in bytes), available for allocation on the device.
"""
free() = info()[1]

"""
    total()

Returns the total amount of memory (in bytes), available for allocation on the device.
"""
total() = info()[2]

"""
    used()

Returns the used amount of memory (in bytes), allocated on the device.
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
    lock(ptr::Ptr, bytesize::Integer, device::ROCDevice)
    lock(ptr, bytesize)
    lock(a::Array, device)
    lock(a)

Page-lock a host pointer allocated by the OS allocator and return a new pointer from
the given `device`. For more information, see `hsa_amd_memory_lock()`.

See also: [`unlock`](@ref)
"""
function lock(ptr::Ptr, bytesize::Integer, device::ROCDevice)
    plocked = Ref{Ptr{Cvoid}}()
    ccall(:memset, Ptr{Cvoid},
                   (Ptr{Ptr{Cvoid}}, UInt8, Csize_t),
                   Base.unsafe_convert(Ptr{Ptr{Cvoid}}, plocked), UInt8(0), sizeof(Ptr{Cvoid}))
    HSA.amd_memory_lock(Ptr{Cvoid}(ptr), bytesize, Ref(device.agent), 1, plocked) |> check
    return plocked[]
end
lock(ptr, bytesize) = lock(ptr, bytesize, Runtime.get_default_device())
lock(a::Array, device::ROCDevice) = lock(pointer(a), sizeof(a), device)
lock(a::Array) = lock(pointer(a), sizeof(a), Runtime.get_default_device())

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

"Enables or disables the slow allocation fallback for non-coherent allocations."
enable_slow_allocation_fallback!(flag::Bool) = @set_preferences!("use_slow_allocation_fallback" => flag)
const USE_SLOW_ALLOCATION_FALLBACK = let
    if haskey(ENV, "JULIA_AMDGPU_USE_SLOW_ALLOCATION_FALLBACK")
        flag = parse(Bool, ENV["JULIA_AMDGPU_USE_SLOW_ALLOCATION_FALLBACK"])
        enable_slow_allocation_fallback!(flag)
        flag
    else
        @load_preference("use_slow_allocation_fallback", true)
    end
end

"Enables or disables using hipMalloc/hipFree for non-coherent allocations."
enable_hip_malloc_override!(flag::Bool) = @set_preferences!("use_hip_malloc_override" => flag)
const USE_HIP_MALLOC_OVERRIDE = let
    if haskey(ENV, "JULIA_AMDGPU_USE_HIP_MALLOC_OVERRIDE")
        flag = parse(Bool, ENV["JULIA_AMDGPU_USE_HIP_MALLOC_OVERRIDE"])
        enable_hip_malloc_override!(flag)
        flag
    else
        @load_preference("use_hip_malloc_override", false)
    end
end

"Sets a limit for total GPU memory allocations."
set_memory_alloc_limit!(limit::Integer) =
    @set_preferences!("memory_alloc_limit" => limit)
const MEMORY_ALLOC_LIMIT = let
    if haskey(ENV, "JULIA_AMDGPU_MEMORY_ALLOC_LIMIT")
        limit = parse(Int, ENV["JULIA_AMDGPU_MEMORY_ALLOC_LIMIT"])
        set_memory_alloc_limit!(limit)
        limit
    else
        @load_preference("memory_alloc_limit", typemax(Int))
    end
end

"""
    alloc(bytesize::Integer; coherent=false) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on the default device.

    alloc(device::ROCDevice, bytesize::Integer; coherent=false) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on `device`.

When using the above two methods, allocations are not coherent by default,
meaning that the allocated buffer is only accessible from the given device.

If `coherent` is set to `true`, the allocated buffer will be accessible from
all HSA devices, including the host CPU.  Even though this is convenient, it can
sometimes be slower than explicit memory transfers if memory accesses are not
carefully managed.

    alloc(device::ROCDevice, pool::ROCMemoryPool, bytesize::Integer) -> Buffer
    alloc(device::ROCDevice, region::ROCMemoryRegion, bytesize::Integer) -> Buffer

Allocate `bytesize` bytes of HSA-managed memory on the region `region` or
memory pool `pool`.
"""
function alloc(device::ROCDevice, bytesize::Integer; coherent=false, slow_fallback=!coherent && USE_SLOW_ALLOCATION_FALLBACK)
    alloc_id = rand(UInt64)
    Runtime.@log_start(:alloc, (;alloc_id), (;device=get_handle(device), size=bytesize, coherent))

    bytesize == 0 && return Buffer(C_NULL, C_NULL, C_NULL, 0, device, coherent, false)

    region_kind = if coherent
        :finegrained
    else
        :coarsegrained
    end

    buf = nothing
    region = nothing
    try
        if region_kind != :coarsegrained
            region = get_region(device, region_kind)
            @debug "Allocating $(Base.format_bytes(bytesize)) from $region"
            buf = alloc(device, region, bytesize)
        else
            if USE_HIP_MALLOC_OVERRIDE
                @debug "Allocating $(Base.format_bytes(bytesize)) from HIP"
                buf = alloc_hip(bytesize)
            else
                region = get_memory_pool(device, region_kind)
                @debug "Allocating $(Base.format_bytes(bytesize)) from $region"
                buf = alloc(device, region, bytesize)
                # This is a no-op and we need to make sure that we use the right region instead
                # check(HSA.memory_assign_agent(buf.ptr, device.agent, HSA.ACCESS_PERMISSION_RW))
            end
        end
    catch err
        if slow_fallback &&
           !coherent &&
           err isa Runtime.HSAError &&
           (err.code == HSA.STATUS_ERROR_OUT_OF_RESOURCES ||
            err.code == HSA.STATUS_ERROR_INVALID_ALLOCATION)
            # TODO: How to handle this with logging?
            buf = alloc(device, bytesize; coherent=true)
        else
            rethrow(err)
        end
    finally
        ptr = buf !== nothing ? buf.ptr : C_NULL
        region = region !== nothing ? get_handle(region) : C_NULL
        Runtime.@log_finish(:alloc, (;alloc_id), (;ptr, region))
    end
    return buf
end
function alloc_or_retry!(f)
    for phase in 1:3
        if phase == 2
            GC.gc(false)
            yield()
        elseif phase == 3
            GC.gc(true)
            yield()
        end
        status = f()
        @debug "Allocation phase $phase: $status"
        if status == HSA.STATUS_SUCCESS
            break
        elseif status == HSA.STATUS_ERROR_OUT_OF_RESOURCES || status == HSA.STATUS_ERROR_INVALID_ALLOCATION
            if phase == 3
                check(status)
            end
        else
            check(status)
        end
    end
end
const ALL_ALLOCS = Threads.Atomic{Int64}(0)
function alloc(device::ROCDevice, pool::ROCMemoryPool, bytesize::Integer)
    if ALL_ALLOCS[] + bytesize > MEMORY_ALLOC_LIMIT
        check(HSA.STATUS_ERROR_OUT_OF_RESOURCES)
    end
    ptr_ref = Ref{Ptr{Cvoid}}()
    alloc_or_retry!() do
        HSA.amd_memory_pool_allocate(pool.pool, bytesize, 0, ptr_ref)
    end
    Threads.atomic_add!(ALL_ALLOCS, Int64(bytesize))
    return Buffer(ptr_ref[], C_NULL, ptr_ref[], bytesize, device, Runtime.pool_accessible_by_all(pool), true)
end
function alloc(device::ROCDevice, region::ROCMemoryRegion, bytesize::Integer)
    if ALL_ALLOCS[] + bytesize > MEMORY_ALLOC_LIMIT
        check(HSA.STATUS_ERROR_OUT_OF_RESOURCES)
    end
    ptr_ref = Ref{Ptr{Cvoid}}()
    alloc_or_retry!() do
        HSA.memory_allocate(region.region, bytesize, ptr_ref)
    end
    Threads.atomic_add!(ALL_ALLOCS, Int64(bytesize))
    return Buffer(ptr_ref[], C_NULL, ptr_ref[], bytesize, device, Runtime.region_host_accessible(region), false)
end
alloc(bytesize; kwargs...) =
    alloc(Runtime.get_default_device(), bytesize; kwargs...)
@static if AMDGPU.hip_configured
function alloc_hip(bytesize::Integer)
    ptr_ref = Ref{Ptr{Cvoid}}()
    # FIXME: Set HIP device
    alloc_or_retry!() do
        try
            HIP.@check HIP.hipMalloc(ptr_ref, Csize_t(bytesize))
            HSA.STATUS_SUCCESS
        catch
            # FIXME: Actually check error code
            HSA.STATUS_ERROR_OUT_OF_RESOURCES
        end
    end
    return Buffer(ptr_ref[], C_NULL, ptr_ref[], bytesize, Runtime.get_default_device(), false, true)
end
end # if AMDGPU.hip_configured

function free(buf::Buffer)
    if buf.ptr != C_NULL
        Runtime.@log_start(:free, (;ptr=buf.ptr), nothing)
        if buf.host_ptr == C_NULL
            # HSA-backed
            if buf.pool_alloc
                if USE_HIP_MALLOC_OVERRIDE
                    @static if AMDGPU.hip_configured
                        # Actually HIP-backed
                        HIP.@check HIP.hipFree(buf.ptr)
                    end
                else
                    check(HSA.amd_memory_pool_free(buf.ptr))
                end
            else
                check(HSA.memory_free(buf.ptr))
            end
            Threads.atomic_sub!(ALL_ALLOCS, Int64(buf.bytesize))
        else
            # Wrapped
            unlock(buf.ptr)
        end
        untrack(buf)
        Runtime.@log_finish(:free, (;ptr=buf.ptr), nothing)
    end
    return
end

struct PoolAllocation
    addr::Ptr{Cvoid}
    refs::Threads.Atomic{Int}
end
PoolAllocation(addr) =
    PoolAllocation(addr, Threads.Atomic{Int}(1))
Base.hash(p::PoolAllocation) = hash(p.addr, hash(PoolAllocation))
Base.isequal(p1::P, p2::P) where P<:PoolAllocation = p1.addr == p2.addr

const ALLOC_POOL_BINNED = IdDict{ROCDevice,Dict{Int,Vector{Ptr{Cvoid}}}}()
const ALLOC_POOL_PTR_BIN_MAP = Dict{Ptr{Cvoid},Int}()
const ALLOC_POOL_SHARED = IdDict{ROCDevice,Dict{UInt64,PoolAllocation}}()
const ALLOC_POOL_LOCK = Threads.SpinLock()
const ALLOC_POOL_MAX_SIZE = Ref{Int}(64)
const ALLOC_POOL_MAX_BINS = 8

function alloc_pooled(device::ROCDevice, key::UInt64, kind::Symbol, bytesize::Integer)
    @assert kind == :kernarg "Pooled non-kernarg allocations not implemented"

    if bytesize == 0
        return C_NULL, false
    end

    # Try to grab from pool
    Base.lock(ALLOC_POOL_LOCK) do
        # Try to grab a shared allocation
        device_dict_shared = get!(()->Dict{UInt64,PoolAllocation}(), ALLOC_POOL_SHARED, device)
        if (alloc = get(device_dict_shared, key, nothing)) !== nothing
            Threads.atomic_add!(alloc.refs, 1)
            return alloc.addr, false
        end
        # Fallback, try to grab a binned (unshared) allocation
        device_dict_binned = get!(ALLOC_POOL_BINNED, device) do
            d = Dict{Int,Vector{Ptr{Cvoid}}}()
            for bin in 1:ALLOC_POOL_MAX_BINS
                d[bin] = Vector{Ptr{Cvoid}}()
            end
            d
        end
        bin_min = ceil(Int, log2(bytesize))
        if bin_min <= ALLOC_POOL_MAX_BINS
            # Find any compatible allocation
            bin = findfirst(bin->bin >= bin_min && length(device_dict_binned[bin]) > 0, bin_min:ALLOC_POOL_MAX_BINS)
            if bin !== nothing
                ptr = pop!(device_dict_binned[bin])
                ALLOC_POOL_PTR_BIN_MAP[ptr] = bin
                return ptr, true
            end
        end

        # No available allocations to grab, make a new one
        Base.unlock(ALLOC_POOL_LOCK)

        if bin_min <= ALLOC_POOL_MAX_BINS
            # Round-up bytesize to allow reuse in bins
            bytesize = 2^bin_min
        end

        # N.B. We use the region API because kernarg allocations don't
        # show up in the memory pools API
        kernarg_region = Runtime.get_region(device, :kernarg)
        kernarg_address = Ref{Ptr{Nothing}}(Ptr{Nothing}(0))
        alloc_or_retry!() do
            HSA.memory_allocate(kernarg_region.region,
                                bytesize,
                                kernarg_address)
        end

        Base.lock(ALLOC_POOL_LOCK)

        # Try to share this allocation
        if length(device_dict_shared) < ALLOC_POOL_MAX_SIZE[]
            device_dict_shared[key] = PoolAllocation(kernarg_address[])
        end

        return kernarg_address[], true
    end
end

function free_pooled(device::ROCDevice, key::UInt64, kind::Symbol, ptr::Ptr{Cvoid})
    # Return to pool
    Runtime.@spinlock ALLOC_POOL_LOCK begin
        # Check if this pointer is a shared allocation
        device_dict_shared = get!(()->Dict{UInt64,PoolAllocation}(), ALLOC_POOL_SHARED, device)
        if (alloc = get(device_dict_shared, key, nothing)) !== nothing
            if Threads.atomic_sub!(alloc.refs, 1) == 1
                # TODO: Don't delete unless we're out of space
                delete!(device_dict_shared, key)
                # TODO: Consider putting into a bin if power-of-two bytesize
                check(HSA.memory_free(ptr))
            end
            return
        end
        # Check if this pointer is a binned allocation
        if !haskey(ALLOC_POOL_PTR_BIN_MAP, ptr)
            # Not binned or shared
            check(HSA.memory_free(ptr))
            return
        end
        bin = ALLOC_POOL_PTR_BIN_MAP[ptr]
        allocs = ALLOC_POOL_BINNED[device][bin]
        if length(allocs) < ALLOC_POOL_MAX_SIZE[]
            # Save for later
            push!(allocs, ptr)
        else
            # No free space
            check(HSA.memory_free(ptr))
        end
        return
    end
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
    Runtime.@log_start(:upload!, (;dest=dst.ptr, src=reinterpret(Ptr{Cvoid}, src)), (;nbytes))
    nbytes > 0 || return
    if dst.host_ptr == C_NULL
        HSA.memory_copy(Ptr{T}(dst.ptr), src, nbytes) |> check
    else
        Base.unsafe_copyto!(reinterpret(Ptr{UInt8}, dst.host_ptr),
                            reinterpret(Ptr{UInt8}, src),
                            nbytes)
    end
    Runtime.@log_finish(:upload!, (;dest=dst.ptr, src=reinterpret(Ptr{Cvoid}, src)), (;nbytes))
end

"""
    download!(dst::Ref, src::Buffer, nbytes::Integer)

Download `nbytes` memory from `src` on the device to `dst` on the host.
"""
function download!(dst::Ptr{T}, src::Buffer, nbytes::Integer) where T
    Runtime.@log_start(:download!, (;dest=reinterpret(Ptr{Cvoid}, dst), src=src.ptr), (;nbytes))
    nbytes > 0 || return
    if src.host_ptr == C_NULL
        HSA.memory_copy(dst, Ptr{T}(src.ptr), nbytes) |> check
    else
        Base.unsafe_copyto!(reinterpret(Ptr{UInt8}, dst),
                            reinterpret(Ptr{UInt8}, src.host_ptr),
                            nbytes)
    end
    Runtime.@log_finish(:download!, (;dest=reinterpret(Ptr{Cvoid}, dst), src=src.ptr), (;nbytes))
end

"""
    transfer!(dst::Buffer, src::Buffer, nbytes::Integer)

Transfer `nbytes` of device memory from `src` to `dst`.
"""
function transfer!(dst::Buffer, src::Buffer, nbytes::Integer)
    Runtime.@log_start(:transfer!, (;dest=dst.ptr, src=src.ptr), (;nbytes))
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
    Runtime.@log_finish(:transfer!, (;dest=dst.ptr, src=src.ptr), (;nbytes))
end

"""
    unsafe_copy3d!(dst::Ptr{T}, src::Ptr{T}, width, height=1, depth=1;
                   dstPos::ROCDim=(1,1,1), dstPitch=0, dstSlice=0,
                   srcPos::ROCDim=(1,1,1), srcPitch=0, srcSlice=0,
                   async::Bool=false, signal::ROCSignal=nothing) where T

Perform a 3D memory copy between pointers `src` and `dst` at respectively position `srcPos` and `dstPos` 
(1-indexed). Both pitch and slice can be specified for both the source and destination. This call is 
executed asynchronously if `async` is set, otherwise `signal` is synchronized.
"""
function unsafe_copy3d!(dst::Ptr{T}, src::Ptr{T}, width, height=1, depth=1;
                        dstPos::ROCDim=(1,1,1), dstPitch=0, dstSlice=0,
                        srcPos::ROCDim=(1,1,1), srcPitch=0, srcSlice=0,
                        async::Bool=false, signal::ROCSignal=nothing) where T
    (T == Nothing) && error("Type of Ptr is Nothing")

    dstPtr_info = pointerinfo(dst)
    srcPtr_info = pointerinfo(src)

    if dstPtr_info.type == HSA.EXT_POINTER_TYPE_UNKNOWN || srcPtr_info.type == HSA.EXT_POINTER_TYPE_UNKNOWN
        error("Only device pointers or locked host pointers are supported, see unsafe_wrap and Mem.lock")
    end

    if dstPtr_info.type == HSA.EXT_POINTER_TYPE_HSA && srcPtr_info.type == HSA.EXT_POINTER_TYPE_LOCKED
        Runtime.device_type(dstPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU || error("dst should point to device memory")
        hsaCopyDir = HSA.LibHSARuntime.hsaHostToDevice
    elseif dstPtr_info.type == HSA.EXT_POINTER_TYPE_LOCKED && srcPtr_info.type == HSA.EXT_POINTER_TYPE_HSA
        Runtime.device_type(srcPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU || error("src should point to device memory")
        hsaCopyDir = HSA.LibHSARuntime.hsaDeviceToHost
    elseif dstPtr_info.type == HSA.EXT_POINTER_TYPE_HSA && srcPtr_info.type == HSA.EXT_POINTER_TYPE_HSA
        (Runtime.device_type(dstPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU && Runtime.device_type(srcPtr_info.agentOwner) == HSA.DEVICE_TYPE_GPU) || error("dst and src should point to device memory")
        hsaCopyDir = HSA.LibHSARuntime.hsaDeviceToDevice
    else
        error("Only device to device, host to device, and device to host memory transfer is supported")
    end

    dstOffset = (sizeof(T)*(dstPos[1]-1), dstPos[2]-1, dstPos[3]-1)
    srcOffset = (sizeof(T)*(srcPos[1]-1), srcPos[2]-1, srcPos[3]-1)

    dstRef = Ref(HSA.PitchedPtr(dst, dstPitch, dstSlice))
    srcRef = Ref(HSA.PitchedPtr(src, srcPitch, srcSlice))
    dstOffsetRef = Ref(HSA.Dim3(dstOffset...))
    srcOffsetRef = Ref(HSA.Dim3(srcOffset...))
    rangeRef = Ref(HSA.Dim3(sizeof(T)*width, height, depth))
    sig = signal.signal[]

    AMDGPU.HSA.amd_memory_async_copy_rect(Base.unsafe_convert(Ptr{HSA.PitchedPtr}, dstRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       dstOffsetRef),
                                          Base.unsafe_convert(Ptr{HSA.PitchedPtr}, srcRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       srcOffsetRef),
                                          Base.unsafe_convert(Ptr{HSA.Dim3},       rangeRef),
                                          Runtime.get_default_device().agent,hsaCopyDir,UInt32(0),C_NULL,sig) |> check

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
    println(io, "Owner: $(DEVICES[ptrinfo.agentOwner.handle])")
    println(io, "Agent base address: $(ptrinfo.agentBaseAddress)")
    println(io, "Host base address: $(ptrinfo.hostBaseAddress)")
    print(io, "Size (bytes): $(ptrinfo.sizeInBytes)")
end
