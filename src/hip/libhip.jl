function hipStreamSynchronize(stream::hipStream_t)
    @check ccall((:hipStreamSynchronize, "libhip_hcc.so"), hipError_t, (hipStream_t,), stream)
end

function hipStreamQuery(stream::hipStream_t)
    @check ccall((:hipStreamQuery, "libhip_hcc.so"), hipError_t, (hipStream_t,), stream)
end

function hipDeviceSynchronize()
    @check ccall((:hipDeviceSynchronize, "libhip_hcc.so"), hipError_t, ())
end
