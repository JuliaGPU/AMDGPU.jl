function hipDriverGetVersion(driverVersion)
    ccall((:hipDriverGetVersion, libhip), hipError_t, (Ptr{Cint},), driverVersion)
end

function hipRuntimeGetVersion(runtimeVersion)
    ccall((:hipRuntimeGetVersion, libhip), hipError_t, (Ptr{Cint},), runtimeVersion)
end

function hipInit(flags)
    ccall((:hipInit, libhip), hipError_t, (Cint,), flags)
end

function hipDeviceGet(dev, device_id)
    ccall((:hipDeviceGet, libhip), hipError_t, (Ptr{hipDevice_t}, Cint), dev, device_id)
end

function hipCtxCreate(ctx_ref, flags, device)
    ccall((:hipCtxCreate, libhip), hipError_t, (Ptr{hipContext_t}, Cuint, hipDevice_t), ctx_ref, flags, device)
end

function hipCtxDestroy(ctx)
    ccall((:hipCtxDestroy, libhip), hipError_t, (hipContext_t,), ctx)
end

function hipCtxSetCurrent(ctx)
    ccall((:hipCtxSetCurrent, libhip), hipError_t, (hipContext_t,), ctx)
end

function hipCtxGetCurrent(ctx_ref)
    ccall((:hipCtxGetCurrent, libhip), hipError_t, (Ptr{hipContext_t},), ctx_ref)
end

function hipGetDevice(device_id_ref)
    ccall((:hipGetDevice, libhip), hipError_t, (Ptr{Cint},), device_id_ref)
end

function hipSetDevice(device_id)
    ccall((:hipSetDevice, libhip), hipError_t, (Cint,), device_id)
end

function hipGetDeviceCount(count_ref)
    ccall((:hipGetDeviceCount, libhip), hipError_t, (Ptr{Cint},), count_ref)
end

function hipGetDeviceProperties(prop, dev_id)
    ccall((:hipGetDeviceProperties, libhip), hipError_t, (Ptr{hipDeviceProp_t}, Cint), prop, dev_id)
end

function hipDeviceGetName(name, len, device)
    ccall((:hipDeviceGetName, libhip), hipError_t, (Ptr{Cuchar}, Cint, hipDevice_t), name, len, device)
end

function hipDeviceGetAttribute(val, attribute, device_id)
    ccall((:hipDeviceGetAttribute, libhip), hipError_t, (Ptr{Cint}, hipDeviceAttribute_t, Cint), val, attribute, device_id)
end

function hipEventCreate(event_ref)
    AMDGPU.prepare_state()
    ccall((:hipEventCreate, libhip), hipError_t, (Ptr{hipEvent_t},), event_ref)
end

function hipEventCreateWithFlags(event_ref, flags)
    AMDGPU.prepare_state()
    ccall((:hipEventCreateWithFlags, libhip), hipError_t, (Ptr{hipEvent_t}, Cuint), event_ref, flags)
end

function hipEventDestroy(event)
    AMDGPU.prepare_state()
    ccall((:hipEventDestroy, libhip), hipError_t, (hipEvent_t,), event)
end

function hipEventRecord(event, stream)
    AMDGPU.prepare_state()
    ccall((:hipEventRecord, libhip), hipError_t, (hipEvent_t, hipStream_t), event, stream)
end

function hipEventQuery(event)
    AMDGPU.prepare_state()
    ccall((:hipEventQuery, libhip), hipError_t, (hipEvent_t,), event)
end

function hipEventSynchronize(event)
    AMDGPU.prepare_state()
    ccall((:hipEventSynchronize, libhip), hipError_t, (hipEvent_t,), event)
end

function hipEventElapsedTime(ms_ref, start_event, stop_event)
    AMDGPU.prepare_state()
    ccall((:hipEventElapsedTime, libhip), hipError_t, (Ptr{Cfloat}, hipEvent_t, hipEvent_t), ms_ref, start_event, stop_event)
end

function hipStreamCreateWithPriority(stream_ref, flags, priority)
    AMDGPU.prepare_state()
    ccall((:hipStreamCreateWithPriority, libhip), hipError_t, (Ptr{hipStream_t}, Cuint, Cint), stream_ref, flags, priority)
end

function hipStreamGetPriority(stream, priority)
    AMDGPU.prepare_state()
    ccall((:hipStreamGetPriority, libhip), hipError_t, (hipStream_t, Ptr{Cint}), stream, priority)
end

function hipStreamSynchronize(stream)
    AMDGPU.prepare_state()
    ccall((:hipStreamSynchronize, libhip), hipError_t, (hipStream_t,), stream)
end

function hipStreamDestroy(stream)
    AMDGPU.prepare_state()
    ccall((:hipStreamDestroy, libhip), hipError_t, (hipStream_t,), stream)
end

