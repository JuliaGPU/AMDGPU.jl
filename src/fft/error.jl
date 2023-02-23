export ROCFFTError

import .AMDGPU: @check, check

struct ROCFFTError <: Exception
    code::rocfft_status
    msg::AbstractString
end
Base.show(io::IO, err::ROCFFTError) = print(io, "ROCFFTError(code $(err.code), $(err.msg))")

function ROCFFTError(code::rocfft_status)
    msg = status_message(code)
    return ROCFFTError(code, msg)
end

function status_message(status)
    if status == rocfft_status_success
        return "the operation completed successfully"
    elseif status == rocfft_status_failure
        return "an operation failed"
    elseif status == rocfft_status_invalid_arg_value
        return "invalid argument value"
    elseif status == rocfft_status_invalid_dimensions
        return "invalid array dimension"
    elseif status == rocfft_status_invalid_array_type
        return "invalid array type"
    elseif status == rocfft_status_invalid_strides
        return "invalid strides"
    elseif status == rocfft_status_invalid_distance
        return "invalid distance"
    elseif status == rocfft_status_invalid_offset
        return "invalid offset"
    else
        return "unknown error"
    end
end

function check(status::rocfft_status)
    if status != rocfft_status_success
        throw(ROCFFTError(status))
    end
    return status
end
