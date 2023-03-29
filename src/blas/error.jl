export ROCBLASError

struct ROCBLASError <: Exception
    code::rocblas_status
    msg::AbstractString
end
Base.show(io::IO, err::ROCBLASError) = print(io, "ROCBLASError(code $(err.code), $(err.msg))")

function ROCBLASError(code::rocblas_status)
    msg = status_message(code)
    return ROCBLASError(code, msg)
end

function status_message(status)
    if status == rocblas_status_success
        return "the operation completed successfully"
    elseif status == rocblas_status_invalid_handle
        return "handle not initialized, invalid or null"
    elseif status == rocblas_status_not_implemented
        return "this function is not implemented"
    elseif status == rocblas_status_invalid_pointer
        return "invalid pointer parameter"
    elseif status == rocblas_status_invalid_size
        return "invalid size parameter"
    elseif status == rocblas_status_memory_error
        return "failed internal memory allocation, copy or dealloc"
    elseif status == rocblas_status_internal_error
        return "an internal operation failed"
    else
        return "unknown status: $status"
    end
end

function check(status::rocblas_status)
    if status != rocblas_status_success
        throw(ROCBLASError(status))
    end
    return status
end
