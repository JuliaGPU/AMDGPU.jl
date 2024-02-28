function hipDriverGetVersion(driverVersion)
    @gcsafe_ccall libhip.hipDriverGetVersion(driverVersion::Ptr{Cint})::hipError_t
end

function hipRuntimeGetVersion(runtimeVersion)
    @gcsafe_ccall libhip.hipRuntimeGetVersion(runtimeVersion::Ptr{Cint})::hipError_t
end

function hipInit(flags)
    @gcsafe_ccall libhip.hipInit(flags::Cuint)::hipError_t
end

function hipDeviceGet(device, ordinal)
    @gcsafe_ccall libhip.hipDeviceGet(device::Ptr{hipDevice_t}, ordinal::Cint)::hipError_t
end

function hipCtxCreate(ctx, flags, device)
    @gcsafe_ccall libhip.hipCtxCreate(ctx::Ptr{hipContext_t}, flags::Cuint, device::hipDevice_t)::hipError_t
end

function hipCtxDestroy(ctx)
    @gcsafe_ccall libhip.hipCtxDestroy(ctx::hipContext_t)::hipError_t
end

function hipCtxSetCurrent(ctx)
    @gcsafe_ccall libhip.hipCtxSetCurrent(ctx::hipContext_t)::hipError_t
end

function hipCtxGetCurrent(ctx)
    @gcsafe_ccall libhip.hipCtxGetCurrent(ctx::Ptr{hipContext_t})::hipError_t
end

function hipGetDevice(deviceId)
    @gcsafe_ccall libhip.hipGetDevice(deviceId::Ptr{Cint})::hipError_t
end

function hipSetDevice(deviceId)
    @gcsafe_ccall libhip.hipSetDevice(deviceId::Cint)::hipError_t
end

function hipGetDeviceCount(count)
    @gcsafe_ccall libhip.hipGetDeviceCount(count::Ptr{Cint})::hipError_t
end

function hipGetDeviceProperties(prop, deviceId)
    @gcsafe_ccall libhip.hipGetDeviceProperties(prop::Ptr{hipDeviceProp_t}, deviceId::Cint)::hipError_t
end

function hipDeviceGetName(name, len, device)
    @gcsafe_ccall libhip.hipDeviceGetName(name::Ptr{Cuchar}, len::Cint, device::hipDevice_t)::hipError_t
end

function hipDeviceGetAttribute(pi, attr, deviceId)
    @gcsafe_ccall libhip.hipDeviceGetAttribute(pi::Ptr{Cint}, attr::hipDeviceAttribute_t, deviceId::Cint)::hipError_t
end

function hipEventCreate(event)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventCreate(event::Ptr{hipEvent_t})::hipError_t
end

function hipEventCreateWithFlags(event, flags)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventCreateWithFlags(event::Ptr{hipEvent_t}, flags::Cuint)::hipError_t
end

function hipEventDestroy(event)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventDestroy(event::hipEvent_t)::hipError_t
end