function hipStreamQuery(stream)
    AMDGPU.prepare_state()
    ccall((:hipStreamQuery, libhip), hipError_t, (hipStream_t,), stream)
end

function hipDeviceSynchronize()
    AMDGPU.prepare_state()
    ccall((:hipDeviceSynchronize, libhip), hipError_t, ())
end

function hipMalloc(ptr::Ref, sz::Csize_t)
    AMDGPU.prepare_state()
    ccall((:hipMalloc, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Csize_t), ptr, sz)
end

function hipFree(ptr::Ptr{Cvoid})
    AMDGPU.prepare_state()
    ccall((:hipFree, libhip), hipError_t, (Ptr{Cvoid},), ptr)
end

function hipHostMalloc(ptr, sz, flags)
    AMDGPU.prepare_state()
    ccall((:hipHostMalloc, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Csize_t, Cuint), ptr, sz, flags)
end

function hipHostFree(ptr)
    AMDGPU.prepare_state()
    ccall((:hipHostFree, libhip), hipError_t, (Ptr{Cvoid},), ptr)
end

function hipHostRegister(hostPtr, sizeBytes, flags)
    AMDGPU.prepare_state()
    ccall((:hipHostRegister, libhip), hipError_t, (Ptr{Cvoid}, Csize_t, Cuint), hostPtr, sizeBytes, flags)
end

function hipHostUnregister(hostPtr)
    AMDGPU.prepare_state()
    ccall((:hipHostUnregister, libhip), hipError_t, (Ptr{Cvoid},), hostPtr)
end

function hipHostGetDevicePointer(devPtr, hstPtr, flags)
    AMDGPU.prepare_state()
    ccall((:hipHostGetDevicePointer, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Ptr{Cvoid}, Cuint), devPtr, hstPtr, flags)
end

function hipPointerGetAttributes(attribute, ptr)
    AMDGPU.prepare_state()
    ccall((:hipPointerGetAttributes, libhip), hipError_t, (Ptr{hipPointerAttribute_t}, Ptr{Cvoid}), attribute, ptr)
end

function hipMemcpy3DAsync(p, stream)
    AMDGPU.prepare_state()
    ccall((:hipMemcpy3DAsync, libhip), hipError_t, (Ptr{hipMemcpy3DParms}, hipStream_t), p, stream)
end

function hipMallocAsync(ptr, sz, stream)
    AMDGPU.prepare_state()
    ccall((:hipMallocAsync, libhip), hipError_t, (Ptr{Ptr{Cvoid}}, Csize_t, hipStream_t), ptr, sz, stream)
end

function hipFreeAsync(ptr, stream)
    AMDGPU.prepare_state()
    ccall((:hipFreeAsync, libhip), hipError_t, (Ptr{Cvoid}, hipStream_t), ptr, stream)
end

