using CEnum

struct rocsparse_float_complex
    x::Cfloat
    y::Cfloat
end

struct rocsparse_double_complex
    x::Cdouble
    y::Cdouble
end

const rocsparse_int = Int32

mutable struct ihipStream_t end

const hipStream_t = Ptr{ihipStream_t}

mutable struct _rocsparse_handle end

const rocsparse_handle = Ptr{_rocsparse_handle}

mutable struct _rocsparse_mat_descr end

const rocsparse_mat_descr = Ptr{_rocsparse_mat_descr}

mutable struct _rocsparse_hyb_mat end

const rocsparse_hyb_mat = Ptr{_rocsparse_hyb_mat}

mutable struct _rocsparse_mat_info end

const rocsparse_mat_info = Ptr{_rocsparse_mat_info}

mutable struct _rocsparse_spvec_descr end

const rocsparse_spvec_descr = Ptr{_rocsparse_spvec_descr}

mutable struct _rocsparse_spmat_descr end

const rocsparse_spmat_descr = Ptr{_rocsparse_spmat_descr}

mutable struct _rocsparse_dnvec_descr end

const rocsparse_dnvec_descr = Ptr{_rocsparse_dnvec_descr}

mutable struct _rocsparse_dnmat_descr end

const rocsparse_dnmat_descr = Ptr{_rocsparse_dnmat_descr}

mutable struct _rocsparse_color_info end

const rocsparse_color_info = Ptr{_rocsparse_color_info}

@cenum rocsparse_operation_::UInt32 begin
    rocsparse_operation_none = 111
    rocsparse_operation_transpose = 112
    rocsparse_operation_conjugate_transpose = 113
end

const rocsparse_operation = rocsparse_operation_

@cenum rocsparse_index_base_::UInt32 begin
    rocsparse_index_base_zero = 0
    rocsparse_index_base_one = 1
end

const rocsparse_index_base = rocsparse_index_base_

@cenum rocsparse_matrix_type_::UInt32 begin
    rocsparse_matrix_type_general = 0
    rocsparse_matrix_type_symmetric = 1
    rocsparse_matrix_type_hermitian = 2
    rocsparse_matrix_type_triangular = 3
end

const rocsparse_matrix_type = rocsparse_matrix_type_

@cenum rocsparse_diag_type_::UInt32 begin
    rocsparse_diag_type_non_unit = 0
    rocsparse_diag_type_unit = 1
end

const rocsparse_diag_type = rocsparse_diag_type_

@cenum rocsparse_fill_mode_::UInt32 begin
    rocsparse_fill_mode_lower = 0
    rocsparse_fill_mode_upper = 1
end

const rocsparse_fill_mode = rocsparse_fill_mode_

@cenum rocsparse_storage_mode_::UInt32 begin
    rocsparse_storage_mode_sorted = 0
    rocsparse_storage_mode_unsorted = 1
end

const rocsparse_storage_mode = rocsparse_storage_mode_

@cenum rocsparse_action_::UInt32 begin
    rocsparse_action_symbolic = 0
    rocsparse_action_numeric = 1
end

const rocsparse_action = rocsparse_action_

@cenum rocsparse_direction_::UInt32 begin
    rocsparse_direction_row = 0
    rocsparse_direction_column = 1
end

const rocsparse_direction = rocsparse_direction_

@cenum rocsparse_hyb_partition_::UInt32 begin
    rocsparse_hyb_partition_auto = 0
    rocsparse_hyb_partition_user = 1
    rocsparse_hyb_partition_max = 2
end

const rocsparse_hyb_partition = rocsparse_hyb_partition_

@cenum rocsparse_analysis_policy_::UInt32 begin
    rocsparse_analysis_policy_reuse = 0
    rocsparse_analysis_policy_force = 1
end

const rocsparse_analysis_policy = rocsparse_analysis_policy_

@cenum rocsparse_solve_policy_::UInt32 begin
    rocsparse_solve_policy_auto = 0
end

const rocsparse_solve_policy = rocsparse_solve_policy_

@cenum rocsparse_pointer_mode_::UInt32 begin
    rocsparse_pointer_mode_host = 0
    rocsparse_pointer_mode_device = 1
end

const rocsparse_pointer_mode = rocsparse_pointer_mode_

@cenum rocsparse_layer_mode::UInt32 begin
    rocsparse_layer_mode_none = 0
    rocsparse_layer_mode_log_trace = 1
    rocsparse_layer_mode_log_bench = 2
end

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
end

const rocsparse_status = rocsparse_status_

@cenum rocsparse_indextype_::UInt32 begin
    rocsparse_indextype_u16 = 1
    rocsparse_indextype_i32 = 2
    rocsparse_indextype_i64 = 3
end

const rocsparse_indextype = rocsparse_indextype_

@cenum rocsparse_datatype_::UInt32 begin
    rocsparse_datatype_f32_r = 151
    rocsparse_datatype_f64_r = 152
    rocsparse_datatype_f32_c = 154
    rocsparse_datatype_f64_c = 155
end

const rocsparse_datatype = rocsparse_datatype_

@cenum rocsparse_format_::UInt32 begin
    rocsparse_format_coo = 0
    rocsparse_format_coo_aos = 1
    rocsparse_format_csr = 2
    rocsparse_format_csc = 3
    rocsparse_format_ell = 4
    rocsparse_format_bell = 5
end

const rocsparse_format = rocsparse_format_

@cenum rocsparse_order_::UInt32 begin
    rocsparse_order_row = 0
    rocsparse_order_column = 1
end

const rocsparse_order = rocsparse_order_

@cenum rocsparse_spmat_attribute_::UInt32 begin
    rocsparse_spmat_fill_mode = 0
    rocsparse_spmat_diag_type = 1
    rocsparse_spmat_matrix_type = 2
    rocsparse_spmat_storage_mode = 3
end

const rocsparse_spmat_attribute = rocsparse_spmat_attribute_

@cenum rocsparse_gtsv_interleaved_alg_::UInt32 begin
    rocsparse_gtsv_interleaved_alg_default = 0
    rocsparse_gtsv_interleaved_alg_thomas = 1
    rocsparse_gtsv_interleaved_alg_lu = 2
    rocsparse_gtsv_interleaved_alg_qr = 3
end

const rocsparse_gtsv_interleaved_alg = rocsparse_gtsv_interleaved_alg_

@cenum rocsparse_spmv_alg_::UInt32 begin
    rocsparse_spmv_alg_default = 0
    rocsparse_spmv_alg_coo = 1
    rocsparse_spmv_alg_csr_adaptive = 2
    rocsparse_spmv_alg_csr_stream = 3
    rocsparse_spmv_alg_ell = 4
end

const rocsparse_spmv_alg = rocsparse_spmv_alg_

@cenum rocsparse_spsv_alg_::UInt32 begin
    rocsparse_spsv_alg_default = 0
end

const rocsparse_spsv_alg = rocsparse_spsv_alg_

@cenum rocsparse_spsv_stage_::UInt32 begin
    rocsparse_spsv_stage_auto = 0
    rocsparse_spsv_stage_buffer_size = 1
    rocsparse_spsv_stage_preprocess = 2
    rocsparse_spsv_stage_compute = 3
end

const rocsparse_spsv_stage = rocsparse_spsv_stage_

@cenum rocsparse_spsm_alg_::UInt32 begin
    rocsparse_spsm_alg_default = 0
end

const rocsparse_spsm_alg = rocsparse_spsm_alg_

@cenum rocsparse_spsm_stage_::UInt32 begin
    rocsparse_spsm_stage_auto = 0
    rocsparse_spsm_stage_buffer_size = 1
    rocsparse_spsm_stage_preprocess = 2
    rocsparse_spsm_stage_compute = 3
end

const rocsparse_spsm_stage = rocsparse_spsm_stage_

@cenum rocsparse_spmm_alg_::UInt32 begin
    rocsparse_spmm_alg_default = 0
    rocsparse_spmm_alg_csr = 1
    rocsparse_spmm_alg_coo_segmented = 2
    rocsparse_spmm_alg_coo_atomic = 3
    rocsparse_spmm_alg_csr_row_split = 4
    rocsparse_spmm_alg_csr_merge = 5
    rocsparse_spmm_alg_coo_segmented_atomic = 6
    rocsparse_spmm_alg_bell = 7
end

const rocsparse_spmm_alg = rocsparse_spmm_alg_

@cenum rocsparse_sddmm_alg_::UInt32 begin
    rocsparse_sddmm_alg_default = 0
end

