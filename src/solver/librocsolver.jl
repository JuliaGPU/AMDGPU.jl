function rocsolver_get_version_string_size(len)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_get_version_string_size, librocsolver), rocblas_status, (Ptr{Csize_t},), len)
end

function rocsolver_get_version_string(buf, len)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_get_version_string, librocsolver), rocblas_status, (Ptr{Cchar}, Csize_t), buf, len)
end

function rocsolver_sgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}), handle, m, n, A, lda, ipiv)
end

function rocsolver_dgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}), handle, m, n, A, lda, ipiv)
end

function rocsolver_cgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}), handle, m, n, A, lda, ipiv)
end

function rocsolver_zgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgeqrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}), handle, m, n, A, lda, ipiv)
end

function rocsolver_sormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sormqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}, Ptr{Float32}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_dormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dormqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}, Ptr{Float64}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_cunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cunmqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}, Ptr{ComplexF32}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_zunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zunmqr, librocsolver), rocblas_status, (rocblas_handle, rocblas_side, rocblas_operation, Cint, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}, Ptr{ComplexF64}, Cint), handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
end

function rocsolver_sorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sorgqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_dorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dorgqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_cungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cungqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_zungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zungqr, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}), handle, m, n, k, A, lda, ipiv)
end

function rocsolver_sgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_dgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_cgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_zgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgetrf, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, m, n, A, lda, ipiv, info)
end

function rocsolver_sgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Float32}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_dgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Float64}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_cgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}, Ptr{ComplexF32}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_zgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgetrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_operation, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}, Ptr{ComplexF64}, Cint), handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
end

function rocsolver_spotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_spotrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{Float32}, Cint, Ptr{Cint}), handle, uplo, n, A, lda, info)
end

function rocsolver_dpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dpotrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{Float64}, Cint, Ptr{Cint}), handle, uplo, n, A, lda, info)
end

function rocsolver_cpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cpotrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}), handle, uplo, n, A, lda, info)
end

function rocsolver_zpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zpotrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}), handle, uplo, n, A, lda, info)
end

function rocsolver_spotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_spotrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Cint, Ptr{Float32}, Cint, Ptr{Float32}, Cint), handle, uplo, n, nrhs, A, lda, B, ldb)
end

function rocsolver_dpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dpotrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Cint, Ptr{Float64}, Cint, Ptr{Float64}, Cint), handle, uplo, n, nrhs, A, lda, B, ldb)
end

function rocsolver_cpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cpotrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Cint, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}, Cint), handle, uplo, n, nrhs, A, lda, B, ldb)
end

function rocsolver_zpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zpotrs, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Cint, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}, Cint), handle, uplo, n, nrhs, A, lda, B, ldb)
end

function rocsolver_ssytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_ssytrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, uplo, n, A, lda, ipiv, info)
end

function rocsolver_dsytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dsytrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, uplo, n, A, lda, ipiv, info)
end

function rocsolver_csytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_csytrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}, Ptr{Cint}), handle, uplo, n, A, lda, ipiv, info)
end

function rocsolver_zsytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zsytrf, librocsolver), rocblas_status, (rocblas_handle, rocblas_fill, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}, Ptr{Cint}), handle, uplo, n, A, lda, ipiv, info)
end

function rocsolver_sgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgetrf_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Ptr{Float32}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, m, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_dgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dgetrf_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Ptr{Float64}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, m, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_cgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cgetrf_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Ptr{ComplexF32}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, m, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_zgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgetrf_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Cint, Ptr{Ptr{ComplexF64}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, m, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_sgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgetri_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Ptr{Ptr{Float32}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_dgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()

    @check ccall((:rocsolver_dgetri_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Ptr{Ptr{Float64}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_cgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()

    @check ccall((:rocsolver_cgetri_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Ptr{Ptr{ComplexF32}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_zgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgetri_batched, librocsolver), rocblas_status, (rocblas_handle, Cint, Ptr{Ptr{ComplexF64}}, Cint, Ptr{Cint}, rocblas_stride, Ptr{Cint}, Cint), handle, n, A, lda, ipiv, strideP, info, batch_count)
end

function rocsolver_zgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zgesvdj, librocsolver), rocblas_status, (rocblas_handle, rocblas_svect, rocblas_svect, Cint, Cint, Ptr{ComplexF64}, Cint, Float64, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Float64}, Ptr{ComplexF64}, Cint, Ptr{ComplexF64}, Cint, Ptr{Cint}), handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
end

function rocsolver_cgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cgesvdj, librocsolver), rocblas_status, (rocblas_handle, rocblas_svect, rocblas_svect, Cint, Cint, Ptr{ComplexF32}, Cint, Float32, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Float32}, Ptr{ComplexF32}, Cint, Ptr{ComplexF32}, Cint, Ptr{Cint}), handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
end

function rocsolver_dgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dgesvdj, librocsolver), rocblas_status, (rocblas_handle, rocblas_svect, rocblas_svect, Cint, Cint, Ptr{Float64}, Cint, Float64, Ptr{Float64}, Cint, Ptr{Cint}, Ptr{Float64}, Ptr{Float64}, Cint, Ptr{Float64}, Cint, Ptr{Cint}), handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
end

function rocsolver_sgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_sgesvdj, librocsolver), rocblas_status, (rocblas_handle, rocblas_svect, rocblas_svect, Cint, Cint, Ptr{Float32}, Cint, Float32, Ptr{Float32}, Cint, Ptr{Cint}, Ptr{Float32}, Ptr{Float32}, Cint, Ptr{Float32}, Cint, Ptr{Cint}), handle, left_svect, right_svect, m, n, A, lda, abstol, residual, max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
end

function rocsolver_dsyevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_dsyevd, librocsolver), rocblas_status, (rocblas_handle, rocblas_evect, rocblas_fill, Cint, Ptr{Float64}, Cint, Ptr{Float64}, Ptr{Float64}, Ptr{Cint}), handle, evect, uplo, n, A, lda, D, E, info)
end

function rocsolver_ssyevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_ssyevd, librocsolver), rocblas_status, (rocblas_handle, rocblas_evect, rocblas_fill, Cint, Ptr{Float32}, Cint, Ptr{Float32}, Ptr{Float32}, Ptr{Cint}), handle, evect, uplo, n, A, lda, D, E, info)
end

function rocsolver_zheevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_zheevd, librocsolver), rocblas_status, (rocblas_handle, rocblas_evect, rocblas_fill, Cint, Ptr{ComplexF64}, Cint, Ptr{Float64}, Ptr{Float64}, Ptr{Cint}), handle, evect, uplo, n, A, lda, D, E, info)
end

function rocsolver_cheevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check ccall((:rocsolver_cheevd, librocsolver), rocblas_status, (rocblas_handle, rocblas_evect, rocblas_fill, Cint, Ptr{ComplexF64}, Cint, Ptr{Float64}, Ptr{Float64}, Ptr{Cint}), handle, evect, uplo, n, A, lda, D, E, info)
end
