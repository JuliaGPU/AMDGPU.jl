export ROCSPARSEError

struct ROCSPARSEError <: Exception
    code::rocsparse_status
end

Base.convert(::Type{rocsparseStatus}, err::ROCSPARSEError) = err.code

Base.showerror(io::IO, err::ROCSPARSEError) =
    print(io, "ROCSPARSEError: ", description(err), " (code $(reinterpret(Int32, err.code)), $(name(err)))")

function rocsparse_get_error_name(err::rocsparse_status) : Base.string
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

macro check(ex, errs...)
    check = :(isequal(err, rocsparse_status_memory_error))
    for err in errs
        check = :($check || isequal(err, $(esc(err))))
    end

    quote
        res = @retry_reclaim err->$check $(esc(ex))
        if res != rocsparse_status_success
            throw_api_error(res)
        end

        nothing
    end
end
