const _POOL_STATUS = AMDGPU.LockedObject(Dict{HIP.HIPDevice, Base.RefValue{Bool}}())

function pool_status(dev::HIP.HIPDevice)
    Base.lock(_POOL_STATUS) do ps
        get!(ps, dev, Ref(false))
    end
end

function mark_pool!(dev::HIP.HIPDevice)
    status = pool_status(dev)
    status[] && return

    # TODO add alloc limiter
    HIP.attribute!(
        HIP.memory_pool(dev), HIP.hipMemPoolAttrReleaseThreshold,
        typemax(UInt64))
    status[] = true
end

struct HIPBuffer <: AbstractAMDBuffer
    device::ROCDevice
    ptr::Ptr{Cvoid}
    bytesize::Int
    _id::UInt64 # Unique ID used for refcounting.
end

function HIPBuffer(bytesize::Int; stream::HIP.HIPStream)
    dev = AMDGPU.device()
    bytesize == 0 && return HIPBuffer(dev, C_NULL, 0, _buffer_id!()), nothing

    mark_pool!(HIP.device())
    ensure_enough_memory!(bytesize)

    ptr_ref = Ref{Ptr{Cvoid}}()
    alloc_or_retry!() do
        try
            HIP.hipMallocAsync(ptr_ref, Csize_t(bytesize), stream) |> HIP.check
            ptr_ref[] == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
            HSA.STATUS_SUCCESS
        catch err
            @error "hipMallocAsync exception. Requested $(Base.format_bytes(bytesize)); Used: $(Base.format_bytes(ALL_ALLOCS[]))" exception=(err, catch_backtrace())
            HSA.STATUS_ERROR_OUT_OF_RESOURCES
        end
    end
    ptr = ptr_ref[]
    @assert ptr != C_NULL "hipMallocAsync resulted in C_NULL for $(Base.format_bytes(bytesize))"

    Threads.atomic_add!(ALL_ALLOCS, Int64(bytesize))

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
    Threads.atomic_sub!(ALL_ALLOCS, Int64(buf.bytesize))
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