function hipMemcpyHtoDAsync(dst, src, sz, stream)
    AMDGPU.prepare_state()
    ccall((:hipMemcpyHtoDAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemcpyDtoHAsync(dst, src, sz, stream)
    AMDGPU.prepare_state()
    ccall((:hipMemcpyDtoHAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemcpyDtoDAsync(dst, src, sz, stream)
    AMDGPU.prepare_state()
    ccall((:hipMemcpyDtoDAsync, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipStream_t), dst, src, sz, stream)
end

function hipMemcpyWithStream(dst, src, sz, kind, stream)
    AMDGPU.prepare_state()
    ccall((:hipMemcpyWithStream, libhip), hipError_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, hipMemcpyKind, hipStream_t), dst, src, sz, kind, stream)
end

function hipMemGetInfo(free, total)
    AMDGPU.prepare_state()
    ccall((:hipMemGetInfo, libhip), hipError_t, (Ptr{Csize_t}, Ptr{Csize_t}), free, total)
end

function hipDeviceGetDefaultMemPool(pool, device_id)
    AMDGPU.prepare_state()
    ccall((:hipDeviceGetDefaultMemPool, libhip), hipError_t, (Ptr{hipMemPool_t}, Cint), pool, device_id)
end

function hipDeviceGetMemPool(pool, device_id)
    AMDGPU.prepare_state()
    ccall((:hipDeviceGetMemPool, libhip), hipError_t, (Ptr{hipMemPool_t}, Cint), pool, device_id)
end

function hipDeviceSetMemPool(device_id, pool)
    AMDGPU.prepare_state()
    ccall((:hipDeviceSetMemPool, libhip), hipError_t, (Cint, hipMemPool_t), device_id, pool)
end

function hipMemPoolTrimTo(pool, min_bytes_to_hold)
    AMDGPU.prepare_state()
    ccall((:hipMemPoolTrimTo, libhip), hipError_t, (hipMemPool_t, Csize_t), pool, min_bytes_to_hold)
end

function hipMemPoolSetAttribute(pool, attr, value)
    AMDGPU.prepare_state()
    ccall((:hipMemPoolSetAttribute, libhip), hipError_t, (hipMemPool_t, hipMemPoolAttr, Ptr{Cvoid}), pool, attr, value)
end

function hipMemPoolGetAttribute(pool, attr, value)
    AMDGPU.prepare_state()
    ccall((:hipMemPoolGetAttribute, libhip), hipError_t, (hipMemPool_t, hipMemPoolAttr, Ptr{Cvoid}), pool, attr, value)
end

function hipMemPoolCreate(pool, props)
    AMDGPU.prepare_state()
    ccall((:hipMemPoolCreate, libhip), hipError_t, (Ptr{hipMemPool_t}, Ptr{hipMemPoolProps}), pool, props)
end

function hipMemPoolDestroy(pool)
    AMDGPU.prepare_state()
    ccall((:hipMemPoolDestroy, libhip), hipError_t, (hipMemPool_t,), pool)
end

function hipDeviceGetLimit(value, limit)
    AMDGPU.prepare_state()
    ccall((:hipDeviceGetLimit, libhip), hipError_t, (Ptr{Csize_t}, hipLimit_t), value, limit)
end

function hipDeviceSetLimit(limit, value)
    AMDGPU.prepare_state()
    ccall((:hipDeviceSetLimit, libhip), hipError_t, (hipLimit_t, Csize_t), limit, value)
end

function hiprtcLinkCreate(n_options, option_ptr, option_vals_pptr, hip_link_state_ptr)
    AMDGPU.prepare_state()
    ccall((:hiprtcLinkCreate, libhip), hiprtcResult, (Cuint, Ptr{hiprtcJIT_option}, Ptr{Ptr{Cvoid}}, Ptr{hiprtcLinkState}), n_options, option_ptr, option_vals_pptr, hip_link_state_ptr)
end

function hiprtcLinkAddFile(
    hip_link_state, input_type, file_path,
    num_options, options_ptr, option_vals_pptr,
)
    AMDGPU.prepare_state()
    ccall((:hiprtcLinkAddFile, libhip), hiprtcResult, (hiprtcLinkState, hiprtcJITInputType, Ptr{Cchar}, Cuint, Ptr{hiprtcJIT_option}, Ptr{Ptr{Cvoid}}), hip_link_state, input_type, file_path, num_options, options_ptr, option_vals_pptr)
end

function hiprtcLinkComplete(hip_link_state, bin_out, size_out)
    AMDGPU.prepare_state()
    ccall((:hiprtcLinkComplete, libhip), hiprtcResult, (hiprtcLinkState, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}), hip_link_state, bin_out, size_out)
end

function hipModuleLoad(mod, fname)
    AMDGPU.prepare_state()
    ccall((:hipModuleLoad, libhip), hipError_t, (Ptr{hipModule_t}, Ptr{Cchar}), mod, fname)
end

function hipModuleLoadData(mod, img)
    AMDGPU.prepare_state()
    ccall((:hipModuleLoadData, libhip), hipError_t, (Ptr{hipModule_t}, Ptr{Cvoid}), mod, img)
end

function hipModuleGetFunction(func, mod, name)
    AMDGPU.prepare_state()
    ccall((:hipModuleGetFunction, libhip), hipError_t, (Ptr{hipFunction_t}, hipModule_t, Ptr{Cchar}), func, mod, name)
end

function hipModuleUnload(mod)
    AMDGPU.prepare_state()
    ccall((:hipModuleUnload, libhip), hipError_t, (hipModule_t,), mod)
end

function hipModuleLaunchKernel(
    func, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ,
    sharedMemBytes, stream, kernelParams, extra,
)
    AMDGPU.prepare_state()
    ccall((:hipModuleLaunchKernel, libhip), hipError_t, (hipFunction_t, Cuint, Cuint, Cuint, Cuint, Cuint, Cuint, Cuint, hipStream_t, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}), func, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, sharedMemBytes, stream, kernelParams, extra)
end

function hipModuleOccupancyMaxPotentialBlockSize(
    gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit,
)
    AMDGPU.prepare_state()
    ccall((:hipModuleOccupancyMaxPotentialBlockSize, libhip), hipError_t, (Ptr{Cint}, Ptr{Cint}, hipFunction_t, Csize_t, Cint), gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit)
end

function hipDeviceCanAccessPeer(can_access_peer_ref, deviceid, peer_deviceid)
    AMDGPU.prepare_state()
    ccall((:hipDeviceCanAccessPeer, libhip), hipError_t, (Ptr{Cint}, Cint, Cint), can_access_peer_ref, deviceid, peer_deviceid)
end

function hipLaunchHostFunc(stream, fn, userData)
    AMDGPU.prepare_state()
    ccall((:hipLaunchHostFunc, libhip), hipError_t, (hipStream_t, hipHostFn, Ptr{Cvoid}), stream, fn, userData)
end
