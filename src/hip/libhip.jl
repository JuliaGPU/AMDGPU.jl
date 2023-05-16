function hipInit(flags)
    @ccall libhip.hipInit(flags::Cint)::hipError_t
end

function hipDeviceGet(dev::Ref{hipDevice_t}, device_id)
    @ccall libhip.hipDeviceGet(
        dev::Ptr{hipDevice_t}, device_id::Cint)::hipError_t
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

function hipSetDevice(device_id)
    @ccall libhip.hipSetDevice(device_id::Cint)::hipError_t
end

function hipGetDeviceCount(count_ref)
    @ccall libhip.hipGetDeviceCount(count_ref::Ptr{Cint})::hipError_t
end

function hipGetDeviceProperties(prop, dev_id)
    @ccall libhip.hipGetDeviceProperties(
        prop::Ptr{hipDeviceProp_t}, dev_id::Cint)::hipError_t
end

function hipDeviceGetName(name::Ptr{Cuchar}, len::Cint, device::hipDevice_t)
    ccall((:hipDeviceGetName, libhip), hipError_t,
          (Ptr{Cuchar}, Cint, hipDevice_t), name, len, device)
end

function hipDeviceGetAttribute(val, attribute, device_id)
    @ccall libhip.hipDeviceGetAttribute(
        val::Ptr{Cint}, attribute::hipDeviceAttribute_t,
        device_id::Cint)::hipError_t
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

function hipEventSynchronize(event)
    @ccall libhip.hipEventSynchronize(event::hipEvent_t)::hipError_t
end

function hipStreamCreateWithPriority(stream_ref::Ref{hipStream_t}, flags::Cuint, priority::Cint)
    ccall((:hipStreamCreateWithPriority, libhip), hipError_t,
          (Ptr{hipStream_t}, Cuint, Cint), stream_ref, flags, priority)
end

function hipStreamGetPriority(stream::hipStream_t, priority::Ref{Cint})
    ccall((:hipStreamGetPriority, libhip), hipError_t, (hipStream_t, Ptr{Cint}), stream, priority)
end

function hipStreamSynchronize(stream)
    @ccall libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t
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

function hipMallocAsync(ptr, sz, stream)
    @ccall libhip.hipMallocAsync(
        ptr::Ptr{Ptr{Cvoid}}, sz::Csize_t, stream::hipStream_t)::hipError_t
end

function hipFreeAsync(ptr, stream)
    @ccall libhip.hipFreeAsync(ptr::Ptr{Cvoid}, stream::hipStream_t)::hipError_t
end

