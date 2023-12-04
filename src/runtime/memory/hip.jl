const _POOL_STATUS = AMDGPU.LockedObject(
    Dict{HIP.HIPDevice, Base.RefValue{Union{Nothing, Bool}}}())

function pool_status(dev::HIP.HIPDevice)
    Base.lock(_POOL_STATUS) do ps
        get!(ps, dev, Ref{Union{Nothing, Bool}}(nothing))
    end
end

const __pool_cleanup = Ref{Task}()
function pool_cleanup()
    idle_counters = Base.fill(0, HIP.ndevices())
    devices = HIP.devices()
    while true
        for (i, dev) in enumerate(devices)
            status = pool_status(dev)
            isnothing(status[]) && continue

            if status[]::Bool
                idle_counters[i] = 0
            else
                idle_counters[i] += 1
            end
            status[] = false

            if idle_counters[i] == 5
                old_device = HIP.device()
                old_device != dev && HIP.device!(dev)
                HIP.reclaim()
                old_device != dev && HIP.device!(old_device)
            end
        end

        try
            sleep(60)
        catch ex
            if ex isa EOFError
                # If we get EOF here, it's because Julia is shutting down,
                # so we should just exit the loop.
                break
            else
                rethrow()
            end
        end
    end
end

function mark_pool!(dev::HIP.HIPDevice)
    status = pool_status(dev)
    if isnothing(status[])
        # Default to `0` which is the default value in HIP.
        limit = parse_memory_limit(@load_preference("soft_memory_limit", "0 MiB"))
        HIP.attribute!(
            HIP.memory_pool(dev), HIP.hipMemPoolAttrReleaseThreshold, limit)
        if !isassigned(__pool_cleanup)
            __pool_cleanup[] = errormonitor(Threads.@spawn pool_cleanup())
        end
    end
    status[] = true
end

struct HIPBuffer <: AbstractAMDBuffer
    device::HIPDevice # TODO not used?
    ctx::HIPContext
    ptr::Ptr{Cvoid}
    bytesize::Int
    own::Bool
end

function HIPBuffer(bytesize; stream::HIP.HIPStream)
    dev = stream.device
    ctx = stream.ctx
    bytesize == 0 && return HIPBuffer(dev, ctx, C_NULL, 0, true)

    # mark_pool!(dev)
    pool = HIP.memory_pool(dev)
    has_limit = hard_memory_limit() != typemax(UInt64)

    ptr = alloc_or_retry!(isnothing; stream) do
        try
            # Try to ensure there is enough memory before even trying to allocate.
            if has_limit
                used = HIP.used_memory(pool)
                (used + bytesize) > hard_memory_limit() &&
                    throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
            end

            # Try to allocate.
            ptr_ref = Ref{Ptr{Cvoid}}()
            HIP.hipMallocAsync(ptr_ref, bytesize, stream) |> HIP.check
            ptr = ptr_ref[]
            ptr == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
            return ptr
        catch err
            # TODO rethrow if not out of memory error
            @debug "hipMallocAsync exception. Requested $(Base.format_bytes(bytesize))." exception=(err, catch_backtrace())
            return nothing
        end
    end
    @assert ptr != C_NULL "hipMallocAsync resulted in C_NULL for $(Base.format_bytes(bytesize))"

    if has_limit
        if HIP.reserved_memory(pool) > hard_memory_limit()
            HIP.reclaim() # TODO do not reclaim all memory
        end
        @assert HIP.reserved_memory(pool) ≤ hard_memory_limit()
    end

    HIPBuffer(dev, ctx, ptr, bytesize, true)
end

function HIPBuffer(ptr::Ptr{Cvoid}, bytesize::Int)
    s = AMDGPU.stream()
    HIPBuffer(s.device, s.ctx, ptr, bytesize, false)
end

Base.unsafe_convert(::Type{Ptr{T}}, buf::HIPBuffer) where T =
    convert(Ptr{T}, buf.ptr)

