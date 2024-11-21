function version()
    len_ref = Ref{Csize_t}()
    rocsolver_get_version_string_size(len_ref)
    len = len_ref[]

    buf = Vector{Cchar}(undef, len)
    rocsolver_get_version_string(buf, len)
    str = unsafe_string(reinterpret(Cstring, pointer(buf)))

    VersionNumber(join(split(str, '.')[1:3], '.'))
end

function Base.convert(::Type{rocblas_svect}, job::Char)
    if job == 'N'
        return rocblas_svect_none
    elseif job == 'A'
        return rocblas_svect_all
    elseif job == 'O'
        return rocblas_svect_overwrite
    elseif job == 'S'
        return rocblas_svect_singular
    else
        throw(ArgumentError("Unknown job $job."))
    end
end

function Base.convert(::Type{rocblas_workmode}, mode::Char)
    if mode == 'O'
        return rocblas_outofplace
    elseif mode == 'I'
        return rocblas_inplace
    else
        throw(ArgumentError("Unknown workmode $mode."))
    end
end

function Base.convert(::Type{rocblas_storev}, storev::Char)
    if storev == 'C'
        rocblas_column_wise
    elseif storev == 'R'
        rocblas_row_wise
    else
        throw(ArgumentError("Unknown storage mode $storev."))
    end
end

function Base.convert(::Type{rocblas_direct}, direct::Char)
    if direct == 'F'
        rocblas_forward_direction
    elseif direct == 'B'
        rocblas_backward_direction
    else
        throw(ArgumentError("Unknown direction mode $direct."))
    end
end