const rocsparse_sddmm_alg = rocsparse_sddmm_alg_

@cenum rocsparse_sparse_to_dense_alg_::UInt32 begin
    rocsparse_sparse_to_dense_alg_default = 0
end

const rocsparse_sparse_to_dense_alg = rocsparse_sparse_to_dense_alg_

@cenum rocsparse_dense_to_sparse_alg_::UInt32 begin
    rocsparse_dense_to_sparse_alg_default = 0
end

const rocsparse_dense_to_sparse_alg = rocsparse_dense_to_sparse_alg_

@cenum rocsparse_spmm_stage_::UInt32 begin
    rocsparse_spmm_stage_auto = 0
    rocsparse_spmm_stage_buffer_size = 1
    rocsparse_spmm_stage_preprocess = 2
    rocsparse_spmm_stage_compute = 3
end

const rocsparse_spmm_stage = rocsparse_spmm_stage_

@cenum rocsparse_spgemm_stage_::UInt32 begin
    rocsparse_spgemm_stage_auto = 0
    rocsparse_spgemm_stage_buffer_size = 1
    rocsparse_spgemm_stage_nnz = 2
    rocsparse_spgemm_stage_compute = 3
    rocsparse_spgemm_stage_symbolic = 4
    rocsparse_spgemm_stage_numeric = 5
end

const rocsparse_spgemm_stage = rocsparse_spgemm_stage_

@cenum rocsparse_spgemm_alg_::UInt32 begin
    rocsparse_spgemm_alg_default = 0
end

const rocsparse_spgemm_alg = rocsparse_spgemm_alg_

@cenum rocsparse_gpsv_interleaved_alg_::UInt32 begin
    rocsparse_gpsv_interleaved_alg_default = 0
    rocsparse_gpsv_interleaved_alg_qr = 1
end

const rocsparse_gpsv_interleaved_alg = rocsparse_gpsv_interleaved_alg_

function rocsparse_create_handle(handle)
    @check ccall((:rocsparse_create_handle, librocsparse), rocsparse_status, (Ptr{rocsparse_handle},), handle)
end

function rocsparse_destroy_handle(handle)
    @check ccall((:rocsparse_destroy_handle, librocsparse), rocsparse_status, (rocsparse_handle,), handle)
end

function rocsparse_set_stream(handle, stream)
    @check ccall((:rocsparse_set_stream, librocsparse), rocsparse_status, (rocsparse_handle, hipStream_t), handle, stream)
end

function rocsparse_get_stream(handle, stream)
    @check ccall((:rocsparse_get_stream, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{hipStream_t}), handle, stream)
end

function rocsparse_set_pointer_mode(handle, pointer_mode)
    @check ccall((:rocsparse_set_pointer_mode, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_pointer_mode), handle, pointer_mode)
end

function rocsparse_get_pointer_mode(handle, pointer_mode)
    @check ccall((:rocsparse_get_pointer_mode, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{rocsparse_pointer_mode}), handle, pointer_mode)
end

function rocsparse_get_version(handle, version)
    @check ccall((:rocsparse_get_version, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{Cint}), handle, version)
end

function rocsparse_get_git_rev(handle, rev)
    @check ccall((:rocsparse_get_git_rev, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{Cchar}), handle, rev)
end

function rocsparse_create_mat_descr(descr)
    @check ccall((:rocsparse_create_mat_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_mat_descr},), descr)
end

function rocsparse_copy_mat_descr(dest, src)
    @check ccall((:rocsparse_copy_mat_descr, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_mat_descr), dest, src)
end

function rocsparse_destroy_mat_descr(descr)
    @check ccall((:rocsparse_destroy_mat_descr, librocsparse), rocsparse_status, (rocsparse_mat_descr,), descr)
end

function rocsparse_set_mat_index_base(descr, base)
    @check ccall((:rocsparse_set_mat_index_base, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_index_base), descr, base)
end

function rocsparse_get_mat_index_base(descr)
    @check ccall((:rocsparse_get_mat_index_base, librocsparse), rocsparse_index_base, (rocsparse_mat_descr,), descr)
end

function rocsparse_set_mat_type(descr, type)
    @check ccall((:rocsparse_set_mat_type, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_matrix_type), descr, type)
end

function rocsparse_get_mat_type(descr)
    @check ccall((:rocsparse_get_mat_type, librocsparse), rocsparse_matrix_type, (rocsparse_mat_descr,), descr)
end

function rocsparse_set_mat_fill_mode(descr, fill_mode)
    @check ccall((:rocsparse_set_mat_fill_mode, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_fill_mode), descr, fill_mode)
end

function rocsparse_get_mat_fill_mode(descr)
    @check ccall((:rocsparse_get_mat_fill_mode, librocsparse), rocsparse_fill_mode, (rocsparse_mat_descr,), descr)
end

function rocsparse_set_mat_diag_type(descr, diag_type)
    @check ccall((:rocsparse_set_mat_diag_type, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_diag_type), descr, diag_type)
end

function rocsparse_get_mat_diag_type(descr)
    @check ccall((:rocsparse_get_mat_diag_type, librocsparse), rocsparse_diag_type, (rocsparse_mat_descr,), descr)
end

function rocsparse_set_mat_storage_mode(descr, storage_mode)
    @check ccall((:rocsparse_set_mat_storage_mode, librocsparse), rocsparse_status, (rocsparse_mat_descr, rocsparse_storage_mode), descr, storage_mode)
end

function rocsparse_get_mat_storage_mode(descr)
    @check ccall((:rocsparse_get_mat_storage_mode, librocsparse), rocsparse_storage_mode, (rocsparse_mat_descr,), descr)
end

function rocsparse_create_hyb_mat(hyb)
    @check ccall((:rocsparse_create_hyb_mat, librocsparse), rocsparse_status, (Ptr{rocsparse_hyb_mat},), hyb)
end

function rocsparse_copy_hyb_mat(dest, src)
    @check ccall((:rocsparse_copy_hyb_mat, librocsparse), rocsparse_status, (rocsparse_hyb_mat, rocsparse_hyb_mat), dest, src)
end

function rocsparse_destroy_hyb_mat(hyb)
    @check ccall((:rocsparse_destroy_hyb_mat, librocsparse), rocsparse_status, (rocsparse_hyb_mat,), hyb)
end

function rocsparse_create_mat_info(info)
    @check ccall((:rocsparse_create_mat_info, librocsparse), rocsparse_status, (Ptr{rocsparse_mat_info},), info)
end

function rocsparse_copy_mat_info(dest, src)
    @check ccall((:rocsparse_copy_mat_info, librocsparse), rocsparse_status, (rocsparse_mat_info, rocsparse_mat_info), dest, src)
end

function rocsparse_destroy_mat_info(info)
    @check ccall((:rocsparse_destroy_mat_info, librocsparse), rocsparse_status, (rocsparse_mat_info,), info)
end

function rocsparse_create_color_info(info)
    @check ccall((:rocsparse_create_color_info, librocsparse), rocsparse_status, (Ptr{rocsparse_color_info},), info)
end

function rocsparse_copy_color_info(dest, src)
    @check ccall((:rocsparse_copy_color_info, librocsparse), rocsparse_status, (rocsparse_color_info, rocsparse_color_info), dest, src)
end

function rocsparse_destroy_color_info(info)
    @check ccall((:rocsparse_destroy_color_info, librocsparse), rocsparse_status, (rocsparse_color_info,), info)
end

function rocsparse_create_spvec_descr(descr, size, nnz, indices, values, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_create_spvec_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spvec_descr}, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, size, nnz, indices, values, idx_type, idx_base, data_type)
end

function rocsparse_destroy_spvec_descr(descr)
    @check ccall((:rocsparse_destroy_spvec_descr, librocsparse), rocsparse_status, (rocsparse_spvec_descr,), descr)
end

function rocsparse_spvec_get(descr, size, nnz, indices, values, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_spvec_get, librocsparse), rocsparse_status, (rocsparse_spvec_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, size, nnz, indices, values, idx_type, idx_base, data_type)
end

function rocsparse_spvec_get_index_base(descr, idx_base)
    @check ccall((:rocsparse_spvec_get_index_base, librocsparse), rocsparse_status, (rocsparse_spvec_descr, Ptr{rocsparse_index_base}), descr, idx_base)
end

function rocsparse_spvec_get_values(descr, values)
    @check ccall((:rocsparse_spvec_get_values, librocsparse), rocsparse_status, (rocsparse_spvec_descr, Ptr{Ptr{Cvoid}}), descr, values)
end