function hipMemcpyHtoDAsync(dst, src, sz, stream)
    @ccall libhip.hipMemcpyHtoDAsync(
        dst::Ptr{Cvoid}, src::Ptr{Cvoid},
        sz::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoHAsync(dst, src, sz, stream)
    @ccall libhip.hipMemcpyDtoHAsync(
        dst::Ptr{Cvoid}, src::Ptr{Cvoid},
        sz::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoDAsync(dst, src, sz, stream)
    @ccall libhip.hipMemcpyDtoDAsync(
        dst::Ptr{Cvoid}, src::Ptr{Cvoid},
        sz::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemGetInfo(free::Ref{Csize_t}, total::Ref{Csize_t})
    ccall((:hipMemGetInfo, libhip), hipError_t, (Ptr{Csize_t}, Ptr{Csize_t}), free, total)
end

function hipDeviceGetDefaultMemPool(pool, device_id)
    @ccall libhip.hipDeviceGetDefaultMemPool(
        pool::Ref{hipMemPool_t}, device_id::Cint)::hipError_t
end

function hipDeviceGetMemPool(pool, device_id)
    @ccall libhip.hipDeviceGetMemPool(
        pool::Ref{hipMemPool_t}, device_id::Cint)::hipError_t
end

function hipDeviceSetMemPool(device_id, pool)
    @ccall libhip.hipDeviceSetMemPool(
        device_id::Cint, pool::hipMemPool_t)::hipError_t
end

function hipMemPoolTrimTo(pool, min_bytes_to_hold)
    @ccall libhip.hipMemPoolTrimTo(
        pool::hipMemPool_t, min_bytes_to_hold::Csize_t)::hipError_t
end

function hipMemPoolSetAttribute(pool, attr, value)
    @ccall libhip.hipMemPoolSetAttribute(
        pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolGetAttribute(pool, attr, value)
    @ccall libhip.hipMemPoolGetAttribute(
        pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolCreate(pool, props)
    @ccall libhip.hipMemPoolCreate(
        pool::Ptr{hipMemPool_t}, props::Ptr{hipMemPoolProps})::hipError_t
end

function hipMemPoolDestroy(pool)
    @ccall libhip.hipMemPoolDestroy(pool::hipMemPool_t)::hipError_t
end

function hipDeviceGetLimit(value, limit)
    @ccall libhip.hipDeviceGetLimit(
        value::Ptr{Csize_t}, limit::hipLimit_t)::hipError_t
end

function hipDeviceSetLimit(limit, value)
    @ccall libhip.hipDeviceSetLimit(
        limit::hipLimit_t, value::Csize_t)::hipError_t
end

function hiprtcLinkCreate(n_options, option_ptr, option_vals_pptr, hip_link_state_ptr)
    @ccall libhip.hiprtcLinkCreate(
        n_options::Cuint,
        option_ptr::Ptr{hiprtcJIT_option}, option_vals_pptr::Ptr{Ptr{Cvoid}},
        hip_link_state_ptr::Ptr{hiprtcLinkState})::hiprtcResult
end

function hiprtcLinkAddFile(
    hip_link_state, input_type, file_path,
    num_options, options_ptr, option_vals_pptr,
)
    @ccall libhip.hiprtcLinkAddFile(
        hip_link_state::hiprtcLinkState, input_type::hiprtcJITInputType,
        file_path::Ptr{Cchar}, num_options::Cuint,
        options_ptr::Ptr{hiprtcJIT_option},
        option_vals_pptr::Ptr{Ptr{Cvoid}})::hiprtcResult
end

function hiprtcLinkComplete(hip_link_state, bin_out, size_out)
    @ccall libhip.hiprtcLinkComplete(
        hip_link_state::hiprtcLinkState, bin_out::Ptr{Ptr{Cvoid}},
        size_out::Ptr{Csize_t})::hiprtcResult
end

function hipModuleLoad(mod, fname)
    @ccall libhip.hipModuleLoad(
        mod::Ptr{hipModule_t}, fname::Ptr{Cchar})::hipError_t
end

function hipModuleLoadData(mod, img)
    @ccall libhip.hipModuleLoadData(
        mod::Ptr{hipModule_t}, img::Ptr{Cvoid})::hipError_t
end

function hipModuleGetFunction(func, mod, name)
    @ccall libhip.hipModuleGetFunction(
        func::Ptr{hipFunction_t}, mod::hipModule_t, name::Ptr{Cchar})::hipError_t
end

function hipModuleUnload(mod)
    @ccall libhip.hipModuleUnload(mod::hipModule_t)::hipError_t
end

function hipModuleLaunchKernel(
    func,
    gridDimX, gridDimY, gridDimZ,
    blockDimX, blockDimY, blockDimZ,
    sharedMemBytes, stream, kernelParams, extra,
)
    @ccall libhip.hipModuleLaunchKernel(
        func::hipFunction_t,
        gridDimX::Cuint, gridDimY::Cuint, gridDimZ::Cuint,
        blockDimX::Cuint, blockDimY::Cuint, blockDimZ::Cuint,
        sharedMemBytes::Cuint, stream::hipStream_t,
        kernelParams::Ptr{Ptr{Cvoid}},
        extra::Ptr{Ptr{Cvoid}},
    )::hipError_t
end
