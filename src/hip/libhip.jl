function hipInit(flags::Cint)
    ccall((:hipInit, libhip), hipError_t, (Cint,), flags)
end

function hipDeviceGet(device_ref::Ref{hipDevice_t}, device_id::Cint)
    ccall((:hipDeviceGet, libhip), hipError_t,
          (Ptr{hipDevice_t}, Cint), device_ref, device_id)
end

function hipCtxCreate(ctx_ref::Ref{hipContext_t}, flags::Cuint, device::hipDevice_t)
    ccall((:hipCtxCreate, libhip), hipError_t,
          (Ptr{hipContext_t}, Cuint, hipDevice_t),
          ctx_ref, flags, device)
end

function hipCtxDestroy(ctx::hipContext_t)
    ccall((:hipCtxDestroy, libhip), hipError_t, (hipContext_t,), ctx)
end

function hipCtxSetCurrent(ctx::hipContext_t)
    ccall((:hipCtxSetCurrent, libhip), hipError_t, (hipContext_t,), ctx)
end

function hipCtxGetCurrent(ctx_ref::Ref{hipContext_t})
    ccall((:hipCtxGetCurrent, libhip), hipError_t, (Ptr{hipContext_t},), ctx_ref)
end

function hipGetDevice(device_id_ref::Ref{Cint})
    ccall((:hipGetDevice, libhip), hipError_t, (Ptr{Cint},), device_id_ref)
end

function hipSetDevice(device_id::Cint)
    ccall((:hipSetDevice, libhip), hipError_t, (Cint,), device_id)
end

function hipDeviceGetCount(count_ref::Ref{Cint})
    ccall((:hipDeviceGetCount, libhip), hipError_t, (Ptr{Cint},), count_ref)
end

function hipDeviceGetName(name::Ptr{Cuchar}, len::Cint, device::hipDevice_t)
    ccall((:hipDeviceGetName, libhip), hipError_t,
          (Ptr{Cuchar}, Cint, hipDevice_t), name, len, device)
end

function hipEventCreate(event_ref::Ref{hipEvent_t})
    ccall((:hipEventCreate, libhip), hipError_t, (Ptr{hipEvent_t},), event_ref)
end

function hipEventCreateWithFlags(event_ref::Ref{hipEvent_t}, flags::hipEventFlag_t)
    ccall((:hipEventCreateWithFlags, libhip), hipError_t, (Ptr{hipEvent_t}, Cuint), event_ref, flags)
end

function hipEventDestroy(event::hipEvent_t)
    ccall((:hipEventDestroy, libhip), hipError_t, (hipEvent_t,), event)
end

function hipEventRecord(event::hipEvent_t, stream::hipStream_t)
    ccall((:hipEventRecord, libhip), hipError_t, (hipEvent_t, hipStream_t), event, stream)
end

function hipEventQuery(event::hipEvent_t)
    ccall((:hipEventQuery, libhip), hipError_t, (hipEvent_t,), event)
end

function hipEventSynchronize(event::hipEvent_t)
    ccall((:hipEventSynchronize, libhip), hipError_t, (hipEvent_t,), event)
end

function hipStreamCreateWithPriority(stream_ref::Ref{hipStream_t}, flags::Cuint, priority::Cint)
    ccall((:hipStreamCreateWithPriority, libhip), hipError_t,
          (Ptr{hipStream_t}, Cuint, Cint), stream_ref, flags, priority)
end

function hipStreamGetPriority(stream::hipStream_t, priority::Ref{Cint})
    ccall((:hipStreamGetPriority, libhip), hipError_t, (hipStream_t, Ptr{Cint}), stream, priority)
end

function hipStreamSynchronize(stream::hipStream_t)
    ccall((:hipStreamSynchronize, libhip), hipError_t, (hipStream_t,), stream)
end

function hipStreamDestroy(stream::hipStream_t)
    ccall((:hipStreamDestroy, libhip), hipError_t, (hipStream_t,), stream)
end

function hipStreamQuery(stream::hipStream_t)
    ccall((:hipStreamQuery, libhip), hipError_t, (hipStream_t,), stream)
end

function hipDeviceSynchronize()
    ccall((:hipDeviceSynchronize, libhip), hipError_t, ())
end

function hipMalloc(ptr::Ref, sz::Csize_t)
    ccall((:hipMalloc, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Csize_t), ptr, sz)
end

function hipFree(ptr::Ptr{Cvoid})
    ccall((:hipFree, libhip), hipError_t, (Ptr{Cvoid},), ptr)
end

function hipMallocAsync(ptr::Ref{Ptr{Cvoid}}, sz::Csize_t, stream::hipStream_t)
    ccall((:hipMallocAsync, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Csize_t, hipStream_t), ptr, sz, stream)
end

function hipFreeAsync(ptr::Ptr{Cvoid}, stream::hipStream_t)
    ccall((:hipFreeAsync, libhip), hipError_t, (Ptr{Cvoid}, hipStream_t), ptr, stream)
end

function hipMemcpyHtoDAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sz::Csize_t, stream::hipStream_t)
    ccall((:hipMemcpyHtoDAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemcpyDtoHAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sz::Csize_t, stream::hipStream_t)
    ccall((:hipMemcpyDtoHAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemcpyDtoDAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sz::Csize_t, stream::hipStream_t)
    ccall((:hipMemcpyDtoDAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemGetInfo(free::Ref{Csize_t}, total::Ref{Csize_t})
    ccall((:hipMemGetInfo, libhip), hipError_t, (Ptr{Csize_t}, Ptr{Csize_t}), free, total)
end
