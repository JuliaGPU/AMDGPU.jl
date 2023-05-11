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
    device::ROCDevice
    ptr::Ptr{Cvoid}
    bytesize::Int
    _id::UInt64 # Unique ID used for refcounting.
end

# TODO migrate MIOpen workspace to HIP allocs
function HIPBuffer(bytesize::Int; stream::HIP.HIPStream)
    dev = AMDGPU.device()
    bytesize == 0 && return HIPBuffer(dev, C_NULL, 0, _buffer_id!()), nothing

    mark_pool!(HIP.device())
    run_or_cleanup!() do
        HARD_MEMORY_LIMIT == typemax(Int) && return HSA.STATUS_SUCCESS

        pool = HIP.memory_pool(stream.device)
        used, reserved = HIP.used_memory(pool), HIP.reserved_memory(pool)

        will_grow = used + bytesize > reserved
        will_overgrow = (reserved + bytesize - (reserved - used)) > HARD_MEMORY_LIMIT
        (will_grow && will_overgrow) ? HSA.STATUS_ERROR_OUT_OF_RESOURCES : HSA.STATUS_SUCCESS
    end

    ptr_ref = Ref{Ptr{Cvoid}}()
    run_or_cleanup!() do
        try
            HIP.hipMallocAsync(ptr_ref, bytesize, stream) |> HIP.check
            ptr_ref[] == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
            HSA.STATUS_SUCCESS
        catch err
            @debug "hipMallocAsync exception. Requested $(Base.format_bytes(bytesize))." exception=(err, catch_backtrace())
            HSA.STATUS_ERROR_OUT_OF_RESOURCES
        end
    end
    ptr = ptr_ref[]
    @assert ptr != C_NULL "hipMallocAsync resulted in C_NULL for $(Base.format_bytes(bytesize))"

    event = HIP.HIPEvent(stream)
    buffer = HIPBuffer(dev, ptr, bytesize, _buffer_id!())
    return buffer, event
end

HIPBuffer(ptr::Ptr{Cvoid}, bytesize::Int) = HIPBuffer(
    AMDGPU.device(), ptr, bytesize, _buffer_id())

Base.unsafe_convert(::Type{Ptr{T}}, buf::HIPBuffer) where T = convert(Ptr{T}, buf.ptr)

function view(buf::HIPBuffer, bytesize::Int)
    bytesize > buf.bytesize && throw(BoundsError(buf, bytesize))
    HIPBuffer(buf.device, buf.ptr + bytesize, buf.bytesize - bytesize, buf._id)
end

function free(buf::HIPBuffer; stream::HIP.HIPStream)
    buf.ptr == C_NULL && return
    HIP.hipFreeAsync(buf, stream) |> HIP.check
    return
end

function upload!(dst::HIPBuffer, src::Ptr, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyHtoDAsync(dst, src, bytesize, stream) |> HIP.check
    HIP.HIPEvent(stream)
end

function download!(dst::Ptr, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyDtoHAsync(dst, src, bytesize, stream) |> HIP.check
    HIP.HIPEvent(stream)
end

function transfer!(dst::HIPBuffer, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyDtoDAsync(dst, src, bytesize, stream) |> HIP.check
    HIP.HIPEvent(stream)
end
