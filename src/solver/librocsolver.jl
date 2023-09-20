function rocsolver_get_version_string_size(len)
    AMDGPU.prepare_state()
    ccall((:rocsolver_get_version_string_size, librocsolver), rocblas_status, (Ptr{Csize_t},), len)
end

function rocsolver_get_version_string(buf, len)
    AMDGPU.prepare_state()
    ccall((:rocsolver_get_version_string, librocsolver), rocblas_status, (Ptr{Cchar}, Csize_t), buf, len)
end

function rocsolver_sgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_sgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}), handle, m, n, A, lda, ipiv)
end

function rocsolver_dgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_dgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}), handle, m, n, A, lda, ipiv)
end

function rocsolver_cgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_cgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}), handle, m, n, A, lda, ipiv)
end

function rocsolver_zgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_zgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}), handle, m, n, A, lda, ipiv)
end

function rocsolver_sormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    ccall((:rocsolver_sormqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}, Ptr{Float32}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_dormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    ccall((:rocsolver_dormqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}, Ptr{Float64}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_cunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    ccall((:rocsolver_cunmqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}, Ptr{ComplexF32}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_zunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    ccall((:rocsolver_zunmqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}, Ptr{ComplexF64}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_sorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_sorgqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_dorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_dorgqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_cungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_cungqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_zungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    ccall((:rocsolver_zungqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_sgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    ccall((:rocsolver_sgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_dgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    ccall((:rocsolver_dgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_cgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    ccall((:rocsolver_cgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_zgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    ccall((:rocsolver_zgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_sgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    ccall((:rocsolver_sgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Float32}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_dgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    ccall((:rocsolver_dgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Float64}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_cgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    ccall((:rocsolver_cgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}, Ptr{ComplexF32}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_zgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    ccall((:rocsolver_zgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}, Ptr{ComplexF64}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end
