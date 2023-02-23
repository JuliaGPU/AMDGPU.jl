function rocblas_get_version_string()
    vec = zeros(UInt8, 64)
    str = reinterpret(Cstring, pointer(vec))
    ccall((:rocblas_get_version_string, librocblas), rocblas_status_t, (Cstring, Csize_t), str, 64)
    return unsafe_string(str)
end
function rocblas_pointer_to_mode(ptr)
    ccall((:rocblas_pointer_to_mode, librocblas), rocblas_pointer_mode_t, (Ptr{Cvoid},), ptr)
end
function rocblas_create_handle()
    handle = Ref{rocblas_handle}()
    ccall((:rocblas_create_handle, librocblas), rocblas_status_t, (Ptr{rocblas_handle},), handle)
    return handle[]
end
function rocblas_destroy_handle(handle)
    ccall((:rocblas_destroy_handle, librocblas), rocblas_status_t, (rocblas_handle,), handle)
end
function rocblas_add_stream(handle, stream)
    ccall((:rocblas_add_stream, librocblas), rocblas_status_t, (rocblas_handle, hipStream_t), handle, stream)
end
function rocblas_set_stream(handle, stream)
    ccall((:rocblas_set_stream, librocblas), rocblas_status_t, (rocblas_handle, hipStream_t), handle, stream)
end
function rocblas_get_stream(handle)
    stream = Ref{hipStream_t}()
    ccall((:rocblas_get_stream, librocblas), rocblas_status_t, (rocblas_handle, Ptr{hipStream_t}), handle, stream)
    return stream[]
end
function rocblas_set_pointer_mode(handle, pointer_mode)
    ccall((:rocblas_set_pointer_mode, librocblas), rocblas_status_t, (rocblas_handle, rocblas_pointer_mode_t), handle, pointer_mode)
end
function rocblas_get_pointer_mode(handle)
    pointer_mode = Ref{rocblas_pointer_mode_t}()
    ccall((:rocblas_get_pointer_mode, librocblas), rocblas_status_t, (rocblas_handle, Ptr{rocblas_pointer_mode_t}), handle, pointer_mode)
    return pointer_mode[]
end

#= TODO: I don't know if these are really important...
function rocblas_set_vector()
    ccall((:rocblas_set_vector, librocblas), rocblas_status_t, n::rocblas_int_t, elem_size::rocblas_int_t, x::Ptr{Cvoid}, incx::rocblas_int_t, y::Ptr{Cvoid}, incy::rocblas_int_t)
end
function rocblas_get_vector()
    ccall((:rocblas_get_vector, librocblas), rocblas_status_t, n::rocblas_int_t, elem_size::rocblas_int_t, x::Ptr{Cvoid}, incx::rocblas_int_t, y::Ptr{Cvoid}, incy::rocblas_int_t)
end
function rocblas_set_matrix()
    ccall((:rocblas_set_matrix, librocblas), rocblas_status_t, rows::rocblas_int_t, cols::rocblas_int_t, elem_size::rocblas_int_t, a::Ptr{Cvoid}, lda::rocblas_int_t, b::Ptr{Cvoid}, ldb::rocblas_int_t)
end
function rocblas_get_matrix()
    ccall((:rocblas_get_matrix, librocblas), rocblas_status_t, rows::rocblas_int_t, cols::rocblas_int_t, elem_size::rocblas_int_t, a::Ptr{Cvoid}, lda::rocblas_int_t, b::Ptr{Cvoid}, ldb::rocblas_int_t)
end
=#
