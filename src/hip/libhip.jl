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