function rocsparse_spvec_set_values(descr, values)
    @check ccall((:rocsparse_spvec_set_values, librocsparse), rocsparse_status, (rocsparse_spvec_descr, Ptr{Cvoid}), descr, values)
end

function rocsparse_create_coo_descr(descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_create_coo_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val, idx_type, idx_base, data_type)
end

function rocsparse_create_coo_aos_descr(descr, rows, cols, nnz, coo_ind, coo_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_create_coo_aos_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, nnz, coo_ind, coo_val, idx_type, idx_base, data_type)
end

function rocsparse_create_csr_descr(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val, row_ptr_type, col_ind_type, idx_base, data_type)
    @check ccall((:rocsparse_create_csr_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val, row_ptr_type, col_ind_type, idx_base, data_type)
end

function rocsparse_create_csc_descr(descr, rows, cols, nnz, csc_col_ptr, csc_row_ind, csc_val, col_ptr_type, row_ind_type, idx_base, data_type)
    @check ccall((:rocsparse_create_csc_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, nnz, csc_col_ptr, csc_row_ind, csc_val, col_ptr_type, row_ind_type, idx_base, data_type)
end

function rocsparse_create_ell_descr(descr, rows, cols, ell_col_ind, ell_val, ell_width, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_create_ell_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, Int64, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, ell_col_ind, ell_val, ell_width, idx_type, idx_base, data_type)
end

function rocsparse_create_bell_descr(descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols, ell_col_ind, ell_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_create_bell_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_spmat_descr}, Int64, Int64, rocsparse_direction, Int64, Int64, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_indextype, rocsparse_index_base, rocsparse_datatype), descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols, ell_col_ind, ell_val, idx_type, idx_base, data_type)
end

function rocsparse_destroy_spmat_descr(descr)
    @check ccall((:rocsparse_destroy_spmat_descr, librocsparse), rocsparse_status, (rocsparse_spmat_descr,), descr)
end

function rocsparse_coo_aos_get(descr, rows, cols, nnz, coo_ind, coo_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_coo_aos_get, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, rows, cols, nnz, coo_ind, coo_val, idx_type, idx_base, data_type)
end

function rocsparse_coo_get(descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_coo_get, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val, idx_type, idx_base, data_type)
end

function rocsparse_csr_get(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val, row_ptr_type, col_ind_type, idx_base, data_type)
    @check ccall((:rocsparse_csr_get, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_indextype}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val, row_ptr_type, col_ind_type, idx_base, data_type)
end

function rocsparse_ell_get(descr, rows, cols, ell_col_ind, ell_val, ell_width, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_ell_get, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{Int64}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, rows, cols, ell_col_ind, ell_val, ell_width, idx_type, idx_base, data_type)
end

function rocsparse_bell_get(descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols, ell_col_ind, ell_val, idx_type, idx_base, data_type)
    @check ccall((:rocsparse_bell_get, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{rocsparse_direction}, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_indextype}, Ptr{rocsparse_index_base}, Ptr{rocsparse_datatype}), descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols, ell_col_ind, ell_val, idx_type, idx_base, data_type)
end

function rocsparse_coo_set_pointers(descr, coo_row_ind, coo_col_ind, coo_val)
    @check ccall((:rocsparse_coo_set_pointers, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), descr, coo_row_ind, coo_col_ind, coo_val)
end

function rocsparse_coo_aos_set_pointers(descr, coo_ind, coo_val)
    @check ccall((:rocsparse_coo_aos_set_pointers, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}, Ptr{Cvoid}), descr, coo_ind, coo_val)
end

function rocsparse_csr_set_pointers(descr, csr_row_ptr, csr_col_ind, csr_val)
    @check ccall((:rocsparse_csr_set_pointers, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), descr, csr_row_ptr, csr_col_ind, csr_val)
end

function rocsparse_csc_set_pointers(descr, csc_col_ptr, csc_row_ind, csc_val)
    @check ccall((:rocsparse_csc_set_pointers, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), descr, csc_col_ptr, csc_row_ind, csc_val)
end

function rocsparse_ell_set_pointers(descr, ell_col_ind, ell_val)
    @check ccall((:rocsparse_ell_set_pointers, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}, Ptr{Cvoid}), descr, ell_col_ind, ell_val)
end

function rocsparse_spmat_get_size(descr, rows, cols, nnz)
    @check ccall((:rocsparse_spmat_get_size, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Int64}), descr, rows, cols, nnz)
end

function rocsparse_spmat_get_format(descr, format)
    @check ccall((:rocsparse_spmat_get_format, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{rocsparse_format}), descr, format)
end

function rocsparse_spmat_get_index_base(descr, idx_base)
    @check ccall((:rocsparse_spmat_get_index_base, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{rocsparse_index_base}), descr, idx_base)
end

function rocsparse_spmat_get_values(descr, values)
    @check ccall((:rocsparse_spmat_get_values, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Ptr{Cvoid}}), descr, values)
end

function rocsparse_spmat_set_values(descr, values)
    @check ccall((:rocsparse_spmat_set_values, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cvoid}), descr, values)
end

function rocsparse_spmat_get_strided_batch(descr, batch_count)
    @check ccall((:rocsparse_spmat_get_strided_batch, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Ptr{Cint}), descr, batch_count)
end

function rocsparse_spmat_set_strided_batch(descr, batch_count)
    @check ccall((:rocsparse_spmat_set_strided_batch, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Cint), descr, batch_count)
end

function rocsparse_coo_set_strided_batch(descr, batch_count, batch_stride)
    @check ccall((:rocsparse_coo_set_strided_batch, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Cint, Int64), descr, batch_count, batch_stride)
end

function rocsparse_csr_set_strided_batch(descr, batch_count, offsets_batch_stride, columns_values_batch_stride)
    @check ccall((:rocsparse_csr_set_strided_batch, librocsparse), rocsparse_status, (rocsparse_spmat_descr, Cint, Int64, Int64), descr, batch_count, offsets_batch_stride, columns_values_batch_stride)
end

function rocsparse_spmat_get_attribute(descr, attribute, data, data_size)
    @check ccall((:rocsparse_spmat_get_attribute, librocsparse), rocsparse_status, (rocsparse_spmat_descr, rocsparse_spmat_attribute, Ptr{Cvoid}, Csize_t), descr, attribute, data, data_size)
end

function rocsparse_spmat_set_attribute(descr, attribute, data, data_size)
    @check ccall((:rocsparse_spmat_set_attribute, librocsparse), rocsparse_status, (rocsparse_spmat_descr, rocsparse_spmat_attribute, Ptr{Cvoid}, Csize_t), descr, attribute, data, data_size)
end

function rocsparse_create_dnvec_descr(descr, size, values, data_type)
    @check ccall((:rocsparse_create_dnvec_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_dnvec_descr}, Int64, Ptr{Cvoid}, rocsparse_datatype), descr, size, values, data_type)
end

function rocsparse_destroy_dnvec_descr(descr)
    @check ccall((:rocsparse_destroy_dnvec_descr, librocsparse), rocsparse_status, (rocsparse_dnvec_descr,), descr)
end

function rocsparse_dnvec_get(descr, size, values, data_type)
    @check ccall((:rocsparse_dnvec_get, librocsparse), rocsparse_status, (rocsparse_dnvec_descr, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_datatype}), descr, size, values, data_type)
end

function rocsparse_dnvec_get_values(descr, values)
    @check ccall((:rocsparse_dnvec_get_values, librocsparse), rocsparse_status, (rocsparse_dnvec_descr, Ptr{Ptr{Cvoid}}), descr, values)
end

function rocsparse_dnvec_set_values(descr, values)
    @check ccall((:rocsparse_dnvec_set_values, librocsparse), rocsparse_status, (rocsparse_dnvec_descr, Ptr{Cvoid}), descr, values)
end

function rocsparse_create_dnmat_descr(descr, rows, cols, ld, values, data_type, order)
    @check ccall((:rocsparse_create_dnmat_descr, librocsparse), rocsparse_status, (Ptr{rocsparse_dnmat_descr}, Int64, Int64, Int64, Ptr{Cvoid}, rocsparse_datatype, rocsparse_order), descr, rows, cols, ld, values, data_type, order)
end

function rocsparse_destroy_dnmat_descr(descr)
    @check ccall((:rocsparse_destroy_dnmat_descr, librocsparse), rocsparse_status, (rocsparse_dnmat_descr,), descr)
end