function view(buf::HIPBuffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    HIPBuffer(buf.device, buf.ctx, buf.ptr + bytesize, buf.bytesize - bytesize, buf.own)
end

function free(buf::HIPBuffer; stream::HIP.HIPStream)
    buf.own || return

    buf.ptr == C_NULL && return
    HIP.hipFreeAsync(buf, stream) |> HIP.check
    return
end

function upload!(dst::HIPBuffer, src::Ptr, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return
    HIP.hipMemcpyHtoDAsync(dst, src, bytesize, stream) |> HIP.check
    return
end

function download!(dst::Ptr, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream, async::Bool)
    bytesize == 0 && return
    if async
        HIP.hipMemcpyDtoHAsync(dst, src, bytesize, stream) |> HIP.check
    else
        HIP.hipMemcpyDtoH(dst, src, bytesize) |> HIP.check
    end
    return
end

function transfer!(dst::HIPBuffer, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return
    HIP.hipMemcpyDtoDAsync(dst, src, bytesize, stream) |> HIP.check
    return
end

struct HostBuffer <: AbstractAMDBuffer
    device::HIPDevice
    ctx::HIPContext
    ptr::Ptr{Cvoid}
    dev_ptr::Ptr{Cvoid}
    bytesize::Int
    own::Bool
end

function HostBuffer()
    s = AMDGPU.stream()
    HostBuffer(s.device, s.ctx, C_NULL, C_NULL, 0, true)
end

function HostBuffer(bytesize::Integer, flags = 0)
    bytesize == 0 && return HostBuffer()

    ptr_ref = Ref{Ptr{Cvoid}}()
    HIP.hipHostMalloc(ptr_ref, bytesize, flags) |> HIP.check
    ptr = ptr_ref[]
    dev_ptr = get_device_ptr(ptr)
    s = AMDGPU.stream()
    HostBuffer(s.device, s.ctx, ptr, dev_ptr, bytesize, true)
end

function HostBuffer(ptr::Ptr{Cvoid}, sz::Integer)
    HIP.hipHostRegister(ptr, sz, HIP.hipHostRegisterMapped) |> HIP.check
    dev_ptr = get_device_ptr(ptr)
    s = AMDGPU.stream()
    HostBuffer(s.device, s.ctx, ptr, dev_ptr, sz, false)
end

function view(buf::HostBuffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    HostBuffer(
        buf.device, buf.ctx,
        buf.ptr + bytesize, buf.dev_ptr + bytesize,
        buf.bytesize - bytesize, buf.own)
end

upload!(dst::HostBuffer, src::Ptr, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

upload!(dst::HostBuffer, src::HIPBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyDeviceToHost, stream)

download!(dst::Ptr, src::HostBuffer, sz::Int; stream::HIP.HIPStream, async::Bool) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

download!(dst::HIPBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream, async::Bool) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToDevice, stream)

transfer!(dst::HostBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToHost, stream)

# download!(::Ptr, ::HIPBuffer)
transfer!(dst::HostBuffer, src::HIPBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyDeviceToHost, stream)

# upload!(::HIPBuffer, ::Ptr)
transfer!(dst::HIPBuffer, src::HostBuffer, sz::Int; stream::HIP.HIPStream) =
    HIP.memcpy(dst, src, sz, HIP.hipMemcpyHostToDevice, stream)

Base.unsafe_convert(::Type{Ptr{T}}, buf::HostBuffer) where T =
    convert(Ptr{T}, buf.ptr)

@inline device_ptr(buf::HostBuffer) = buf.dev_ptr

function free(buf::HostBuffer; kwargs...)
    buf.ptr == C_NULL && return
    if buf.own
        HIP.hipHostFree(buf) |> HIP.check
    else
        is_pinned(buf.dev_ptr) && HIP.check(HIP.hipHostUnregister(buf.ptr))
    end
    return
end

function get_device_ptr(ptr::Ptr{Cvoid})
    ptr == C_NULL && return C_NULL
    ptr_ref = Ref{Ptr{Cvoid}}()
    HIP.hipHostGetDevicePointer(ptr_ref, ptr, 0) |> HIP.check
    ptr_ref[]
end

function is_pinned(ptr::Ptr{Cvoid})
    ptr == C_NULL && return false

    st, data = attributes(ptr)
    if st == HIP.hipErrorInvalidValue
        return false
    elseif st == HIP.hipSuccess
        return data.memoryType == HIP.hipMemoryTypeHost
    end
    st |> HIP.check
end

function attributes(ptr::Ptr{Cvoid})
    data = Ref{HIP.hipPointerAttribute_t}()
    st = HIP.hipPointerGetAttributes(data, ptr)
    st, data[]
end

# TODO unsafe_copy3d! is broken in HIP:
# https://github.com/ROCm-Developer-Tools/HIP/issues/3289#issuecomment-1651195870
"""
Asynchronous 3D array copy.

# Arguments:

- `width::Integer`: Width of 3D memory copy.
- `height::Integer = 1`: Height of 3D memory copy.
- `depth::Integer = 1`: Depth of 3D memory copy.
- `dstPos::ROCDim3 = (1, 1, 1)`:
    Starting position of the destination data for the copy.
- `srcPos::ROCDim3 = (1, 1, 1)`:
    Starting position of the source data for the copy.
- `dstPitch::Integer = 0`: Pitch in bytes of the destination data for the copy.
- `srcPitch::Integer = 0`: Pitch in bytes of the source data for the copy.
- `async::Bool = false`: If `false`, then synchronize `stream` immediately.
- `stream::HIP.HIPStream = AMDGPU.stream()`: Stream on which to perform the copy.
"""
function unsafe_copy3d!(
    dst::Ptr{T}, dstTyp::Type{D},
    src::Ptr{T}, srcTyp::Type{S},
    width::Integer, height::Integer = 1, depth::Integer = 1;
    dstPos::ROCDim = (1, 1, 1), srcPos::ROCDim = (1, 1, 1),
    dstPitch::Integer = 0, dstWidth::Integer = 0, dstHeight::Integer = 0,
    srcPitch::Integer = 0, srcWidth::Integer = 0, srcHeight::Integer = 0,
    async::Bool = false, stream::HIP.HIPStream = AMDGPU.stream(),
) where {T, D, S}
    (width == 0 || height == 0 || depth == 0) && return dst

    srcPos, dstPos = ROCDim3(srcPos), ROCDim3(dstPos)
    srcPos = HIP.hipPos((srcPos[1] - 1) * sizeof(T), srcPos[2] - 1, srcPos[3] - 1)
    dstPos = HIP.hipPos((dstPos[1] - 1) * sizeof(T), dstPos[2] - 1, dstPos[3] - 1)

    extent = HIP.hipExtent(width * sizeof(T), height, depth)
    kind = if D <: HIPBuffer && S <: HIPBuffer
        HIP.hipMemcpyDeviceToDevice
    elseif D <: HIPBuffer && S <: HostBuffer
        HIP.hipMemcpyHostToDevice
    elseif D <: HostBuffer && S <: HIPBuffer
        HIP.hipMemcpyDeviceToHost
    elseif D <: HostBuffer && S <: HostBuffer
        HIP.hipMemcpyHostToHost
    end

    srcPtr = HIP.hipPitchedPtr(src, srcPitch, srcWidth, srcHeight)
    dstPtr = HIP.hipPitchedPtr(dst, dstPitch, dstWidth, dstHeight)
    params = Ref(HIP.hipMemcpy3DParms(
        C_NULL, srcPos, srcPtr,
        C_NULL, dstPos, dstPtr, extent, kind))

    HIP.hipMemcpy3DAsync(params, stream) |> HIP.check
    async || AMDGPU.synchronize(stream)
    return dst
end
