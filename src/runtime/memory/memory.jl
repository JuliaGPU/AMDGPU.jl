# Raw memory management
# Copied from CUDAdrv.jl

struct Buffer <: AbstractAMDBuffer
    ptr::Ptr{Cvoid}
    host_ptr::Ptr{Cvoid}
    base_ptr::Ptr{Cvoid}
    bytesize::Int
    device::ROCDevice
    coherent::Bool
    pool_alloc::Bool
    _id::UInt64 # Unique ID used for refcounting.

    function Buffer(
        ptr::Ptr{Cvoid}, host_ptr::Ptr{Cvoid}, base_ptr::Ptr{Cvoid},
        bytesize::Int, device::ROCDevice, coherent::Bool, pool_alloc::Bool,
    )
        _id = _buffer_id!()
        new(ptr, host_ptr, base_ptr, bytesize, device, coherent, pool_alloc, _id)
    end
end

Base.unsafe_convert(::Type{Ptr{T}}, buf::Buffer) where {T} = convert(Ptr{T}, buf.ptr)

function view(buf::Buffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    host_ptr = buf.host_ptr != C_NULL ? (buf.host_ptr + bytesize) : C_NULL
    Buffer(
        buf.ptr + bytesize, host_ptr, buf.base_ptr,
        buf.bytesize - bytesize, buf.device, buf.coherent, buf.pool_alloc)
end

## memory info

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
lock(ptr, bytesize) = lock(ptr, bytesize, AMDGPU.device())
lock(a::Array, device::ROCDevice) = lock(pointer(a), sizeof(a), device)
lock(a::Array) = lock(pointer(a), sizeof(a), AMDGPU.device())

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

    region_kind = coherent ? :finegrained : :coarsegrained

    buf = nothing
    region = nothing
    try
        if region_kind != :coarsegrained
            region = get_region(device, region_kind)
            @debug "Allocating $(Base.format_bytes(bytesize)) from $region"
            buf = alloc(device, region, bytesize)
        else
            region = get_memory_pool(device, region_kind)
            @debug "Allocating $(Base.format_bytes(bytesize)) from $region"
            buf = alloc(device, region, bytesize)
            # This is a no-op and we need to make sure that we use the right region instead
            # check(HSA.memory_assign_agent(buf.ptr, device.agent, HSA.ACCESS_PERMISSION_RW))
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

_alloc(p::ROCMemoryPool, bytesize::Integer, ptr_ref) = HSA.amd_memory_pool_allocate(p.pool, bytesize, 0, ptr_ref)
_alloc(p::ROCMemoryRegion, bytesize::Integer, ptr_ref) = HSA.memory_allocate(p.region, bytesize, ptr_ref)

_accessible(p::ROCMemoryRegion)::Bool = Runtime.region_host_accessible(p)
_accessible(p::ROCMemoryPool)::Bool = Runtime.pool_accessible_by_all(p)

function alloc(
    device::ROCDevice, space::S, bytesize::Integer,
) where S <: Union{ROCMemoryPool, ROCMemoryRegion}
    ptr_ref = Ref{Ptr{Cvoid}}()

    run_or_cleanup!(() -> _alloc(space, bytesize, ptr_ref))

    ptr = ptr_ref[]
    AMDGPU.hsaref!()
    Threads.atomic_add!(ALL_ALLOCS, Int64(bytesize))
    Buffer(ptr, C_NULL, ptr, Int64(bytesize), device, _accessible(space), S <: ROCMemoryPool)
end

alloc(bytesize; kwargs...) = alloc(AMDGPU.device(), bytesize; kwargs...)

function free(buf::Buffer)
    buf.ptr == C_NULL && return

    Runtime.@log_start(:free, (;ptr=buf.ptr), nothing)
    if buf.host_ptr == C_NULL
        # HSA-backed
        if buf.pool_alloc
            memory_check(HSA.amd_memory_pool_free(buf.base_ptr), buf.base_ptr)
        else
            memory_check(HSA.memory_free(buf.base_ptr), buf.base_ptr)
        end
        Threads.atomic_sub!(ALL_ALLOCS, Int64(buf.bytesize))
        AMDGPU.hsaunref!()
    else
        # Wrapped
        unlock(buf.ptr)
    end
    Runtime.@log_finish(:free, (;ptr=buf.ptr), nothing)
    return
end

# N.B. We try to keep this from yielding or throwing, since this usually runs
# in a finalizer
function memory_check(status::HSA.Status, ptr::Ptr{Cvoid})
    if status != HSA.STATUS_SUCCESS
        err_str = Runtime.description(status)
        Core.println("Error when attempting to free an HSA buffer:\n  $err_str")
        pinfo = pointerinfo(ptr)
        Core.println(sprint(io->Base.show(io, pinfo)))
        return false
    end
    return true
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

    AMDGPU.HSA.amd_memory_async_copy_rect(
        Base.unsafe_convert(Ptr{HSA.PitchedPtr}, dstRef),
        Base.unsafe_convert(Ptr{HSA.Dim3},       dstOffsetRef),
        Base.unsafe_convert(Ptr{HSA.PitchedPtr}, srcRef),
        Base.unsafe_convert(Ptr{HSA.Dim3},       srcOffsetRef),
        Base.unsafe_convert(Ptr{HSA.Dim3},       rangeRef),
        AMDGPU.device().agent, hsaCopyDir,
        UInt32(0), C_NULL, signal.signal) |> check

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