function rocsparse_dnmat_get(descr, rows, cols, ld, values, data_type, order)
    @check ccall((:rocsparse_dnmat_get, librocsparse), rocsparse_status, (rocsparse_dnmat_descr, Ptr{Int64}, Ptr{Int64}, Ptr{Int64}, Ptr{Ptr{Cvoid}}, Ptr{rocsparse_datatype}, Ptr{rocsparse_order}), descr, rows, cols, ld, values, data_type, order)
end

function rocsparse_dnmat_get_values(descr, values)
    @check ccall((:rocsparse_dnmat_get_values, librocsparse), rocsparse_status, (rocsparse_dnmat_descr, Ptr{Ptr{Cvoid}}), descr, values)
end

function rocsparse_dnmat_set_values(descr, values)
    @check ccall((:rocsparse_dnmat_set_values, librocsparse), rocsparse_status, (rocsparse_dnmat_descr, Ptr{Cvoid}), descr, values)
end

function rocsparse_dnmat_get_strided_batch(descr, batch_count, batch_stride)
    @check ccall((:rocsparse_dnmat_get_strided_batch, librocsparse), rocsparse_status, (rocsparse_dnmat_descr, Ptr{Cint}, Ptr{Int64}), descr, batch_count, batch_stride)
end

function rocsparse_dnmat_set_strided_batch(descr, batch_count, batch_stride)
    @check ccall((:rocsparse_dnmat_set_strided_batch, librocsparse), rocsparse_status, (rocsparse_dnmat_descr, Cint, Int64), descr, batch_count, batch_stride)
end

function rocsparse_saxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_saxpyi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_index_base), handle, nnz, alpha, x_val, x_ind, y, idx_base)
end

function rocsparse_daxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_daxpyi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_index_base), handle, nnz, alpha, x_val, x_ind, y, idx_base)
end

function rocsparse_caxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_caxpyi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_index_base), handle, nnz, alpha, x_val, x_ind, y, idx_base)
end

function rocsparse_zaxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_zaxpyi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_index_base), handle, nnz, alpha, x_val, x_ind, y, idx_base)
end