function hipEventRecord(event, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventRecord(event::hipEvent_t, stream::hipStream_t)::hipError_t
end

function hipEventQuery(event)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventQuery(event::hipEvent_t)::hipError_t
end

function hipEventSynchronize(event)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventSynchronize(event::hipEvent_t)::hipError_t
end

function hipEventElapsedTime(ms, start, stop)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipEventElapsedTime(ms::Ptr{Cfloat}, start::hipEvent_t, stop::hipEvent_t)::hipError_t
end

function hipStreamCreateWithPriority(stream, flags, priority)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipStreamCreateWithPriority(stream::Ptr{hipStream_t}, flags::Cuint, priority::Cint)::hipError_t
end

function hipStreamGetPriority(stream, priority)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipStreamGetPriority(stream::hipStream_t, priority::Ptr{Cint})::hipError_t
end

function hipStreamSynchronize(stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t
end

function hipStreamDestroy(stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipStreamDestroy(stream::hipStream_t)::hipError_t
end

function hipStreamQuery(stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipStreamQuery(stream::hipStream_t)::hipError_t
end

function hipDeviceSynchronize()
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceSynchronize()::hipError_t
end

function hipMalloc(ptr, size)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::hipError_t
end

function hipFree(ptr)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipFree(ptr::Ptr{Cvoid})::hipError_t
end

function hipHostMalloc(ptr, size, flags)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipHostMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, flags::Cuint)::hipError_t
end

function hipHostFree(ptr)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipHostFree(ptr::Ptr{Cvoid})::hipError_t
end

function hipHostRegister(hostPtr, sizeBytes, flags)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipHostRegister(hostPtr::Ptr{Cvoid}, sizeBytes::Csize_t, flags::Cuint)::hipError_t
end

function hipHostUnregister(hostPtr)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipHostUnregister(hostPtr::Ptr{Cvoid})::hipError_t
end

function hipHostGetDevicePointer(devPtr, hstPtr, flags)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipHostGetDevicePointer(devPtr::Ptr{Ptr{Cvoid}}, hstPtr::Ptr{Cvoid}, flags::Cuint)::hipError_t
end

function hipPointerGetAttributes(attributes, ptr)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipPointerGetAttributes(attributes::Ptr{hipPointerAttribute_t}, ptr::Ptr{Cvoid})::hipError_t
end

function hipMemcpy3DAsync(p, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpy3DAsync(p::Ptr{hipMemcpy3DParms}, stream::hipStream_t)::hipError_t
end

function hipMallocAsync(dev_ptr, size, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMallocAsync(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, stream::hipStream_t)::hipError_t
end

function hipFreeAsync(dev_ptr, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipFreeAsync(dev_ptr::Ptr{Cvoid}, stream::hipStream_t)::hipError_t
end

function hipMemcpyHtoDAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpyHtoDAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoHAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpyDtoHAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoH(dst, src, sizeBytes)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpyDtoH(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t)::hipError_t
end

function hipMemcpyDtoDAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpyDtoDAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyWithStream(dst, src, sizeBytes, kind, stream)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemcpyWithStream(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemGetInfo(free, total)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemGetInfo(free::Ptr{Csize_t}, total::Ptr{Csize_t})::hipError_t
end

function hipDeviceGetDefaultMemPool(mem_pool, device)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceGetDefaultMemPool(mem_pool::Ptr{hipMemPool_t}, device::Cint)::hipError_t
end

function hipDeviceGetMemPool(mem_pool, device)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceGetMemPool(mem_pool::Ptr{hipMemPool_t}, device::Cint)::hipError_t
end

function hipDeviceSetMemPool(device, mem_pool)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceSetMemPool(device::Cint, mem_pool::hipMemPool_t)::hipError_t
end

function hipMemPoolTrimTo(mem_pool, min_bytes_to_hold)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemPoolTrimTo(mem_pool::hipMemPool_t, min_bytes_to_hold::Csize_t)::hipError_t
end

function hipMemPoolSetAttribute(mem_pool, attr, value)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemPoolSetAttribute(mem_pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolGetAttribute(mem_pool, attr, value)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemPoolGetAttribute(mem_pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolCreate(mem_pool, pool_props)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemPoolCreate(mem_pool::Ptr{hipMemPool_t}, pool_props::Ptr{hipMemPoolProps})::hipError_t
end

function hipMemPoolDestroy(mem_pool)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipMemPoolDestroy(mem_pool::hipMemPool_t)::hipError_t
end

function hipDeviceGetLimit(pValue, limit)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceGetLimit(pValue::Ptr{Csize_t}, limit::hipLimit_t)::hipError_t
end

function hipDeviceSetLimit(limit, value)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceSetLimit(limit::hipLimit_t, value::Csize_t)::hipError_t
end

function hipModuleLoad(_module, fname)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleLoad(_module::Ptr{hipModule_t}, fname::Ptr{Cchar})::hipError_t
end

function hipModuleLoadData(_module, image)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleLoadData(_module::Ptr{hipModule_t}, image::Ptr{Cvoid})::hipError_t
end

function hipModuleGetFunction(_function, _module, kname)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleGetFunction(_function::Ptr{hipFunction_t}, _module::hipModule_t, kname::Ptr{Cchar})::hipError_t
end

function hipModuleUnload(_module)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleUnload(_module::hipModule_t)::hipError_t
end

function hipModuleLaunchKernel(
    f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ,
    sharedMemBytes, stream, kernelParams, extra,
)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleLaunchKernel(f::hipFunction_t, gridDimX::Cuint, gridDimY::Cuint, gridDimZ::Cuint, blockDimX::Cuint, blockDimY::Cuint, blockDimZ::Cuint, sharedMemBytes::Cuint, stream::hipStream_t, kernelParams::Ptr{Ptr{Cvoid}}, extra::Ptr{Ptr{Cvoid}})::hipError_t
end

function hipModuleOccupancyMaxPotentialBlockSize(
    gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit,
)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipModuleOccupancyMaxPotentialBlockSize(gridSize::Ptr{Cint}, blockSize::Ptr{Cint}, f::hipFunction_t, dynSharedMemPerBlk::Csize_t, blockSizeLimit::Cint)::hipError_t
end

function hipDeviceCanAccessPeer(canAccessPeer, deviceId, peerDeviceId)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipDeviceCanAccessPeer(canAccessPeer::Ptr{Cint}, deviceId::Cint, peerDeviceId::Cint)::hipError_t
end

function hipLaunchHostFunc(stream, fn, userData)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhip.hipLaunchHostFunc(stream::hipStream_t, fn::hipHostFn_t, userData::Ptr{Cvoid})::hipError_t
end
