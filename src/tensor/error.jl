export hipTENSORError

struct hipTENSORError <: Exception
    code::hiptensorStatus_t
end

Base.convert(::Type{hiptensorStatus_t}, err::hipTENSORError) = err.code

Base.showerror(io::IO, err::hipTENSORError) =
    print(io, "hipTENSORError: ", description(err), " (code $(reinterpret(Int32, err.code)), $(name(err)))")

name(err::hipTENSORError) = unsafe_string(hiptensorGetErrorString(err))

## COV_EXCL_START
function description(err::hipTENSORError)
    if err.code == HIPTENSOR_STATUS_SUCCESS
        "the operation completed successfully"
    elseif err.code == HIPTENSOR_STATUS_NOT_INITIALIZED
        "the library was not initialized"
    elseif err.code == HIPTENSOR_STATUS_ALLOC_FAILED
        "the resource allocation failed"
    elseif err.code == HIPTENSOR_STATUS_INVALID_VALUE
        "an invalid value was used as an argument"
    elseif err.code == HIPTENSOR_STATUS_ARCH_MISMATCH
        "an absent device architectural feature is required"
    elseif err.code == HIPTENSOR_STATUS_EXECUTION_FAILED
        "the GPU program failed to execute"
    elseif err.code == HIPTENSOR_STATUS_INTERNAL_ERROR
        "an internal operation failed"
    elseif err.code == HIPTENSOR_STATUS_NOT_SUPPORTED
        "operation not supported (yet)"
    elseif err.code == HIPTENSOR_STATUS_CK_ERROR
        "error detected trying to check the license"
    elseif err.code == HIPTENSOR_STATUS_HIP_ERROR
        "error occurred during a HIP operation"
    elseif err.code == HIPTENSOR_STATUS_INSUFFICIENT_WORKSPACE
        "insufficient workspace memory for this operation"
    elseif err.code == HIPTENSOR_STATUS_INSUFFICIENT_DRIVER
        "insufficient driver version"
    elseif err.code == HIPTENSOR_STATUS_IO_ERROR
        "file not found"
    else
        "no description for this error"
    end
end
## COV_EXCL_STOP
