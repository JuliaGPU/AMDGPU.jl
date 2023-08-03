function rocsolver_get_version_string_size(len)
    ccall((:rocsolver_get_version_string_size, librocsolver), rocblas_status,
        (Ptr{Csize_t},), len)
end

function rocsolver_get_version_string(buf, len)
    ccall((:rocsolver_get_version_string, librocsolver), rocblas_status,
        (Ptr{Cchar}, Csize_t), buf, len)
end

function rocsolver_sgeqrf(handle, m, n, A, lda, ipiv)
    ccall((:rocsolver_sgeqrf, librocsolver), rocblas_status,
        (rocblas_handle, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}),
        handle, m, n, A, lda, ipiv)
end

function rocsolver_dgeqrf(handle, m, n, A, lda, ipiv)
    ccall((:rocsolver_dgeqrf, librocsolver), rocblas_status,
        (rocblas_handle, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}),
        handle, m, n, A, lda, ipiv)
end

function rocsolver_cgeqrf(handle, m, n, A, lda, ipiv)
    ccall((:rocsolver_cgeqrf, librocsolver), rocblas_status,
        (rocblas_handle, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}),
        handle, m, n, A, lda, ipiv)
end

function rocsolver_zgeqrf(handle, m, n, A, lda, ipiv)
    ccall((:rocsolver_zgeqrf, librocsolver), rocblas_status,
        (rocblas_handle, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}),
        handle, m, n, A, lda, ipiv)
end

function rocsolver_sormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    ccall((:rocsolver_sormqr, librocsolver), rocblas_status,
        (
            rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint,
            Ptr{Float32}, Cint, Ptr{Float32}, Ptr{Float32}, Cint),
        handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_dormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    ccall((:rocsolver_dormqr, librocsolver), rocblas_status,
        (
            rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint,
            Ptr{Float64}, Cint, Ptr{Float64}, Ptr{Float64}, Cint),
        handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_cunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    ccall((:rocsolver_cunmqr, librocsolver), rocblas_status,
        (
            rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint,
            Ptr{ComplexF32}, Cint, Ptr{ComplexF32}, Ptr{ComplexF32}, Cint),
        handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_zunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    ccall((:rocsolver_zunmqr, librocsolver), rocblas_status,
        (
            rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint,
            Ptr{ComplexF64}, Cint, Ptr{ComplexF64}, Ptr{ComplexF64}, Cint),
        handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end
