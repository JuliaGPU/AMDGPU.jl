function hipStreamSynchronize(stream::hipStream_t)
    ccall((:hipStreamSynchronize, libhip), hipError_t, (hipStream_t,), stream)
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
