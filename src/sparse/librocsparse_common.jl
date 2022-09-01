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