function rocsparse_sdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_sdoti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_ddoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_ddoti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_cdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_cdoti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_zdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_zdoti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_cdotci(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_cdotci, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_zdotci(handle, nnz, x_val, x_ind, y, result, idx_base)
    @check ccall((:rocsparse_zdotci, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, result, idx_base)
end

function rocsparse_sgthr(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_sgthr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_dgthr(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_dgthr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_cgthr(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_cgthr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_zgthr(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_zgthr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_sgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_sgthrz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_dgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_dgthrz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_cgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_cgthrz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_zgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    @check ccall((:rocsparse_zgthrz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, y, x_val, x_ind, idx_base)
end

function rocsparse_sroti(handle, nnz, x_val, x_ind, y, c, s, idx_base)
    @check ccall((:rocsparse_sroti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, c, s, idx_base)
end

function rocsparse_droti(handle, nnz, x_val, x_ind, y, c, s, idx_base)
    @check ccall((:rocsparse_droti, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, c, s, idx_base)
end

function rocsparse_ssctr(handle, nnz, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_ssctr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, idx_base)
end

function rocsparse_dsctr(handle, nnz, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_dsctr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, idx_base)
end

function rocsparse_csctr(handle, nnz, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_csctr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, idx_base)
end

function rocsparse_zsctr(handle, nnz, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_zsctr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, idx_base)
end

function rocsparse_isctr(handle, nnz, x_val, x_ind, y, idx_base)
    @check ccall((:rocsparse_isctr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_index_base), handle, nnz, x_val, x_ind, y, idx_base)
end

function rocsparse_sbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_sbsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_dbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_dbsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_cbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_cbsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_zbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_zbsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_sbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_sbsrxmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_dbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_dbsrxmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_cbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_cbsrxmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_zbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
    @check ccall((:rocsparse_zbsrxmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr, bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind, block_dim, x, beta, y)
end

function rocsparse_bsrsv_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_bsrsv_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_sbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_sbsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_dbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_dbsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_cbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_cbsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_zbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_zbsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_sbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_sbsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_dbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dbsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_cbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_cbsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_zbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zbsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_bsrsv_clear(handle, info)
    @check ccall((:rocsparse_bsrsv_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_sbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_sbsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
end

function rocsparse_dbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_dbsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
end

function rocsparse_cbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_cbsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
end

function rocsparse_zbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_zbsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans, mb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy, temp_buffer)
end

function rocsparse_scoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
    @check ccall((:rocsparse_scoomv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
end

function rocsparse_dcoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
    @check ccall((:rocsparse_dcoomv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
end

function rocsparse_ccoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
    @check ccall((:rocsparse_ccoomv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
end

function rocsparse_zcoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
    @check ccall((:rocsparse_zcoomv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind, coo_col_ind, x, beta, y)
end

function rocsparse_scsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
    @check ccall((:rocsparse_scsrmv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
end

function rocsparse_dcsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
    @check ccall((:rocsparse_dcsrmv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
end

function rocsparse_ccsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
    @check ccall((:rocsparse_ccsrmv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
end

function rocsparse_zcsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
    @check ccall((:rocsparse_zcsrmv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info)
end

function rocsparse_csrmv_clear(handle, info)
    @check ccall((:rocsparse_csrmv_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_scsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
    @check ccall((:rocsparse_scsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
end

function rocsparse_dcsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
    @check ccall((:rocsparse_dcsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
end

function rocsparse_ccsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
    @check ccall((:rocsparse_ccsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
end

function rocsparse_zcsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
    @check ccall((:rocsparse_zcsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, beta, y)
end

function rocsparse_csrsv_zero_pivot(handle, descr, info, position)
    @check ccall((:rocsparse_csrsv_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_mat_info, Ptr{rocsparse_int}), handle, descr, info, position)
end

function rocsparse_scsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_scsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_dcsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_dcsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_ccsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_ccsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_zcsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_zcsrsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_scsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_scsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_dcsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dcsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_ccsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_ccsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_zcsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zcsrsv_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_csrsv_clear(handle, descr, info)
    @check ccall((:rocsparse_csrsv_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_mat_info), handle, descr, info)
end

function rocsparse_scsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_scsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
end

function rocsparse_dcsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_dcsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
end

function rocsparse_ccsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_ccsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
end

function rocsparse_zcsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
    @check ccall((:rocsparse_zcsrsv_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, info, x, y, policy, temp_buffer)
end

function rocsparse_sellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
    @check ccall((:rocsparse_sellmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
end

function rocsparse_dellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
    @check ccall((:rocsparse_dellmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
end

function rocsparse_cellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
    @check ccall((:rocsparse_cellmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
end

function rocsparse_zellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
    @check ccall((:rocsparse_zellmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, trans, m, n, alpha, descr, ell_val, ell_col_ind, ell_width, x, beta, y)
end

function rocsparse_shybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    @check ccall((:rocsparse_shybmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, trans, alpha, descr, hyb, x, beta, y)
end

function rocsparse_dhybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    @check ccall((:rocsparse_dhybmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, trans, alpha, descr, hyb, x, beta, y)
end

function rocsparse_chybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    @check ccall((:rocsparse_chybmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, trans, alpha, descr, hyb, x, beta, y)
end

function rocsparse_zhybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    @check ccall((:rocsparse_zhybmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, trans, alpha, descr, hyb, x, beta, y)
end

function rocsparse_sgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
    @check ccall((:rocsparse_sgebsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
end

function rocsparse_dgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
    @check ccall((:rocsparse_dgebsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
end

function rocsparse_cgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
    @check ccall((:rocsparse_cgebsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
end

function rocsparse_zgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
    @check ccall((:rocsparse_zgebsrmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}), handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta, y)
end

function rocsparse_sgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    @check ccall((:rocsparse_sgemvi_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, trans, m, n, nnz, buffer_size)
end

function rocsparse_dgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    @check ccall((:rocsparse_dgemvi_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, trans, m, n, nnz, buffer_size)
end

function rocsparse_cgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    @check ccall((:rocsparse_cgemvi_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, trans, m, n, nnz, buffer_size)
end

function rocsparse_zgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    @check ccall((:rocsparse_zgemvi_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, trans, m, n, nnz, buffer_size)
end

function rocsparse_sgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
    @check ccall((:rocsparse_sgemvi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_index_base, Ptr{Cvoid}), handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
end

function rocsparse_dgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
    @check ccall((:rocsparse_dgemvi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_index_base, Ptr{Cvoid}), handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
end

function rocsparse_cgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
    @check ccall((:rocsparse_cgemvi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_index_base, Ptr{Cvoid}), handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
end

function rocsparse_zgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
    @check ccall((:rocsparse_zgemvi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_index_base, Ptr{Cvoid}), handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y, idx_base, temp_buffer)
end

function rocsparse_sbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_sbsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_dbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_dbsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_cbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_cbsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_zbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_zbsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_sgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_sgebsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_dgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_dgebsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_cgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_cgebsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_zgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_zgebsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, B, ldb, beta, C, ldc)
end

function rocsparse_scsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_scsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
end

function rocsparse_dcsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_dcsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
end

function rocsparse_ccsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_ccsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
end

function rocsparse_zcsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    @check ccall((:rocsparse_zcsrmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
end

function rocsparse_csrsm_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_csrsm_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_scsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
    @check ccall((:rocsparse_scsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Csize_t}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
end

function rocsparse_dcsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
    @check ccall((:rocsparse_dcsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Csize_t}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
end

function rocsparse_ccsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
    @check ccall((:rocsparse_ccsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Csize_t}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
end

function rocsparse_zcsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
    @check ccall((:rocsparse_zcsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Csize_t}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, buffer_size)
end

function rocsparse_scsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_scsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
end

function rocsparse_dcsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dcsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
end

function rocsparse_ccsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_ccsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
end

function rocsparse_zcsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zcsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, analysis, solve, temp_buffer)
end

function rocsparse_csrsm_clear(handle, info)
    @check ccall((:rocsparse_csrsm_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_scsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
    @check ccall((:rocsparse_scsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
end

function rocsparse_dcsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
    @check ccall((:rocsparse_dcsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
end

function rocsparse_ccsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
    @check ccall((:rocsparse_ccsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
end

function rocsparse_zcsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
    @check ccall((:rocsparse_zcsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy, temp_buffer)
end

function rocsparse_bsrsm_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_bsrsm_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_sbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_sbsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_dbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_dbsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_cbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_cbsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_zbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_zbsrsm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_sbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_sbsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_dbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dbsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_cbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_cbsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_zbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zbsrsm_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_bsrsm_clear(handle, info)
    @check ccall((:rocsparse_bsrsm_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_sbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
    @check ccall((:rocsparse_sbsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, rocsparse_int, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
end

function rocsparse_dbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
    @check ccall((:rocsparse_dbsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, rocsparse_int, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
end

function rocsparse_cbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
    @check ccall((:rocsparse_cbsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
end

function rocsparse_zbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
    @check ccall((:rocsparse_zbsrsm_solve, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb, X, ldx, policy, temp_buffer)
end

function rocsparse_sgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    @check ccall((:rocsparse_sgemmi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
end

function rocsparse_dgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    @check ccall((:rocsparse_dgemmi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
end

function rocsparse_cgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    @check ccall((:rocsparse_cgemmi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
end

function rocsparse_zgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    @check ccall((:rocsparse_zgemmi, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr, csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
end

function rocsparse_csrgeam_nnz(handle, m, n, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_row_ptr_C, nnz_C)
    @check ccall((:rocsparse_csrgeam_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_row_ptr_C, nnz_C)
end

function rocsparse_scsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    @check ccall((:rocsparse_scsrgeam, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
end

function rocsparse_dcsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    @check ccall((:rocsparse_dcsrgeam, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
end

function rocsparse_ccsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    @check ccall((:rocsparse_ccsrgeam, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
end

function rocsparse_zcsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    @check ccall((:rocsparse_zcsrgeam, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
end

function rocsparse_scsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    @check ccall((:rocsparse_scsrgemm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
end

function rocsparse_dcsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    @check ccall((:rocsparse_dcsrgemm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
end

function rocsparse_ccsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    @check ccall((:rocsparse_ccsrgemm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
end

function rocsparse_zcsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    @check ccall((:rocsparse_zcsrgemm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
end

function rocsparse_csrgemm_nnz(handle, trans_A, trans_B, m, n, k, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_row_ptr_C, nnz_C, info_C, temp_buffer)
    @check ccall((:rocsparse_csrgemm_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_row_ptr_C, nnz_C, info_C, temp_buffer)
end

function rocsparse_scsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_scsrgemm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_dcsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_dcsrgemm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_ccsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_ccsrgemm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_zcsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_zcsrgemm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_csrgemm_symbolic(handle, trans_A, trans_B, m, n, k, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_csrgemm_symbolic, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_scsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_scsrgemm_numeric, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_dcsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_dcsrgemm_numeric, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_ccsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_ccsrgemm_numeric, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_zcsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    @check ccall((:rocsparse_zcsrgemm_numeric, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
end

function rocsparse_bsric0_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_bsric0_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_sbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_sbsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_dbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_dbsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_cbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_cbsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_zbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_zbsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_sbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_sbsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_dbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dbsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_cbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_cbsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_zbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zbsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_bsric0_clear(handle, info)
    @check ccall((:rocsparse_bsric0_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_sbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_sbsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_dbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_dbsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_cbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_cbsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_zbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_zbsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_bsrilu0_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_bsrilu0_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_sbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_sbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cfloat}, Ptr{Cfloat}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{Cdouble}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_cbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_cbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cfloat}, Ptr{rocsparse_float_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_zbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_zbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{rocsparse_double_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dsbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dsbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{Cfloat}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dcbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dcbsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{rocsparse_float_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_sbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_sbsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_dbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_dbsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_cbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_cbsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_zbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
    @check ccall((:rocsparse_zbsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, Ptr{Csize_t}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, buffer_size)
end

function rocsparse_sbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_sbsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_dbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dbsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_cbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_cbsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_zbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zbsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, analysis, solve, temp_buffer)
end

function rocsparse_bsrilu0_clear(handle, info)
    @check ccall((:rocsparse_bsrilu0_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_sbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_sbsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_dbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_dbsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_cbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_cbsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_zbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
    @check ccall((:rocsparse_zbsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, policy, temp_buffer)
end

function rocsparse_csric0_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_csric0_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_scsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_scsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_dcsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_dcsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_ccsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_ccsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_zcsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_zcsric0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_scsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_scsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_dcsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dcsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_ccsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_ccsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_zcsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zcsric0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_csric0_clear(handle, info)
    @check ccall((:rocsparse_csric0_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_scsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_scsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_dcsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_dcsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_ccsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_ccsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_zcsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_zcsric0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_csrilu0_zero_pivot(handle, info, position)
    @check ccall((:rocsparse_csrilu0_zero_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Ptr{rocsparse_int}), handle, info, position)
end

function rocsparse_scsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_scsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cfloat}, Ptr{Cfloat}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dcsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dcsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{Cdouble}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_ccsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_ccsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cfloat}, Ptr{rocsparse_float_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_zcsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_zcsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{rocsparse_double_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dscsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dscsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{Cfloat}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_dccsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    @check ccall((:rocsparse_dccsrilu0_numeric_boost, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info, Cint, Ptr{Cdouble}, Ptr{rocsparse_float_complex}), handle, info, enable_boost, boost_tol, boost_val)
end

function rocsparse_scsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_scsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_dcsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_dcsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_ccsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_ccsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_zcsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_zcsrilu0_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_scsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_scsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_dcsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_dcsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_ccsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_ccsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_zcsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
    @check ccall((:rocsparse_zcsrilu0_analysis, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_analysis_policy, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, analysis, solve, temp_buffer)
end

function rocsparse_csrilu0_clear(handle, info)
    @check ccall((:rocsparse_csrilu0_clear, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_info), handle, info)
end

function rocsparse_scsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_scsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_dcsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_dcsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_ccsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_ccsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_zcsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
    @check ccall((:rocsparse_zcsrilu0, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, rocsparse_solve_policy, Ptr{Cvoid}), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info, policy, temp_buffer)
end

function rocsparse_sgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_sgtsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_dgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_dgtsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_cgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_cgtsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_zgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_zgtsv_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_sgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_sgtsv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_dgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_dgtsv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_cgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_cgtsv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_zgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_zgtsv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_sgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_sgtsv_no_pivot_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_dgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_dgtsv_no_pivot_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_cgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_cgtsv_no_pivot_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_zgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    @check ccall((:rocsparse_zgtsv_no_pivot_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{Csize_t}), handle, m, n, dl, d, du, B, ldb, buffer_size)
end

function rocsparse_sgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_sgtsv_no_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_dgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_dgtsv_no_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_cgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_cgtsv_no_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_zgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    @check ccall((:rocsparse_zgtsv_no_pivot, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{Cvoid}), handle, m, n, dl, d, du, B, ldb, temp_buffer)
end

function rocsparse_sgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_sgtsv_no_pivot_strided_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_dgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_dgtsv_no_pivot_strided_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_cgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_cgtsv_no_pivot_strided_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_zgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_zgtsv_no_pivot_strided_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_sgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_sgtsv_no_pivot_strided_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_dgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_dgtsv_no_pivot_strided_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_cgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_cgtsv_no_pivot_strided_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_zgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_zgtsv_no_pivot_strided_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_sgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_sgtsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_dgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_dgtsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_cgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_cgtsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_zgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_zgtsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_sgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_sgtsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_dgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_dgtsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_cgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_cgtsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_zgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_zgtsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gtsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, dl, d, du, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_sgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_sgpsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_dgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_dgpsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_cgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_cgpsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_zgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
    @check ccall((:rocsparse_zgpsv_interleaved_batch_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, buffer_size)
end

function rocsparse_sgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_sgpsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_dgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_dgpsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_cgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_cgpsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_float_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_zgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
    @check ccall((:rocsparse_zgpsv_interleaved_batch, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_gpsv_interleaved_alg, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_double_complex}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, alg, m, ds, dl, d, du, dw, x, batch_count, batch_stride, temp_buffer)
end

function rocsparse_snnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
    @check ccall((:rocsparse_snnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
end

function rocsparse_dnnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
    @check ccall((:rocsparse_dnnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
end

function rocsparse_cnnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
    @check ccall((:rocsparse_cnnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
end

function rocsparse_znnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
    @check ccall((:rocsparse_znnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, descr, A, ld, nnz_per_row_columns, nnz_total_dev_host_ptr)
end

function rocsparse_sdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_sdense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_ddense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_ddense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_cdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_cdense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_zdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_zdense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_sprune_dense2csr_buffer_size(handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, buffer_size)
    @check ccall((:rocsparse_sprune_dense2csr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, buffer_size)
end

function rocsparse_dprune_dense2csr_buffer_size(handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, buffer_size)
    @check ccall((:rocsparse_dprune_dense2csr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, buffer_size)
end

function rocsparse_sprune_dense2csr_nnz(handle, m, n, A, lda, threshold, descr, csr_row_ptr, nnz_total_dev_host_ptr, temp_buffer)
    @check ccall((:rocsparse_sprune_dense2csr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, A, lda, threshold, descr, csr_row_ptr, nnz_total_dev_host_ptr, temp_buffer)
end

function rocsparse_dprune_dense2csr_nnz(handle, m, n, A, lda, threshold, descr, csr_row_ptr, nnz_total_dev_host_ptr, temp_buffer)
    @check ccall((:rocsparse_dprune_dense2csr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, A, lda, threshold, descr, csr_row_ptr, nnz_total_dev_host_ptr, temp_buffer)
end

function rocsparse_sprune_dense2csr(handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_sprune_dense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_dprune_dense2csr(handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_dprune_dense2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, A, lda, threshold, descr, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_sprune_dense2csr_by_percentage_buffer_size(handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_sprune_dense2csr_by_percentage_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Cfloat, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_dprune_dense2csr_by_percentage_buffer_size(handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
    @check ccall((:rocsparse_dprune_dense2csr_by_percentage_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Cdouble, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, buffer_size)
end

function rocsparse_sprune_dense2csr_nnz_by_percentage(handle, m, n, A, lda, percentage, descr, csr_row_ptr, nnz_total_dev_host_ptr, info, temp_buffer)
    @check ccall((:rocsparse_sprune_dense2csr_nnz_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Cfloat, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, A, lda, percentage, descr, csr_row_ptr, nnz_total_dev_host_ptr, info, temp_buffer)
end

function rocsparse_dprune_dense2csr_nnz_by_percentage(handle, m, n, A, lda, percentage, descr, csr_row_ptr, nnz_total_dev_host_ptr, info, temp_buffer)
    @check ccall((:rocsparse_dprune_dense2csr_nnz_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Cdouble, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, A, lda, percentage, descr, csr_row_ptr, nnz_total_dev_host_ptr, info, temp_buffer)
end

function rocsparse_sprune_dense2csr_by_percentage(handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, temp_buffer)
    @check ccall((:rocsparse_sprune_dense2csr_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cfloat}, rocsparse_int, Cfloat, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, temp_buffer)
end

function rocsparse_dprune_dense2csr_by_percentage(handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, temp_buffer)
    @check ccall((:rocsparse_dprune_dense2csr_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, Ptr{Cdouble}, rocsparse_int, Cdouble, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, A, lda, percentage, descr, csr_val, csr_row_ptr, csr_col_ind, info, temp_buffer)
end

function rocsparse_sdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
    @check ccall((:rocsparse_sdense2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
end

function rocsparse_ddense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
    @check ccall((:rocsparse_ddense2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
end

function rocsparse_cdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
    @check ccall((:rocsparse_cdense2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
end

function rocsparse_zdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
    @check ccall((:rocsparse_zdense2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_columns, csc_val, csc_col_ptr, csc_row_ind)
end

function rocsparse_sdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
    @check ccall((:rocsparse_sdense2coo, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
end

function rocsparse_ddense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
    @check ccall((:rocsparse_ddense2coo, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
end

function rocsparse_cdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
    @check ccall((:rocsparse_cdense2coo, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
end

function rocsparse_zdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
    @check ccall((:rocsparse_zdense2coo, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, descr, A, ld, nnz_per_rows, coo_val, coo_row_ind, coo_col_ind)
end

function rocsparse_scsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    @check ccall((:rocsparse_scsr2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
end

function rocsparse_dcsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    @check ccall((:rocsparse_dcsr2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
end

function rocsparse_ccsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    @check ccall((:rocsparse_ccsr2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
end

function rocsparse_zcsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    @check ccall((:rocsparse_zcsr2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
end

function rocsparse_scsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    @check ccall((:rocsparse_scsc2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int), handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
end

function rocsparse_dcsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    @check ccall((:rocsparse_dcsc2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int), handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
end

function rocsparse_ccsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    @check ccall((:rocsparse_ccsc2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
end

function rocsparse_zcsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    @check ccall((:rocsparse_zcsc2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
end

function rocsparse_scoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
    @check ccall((:rocsparse_scoo2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_int), handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
end

function rocsparse_dcoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
    @check ccall((:rocsparse_dcoo2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_int), handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
end

function rocsparse_ccoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
    @check ccall((:rocsparse_ccoo2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, rocsparse_int), handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
end

function rocsparse_zcoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
    @check ccall((:rocsparse_zcoo2dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, rocsparse_int), handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind, A, ld)
end

function rocsparse_snnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
    @check ccall((:rocsparse_snnz_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cfloat), handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
end

function rocsparse_dnnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
    @check ccall((:rocsparse_dnnz_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cdouble), handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
end

function rocsparse_cnnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
    @check ccall((:rocsparse_cnnz_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_float_complex), handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
end

function rocsparse_znnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
    @check ccall((:rocsparse_znnz_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_double_complex), handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row, nnz_C, tol)
end

function rocsparse_csr2coo(handle, csr_row_ptr, nnz, m, coo_row_ind, idx_base)
    @check ccall((:rocsparse_csr2coo, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, rocsparse_index_base), handle, csr_row_ptr, nnz, m, coo_row_ind, idx_base)
end

function rocsparse_csr2csc_buffer_size(handle, m, n, nnz, csr_row_ptr, csr_col_ind, copy_values, buffer_size)
    @check ccall((:rocsparse_csr2csc_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, Ptr{Csize_t}), handle, m, n, nnz, csr_row_ptr, csr_col_ind, copy_values, buffer_size)
end

function rocsparse_scsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_scsr2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_dcsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_dcsr2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_ccsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_ccsr2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_zcsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_zcsr2csc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val, csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_sgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_sgebsr2gebsc_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_dgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_dgebsr2gebsc_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_cgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_cgebsr2gebsc_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_zgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_zgebsr2gebsc_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_sgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_sgebsr2gebsc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_dgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_dgebsr2gebsc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_cgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_cgebsr2gebsc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_zgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
    @check ccall((:rocsparse_zgebsr2gebsc, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_action, rocsparse_index_base, Ptr{Cvoid}), handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, bsc_val, bsc_row_ind, bsc_col_ptr, copy_values, idx_base, temp_buffer)
end

function rocsparse_csr2ell_width(handle, m, csr_descr, csr_row_ptr, ell_descr, ell_width)
    @check ccall((:rocsparse_csr2ell_width, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_int}), handle, m, csr_descr, csr_row_ptr, ell_descr, ell_width)
end

function rocsparse_scsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
    @check ccall((:rocsparse_scsr2ell, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}), handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
end

function rocsparse_dcsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
    @check ccall((:rocsparse_dcsr2ell, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}), handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
end

function rocsparse_ccsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
    @check ccall((:rocsparse_ccsr2ell, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}), handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
end

function rocsparse_zcsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
    @check ccall((:rocsparse_zcsr2ell, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}), handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind, ell_descr, ell_width, ell_val, ell_col_ind)
end

function rocsparse_scsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
    @check ccall((:rocsparse_scsr2hyb, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_hyb_mat, rocsparse_int, rocsparse_hyb_partition), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
end

function rocsparse_dcsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
    @check ccall((:rocsparse_dcsr2hyb, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_hyb_mat, rocsparse_int, rocsparse_hyb_partition), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
end

function rocsparse_ccsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
    @check ccall((:rocsparse_ccsr2hyb, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_hyb_mat, rocsparse_int, rocsparse_hyb_partition), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
end

function rocsparse_zcsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
    @check ccall((:rocsparse_zcsr2hyb, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_hyb_mat, rocsparse_int, rocsparse_hyb_partition), handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb, user_ell_width, partition_type)
end

function rocsparse_csr2bsr_nnz(handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_row_ptr, bsr_nnz)
    @check ccall((:rocsparse_csr2bsr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_row_ptr, bsr_nnz)
end

function rocsparse_scsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    @check ccall((:rocsparse_scsr2bsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
end

function rocsparse_dcsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    @check ccall((:rocsparse_dcsr2bsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
end

function rocsparse_ccsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    @check ccall((:rocsparse_ccsr2bsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
end

function rocsparse_zcsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    @check ccall((:rocsparse_zcsr2bsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
end

function rocsparse_scsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_scsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_dcsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_dcsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_ccsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_ccsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_zcsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
    @check ccall((:rocsparse_zcsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, row_block_dim, col_block_dim, p_buffer_size)
end

function rocsparse_csr2gebsr_nnz(handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind, bsr_descr, bsr_row_ptr, row_block_dim, col_block_dim, bsr_nnz_devhost, p_buffer)
    @check ccall((:rocsparse_csr2gebsr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind, bsr_descr, bsr_row_ptr, row_block_dim, col_block_dim, bsr_nnz_devhost, p_buffer)
end

function rocsparse_scsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
    @check ccall((:rocsparse_scsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
end

function rocsparse_dcsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
    @check ccall((:rocsparse_dcsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
end

function rocsparse_ccsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
    @check ccall((:rocsparse_ccsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
end

function rocsparse_zcsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
    @check ccall((:rocsparse_zcsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, p_buffer)
end

function rocsparse_scsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
    @check ccall((:rocsparse_scsr2csr_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cfloat), handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
end

function rocsparse_dcsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
    @check ccall((:rocsparse_dcsr2csr_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cdouble), handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
end

function rocsparse_ccsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
    @check ccall((:rocsparse_ccsr2csr_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_float_complex), handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
end

function rocsparse_zcsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
    @check ccall((:rocsparse_zcsr2csr_compress, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_double_complex), handle, m, n, descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C, csr_row_ptr_C, csr_col_ind_C, tol)
end

function rocsparse_sprune_csr2csr_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, buffer_size)
    @check ccall((:rocsparse_sprune_csr2csr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, buffer_size)
end

function rocsparse_dprune_csr2csr_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, buffer_size)
    @check ccall((:rocsparse_dprune_csr2csr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, buffer_size)
end

function rocsparse_sprune_csr2csr_nnz(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
    @check ccall((:rocsparse_sprune_csr2csr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
end

function rocsparse_dprune_csr2csr_nnz(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
    @check ccall((:rocsparse_dprune_csr2csr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
end

function rocsparse_sprune_csr2csr(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
    @check ccall((:rocsparse_sprune_csr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
end

function rocsparse_dprune_csr2csr(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
    @check ccall((:rocsparse_dprune_csr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
end

function rocsparse_sprune_csr2csr_by_percentage_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, buffer_size)
    @check ccall((:rocsparse_sprune_csr2csr_by_percentage_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cfloat, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, buffer_size)
end

function rocsparse_dprune_csr2csr_by_percentage_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, buffer_size)
    @check ccall((:rocsparse_dprune_csr2csr_by_percentage_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cdouble, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Csize_t}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, buffer_size)
end

function rocsparse_sprune_csr2csr_nnz_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, info, temp_buffer)
    @check ccall((:rocsparse_sprune_csr2csr_nnz_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cfloat, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, info, temp_buffer)
end

function rocsparse_dprune_csr2csr_nnz_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, info, temp_buffer)
    @check ccall((:rocsparse_dprune_csr2csr_nnz_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cdouble, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_row_ptr_C, nnz_total_dev_host_ptr, info, temp_buffer)
end

function rocsparse_sprune_csr2csr_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, temp_buffer)
    @check ccall((:rocsparse_sprune_csr2csr_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cfloat, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, temp_buffer)
end

function rocsparse_dprune_csr2csr_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, temp_buffer)
    @check ccall((:rocsparse_dprune_csr2csr_by_percentage, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Cdouble, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info, Ptr{Cvoid}), handle, m, n, nnz_A, csr_descr_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, percentage, csr_descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C, info, temp_buffer)
end

function rocsparse_coo2csr(handle, coo_row_ind, nnz, m, csr_row_ptr, idx_base)
    @check ccall((:rocsparse_coo2csr, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, rocsparse_index_base), handle, coo_row_ind, nnz, m, csr_row_ptr, idx_base)
end

function rocsparse_ell2csr_nnz(handle, m, n, ell_descr, ell_width, ell_col_ind, csr_descr, csr_row_ptr, csr_nnz)
    @check ccall((:rocsparse_ell2csr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, ell_descr, ell_width, ell_col_ind, csr_descr, csr_row_ptr, csr_nnz)
end

function rocsparse_sell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_sell2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{Cfloat}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_dell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_dell2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{Cdouble}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_cell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_cell2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_zell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_zell2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, rocsparse_int, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_hyb2csr_buffer_size(handle, descr, hyb, csr_row_ptr, buffer_size)
    @check ccall((:rocsparse_hyb2csr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, descr, hyb, csr_row_ptr, buffer_size)
end

function rocsparse_shyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_shyb2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_dhyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_dhyb2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_chyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_chyb2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_zhyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
    @check ccall((:rocsparse_zhyb2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_mat_descr, rocsparse_hyb_mat, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind, temp_buffer)
end

function rocsparse_create_identity_permutation(handle, n, p)
    @check ccall((:rocsparse_create_identity_permutation, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, Ptr{rocsparse_int}), handle, n, p)
end

function rocsparse_csrsort_buffer_size(handle, m, n, nnz, csr_row_ptr, csr_col_ind, buffer_size)
    @check ccall((:rocsparse_csrsort_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, nnz, csr_row_ptr, csr_col_ind, buffer_size)
end

function rocsparse_csrsort(handle, m, n, nnz, descr, csr_row_ptr, csr_col_ind, perm, temp_buffer)
    @check ccall((:rocsparse_csrsort, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz, descr, csr_row_ptr, csr_col_ind, perm, temp_buffer)
end

function rocsparse_cscsort_buffer_size(handle, m, n, nnz, csc_col_ptr, csc_row_ind, buffer_size)
    @check ccall((:rocsparse_cscsort_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, nnz, csc_col_ptr, csc_row_ind, buffer_size)
end

function rocsparse_cscsort(handle, m, n, nnz, descr, csc_col_ptr, csc_row_ind, perm, temp_buffer)
    @check ccall((:rocsparse_cscsort, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz, descr, csc_col_ptr, csc_row_ind, perm, temp_buffer)
end

function rocsparse_coosort_buffer_size(handle, m, n, nnz, coo_row_ind, coo_col_ind, buffer_size)
    @check ccall((:rocsparse_coosort_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Csize_t}), handle, m, n, nnz, coo_row_ind, coo_col_ind, buffer_size)
end

function rocsparse_coosort_by_row(handle, m, n, nnz, coo_row_ind, coo_col_ind, perm, temp_buffer)
    @check ccall((:rocsparse_coosort_by_row, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz, coo_row_ind, coo_col_ind, perm, temp_buffer)
end

function rocsparse_coosort_by_column(handle, m, n, nnz, coo_row_ind, coo_col_ind, perm, temp_buffer)
    @check ccall((:rocsparse_coosort_by_column, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, m, n, nnz, coo_row_ind, coo_col_ind, perm, temp_buffer)
end

function rocsparse_sbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_sbsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_dbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_dbsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_cbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_cbsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_zbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_zbsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_sgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_sgebsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_dgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_dgebsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_cgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_cgebsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_zgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    @check ccall((:rocsparse_zgebsr2csr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}), handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val, csr_row_ptr, csr_col_ind)
end

function rocsparse_sgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
    @check ccall((:rocsparse_sgebsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
end

function rocsparse_dgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
    @check ccall((:rocsparse_dgebsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
end

function rocsparse_cgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
    @check ccall((:rocsparse_cgebsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
end

function rocsparse_zgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
    @check ccall((:rocsparse_zgebsr2gebsr_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_int, Ptr{Csize_t}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, row_block_dim_C, col_block_dim_C, buffer_size)
end

function rocsparse_gebsr2gebsr_nnz(handle, dir, mb, nb, nnzb, descr_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_row_ptr_C, row_block_dim_C, col_block_dim_C, nnz_total_dev_host_ptr, temp_buffer)
    @check ccall((:rocsparse_gebsr2gebsr_nnz, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{rocsparse_int}, Ptr{Cvoid}), handle, dir, mb, nb, nnzb, descr_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_row_ptr_C, row_block_dim_C, col_block_dim_C, nnz_total_dev_host_ptr, temp_buffer)
end

function rocsparse_sgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
    @check ccall((:rocsparse_sgebsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
end

function rocsparse_dgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
    @check ccall((:rocsparse_dgebsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
end

function rocsparse_cgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
    @check ccall((:rocsparse_cgebsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
end

function rocsparse_zgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
    @check ccall((:rocsparse_zgebsr2gebsr, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_direction, rocsparse_int, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_int, rocsparse_int, Ptr{Cvoid}), handle, dir, mb, nb, nnzb, descr_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, row_block_dim_C, col_block_dim_C, temp_buffer)
end

function rocsparse_axpby(handle, alpha, x, beta, y)
    @check ccall((:rocsparse_axpby, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{Cvoid}, rocsparse_spvec_descr, Ptr{Cvoid}, rocsparse_dnvec_descr), handle, alpha, x, beta, y)
end

function rocsparse_gather(handle, y, x)
    @check ccall((:rocsparse_gather, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_dnvec_descr, rocsparse_spvec_descr), handle, y, x)
end

function rocsparse_scatter(handle, x, y)
    @check ccall((:rocsparse_scatter, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_spvec_descr, rocsparse_dnvec_descr), handle, x, y)
end

function rocsparse_rot(handle, c, s, x, y)
    @check ccall((:rocsparse_rot, librocsparse), rocsparse_status, (rocsparse_handle, Ptr{Cvoid}, Ptr{Cvoid}, rocsparse_spvec_descr, rocsparse_dnvec_descr), handle, c, s, x, y)
end

function rocsparse_sparse_to_dense(handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
    @check ccall((:rocsparse_sparse_to_dense, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_spmat_descr, rocsparse_dnmat_descr, rocsparse_sparse_to_dense_alg, Ptr{Csize_t}, Ptr{Cvoid}), handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
end

function rocsparse_dense_to_sparse(handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
    @check ccall((:rocsparse_dense_to_sparse, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_dnmat_descr, rocsparse_spmat_descr, rocsparse_dense_to_sparse_alg, Ptr{Csize_t}, Ptr{Cvoid}), handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
end

function rocsparse_spvv(handle, trans, x, y, result, compute_type, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spvv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_spvec_descr, rocsparse_dnvec_descr, Ptr{Cvoid}, rocsparse_datatype, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans, x, y, result, compute_type, buffer_size, temp_buffer)
end

function rocsparse_spmv(handle, trans, alpha, mat, x, beta, y, compute_type, alg, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spmv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_dnvec_descr, Ptr{Cvoid}, rocsparse_dnvec_descr, rocsparse_datatype, rocsparse_spmv_alg, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans, alpha, mat, x, beta, y, compute_type, alg, buffer_size, temp_buffer)
end

function rocsparse_spsv(handle, trans, alpha, mat, x, y, compute_type, alg, stage, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spsv, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_dnvec_descr, rocsparse_dnvec_descr, rocsparse_datatype, rocsparse_spsv_alg, rocsparse_spsv_stage, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans, alpha, mat, x, y, compute_type, alg, stage, buffer_size, temp_buffer)
end

function rocsparse_spsm(handle, trans_A, trans_B, alpha, matA, matB, matC, compute_type, alg, stage, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spsm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_dnmat_descr, rocsparse_dnmat_descr, rocsparse_datatype, rocsparse_spsm_alg, rocsparse_spsm_stage, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans_A, trans_B, alpha, matA, matB, matC, compute_type, alg, stage, buffer_size, temp_buffer)
end

function rocsparse_spmm(handle, trans_A, trans_B, alpha, mat_A, mat_B, beta, mat_C, compute_type, alg, stage, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_dnmat_descr, Ptr{Cvoid}, rocsparse_dnmat_descr, rocsparse_datatype, rocsparse_spmm_alg, rocsparse_spmm_stage, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans_A, trans_B, alpha, mat_A, mat_B, beta, mat_C, compute_type, alg, stage, buffer_size, temp_buffer)
end

function rocsparse_spgemm(handle, trans_A, trans_B, alpha, A, B, beta, D, C, compute_type, alg, stage, buffer_size, temp_buffer)
    @check ccall((:rocsparse_spgemm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_spmat_descr, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_spmat_descr, rocsparse_datatype, rocsparse_spgemm_alg, rocsparse_spgemm_stage, Ptr{Csize_t}, Ptr{Cvoid}), handle, trans_A, trans_B, alpha, A, B, beta, D, C, compute_type, alg, stage, buffer_size, temp_buffer)
end

function rocsparse_sddmm(handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, temp_buffer)
    @check ccall((:rocsparse_sddmm, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_dnmat_descr, rocsparse_dnmat_descr, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_datatype, rocsparse_sddmm_alg, Ptr{Cvoid}), handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, temp_buffer)
end

function rocsparse_sddmm_buffer_size(handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, buffer_size)
    @check ccall((:rocsparse_sddmm_buffer_size, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_dnmat_descr, rocsparse_dnmat_descr, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_datatype, rocsparse_sddmm_alg, Ptr{Csize_t}), handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, buffer_size)
end

function rocsparse_sddmm_preprocess(handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, temp_buffer)
    @check ccall((:rocsparse_sddmm_preprocess, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_operation, rocsparse_operation, Ptr{Cvoid}, rocsparse_dnmat_descr, rocsparse_dnmat_descr, Ptr{Cvoid}, rocsparse_spmat_descr, rocsparse_datatype, rocsparse_sddmm_alg, Ptr{Cvoid}), handle, opA, opB, alpha, A, B, beta, C, compute_type, alg, temp_buffer)
end

function rocsparse_scsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
    @check ccall((:rocsparse_scsrcolor, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
end

function rocsparse_dcsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
    @check ccall((:rocsparse_dcsrcolor, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
end

function rocsparse_ccsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
    @check ccall((:rocsparse_ccsrcolor, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_float_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cfloat}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
end

function rocsparse_zcsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
    @check ccall((:rocsparse_zcsrcolor, librocsparse), rocsparse_status, (rocsparse_handle, rocsparse_int, rocsparse_int, rocsparse_mat_descr, Ptr{rocsparse_double_complex}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{Cdouble}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, Ptr{rocsparse_int}, rocsparse_mat_info), handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, fraction_to_color, ncolors, coloring, reordering, info)
end

# Skipping MacroDefinition: ROCSPARSE_EXPORT __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: ROCSPARSE_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: ROCSPARSE_DEPRECATED __attribute__ ( ( __deprecated__ ) )

const ROCSPARSE_DEPRECATED_EXPORT = ROCSPARSE_EXPORT(ROCSPARSE_DEPRECATED)

const ROCSPARSE_DEPRECATED_NO_EXPORT = ROCSPARSE_NO_EXPORT(ROCSPARSE_DEPRECATED)

const ROCSPARSE_KERNEL = __global__

const ROCSPARSE_DEVICE_ILF = __device__

const ROCSPARSE_VERSION_MAJOR = 2

const ROCSPARSE_VERSION_MINOR = 2

const ROCSPARSE_VERSION_PATCH = 0

const ROCSPARSE_VERSION_TWEAK = 22d75cb

