export ROCRANDError

import .AMDGPU: @check, check

struct ROCRANDError <: Exception
    code::rocrand_status
    msg::AbstractString
end
Base.show(io::IO, err::ROCRANDError) = print(io, "ROCRANDError(code $(err.code), $(err.msg))")

function ROCRANDError(code::rocrand_status)
    msg = status_message(code)
    return ROCRANDError(code, msg)
end

function status_message(status)
    if status == ROCRAND_STATUS_SUCCESS
        return "the operation completed successfully"
    elseif status == ROCRAND_STATUS_VERSION_MISMATCH
        return "header file and linked library version do not match"
    elseif status == ROCRAND_STATUS_NOT_CREATED
        return "generator was not created"
    elseif status == ROCRAND_STATUS_ALLOCATION_FAILED
        return "memory allocation failed"
    elseif status == ROCRAND_STATUS_TYPE_ERROR
        return "wrong generator type"
    elseif status == ROCRAND_STATUS_OUT_OF_RANGE
        return "argument out of range"
    elseif status == ROCRAND_STATUS_LENGTH_NOT_MULTIPLE
        return "requested size is not a multiple of quasirandom generator's dimension"
    elseif status == ROCRAND_STATUS_DOUBLE_PRECISION_REQUIRED
        return "GPU does not support double precision"
    elseif status == ROCRAND_STATUS_LAUNCH_FAILURE
        return "kernel launch failure"
    elseif status == ROCRAND_STATUS_INTERNAL_ERROR
        return "internal library error"
    else
        return "unknown error"
    end
end

function check(status::rocrand_status)
    if status != ROCRAND_STATUS_SUCCESS
        throw(ROCRANDError(status))
    end
    return status
end
