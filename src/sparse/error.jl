export ROCSPARSEError

@cenum rocsparse_status_::UInt32 begin
    rocsparse_status_success = 0
    rocsparse_status_invalid_handle = 1
    rocsparse_status_not_implemented = 2
    rocsparse_status_invalid_pointer = 3
    rocsparse_status_invalid_size = 4
    rocsparse_status_memory_error = 5
    rocsparse_status_internal_error = 6
    rocsparse_status_invalid_value = 7
    rocsparse_status_arch_mismatch = 8
    rocsparse_status_zero_pivot = 9
    rocsparse_status_not_initialized = 10
    rocsparse_status_type_mismatch = 11
    rocsparse_status_requires_sorted_storage = 12
    rocsparse_status_thrown_exception = 13
    rocsparse_status_continue = 14
end

const rocsparse_status = rocsparse_status_

struct ROCSPARSEError <: Exception
    code::rocsparse_status
end

Base.convert(::Type{rocsparse_status}, err::ROCSPARSEError) = err.code

Base.showerror(io::IO, err::ROCSPARSEError) =
    print(io, "ROCSPARSEError: (code $(reinterpret(Int32, err.code)), $(name(err)))")

function rocsparse_get_error_name(err::rocsparse_status)
    if err == rocsparse_status_success
        return "rocsparse_status_success"
    elseif err == rocsparse_status_invalid_handle
        return "rocsparse_status_invalid_handle"
    elseif err == rocsparse_status_not_implemented
        return "rocsparse_status_not_implemented"
    elseif err == rocsparse_status_invalid_pointer
        return "rocsparse_status_invalid_pointer"
    elseif err == rocsparse_status_invalid_size
        return "rocsparse_status_invalid_size"
    elseif err == rocsparse_status_memory_error
        return "rocsparse_status_memory_error"
    elseif err == rocsparse_status_internal_error
        return "rocsparse_status_internal_error"
    elseif err == rocsparse_status_invalid_value
        return "rocsparse_status_invalid_value"
    elseif err == rocsparse_status_arch_mismatch
        return "rocsparse_status_arch_mismatch"
    elseif err == rocsparse_status_zero_pivot
        return "rocsparse_status_zero_pivot"
    elseif err == rocsparse_status_not_initialized
        return "rocsparse_status_not_initialized"
    elseif err == rocsparse_status_type_mismatch
        return "rocsparse_status_type_mismatch"
    elseif err == rocsparse_status_requires_sorted_storage
        return "rocsparse_status_requires_sorted_storage"
    else
        throw(ArgumentError("invalid rocsparse error code."))
    end
end

name(err::ROCSPARSEError) = rocsparse_get_error_name(err.code)

## API call wrapper

# outlined functionality to avoid GC frame allocation
@noinline function throw_api_error(res)
    if res == rocsparse_status_memory_error
        throw(OutOfGPUMemoryError())
    else
        throw(ROCSPARSEError(res))
    end
end

macro check(rocsparse_func)
    quote
        local err::rocsparse_status
        err = $(esc(rocsparse_func::Expr))
        if err != rocsparse_status_success
            throw(ROCSPARSEError(err))
        end
        err
    end
end
