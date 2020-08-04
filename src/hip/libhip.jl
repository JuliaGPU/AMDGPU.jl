function hipStreamSynchronize(stream::hipStream_t)
    @check ccall((:hipStreamSynchronize, libhip), hipError_t, (hipStream_t,), stream)
end

function hipStreamQuery(stream::hipStream_t)
    @check ccall((:hipStreamQuery, libhip), hipError_t, (hipStream_t,), stream)
end

function hipDeviceSynchronize()
    @check ccall((:hipDeviceSynchronize, libhip), hipError_t, ())
end
