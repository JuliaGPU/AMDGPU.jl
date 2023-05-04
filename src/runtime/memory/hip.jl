struct HIPBuffer <: AbstractAMDBuffer
    device::ROCDevice
    ptr::Ptr{Cvoid}
    bytesize::Int
    _id::UInt64 # Unique ID used for refcounting.
end

function HIPBuffer(bytesize::Int; stream::HIP.HIPStream)
    dev = AMDGPU.device()
    bytesize == 0 && return HIPBuffer(dev, C_NULL, 0, _buffer_id!()), nothing

    ptr = Ref{Ptr{Cvoid}}()
    alloc_or_retry!() do
        try
            HIP.hipMallocAsync(ptr, Csize_t(bytesize), stream.stream) |> HIP.check
            HSA.STATUS_SUCCESS
        catch err
            @error "hipMallocAsync exception" exception=(err, catch_backtrace())
            HSA.STATUS_ERROR_OUT_OF_RESOURCES
        end
    end

    event = HIP.HIPEvent(stream)
    buffer = HIPBuffer(dev, ptr[], bytesize, _buffer_id!())
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
    HIP.hipFreeAsync(buf.ptr, stream.stream) |> HIP.check
    return
end

function upload!(dst::HIPBuffer, src::Ptr, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyHtoDAsync(
        dst.ptr, Ptr{Cvoid}(src), Csize_t(bytesize), stream.stream) |> HIP.check
    HIP.HIPEvent(stream)
end

function download!(dst::Ptr, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyDtoHAsync(
        Ptr{Cvoid}(dst), src.ptr, Csize_t(bytesize), stream.stream) |> HIP.check
    HIP.HIPEvent(stream)
end

function transfer!(dst::HIPBuffer, src::HIPBuffer, bytesize::Int; stream::HIP.HIPStream)
    bytesize == 0 && return nothing
    HIP.hipMemcpyDtoDAsync(
        dst.ptr, src.ptr, Csize_t(bytesize), stream.stream) |> HIP.check
    HIP.HIPEvent(stream)
end
