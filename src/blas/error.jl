export ROCBLASError

struct ROCBLASError <: Exception
    code::rocblas_status_t
    msg::AbstractString
end
Base.show(io::IO, err::ROCBLASError) = print(io, "ROCBLASError(code $(err.code), $(err.msg))")

function ROCBLASError(code::rocblas_status_t)
    msg = status_message(code)
    return ROCBLASError(code, msg)
end

function status_message(status)
    if status == ROCBLAS_STATUS_SUCCESS
        return "the operation completed successfully"
    elseif status == ROCBLAS_STATUS_INVALID_HANDLE
        return "handle not initialized, invalid or null"
    elseif status == ROCBLAS_STATUS_NOT_IMPLEMENTED
        return "this function is not implemented"
    elseif status == ROCBLAS_STATUS_INVALID_POINTER
        return "invalid pointer parameter"
    elseif status == ROCBLAS_STATUS_INVALID_SIZE
        return "invalid size parameter"
    elseif status == ROCBLAS_STATUS_MEMORY_ERROR
        return "failed internal memory allocation, copy or dealloc"
    elseif status == ROCBLAS_STATUS_INTERNAL_ERROR
        return "an internal operation failed"
    else
        return "unknown status"
    end
end

macro check(blas_func)
    quote
        local err::rocblas_status_t
        err = $(esc(blas_func::Expr))
        if err != ROCBLAS_STATUS_SUCCESS
            throw(ROCBLASError(err))
        end
        err
    end
end
