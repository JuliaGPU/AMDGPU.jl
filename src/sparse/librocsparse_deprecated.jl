# TODO remove once we support only ROCm 6.0+.

function rocsparse_spmv(
    handle, trans, alpha, mat, x, beta, y, compute_type, alg,
    buffer_size, temp_buffer,
)
    AMDGPU.prepare_state()
    @check ccall((:rocsparse_spmv, librocsparse), rocsparse_status,
        (rocsparse_handle, rocsparse_operation, Ptr{Cvoid},
        rocsparse_spmat_descr, rocsparse_dnvec_descr, Ptr{Cvoid},
        rocsparse_dnvec_descr, rocsparse_datatype, rocsparse_spmv_alg,
        Ptr{Csize_t}, Ptr{Cvoid}),
        handle, trans, alpha, mat, x, beta, y, compute_type, alg,
        buffer_size, temp_buffer)
end
