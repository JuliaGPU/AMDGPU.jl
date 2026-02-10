mutable struct _rocsparse_handle end

const rocsparse_handle = Ptr{_rocsparse_handle}

function rocsparse_create_handle(handle)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_handle(handle::Ptr{rocsparse_handle})::rocsparse_status)
end

function rocsparse_destroy_handle(handle)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_handle(handle::rocsparse_handle)::rocsparse_status)
end

mutable struct _rocsparse_error end

const rocsparse_error = Ptr{_rocsparse_error}

function rocsparse_destroy_error(error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_error(error::rocsparse_error)::rocsparse_status)
end

function rocsparse_error_get_message(error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_error_get_message(error::rocsparse_error)::Ptr{Cchar})
end

function rocsparse_get_status_name(status)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_status_name(status::rocsparse_status)::Ptr{Cchar})
end

function rocsparse_get_status_description(status)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_status_description(status::rocsparse_status)::Ptr{Cchar})
end

function rocsparse_set_stream(handle, stream)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_stream(handle::rocsparse_handle,
                                                    stream::hipStream_t)::rocsparse_status)
end

function rocsparse_get_stream(handle, stream)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_stream(handle::rocsparse_handle,
                                                    stream::Ptr{hipStream_t})::rocsparse_status)
end

@cenum rocsparse_pointer_mode_::UInt32 begin
    rocsparse_pointer_mode_host = 0
    rocsparse_pointer_mode_device = 1
end

const rocsparse_pointer_mode = rocsparse_pointer_mode_

function rocsparse_set_pointer_mode(handle, pointer_mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_pointer_mode(handle::rocsparse_handle,
                                                          pointer_mode::rocsparse_pointer_mode)::rocsparse_status)
end

function rocsparse_get_pointer_mode(handle, pointer_mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_pointer_mode(handle::rocsparse_handle,
                                                          pointer_mode::Ptr{rocsparse_pointer_mode})::rocsparse_status)
end

function rocsparse_get_version(handle, version)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_version(handle::rocsparse_handle,
                                                     version::Ptr{Cint})::rocsparse_status)
end

function rocsparse_get_git_rev(handle, rev)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_git_rev(handle::rocsparse_handle,
                                                     rev::Ptr{Cchar})::rocsparse_status)
end

mutable struct _rocsparse_mat_descr end

const rocsparse_mat_descr = Ptr{_rocsparse_mat_descr}

function rocsparse_create_mat_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_mat_descr(descr::Ptr{rocsparse_mat_descr})::rocsparse_status)
end

function rocsparse_copy_mat_descr(dest, src)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_copy_mat_descr(dest::rocsparse_mat_descr,
                                                        src::rocsparse_mat_descr)::rocsparse_status)
end

function rocsparse_destroy_mat_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_mat_descr(descr::rocsparse_mat_descr)::rocsparse_status)
end

@cenum rocsparse_index_base_::UInt32 begin
    rocsparse_index_base_zero = 0
    rocsparse_index_base_one = 1
end

const rocsparse_index_base = rocsparse_index_base_

function rocsparse_set_mat_index_base(descr, base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_mat_index_base(descr::rocsparse_mat_descr,
                                                            base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_get_mat_index_base(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_mat_index_base(descr::rocsparse_mat_descr)::rocsparse_index_base)
end

@cenum rocsparse_matrix_type_::UInt32 begin
    rocsparse_matrix_type_general = 0
    rocsparse_matrix_type_symmetric = 1
    rocsparse_matrix_type_hermitian = 2
    rocsparse_matrix_type_triangular = 3
end

const rocsparse_matrix_type = rocsparse_matrix_type_

function rocsparse_set_mat_type(descr, type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_mat_type(descr::rocsparse_mat_descr,
                                                      type::rocsparse_matrix_type)::rocsparse_status)
end

function rocsparse_get_mat_type(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_mat_type(descr::rocsparse_mat_descr)::rocsparse_matrix_type)
end

@cenum rocsparse_fill_mode_::UInt32 begin
    rocsparse_fill_mode_lower = 0
    rocsparse_fill_mode_upper = 1
end

const rocsparse_fill_mode = rocsparse_fill_mode_

function rocsparse_set_mat_fill_mode(descr, fill_mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_mat_fill_mode(descr::rocsparse_mat_descr,
                                                           fill_mode::rocsparse_fill_mode)::rocsparse_status)
end

function rocsparse_get_mat_fill_mode(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_mat_fill_mode(descr::rocsparse_mat_descr)::rocsparse_fill_mode)
end

@cenum rocsparse_diag_type_::UInt32 begin
    rocsparse_diag_type_non_unit = 0
    rocsparse_diag_type_unit = 1
end

const rocsparse_diag_type = rocsparse_diag_type_

function rocsparse_set_mat_diag_type(descr, diag_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_mat_diag_type(descr::rocsparse_mat_descr,
                                                           diag_type::rocsparse_diag_type)::rocsparse_status)
end

function rocsparse_get_mat_diag_type(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_mat_diag_type(descr::rocsparse_mat_descr)::rocsparse_diag_type)
end

@cenum rocsparse_storage_mode_::UInt32 begin
    rocsparse_storage_mode_sorted = 0
    rocsparse_storage_mode_unsorted = 1
end

const rocsparse_storage_mode = rocsparse_storage_mode_

function rocsparse_set_mat_storage_mode(descr, storage_mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_mat_storage_mode(descr::rocsparse_mat_descr,
                                                              storage_mode::rocsparse_storage_mode)::rocsparse_status)
end

function rocsparse_get_mat_storage_mode(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_get_mat_storage_mode(descr::rocsparse_mat_descr)::rocsparse_storage_mode)
end

mutable struct _rocsparse_hyb_mat end

const rocsparse_hyb_mat = Ptr{_rocsparse_hyb_mat}

function rocsparse_create_hyb_mat(hyb)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_hyb_mat(hyb::Ptr{rocsparse_hyb_mat})::rocsparse_status)
end

function rocsparse_copy_hyb_mat(dest, src)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_copy_hyb_mat(dest::rocsparse_hyb_mat,
                                                      src::rocsparse_hyb_mat)::rocsparse_status)
end

function rocsparse_destroy_hyb_mat(hyb)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_hyb_mat(hyb::rocsparse_hyb_mat)::rocsparse_status)
end

mutable struct _rocsparse_mat_info end

const rocsparse_mat_info = Ptr{_rocsparse_mat_info}

function rocsparse_create_mat_info(info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_mat_info(info::Ptr{rocsparse_mat_info})::rocsparse_status)
end

function rocsparse_copy_mat_info(dest, src)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_copy_mat_info(dest::rocsparse_mat_info,
                                                       src::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_destroy_mat_info(info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_mat_info(info::rocsparse_mat_info)::rocsparse_status)
end

mutable struct _rocsparse_color_info end

const rocsparse_color_info = Ptr{_rocsparse_color_info}

function rocsparse_create_color_info(info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_color_info(info::Ptr{rocsparse_color_info})::rocsparse_status)
end

function rocsparse_copy_color_info(dest, src)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_copy_color_info(dest::rocsparse_color_info,
                                                         src::rocsparse_color_info)::rocsparse_status)
end

function rocsparse_destroy_color_info(info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_color_info(info::rocsparse_color_info)::rocsparse_status)
end

mutable struct _rocsparse_spvec_descr end

const rocsparse_spvec_descr = Ptr{_rocsparse_spvec_descr}

@cenum rocsparse_indextype_::UInt32 begin
    rocsparse_indextype_u16 = 1
    rocsparse_indextype_i32 = 2
    rocsparse_indextype_i64 = 3
end

const rocsparse_indextype = rocsparse_indextype_

@cenum rocsparse_datatype_::UInt32 begin
    rocsparse_datatype_f16_r = 150
    rocsparse_datatype_f32_r = 151
    rocsparse_datatype_f64_r = 152
    rocsparse_datatype_f32_c = 154
    rocsparse_datatype_f64_c = 155
    rocsparse_datatype_i8_r = 160
    rocsparse_datatype_u8_r = 161
    rocsparse_datatype_i32_r = 162
    rocsparse_datatype_u32_r = 163
    rocsparse_datatype_bf16_r = 168
end

const rocsparse_datatype = rocsparse_datatype_

function rocsparse_create_spvec_descr(descr, size, nnz, indices, values, idx_type, idx_base,
                                      data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_spvec_descr(descr::Ptr{rocsparse_spvec_descr},
                                                            size::Int64, nnz::Int64,
                                                            indices::Ptr{Cvoid},
                                                            values::Ptr{Cvoid},
                                                            idx_type::rocsparse_indextype,
                                                            idx_base::rocsparse_index_base,
                                                            data_type::rocsparse_datatype)::rocsparse_status)
end

const rocsparse_const_spvec_descr = Ptr{_rocsparse_spvec_descr}

function rocsparse_create_const_spvec_descr(descr, size, nnz, indices, values, idx_type,
                                            idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_spvec_descr(descr::Ptr{rocsparse_const_spvec_descr},
                                                                  size::Int64, nnz::Int64,
                                                                  indices::Ptr{Cvoid},
                                                                  values::Ptr{Cvoid},
                                                                  idx_type::rocsparse_indextype,
                                                                  idx_base::rocsparse_index_base,
                                                                  data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_destroy_spvec_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_spvec_descr(descr::rocsparse_const_spvec_descr)::rocsparse_status)
end

function rocsparse_spvec_get(descr, size, nnz, indices, values, idx_type, idx_base,
                             data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spvec_get(descr::rocsparse_spvec_descr,
                                                   size::Ptr{Int64}, nnz::Ptr{Int64},
                                                   indices::Ptr{Ptr{Cvoid}},
                                                   values::Ptr{Ptr{Cvoid}},
                                                   idx_type::Ptr{rocsparse_indextype},
                                                   idx_base::Ptr{rocsparse_index_base},
                                                   data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_spvec_get(descr, size, nnz, indices, values, idx_type, idx_base,
                                   data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_spvec_get(descr::rocsparse_const_spvec_descr,
                                                         size::Ptr{Int64}, nnz::Ptr{Int64},
                                                         indices::Ptr{Ptr{Cvoid}},
                                                         values::Ptr{Ptr{Cvoid}},
                                                         idx_type::Ptr{rocsparse_indextype},
                                                         idx_base::Ptr{rocsparse_index_base},
                                                         data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_spvec_get_index_base(descr, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spvec_get_index_base(descr::rocsparse_const_spvec_descr,
                                                              idx_base::Ptr{rocsparse_index_base})::rocsparse_status)
end

function rocsparse_spvec_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spvec_get_values(descr::rocsparse_spvec_descr,
                                                          values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_const_spvec_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_spvec_get_values(descr::rocsparse_const_spvec_descr,
                                                                values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_spvec_set_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spvec_set_values(descr::rocsparse_spvec_descr,
                                                          values::Ptr{Cvoid})::rocsparse_status)
end

mutable struct _rocsparse_spmat_descr end

const rocsparse_spmat_descr = Ptr{_rocsparse_spmat_descr}

function rocsparse_create_coo_descr(descr, rows, cols, nnz, coo_row_ind, coo_col_ind,
                                    coo_val, idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_coo_descr(descr::Ptr{rocsparse_spmat_descr},
                                                          rows::Int64, cols::Int64,
                                                          nnz::Int64,
                                                          coo_row_ind::Ptr{Cvoid},
                                                          coo_col_ind::Ptr{Cvoid},
                                                          coo_val::Ptr{Cvoid},
                                                          idx_type::rocsparse_indextype,
                                                          idx_base::rocsparse_index_base,
                                                          data_type::rocsparse_datatype)::rocsparse_status)
end

const rocsparse_const_spmat_descr = Ptr{_rocsparse_spmat_descr}

function rocsparse_create_const_coo_descr(descr, rows, cols, nnz, coo_row_ind, coo_col_ind,
                                          coo_val, idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_coo_descr(descr::Ptr{rocsparse_const_spmat_descr},
                                                                rows::Int64, cols::Int64,
                                                                nnz::Int64,
                                                                coo_row_ind::Ptr{Cvoid},
                                                                coo_col_ind::Ptr{Cvoid},
                                                                coo_val::Ptr{Cvoid},
                                                                idx_type::rocsparse_indextype,
                                                                idx_base::rocsparse_index_base,
                                                                data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_coo_aos_descr(descr, rows, cols, nnz, coo_ind, coo_val, idx_type,
                                        idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_coo_aos_descr(descr::Ptr{rocsparse_spmat_descr},
                                                              rows::Int64, cols::Int64,
                                                              nnz::Int64,
                                                              coo_ind::Ptr{Cvoid},
                                                              coo_val::Ptr{Cvoid},
                                                              idx_type::rocsparse_indextype,
                                                              idx_base::rocsparse_index_base,
                                                              data_type::rocsparse_datatype)::rocsparse_status)
end

@cenum rocsparse_direction_::UInt32 begin
    rocsparse_direction_row = 0
    rocsparse_direction_column = 1
end

const rocsparse_direction = rocsparse_direction_

function rocsparse_create_bsr_descr(descr, mb, nb, nnzb, block_dir, block_dim, bsr_row_ptr,
                                    bsr_col_ind, bsr_val, row_ptr_type, col_ind_type,
                                    idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_bsr_descr(descr::Ptr{rocsparse_spmat_descr},
                                                          mb::Int64, nb::Int64, nnzb::Int64,
                                                          block_dir::rocsparse_direction,
                                                          block_dim::Int64,
                                                          bsr_row_ptr::Ptr{Cvoid},
                                                          bsr_col_ind::Ptr{Cvoid},
                                                          bsr_val::Ptr{Cvoid},
                                                          row_ptr_type::rocsparse_indextype,
                                                          col_ind_type::rocsparse_indextype,
                                                          idx_base::rocsparse_index_base,
                                                          data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_csr_descr(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind,
                                    csr_val, row_ptr_type, col_ind_type, idx_base,
                                    data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_csr_descr(descr::Ptr{rocsparse_spmat_descr},
                                                          rows::Int64, cols::Int64,
                                                          nnz::Int64,
                                                          csr_row_ptr::Ptr{Cvoid},
                                                          csr_col_ind::Ptr{Cvoid},
                                                          csr_val::Ptr{Cvoid},
                                                          row_ptr_type::rocsparse_indextype,
                                                          col_ind_type::rocsparse_indextype,
                                                          idx_base::rocsparse_index_base,
                                                          data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_const_csr_descr(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind,
                                          csr_val, row_ptr_type, col_ind_type, idx_base,
                                          data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_csr_descr(descr::Ptr{rocsparse_const_spmat_descr},
                                                                rows::Int64, cols::Int64,
                                                                nnz::Int64,
                                                                csr_row_ptr::Ptr{Cvoid},
                                                                csr_col_ind::Ptr{Cvoid},
                                                                csr_val::Ptr{Cvoid},
                                                                row_ptr_type::rocsparse_indextype,
                                                                col_ind_type::rocsparse_indextype,
                                                                idx_base::rocsparse_index_base,
                                                                data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_csc_descr(descr, rows, cols, nnz, csc_col_ptr, csc_row_ind,
                                    csc_val, col_ptr_type, row_ind_type, idx_base,
                                    data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_csc_descr(descr::Ptr{rocsparse_spmat_descr},
                                                          rows::Int64, cols::Int64,
                                                          nnz::Int64,
                                                          csc_col_ptr::Ptr{Cvoid},
                                                          csc_row_ind::Ptr{Cvoid},
                                                          csc_val::Ptr{Cvoid},
                                                          col_ptr_type::rocsparse_indextype,
                                                          row_ind_type::rocsparse_indextype,
                                                          idx_base::rocsparse_index_base,
                                                          data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_const_csc_descr(descr, rows, cols, nnz, csc_col_ptr, csc_row_ind,
                                          csc_val, col_ptr_type, row_ind_type, idx_base,
                                          data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_csc_descr(descr::Ptr{rocsparse_const_spmat_descr},
                                                                rows::Int64, cols::Int64,
                                                                nnz::Int64,
                                                                csc_col_ptr::Ptr{Cvoid},
                                                                csc_row_ind::Ptr{Cvoid},
                                                                csc_val::Ptr{Cvoid},
                                                                col_ptr_type::rocsparse_indextype,
                                                                row_ind_type::rocsparse_indextype,
                                                                idx_base::rocsparse_index_base,
                                                                data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_ell_descr(descr, rows, cols, ell_col_ind, ell_val, ell_width,
                                    idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_ell_descr(descr::Ptr{rocsparse_spmat_descr},
                                                          rows::Int64, cols::Int64,
                                                          ell_col_ind::Ptr{Cvoid},
                                                          ell_val::Ptr{Cvoid},
                                                          ell_width::Int64,
                                                          idx_type::rocsparse_indextype,
                                                          idx_base::rocsparse_index_base,
                                                          data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_bell_descr(descr, rows, cols, ell_block_dir, ell_block_dim,
                                     ell_cols, ell_col_ind, ell_val, idx_type, idx_base,
                                     data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_bell_descr(descr::Ptr{rocsparse_spmat_descr},
                                                           rows::Int64, cols::Int64,
                                                           ell_block_dir::rocsparse_direction,
                                                           ell_block_dim::Int64,
                                                           ell_cols::Int64,
                                                           ell_col_ind::Ptr{Cvoid},
                                                           ell_val::Ptr{Cvoid},
                                                           idx_type::rocsparse_indextype,
                                                           idx_base::rocsparse_index_base,
                                                           data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_const_bell_descr(descr, rows, cols, ell_block_dir, ell_block_dim,
                                           ell_cols, ell_col_ind, ell_val, idx_type,
                                           idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_bell_descr(descr::Ptr{rocsparse_const_spmat_descr},
                                                                 rows::Int64, cols::Int64,
                                                                 ell_block_dir::rocsparse_direction,
                                                                 ell_block_dim::Int64,
                                                                 ell_cols::Int64,
                                                                 ell_col_ind::Ptr{Cvoid},
                                                                 ell_val::Ptr{Cvoid},
                                                                 idx_type::rocsparse_indextype,
                                                                 idx_base::rocsparse_index_base,
                                                                 data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_sell_descr(descr, rows, cols, nnz, sell_slice_size,
                                     sell_colval_size, sell_slice_offsets, sell_col_ind,
                                     sell_val, sell_slice_offsets_type, sell_col_ind_type,
                                     idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_sell_descr(descr::Ptr{rocsparse_spmat_descr},
                                                           rows::Int64, cols::Int64,
                                                           nnz::Int64,
                                                           sell_slice_size::Int64,
                                                           sell_colval_size::Int64,
                                                           sell_slice_offsets::Ptr{Cvoid},
                                                           sell_col_ind::Ptr{Cvoid},
                                                           sell_val::Ptr{Cvoid},
                                                           sell_slice_offsets_type::rocsparse_indextype,
                                                           sell_col_ind_type::rocsparse_indextype,
                                                           idx_base::rocsparse_index_base,
                                                           data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_create_const_sell_descr(descr, rows, cols, nnz, sell_slice_size,
                                           sell_colval_size, sell_slice_offsets,
                                           sell_col_ind, sell_val, sell_slice_offsets_type,
                                           sell_col_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_sell_descr(descr::Ptr{rocsparse_const_spmat_descr},
                                                                 rows::Int64, cols::Int64,
                                                                 nnz::Int64,
                                                                 sell_slice_size::Int64,
                                                                 sell_colval_size::Int64,
                                                                 sell_slice_offsets::Ptr{Cvoid},
                                                                 sell_col_ind::Ptr{Cvoid},
                                                                 sell_val::Ptr{Cvoid},
                                                                 sell_slice_offsets_type::rocsparse_indextype,
                                                                 sell_col_ind_type::rocsparse_indextype,
                                                                 idx_base::rocsparse_index_base,
                                                                 data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_destroy_spmat_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_spmat_descr(descr::rocsparse_const_spmat_descr)::rocsparse_status)
end

mutable struct _rocsparse_sparse_to_sparse_descr end

const rocsparse_sparse_to_sparse_descr = Ptr{_rocsparse_sparse_to_sparse_descr}

@cenum rocsparse_sparse_to_sparse_alg_::UInt32 begin
    rocsparse_sparse_to_sparse_alg_default = 0
end

const rocsparse_sparse_to_sparse_alg = rocsparse_sparse_to_sparse_alg_

function rocsparse_create_sparse_to_sparse_descr(descr, source, target, alg)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_sparse_to_sparse_descr(descr::Ptr{rocsparse_sparse_to_sparse_descr},
                                                                       source::rocsparse_const_spmat_descr,
                                                                       target::rocsparse_spmat_descr,
                                                                       alg::rocsparse_sparse_to_sparse_alg)::rocsparse_status)
end

function rocsparse_sparse_to_sparse_permissive(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sparse_to_sparse_permissive(descr::rocsparse_sparse_to_sparse_descr)::rocsparse_status)
end

function rocsparse_destroy_sparse_to_sparse_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_sparse_to_sparse_descr(descr::rocsparse_sparse_to_sparse_descr)::rocsparse_status)
end

mutable struct _rocsparse_extract_descr end

const rocsparse_extract_descr = Ptr{_rocsparse_extract_descr}

@cenum rocsparse_extract_alg_::UInt32 begin
    rocsparse_extract_alg_default = 0
end

const rocsparse_extract_alg = rocsparse_extract_alg_

function rocsparse_create_extract_descr(descr, source, target, alg)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_extract_descr(descr::Ptr{rocsparse_extract_descr},
                                                              source::rocsparse_const_spmat_descr,
                                                              target::rocsparse_spmat_descr,
                                                              alg::rocsparse_extract_alg)::rocsparse_status)
end

function rocsparse_destroy_extract_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_extract_descr(descr::rocsparse_extract_descr)::rocsparse_status)
end

mutable struct _rocsparse_spgeam_descr end

const rocsparse_spgeam_descr = Ptr{_rocsparse_spgeam_descr}

function rocsparse_create_spgeam_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_spgeam_descr(descr::Ptr{rocsparse_spgeam_descr})::rocsparse_status)
end

function rocsparse_destroy_spgeam_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_spgeam_descr(descr::rocsparse_spgeam_descr)::rocsparse_status)
end

@cenum rocsparse_spgeam_input_::UInt32 begin
    rocsparse_spgeam_input_alg = 0
    rocsparse_spgeam_input_scalar_datatype = 1
    rocsparse_spgeam_input_compute_datatype = 2
    rocsparse_spgeam_input_operation_A = 3
    rocsparse_spgeam_input_operation_B = 4
    rocsparse_spgeam_input_scalar_alpha = 5
    rocsparse_spgeam_input_scalar_beta = 6
end

const rocsparse_spgeam_input = rocsparse_spgeam_input_

function rocsparse_spgeam_set_input(handle, descr, input, data, data_size_in_bytes, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spgeam_set_input(handle::rocsparse_handle,
                                                          descr::rocsparse_spgeam_descr,
                                                          input::rocsparse_spgeam_input,
                                                          data::Ptr{Cvoid},
                                                          data_size_in_bytes::Csize_t,
                                                          p_error::Ptr{rocsparse_error})::rocsparse_status)
end

@cenum rocsparse_spgeam_output_::UInt32 begin
    rocsparse_spgeam_output_nnz = 0
end

const rocsparse_spgeam_output = rocsparse_spgeam_output_

function rocsparse_spgeam_get_output(handle, descr, output, data, data_size_in_bytes, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spgeam_get_output(handle::rocsparse_handle,
                                                           descr::rocsparse_spgeam_descr,
                                                           output::rocsparse_spgeam_output,
                                                           data::Ptr{Cvoid},
                                                           data_size_in_bytes::Csize_t,
                                                           error::Ptr{rocsparse_error})::rocsparse_status)
end

mutable struct _rocsparse_spmv_descr end

const rocsparse_spmv_descr = Ptr{_rocsparse_spmv_descr}

function rocsparse_create_spmv_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_spmv_descr(descr::Ptr{rocsparse_spmv_descr})::rocsparse_status)
end

function rocsparse_destroy_spmv_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_spmv_descr(descr::rocsparse_spmv_descr)::rocsparse_status)
end

@cenum rocsparse_spmv_input_::UInt32 begin
    rocsparse_spmv_input_alg = 0
    rocsparse_spmv_input_operation = 1
    rocsparse_spmv_input_scalar_datatype = 2
    rocsparse_spmv_input_compute_datatype = 3
    rocsparse_spmv_input_nnz_use_starting_block_ids = 4
    rocsparse_spmv_input_enable_extra = 5
end

const rocsparse_spmv_input = rocsparse_spmv_input_

function rocsparse_spmv_set_input(handle, descr, input, in, size_in_bytes, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmv_set_input(handle::rocsparse_handle,
                                                        descr::rocsparse_spmv_descr,
                                                        input::rocsparse_spmv_input,
                                                        in::Ptr{Cvoid},
                                                        size_in_bytes::Csize_t,
                                                        error::Ptr{rocsparse_error})::rocsparse_status)
end

mutable struct _rocsparse_sptrsv_descr end

const rocsparse_sptrsv_descr = Ptr{_rocsparse_sptrsv_descr}

function rocsparse_create_sptrsv_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_sptrsv_descr(descr::Ptr{rocsparse_sptrsv_descr})::rocsparse_status)
end

function rocsparse_destroy_sptrsv_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_sptrsv_descr(descr::rocsparse_sptrsv_descr)::rocsparse_status)
end

@cenum rocsparse_sptrsv_input_::UInt32 begin
    rocsparse_sptrsv_input_alg = 0
    rocsparse_sptrsv_input_operation = 1
    rocsparse_sptrsv_input_scalar_datatype = 2
    rocsparse_sptrsv_input_compute_datatype = 3
    rocsparse_sptrsv_input_scalar_alpha = 4
    rocsparse_sptrsv_input_analysis_policy = 5
end

const rocsparse_sptrsv_input = rocsparse_sptrsv_input_

function rocsparse_sptrsv_set_input(handle, descr, input, data, data_size_in_bytes, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsv_set_input(handle::rocsparse_handle,
                                                          descr::rocsparse_sptrsv_descr,
                                                          input::rocsparse_sptrsv_input,
                                                          data::Ptr{Cvoid},
                                                          data_size_in_bytes::Csize_t,
                                                          p_error::Ptr{rocsparse_error})::rocsparse_status)
end

@cenum rocsparse_sptrsv_output_::UInt32 begin
    rocsparse_sptrsv_output_zero_pivot_position = 0
end

const rocsparse_sptrsv_output = rocsparse_sptrsv_output_

function rocsparse_sptrsv_get_output(handle, descr, output, data, data_size_in_bytes,
                                     p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsv_get_output(handle::rocsparse_handle,
                                                           descr::rocsparse_sptrsv_descr,
                                                           output::rocsparse_sptrsv_output,
                                                           data::Ptr{Cvoid},
                                                           data_size_in_bytes::Csize_t,
                                                           p_error::Ptr{rocsparse_error})::rocsparse_status)
end

mutable struct _rocsparse_sptrsm_descr end

const rocsparse_sptrsm_descr = Ptr{_rocsparse_sptrsm_descr}

function rocsparse_create_sptrsm_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_sptrsm_descr(descr::Ptr{rocsparse_sptrsm_descr})::rocsparse_status)
end

function rocsparse_destroy_sptrsm_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_sptrsm_descr(descr::rocsparse_sptrsm_descr)::rocsparse_status)
end

@cenum rocsparse_sptrsm_input_::UInt32 begin
    rocsparse_sptrsm_input_alg = 0
    rocsparse_sptrsm_input_operation_A = 1
    rocsparse_sptrsm_input_operation_X = 2
    rocsparse_sptrsm_input_compute_datatype = 3
    rocsparse_sptrsm_input_scalar_datatype = 4
    rocsparse_sptrsm_input_scalar_alpha = 5
    rocsparse_sptrsm_input_analysis_policy = 6
end

const rocsparse_sptrsm_input = rocsparse_sptrsm_input_

function rocsparse_sptrsm_set_input(handle, descr, input, data, data_size, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsm_set_input(handle::rocsparse_handle,
                                                          descr::rocsparse_sptrsm_descr,
                                                          input::rocsparse_sptrsm_input,
                                                          data::Ptr{Cvoid},
                                                          data_size::Csize_t,
                                                          p_error::Ptr{rocsparse_error})::rocsparse_status)
end

@cenum rocsparse_sptrsm_output_::UInt32 begin
    rocsparse_sptrsm_output_zero_pivot_position = 0
end

const rocsparse_sptrsm_output = rocsparse_sptrsm_output_

function rocsparse_sptrsm_get_output(handle, descr, output, data, data_size_in_bytes,
                                     p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsm_get_output(handle::rocsparse_handle,
                                                           descr::rocsparse_sptrsm_descr,
                                                           output::rocsparse_sptrsm_output,
                                                           data::Ptr{Cvoid},
                                                           data_size_in_bytes::Csize_t,
                                                           p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_coo_get(descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val,
                           idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo_get(descr::rocsparse_spmat_descr,
                                                 rows::Ptr{Int64}, cols::Ptr{Int64},
                                                 nnz::Ptr{Int64},
                                                 coo_row_ind::Ptr{Ptr{Cvoid}},
                                                 coo_col_ind::Ptr{Ptr{Cvoid}},
                                                 coo_val::Ptr{Ptr{Cvoid}},
                                                 idx_type::Ptr{rocsparse_indextype},
                                                 idx_base::Ptr{rocsparse_index_base},
                                                 data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_coo_get(descr, rows, cols, nnz, coo_row_ind, coo_col_ind, coo_val,
                                 idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_coo_get(descr::rocsparse_const_spmat_descr,
                                                       rows::Ptr{Int64}, cols::Ptr{Int64},
                                                       nnz::Ptr{Int64},
                                                       coo_row_ind::Ptr{Ptr{Cvoid}},
                                                       coo_col_ind::Ptr{Ptr{Cvoid}},
                                                       coo_val::Ptr{Ptr{Cvoid}},
                                                       idx_type::Ptr{rocsparse_indextype},
                                                       idx_base::Ptr{rocsparse_index_base},
                                                       data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_coo_aos_get(descr, rows, cols, nnz, coo_ind, coo_val, idx_type, idx_base,
                               data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo_aos_get(descr::rocsparse_spmat_descr,
                                                     rows::Ptr{Int64}, cols::Ptr{Int64},
                                                     nnz::Ptr{Int64},
                                                     coo_ind::Ptr{Ptr{Cvoid}},
                                                     coo_val::Ptr{Ptr{Cvoid}},
                                                     idx_type::Ptr{rocsparse_indextype},
                                                     idx_base::Ptr{rocsparse_index_base},
                                                     data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_coo_aos_get(descr, rows, cols, nnz, coo_ind, coo_val, idx_type,
                                     idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_coo_aos_get(descr::rocsparse_const_spmat_descr,
                                                           rows::Ptr{Int64},
                                                           cols::Ptr{Int64},
                                                           nnz::Ptr{Int64},
                                                           coo_ind::Ptr{Ptr{Cvoid}},
                                                           coo_val::Ptr{Ptr{Cvoid}},
                                                           idx_type::Ptr{rocsparse_indextype},
                                                           idx_base::Ptr{rocsparse_index_base},
                                                           data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_csr_get(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val,
                           row_ptr_type, col_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr_get(descr::rocsparse_spmat_descr,
                                                 rows::Ptr{Int64}, cols::Ptr{Int64},
                                                 nnz::Ptr{Int64},
                                                 csr_row_ptr::Ptr{Ptr{Cvoid}},
                                                 csr_col_ind::Ptr{Ptr{Cvoid}},
                                                 csr_val::Ptr{Ptr{Cvoid}},
                                                 row_ptr_type::Ptr{rocsparse_indextype},
                                                 col_ind_type::Ptr{rocsparse_indextype},
                                                 idx_base::Ptr{rocsparse_index_base},
                                                 data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_csr_get(descr, rows, cols, nnz, csr_row_ptr, csr_col_ind, csr_val,
                                 row_ptr_type, col_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_csr_get(descr::rocsparse_const_spmat_descr,
                                                       rows::Ptr{Int64}, cols::Ptr{Int64},
                                                       nnz::Ptr{Int64},
                                                       csr_row_ptr::Ptr{Ptr{Cvoid}},
                                                       csr_col_ind::Ptr{Ptr{Cvoid}},
                                                       csr_val::Ptr{Ptr{Cvoid}},
                                                       row_ptr_type::Ptr{rocsparse_indextype},
                                                       col_ind_type::Ptr{rocsparse_indextype},
                                                       idx_base::Ptr{rocsparse_index_base},
                                                       data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_csc_get(descr, rows, cols, nnz, csc_col_ptr, csc_row_ind, csc_val,
                           col_ptr_type, row_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csc_get(descr::rocsparse_spmat_descr,
                                                 rows::Ptr{Int64}, cols::Ptr{Int64},
                                                 nnz::Ptr{Int64},
                                                 csc_col_ptr::Ptr{Ptr{Cvoid}},
                                                 csc_row_ind::Ptr{Ptr{Cvoid}},
                                                 csc_val::Ptr{Ptr{Cvoid}},
                                                 col_ptr_type::Ptr{rocsparse_indextype},
                                                 row_ind_type::Ptr{rocsparse_indextype},
                                                 idx_base::Ptr{rocsparse_index_base},
                                                 data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_csc_get(descr, rows, cols, nnz, csc_col_ptr, csc_row_ind, csc_val,
                                 col_ptr_type, row_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_csc_get(descr::rocsparse_const_spmat_descr,
                                                       rows::Ptr{Int64}, cols::Ptr{Int64},
                                                       nnz::Ptr{Int64},
                                                       csc_col_ptr::Ptr{Ptr{Cvoid}},
                                                       csc_row_ind::Ptr{Ptr{Cvoid}},
                                                       csc_val::Ptr{Ptr{Cvoid}},
                                                       col_ptr_type::Ptr{rocsparse_indextype},
                                                       row_ind_type::Ptr{rocsparse_indextype},
                                                       idx_base::Ptr{rocsparse_index_base},
                                                       data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_ell_get(descr, rows, cols, ell_col_ind, ell_val, ell_width, idx_type,
                           idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ell_get(descr::rocsparse_spmat_descr,
                                                 rows::Ptr{Int64}, cols::Ptr{Int64},
                                                 ell_col_ind::Ptr{Ptr{Cvoid}},
                                                 ell_val::Ptr{Ptr{Cvoid}},
                                                 ell_width::Ptr{Int64},
                                                 idx_type::Ptr{rocsparse_indextype},
                                                 idx_base::Ptr{rocsparse_index_base},
                                                 data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_ell_get(descr, rows, cols, ell_col_ind, ell_val, ell_width,
                                 idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_ell_get(descr::rocsparse_const_spmat_descr,
                                                       rows::Ptr{Int64}, cols::Ptr{Int64},
                                                       ell_col_ind::Ptr{Ptr{Cvoid}},
                                                       ell_val::Ptr{Ptr{Cvoid}},
                                                       ell_width::Ptr{Int64},
                                                       idx_type::Ptr{rocsparse_indextype},
                                                       idx_base::Ptr{rocsparse_index_base},
                                                       data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_bell_get(descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols,
                            ell_col_ind, ell_val, idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bell_get(descr::rocsparse_spmat_descr,
                                                  rows::Ptr{Int64}, cols::Ptr{Int64},
                                                  ell_block_dir::Ptr{rocsparse_direction},
                                                  ell_block_dim::Ptr{Int64},
                                                  ell_cols::Ptr{Int64},
                                                  ell_col_ind::Ptr{Ptr{Cvoid}},
                                                  ell_val::Ptr{Ptr{Cvoid}},
                                                  idx_type::Ptr{rocsparse_indextype},
                                                  idx_base::Ptr{rocsparse_index_base},
                                                  data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_bell_get(descr, rows, cols, ell_block_dir, ell_block_dim, ell_cols,
                                  ell_col_ind, ell_val, idx_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_bell_get(descr::rocsparse_const_spmat_descr,
                                                        rows::Ptr{Int64}, cols::Ptr{Int64},
                                                        ell_block_dir::Ptr{rocsparse_direction},
                                                        ell_block_dim::Ptr{Int64},
                                                        ell_cols::Ptr{Int64},
                                                        ell_col_ind::Ptr{Ptr{Cvoid}},
                                                        ell_val::Ptr{Ptr{Cvoid}},
                                                        idx_type::Ptr{rocsparse_indextype},
                                                        idx_base::Ptr{rocsparse_index_base},
                                                        data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_sell_get(descr, rows, cols, nnz, sell_slice_size, sell_colval_size,
                            sell_slice_offsets, sell_col_ind, sell_val,
                            sell_slice_offsets_type, sell_col_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sell_get(descr::rocsparse_spmat_descr,
                                                  rows::Ptr{Int64}, cols::Ptr{Int64},
                                                  nnz::Ptr{Int64},
                                                  sell_slice_size::Ptr{Int64},
                                                  sell_colval_size::Ptr{Int64},
                                                  sell_slice_offsets::Ptr{Ptr{Cvoid}},
                                                  sell_col_ind::Ptr{Ptr{Cvoid}},
                                                  sell_val::Ptr{Ptr{Cvoid}},
                                                  sell_slice_offsets_type::Ptr{rocsparse_indextype},
                                                  sell_col_ind_type::Ptr{rocsparse_indextype},
                                                  idx_base::Ptr{rocsparse_index_base},
                                                  data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_sell_get(descr, rows, cols, nnz, sell_slice_size, sell_colval_size,
                                  sell_slice_offsets, sell_col_ind, sell_val,
                                  sell_slice_offsets_type, sell_col_ind_type, idx_base,
                                  data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_sell_get(descr::rocsparse_const_spmat_descr,
                                                        rows::Ptr{Int64}, cols::Ptr{Int64},
                                                        nnz::Ptr{Int64},
                                                        sell_slice_size::Ptr{Int64},
                                                        sell_colval_size::Ptr{Int64},
                                                        sell_slice_offsets::Ptr{Ptr{Cvoid}},
                                                        sell_col_ind::Ptr{Ptr{Cvoid}},
                                                        sell_val::Ptr{Ptr{Cvoid}},
                                                        sell_slice_offsets_type::Ptr{rocsparse_indextype},
                                                        sell_col_ind_type::Ptr{rocsparse_indextype},
                                                        idx_base::Ptr{rocsparse_index_base},
                                                        data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_bsr_get(descr, brows, bcols, bnnz, bdir, bdim, bsr_row_ptr, bsr_col_ind,
                           bsr_val, row_ptr_type, col_ind_type, idx_base, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsr_get(descr::rocsparse_spmat_descr,
                                                 brows::Ptr{Int64}, bcols::Ptr{Int64},
                                                 bnnz::Ptr{Int64},
                                                 bdir::Ptr{rocsparse_direction},
                                                 bdim::Ptr{Int64},
                                                 bsr_row_ptr::Ptr{Ptr{Cvoid}},
                                                 bsr_col_ind::Ptr{Ptr{Cvoid}},
                                                 bsr_val::Ptr{Ptr{Cvoid}},
                                                 row_ptr_type::Ptr{rocsparse_indextype},
                                                 col_ind_type::Ptr{rocsparse_indextype},
                                                 idx_base::Ptr{rocsparse_index_base},
                                                 data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_bsr_get(descr, brows, bcols, bnnz, bdir, bdim, bsr_row_ptr,
                                 bsr_col_ind, bsr_val, row_ptr_type, col_ind_type, idx_base,
                                 data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_bsr_get(descr::rocsparse_const_spmat_descr,
                                                       brows::Ptr{Int64}, bcols::Ptr{Int64},
                                                       bnnz::Ptr{Int64},
                                                       bdir::Ptr{rocsparse_direction},
                                                       bdim::Ptr{Int64},
                                                       bsr_row_ptr::Ptr{Ptr{Cvoid}},
                                                       bsr_col_ind::Ptr{Ptr{Cvoid}},
                                                       bsr_val::Ptr{Ptr{Cvoid}},
                                                       row_ptr_type::Ptr{rocsparse_indextype},
                                                       col_ind_type::Ptr{rocsparse_indextype},
                                                       idx_base::Ptr{rocsparse_index_base},
                                                       data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_coo_set_pointers(descr, coo_row_ind, coo_col_ind, coo_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo_set_pointers(descr::rocsparse_spmat_descr,
                                                          coo_row_ind::Ptr{Cvoid},
                                                          coo_col_ind::Ptr{Cvoid},
                                                          coo_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_coo_aos_set_pointers(descr, coo_ind, coo_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo_aos_set_pointers(descr::rocsparse_spmat_descr,
                                                              coo_ind::Ptr{Cvoid},
                                                              coo_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csr_set_pointers(descr, csr_row_ptr, csr_col_ind, csr_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr_set_pointers(descr::rocsparse_spmat_descr,
                                                          csr_row_ptr::Ptr{Cvoid},
                                                          csr_col_ind::Ptr{Cvoid},
                                                          csr_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csc_set_pointers(descr, csc_col_ptr, csc_row_ind, csc_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csc_set_pointers(descr::rocsparse_spmat_descr,
                                                          csc_col_ptr::Ptr{Cvoid},
                                                          csc_row_ind::Ptr{Cvoid},
                                                          csc_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ell_set_pointers(descr, ell_col_ind, ell_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ell_set_pointers(descr::rocsparse_spmat_descr,
                                                          ell_col_ind::Ptr{Cvoid},
                                                          ell_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsr_set_pointers(descr, bsr_row_ptr, bsr_col_ind, bsr_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsr_set_pointers(descr::rocsparse_spmat_descr,
                                                          bsr_row_ptr::Ptr{Cvoid},
                                                          bsr_col_ind::Ptr{Cvoid},
                                                          bsr_val::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_spmat_get_size(descr, rows, cols, nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_size(descr::rocsparse_const_spmat_descr,
                                                        rows::Ptr{Int64}, cols::Ptr{Int64},
                                                        nnz::Ptr{Int64})::rocsparse_status)
end

@cenum rocsparse_format_::UInt32 begin
    rocsparse_format_coo = 0
    rocsparse_format_coo_aos = 1
    rocsparse_format_csr = 2
    rocsparse_format_csc = 3
    rocsparse_format_ell = 4
    rocsparse_format_bell = 5
    rocsparse_format_bsr = 6
    rocsparse_format_sell = 7
end

const rocsparse_format = rocsparse_format_

function rocsparse_spmat_get_format(descr, format)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_format(descr::rocsparse_const_spmat_descr,
                                                          format::Ptr{rocsparse_format})::rocsparse_status)
end

function rocsparse_spmat_get_index_base(descr, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_index_base(descr::rocsparse_const_spmat_descr,
                                                              idx_base::Ptr{rocsparse_index_base})::rocsparse_status)
end

function rocsparse_spmat_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_values(descr::rocsparse_spmat_descr,
                                                          values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_const_spmat_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_spmat_get_values(descr::rocsparse_const_spmat_descr,
                                                                values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_spmat_set_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_set_values(descr::rocsparse_spmat_descr,
                                                          values::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_spmat_get_nnz(descr, nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_nnz(descr::rocsparse_const_spmat_descr,
                                                       nnz::Ptr{Int64})::rocsparse_status)
end

function rocsparse_spmat_set_nnz(descr, nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_set_nnz(descr::rocsparse_spmat_descr,
                                                       nnz::Int64)::rocsparse_status)
end

const rocsparse_int = Int32

function rocsparse_spmat_get_strided_batch(descr, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_strided_batch(descr::rocsparse_const_spmat_descr,
                                                                 batch_count::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_spmat_set_strided_batch(descr, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_set_strided_batch(descr::rocsparse_spmat_descr,
                                                                 batch_count::rocsparse_int)::rocsparse_status)
end

function rocsparse_coo_set_strided_batch(descr, batch_count, batch_stride)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo_set_strided_batch(descr::rocsparse_spmat_descr,
                                                               batch_count::rocsparse_int,
                                                               batch_stride::Int64)::rocsparse_status)
end

function rocsparse_csr_set_strided_batch(descr, batch_count, offsets_batch_stride,
                                         columns_values_batch_stride)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr_set_strided_batch(descr::rocsparse_spmat_descr,
                                                               batch_count::rocsparse_int,
                                                               offsets_batch_stride::Int64,
                                                               columns_values_batch_stride::Int64)::rocsparse_status)
end

function rocsparse_csc_set_strided_batch(descr, batch_count, offsets_batch_stride,
                                         rows_values_batch_stride)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csc_set_strided_batch(descr::rocsparse_spmat_descr,
                                                               batch_count::rocsparse_int,
                                                               offsets_batch_stride::Int64,
                                                               rows_values_batch_stride::Int64)::rocsparse_status)
end

@cenum rocsparse_spmat_attribute_::UInt32 begin
    rocsparse_spmat_fill_mode = 0
    rocsparse_spmat_diag_type = 1
    rocsparse_spmat_matrix_type = 2
    rocsparse_spmat_storage_mode = 3
end

const rocsparse_spmat_attribute = rocsparse_spmat_attribute_

function rocsparse_spmat_get_attribute(descr, attribute, data, data_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_get_attribute(descr::rocsparse_const_spmat_descr,
                                                             attribute::rocsparse_spmat_attribute,
                                                             data::Ptr{Cvoid},
                                                             data_size::Csize_t)::rocsparse_status)
end

function rocsparse_spmat_set_attribute(descr, attribute, data, data_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmat_set_attribute(descr::rocsparse_spmat_descr,
                                                             attribute::rocsparse_spmat_attribute,
                                                             data::Ptr{Cvoid},
                                                             data_size::Csize_t)::rocsparse_status)
end

mutable struct _rocsparse_dnvec_descr end

const rocsparse_dnvec_descr = Ptr{_rocsparse_dnvec_descr}

function rocsparse_create_dnvec_descr(descr, size, values, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_dnvec_descr(descr::Ptr{rocsparse_dnvec_descr},
                                                            size::Int64, values::Ptr{Cvoid},
                                                            data_type::rocsparse_datatype)::rocsparse_status)
end

const rocsparse_const_dnvec_descr = Ptr{_rocsparse_dnvec_descr}

function rocsparse_create_const_dnvec_descr(descr, size, values, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_dnvec_descr(descr::Ptr{rocsparse_const_dnvec_descr},
                                                                  size::Int64,
                                                                  values::Ptr{Cvoid},
                                                                  data_type::rocsparse_datatype)::rocsparse_status)
end

function rocsparse_destroy_dnvec_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_dnvec_descr(descr::rocsparse_const_dnvec_descr)::rocsparse_status)
end

function rocsparse_dnvec_get(descr, size, values, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnvec_get(descr::rocsparse_dnvec_descr,
                                                   size::Ptr{Int64},
                                                   values::Ptr{Ptr{Cvoid}},
                                                   data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_const_dnvec_get(descr, size, values, data_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_dnvec_get(descr::rocsparse_const_dnvec_descr,
                                                         size::Ptr{Int64},
                                                         values::Ptr{Ptr{Cvoid}},
                                                         data_type::Ptr{rocsparse_datatype})::rocsparse_status)
end

function rocsparse_dnvec_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnvec_get_values(descr::rocsparse_dnvec_descr,
                                                          values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_const_dnvec_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_dnvec_get_values(descr::rocsparse_const_dnvec_descr,
                                                                values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_dnvec_set_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnvec_set_values(descr::rocsparse_dnvec_descr,
                                                          values::Ptr{Cvoid})::rocsparse_status)
end

mutable struct _rocsparse_dnmat_descr end

const rocsparse_dnmat_descr = Ptr{_rocsparse_dnmat_descr}

@cenum rocsparse_order_::UInt32 begin
    rocsparse_order_row = 0
    rocsparse_order_column = 1
end

const rocsparse_order = rocsparse_order_

function rocsparse_create_dnmat_descr(descr, rows, cols, ld, values, data_type, order)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_dnmat_descr(descr::Ptr{rocsparse_dnmat_descr},
                                                            rows::Int64, cols::Int64,
                                                            ld::Int64, values::Ptr{Cvoid},
                                                            data_type::rocsparse_datatype,
                                                            order::rocsparse_order)::rocsparse_status)
end

const rocsparse_const_dnmat_descr = Ptr{_rocsparse_dnmat_descr}

function rocsparse_create_const_dnmat_descr(descr, rows, cols, ld, values, data_type, order)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_const_dnmat_descr(descr::Ptr{rocsparse_const_dnmat_descr},
                                                                  rows::Int64, cols::Int64,
                                                                  ld::Int64,
                                                                  values::Ptr{Cvoid},
                                                                  data_type::rocsparse_datatype,
                                                                  order::rocsparse_order)::rocsparse_status)
end

function rocsparse_destroy_dnmat_descr(descr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_destroy_dnmat_descr(descr::rocsparse_const_dnmat_descr)::rocsparse_status)
end

function rocsparse_dnmat_get(descr, rows, cols, ld, values, data_type, order)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnmat_get(descr::rocsparse_dnmat_descr,
                                                   rows::Ptr{Int64}, cols::Ptr{Int64},
                                                   ld::Ptr{Int64}, values::Ptr{Ptr{Cvoid}},
                                                   data_type::Ptr{rocsparse_datatype},
                                                   order::Ptr{rocsparse_order})::rocsparse_status)
end

function rocsparse_const_dnmat_get(descr, rows, cols, ld, values, data_type, order)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_dnmat_get(descr::rocsparse_const_dnmat_descr,
                                                         rows::Ptr{Int64}, cols::Ptr{Int64},
                                                         ld::Ptr{Int64},
                                                         values::Ptr{Ptr{Cvoid}},
                                                         data_type::Ptr{rocsparse_datatype},
                                                         order::Ptr{rocsparse_order})::rocsparse_status)
end

function rocsparse_dnmat_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnmat_get_values(descr::rocsparse_dnmat_descr,
                                                          values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_const_dnmat_get_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_const_dnmat_get_values(descr::rocsparse_const_dnmat_descr,
                                                                values::Ptr{Ptr{Cvoid}})::rocsparse_status)
end

function rocsparse_dnmat_set_values(descr, values)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnmat_set_values(descr::rocsparse_dnmat_descr,
                                                          values::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dnmat_get_strided_batch(descr, batch_count, batch_stride)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnmat_get_strided_batch(descr::rocsparse_const_dnmat_descr,
                                                                 batch_count::Ptr{rocsparse_int},
                                                                 batch_stride::Ptr{Int64})::rocsparse_status)
end

function rocsparse_dnmat_set_strided_batch(descr, batch_count, batch_stride)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnmat_set_strided_batch(descr::rocsparse_dnmat_descr,
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::Int64)::rocsparse_status)
end

struct rocsparse_float_complex
    x::Cfloat
    y::Cfloat
end

struct rocsparse_double_complex
    x::Cdouble
    y::Cdouble
end

# no prototype is found for this function at rocsparse-debugging.h:44:6, please use with caution
function rocsparse_enable_debug_kernel_launch()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_kernel_launch()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:50:23, please use with caution
function rocsparse_disable_debug_kernel_launch()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_kernel_launch()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:56:22, please use with caution
function rocsparse_state_debug_kernel_launch()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug_kernel_launch()::Cint)
end

# no prototype is found for this function at rocsparse-debugging.h:67:6, please use with caution
function rocsparse_enable_debug_arguments()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_arguments()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:75:6, please use with caution
function rocsparse_disable_debug_arguments()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_arguments()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:82:5, please use with caution
function rocsparse_state_debug_arguments()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug_arguments()::Cint)
end

# no prototype is found for this function at rocsparse-debugging.h:91:6, please use with caution
function rocsparse_enable_debug_arguments_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_arguments_verbose()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:98:6, please use with caution
function rocsparse_disable_debug_arguments_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_arguments_verbose()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:105:5, please use with caution
function rocsparse_state_debug_arguments_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug_arguments_verbose()::Cint)
end

# no prototype is found for this function at rocsparse-debugging.h:115:6, please use with caution
function rocsparse_enable_debug()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:123:6, please use with caution
function rocsparse_disable_debug()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:130:5, please use with caution
function rocsparse_state_debug()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug()::Cint)
end

# no prototype is found for this function at rocsparse-debugging.h:138:6, please use with caution
function rocsparse_enable_debug_warnings()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_warnings()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:145:6, please use with caution
function rocsparse_disable_debug_warnings()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_warnings()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:154:6, please use with caution
function rocsparse_enable_debug_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_verbose()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:162:6, please use with caution
function rocsparse_disable_debug_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_verbose()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:168:5, please use with caution
function rocsparse_state_debug_verbose()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug_verbose()::Cint)
end

# no prototype is found for this function at rocsparse-debugging.h:175:6, please use with caution
function rocsparse_enable_debug_force_host_assert()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_debug_force_host_assert()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:181:6, please use with caution
function rocsparse_disable_debug_force_host_assert()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_debug_force_host_assert()::Cvoid)
end

# no prototype is found for this function at rocsparse-debugging.h:188:5, please use with caution
function rocsparse_state_debug_force_host_assert()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_debug_force_host_assert()::Cint)
end

function rocsparse_sbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                            bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr,
                            csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsr2csr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cfloat},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                            bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr,
                            csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsr2csr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cdouble},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                            bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr,
                            csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsr2csr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zbsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                            bsr_col_ind, block_dim, csr_descr, csr_val, csr_row_ptr,
                            csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsr2csr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsrpad_value(handle, m, mb, nnzb, block_dim, value, bsr_descr, bsr_val,
                                 bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrpad_value(handle::rocsparse_handle,
                                                       m::rocsparse_int, mb::rocsparse_int,
                                                       nnzb::rocsparse_int,
                                                       block_dim::rocsparse_int,
                                                       value::Cfloat,
                                                       bsr_descr::rocsparse_mat_descr,
                                                       bsr_val::Ptr{Cfloat},
                                                       bsr_row_ptr::Ptr{rocsparse_int},
                                                       bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dbsrpad_value(handle, m, mb, nnzb, block_dim, value, bsr_descr, bsr_val,
                                 bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrpad_value(handle::rocsparse_handle,
                                                       m::rocsparse_int, mb::rocsparse_int,
                                                       nnzb::rocsparse_int,
                                                       block_dim::rocsparse_int,
                                                       value::Cdouble,
                                                       bsr_descr::rocsparse_mat_descr,
                                                       bsr_val::Ptr{Cdouble},
                                                       bsr_row_ptr::Ptr{rocsparse_int},
                                                       bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cbsrpad_value(handle, m, mb, nnzb, block_dim, value, bsr_descr, bsr_val,
                                 bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrpad_value(handle::rocsparse_handle,
                                                       m::rocsparse_int, mb::rocsparse_int,
                                                       nnzb::rocsparse_int,
                                                       block_dim::rocsparse_int,
                                                       value::rocsparse_float_complex,
                                                       bsr_descr::rocsparse_mat_descr,
                                                       bsr_val::Ptr{rocsparse_float_complex},
                                                       bsr_row_ptr::Ptr{rocsparse_int},
                                                       bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zbsrpad_value(handle, m, mb, nnzb, block_dim, value, bsr_descr, bsr_val,
                                 bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrpad_value(handle::rocsparse_handle,
                                                       m::rocsparse_int, mb::rocsparse_int,
                                                       nnzb::rocsparse_int,
                                                       block_dim::rocsparse_int,
                                                       value::rocsparse_double_complex,
                                                       bsr_descr::rocsparse_mat_descr,
                                                       bsr_val::Ptr{rocsparse_double_complex},
                                                       bsr_row_ptr::Ptr{rocsparse_int},
                                                       bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_coo2csr(handle, coo_row_ind, nnz, m, csr_row_ptr, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coo2csr(handle::rocsparse_handle,
                                                 coo_row_ind::Ptr{rocsparse_int},
                                                 nnz::rocsparse_int, m::rocsparse_int,
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_scoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind,
                              A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scoo2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    nnz::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    coo_val::Ptr{Cfloat},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cfloat},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_dcoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind,
                              A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcoo2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    nnz::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    coo_val::Ptr{Cdouble},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cdouble},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_ccoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind,
                              A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccoo2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    nnz::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    coo_val::Ptr{rocsparse_float_complex},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_zcoo2dense(handle, m, n, nnz, descr, coo_val, coo_row_ind, coo_col_ind,
                              A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcoo2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    nnz::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    coo_val::Ptr{rocsparse_double_complex},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_coosort_buffer_size(handle, m, n, nnz, coo_row_ind, coo_col_ind,
                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coosort_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             n::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             coo_row_ind::Ptr{rocsparse_int},
                                                             coo_col_ind::Ptr{rocsparse_int},
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_coosort_by_row(handle, m, n, nnz, coo_row_ind, coo_col_ind, perm,
                                  temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coosort_by_row(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        nnz::rocsparse_int,
                                                        coo_row_ind::Ptr{rocsparse_int},
                                                        coo_col_ind::Ptr{rocsparse_int},
                                                        perm::Ptr{rocsparse_int},
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_coosort_by_column(handle, m, n, nnz, coo_row_ind, coo_col_ind, perm,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_coosort_by_column(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           coo_row_ind::Ptr{rocsparse_int},
                                                           coo_col_ind::Ptr{rocsparse_int},
                                                           perm::Ptr{rocsparse_int},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsc2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csc_val::Ptr{Cfloat},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cfloat},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_dcsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsc2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csc_val::Ptr{Cdouble},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cdouble},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_ccsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsc2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csc_val::Ptr{rocsparse_float_complex},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_zcsc2dense(handle, m, n, descr, csc_val, csc_col_ptr, csc_row_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsc2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csc_val::Ptr{rocsparse_double_complex},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_cscsort_buffer_size(handle, m, n, nnz, csc_col_ptr, csc_row_ind,
                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cscsort_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             n::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             csc_col_ptr::Ptr{rocsparse_int},
                                                             csc_row_ind::Ptr{rocsparse_int},
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cscsort(handle, m, n, nnz, descr, csc_col_ptr, csc_row_ind, perm,
                           temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cscsort(handle::rocsparse_handle, m::rocsparse_int,
                                                 n::rocsparse_int, nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csc_col_ptr::Ptr{rocsparse_int},
                                                 csc_row_ind::Ptr{rocsparse_int},
                                                 perm::Ptr{rocsparse_int},
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csr2bsr_nnz(handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind,
                               block_dim, bsr_descr, bsr_row_ptr, bsr_nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr2bsr_nnz(handle::rocsparse_handle,
                                                     dir::rocsparse_direction,
                                                     m::rocsparse_int, n::rocsparse_int,
                                                     csr_descr::rocsparse_mat_descr,
                                                     csr_row_ptr::Ptr{rocsparse_int},
                                                     csr_col_ind::Ptr{rocsparse_int},
                                                     block_dim::rocsparse_int,
                                                     bsr_descr::rocsparse_mat_descr,
                                                     bsr_row_ptr::Ptr{rocsparse_int},
                                                     bsr_nnz::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2bsr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cfloat},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dcsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2bsr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cdouble},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ccsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2bsr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zcsr2bsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            block_dim, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2bsr(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  bsr_descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_csr2coo(handle, csr_row_ptr, nnz, m, coo_row_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr2coo(handle::rocsparse_handle,
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 nnz::rocsparse_int, m::rocsparse_int,
                                                 coo_row_ind::Ptr{rocsparse_int},
                                                 idx_base::rocsparse_index_base)::rocsparse_status)
end

@cenum rocsparse_action_::UInt32 begin
    rocsparse_action_symbolic = 0
    rocsparse_action_numeric = 1
end

const rocsparse_action = rocsparse_action_

function rocsparse_csr2csc_buffer_size(handle, m, n, nnz, csr_row_ptr, csr_col_ind,
                                       copy_values, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr2csc_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             n::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             copy_values::rocsparse_action,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val,
                            csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2csc(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  nnz::rocsparse_int, csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  csc_val::Ptr{Cfloat},
                                                  csc_row_ind::Ptr{rocsparse_int},
                                                  csc_col_ptr::Ptr{rocsparse_int},
                                                  copy_values::rocsparse_action,
                                                  idx_base::rocsparse_index_base,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val,
                            csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2csc(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  nnz::rocsparse_int, csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  csc_val::Ptr{Cdouble},
                                                  csc_row_ind::Ptr{rocsparse_int},
                                                  csc_col_ptr::Ptr{rocsparse_int},
                                                  copy_values::rocsparse_action,
                                                  idx_base::rocsparse_index_base,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val,
                            csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2csc(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  nnz::rocsparse_int,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  csc_val::Ptr{rocsparse_float_complex},
                                                  csc_row_ind::Ptr{rocsparse_int},
                                                  csc_col_ptr::Ptr{rocsparse_int},
                                                  copy_values::rocsparse_action,
                                                  idx_base::rocsparse_index_base,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsr2csc(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind, csc_val,
                            csc_row_ind, csc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2csc(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  nnz::rocsparse_int,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  csc_val::Ptr{rocsparse_double_complex},
                                                  csc_row_ind::Ptr{rocsparse_int},
                                                  csc_col_ptr::Ptr{rocsparse_int},
                                                  copy_values::rocsparse_action,
                                                  idx_base::rocsparse_index_base,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A,
                                     csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C,
                                     csr_row_ptr_C, csr_col_ind_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2csr_compress(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           descr_A::rocsparse_mat_descr,
                                                           csr_val_A::Ptr{Cfloat},
                                                           csr_row_ptr_A::Ptr{rocsparse_int},
                                                           csr_col_ind_A::Ptr{rocsparse_int},
                                                           nnz_A::rocsparse_int,
                                                           nnz_per_row::Ptr{rocsparse_int},
                                                           csr_val_C::Ptr{Cfloat},
                                                           csr_row_ptr_C::Ptr{rocsparse_int},
                                                           csr_col_ind_C::Ptr{rocsparse_int},
                                                           tol::Cfloat)::rocsparse_status)
end

function rocsparse_dcsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A,
                                     csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C,
                                     csr_row_ptr_C, csr_col_ind_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2csr_compress(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           descr_A::rocsparse_mat_descr,
                                                           csr_val_A::Ptr{Cdouble},
                                                           csr_row_ptr_A::Ptr{rocsparse_int},
                                                           csr_col_ind_A::Ptr{rocsparse_int},
                                                           nnz_A::rocsparse_int,
                                                           nnz_per_row::Ptr{rocsparse_int},
                                                           csr_val_C::Ptr{Cdouble},
                                                           csr_row_ptr_C::Ptr{rocsparse_int},
                                                           csr_col_ind_C::Ptr{rocsparse_int},
                                                           tol::Cdouble)::rocsparse_status)
end

function rocsparse_ccsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A,
                                     csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C,
                                     csr_row_ptr_C, csr_col_ind_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2csr_compress(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           descr_A::rocsparse_mat_descr,
                                                           csr_val_A::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr_A::Ptr{rocsparse_int},
                                                           csr_col_ind_A::Ptr{rocsparse_int},
                                                           nnz_A::rocsparse_int,
                                                           nnz_per_row::Ptr{rocsparse_int},
                                                           csr_val_C::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr_C::Ptr{rocsparse_int},
                                                           csr_col_ind_C::Ptr{rocsparse_int},
                                                           tol::rocsparse_float_complex)::rocsparse_status)
end

function rocsparse_zcsr2csr_compress(handle, m, n, descr_A, csr_val_A, csr_row_ptr_A,
                                     csr_col_ind_A, nnz_A, nnz_per_row, csr_val_C,
                                     csr_row_ptr_C, csr_col_ind_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2csr_compress(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           descr_A::rocsparse_mat_descr,
                                                           csr_val_A::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr_A::Ptr{rocsparse_int},
                                                           csr_col_ind_A::Ptr{rocsparse_int},
                                                           nnz_A::rocsparse_int,
                                                           nnz_per_row::Ptr{rocsparse_int},
                                                           csr_val_C::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr_C::Ptr{rocsparse_int},
                                                           csr_col_ind_C::Ptr{rocsparse_int},
                                                           tol::rocsparse_double_complex)::rocsparse_status)
end

function rocsparse_scsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cfloat},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cfloat},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_dcsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cdouble},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{Cdouble},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_ccsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_float_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_zcsr2dense(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, A, ld)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2dense(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_double_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int)::rocsparse_status)
end

function rocsparse_csr2ell_width(handle, m, csr_descr, csr_row_ptr, ell_descr, ell_width)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr2ell_width(handle::rocsparse_handle,
                                                       m::rocsparse_int,
                                                       csr_descr::rocsparse_mat_descr,
                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                       ell_descr::rocsparse_mat_descr,
                                                       ell_width::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            ell_descr, ell_width, ell_val, ell_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2ell(handle::rocsparse_handle,
                                                  m::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{Cfloat},
                                                  ell_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dcsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            ell_descr, ell_width, ell_val, ell_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2ell(handle::rocsparse_handle,
                                                  m::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{Cdouble},
                                                  ell_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ccsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            ell_descr, ell_width, ell_val, ell_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2ell(handle::rocsparse_handle,
                                                  m::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{rocsparse_float_complex},
                                                  ell_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zcsr2ell(handle, m, csr_descr, csr_val, csr_row_ptr, csr_col_ind,
                            ell_descr, ell_width, ell_val, ell_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2ell(handle::rocsparse_handle,
                                                  m::rocsparse_int,
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{rocsparse_double_complex},
                                                  ell_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val,
                                          csr_row_ptr, csr_col_ind, row_block_dim,
                                          col_block_dim, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                dir::rocsparse_direction,
                                                                m::rocsparse_int,
                                                                n::rocsparse_int,
                                                                csr_descr::rocsparse_mat_descr,
                                                                csr_val::Ptr{Cfloat},
                                                                csr_row_ptr::Ptr{rocsparse_int},
                                                                csr_col_ind::Ptr{rocsparse_int},
                                                                row_block_dim::rocsparse_int,
                                                                col_block_dim::rocsparse_int,
                                                                buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val,
                                          csr_row_ptr, csr_col_ind, row_block_dim,
                                          col_block_dim, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                dir::rocsparse_direction,
                                                                m::rocsparse_int,
                                                                n::rocsparse_int,
                                                                csr_descr::rocsparse_mat_descr,
                                                                csr_val::Ptr{Cdouble},
                                                                csr_row_ptr::Ptr{rocsparse_int},
                                                                csr_col_ind::Ptr{rocsparse_int},
                                                                row_block_dim::rocsparse_int,
                                                                col_block_dim::rocsparse_int,
                                                                buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val,
                                          csr_row_ptr, csr_col_ind, row_block_dim,
                                          col_block_dim, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                dir::rocsparse_direction,
                                                                m::rocsparse_int,
                                                                n::rocsparse_int,
                                                                csr_descr::rocsparse_mat_descr,
                                                                csr_val::Ptr{rocsparse_float_complex},
                                                                csr_row_ptr::Ptr{rocsparse_int},
                                                                csr_col_ind::Ptr{rocsparse_int},
                                                                row_block_dim::rocsparse_int,
                                                                col_block_dim::rocsparse_int,
                                                                buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsr2gebsr_buffer_size(handle, dir, m, n, csr_descr, csr_val,
                                          csr_row_ptr, csr_col_ind, row_block_dim,
                                          col_block_dim, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                dir::rocsparse_direction,
                                                                m::rocsparse_int,
                                                                n::rocsparse_int,
                                                                csr_descr::rocsparse_mat_descr,
                                                                csr_val::Ptr{rocsparse_double_complex},
                                                                csr_row_ptr::Ptr{rocsparse_int},
                                                                csr_col_ind::Ptr{rocsparse_int},
                                                                row_block_dim::rocsparse_int,
                                                                col_block_dim::rocsparse_int,
                                                                buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_csr2gebsr_nnz(handle, dir, m, n, csr_descr, csr_row_ptr, csr_col_ind,
                                 bsr_descr, bsr_row_ptr, row_block_dim, col_block_dim,
                                 bsr_nnz_devhost, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csr2gebsr_nnz(handle::rocsparse_handle,
                                                       dir::rocsparse_direction,
                                                       m::rocsparse_int, n::rocsparse_int,
                                                       csr_descr::rocsparse_mat_descr,
                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                       csr_col_ind::Ptr{rocsparse_int},
                                                       bsr_descr::rocsparse_mat_descr,
                                                       bsr_row_ptr::Ptr{rocsparse_int},
                                                       row_block_dim::rocsparse_int,
                                                       col_block_dim::rocsparse_int,
                                                       bsr_nnz_devhost::Ptr{rocsparse_int},
                                                       temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr,
                              csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                              row_block_dim, col_block_dim, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2gebsr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cfloat},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{Cfloat},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr,
                              csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                              row_block_dim, col_block_dim, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2gebsr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cdouble},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{Cdouble},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr,
                              csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                              row_block_dim, col_block_dim, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2gebsr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_float_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{rocsparse_float_complex},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsr2gebsr(handle, dir, m, n, csr_descr, csr_val, csr_row_ptr,
                              csr_col_ind, bsr_descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                              row_block_dim, col_block_dim, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2gebsr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_double_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int},
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{rocsparse_double_complex},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_hyb_partition_::UInt32 begin
    rocsparse_hyb_partition_auto = 0
    rocsparse_hyb_partition_user = 1
    rocsparse_hyb_partition_max = 2
end

const rocsparse_hyb_partition = rocsparse_hyb_partition_

function rocsparse_scsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb,
                            user_ell_width, partition_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsr2hyb(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  hyb::rocsparse_hyb_mat,
                                                  user_ell_width::rocsparse_int,
                                                  partition_type::rocsparse_hyb_partition)::rocsparse_status)
end

function rocsparse_dcsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb,
                            user_ell_width, partition_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsr2hyb(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  hyb::rocsparse_hyb_mat,
                                                  user_ell_width::rocsparse_int,
                                                  partition_type::rocsparse_hyb_partition)::rocsparse_status)
end

function rocsparse_ccsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb,
                            user_ell_width, partition_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsr2hyb(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  hyb::rocsparse_hyb_mat,
                                                  user_ell_width::rocsparse_int,
                                                  partition_type::rocsparse_hyb_partition)::rocsparse_status)
end

function rocsparse_zcsr2hyb(handle, m, n, descr, csr_val, csr_row_ptr, csr_col_ind, hyb,
                            user_ell_width, partition_type)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsr2hyb(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  hyb::rocsparse_hyb_mat,
                                                  user_ell_width::rocsparse_int,
                                                  partition_type::rocsparse_hyb_partition)::rocsparse_status)
end

function rocsparse_csrsort_buffer_size(handle, m, n, nnz, csr_row_ptr, csr_col_ind,
                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsort_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             n::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_csrsort(handle, m, n, nnz, descr, csr_row_ptr, csr_col_ind, perm,
                           temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsort(handle::rocsparse_handle, m::rocsparse_int,
                                                 n::rocsparse_int, nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 csr_col_ind::Ptr{rocsparse_int},
                                                 perm::Ptr{rocsparse_int},
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val,
                              coo_row_ind, coo_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sdense2coo(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cfloat}, ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    coo_val::Ptr{Cfloat},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ddense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val,
                              coo_row_ind, coo_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ddense2coo(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cdouble}, ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    coo_val::Ptr{Cdouble},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val,
                              coo_row_ind, coo_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cdense2coo(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    coo_val::Ptr{rocsparse_float_complex},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zdense2coo(handle, m, n, descr, A, ld, nnz_per_rows, coo_val,
                              coo_row_ind, coo_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zdense2coo(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    coo_val::Ptr{rocsparse_double_complex},
                                                    coo_row_ind::Ptr{rocsparse_int},
                                                    coo_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val,
                              csc_col_ptr, csc_row_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sdense2csc(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cfloat}, ld::rocsparse_int,
                                                    nnz_per_columns::Ptr{rocsparse_int},
                                                    csc_val::Ptr{Cfloat},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ddense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val,
                              csc_col_ptr, csc_row_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ddense2csc(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cdouble}, ld::rocsparse_int,
                                                    nnz_per_columns::Ptr{rocsparse_int},
                                                    csc_val::Ptr{Cdouble},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val,
                              csc_col_ptr, csc_row_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cdense2csc(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_columns::Ptr{rocsparse_int},
                                                    csc_val::Ptr{rocsparse_float_complex},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zdense2csc(handle, m, n, descr, A, ld, nnz_per_columns, csc_val,
                              csc_col_ptr, csc_row_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zdense2csc(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_columns::Ptr{rocsparse_int},
                                                    csc_val::Ptr{rocsparse_double_complex},
                                                    csc_col_ptr::Ptr{rocsparse_int},
                                                    csc_row_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sdense2csr(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cfloat}, ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    csr_val::Ptr{Cfloat},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ddense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ddense2csr(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{Cdouble}, ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    csr_val::Ptr{Cdouble},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cdense2csr(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_float_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    csr_val::Ptr{rocsparse_float_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zdense2csr(handle, m, n, descr, A, ld, nnz_per_rows, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zdense2csr(handle::rocsparse_handle,
                                                    m::rocsparse_int, n::rocsparse_int,
                                                    descr::rocsparse_mat_descr,
                                                    A::Ptr{rocsparse_double_complex},
                                                    ld::rocsparse_int,
                                                    nnz_per_rows::Ptr{rocsparse_int},
                                                    csr_val::Ptr{rocsparse_double_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ell2csr_nnz(handle, m, n, ell_descr, ell_width, ell_col_ind, csr_descr,
                               csr_row_ptr, csr_nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ell2csr_nnz(handle::rocsparse_handle,
                                                     m::rocsparse_int, n::rocsparse_int,
                                                     ell_descr::rocsparse_mat_descr,
                                                     ell_width::rocsparse_int,
                                                     ell_col_ind::Ptr{rocsparse_int},
                                                     csr_descr::rocsparse_mat_descr,
                                                     csr_row_ptr::Ptr{rocsparse_int},
                                                     csr_nnz::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind,
                            csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sell2csr(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{Cfloat},
                                                  ell_col_ind::Ptr{rocsparse_int},
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind,
                            csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dell2csr(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{Cdouble},
                                                  ell_col_ind::Ptr{rocsparse_int},
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind,
                            csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cell2csr(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{rocsparse_float_complex},
                                                  ell_col_ind::Ptr{rocsparse_int},
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zell2csr(handle, m, n, ell_descr, ell_width, ell_val, ell_col_ind,
                            csr_descr, csr_val, csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zell2csr(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  ell_descr::rocsparse_mat_descr,
                                                  ell_width::rocsparse_int,
                                                  ell_val::Ptr{rocsparse_double_complex},
                                                  ell_col_ind::Ptr{rocsparse_int},
                                                  csr_descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                              bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsr2csr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    mb::rocsparse_int, nb::rocsparse_int,
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{Cfloat},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cfloat},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                              bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsr2csr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    mb::rocsparse_int, nb::rocsparse_int,
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{Cdouble},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{Cdouble},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                              bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsr2csr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    mb::rocsparse_int, nb::rocsparse_int,
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{rocsparse_float_complex},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_float_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zgebsr2csr(handle, dir, mb, nb, bsr_descr, bsr_val, bsr_row_ptr,
                              bsr_col_ind, row_block_dim, col_block_dim, csr_descr, csr_val,
                              csr_row_ptr, csr_col_ind)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsr2csr(handle::rocsparse_handle,
                                                    dir::rocsparse_direction,
                                                    mb::rocsparse_int, nb::rocsparse_int,
                                                    bsr_descr::rocsparse_mat_descr,
                                                    bsr_val::Ptr{rocsparse_double_complex},
                                                    bsr_row_ptr::Ptr{rocsparse_int},
                                                    bsr_col_ind::Ptr{rocsparse_int},
                                                    row_block_dim::rocsparse_int,
                                                    col_block_dim::rocsparse_int,
                                                    csr_descr::rocsparse_mat_descr,
                                                    csr_val::Ptr{rocsparse_double_complex},
                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                    csr_col_ind::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr,
                                            bsr_col_ind, row_block_dim, col_block_dim,
                                            p_buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsr2gebsc_buffer_size(handle::rocsparse_handle,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  bsr_val::Ptr{Cfloat},
                                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                                  row_block_dim::rocsparse_int,
                                                                  col_block_dim::rocsparse_int,
                                                                  p_buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr,
                                            bsr_col_ind, row_block_dim, col_block_dim,
                                            p_buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsr2gebsc_buffer_size(handle::rocsparse_handle,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  bsr_val::Ptr{Cdouble},
                                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                                  row_block_dim::rocsparse_int,
                                                                  col_block_dim::rocsparse_int,
                                                                  p_buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr,
                                            bsr_col_ind, row_block_dim, col_block_dim,
                                            p_buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsr2gebsc_buffer_size(handle::rocsparse_handle,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                                  row_block_dim::rocsparse_int,
                                                                  col_block_dim::rocsparse_int,
                                                                  p_buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgebsr2gebsc_buffer_size(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr,
                                            bsr_col_ind, row_block_dim, col_block_dim,
                                            p_buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsr2gebsc_buffer_size(handle::rocsparse_handle,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                                  row_block_dim::rocsparse_int,
                                                                  col_block_dim::rocsparse_int,
                                                                  p_buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind,
                                row_block_dim, col_block_dim, bsc_val, bsc_row_ind,
                                bsc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsr2gebsc(handle::rocsparse_handle,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      bsr_val::Ptr{Cfloat},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      row_block_dim::rocsparse_int,
                                                      col_block_dim::rocsparse_int,
                                                      bsc_val::Ptr{Cfloat},
                                                      bsc_row_ind::Ptr{rocsparse_int},
                                                      bsc_col_ptr::Ptr{rocsparse_int},
                                                      copy_values::rocsparse_action,
                                                      idx_base::rocsparse_index_base,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind,
                                row_block_dim, col_block_dim, bsc_val, bsc_row_ind,
                                bsc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsr2gebsc(handle::rocsparse_handle,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      bsr_val::Ptr{Cdouble},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      row_block_dim::rocsparse_int,
                                                      col_block_dim::rocsparse_int,
                                                      bsc_val::Ptr{Cdouble},
                                                      bsc_row_ind::Ptr{rocsparse_int},
                                                      bsc_col_ptr::Ptr{rocsparse_int},
                                                      copy_values::rocsparse_action,
                                                      idx_base::rocsparse_index_base,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind,
                                row_block_dim, col_block_dim, bsc_val, bsc_row_ind,
                                bsc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsr2gebsc(handle::rocsparse_handle,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      bsr_val::Ptr{rocsparse_float_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      row_block_dim::rocsparse_int,
                                                      col_block_dim::rocsparse_int,
                                                      bsc_val::Ptr{rocsparse_float_complex},
                                                      bsc_row_ind::Ptr{rocsparse_int},
                                                      bsc_col_ptr::Ptr{rocsparse_int},
                                                      copy_values::rocsparse_action,
                                                      idx_base::rocsparse_index_base,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgebsr2gebsc(handle, mb, nb, nnzb, bsr_val, bsr_row_ptr, bsr_col_ind,
                                row_block_dim, col_block_dim, bsc_val, bsc_row_ind,
                                bsc_col_ptr, copy_values, idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsr2gebsc(handle::rocsparse_handle,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      bsr_val::Ptr{rocsparse_double_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      row_block_dim::rocsparse_int,
                                                      col_block_dim::rocsparse_int,
                                                      bsc_val::Ptr{rocsparse_double_complex},
                                                      bsc_row_ind::Ptr{rocsparse_int},
                                                      bsc_col_ptr::Ptr{rocsparse_int},
                                                      copy_values::rocsparse_action,
                                                      idx_base::rocsparse_index_base,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                            bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                            col_block_dim_A, row_block_dim_C,
                                            col_block_dim_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                  dir::rocsparse_direction,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  descr_A::rocsparse_mat_descr,
                                                                  bsr_val_A::Ptr{Cfloat},
                                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                                  row_block_dim_A::rocsparse_int,
                                                                  col_block_dim_A::rocsparse_int,
                                                                  row_block_dim_C::rocsparse_int,
                                                                  col_block_dim_C::rocsparse_int,
                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                            bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                            col_block_dim_A, row_block_dim_C,
                                            col_block_dim_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                  dir::rocsparse_direction,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  descr_A::rocsparse_mat_descr,
                                                                  bsr_val_A::Ptr{Cdouble},
                                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                                  row_block_dim_A::rocsparse_int,
                                                                  col_block_dim_A::rocsparse_int,
                                                                  row_block_dim_C::rocsparse_int,
                                                                  col_block_dim_C::rocsparse_int,
                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                            bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                            col_block_dim_A, row_block_dim_C,
                                            col_block_dim_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                  dir::rocsparse_direction,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  descr_A::rocsparse_mat_descr,
                                                                  bsr_val_A::Ptr{rocsparse_float_complex},
                                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                                  row_block_dim_A::rocsparse_int,
                                                                  col_block_dim_A::rocsparse_int,
                                                                  row_block_dim_C::rocsparse_int,
                                                                  col_block_dim_C::rocsparse_int,
                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgebsr2gebsr_buffer_size(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                            bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                            col_block_dim_A, row_block_dim_C,
                                            col_block_dim_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsr2gebsr_buffer_size(handle::rocsparse_handle,
                                                                  dir::rocsparse_direction,
                                                                  mb::rocsparse_int,
                                                                  nb::rocsparse_int,
                                                                  nnzb::rocsparse_int,
                                                                  descr_A::rocsparse_mat_descr,
                                                                  bsr_val_A::Ptr{rocsparse_double_complex},
                                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                                  row_block_dim_A::rocsparse_int,
                                                                  col_block_dim_A::rocsparse_int,
                                                                  row_block_dim_C::rocsparse_int,
                                                                  col_block_dim_C::rocsparse_int,
                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_gebsr2gebsr_nnz(handle, dir, mb, nb, nnzb, descr_A, bsr_row_ptr_A,
                                   bsr_col_ind_A, row_block_dim_A, col_block_dim_A, descr_C,
                                   bsr_row_ptr_C, row_block_dim_C, col_block_dim_C,
                                   nnz_total_dev_host_ptr, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_gebsr2gebsr_nnz(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         mb::rocsparse_int,
                                                         nb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr_A::rocsparse_mat_descr,
                                                         bsr_row_ptr_A::Ptr{rocsparse_int},
                                                         bsr_col_ind_A::Ptr{rocsparse_int},
                                                         row_block_dim_A::rocsparse_int,
                                                         col_block_dim_A::rocsparse_int,
                                                         descr_C::rocsparse_mat_descr,
                                                         bsr_row_ptr_C::Ptr{rocsparse_int},
                                                         row_block_dim_C::rocsparse_int,
                                                         col_block_dim_C::rocsparse_int,
                                                         nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C,
                                bsr_col_ind_C, row_block_dim_C, col_block_dim_C,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsr2gebsr(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      bsr_val_A::Ptr{Cfloat},
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      row_block_dim_A::rocsparse_int,
                                                      col_block_dim_A::rocsparse_int,
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_val_C::Ptr{Cfloat},
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      bsr_col_ind_C::Ptr{rocsparse_int},
                                                      row_block_dim_C::rocsparse_int,
                                                      col_block_dim_C::rocsparse_int,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C,
                                bsr_col_ind_C, row_block_dim_C, col_block_dim_C,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsr2gebsr(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      bsr_val_A::Ptr{Cdouble},
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      row_block_dim_A::rocsparse_int,
                                                      col_block_dim_A::rocsparse_int,
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_val_C::Ptr{Cdouble},
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      bsr_col_ind_C::Ptr{rocsparse_int},
                                                      row_block_dim_C::rocsparse_int,
                                                      col_block_dim_C::rocsparse_int,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C,
                                bsr_col_ind_C, row_block_dim_C, col_block_dim_C,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsr2gebsr(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      bsr_val_A::Ptr{rocsparse_float_complex},
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      row_block_dim_A::rocsparse_int,
                                                      col_block_dim_A::rocsparse_int,
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_val_C::Ptr{rocsparse_float_complex},
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      bsr_col_ind_C::Ptr{rocsparse_int},
                                                      row_block_dim_C::rocsparse_int,
                                                      col_block_dim_C::rocsparse_int,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgebsr2gebsr(handle, dir, mb, nb, nnzb, descr_A, bsr_val_A,
                                bsr_row_ptr_A, bsr_col_ind_A, row_block_dim_A,
                                col_block_dim_A, descr_C, bsr_val_C, bsr_row_ptr_C,
                                bsr_col_ind_C, row_block_dim_C, col_block_dim_C,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsr2gebsr(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      bsr_val_A::Ptr{rocsparse_double_complex},
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      row_block_dim_A::rocsparse_int,
                                                      col_block_dim_A::rocsparse_int,
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_val_C::Ptr{rocsparse_double_complex},
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      bsr_col_ind_C::Ptr{rocsparse_int},
                                                      row_block_dim_C::rocsparse_int,
                                                      col_block_dim_C::rocsparse_int,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_hyb2csr_buffer_size(handle, descr, hyb, csr_row_ptr, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_hyb2csr_buffer_size(handle::rocsparse_handle,
                                                             descr::rocsparse_mat_descr,
                                                             hyb::rocsparse_hyb_mat,
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_shyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_shyb2csr(handle::rocsparse_handle,
                                                  descr::rocsparse_mat_descr,
                                                  hyb::rocsparse_hyb_mat,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dhyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dhyb2csr(handle::rocsparse_handle,
                                                  descr::rocsparse_mat_descr,
                                                  hyb::rocsparse_hyb_mat,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_chyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_chyb2csr(handle::rocsparse_handle,
                                                  descr::rocsparse_mat_descr,
                                                  hyb::rocsparse_hyb_mat,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zhyb2csr(handle, descr, hyb, csr_val, csr_row_ptr, csr_col_ind,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zhyb2csr(handle::rocsparse_handle,
                                                  descr::rocsparse_mat_descr,
                                                  hyb::rocsparse_hyb_mat,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_create_identity_permutation(handle, n, p)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_create_identity_permutation(handle::rocsparse_handle,
                                                                     n::rocsparse_int,
                                                                     p::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_inverse_permutation(handle, n, p, q, base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_inverse_permutation(handle::rocsparse_handle,
                                                             n::rocsparse_int,
                                                             p::Ptr{rocsparse_int},
                                                             q::Ptr{rocsparse_int},
                                                             base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_set_identity_permutation(handle, n, p, indextype)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_set_identity_permutation(handle::rocsparse_handle,
                                                                  n::Int64, p::Ptr{Cvoid},
                                                                  indextype::rocsparse_indextype)::rocsparse_status)
end

function rocsparse_snnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns,
                        nnz_total_dev_host_ptr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_snnz(handle::rocsparse_handle,
                                              dir::rocsparse_direction, m::rocsparse_int,
                                              n::rocsparse_int, descr::rocsparse_mat_descr,
                                              A::Ptr{Cfloat}, ld::rocsparse_int,
                                              nnz_per_row_columns::Ptr{rocsparse_int},
                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dnnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns,
                        nnz_total_dev_host_ptr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnnz(handle::rocsparse_handle,
                                              dir::rocsparse_direction, m::rocsparse_int,
                                              n::rocsparse_int, descr::rocsparse_mat_descr,
                                              A::Ptr{Cdouble}, ld::rocsparse_int,
                                              nnz_per_row_columns::Ptr{rocsparse_int},
                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cnnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns,
                        nnz_total_dev_host_ptr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cnnz(handle::rocsparse_handle,
                                              dir::rocsparse_direction, m::rocsparse_int,
                                              n::rocsparse_int, descr::rocsparse_mat_descr,
                                              A::Ptr{rocsparse_float_complex},
                                              ld::rocsparse_int,
                                              nnz_per_row_columns::Ptr{rocsparse_int},
                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_znnz(handle, dir, m, n, descr, A, ld, nnz_per_row_columns,
                        nnz_total_dev_host_ptr)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_znnz(handle::rocsparse_handle,
                                              dir::rocsparse_direction, m::rocsparse_int,
                                              n::rocsparse_int, descr::rocsparse_mat_descr,
                                              A::Ptr{rocsparse_double_complex},
                                              ld::rocsparse_int,
                                              nnz_per_row_columns::Ptr{rocsparse_int},
                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_snnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row,
                                 nnz_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_snnz_compress(handle::rocsparse_handle,
                                                       m::rocsparse_int,
                                                       descr_A::rocsparse_mat_descr,
                                                       csr_val_A::Ptr{Cfloat},
                                                       csr_row_ptr_A::Ptr{rocsparse_int},
                                                       nnz_per_row::Ptr{rocsparse_int},
                                                       nnz_C::Ptr{rocsparse_int},
                                                       tol::Cfloat)::rocsparse_status)
end

function rocsparse_dnnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row,
                                 nnz_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dnnz_compress(handle::rocsparse_handle,
                                                       m::rocsparse_int,
                                                       descr_A::rocsparse_mat_descr,
                                                       csr_val_A::Ptr{Cdouble},
                                                       csr_row_ptr_A::Ptr{rocsparse_int},
                                                       nnz_per_row::Ptr{rocsparse_int},
                                                       nnz_C::Ptr{rocsparse_int},
                                                       tol::Cdouble)::rocsparse_status)
end

function rocsparse_cnnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row,
                                 nnz_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cnnz_compress(handle::rocsparse_handle,
                                                       m::rocsparse_int,
                                                       descr_A::rocsparse_mat_descr,
                                                       csr_val_A::Ptr{rocsparse_float_complex},
                                                       csr_row_ptr_A::Ptr{rocsparse_int},
                                                       nnz_per_row::Ptr{rocsparse_int},
                                                       nnz_C::Ptr{rocsparse_int},
                                                       tol::rocsparse_float_complex)::rocsparse_status)
end

function rocsparse_znnz_compress(handle, m, descr_A, csr_val_A, csr_row_ptr_A, nnz_per_row,
                                 nnz_C, tol)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_znnz_compress(handle::rocsparse_handle,
                                                       m::rocsparse_int,
                                                       descr_A::rocsparse_mat_descr,
                                                       csr_val_A::Ptr{rocsparse_double_complex},
                                                       csr_row_ptr_A::Ptr{rocsparse_int},
                                                       nnz_per_row::Ptr{rocsparse_int},
                                                       nnz_C::Ptr{rocsparse_int},
                                                       tol::rocsparse_double_complex)::rocsparse_status)
end

function rocsparse_sprune_csr2csr_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                              csr_row_ptr_A, csr_col_ind_A, threshold,
                                              csr_descr_C, csr_val_C, csr_row_ptr_C,
                                              csr_col_ind_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    nnz_A::rocsparse_int,
                                                                    csr_descr_A::rocsparse_mat_descr,
                                                                    csr_val_A::Ptr{Cfloat},
                                                                    csr_row_ptr_A::Ptr{rocsparse_int},
                                                                    csr_col_ind_A::Ptr{rocsparse_int},
                                                                    threshold::Ptr{Cfloat},
                                                                    csr_descr_C::rocsparse_mat_descr,
                                                                    csr_val_C::Ptr{Cfloat},
                                                                    csr_row_ptr_C::Ptr{rocsparse_int},
                                                                    csr_col_ind_C::Ptr{rocsparse_int},
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dprune_csr2csr_buffer_size(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                              csr_row_ptr_A, csr_col_ind_A, threshold,
                                              csr_descr_C, csr_val_C, csr_row_ptr_C,
                                              csr_col_ind_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    nnz_A::rocsparse_int,
                                                                    csr_descr_A::rocsparse_mat_descr,
                                                                    csr_val_A::Ptr{Cdouble},
                                                                    csr_row_ptr_A::Ptr{rocsparse_int},
                                                                    csr_col_ind_A::Ptr{rocsparse_int},
                                                                    threshold::Ptr{Cdouble},
                                                                    csr_descr_C::rocsparse_mat_descr,
                                                                    csr_val_C::Ptr{Cdouble},
                                                                    csr_row_ptr_C::Ptr{rocsparse_int},
                                                                    csr_col_ind_C::Ptr{rocsparse_int},
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sprune_csr2csr_nnz(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                      csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C,
                                      csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr_nnz(handle::rocsparse_handle,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz_A::rocsparse_int,
                                                            csr_descr_A::rocsparse_mat_descr,
                                                            csr_val_A::Ptr{Cfloat},
                                                            csr_row_ptr_A::Ptr{rocsparse_int},
                                                            csr_col_ind_A::Ptr{rocsparse_int},
                                                            threshold::Ptr{Cfloat},
                                                            csr_descr_C::rocsparse_mat_descr,
                                                            csr_row_ptr_C::Ptr{rocsparse_int},
                                                            nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                            temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_csr2csr_nnz(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                      csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C,
                                      csr_row_ptr_C, nnz_total_dev_host_ptr, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr_nnz(handle::rocsparse_handle,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz_A::rocsparse_int,
                                                            csr_descr_A::rocsparse_mat_descr,
                                                            csr_val_A::Ptr{Cdouble},
                                                            csr_row_ptr_A::Ptr{rocsparse_int},
                                                            csr_col_ind_A::Ptr{rocsparse_int},
                                                            threshold::Ptr{Cdouble},
                                                            csr_descr_C::rocsparse_mat_descr,
                                                            csr_row_ptr_C::Ptr{rocsparse_int},
                                                            nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                            temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_csr2csr(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                  csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C,
                                  csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        nnz_A::rocsparse_int,
                                                        csr_descr_A::rocsparse_mat_descr,
                                                        csr_val_A::Ptr{Cfloat},
                                                        csr_row_ptr_A::Ptr{rocsparse_int},
                                                        csr_col_ind_A::Ptr{rocsparse_int},
                                                        threshold::Ptr{Cfloat},
                                                        csr_descr_C::rocsparse_mat_descr,
                                                        csr_val_C::Ptr{Cfloat},
                                                        csr_row_ptr_C::Ptr{rocsparse_int},
                                                        csr_col_ind_C::Ptr{rocsparse_int},
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_csr2csr(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                  csr_row_ptr_A, csr_col_ind_A, threshold, csr_descr_C,
                                  csr_val_C, csr_row_ptr_C, csr_col_ind_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        nnz_A::rocsparse_int,
                                                        csr_descr_A::rocsparse_mat_descr,
                                                        csr_val_A::Ptr{Cdouble},
                                                        csr_row_ptr_A::Ptr{rocsparse_int},
                                                        csr_col_ind_A::Ptr{rocsparse_int},
                                                        threshold::Ptr{Cdouble},
                                                        csr_descr_C::rocsparse_mat_descr,
                                                        csr_val_C::Ptr{Cdouble},
                                                        csr_row_ptr_C::Ptr{rocsparse_int},
                                                        csr_col_ind_C::Ptr{rocsparse_int},
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_csr2csr_by_percentage_buffer_size(handle, m, n, nnz_A,
                                                            csr_descr_A, csr_val_A,
                                                            csr_row_ptr_A, csr_col_ind_A,
                                                            percentage, csr_descr_C,
                                                            csr_val_C, csr_row_ptr_C,
                                                            csr_col_ind_C, info,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr_by_percentage_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  n::rocsparse_int,
                                                                                  nnz_A::rocsparse_int,
                                                                                  csr_descr_A::rocsparse_mat_descr,
                                                                                  csr_val_A::Ptr{Cfloat},
                                                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                                                  percentage::Cfloat,
                                                                                  csr_descr_C::rocsparse_mat_descr,
                                                                                  csr_val_C::Ptr{Cfloat},
                                                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                                                  info::rocsparse_mat_info,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dprune_csr2csr_by_percentage_buffer_size(handle, m, n, nnz_A,
                                                            csr_descr_A, csr_val_A,
                                                            csr_row_ptr_A, csr_col_ind_A,
                                                            percentage, csr_descr_C,
                                                            csr_val_C, csr_row_ptr_C,
                                                            csr_col_ind_C, info,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr_by_percentage_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  n::rocsparse_int,
                                                                                  nnz_A::rocsparse_int,
                                                                                  csr_descr_A::rocsparse_mat_descr,
                                                                                  csr_val_A::Ptr{Cdouble},
                                                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                                                  percentage::Cdouble,
                                                                                  csr_descr_C::rocsparse_mat_descr,
                                                                                  csr_val_C::Ptr{Cdouble},
                                                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                                                  info::rocsparse_mat_info,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sprune_csr2csr_nnz_by_percentage(handle, m, n, nnz_A, csr_descr_A,
                                                    csr_val_A, csr_row_ptr_A, csr_col_ind_A,
                                                    percentage, csr_descr_C, csr_row_ptr_C,
                                                    nnz_total_dev_host_ptr, info,
                                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr_nnz_by_percentage(handle::rocsparse_handle,
                                                                          m::rocsparse_int,
                                                                          n::rocsparse_int,
                                                                          nnz_A::rocsparse_int,
                                                                          csr_descr_A::rocsparse_mat_descr,
                                                                          csr_val_A::Ptr{Cfloat},
                                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                                          percentage::Cfloat,
                                                                          csr_descr_C::rocsparse_mat_descr,
                                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                                          nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                                          info::rocsparse_mat_info,
                                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_csr2csr_nnz_by_percentage(handle, m, n, nnz_A, csr_descr_A,
                                                    csr_val_A, csr_row_ptr_A, csr_col_ind_A,
                                                    percentage, csr_descr_C, csr_row_ptr_C,
                                                    nnz_total_dev_host_ptr, info,
                                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr_nnz_by_percentage(handle::rocsparse_handle,
                                                                          m::rocsparse_int,
                                                                          n::rocsparse_int,
                                                                          nnz_A::rocsparse_int,
                                                                          csr_descr_A::rocsparse_mat_descr,
                                                                          csr_val_A::Ptr{Cdouble},
                                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                                          percentage::Cdouble,
                                                                          csr_descr_C::rocsparse_mat_descr,
                                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                                          nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                                          info::rocsparse_mat_info,
                                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_csr2csr_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                                csr_row_ptr_A, csr_col_ind_A, percentage,
                                                csr_descr_C, csr_val_C, csr_row_ptr_C,
                                                csr_col_ind_C, info, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_csr2csr_by_percentage(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      n::rocsparse_int,
                                                                      nnz_A::rocsparse_int,
                                                                      csr_descr_A::rocsparse_mat_descr,
                                                                      csr_val_A::Ptr{Cfloat},
                                                                      csr_row_ptr_A::Ptr{rocsparse_int},
                                                                      csr_col_ind_A::Ptr{rocsparse_int},
                                                                      percentage::Cfloat,
                                                                      csr_descr_C::rocsparse_mat_descr,
                                                                      csr_val_C::Ptr{Cfloat},
                                                                      csr_row_ptr_C::Ptr{rocsparse_int},
                                                                      csr_col_ind_C::Ptr{rocsparse_int},
                                                                      info::rocsparse_mat_info,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_csr2csr_by_percentage(handle, m, n, nnz_A, csr_descr_A, csr_val_A,
                                                csr_row_ptr_A, csr_col_ind_A, percentage,
                                                csr_descr_C, csr_val_C, csr_row_ptr_C,
                                                csr_col_ind_C, info, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_csr2csr_by_percentage(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      n::rocsparse_int,
                                                                      nnz_A::rocsparse_int,
                                                                      csr_descr_A::rocsparse_mat_descr,
                                                                      csr_val_A::Ptr{Cdouble},
                                                                      csr_row_ptr_A::Ptr{rocsparse_int},
                                                                      csr_col_ind_A::Ptr{rocsparse_int},
                                                                      percentage::Cdouble,
                                                                      csr_descr_C::rocsparse_mat_descr,
                                                                      csr_val_C::Ptr{Cdouble},
                                                                      csr_row_ptr_C::Ptr{rocsparse_int},
                                                                      csr_col_ind_C::Ptr{rocsparse_int},
                                                                      info::rocsparse_mat_info,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_dense2csr_buffer_size(handle, m, n, A, lda, threshold, descr,
                                                csr_val, csr_row_ptr, csr_col_ind,
                                                buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr_buffer_size(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      n::rocsparse_int,
                                                                      A::Ptr{Cfloat},
                                                                      lda::rocsparse_int,
                                                                      threshold::Ptr{Cfloat},
                                                                      descr::rocsparse_mat_descr,
                                                                      csr_val::Ptr{Cfloat},
                                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                                      csr_col_ind::Ptr{rocsparse_int},
                                                                      buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dprune_dense2csr_buffer_size(handle, m, n, A, lda, threshold, descr,
                                                csr_val, csr_row_ptr, csr_col_ind,
                                                buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr_buffer_size(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      n::rocsparse_int,
                                                                      A::Ptr{Cdouble},
                                                                      lda::rocsparse_int,
                                                                      threshold::Ptr{Cdouble},
                                                                      descr::rocsparse_mat_descr,
                                                                      csr_val::Ptr{Cdouble},
                                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                                      csr_col_ind::Ptr{rocsparse_int},
                                                                      buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sprune_dense2csr_nnz(handle, m, n, A, lda, threshold, descr, csr_row_ptr,
                                        nnz_total_dev_host_ptr, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr_nnz(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              A::Ptr{Cfloat},
                                                              lda::rocsparse_int,
                                                              threshold::Ptr{Cfloat},
                                                              descr::rocsparse_mat_descr,
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_dense2csr_nnz(handle, m, n, A, lda, threshold, descr, csr_row_ptr,
                                        nnz_total_dev_host_ptr, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr_nnz(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              A::Ptr{Cdouble},
                                                              lda::rocsparse_int,
                                                              threshold::Ptr{Cdouble},
                                                              descr::rocsparse_mat_descr,
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_dense2csr(handle, m, n, A, lda, threshold, descr, csr_val,
                                    csr_row_ptr, csr_col_ind, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int, A::Ptr{Cfloat},
                                                          lda::rocsparse_int,
                                                          threshold::Ptr{Cfloat},
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{Cfloat},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_dense2csr(handle, m, n, A, lda, threshold, descr, csr_val,
                                    csr_row_ptr, csr_col_ind, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int, A::Ptr{Cdouble},
                                                          lda::rocsparse_int,
                                                          threshold::Ptr{Cdouble},
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{Cdouble},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_dense2csr_by_percentage_buffer_size(handle, m, n, A, lda,
                                                              percentage, descr, csr_val,
                                                              csr_row_ptr, csr_col_ind,
                                                              info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr_by_percentage_buffer_size(handle::rocsparse_handle,
                                                                                    m::rocsparse_int,
                                                                                    n::rocsparse_int,
                                                                                    A::Ptr{Cfloat},
                                                                                    lda::rocsparse_int,
                                                                                    percentage::Cfloat,
                                                                                    descr::rocsparse_mat_descr,
                                                                                    csr_val::Ptr{Cfloat},
                                                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                                                    csr_col_ind::Ptr{rocsparse_int},
                                                                                    info::rocsparse_mat_info,
                                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dprune_dense2csr_by_percentage_buffer_size(handle, m, n, A, lda,
                                                              percentage, descr, csr_val,
                                                              csr_row_ptr, csr_col_ind,
                                                              info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr_by_percentage_buffer_size(handle::rocsparse_handle,
                                                                                    m::rocsparse_int,
                                                                                    n::rocsparse_int,
                                                                                    A::Ptr{Cdouble},
                                                                                    lda::rocsparse_int,
                                                                                    percentage::Cdouble,
                                                                                    descr::rocsparse_mat_descr,
                                                                                    csr_val::Ptr{Cdouble},
                                                                                    csr_row_ptr::Ptr{rocsparse_int},
                                                                                    csr_col_ind::Ptr{rocsparse_int},
                                                                                    info::rocsparse_mat_info,
                                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sprune_dense2csr_nnz_by_percentage(handle, m, n, A, lda, percentage,
                                                      descr, csr_row_ptr,
                                                      nnz_total_dev_host_ptr, info,
                                                      temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr_nnz_by_percentage(handle::rocsparse_handle,
                                                                            m::rocsparse_int,
                                                                            n::rocsparse_int,
                                                                            A::Ptr{Cfloat},
                                                                            lda::rocsparse_int,
                                                                            percentage::Cfloat,
                                                                            descr::rocsparse_mat_descr,
                                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                                            nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                                            info::rocsparse_mat_info,
                                                                            temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_dense2csr_nnz_by_percentage(handle, m, n, A, lda, percentage,
                                                      descr, csr_row_ptr,
                                                      nnz_total_dev_host_ptr, info,
                                                      temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr_nnz_by_percentage(handle::rocsparse_handle,
                                                                            m::rocsparse_int,
                                                                            n::rocsparse_int,
                                                                            A::Ptr{Cdouble},
                                                                            lda::rocsparse_int,
                                                                            percentage::Cdouble,
                                                                            descr::rocsparse_mat_descr,
                                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                                            nnz_total_dev_host_ptr::Ptr{rocsparse_int},
                                                                            info::rocsparse_mat_info,
                                                                            temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sprune_dense2csr_by_percentage(handle, m, n, A, lda, percentage, descr,
                                                  csr_val, csr_row_ptr, csr_col_ind, info,
                                                  temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sprune_dense2csr_by_percentage(handle::rocsparse_handle,
                                                                        m::rocsparse_int,
                                                                        n::rocsparse_int,
                                                                        A::Ptr{Cfloat},
                                                                        lda::rocsparse_int,
                                                                        percentage::Cfloat,
                                                                        descr::rocsparse_mat_descr,
                                                                        csr_val::Ptr{Cfloat},
                                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                                        csr_col_ind::Ptr{rocsparse_int},
                                                                        info::rocsparse_mat_info,
                                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dprune_dense2csr_by_percentage(handle, m, n, A, lda, percentage, descr,
                                                  csr_val, csr_row_ptr, csr_col_ind, info,
                                                  temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dprune_dense2csr_by_percentage(handle::rocsparse_handle,
                                                                        m::rocsparse_int,
                                                                        n::rocsparse_int,
                                                                        A::Ptr{Cdouble},
                                                                        lda::rocsparse_int,
                                                                        percentage::Cdouble,
                                                                        descr::rocsparse_mat_descr,
                                                                        csr_val::Ptr{Cdouble},
                                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                                        csr_col_ind::Ptr{rocsparse_int},
                                                                        info::rocsparse_mat_info,
                                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsrgeam_nnzb(handle, dir, mb, nb, block_dim, descr_A, nnzb_A,
                                bsr_row_ptr_A, bsr_col_ind_A, descr_B, nnzb_B,
                                bsr_row_ptr_B, bsr_col_ind_B, descr_C, bsr_row_ptr_C,
                                nnzb_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrgeam_nnzb(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      block_dim::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      nnzb_A::rocsparse_int,
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      descr_B::rocsparse_mat_descr,
                                                      nnzb_B::rocsparse_int,
                                                      bsr_row_ptr_B::Ptr{rocsparse_int},
                                                      bsr_col_ind_B::Ptr{rocsparse_int},
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      nnzb_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsrgeam(handle, dir, mb, nb, block_dim, alpha, descr_A, nnzb_A,
                            bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, beta, descr_B, nnzb_B,
                            bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, descr_C, bsr_val_C,
                            bsr_row_ptr_C, bsr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrgeam(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{Cfloat},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{Cfloat},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{Cfloat},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{Cfloat},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{Cfloat},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dbsrgeam(handle, dir, mb, nb, block_dim, alpha, descr_A, nnzb_A,
                            bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, beta, descr_B, nnzb_B,
                            bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, descr_C, bsr_val_C,
                            bsr_row_ptr_C, bsr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrgeam(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{Cdouble},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{Cdouble},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{Cdouble},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{Cdouble},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{Cdouble},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_cbsrgeam(handle, dir, mb, nb, block_dim, alpha, descr_A, nnzb_A,
                            bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, beta, descr_B, nnzb_B,
                            bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, descr_C, bsr_val_C,
                            bsr_row_ptr_C, bsr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrgeam(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_float_complex},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zbsrgeam(handle, dir, mb, nb, block_dim, alpha, descr_A, nnzb_A,
                            bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A, beta, descr_B, nnzb_B,
                            bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, descr_C, bsr_val_C,
                            bsr_row_ptr_C, bsr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrgeam(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_double_complex},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

@cenum rocsparse_operation_::UInt32 begin
    rocsparse_operation_none = 111
    rocsparse_operation_transpose = 112
    rocsparse_operation_conjugate_transpose = 113
end

const rocsparse_operation = rocsparse_operation_

function rocsparse_sbsrgemm_buffer_size(handle, dir, trans_A, trans_B, mb, nb, kb,
                                        block_dim, alpha, descr_A, nnzb_A, bsr_row_ptr_A,
                                        bsr_col_ind_A, descr_B, nnzb_B, bsr_row_ptr_B,
                                        bsr_col_ind_B, beta, descr_D, nnzb_D, bsr_row_ptr_D,
                                        bsr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrgemm_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              mb::rocsparse_int,
                                                              nb::rocsparse_int,
                                                              kb::rocsparse_int,
                                                              block_dim::rocsparse_int,
                                                              alpha::Ptr{Cfloat},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnzb_A::rocsparse_int,
                                                              bsr_row_ptr_A::Ptr{rocsparse_int},
                                                              bsr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnzb_B::rocsparse_int,
                                                              bsr_row_ptr_B::Ptr{rocsparse_int},
                                                              bsr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{Cfloat},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnzb_D::rocsparse_int,
                                                              bsr_row_ptr_D::Ptr{rocsparse_int},
                                                              bsr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dbsrgemm_buffer_size(handle, dir, trans_A, trans_B, mb, nb, kb,
                                        block_dim, alpha, descr_A, nnzb_A, bsr_row_ptr_A,
                                        bsr_col_ind_A, descr_B, nnzb_B, bsr_row_ptr_B,
                                        bsr_col_ind_B, beta, descr_D, nnzb_D, bsr_row_ptr_D,
                                        bsr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrgemm_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              mb::rocsparse_int,
                                                              nb::rocsparse_int,
                                                              kb::rocsparse_int,
                                                              block_dim::rocsparse_int,
                                                              alpha::Ptr{Cdouble},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnzb_A::rocsparse_int,
                                                              bsr_row_ptr_A::Ptr{rocsparse_int},
                                                              bsr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnzb_B::rocsparse_int,
                                                              bsr_row_ptr_B::Ptr{rocsparse_int},
                                                              bsr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{Cdouble},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnzb_D::rocsparse_int,
                                                              bsr_row_ptr_D::Ptr{rocsparse_int},
                                                              bsr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cbsrgemm_buffer_size(handle, dir, trans_A, trans_B, mb, nb, kb,
                                        block_dim, alpha, descr_A, nnzb_A, bsr_row_ptr_A,
                                        bsr_col_ind_A, descr_B, nnzb_B, bsr_row_ptr_B,
                                        bsr_col_ind_B, beta, descr_D, nnzb_D, bsr_row_ptr_D,
                                        bsr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrgemm_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              mb::rocsparse_int,
                                                              nb::rocsparse_int,
                                                              kb::rocsparse_int,
                                                              block_dim::rocsparse_int,
                                                              alpha::Ptr{rocsparse_float_complex},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnzb_A::rocsparse_int,
                                                              bsr_row_ptr_A::Ptr{rocsparse_int},
                                                              bsr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnzb_B::rocsparse_int,
                                                              bsr_row_ptr_B::Ptr{rocsparse_int},
                                                              bsr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{rocsparse_float_complex},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnzb_D::rocsparse_int,
                                                              bsr_row_ptr_D::Ptr{rocsparse_int},
                                                              bsr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zbsrgemm_buffer_size(handle, dir, trans_A, trans_B, mb, nb, kb,
                                        block_dim, alpha, descr_A, nnzb_A, bsr_row_ptr_A,
                                        bsr_col_ind_A, descr_B, nnzb_B, bsr_row_ptr_B,
                                        bsr_col_ind_B, beta, descr_D, nnzb_D, bsr_row_ptr_D,
                                        bsr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrgemm_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              mb::rocsparse_int,
                                                              nb::rocsparse_int,
                                                              kb::rocsparse_int,
                                                              block_dim::rocsparse_int,
                                                              alpha::Ptr{rocsparse_double_complex},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnzb_A::rocsparse_int,
                                                              bsr_row_ptr_A::Ptr{rocsparse_int},
                                                              bsr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnzb_B::rocsparse_int,
                                                              bsr_row_ptr_B::Ptr{rocsparse_int},
                                                              bsr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{rocsparse_double_complex},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnzb_D::rocsparse_int,
                                                              bsr_row_ptr_D::Ptr{rocsparse_int},
                                                              bsr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_bsrgemm_nnzb(handle, dir, trans_A, trans_B, mb, nb, kb, block_dim,
                                descr_A, nnzb_A, bsr_row_ptr_A, bsr_col_ind_A, descr_B,
                                nnzb_B, bsr_row_ptr_B, bsr_col_ind_B, descr_D, nnzb_D,
                                bsr_row_ptr_D, bsr_col_ind_D, descr_C, bsr_row_ptr_C,
                                nnzb_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrgemm_nnzb(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans_A::rocsparse_operation,
                                                      trans_B::rocsparse_operation,
                                                      mb::rocsparse_int, nb::rocsparse_int,
                                                      kb::rocsparse_int,
                                                      block_dim::rocsparse_int,
                                                      descr_A::rocsparse_mat_descr,
                                                      nnzb_A::rocsparse_int,
                                                      bsr_row_ptr_A::Ptr{rocsparse_int},
                                                      bsr_col_ind_A::Ptr{rocsparse_int},
                                                      descr_B::rocsparse_mat_descr,
                                                      nnzb_B::rocsparse_int,
                                                      bsr_row_ptr_B::Ptr{rocsparse_int},
                                                      bsr_col_ind_B::Ptr{rocsparse_int},
                                                      descr_D::rocsparse_mat_descr,
                                                      nnzb_D::rocsparse_int,
                                                      bsr_row_ptr_D::Ptr{rocsparse_int},
                                                      bsr_col_ind_D::Ptr{rocsparse_int},
                                                      descr_C::rocsparse_mat_descr,
                                                      bsr_row_ptr_C::Ptr{rocsparse_int},
                                                      nnzb_C::Ptr{rocsparse_int},
                                                      info_C::rocsparse_mat_info,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sbsrgemm(handle, dir, trans_A, trans_B, mb, nb, kb, block_dim, alpha,
                            descr_A, nnzb_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A,
                            descr_B, nnzb_B, bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, beta,
                            descr_D, nnzb_D, bsr_val_D, bsr_row_ptr_D, bsr_col_ind_D,
                            descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, info_C,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrgemm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  kb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{Cfloat},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{Cfloat},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{Cfloat},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{Cfloat},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnzb_D::rocsparse_int,
                                                  bsr_val_D::Ptr{Cfloat},
                                                  bsr_row_ptr_D::Ptr{rocsparse_int},
                                                  bsr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{Cfloat},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrgemm(handle, dir, trans_A, trans_B, mb, nb, kb, block_dim, alpha,
                            descr_A, nnzb_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A,
                            descr_B, nnzb_B, bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, beta,
                            descr_D, nnzb_D, bsr_val_D, bsr_row_ptr_D, bsr_col_ind_D,
                            descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, info_C,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrgemm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  kb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{Cdouble},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{Cdouble},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{Cdouble},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{Cdouble},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnzb_D::rocsparse_int,
                                                  bsr_val_D::Ptr{Cdouble},
                                                  bsr_row_ptr_D::Ptr{rocsparse_int},
                                                  bsr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{Cdouble},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrgemm(handle, dir, trans_A, trans_B, mb, nb, kb, block_dim, alpha,
                            descr_A, nnzb_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A,
                            descr_B, nnzb_B, bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, beta,
                            descr_D, nnzb_D, bsr_val_D, bsr_row_ptr_D, bsr_col_ind_D,
                            descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, info_C,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrgemm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  kb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_float_complex},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnzb_D::rocsparse_int,
                                                  bsr_val_D::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_D::Ptr{rocsparse_int},
                                                  bsr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrgemm(handle, dir, trans_A, trans_B, mb, nb, kb, block_dim, alpha,
                            descr_A, nnzb_A, bsr_val_A, bsr_row_ptr_A, bsr_col_ind_A,
                            descr_B, nnzb_B, bsr_val_B, bsr_row_ptr_B, bsr_col_ind_B, beta,
                            descr_D, nnzb_D, bsr_val_D, bsr_row_ptr_D, bsr_col_ind_D,
                            descr_C, bsr_val_C, bsr_row_ptr_C, bsr_col_ind_C, info_C,
                            temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrgemm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  kb::rocsparse_int,
                                                  block_dim::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnzb_A::rocsparse_int,
                                                  bsr_val_A::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_A::Ptr{rocsparse_int},
                                                  bsr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnzb_B::rocsparse_int,
                                                  bsr_val_B::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_B::Ptr{rocsparse_int},
                                                  bsr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_double_complex},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnzb_D::rocsparse_int,
                                                  bsr_val_D::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_D::Ptr{rocsparse_int},
                                                  bsr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  bsr_val_C::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr_C::Ptr{rocsparse_int},
                                                  bsr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrgeam_nnz(handle, m, n, descr_A, nnz_A, csr_row_ptr_A, csr_col_ind_A,
                               descr_B, nnz_B, csr_row_ptr_B, csr_col_ind_B, descr_C,
                               csr_row_ptr_C, nnz_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrgeam_nnz(handle::rocsparse_handle,
                                                     m::rocsparse_int, n::rocsparse_int,
                                                     descr_A::rocsparse_mat_descr,
                                                     nnz_A::rocsparse_int,
                                                     csr_row_ptr_A::Ptr{rocsparse_int},
                                                     csr_col_ind_A::Ptr{rocsparse_int},
                                                     descr_B::rocsparse_mat_descr,
                                                     nnz_B::rocsparse_int,
                                                     csr_row_ptr_B::Ptr{rocsparse_int},
                                                     csr_col_ind_B::Ptr{rocsparse_int},
                                                     descr_C::rocsparse_mat_descr,
                                                     csr_row_ptr_C::Ptr{rocsparse_int},
                                                     nnz_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A,
                            csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B,
                            csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrgeam(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  alpha::Ptr{Cfloat},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{Cfloat},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{Cfloat},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{Cfloat},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{Cfloat},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_dcsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A,
                            csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B,
                            csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrgeam(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  alpha::Ptr{Cdouble},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{Cdouble},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{Cdouble},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{Cdouble},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{Cdouble},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_ccsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A,
                            csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B,
                            csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrgeam(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_float_complex},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_zcsrgeam(handle, m, n, alpha, descr_A, nnz_A, csr_val_A, csr_row_ptr_A,
                            csr_col_ind_A, beta, descr_B, nnz_B, csr_val_B, csr_row_ptr_B,
                            csr_col_ind_B, descr_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrgeam(handle::rocsparse_handle,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_double_complex},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                        nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                                        csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                                        csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrgemm_buffer_size(handle::rocsparse_handle,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              k::rocsparse_int,
                                                              alpha::Ptr{Cfloat},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnz_A::rocsparse_int,
                                                              csr_row_ptr_A::Ptr{rocsparse_int},
                                                              csr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnz_B::rocsparse_int,
                                                              csr_row_ptr_B::Ptr{rocsparse_int},
                                                              csr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{Cfloat},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnz_D::rocsparse_int,
                                                              csr_row_ptr_D::Ptr{rocsparse_int},
                                                              csr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                        nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                                        csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                                        csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrgemm_buffer_size(handle::rocsparse_handle,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              k::rocsparse_int,
                                                              alpha::Ptr{Cdouble},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnz_A::rocsparse_int,
                                                              csr_row_ptr_A::Ptr{rocsparse_int},
                                                              csr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnz_B::rocsparse_int,
                                                              csr_row_ptr_B::Ptr{rocsparse_int},
                                                              csr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{Cdouble},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnz_D::rocsparse_int,
                                                              csr_row_ptr_D::Ptr{rocsparse_int},
                                                              csr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                        nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                                        csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                                        csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrgemm_buffer_size(handle::rocsparse_handle,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              k::rocsparse_int,
                                                              alpha::Ptr{rocsparse_float_complex},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnz_A::rocsparse_int,
                                                              csr_row_ptr_A::Ptr{rocsparse_int},
                                                              csr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnz_B::rocsparse_int,
                                                              csr_row_ptr_B::Ptr{rocsparse_int},
                                                              csr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{rocsparse_float_complex},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnz_D::rocsparse_int,
                                                              csr_row_ptr_D::Ptr{rocsparse_int},
                                                              csr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsrgemm_buffer_size(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                        nnz_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                                        csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                                        csr_row_ptr_D, csr_col_ind_D, info_C, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrgemm_buffer_size(handle::rocsparse_handle,
                                                              trans_A::rocsparse_operation,
                                                              trans_B::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              n::rocsparse_int,
                                                              k::rocsparse_int,
                                                              alpha::Ptr{rocsparse_double_complex},
                                                              descr_A::rocsparse_mat_descr,
                                                              nnz_A::rocsparse_int,
                                                              csr_row_ptr_A::Ptr{rocsparse_int},
                                                              csr_col_ind_A::Ptr{rocsparse_int},
                                                              descr_B::rocsparse_mat_descr,
                                                              nnz_B::rocsparse_int,
                                                              csr_row_ptr_B::Ptr{rocsparse_int},
                                                              csr_col_ind_B::Ptr{rocsparse_int},
                                                              beta::Ptr{rocsparse_double_complex},
                                                              descr_D::rocsparse_mat_descr,
                                                              nnz_D::rocsparse_int,
                                                              csr_row_ptr_D::Ptr{rocsparse_int},
                                                              csr_col_ind_D::Ptr{rocsparse_int},
                                                              info_C::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_csrgemm_nnz(handle, trans_A, trans_B, m, n, k, descr_A, nnz_A,
                               csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B, csr_row_ptr_B,
                               csr_col_ind_B, descr_D, nnz_D, csr_row_ptr_D, csr_col_ind_D,
                               descr_C, csr_row_ptr_C, nnz_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrgemm_nnz(handle::rocsparse_handle,
                                                     trans_A::rocsparse_operation,
                                                     trans_B::rocsparse_operation,
                                                     m::rocsparse_int, n::rocsparse_int,
                                                     k::rocsparse_int,
                                                     descr_A::rocsparse_mat_descr,
                                                     nnz_A::rocsparse_int,
                                                     csr_row_ptr_A::Ptr{rocsparse_int},
                                                     csr_col_ind_A::Ptr{rocsparse_int},
                                                     descr_B::rocsparse_mat_descr,
                                                     nnz_B::rocsparse_int,
                                                     csr_row_ptr_B::Ptr{rocsparse_int},
                                                     csr_col_ind_B::Ptr{rocsparse_int},
                                                     descr_D::rocsparse_mat_descr,
                                                     nnz_D::rocsparse_int,
                                                     csr_row_ptr_D::Ptr{rocsparse_int},
                                                     csr_col_ind_D::Ptr{rocsparse_int},
                                                     descr_C::rocsparse_mat_descr,
                                                     csr_row_ptr_C::Ptr{rocsparse_int},
                                                     nnz_C::Ptr{rocsparse_int},
                                                     info_C::rocsparse_mat_info,
                                                     temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A,
                            csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                            csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                            csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C,
                            csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrgemm(handle::rocsparse_handle,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  k::rocsparse_int, alpha::Ptr{Cfloat},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{Cfloat},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{Cfloat},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{Cfloat},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnz_D::rocsparse_int,
                                                  csr_val_D::Ptr{Cfloat},
                                                  csr_row_ptr_D::Ptr{rocsparse_int},
                                                  csr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{Cfloat},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A,
                            csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                            csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                            csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C,
                            csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrgemm(handle::rocsparse_handle,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  k::rocsparse_int, alpha::Ptr{Cdouble},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{Cdouble},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{Cdouble},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{Cdouble},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnz_D::rocsparse_int,
                                                  csr_val_D::Ptr{Cdouble},
                                                  csr_row_ptr_D::Ptr{rocsparse_int},
                                                  csr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{Cdouble},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A,
                            csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                            csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                            csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C,
                            csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrgemm(handle::rocsparse_handle,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  k::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_float_complex},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnz_D::rocsparse_int,
                                                  csr_val_D::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_D::Ptr{rocsparse_int},
                                                  csr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrgemm(handle, trans_A, trans_B, m, n, k, alpha, descr_A, nnz_A,
                            csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                            csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta, descr_D, nnz_D,
                            csr_val_D, csr_row_ptr_D, csr_col_ind_D, descr_C, csr_val_C,
                            csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrgemm(handle::rocsparse_handle,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  m::rocsparse_int, n::rocsparse_int,
                                                  k::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr_A::rocsparse_mat_descr,
                                                  nnz_A::rocsparse_int,
                                                  csr_val_A::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_A::Ptr{rocsparse_int},
                                                  csr_col_ind_A::Ptr{rocsparse_int},
                                                  descr_B::rocsparse_mat_descr,
                                                  nnz_B::rocsparse_int,
                                                  csr_val_B::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_B::Ptr{rocsparse_int},
                                                  csr_col_ind_B::Ptr{rocsparse_int},
                                                  beta::Ptr{rocsparse_double_complex},
                                                  descr_D::rocsparse_mat_descr,
                                                  nnz_D::rocsparse_int,
                                                  csr_val_D::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_D::Ptr{rocsparse_int},
                                                  csr_col_ind_D::Ptr{rocsparse_int},
                                                  descr_C::rocsparse_mat_descr,
                                                  csr_val_C::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr_C::Ptr{rocsparse_int},
                                                  csr_col_ind_C::Ptr{rocsparse_int},
                                                  info_C::rocsparse_mat_info,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrgemm_symbolic(handle, trans_A, trans_B, m, n, k, descr_A, nnz_A,
                                    csr_row_ptr_A, csr_col_ind_A, descr_B, nnz_B,
                                    csr_row_ptr_B, csr_col_ind_B, descr_D, nnz_D,
                                    csr_row_ptr_D, csr_col_ind_D, descr_C, nnz_C,
                                    csr_row_ptr_C, csr_col_ind_C, info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrgemm_symbolic(handle::rocsparse_handle,
                                                          trans_A::rocsparse_operation,
                                                          trans_B::rocsparse_operation,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int,
                                                          k::rocsparse_int,
                                                          descr_A::rocsparse_mat_descr,
                                                          nnz_A::rocsparse_int,
                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                          descr_B::rocsparse_mat_descr,
                                                          nnz_B::rocsparse_int,
                                                          csr_row_ptr_B::Ptr{rocsparse_int},
                                                          csr_col_ind_B::Ptr{rocsparse_int},
                                                          descr_D::rocsparse_mat_descr,
                                                          nnz_D::rocsparse_int,
                                                          csr_row_ptr_D::Ptr{rocsparse_int},
                                                          csr_col_ind_D::Ptr{rocsparse_int},
                                                          descr_C::rocsparse_mat_descr,
                                                          nnz_C::rocsparse_int,
                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                          csr_col_ind_C::Ptr{rocsparse_int},
                                                          info_C::rocsparse_mat_info,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                    nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B,
                                    nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta,
                                    descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D,
                                    descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C,
                                    info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrgemm_numeric(handle::rocsparse_handle,
                                                          trans_A::rocsparse_operation,
                                                          trans_B::rocsparse_operation,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int,
                                                          k::rocsparse_int,
                                                          alpha::Ptr{Cfloat},
                                                          descr_A::rocsparse_mat_descr,
                                                          nnz_A::rocsparse_int,
                                                          csr_val_A::Ptr{Cfloat},
                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                          descr_B::rocsparse_mat_descr,
                                                          nnz_B::rocsparse_int,
                                                          csr_val_B::Ptr{Cfloat},
                                                          csr_row_ptr_B::Ptr{rocsparse_int},
                                                          csr_col_ind_B::Ptr{rocsparse_int},
                                                          beta::Ptr{Cfloat},
                                                          descr_D::rocsparse_mat_descr,
                                                          nnz_D::rocsparse_int,
                                                          csr_val_D::Ptr{Cfloat},
                                                          csr_row_ptr_D::Ptr{rocsparse_int},
                                                          csr_col_ind_D::Ptr{rocsparse_int},
                                                          descr_C::rocsparse_mat_descr,
                                                          nnz_C::rocsparse_int,
                                                          csr_val_C::Ptr{Cfloat},
                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                          csr_col_ind_C::Ptr{rocsparse_int},
                                                          info_C::rocsparse_mat_info,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                    nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B,
                                    nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta,
                                    descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D,
                                    descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C,
                                    info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrgemm_numeric(handle::rocsparse_handle,
                                                          trans_A::rocsparse_operation,
                                                          trans_B::rocsparse_operation,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int,
                                                          k::rocsparse_int,
                                                          alpha::Ptr{Cdouble},
                                                          descr_A::rocsparse_mat_descr,
                                                          nnz_A::rocsparse_int,
                                                          csr_val_A::Ptr{Cdouble},
                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                          descr_B::rocsparse_mat_descr,
                                                          nnz_B::rocsparse_int,
                                                          csr_val_B::Ptr{Cdouble},
                                                          csr_row_ptr_B::Ptr{rocsparse_int},
                                                          csr_col_ind_B::Ptr{rocsparse_int},
                                                          beta::Ptr{Cdouble},
                                                          descr_D::rocsparse_mat_descr,
                                                          nnz_D::rocsparse_int,
                                                          csr_val_D::Ptr{Cdouble},
                                                          csr_row_ptr_D::Ptr{rocsparse_int},
                                                          csr_col_ind_D::Ptr{rocsparse_int},
                                                          descr_C::rocsparse_mat_descr,
                                                          nnz_C::rocsparse_int,
                                                          csr_val_C::Ptr{Cdouble},
                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                          csr_col_ind_C::Ptr{rocsparse_int},
                                                          info_C::rocsparse_mat_info,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                    nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B,
                                    nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta,
                                    descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D,
                                    descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C,
                                    info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrgemm_numeric(handle::rocsparse_handle,
                                                          trans_A::rocsparse_operation,
                                                          trans_B::rocsparse_operation,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int,
                                                          k::rocsparse_int,
                                                          alpha::Ptr{rocsparse_float_complex},
                                                          descr_A::rocsparse_mat_descr,
                                                          nnz_A::rocsparse_int,
                                                          csr_val_A::Ptr{rocsparse_float_complex},
                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                          descr_B::rocsparse_mat_descr,
                                                          nnz_B::rocsparse_int,
                                                          csr_val_B::Ptr{rocsparse_float_complex},
                                                          csr_row_ptr_B::Ptr{rocsparse_int},
                                                          csr_col_ind_B::Ptr{rocsparse_int},
                                                          beta::Ptr{rocsparse_float_complex},
                                                          descr_D::rocsparse_mat_descr,
                                                          nnz_D::rocsparse_int,
                                                          csr_val_D::Ptr{rocsparse_float_complex},
                                                          csr_row_ptr_D::Ptr{rocsparse_int},
                                                          csr_col_ind_D::Ptr{rocsparse_int},
                                                          descr_C::rocsparse_mat_descr,
                                                          nnz_C::rocsparse_int,
                                                          csr_val_C::Ptr{rocsparse_float_complex},
                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                          csr_col_ind_C::Ptr{rocsparse_int},
                                                          info_C::rocsparse_mat_info,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrgemm_numeric(handle, trans_A, trans_B, m, n, k, alpha, descr_A,
                                    nnz_A, csr_val_A, csr_row_ptr_A, csr_col_ind_A, descr_B,
                                    nnz_B, csr_val_B, csr_row_ptr_B, csr_col_ind_B, beta,
                                    descr_D, nnz_D, csr_val_D, csr_row_ptr_D, csr_col_ind_D,
                                    descr_C, nnz_C, csr_val_C, csr_row_ptr_C, csr_col_ind_C,
                                    info_C, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrgemm_numeric(handle::rocsparse_handle,
                                                          trans_A::rocsparse_operation,
                                                          trans_B::rocsparse_operation,
                                                          m::rocsparse_int,
                                                          n::rocsparse_int,
                                                          k::rocsparse_int,
                                                          alpha::Ptr{rocsparse_double_complex},
                                                          descr_A::rocsparse_mat_descr,
                                                          nnz_A::rocsparse_int,
                                                          csr_val_A::Ptr{rocsparse_double_complex},
                                                          csr_row_ptr_A::Ptr{rocsparse_int},
                                                          csr_col_ind_A::Ptr{rocsparse_int},
                                                          descr_B::rocsparse_mat_descr,
                                                          nnz_B::rocsparse_int,
                                                          csr_val_B::Ptr{rocsparse_double_complex},
                                                          csr_row_ptr_B::Ptr{rocsparse_int},
                                                          csr_col_ind_B::Ptr{rocsparse_int},
                                                          beta::Ptr{rocsparse_double_complex},
                                                          descr_D::rocsparse_mat_descr,
                                                          nnz_D::rocsparse_int,
                                                          csr_val_D::Ptr{rocsparse_double_complex},
                                                          csr_row_ptr_D::Ptr{rocsparse_int},
                                                          csr_col_ind_D::Ptr{rocsparse_int},
                                                          descr_C::rocsparse_mat_descr,
                                                          nnz_C::rocsparse_int,
                                                          csr_val_C::Ptr{rocsparse_double_complex},
                                                          csr_row_ptr_C::Ptr{rocsparse_int},
                                                          csr_col_ind_C::Ptr{rocsparse_int},
                                                          info_C::rocsparse_mat_info,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_axpby(handle, alpha, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_axpby(handle::rocsparse_handle, alpha::Ptr{Cvoid},
                                               x::rocsparse_const_spvec_descr,
                                               beta::Ptr{Cvoid},
                                               y::rocsparse_dnvec_descr)::rocsparse_status)
end

@cenum rocsparse_data_status_::UInt32 begin
    rocsparse_data_status_success = 0
    rocsparse_data_status_inf = 1
    rocsparse_data_status_nan = 2
    rocsparse_data_status_invalid_offset_ptr = 3
    rocsparse_data_status_invalid_index = 4
    rocsparse_data_status_duplicate_entry = 5
    rocsparse_data_status_invalid_sorting = 6
    rocsparse_data_status_invalid_fill = 7
end

const rocsparse_data_status = rocsparse_data_status_

@cenum rocsparse_check_spmat_stage_::UInt32 begin
    rocsparse_check_spmat_stage_buffer_size = 0
    rocsparse_check_spmat_stage_compute = 1
end

const rocsparse_check_spmat_stage = rocsparse_check_spmat_stage_

function rocsparse_check_spmat(handle, mat, data_status, stage, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_check_spmat(handle::rocsparse_handle,
                                                     mat::rocsparse_const_spmat_descr,
                                                     data_status::Ptr{rocsparse_data_status},
                                                     stage::rocsparse_check_spmat_stage,
                                                     buffer_size::Ptr{Csize_t},
                                                     temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_dense_to_sparse_alg_::UInt32 begin
    rocsparse_dense_to_sparse_alg_default = 0
end

const rocsparse_dense_to_sparse_alg = rocsparse_dense_to_sparse_alg_

function rocsparse_dense_to_sparse(handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dense_to_sparse(handle::rocsparse_handle,
                                                         mat_A::rocsparse_const_dnmat_descr,
                                                         mat_B::rocsparse_spmat_descr,
                                                         alg::rocsparse_dense_to_sparse_alg,
                                                         buffer_size::Ptr{Csize_t},
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_extract_stage_::UInt32 begin
    rocsparse_extract_stage_analysis = 0
    rocsparse_extract_stage_compute = 1
end

const rocsparse_extract_stage = rocsparse_extract_stage_

function rocsparse_extract_buffer_size(handle, descr, source, target, stage,
                                       buffer_size_in_bytes)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_extract_buffer_size(handle::rocsparse_handle,
                                                             descr::rocsparse_extract_descr,
                                                             source::rocsparse_const_spmat_descr,
                                                             target::rocsparse_spmat_descr,
                                                             stage::rocsparse_extract_stage,
                                                             buffer_size_in_bytes::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_extract_nnz(handle, descr, nnz)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_extract_nnz(handle::rocsparse_handle,
                                                     descr::rocsparse_extract_descr,
                                                     nnz::Ptr{Int64})::rocsparse_status)
end

function rocsparse_extract(handle, descr, source, target, stage, buffer_size_in_bytes,
                           buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_extract(handle::rocsparse_handle,
                                                 descr::rocsparse_extract_descr,
                                                 source::rocsparse_const_spmat_descr,
                                                 target::rocsparse_spmat_descr,
                                                 stage::rocsparse_extract_stage,
                                                 buffer_size_in_bytes::Csize_t,
                                                 buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_gather(handle, y, x)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_gather(handle::rocsparse_handle,
                                                y::rocsparse_const_dnvec_descr,
                                                x::rocsparse_spvec_descr)::rocsparse_status)
end

function rocsparse_rot(handle, c, s, x, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_rot(handle::rocsparse_handle, c::Ptr{Cvoid},
                                             s::Ptr{Cvoid}, x::rocsparse_spvec_descr,
                                             y::rocsparse_dnvec_descr)::rocsparse_status)
end

function rocsparse_scatter(handle, x, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scatter(handle::rocsparse_handle,
                                                 x::rocsparse_const_spvec_descr,
                                                 y::rocsparse_dnvec_descr)::rocsparse_status)
end

@cenum rocsparse_sddmm_alg_::UInt32 begin
    rocsparse_sddmm_alg_default = 0
    rocsparse_sddmm_alg_dense = 1
end

const rocsparse_sddmm_alg = rocsparse_sddmm_alg_

function rocsparse_sddmm_buffer_size(handle, opA, opB, alpha, mat_A, mat_B, beta, mat_C,
                                     compute_type, alg, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sddmm_buffer_size(handle::rocsparse_handle,
                                                           opA::rocsparse_operation,
                                                           opB::rocsparse_operation,
                                                           alpha::Ptr{Cvoid},
                                                           mat_A::rocsparse_const_dnmat_descr,
                                                           mat_B::rocsparse_const_dnmat_descr,
                                                           beta::Ptr{Cvoid},
                                                           mat_C::rocsparse_spmat_descr,
                                                           compute_type::rocsparse_datatype,
                                                           alg::rocsparse_sddmm_alg,
                                                           buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sddmm_preprocess(handle, opA, opB, alpha, mat_A, mat_B, beta, mat_C,
                                    compute_type, alg, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sddmm_preprocess(handle::rocsparse_handle,
                                                          opA::rocsparse_operation,
                                                          opB::rocsparse_operation,
                                                          alpha::Ptr{Cvoid},
                                                          mat_A::rocsparse_const_dnmat_descr,
                                                          mat_B::rocsparse_const_dnmat_descr,
                                                          beta::Ptr{Cvoid},
                                                          mat_C::rocsparse_spmat_descr,
                                                          compute_type::rocsparse_datatype,
                                                          alg::rocsparse_sddmm_alg,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sddmm(handle, opA, opB, alpha, mat_A, mat_B, beta, mat_C, compute_type,
                         alg, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sddmm(handle::rocsparse_handle,
                                               opA::rocsparse_operation,
                                               opB::rocsparse_operation, alpha::Ptr{Cvoid},
                                               mat_A::rocsparse_const_dnmat_descr,
                                               mat_B::rocsparse_const_dnmat_descr,
                                               beta::Ptr{Cvoid},
                                               mat_C::rocsparse_spmat_descr,
                                               compute_type::rocsparse_datatype,
                                               alg::rocsparse_sddmm_alg,
                                               temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_sparse_to_dense_alg_::UInt32 begin
    rocsparse_sparse_to_dense_alg_default = 0
end

const rocsparse_sparse_to_dense_alg = rocsparse_sparse_to_dense_alg_

function rocsparse_sparse_to_dense(handle, mat_A, mat_B, alg, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sparse_to_dense(handle::rocsparse_handle,
                                                         mat_A::rocsparse_const_spmat_descr,
                                                         mat_B::rocsparse_dnmat_descr,
                                                         alg::rocsparse_sparse_to_dense_alg,
                                                         buffer_size::Ptr{Csize_t},
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_sparse_to_sparse_stage_::UInt32 begin
    rocsparse_sparse_to_sparse_stage_analysis = 0
    rocsparse_sparse_to_sparse_stage_compute = 1
end

const rocsparse_sparse_to_sparse_stage = rocsparse_sparse_to_sparse_stage_

function rocsparse_sparse_to_sparse_buffer_size(handle, descr, source, target, stage,
                                                buffer_size_in_bytes)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sparse_to_sparse_buffer_size(handle::rocsparse_handle,
                                                                      descr::rocsparse_sparse_to_sparse_descr,
                                                                      source::rocsparse_const_spmat_descr,
                                                                      target::rocsparse_spmat_descr,
                                                                      stage::rocsparse_sparse_to_sparse_stage,
                                                                      buffer_size_in_bytes::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sparse_to_sparse(handle, descr, source, target, stage,
                                    buffer_size_in_bytes, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sparse_to_sparse(handle::rocsparse_handle,
                                                          descr::rocsparse_sparse_to_sparse_descr,
                                                          source::rocsparse_const_spmat_descr,
                                                          target::rocsparse_spmat_descr,
                                                          stage::rocsparse_sparse_to_sparse_stage,
                                                          buffer_size_in_bytes::Csize_t,
                                                          buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spgeam_stage_::UInt32 begin
    rocsparse_spgeam_stage_analysis = 1
    rocsparse_spgeam_stage_compute = 2
    rocsparse_spgeam_stage_symbolic_analysis = 3
    rocsparse_spgeam_stage_symbolic_compute = 4
    rocsparse_spgeam_stage_numeric_analysis = 5
    rocsparse_spgeam_stage_numeric_compute = 6
end

const rocsparse_spgeam_stage = rocsparse_spgeam_stage_

function rocsparse_spgeam_buffer_size(handle, descr, mat_A, mat_B, mat_C, stage,
                                      buffer_size, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spgeam_buffer_size(handle::rocsparse_handle,
                                                            descr::rocsparse_spgeam_descr,
                                                            mat_A::rocsparse_const_spmat_descr,
                                                            mat_B::rocsparse_const_spmat_descr,
                                                            mat_C::rocsparse_const_spmat_descr,
                                                            stage::rocsparse_spgeam_stage,
                                                            buffer_size::Ptr{Csize_t},
                                                            error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_spgeam(handle, descr, mat_A, mat_B, mat_C, stage, buffer_size,
                          temp_buffer, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spgeam(handle::rocsparse_handle,
                                                descr::rocsparse_spgeam_descr,
                                                mat_A::rocsparse_const_spmat_descr,
                                                mat_B::rocsparse_const_spmat_descr,
                                                mat_C::rocsparse_spmat_descr,
                                                stage::rocsparse_spgeam_stage,
                                                buffer_size::Csize_t,
                                                temp_buffer::Ptr{Cvoid},
                                                error::Ptr{rocsparse_error})::rocsparse_status)
end

@cenum rocsparse_spgemm_alg_::UInt32 begin
    rocsparse_spgemm_alg_default = 0
end

const rocsparse_spgemm_alg = rocsparse_spgemm_alg_

@cenum rocsparse_spgemm_stage_::UInt32 begin
    rocsparse_spgemm_stage_buffer_size = 1
    rocsparse_spgemm_stage_nnz = 2
    rocsparse_spgemm_stage_compute = 3
    rocsparse_spgemm_stage_symbolic = 4
    rocsparse_spgemm_stage_numeric = 5
end

const rocsparse_spgemm_stage = rocsparse_spgemm_stage_

function rocsparse_spgemm(handle, trans_A, trans_B, alpha, A, B, beta, D, C, compute_type,
                          alg, stage, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spgemm(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                alpha::Ptr{Cvoid},
                                                A::rocsparse_const_spmat_descr,
                                                B::rocsparse_const_spmat_descr,
                                                beta::Ptr{Cvoid},
                                                D::rocsparse_const_spmat_descr,
                                                C::rocsparse_spmat_descr,
                                                compute_type::rocsparse_datatype,
                                                alg::rocsparse_spgemm_alg,
                                                stage::rocsparse_spgemm_stage,
                                                buffer_size::Ptr{Csize_t},
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spitsv_alg_::UInt32 begin
    rocsparse_spitsv_alg_default = 0
end

const rocsparse_spitsv_alg = rocsparse_spitsv_alg_

@cenum rocsparse_spitsv_stage_::UInt32 begin
    rocsparse_spitsv_stage_buffer_size = 1
    rocsparse_spitsv_stage_preprocess = 2
    rocsparse_spitsv_stage_compute = 3
end

const rocsparse_spitsv_stage = rocsparse_spitsv_stage_

function rocsparse_spitsv(handle, host_nmaxiter, host_tol, host_history, trans, alpha, mat,
                          x, y, compute_type, alg, stage, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spitsv(handle::rocsparse_handle,
                                                host_nmaxiter::Ptr{rocsparse_int},
                                                host_tol::Ptr{Cvoid},
                                                host_history::Ptr{Cvoid},
                                                trans::rocsparse_operation,
                                                alpha::Ptr{Cvoid},
                                                mat::rocsparse_spmat_descr,
                                                x::rocsparse_dnvec_descr,
                                                y::rocsparse_dnvec_descr,
                                                compute_type::rocsparse_datatype,
                                                alg::rocsparse_spitsv_alg,
                                                stage::rocsparse_spitsv_stage,
                                                buffer_size::Ptr{Csize_t},
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spmm_alg_::UInt32 begin
    rocsparse_spmm_alg_default = 0
    rocsparse_spmm_alg_csr = 1
    rocsparse_spmm_alg_coo_segmented = 2
    rocsparse_spmm_alg_coo_atomic = 3
    rocsparse_spmm_alg_csr_row_split = 4
    rocsparse_spmm_alg_csr_merge = 5
    rocsparse_spmm_alg_coo_segmented_atomic = 6
    rocsparse_spmm_alg_bell = 7
    rocsparse_spmm_alg_bsr = 8
    rocsparse_spmm_alg_csr_merge_path = 9
    rocsparse_spmm_alg_csr_nnz_split = 5
end

const rocsparse_spmm_alg = rocsparse_spmm_alg_

@cenum rocsparse_spmm_stage_::UInt32 begin
    rocsparse_spmm_stage_buffer_size = 1
    rocsparse_spmm_stage_preprocess = 2
    rocsparse_spmm_stage_compute = 3
end

const rocsparse_spmm_stage = rocsparse_spmm_stage_

function rocsparse_spmm(handle, trans_A, trans_B, alpha, mat_A, mat_B, beta, mat_C,
                        compute_type, alg, stage, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmm(handle::rocsparse_handle,
                                              trans_A::rocsparse_operation,
                                              trans_B::rocsparse_operation,
                                              alpha::Ptr{Cvoid},
                                              mat_A::rocsparse_const_spmat_descr,
                                              mat_B::rocsparse_const_dnmat_descr,
                                              beta::Ptr{Cvoid},
                                              mat_C::rocsparse_dnmat_descr,
                                              compute_type::rocsparse_datatype,
                                              alg::rocsparse_spmm_alg,
                                              stage::rocsparse_spmm_stage,
                                              buffer_size::Ptr{Csize_t},
                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spmv_alg_::UInt32 begin
    rocsparse_spmv_alg_default = 0
    rocsparse_spmv_alg_coo = 1
    rocsparse_spmv_alg_csr_adaptive = 2
    rocsparse_spmv_alg_csr_rowsplit = 3
    rocsparse_spmv_alg_ell = 4
    rocsparse_spmv_alg_coo_atomic = 5
    rocsparse_spmv_alg_bsr = 6
    rocsparse_spmv_alg_csr_lrb = 7
    rocsparse_spmv_alg_csr_nnzsplit = 8
    rocsparse_spmv_alg_sell = 9
    rocsparse_spmv_alg_csr_stream = 3
end

const rocsparse_spmv_alg = rocsparse_spmv_alg_

@cenum rocsparse_spmv_stage_::UInt32 begin
    rocsparse_spmv_stage_buffer_size = 1
    rocsparse_spmv_stage_preprocess = 2
    rocsparse_spmv_stage_compute = 3
end

const rocsparse_spmv_stage = rocsparse_spmv_stage_

function rocsparse_spmv(handle, trans, alpha, mat, x, beta, y, compute_type, alg, stage,
                        buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmv(handle::rocsparse_handle,
                                              trans::rocsparse_operation, alpha::Ptr{Cvoid},
                                              mat::rocsparse_const_spmat_descr,
                                              x::rocsparse_const_dnvec_descr,
                                              beta::Ptr{Cvoid}, y::rocsparse_dnvec_descr,
                                              compute_type::rocsparse_datatype,
                                              alg::rocsparse_spmv_alg,
                                              stage::rocsparse_spmv_stage,
                                              buffer_size::Ptr{Csize_t},
                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spsm_alg_::UInt32 begin
    rocsparse_spsm_alg_default = 0
end

const rocsparse_spsm_alg = rocsparse_spsm_alg_

@cenum rocsparse_spsm_stage_::UInt32 begin
    rocsparse_spsm_stage_buffer_size = 1
    rocsparse_spsm_stage_preprocess = 2
    rocsparse_spsm_stage_compute = 3
end

const rocsparse_spsm_stage = rocsparse_spsm_stage_

function rocsparse_spsm(handle, trans_A, trans_B, alpha, matA, matB, matC, compute_type,
                        alg, stage, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spsm(handle::rocsparse_handle,
                                              trans_A::rocsparse_operation,
                                              trans_B::rocsparse_operation,
                                              alpha::Ptr{Cvoid},
                                              matA::rocsparse_const_spmat_descr,
                                              matB::rocsparse_const_dnmat_descr,
                                              matC::rocsparse_dnmat_descr,
                                              compute_type::rocsparse_datatype,
                                              alg::rocsparse_spsm_alg,
                                              stage::rocsparse_spsm_stage,
                                              buffer_size::Ptr{Csize_t},
                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_spsv_alg_::UInt32 begin
    rocsparse_spsv_alg_default = 0
end

const rocsparse_spsv_alg = rocsparse_spsv_alg_

@cenum rocsparse_spsv_stage_::UInt32 begin
    rocsparse_spsv_stage_buffer_size = 1
    rocsparse_spsv_stage_preprocess = 2
    rocsparse_spsv_stage_compute = 3
end

const rocsparse_spsv_stage = rocsparse_spsv_stage_

function rocsparse_spsv(handle, trans, alpha, mat, x, y, compute_type, alg, stage,
                        buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spsv(handle::rocsparse_handle,
                                              trans::rocsparse_operation, alpha::Ptr{Cvoid},
                                              mat::rocsparse_const_spmat_descr,
                                              x::rocsparse_const_dnvec_descr,
                                              y::rocsparse_dnvec_descr,
                                              compute_type::rocsparse_datatype,
                                              alg::rocsparse_spsv_alg,
                                              stage::rocsparse_spsv_stage,
                                              buffer_size::Ptr{Csize_t},
                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_sptrsm_stage_::UInt32 begin
    rocsparse_sptrsm_stage_analysis = 0
    rocsparse_sptrsm_stage_compute = 1
end

const rocsparse_sptrsm_stage = rocsparse_sptrsm_stage_

function rocsparse_sptrsm_buffer_size(handle, sptrsm_descr, A, X, Y, sptrsm_stage,
                                      buffer_size_in_bytes, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsm_buffer_size(handle::rocsparse_handle,
                                                            sptrsm_descr::rocsparse_sptrsm_descr,
                                                            A::rocsparse_const_spmat_descr,
                                                            X::rocsparse_const_dnmat_descr,
                                                            Y::rocsparse_const_dnmat_descr,
                                                            sptrsm_stage::rocsparse_sptrsm_stage,
                                                            buffer_size_in_bytes::Ptr{Csize_t},
                                                            p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_sptrsm(handle, sptrsm_descr, A, X, Y, sptrsm_stage, buffer_size_in_bytes,
                          buffer, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsm(handle::rocsparse_handle,
                                                sptrsm_descr::rocsparse_sptrsm_descr,
                                                A::rocsparse_const_spmat_descr,
                                                X::rocsparse_const_dnmat_descr,
                                                Y::rocsparse_dnmat_descr,
                                                sptrsm_stage::rocsparse_sptrsm_stage,
                                                buffer_size_in_bytes::Csize_t,
                                                buffer::Ptr{Cvoid},
                                                p_error::Ptr{rocsparse_error})::rocsparse_status)
end

@cenum rocsparse_sptrsv_stage_::UInt32 begin
    rocsparse_sptrsv_stage_analysis = 0
    rocsparse_sptrsv_stage_compute = 1
end

const rocsparse_sptrsv_stage = rocsparse_sptrsv_stage_

function rocsparse_sptrsv_buffer_size(handle, sptrsv_descr, spmat_descr, x, y, sptrsv_stage,
                                      buffer_size_in_bytes, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsv_buffer_size(handle::rocsparse_handle,
                                                            sptrsv_descr::rocsparse_sptrsv_descr,
                                                            spmat_descr::rocsparse_const_spmat_descr,
                                                            x::rocsparse_const_dnvec_descr,
                                                            y::rocsparse_const_dnvec_descr,
                                                            sptrsv_stage::rocsparse_sptrsv_stage,
                                                            buffer_size_in_bytes::Ptr{Csize_t},
                                                            p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_sptrsv(handle, sptrsv_descr, A, x, y, sptrsv_stage, buffer_size_in_bytes,
                          buffer, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sptrsv(handle::rocsparse_handle,
                                                sptrsv_descr::rocsparse_sptrsv_descr,
                                                A::rocsparse_const_spmat_descr,
                                                x::rocsparse_const_dnvec_descr,
                                                y::rocsparse_dnvec_descr,
                                                sptrsv_stage::rocsparse_sptrsv_stage,
                                                buffer_size_in_bytes::Csize_t,
                                                buffer::Ptr{Cvoid},
                                                p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_spvv(handle, trans, x, y, result, compute_type, buffer_size, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spvv(handle::rocsparse_handle,
                                              trans::rocsparse_operation,
                                              x::rocsparse_const_spvec_descr,
                                              y::rocsparse_const_dnvec_descr,
                                              result::Ptr{Cvoid},
                                              compute_type::rocsparse_datatype,
                                              buffer_size::Ptr{Csize_t},
                                              temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_v2_spmv_stage_::UInt32 begin
    rocsparse_v2_spmv_stage_analysis = 0
    rocsparse_v2_spmv_stage_compute = 1
end

const rocsparse_v2_spmv_stage = rocsparse_v2_spmv_stage_

function rocsparse_v2_spmv_buffer_size(handle, descr, mat, x, y, stage,
                                       buffer_size_in_bytes, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_v2_spmv_buffer_size(handle::rocsparse_handle,
                                                             descr::rocsparse_spmv_descr,
                                                             mat::rocsparse_const_spmat_descr,
                                                             x::rocsparse_const_dnvec_descr,
                                                             y::rocsparse_const_dnvec_descr,
                                                             stage::rocsparse_v2_spmv_stage,
                                                             buffer_size_in_bytes::Ptr{Csize_t},
                                                             error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_v2_spmv(handle, descr, alpha, mat, x, beta, y, stage,
                           buffer_size_in_bytes, buffer, error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_v2_spmv(handle::rocsparse_handle,
                                                 descr::rocsparse_spmv_descr,
                                                 alpha::Ptr{Cvoid},
                                                 mat::rocsparse_const_spmat_descr,
                                                 x::rocsparse_const_dnvec_descr,
                                                 beta::Ptr{Cvoid}, y::rocsparse_dnvec_descr,
                                                 stage::rocsparse_v2_spmv_stage,
                                                 buffer_size_in_bytes::Csize_t,
                                                 buffer::Ptr{Cvoid},
                                                 error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_spmv_set_extra(handle, descr, num_extras, gamma_vec, z_vecs, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmv_set_extra(handle::rocsparse_handle,
                                                        descr::rocsparse_spmv_descr,
                                                        num_extras::Int64,
                                                        gamma_vec::rocsparse_const_dnvec_descr,
                                                        z_vecs::Ptr{rocsparse_const_dnvec_descr},
                                                        p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_spmv_clear_extra(handle, descr, p_error)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_spmv_clear_extra(handle::rocsparse_handle,
                                                          descr::rocsparse_spmv_descr,
                                                          p_error::Ptr{rocsparse_error})::rocsparse_status)
end

function rocsparse_saxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_saxpyi(handle::rocsparse_handle,
                                                nnz::rocsparse_int, alpha::Ptr{Cfloat},
                                                x_val::Ptr{Cfloat},
                                                x_ind::Ptr{rocsparse_int}, y::Ptr{Cfloat},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_daxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_daxpyi(handle::rocsparse_handle,
                                                nnz::rocsparse_int, alpha::Ptr{Cdouble},
                                                x_val::Ptr{Cdouble},
                                                x_ind::Ptr{rocsparse_int}, y::Ptr{Cdouble},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_caxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_caxpyi(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                x_val::Ptr{rocsparse_float_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                y::Ptr{rocsparse_float_complex},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zaxpyi(handle, nnz, alpha, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zaxpyi(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                x_val::Ptr{rocsparse_double_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                y::Ptr{rocsparse_double_complex},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_cdotci(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cdotci(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                x_val::Ptr{rocsparse_float_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                y::Ptr{rocsparse_float_complex},
                                                result::Ptr{rocsparse_float_complex},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zdotci(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zdotci(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                x_val::Ptr{rocsparse_double_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                y::Ptr{rocsparse_double_complex},
                                                result::Ptr{rocsparse_double_complex},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_sdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sdoti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cfloat},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cfloat},
                                               result::Ptr{Cfloat},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_ddoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ddoti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cdouble},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cdouble},
                                               result::Ptr{Cdouble},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_cdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cdoti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{rocsparse_float_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               y::Ptr{rocsparse_float_complex},
                                               result::Ptr{rocsparse_float_complex},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zdoti(handle, nnz, x_val, x_ind, y, result, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zdoti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{rocsparse_double_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               y::Ptr{rocsparse_double_complex},
                                               result::Ptr{rocsparse_double_complex},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_sgthr(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgthr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               y::Ptr{Cfloat}, x_val::Ptr{Cfloat},
                                               x_ind::Ptr{rocsparse_int},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_dgthr(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgthr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               y::Ptr{Cdouble}, x_val::Ptr{Cdouble},
                                               x_ind::Ptr{rocsparse_int},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_cgthr(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgthr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               y::Ptr{rocsparse_float_complex},
                                               x_val::Ptr{rocsparse_float_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zgthr(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgthr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               y::Ptr{rocsparse_double_complex},
                                               x_val::Ptr{rocsparse_double_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_sgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgthrz(handle::rocsparse_handle,
                                                nnz::rocsparse_int, y::Ptr{Cfloat},
                                                x_val::Ptr{Cfloat},
                                                x_ind::Ptr{rocsparse_int},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_dgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgthrz(handle::rocsparse_handle,
                                                nnz::rocsparse_int, y::Ptr{Cdouble},
                                                x_val::Ptr{Cdouble},
                                                x_ind::Ptr{rocsparse_int},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_cgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgthrz(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                y::Ptr{rocsparse_float_complex},
                                                x_val::Ptr{rocsparse_float_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zgthrz(handle, nnz, y, x_val, x_ind, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgthrz(handle::rocsparse_handle,
                                                nnz::rocsparse_int,
                                                y::Ptr{rocsparse_double_complex},
                                                x_val::Ptr{rocsparse_double_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_sroti(handle, nnz, x_val, x_ind, y, c, s, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sroti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cfloat},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cfloat},
                                               c::Ptr{Cfloat}, s::Ptr{Cfloat},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_droti(handle, nnz, x_val, x_ind, y, c, s, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_droti(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cdouble},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cdouble},
                                               c::Ptr{Cdouble}, s::Ptr{Cdouble},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_ssctr(handle, nnz, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ssctr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cfloat},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cfloat},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_dsctr(handle, nnz, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dsctr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{Cdouble},
                                               x_ind::Ptr{rocsparse_int}, y::Ptr{Cdouble},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_csctr(handle, nnz, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csctr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{rocsparse_float_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               y::Ptr{rocsparse_float_complex},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_zsctr(handle, nnz, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zsctr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{rocsparse_double_complex},
                                               x_ind::Ptr{rocsparse_int},
                                               y::Ptr{rocsparse_double_complex},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_isctr(handle, nnz, x_val, x_ind, y, idx_base)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_isctr(handle::rocsparse_handle, nnz::rocsparse_int,
                                               x_val::Ptr{rocsparse_int},
                                               x_ind::Ptr{rocsparse_int},
                                               y::Ptr{rocsparse_int},
                                               idx_base::rocsparse_index_base)::rocsparse_status)
end

function rocsparse_sbsrmv_analysis(handle, dir, trans, mb, nb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrmv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cfloat},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_dbsrmv_analysis(handle, dir, trans, mb, nb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrmv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cdouble},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_cbsrmv_analysis(handle, dir, trans, mb, nb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrmv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_float_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_zbsrmv_analysis(handle, dir, trans, mb, nb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrmv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_double_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_sbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                          bsr_row_ptr, bsr_col_ind, block_dim, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrmv(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans::rocsparse_operation,
                                                mb::rocsparse_int, nb::rocsparse_int,
                                                nnzb::rocsparse_int, alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{Cfloat},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                info::rocsparse_mat_info, x::Ptr{Cfloat},
                                                beta::Ptr{Cfloat},
                                                y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                          bsr_row_ptr, bsr_col_ind, block_dim, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrmv(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans::rocsparse_operation,
                                                mb::rocsparse_int, nb::rocsparse_int,
                                                nnzb::rocsparse_int, alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{Cdouble},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                info::rocsparse_mat_info, x::Ptr{Cdouble},
                                                beta::Ptr{Cdouble},
                                                y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_cbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                          bsr_row_ptr, bsr_col_ind, block_dim, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrmv(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans::rocsparse_operation,
                                                mb::rocsparse_int, nb::rocsparse_int,
                                                nnzb::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{rocsparse_float_complex},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                info::rocsparse_mat_info,
                                                x::Ptr{rocsparse_float_complex},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zbsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                          bsr_row_ptr, bsr_col_ind, block_dim, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrmv(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans::rocsparse_operation,
                                                mb::rocsparse_int, nb::rocsparse_int,
                                                nnzb::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{rocsparse_double_complex},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                info::rocsparse_mat_info,
                                                x::Ptr{rocsparse_double_complex},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_bsrmv_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrmv_clear(handle::rocsparse_handle,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_bsrsv_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrsv_zero_pivot(handle::rocsparse_handle,
                                                          info::rocsparse_mat_info,
                                                          position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                      bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsv_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{Cfloat},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                      bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsv_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{Cdouble},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                      bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsv_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{rocsparse_float_complex},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zbsrsv_buffer_size(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                      bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsv_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{rocsparse_double_complex},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

@cenum rocsparse_analysis_policy_::UInt32 begin
    rocsparse_analysis_policy_reuse = 0
    rocsparse_analysis_policy_force = 1
end

const rocsparse_analysis_policy = rocsparse_analysis_policy_

@cenum rocsparse_solve_policy_::UInt32 begin
    rocsparse_solve_policy_auto = 0
end

const rocsparse_solve_policy = rocsparse_solve_policy_

function rocsparse_sbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info, analysis,
                                   solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cfloat},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info, analysis,
                                   solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cdouble},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info, analysis,
                                   solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_float_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrsv_analysis(handle, dir, trans, mb, nnzb, descr, bsr_val,
                                   bsr_row_ptr, bsr_col_ind, block_dim, info, analysis,
                                   solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsv_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_double_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsrsv_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrsv_clear(handle::rocsparse_handle,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_sbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val,
                                bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsv_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{Cfloat},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{Cfloat},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{Cfloat}, y::Ptr{Cfloat},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val,
                                bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsv_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{Cdouble},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{Cdouble},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{Cdouble}, y::Ptr{Cdouble},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val,
                                bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsv_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{rocsparse_float_complex},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{rocsparse_float_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{rocsparse_float_complex},
                                                      y::Ptr{rocsparse_float_complex},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrsv_solve(handle, dir, trans, mb, nnzb, alpha, descr, bsr_val,
                                bsr_row_ptr, bsr_col_ind, block_dim, info, x, y, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsv_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{rocsparse_double_complex},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{rocsparse_double_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{rocsparse_double_complex},
                                                      y::Ptr{rocsparse_double_complex},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr,
                           bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind,
                           block_dim, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrxmv(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 trans::rocsparse_operation,
                                                 size_of_mask::rocsparse_int,
                                                 mb::rocsparse_int, nb::rocsparse_int,
                                                 nnzb::rocsparse_int, alpha::Ptr{Cfloat},
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{Cfloat},
                                                 bsr_mask_ptr::Ptr{rocsparse_int},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_end_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int, x::Ptr{Cfloat},
                                                 beta::Ptr{Cfloat},
                                                 y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr,
                           bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind,
                           block_dim, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrxmv(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 trans::rocsparse_operation,
                                                 size_of_mask::rocsparse_int,
                                                 mb::rocsparse_int, nb::rocsparse_int,
                                                 nnzb::rocsparse_int, alpha::Ptr{Cdouble},
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{Cdouble},
                                                 bsr_mask_ptr::Ptr{rocsparse_int},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_end_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int, x::Ptr{Cdouble},
                                                 beta::Ptr{Cdouble},
                                                 y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_cbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr,
                           bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind,
                           block_dim, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrxmv(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 trans::rocsparse_operation,
                                                 size_of_mask::rocsparse_int,
                                                 mb::rocsparse_int, nb::rocsparse_int,
                                                 nnzb::rocsparse_int,
                                                 alpha::Ptr{rocsparse_float_complex},
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{rocsparse_float_complex},
                                                 bsr_mask_ptr::Ptr{rocsparse_int},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_end_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 x::Ptr{rocsparse_float_complex},
                                                 beta::Ptr{rocsparse_float_complex},
                                                 y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zbsrxmv(handle, dir, trans, size_of_mask, mb, nb, nnzb, alpha, descr,
                           bsr_val, bsr_mask_ptr, bsr_row_ptr, bsr_end_ptr, bsr_col_ind,
                           block_dim, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrxmv(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 trans::rocsparse_operation,
                                                 size_of_mask::rocsparse_int,
                                                 mb::rocsparse_int, nb::rocsparse_int,
                                                 nnzb::rocsparse_int,
                                                 alpha::Ptr{rocsparse_double_complex},
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{rocsparse_double_complex},
                                                 bsr_mask_ptr::Ptr{rocsparse_int},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_end_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 x::Ptr{rocsparse_double_complex},
                                                 beta::Ptr{rocsparse_double_complex},
                                                 y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_scoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind,
                          coo_col_ind, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scoomv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int, alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                coo_val::Ptr{Cfloat},
                                                coo_row_ind::Ptr{rocsparse_int},
                                                coo_col_ind::Ptr{rocsparse_int},
                                                x::Ptr{Cfloat}, beta::Ptr{Cfloat},
                                                y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dcoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind,
                          coo_col_ind, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcoomv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int, alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                coo_val::Ptr{Cdouble},
                                                coo_row_ind::Ptr{rocsparse_int},
                                                coo_col_ind::Ptr{rocsparse_int},
                                                x::Ptr{Cdouble}, beta::Ptr{Cdouble},
                                                y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_ccoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind,
                          coo_col_ind, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccoomv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                coo_val::Ptr{rocsparse_float_complex},
                                                coo_row_ind::Ptr{rocsparse_int},
                                                coo_col_ind::Ptr{rocsparse_int},
                                                x::Ptr{rocsparse_float_complex},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zcoomv(handle, trans, m, n, nnz, alpha, descr, coo_val, coo_row_ind,
                          coo_col_ind, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcoomv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                coo_val::Ptr{rocsparse_double_complex},
                                                coo_row_ind::Ptr{rocsparse_int},
                                                coo_col_ind::Ptr{rocsparse_int},
                                                x::Ptr{rocsparse_double_complex},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_csritsv_zero_pivot(handle, descr, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csritsv_zero_pivot(handle::rocsparse_handle,
                                                            descr::rocsparse_mat_descr,
                                                            info::rocsparse_mat_info,
                                                            position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsritsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritsv_buffer_size(handle::rocsparse_handle,
                                                              trans::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{Cfloat},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsritsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritsv_buffer_size(handle::rocsparse_handle,
                                                              trans::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{Cdouble},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsritsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritsv_buffer_size(handle::rocsparse_handle,
                                                              trans::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{rocsparse_float_complex},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsritsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritsv_buffer_size(handle::rocsparse_handle,
                                                              trans::rocsparse_operation,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{rocsparse_double_complex},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsritsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritsv_analysis(handle::rocsparse_handle,
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cfloat},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritsv_analysis(handle::rocsparse_handle,
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cdouble},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritsv_analysis(handle::rocsparse_handle,
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritsv_analysis(handle::rocsparse_handle,
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csritsv_clear(handle, descr, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csritsv_clear(handle::rocsparse_handle,
                                                       descr::rocsparse_mat_descr,
                                                       info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsritsv_solve(handle, host_nmaxiter, host_tol, host_history, trans, m,
                                  nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind,
                                  info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritsv_solve(handle::rocsparse_handle,
                                                        host_nmaxiter::Ptr{rocsparse_int},
                                                        host_tol::Ptr{Cfloat},
                                                        host_history::Ptr{Cfloat},
                                                        trans::rocsparse_operation,
                                                        m::rocsparse_int,
                                                        nnz::rocsparse_int,
                                                        alpha::Ptr{Cfloat},
                                                        descr::rocsparse_mat_descr,
                                                        csr_val::Ptr{Cfloat},
                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                        csr_col_ind::Ptr{rocsparse_int},
                                                        info::rocsparse_mat_info,
                                                        x::Ptr{Cfloat}, y::Ptr{Cfloat},
                                                        policy::rocsparse_solve_policy,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritsv_solve(handle, host_nmaxiter, host_tol, host_history, trans, m,
                                  nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind,
                                  info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritsv_solve(handle::rocsparse_handle,
                                                        host_nmaxiter::Ptr{rocsparse_int},
                                                        host_tol::Ptr{Cdouble},
                                                        host_history::Ptr{Cdouble},
                                                        trans::rocsparse_operation,
                                                        m::rocsparse_int,
                                                        nnz::rocsparse_int,
                                                        alpha::Ptr{Cdouble},
                                                        descr::rocsparse_mat_descr,
                                                        csr_val::Ptr{Cdouble},
                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                        csr_col_ind::Ptr{rocsparse_int},
                                                        info::rocsparse_mat_info,
                                                        x::Ptr{Cdouble}, y::Ptr{Cdouble},
                                                        policy::rocsparse_solve_policy,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritsv_solve(handle, host_nmaxiter, host_tol, host_history, trans, m,
                                  nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind,
                                  info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritsv_solve(handle::rocsparse_handle,
                                                        host_nmaxiter::Ptr{rocsparse_int},
                                                        host_tol::Ptr{Cfloat},
                                                        host_history::Ptr{Cfloat},
                                                        trans::rocsparse_operation,
                                                        m::rocsparse_int,
                                                        nnz::rocsparse_int,
                                                        alpha::Ptr{rocsparse_float_complex},
                                                        descr::rocsparse_mat_descr,
                                                        csr_val::Ptr{rocsparse_float_complex},
                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                        csr_col_ind::Ptr{rocsparse_int},
                                                        info::rocsparse_mat_info,
                                                        x::Ptr{rocsparse_float_complex},
                                                        y::Ptr{rocsparse_float_complex},
                                                        policy::rocsparse_solve_policy,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritsv_solve(handle, host_nmaxiter, host_tol, host_history, trans, m,
                                  nnz, alpha, descr, csr_val, csr_row_ptr, csr_col_ind,
                                  info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritsv_solve(handle::rocsparse_handle,
                                                        host_nmaxiter::Ptr{rocsparse_int},
                                                        host_tol::Ptr{Cdouble},
                                                        host_history::Ptr{Cdouble},
                                                        trans::rocsparse_operation,
                                                        m::rocsparse_int,
                                                        nnz::rocsparse_int,
                                                        alpha::Ptr{rocsparse_double_complex},
                                                        descr::rocsparse_mat_descr,
                                                        csr_val::Ptr{rocsparse_double_complex},
                                                        csr_row_ptr::Ptr{rocsparse_int},
                                                        csr_col_ind::Ptr{rocsparse_int},
                                                        info::rocsparse_mat_info,
                                                        x::Ptr{rocsparse_double_complex},
                                                        y::Ptr{rocsparse_double_complex},
                                                        policy::rocsparse_solve_policy,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsritsv_solve_ex(handle, host_nmaxiter, host_nfreeiter, host_tol,
                                     host_history, trans, m, nnz, alpha, descr, csr_val,
                                     csr_row_ptr, csr_col_ind, info, x, y, policy,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritsv_solve_ex(handle::rocsparse_handle,
                                                           host_nmaxiter::Ptr{rocsparse_int},
                                                           host_nfreeiter::rocsparse_int,
                                                           host_tol::Ptr{Cfloat},
                                                           host_history::Ptr{Cfloat},
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           alpha::Ptr{Cfloat},
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cfloat},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           x::Ptr{Cfloat}, y::Ptr{Cfloat},
                                                           policy::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritsv_solve_ex(handle, host_nmaxiter, host_nfreeiter, host_tol,
                                     host_history, trans, m, nnz, alpha, descr, csr_val,
                                     csr_row_ptr, csr_col_ind, info, x, y, policy,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritsv_solve_ex(handle::rocsparse_handle,
                                                           host_nmaxiter::Ptr{rocsparse_int},
                                                           host_nfreeiter::rocsparse_int,
                                                           host_tol::Ptr{Cdouble},
                                                           host_history::Ptr{Cdouble},
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           alpha::Ptr{Cdouble},
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cdouble},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           x::Ptr{Cdouble}, y::Ptr{Cdouble},
                                                           policy::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritsv_solve_ex(handle, host_nmaxiter, host_nfreeiter, host_tol,
                                     host_history, trans, m, nnz, alpha, descr, csr_val,
                                     csr_row_ptr, csr_col_ind, info, x, y, policy,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritsv_solve_ex(handle::rocsparse_handle,
                                                           host_nmaxiter::Ptr{rocsparse_int},
                                                           host_nfreeiter::rocsparse_int,
                                                           host_tol::Ptr{Cfloat},
                                                           host_history::Ptr{Cfloat},
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           alpha::Ptr{rocsparse_float_complex},
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           x::Ptr{rocsparse_float_complex},
                                                           y::Ptr{rocsparse_float_complex},
                                                           policy::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritsv_solve_ex(handle, host_nmaxiter, host_nfreeiter, host_tol,
                                     host_history, trans, m, nnz, alpha, descr, csr_val,
                                     csr_row_ptr, csr_col_ind, info, x, y, policy,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritsv_solve_ex(handle::rocsparse_handle,
                                                           host_nmaxiter::Ptr{rocsparse_int},
                                                           host_nfreeiter::rocsparse_int,
                                                           host_tol::Ptr{Cdouble},
                                                           host_history::Ptr{Cdouble},
                                                           trans::rocsparse_operation,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           alpha::Ptr{rocsparse_double_complex},
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           x::Ptr{rocsparse_double_complex},
                                                           y::Ptr{rocsparse_double_complex},
                                                           policy::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrmv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int, n::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cfloat},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_dcsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrmv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int, n::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cdouble},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_ccsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrmv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int, n::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_float_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_zcsrmv_analysis(handle, trans, m, n, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrmv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int, n::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_double_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_csrmv_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrmv_clear(handle::rocsparse_handle,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr,
                          csr_col_ind, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int, alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cfloat},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                info::rocsparse_mat_info, x::Ptr{Cfloat},
                                                beta::Ptr{Cfloat},
                                                y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dcsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr,
                          csr_col_ind, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int, alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cdouble},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                info::rocsparse_mat_info, x::Ptr{Cdouble},
                                                beta::Ptr{Cdouble},
                                                y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_ccsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr,
                          csr_col_ind, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_float_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                info::rocsparse_mat_info,
                                                x::Ptr{rocsparse_float_complex},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zcsrmv(handle, trans, m, n, nnz, alpha, descr, csr_val, csr_row_ptr,
                          csr_col_ind, info, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_double_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                info::rocsparse_mat_info,
                                                x::Ptr{rocsparse_double_complex},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_csrsv_zero_pivot(handle, descr, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsv_zero_pivot(handle::rocsparse_handle,
                                                          descr::rocsparse_mat_descr,
                                                          info::rocsparse_mat_info,
                                                          position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                      csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsv_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{Cfloat},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                      csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsv_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{Cdouble},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                      csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsv_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{rocsparse_float_complex},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsrsv_buffer_size(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                      csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsv_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{rocsparse_double_complex},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cfloat},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cdouble},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_float_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrsv_analysis(handle, trans, m, nnz, descr, csr_val, csr_row_ptr,
                                   csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsv_analysis(handle::rocsparse_handle,
                                                         trans::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_double_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrsv_clear(handle, descr, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsv_clear(handle::rocsparse_handle,
                                                     descr::rocsparse_mat_descr,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr,
                                csr_col_ind, info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsv_solve(handle::rocsparse_handle,
                                                      trans::rocsparse_operation,
                                                      m::rocsparse_int, nnz::rocsparse_int,
                                                      alpha::Ptr{Cfloat},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{Cfloat},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{Cfloat}, y::Ptr{Cfloat},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr,
                                csr_col_ind, info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsv_solve(handle::rocsparse_handle,
                                                      trans::rocsparse_operation,
                                                      m::rocsparse_int, nnz::rocsparse_int,
                                                      alpha::Ptr{Cdouble},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{Cdouble},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{Cdouble}, y::Ptr{Cdouble},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr,
                                csr_col_ind, info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsv_solve(handle::rocsparse_handle,
                                                      trans::rocsparse_operation,
                                                      m::rocsparse_int, nnz::rocsparse_int,
                                                      alpha::Ptr{rocsparse_float_complex},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{rocsparse_float_complex},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{rocsparse_float_complex},
                                                      y::Ptr{rocsparse_float_complex},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrsv_solve(handle, trans, m, nnz, alpha, descr, csr_val, csr_row_ptr,
                                csr_col_ind, info, x, y, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsv_solve(handle::rocsparse_handle,
                                                      trans::rocsparse_operation,
                                                      m::rocsparse_int, nnz::rocsparse_int,
                                                      alpha::Ptr{rocsparse_double_complex},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{rocsparse_double_complex},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      info::rocsparse_mat_info,
                                                      x::Ptr{rocsparse_double_complex},
                                                      y::Ptr{rocsparse_double_complex},
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind,
                          ell_width, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sellmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                ell_val::Ptr{Cfloat},
                                                ell_col_ind::Ptr{rocsparse_int},
                                                ell_width::rocsparse_int, x::Ptr{Cfloat},
                                                beta::Ptr{Cfloat},
                                                y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind,
                          ell_width, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dellmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                ell_val::Ptr{Cdouble},
                                                ell_col_ind::Ptr{rocsparse_int},
                                                ell_width::rocsparse_int, x::Ptr{Cdouble},
                                                beta::Ptr{Cdouble},
                                                y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_cellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind,
                          ell_width, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cellmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                ell_val::Ptr{rocsparse_float_complex},
                                                ell_col_ind::Ptr{rocsparse_int},
                                                ell_width::rocsparse_int,
                                                x::Ptr{rocsparse_float_complex},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zellmv(handle, trans, m, n, alpha, descr, ell_val, ell_col_ind,
                          ell_width, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zellmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                ell_val::Ptr{rocsparse_double_complex},
                                                ell_col_ind::Ptr{rocsparse_int},
                                                ell_width::rocsparse_int,
                                                x::Ptr{rocsparse_double_complex},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_sgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                            bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta,
                            y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsrmv(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  nnzb::rocsparse_int, alpha::Ptr{Cfloat},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cfloat},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  x::Ptr{Cfloat}, beta::Ptr{Cfloat},
                                                  y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                            bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta,
                            y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsrmv(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  nnzb::rocsparse_int, alpha::Ptr{Cdouble},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cdouble},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  x::Ptr{Cdouble}, beta::Ptr{Cdouble},
                                                  y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_cgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                            bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta,
                            y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsrmv(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  nnzb::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  x::Ptr{rocsparse_float_complex},
                                                  beta::Ptr{rocsparse_float_complex},
                                                  y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zgebsrmv(handle, dir, trans, mb, nb, nnzb, alpha, descr, bsr_val,
                            bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim, x, beta,
                            y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsrmv(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans::rocsparse_operation,
                                                  mb::rocsparse_int, nb::rocsparse_int,
                                                  nnzb::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  x::Ptr{rocsparse_double_complex},
                                                  beta::Ptr{rocsparse_double_complex},
                                                  y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_sgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgemvi_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgemvi_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgemvi_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgemvi_buffer_size(handle, trans, m, n, nnz, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgemvi_buffer_size(handle::rocsparse_handle,
                                                            trans::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            n::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y,
                          idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgemvi(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{Cfloat}, A::Ptr{Cfloat},
                                                lda::rocsparse_int, nnz::rocsparse_int,
                                                x_val::Ptr{Cfloat},
                                                x_ind::Ptr{rocsparse_int},
                                                beta::Ptr{Cfloat}, y::Ptr{Cfloat},
                                                idx_base::rocsparse_index_base,
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y,
                          idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgemvi(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{Cdouble}, A::Ptr{Cdouble},
                                                lda::rocsparse_int, nnz::rocsparse_int,
                                                x_val::Ptr{Cdouble},
                                                x_ind::Ptr{rocsparse_int},
                                                beta::Ptr{Cdouble}, y::Ptr{Cdouble},
                                                idx_base::rocsparse_index_base,
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y,
                          idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgemvi(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                A::Ptr{rocsparse_float_complex},
                                                lda::rocsparse_int, nnz::rocsparse_int,
                                                x_val::Ptr{rocsparse_float_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex},
                                                idx_base::rocsparse_index_base,
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgemvi(handle, trans, m, n, alpha, A, lda, nnz, x_val, x_ind, beta, y,
                          idx_base, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgemvi(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                A::Ptr{rocsparse_double_complex},
                                                lda::rocsparse_int, nnz::rocsparse_int,
                                                x_val::Ptr{rocsparse_double_complex},
                                                x_ind::Ptr{rocsparse_int},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex},
                                                idx_base::rocsparse_index_base,
                                                temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_shybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_shybmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                hyb::rocsparse_hyb_mat, x::Ptr{Cfloat},
                                                beta::Ptr{Cfloat},
                                                y::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dhybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dhybmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                hyb::rocsparse_hyb_mat, x::Ptr{Cdouble},
                                                beta::Ptr{Cdouble},
                                                y::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_chybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_chybmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                hyb::rocsparse_hyb_mat,
                                                x::Ptr{rocsparse_float_complex},
                                                beta::Ptr{rocsparse_float_complex},
                                                y::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zhybmv(handle, trans, alpha, descr, hyb, x, beta, y)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zhybmv(handle::rocsparse_handle,
                                                trans::rocsparse_operation,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                hyb::rocsparse_hyb_mat,
                                                x::Ptr{rocsparse_double_complex},
                                                beta::Ptr{rocsparse_double_complex},
                                                y::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_sbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                          bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C,
                          ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrmm(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                mb::rocsparse_int, n::rocsparse_int,
                                                kb::rocsparse_int, nnzb::rocsparse_int,
                                                alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{Cfloat},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int, B::Ptr{Cfloat},
                                                ldb::rocsparse_int, beta::Ptr{Cfloat},
                                                C::Ptr{Cfloat},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_dbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                          bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C,
                          ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrmm(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                mb::rocsparse_int, n::rocsparse_int,
                                                kb::rocsparse_int, nnzb::rocsparse_int,
                                                alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{Cdouble},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int, B::Ptr{Cdouble},
                                                ldb::rocsparse_int, beta::Ptr{Cdouble},
                                                C::Ptr{Cdouble},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_cbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                          bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C,
                          ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrmm(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                mb::rocsparse_int, n::rocsparse_int,
                                                kb::rocsparse_int, nnzb::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{rocsparse_float_complex},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                B::Ptr{rocsparse_float_complex},
                                                ldb::rocsparse_int,
                                                beta::Ptr{rocsparse_float_complex},
                                                C::Ptr{rocsparse_float_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_zbsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                          bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, B, ldb, beta, C,
                          ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrmm(handle::rocsparse_handle,
                                                dir::rocsparse_direction,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                mb::rocsparse_int, n::rocsparse_int,
                                                kb::rocsparse_int, nnzb::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                bsr_val::Ptr{rocsparse_double_complex},
                                                bsr_row_ptr::Ptr{rocsparse_int},
                                                bsr_col_ind::Ptr{rocsparse_int},
                                                block_dim::rocsparse_int,
                                                B::Ptr{rocsparse_double_complex},
                                                ldb::rocsparse_int,
                                                beta::Ptr{rocsparse_double_complex},
                                                C::Ptr{rocsparse_double_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_bsrsm_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrsm_zero_pivot(handle::rocsparse_handle,
                                                          info::rocsparse_mat_info,
                                                          position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                      bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsm_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans_A::rocsparse_operation,
                                                            trans_X::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{Cfloat},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                      bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsm_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans_A::rocsparse_operation,
                                                            trans_X::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{Cdouble},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                      bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsm_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans_A::rocsparse_operation,
                                                            trans_X::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{rocsparse_float_complex},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zbsrsm_buffer_size(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                      bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                      buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsm_buffer_size(handle::rocsparse_handle,
                                                            dir::rocsparse_direction,
                                                            trans_A::rocsparse_operation,
                                                            trans_X::rocsparse_operation,
                                                            mb::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnzb::rocsparse_int,
                                                            descr::rocsparse_mat_descr,
                                                            bsr_val::Ptr{rocsparse_double_complex},
                                                            bsr_row_ptr::Ptr{rocsparse_int},
                                                            bsr_col_ind::Ptr{rocsparse_int},
                                                            block_dim::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                   bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsm_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans_A::rocsparse_operation,
                                                         trans_X::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cfloat},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                   bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsm_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans_A::rocsparse_operation,
                                                         trans_X::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{Cdouble},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                   bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsm_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans_A::rocsparse_operation,
                                                         trans_X::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_float_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrsm_analysis(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, descr,
                                   bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsm_analysis(handle::rocsparse_handle,
                                                         dir::rocsparse_direction,
                                                         trans_A::rocsparse_operation,
                                                         trans_X::rocsparse_operation,
                                                         mb::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnzb::rocsparse_int,
                                                         descr::rocsparse_mat_descr,
                                                         bsr_val::Ptr{rocsparse_double_complex},
                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                         block_dim::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsrsm_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrsm_clear(handle::rocsparse_handle,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_sbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr,
                                bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb,
                                X, ldx, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrsm_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans_A::rocsparse_operation,
                                                      trans_X::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nrhs::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{Cfloat},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{Cfloat},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      B::Ptr{Cfloat}, ldb::rocsparse_int,
                                                      X::Ptr{Cfloat}, ldx::rocsparse_int,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr,
                                bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb,
                                X, ldx, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrsm_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans_A::rocsparse_operation,
                                                      trans_X::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nrhs::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{Cdouble},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{Cdouble},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      B::Ptr{Cdouble}, ldb::rocsparse_int,
                                                      X::Ptr{Cdouble}, ldx::rocsparse_int,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr,
                                bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb,
                                X, ldx, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrsm_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans_A::rocsparse_operation,
                                                      trans_X::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nrhs::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{rocsparse_float_complex},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{rocsparse_float_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      B::Ptr{rocsparse_float_complex},
                                                      ldb::rocsparse_int,
                                                      X::Ptr{rocsparse_float_complex},
                                                      ldx::rocsparse_int,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrsm_solve(handle, dir, trans_A, trans_X, mb, nrhs, nnzb, alpha, descr,
                                bsr_val, bsr_row_ptr, bsr_col_ind, block_dim, info, B, ldb,
                                X, ldx, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrsm_solve(handle::rocsparse_handle,
                                                      dir::rocsparse_direction,
                                                      trans_A::rocsparse_operation,
                                                      trans_X::rocsparse_operation,
                                                      mb::rocsparse_int,
                                                      nrhs::rocsparse_int,
                                                      nnzb::rocsparse_int,
                                                      alpha::Ptr{rocsparse_double_complex},
                                                      descr::rocsparse_mat_descr,
                                                      bsr_val::Ptr{rocsparse_double_complex},
                                                      bsr_row_ptr::Ptr{rocsparse_int},
                                                      bsr_col_ind::Ptr{rocsparse_int},
                                                      block_dim::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      B::Ptr{rocsparse_double_complex},
                                                      ldb::rocsparse_int,
                                                      X::Ptr{rocsparse_double_complex},
                                                      ldx::rocsparse_int,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val,
                          csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrmm(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{Cfloat},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cfloat},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                B::Ptr{Cfloat}, ldb::rocsparse_int,
                                                beta::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_dcsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val,
                          csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrmm(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{Cdouble},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cdouble},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                B::Ptr{Cdouble}, ldb::rocsparse_int,
                                                beta::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_ccsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val,
                          csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrmm(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_float_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                B::Ptr{rocsparse_float_complex},
                                                ldb::rocsparse_int,
                                                beta::Ptr{rocsparse_float_complex},
                                                C::Ptr{rocsparse_float_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_zcsrmm(handle, trans_A, trans_B, m, n, k, nnz, alpha, descr, csr_val,
                          csr_row_ptr, csr_col_ind, B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrmm(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_double_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                B::Ptr{rocsparse_double_complex},
                                                ldb::rocsparse_int,
                                                beta::Ptr{rocsparse_double_complex},
                                                C::Ptr{rocsparse_double_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_csrsm_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsm_zero_pivot(handle::rocsparse_handle,
                                                          info::rocsparse_mat_info,
                                                          position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                      csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                      policy, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsm_buffer_size(handle::rocsparse_handle,
                                                            trans_A::rocsparse_operation,
                                                            trans_B::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            alpha::Ptr{Cfloat},
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{Cfloat},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            B::Ptr{Cfloat},
                                                            ldb::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            policy::rocsparse_solve_policy,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                      csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                      policy, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsm_buffer_size(handle::rocsparse_handle,
                                                            trans_A::rocsparse_operation,
                                                            trans_B::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            alpha::Ptr{Cdouble},
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{Cdouble},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            B::Ptr{Cdouble},
                                                            ldb::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            policy::rocsparse_solve_policy,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                      csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                      policy, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsm_buffer_size(handle::rocsparse_handle,
                                                            trans_A::rocsparse_operation,
                                                            trans_B::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            alpha::Ptr{rocsparse_float_complex},
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{rocsparse_float_complex},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            B::Ptr{rocsparse_float_complex},
                                                            ldb::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            policy::rocsparse_solve_policy,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsrsm_buffer_size(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                      csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                      policy, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsm_buffer_size(handle::rocsparse_handle,
                                                            trans_A::rocsparse_operation,
                                                            trans_B::rocsparse_operation,
                                                            m::rocsparse_int,
                                                            nrhs::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            alpha::Ptr{rocsparse_double_complex},
                                                            descr::rocsparse_mat_descr,
                                                            csr_val::Ptr{rocsparse_double_complex},
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            B::Ptr{rocsparse_double_complex},
                                                            ldb::rocsparse_int,
                                                            info::rocsparse_mat_info,
                                                            policy::rocsparse_solve_policy,
                                                            buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                   csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsm_analysis(handle::rocsparse_handle,
                                                         trans_A::rocsparse_operation,
                                                         trans_B::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         alpha::Ptr{Cfloat},
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cfloat},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         B::Ptr{Cfloat}, ldb::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                   csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsm_analysis(handle::rocsparse_handle,
                                                         trans_A::rocsparse_operation,
                                                         trans_B::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         alpha::Ptr{Cdouble},
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{Cdouble},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         B::Ptr{Cdouble},
                                                         ldb::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                   csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsm_analysis(handle::rocsparse_handle,
                                                         trans_A::rocsparse_operation,
                                                         trans_B::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         alpha::Ptr{rocsparse_float_complex},
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_float_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         B::Ptr{rocsparse_float_complex},
                                                         ldb::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrsm_analysis(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                   csr_val, csr_row_ptr, csr_col_ind, B, ldb, info,
                                   analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsm_analysis(handle::rocsparse_handle,
                                                         trans_A::rocsparse_operation,
                                                         trans_B::rocsparse_operation,
                                                         m::rocsparse_int,
                                                         nrhs::rocsparse_int,
                                                         nnz::rocsparse_int,
                                                         alpha::Ptr{rocsparse_double_complex},
                                                         descr::rocsparse_mat_descr,
                                                         csr_val::Ptr{rocsparse_double_complex},
                                                         csr_row_ptr::Ptr{rocsparse_int},
                                                         csr_col_ind::Ptr{rocsparse_int},
                                                         B::Ptr{rocsparse_double_complex},
                                                         ldb::rocsparse_int,
                                                         info::rocsparse_mat_info,
                                                         analysis::rocsparse_analysis_policy,
                                                         solve::rocsparse_solve_policy,
                                                         temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrsm_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrsm_clear(handle::rocsparse_handle,
                                                     info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrsm_solve(handle::rocsparse_handle,
                                                      trans_A::rocsparse_operation,
                                                      trans_B::rocsparse_operation,
                                                      m::rocsparse_int, nrhs::rocsparse_int,
                                                      nnz::rocsparse_int,
                                                      alpha::Ptr{Cfloat},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{Cfloat},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      B::Ptr{Cfloat}, ldb::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrsm_solve(handle::rocsparse_handle,
                                                      trans_A::rocsparse_operation,
                                                      trans_B::rocsparse_operation,
                                                      m::rocsparse_int, nrhs::rocsparse_int,
                                                      nnz::rocsparse_int,
                                                      alpha::Ptr{Cdouble},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{Cdouble},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      B::Ptr{Cdouble}, ldb::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrsm_solve(handle::rocsparse_handle,
                                                      trans_A::rocsparse_operation,
                                                      trans_B::rocsparse_operation,
                                                      m::rocsparse_int, nrhs::rocsparse_int,
                                                      nnz::rocsparse_int,
                                                      alpha::Ptr{rocsparse_float_complex},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{rocsparse_float_complex},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      B::Ptr{rocsparse_float_complex},
                                                      ldb::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrsm_solve(handle, trans_A, trans_B, m, nrhs, nnz, alpha, descr,
                                csr_val, csr_row_ptr, csr_col_ind, B, ldb, info, policy,
                                temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrsm_solve(handle::rocsparse_handle,
                                                      trans_A::rocsparse_operation,
                                                      trans_B::rocsparse_operation,
                                                      m::rocsparse_int, nrhs::rocsparse_int,
                                                      nnz::rocsparse_int,
                                                      alpha::Ptr{rocsparse_double_complex},
                                                      descr::rocsparse_mat_descr,
                                                      csr_val::Ptr{rocsparse_double_complex},
                                                      csr_row_ptr::Ptr{rocsparse_int},
                                                      csr_col_ind::Ptr{rocsparse_int},
                                                      B::Ptr{rocsparse_double_complex},
                                                      ldb::rocsparse_int,
                                                      info::rocsparse_mat_info,
                                                      policy::rocsparse_solve_policy,
                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                            bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim,
                            B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgebsrmm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, n::rocsparse_int,
                                                  kb::rocsparse_int, nnzb::rocsparse_int,
                                                  alpha::Ptr{Cfloat},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cfloat},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  B::Ptr{Cfloat}, ldb::rocsparse_int,
                                                  beta::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                  ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_dgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                            bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim,
                            B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgebsrmm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, n::rocsparse_int,
                                                  kb::rocsparse_int, nnzb::rocsparse_int,
                                                  alpha::Ptr{Cdouble},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cdouble},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  B::Ptr{Cdouble}, ldb::rocsparse_int,
                                                  beta::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                  ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_cgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                            bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim,
                            B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgebsrmm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, n::rocsparse_int,
                                                  kb::rocsparse_int, nnzb::rocsparse_int,
                                                  alpha::Ptr{rocsparse_float_complex},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  B::Ptr{rocsparse_float_complex},
                                                  ldb::rocsparse_int,
                                                  beta::Ptr{rocsparse_float_complex},
                                                  C::Ptr{rocsparse_float_complex},
                                                  ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_zgebsrmm(handle, dir, trans_A, trans_B, mb, n, kb, nnzb, alpha, descr,
                            bsr_val, bsr_row_ptr, bsr_col_ind, row_block_dim, col_block_dim,
                            B, ldb, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgebsrmm(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  trans_A::rocsparse_operation,
                                                  trans_B::rocsparse_operation,
                                                  mb::rocsparse_int, n::rocsparse_int,
                                                  kb::rocsparse_int, nnzb::rocsparse_int,
                                                  alpha::Ptr{rocsparse_double_complex},
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  row_block_dim::rocsparse_int,
                                                  col_block_dim::rocsparse_int,
                                                  B::Ptr{rocsparse_double_complex},
                                                  ldb::rocsparse_int,
                                                  beta::Ptr{rocsparse_double_complex},
                                                  C::Ptr{rocsparse_double_complex},
                                                  ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_sgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr,
                          csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgemmi(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{Cfloat}, A::Ptr{Cfloat},
                                                lda::rocsparse_int,
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cfloat},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                beta::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_dgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr,
                          csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgemmi(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{Cdouble}, A::Ptr{Cdouble},
                                                lda::rocsparse_int,
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{Cdouble},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                beta::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_cgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr,
                          csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgemmi(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_float_complex},
                                                A::Ptr{rocsparse_float_complex},
                                                lda::rocsparse_int,
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_float_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                beta::Ptr{rocsparse_float_complex},
                                                C::Ptr{rocsparse_float_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_zgemmi(handle, trans_A, trans_B, m, n, k, nnz, alpha, A, lda, descr,
                          csr_val, csr_row_ptr, csr_col_ind, beta, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgemmi(handle::rocsparse_handle,
                                                trans_A::rocsparse_operation,
                                                trans_B::rocsparse_operation,
                                                m::rocsparse_int, n::rocsparse_int,
                                                k::rocsparse_int, nnz::rocsparse_int,
                                                alpha::Ptr{rocsparse_double_complex},
                                                A::Ptr{rocsparse_double_complex},
                                                lda::rocsparse_int,
                                                descr::rocsparse_mat_descr,
                                                csr_val::Ptr{rocsparse_double_complex},
                                                csr_row_ptr::Ptr{rocsparse_int},
                                                csr_col_ind::Ptr{rocsparse_int},
                                                beta::Ptr{rocsparse_double_complex},
                                                C::Ptr{rocsparse_double_complex},
                                                ldc::rocsparse_int)::rocsparse_status)
end

function rocsparse_bsric0_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsric0_zero_pivot(handle::rocsparse_handle,
                                                           info::rocsparse_mat_info,
                                                           position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                       bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsric0_buffer_size(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             bsr_val::Ptr{Cfloat},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             block_dim::rocsparse_int,
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                       bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsric0_buffer_size(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             bsr_val::Ptr{Cdouble},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             block_dim::rocsparse_int,
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                       bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsric0_buffer_size(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             bsr_val::Ptr{rocsparse_float_complex},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             block_dim::rocsparse_int,
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zbsric0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                       bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsric0_buffer_size(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             bsr_val::Ptr{rocsparse_double_complex},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             block_dim::rocsparse_int,
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                    bsr_col_ind, block_dim, info, analysis, solve,
                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsric0_analysis(handle::rocsparse_handle,
                                                          dir::rocsparse_direction,
                                                          mb::rocsparse_int,
                                                          nnzb::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          bsr_val::Ptr{Cfloat},
                                                          bsr_row_ptr::Ptr{rocsparse_int},
                                                          bsr_col_ind::Ptr{rocsparse_int},
                                                          block_dim::rocsparse_int,
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                    bsr_col_ind, block_dim, info, analysis, solve,
                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsric0_analysis(handle::rocsparse_handle,
                                                          dir::rocsparse_direction,
                                                          mb::rocsparse_int,
                                                          nnzb::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          bsr_val::Ptr{Cdouble},
                                                          bsr_row_ptr::Ptr{rocsparse_int},
                                                          bsr_col_ind::Ptr{rocsparse_int},
                                                          block_dim::rocsparse_int,
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                    bsr_col_ind, block_dim, info, analysis, solve,
                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsric0_analysis(handle::rocsparse_handle,
                                                          dir::rocsparse_direction,
                                                          mb::rocsparse_int,
                                                          nnzb::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          bsr_val::Ptr{rocsparse_float_complex},
                                                          bsr_row_ptr::Ptr{rocsparse_int},
                                                          bsr_col_ind::Ptr{rocsparse_int},
                                                          block_dim::rocsparse_int,
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsric0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                    bsr_col_ind, block_dim, info, analysis, solve,
                                    temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsric0_analysis(handle::rocsparse_handle,
                                                          dir::rocsparse_direction,
                                                          mb::rocsparse_int,
                                                          nnzb::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          bsr_val::Ptr{rocsparse_double_complex},
                                                          bsr_row_ptr::Ptr{rocsparse_int},
                                                          bsr_col_ind::Ptr{rocsparse_int},
                                                          block_dim::rocsparse_int,
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsric0_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsric0_clear(handle::rocsparse_handle,
                                                      info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_sbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                           block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsric0(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 mb::rocsparse_int, nnzb::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{Cfloat},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                           block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsric0(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 mb::rocsparse_int, nnzb::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{Cdouble},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                           block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsric0(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 mb::rocsparse_int, nnzb::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{rocsparse_float_complex},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsric0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                           block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsric0(handle::rocsparse_handle,
                                                 dir::rocsparse_direction,
                                                 mb::rocsparse_int, nnzb::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 bsr_val::Ptr{rocsparse_double_complex},
                                                 bsr_row_ptr::Ptr{rocsparse_int},
                                                 bsr_col_ind::Ptr{rocsparse_int},
                                                 block_dim::rocsparse_int,
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsrilu0_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrilu0_zero_pivot(handle::rocsparse_handle,
                                                            info::rocsparse_mat_info,
                                                            position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_sbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cfloat},
                                                                boost_val::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cdouble},
                                                                boost_val::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_cbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cfloat},
                                                                boost_val::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cdouble},
                                                                boost_val::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_dsbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dsbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                 info::rocsparse_mat_info,
                                                                 enable_boost::Cint,
                                                                 boost_tol::Ptr{Cdouble},
                                                                 boost_val::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dcbsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcbsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                 info::rocsparse_mat_info,
                                                                 enable_boost::Cint,
                                                                 boost_tol::Ptr{Cdouble},
                                                                 boost_val::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_sbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                        bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrilu0_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              mb::rocsparse_int,
                                                              nnzb::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              bsr_val::Ptr{Cfloat},
                                                              bsr_row_ptr::Ptr{rocsparse_int},
                                                              bsr_col_ind::Ptr{rocsparse_int},
                                                              block_dim::rocsparse_int,
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                        bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrilu0_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              mb::rocsparse_int,
                                                              nnzb::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              bsr_val::Ptr{Cdouble},
                                                              bsr_row_ptr::Ptr{rocsparse_int},
                                                              bsr_col_ind::Ptr{rocsparse_int},
                                                              block_dim::rocsparse_int,
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                        bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrilu0_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              mb::rocsparse_int,
                                                              nnzb::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              bsr_val::Ptr{rocsparse_float_complex},
                                                              bsr_row_ptr::Ptr{rocsparse_int},
                                                              bsr_col_ind::Ptr{rocsparse_int},
                                                              block_dim::rocsparse_int,
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zbsrilu0_buffer_size(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                        bsr_col_ind, block_dim, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrilu0_buffer_size(handle::rocsparse_handle,
                                                              dir::rocsparse_direction,
                                                              mb::rocsparse_int,
                                                              nnzb::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              bsr_val::Ptr{rocsparse_double_complex},
                                                              bsr_row_ptr::Ptr{rocsparse_int},
                                                              bsr_col_ind::Ptr{rocsparse_int},
                                                              block_dim::rocsparse_int,
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                     bsr_col_ind, block_dim, info, analysis, solve,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrilu0_analysis(handle::rocsparse_handle,
                                                           dir::rocsparse_direction,
                                                           mb::rocsparse_int,
                                                           nnzb::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           bsr_val::Ptr{Cfloat},
                                                           bsr_row_ptr::Ptr{rocsparse_int},
                                                           bsr_col_ind::Ptr{rocsparse_int},
                                                           block_dim::rocsparse_int,
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                     bsr_col_ind, block_dim, info, analysis, solve,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrilu0_analysis(handle::rocsparse_handle,
                                                           dir::rocsparse_direction,
                                                           mb::rocsparse_int,
                                                           nnzb::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           bsr_val::Ptr{Cdouble},
                                                           bsr_row_ptr::Ptr{rocsparse_int},
                                                           bsr_col_ind::Ptr{rocsparse_int},
                                                           block_dim::rocsparse_int,
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                     bsr_col_ind, block_dim, info, analysis, solve,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrilu0_analysis(handle::rocsparse_handle,
                                                           dir::rocsparse_direction,
                                                           mb::rocsparse_int,
                                                           nnzb::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           bsr_val::Ptr{rocsparse_float_complex},
                                                           bsr_row_ptr::Ptr{rocsparse_int},
                                                           bsr_col_ind::Ptr{rocsparse_int},
                                                           block_dim::rocsparse_int,
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrilu0_analysis(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr,
                                     bsr_col_ind, block_dim, info, analysis, solve,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrilu0_analysis(handle::rocsparse_handle,
                                                           dir::rocsparse_direction,
                                                           mb::rocsparse_int,
                                                           nnzb::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           bsr_val::Ptr{rocsparse_double_complex},
                                                           bsr_row_ptr::Ptr{rocsparse_int},
                                                           bsr_col_ind::Ptr{rocsparse_int},
                                                           block_dim::rocsparse_int,
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_bsrilu0_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_bsrilu0_clear(handle::rocsparse_handle,
                                                       info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_sbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                            block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sbsrilu0(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nnzb::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cfloat},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                            block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dbsrilu0(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nnzb::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{Cdouble},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                            block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cbsrilu0(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nnzb::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_float_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zbsrilu0(handle, dir, mb, nnzb, descr, bsr_val, bsr_row_ptr, bsr_col_ind,
                            block_dim, info, policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zbsrilu0(handle::rocsparse_handle,
                                                  dir::rocsparse_direction,
                                                  mb::rocsparse_int, nnzb::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  bsr_val::Ptr{rocsparse_double_complex},
                                                  bsr_row_ptr::Ptr{rocsparse_int},
                                                  bsr_col_ind::Ptr{rocsparse_int},
                                                  block_dim::rocsparse_int,
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csric0_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csric0_zero_pivot(handle::rocsparse_handle,
                                                           info::rocsparse_mat_info,
                                                           position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_csric0_singular_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csric0_singular_pivot(handle::rocsparse_handle,
                                                               info::rocsparse_mat_info,
                                                               position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_csric0_set_tolerance(handle, info, tolerance)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csric0_set_tolerance(handle::rocsparse_handle,
                                                              info::rocsparse_mat_info,
                                                              tolerance::Cdouble)::rocsparse_status)
end

function rocsparse_csric0_get_tolerance(handle, info, tolerance)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csric0_get_tolerance(handle::rocsparse_handle,
                                                              info::rocsparse_mat_info,
                                                              tolerance::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_scsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                       csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsric0_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             csr_val::Ptr{Cfloat},
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                       csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsric0_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             csr_val::Ptr{Cdouble},
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                       csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsric0_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             csr_val::Ptr{rocsparse_float_complex},
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsric0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                       csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsric0_buffer_size(handle::rocsparse_handle,
                                                             m::rocsparse_int,
                                                             nnz::rocsparse_int,
                                                             descr::rocsparse_mat_descr,
                                                             csr_val::Ptr{rocsparse_double_complex},
                                                             csr_row_ptr::Ptr{rocsparse_int},
                                                             csr_col_ind::Ptr{rocsparse_int},
                                                             info::rocsparse_mat_info,
                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                    csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsric0_analysis(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          nnz::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{Cfloat},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                    csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsric0_analysis(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          nnz::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{Cdouble},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                    csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsric0_analysis(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          nnz::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{rocsparse_float_complex},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsric0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                    csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsric0_analysis(handle::rocsparse_handle,
                                                          m::rocsparse_int,
                                                          nnz::rocsparse_int,
                                                          descr::rocsparse_mat_descr,
                                                          csr_val::Ptr{rocsparse_double_complex},
                                                          csr_row_ptr::Ptr{rocsparse_int},
                                                          csr_col_ind::Ptr{rocsparse_int},
                                                          info::rocsparse_mat_info,
                                                          analysis::rocsparse_analysis_policy,
                                                          solve::rocsparse_solve_policy,
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csric0_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csric0_clear(handle::rocsparse_handle,
                                                      info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                           policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsric0(handle::rocsparse_handle, m::rocsparse_int,
                                                 nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csr_val::Ptr{Cfloat},
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 csr_col_ind::Ptr{rocsparse_int},
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                           policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsric0(handle::rocsparse_handle, m::rocsparse_int,
                                                 nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csr_val::Ptr{Cdouble},
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 csr_col_ind::Ptr{rocsparse_int},
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                           policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsric0(handle::rocsparse_handle, m::rocsparse_int,
                                                 nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csr_val::Ptr{rocsparse_float_complex},
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 csr_col_ind::Ptr{rocsparse_int},
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsric0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                           policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsric0(handle::rocsparse_handle, m::rocsparse_int,
                                                 nnz::rocsparse_int,
                                                 descr::rocsparse_mat_descr,
                                                 csr_val::Ptr{rocsparse_double_complex},
                                                 csr_row_ptr::Ptr{rocsparse_int},
                                                 csr_col_ind::Ptr{rocsparse_int},
                                                 info::rocsparse_mat_info,
                                                 policy::rocsparse_solve_policy,
                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrilu0_zero_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrilu0_zero_pivot(handle::rocsparse_handle,
                                                            info::rocsparse_mat_info,
                                                            position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_csrilu0_set_tolerance(handle, info, tolerance)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrilu0_set_tolerance(handle::rocsparse_handle,
                                                               info::rocsparse_mat_info,
                                                               tolerance::Cdouble)::rocsparse_status)
end

function rocsparse_csrilu0_get_tolerance(handle, info, tolerance)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrilu0_get_tolerance(handle::rocsparse_handle,
                                                               info::rocsparse_mat_info,
                                                               tolerance::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_csrilu0_singular_pivot(handle, info, position)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrilu0_singular_pivot(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                position::Ptr{rocsparse_int})::rocsparse_status)
end

function rocsparse_scsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cfloat},
                                                                boost_val::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dcsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cdouble},
                                                                boost_val::Ptr{Cdouble})::rocsparse_status)
end

function rocsparse_ccsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cfloat},
                                                                boost_val::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_zcsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                info::rocsparse_mat_info,
                                                                enable_boost::Cint,
                                                                boost_tol::Ptr{Cdouble},
                                                                boost_val::Ptr{rocsparse_double_complex})::rocsparse_status)
end

function rocsparse_dscsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dscsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                 info::rocsparse_mat_info,
                                                                 enable_boost::Cint,
                                                                 boost_tol::Ptr{Cdouble},
                                                                 boost_val::Ptr{Cfloat})::rocsparse_status)
end

function rocsparse_dccsrilu0_numeric_boost(handle, info, enable_boost, boost_tol, boost_val)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dccsrilu0_numeric_boost(handle::rocsparse_handle,
                                                                 info::rocsparse_mat_info,
                                                                 enable_boost::Cint,
                                                                 boost_tol::Ptr{Cdouble},
                                                                 boost_val::Ptr{rocsparse_float_complex})::rocsparse_status)
end

function rocsparse_scsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrilu0_buffer_size(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{Cfloat},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrilu0_buffer_size(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{Cdouble},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrilu0_buffer_size(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{rocsparse_float_complex},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcsrilu0_buffer_size(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                        csr_col_ind, info, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrilu0_buffer_size(handle::rocsparse_handle,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              descr::rocsparse_mat_descr,
                                                              csr_val::Ptr{rocsparse_double_complex},
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              info::rocsparse_mat_info,
                                                              buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrilu0_analysis(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cfloat},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrilu0_analysis(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{Cdouble},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrilu0_analysis(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrilu0_analysis(handle, m, nnz, descr, csr_val, csr_row_ptr,
                                     csr_col_ind, info, analysis, solve, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrilu0_analysis(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           descr::rocsparse_mat_descr,
                                                           csr_val::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           info::rocsparse_mat_info,
                                                           analysis::rocsparse_analysis_policy,
                                                           solve::rocsparse_solve_policy,
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_csrilu0_clear(handle, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csrilu0_clear(handle::rocsparse_handle,
                                                       info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                            policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrilu0(handle::rocsparse_handle,
                                                  m::rocsparse_int, nnz::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cfloat},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                            policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrilu0(handle::rocsparse_handle,
                                                  m::rocsparse_int, nnz::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{Cdouble},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                            policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrilu0(handle::rocsparse_handle,
                                                  m::rocsparse_int, nnz::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_float_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsrilu0(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind, info,
                            policy, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrilu0(handle::rocsparse_handle,
                                                  m::rocsparse_int, nnz::rocsparse_int,
                                                  descr::rocsparse_mat_descr,
                                                  csr_val::Ptr{rocsparse_double_complex},
                                                  csr_row_ptr::Ptr{rocsparse_int},
                                                  csr_col_ind::Ptr{rocsparse_int},
                                                  info::rocsparse_mat_info,
                                                  policy::rocsparse_solve_policy,
                                                  temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_itilu0_alg_::UInt32 begin
    rocsparse_itilu0_alg_default = 0
    rocsparse_itilu0_alg_async_inplace = 1
    rocsparse_itilu0_alg_async_split = 2
    rocsparse_itilu0_alg_sync_split = 3
    rocsparse_itilu0_alg_sync_split_fusion = 4
end

const rocsparse_itilu0_alg = rocsparse_itilu0_alg_

function rocsparse_csritilu0_buffer_size(handle, alg, option, nmaxiter, m, nnz, csr_row_ptr,
                                         csr_col_ind, idx_base, datatype, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csritilu0_buffer_size(handle::rocsparse_handle,
                                                               alg::rocsparse_itilu0_alg,
                                                               option::rocsparse_int,
                                                               nmaxiter::rocsparse_int,
                                                               m::rocsparse_int,
                                                               nnz::rocsparse_int,
                                                               csr_row_ptr::Ptr{rocsparse_int},
                                                               csr_col_ind::Ptr{rocsparse_int},
                                                               idx_base::rocsparse_index_base,
                                                               datatype::rocsparse_datatype,
                                                               buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_csritilu0_preprocess(handle, alg, option, nmaxiter, m, nnz, csr_row_ptr,
                                        csr_col_ind, idx_base, datatype, buffer_size,
                                        buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_csritilu0_preprocess(handle::rocsparse_handle,
                                                              alg::rocsparse_itilu0_alg,
                                                              option::rocsparse_int,
                                                              nmaxiter::rocsparse_int,
                                                              m::rocsparse_int,
                                                              nnz::rocsparse_int,
                                                              csr_row_ptr::Ptr{rocsparse_int},
                                                              csr_col_ind::Ptr{rocsparse_int},
                                                              idx_base::rocsparse_index_base,
                                                              datatype::rocsparse_datatype,
                                                              buffer_size::Csize_t,
                                                              buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsritilu0_compute(handle, alg, option, nmaxiter, tol, m, nnz,
                                      csr_row_ptr, csr_col_ind, csr_val, ilu0, idx_base,
                                      buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritilu0_compute(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            option::rocsparse_int,
                                                            nmaxiter::Ptr{rocsparse_int},
                                                            tol::Cfloat, m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            csr_val::Ptr{Cfloat},
                                                            ilu0::Ptr{Cfloat},
                                                            idx_base::rocsparse_index_base,
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritilu0_compute(handle, alg, option, nmaxiter, tol, m, nnz,
                                      csr_row_ptr, csr_col_ind, csr_val, ilu0, idx_base,
                                      buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritilu0_compute(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            option::rocsparse_int,
                                                            nmaxiter::Ptr{rocsparse_int},
                                                            tol::Cdouble, m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            csr_val::Ptr{Cdouble},
                                                            ilu0::Ptr{Cdouble},
                                                            idx_base::rocsparse_index_base,
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritilu0_compute(handle, alg, option, nmaxiter, tol, m, nnz,
                                      csr_row_ptr, csr_col_ind, csr_val, ilu0, idx_base,
                                      buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritilu0_compute(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            option::rocsparse_int,
                                                            nmaxiter::Ptr{rocsparse_int},
                                                            tol::Cfloat, m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            csr_val::Ptr{rocsparse_float_complex},
                                                            ilu0::Ptr{rocsparse_float_complex},
                                                            idx_base::rocsparse_index_base,
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritilu0_compute(handle, alg, option, nmaxiter, tol, m, nnz,
                                      csr_row_ptr, csr_col_ind, csr_val, ilu0, idx_base,
                                      buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritilu0_compute(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            option::rocsparse_int,
                                                            nmaxiter::Ptr{rocsparse_int},
                                                            tol::Cdouble, m::rocsparse_int,
                                                            nnz::rocsparse_int,
                                                            csr_row_ptr::Ptr{rocsparse_int},
                                                            csr_col_ind::Ptr{rocsparse_int},
                                                            csr_val::Ptr{rocsparse_double_complex},
                                                            ilu0::Ptr{rocsparse_double_complex},
                                                            idx_base::rocsparse_index_base,
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsritilu0_compute_ex(handle, alg, option, nmaxiter, nfreeiter, tol, m,
                                         nnz, csr_row_ptr, csr_col_ind, csr_val, ilu0,
                                         idx_base, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritilu0_compute_ex(handle::rocsparse_handle,
                                                               alg::rocsparse_itilu0_alg,
                                                               option::rocsparse_int,
                                                               nmaxiter::Ptr{rocsparse_int},
                                                               nfreeiter::rocsparse_int,
                                                               tol::Cfloat,
                                                               m::rocsparse_int,
                                                               nnz::rocsparse_int,
                                                               csr_row_ptr::Ptr{rocsparse_int},
                                                               csr_col_ind::Ptr{rocsparse_int},
                                                               csr_val::Ptr{Cfloat},
                                                               ilu0::Ptr{Cfloat},
                                                               idx_base::rocsparse_index_base,
                                                               buffer_size::Csize_t,
                                                               buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritilu0_compute_ex(handle, alg, option, nmaxiter, nfreeiter, tol, m,
                                         nnz, csr_row_ptr, csr_col_ind, csr_val, ilu0,
                                         idx_base, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritilu0_compute_ex(handle::rocsparse_handle,
                                                               alg::rocsparse_itilu0_alg,
                                                               option::rocsparse_int,
                                                               nmaxiter::Ptr{rocsparse_int},
                                                               nfreeiter::rocsparse_int,
                                                               tol::Cdouble,
                                                               m::rocsparse_int,
                                                               nnz::rocsparse_int,
                                                               csr_row_ptr::Ptr{rocsparse_int},
                                                               csr_col_ind::Ptr{rocsparse_int},
                                                               csr_val::Ptr{Cdouble},
                                                               ilu0::Ptr{Cdouble},
                                                               idx_base::rocsparse_index_base,
                                                               buffer_size::Csize_t,
                                                               buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritilu0_compute_ex(handle, alg, option, nmaxiter, nfreeiter, tol, m,
                                         nnz, csr_row_ptr, csr_col_ind, csr_val, ilu0,
                                         idx_base, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritilu0_compute_ex(handle::rocsparse_handle,
                                                               alg::rocsparse_itilu0_alg,
                                                               option::rocsparse_int,
                                                               nmaxiter::Ptr{rocsparse_int},
                                                               nfreeiter::rocsparse_int,
                                                               tol::Cfloat,
                                                               m::rocsparse_int,
                                                               nnz::rocsparse_int,
                                                               csr_row_ptr::Ptr{rocsparse_int},
                                                               csr_col_ind::Ptr{rocsparse_int},
                                                               csr_val::Ptr{rocsparse_float_complex},
                                                               ilu0::Ptr{rocsparse_float_complex},
                                                               idx_base::rocsparse_index_base,
                                                               buffer_size::Csize_t,
                                                               buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritilu0_compute_ex(handle, alg, option, nmaxiter, nfreeiter, tol, m,
                                         nnz, csr_row_ptr, csr_col_ind, csr_val, ilu0,
                                         idx_base, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritilu0_compute_ex(handle::rocsparse_handle,
                                                               alg::rocsparse_itilu0_alg,
                                                               option::rocsparse_int,
                                                               nmaxiter::Ptr{rocsparse_int},
                                                               nfreeiter::rocsparse_int,
                                                               tol::Cdouble,
                                                               m::rocsparse_int,
                                                               nnz::rocsparse_int,
                                                               csr_row_ptr::Ptr{rocsparse_int},
                                                               csr_col_ind::Ptr{rocsparse_int},
                                                               csr_val::Ptr{rocsparse_double_complex},
                                                               ilu0::Ptr{rocsparse_double_complex},
                                                               idx_base::rocsparse_index_base,
                                                               buffer_size::Csize_t,
                                                               buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsritilu0_history(handle, alg, niter, data, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsritilu0_history(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            niter::Ptr{rocsparse_int},
                                                            data::Ptr{Cfloat},
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcsritilu0_history(handle, alg, niter, data, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsritilu0_history(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            niter::Ptr{rocsparse_int},
                                                            data::Ptr{Cdouble},
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccsritilu0_history(handle, alg, niter, data, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsritilu0_history(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            niter::Ptr{rocsparse_int},
                                                            data::Ptr{Cfloat},
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcsritilu0_history(handle, alg, niter, data, buffer_size, buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsritilu0_history(handle::rocsparse_handle,
                                                            alg::rocsparse_itilu0_alg,
                                                            niter::Ptr{rocsparse_int},
                                                            data::Ptr{Cdouble},
                                                            buffer_size::Csize_t,
                                                            buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_gpsv_interleaved_alg_::UInt32 begin
    rocsparse_gpsv_interleaved_alg_default = 0
    rocsparse_gpsv_interleaved_alg_qr = 1
end

const rocsparse_gpsv_interleaved_alg = rocsparse_gpsv_interleaved_alg_

function rocsparse_sgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgpsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gpsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             ds::Ptr{Cfloat},
                                                                             dl::Ptr{Cfloat},
                                                                             d::Ptr{Cfloat},
                                                                             du::Ptr{Cfloat},
                                                                             dw::Ptr{Cfloat},
                                                                             x::Ptr{Cfloat},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgpsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gpsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             ds::Ptr{Cdouble},
                                                                             dl::Ptr{Cdouble},
                                                                             d::Ptr{Cdouble},
                                                                             du::Ptr{Cdouble},
                                                                             dw::Ptr{Cdouble},
                                                                             x::Ptr{Cdouble},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgpsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gpsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             ds::Ptr{rocsparse_float_complex},
                                                                             dl::Ptr{rocsparse_float_complex},
                                                                             d::Ptr{rocsparse_float_complex},
                                                                             du::Ptr{rocsparse_float_complex},
                                                                             dw::Ptr{rocsparse_float_complex},
                                                                             x::Ptr{rocsparse_float_complex},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgpsv_interleaved_batch_buffer_size(handle, alg, m, ds, dl, d, du, dw, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgpsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gpsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             ds::Ptr{rocsparse_double_complex},
                                                                             dl::Ptr{rocsparse_double_complex},
                                                                             d::Ptr{rocsparse_double_complex},
                                                                             du::Ptr{rocsparse_double_complex},
                                                                             dw::Ptr{rocsparse_double_complex},
                                                                             x::Ptr{rocsparse_double_complex},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x,
                                           batch_count, batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgpsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gpsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 ds::Ptr{Cfloat},
                                                                 dl::Ptr{Cfloat},
                                                                 d::Ptr{Cfloat},
                                                                 du::Ptr{Cfloat},
                                                                 dw::Ptr{Cfloat},
                                                                 x::Ptr{Cfloat},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x,
                                           batch_count, batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgpsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gpsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 ds::Ptr{Cdouble},
                                                                 dl::Ptr{Cdouble},
                                                                 d::Ptr{Cdouble},
                                                                 du::Ptr{Cdouble},
                                                                 dw::Ptr{Cdouble},
                                                                 x::Ptr{Cdouble},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x,
                                           batch_count, batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgpsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gpsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 ds::Ptr{rocsparse_float_complex},
                                                                 dl::Ptr{rocsparse_float_complex},
                                                                 d::Ptr{rocsparse_float_complex},
                                                                 du::Ptr{rocsparse_float_complex},
                                                                 dw::Ptr{rocsparse_float_complex},
                                                                 x::Ptr{rocsparse_float_complex},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgpsv_interleaved_batch(handle, alg, m, ds, dl, d, du, dw, x,
                                           batch_count, batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgpsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gpsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 ds::Ptr{rocsparse_double_complex},
                                                                 dl::Ptr{rocsparse_double_complex},
                                                                 d::Ptr{rocsparse_double_complex},
                                                                 du::Ptr{rocsparse_double_complex},
                                                                 dw::Ptr{rocsparse_double_complex},
                                                                 x::Ptr{rocsparse_double_complex},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_buffer_size(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           dl::Ptr{Cfloat}, d::Ptr{Cfloat},
                                                           du::Ptr{Cfloat}, B::Ptr{Cfloat},
                                                           ldb::rocsparse_int,
                                                           buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_buffer_size(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           dl::Ptr{Cdouble},
                                                           d::Ptr{Cdouble},
                                                           du::Ptr{Cdouble},
                                                           B::Ptr{Cdouble},
                                                           ldb::rocsparse_int,
                                                           buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_buffer_size(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           dl::Ptr{rocsparse_float_complex},
                                                           d::Ptr{rocsparse_float_complex},
                                                           du::Ptr{rocsparse_float_complex},
                                                           B::Ptr{rocsparse_float_complex},
                                                           ldb::rocsparse_int,
                                                           buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgtsv_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_buffer_size(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           dl::Ptr{rocsparse_double_complex},
                                                           d::Ptr{rocsparse_double_complex},
                                                           du::Ptr{rocsparse_double_complex},
                                                           B::Ptr{rocsparse_double_complex},
                                                           ldb::rocsparse_int,
                                                           buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv(handle::rocsparse_handle, m::rocsparse_int,
                                               n::rocsparse_int, dl::Ptr{Cfloat},
                                               d::Ptr{Cfloat}, du::Ptr{Cfloat},
                                               B::Ptr{Cfloat}, ldb::rocsparse_int,
                                               temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv(handle::rocsparse_handle, m::rocsparse_int,
                                               n::rocsparse_int, dl::Ptr{Cdouble},
                                               d::Ptr{Cdouble}, du::Ptr{Cdouble},
                                               B::Ptr{Cdouble}, ldb::rocsparse_int,
                                               temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv(handle::rocsparse_handle, m::rocsparse_int,
                                               n::rocsparse_int,
                                               dl::Ptr{rocsparse_float_complex},
                                               d::Ptr{rocsparse_float_complex},
                                               du::Ptr{rocsparse_float_complex},
                                               B::Ptr{rocsparse_float_complex},
                                               ldb::rocsparse_int,
                                               temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgtsv(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv(handle::rocsparse_handle, m::rocsparse_int,
                                               n::rocsparse_int,
                                               dl::Ptr{rocsparse_double_complex},
                                               d::Ptr{rocsparse_double_complex},
                                               du::Ptr{rocsparse_double_complex},
                                               B::Ptr{rocsparse_double_complex},
                                               ldb::rocsparse_int,
                                               temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_no_pivot_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    dl::Ptr{Cfloat},
                                                                    d::Ptr{Cfloat},
                                                                    du::Ptr{Cfloat},
                                                                    B::Ptr{Cfloat},
                                                                    ldb::rocsparse_int,
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_no_pivot_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    dl::Ptr{Cdouble},
                                                                    d::Ptr{Cdouble},
                                                                    du::Ptr{Cdouble},
                                                                    B::Ptr{Cdouble},
                                                                    ldb::rocsparse_int,
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_no_pivot_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    dl::Ptr{rocsparse_float_complex},
                                                                    d::Ptr{rocsparse_float_complex},
                                                                    du::Ptr{rocsparse_float_complex},
                                                                    B::Ptr{rocsparse_float_complex},
                                                                    ldb::rocsparse_int,
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgtsv_no_pivot_buffer_size(handle, m, n, dl, d, du, B, ldb, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_no_pivot_buffer_size(handle::rocsparse_handle,
                                                                    m::rocsparse_int,
                                                                    n::rocsparse_int,
                                                                    dl::Ptr{rocsparse_double_complex},
                                                                    d::Ptr{rocsparse_double_complex},
                                                                    du::Ptr{rocsparse_double_complex},
                                                                    B::Ptr{rocsparse_double_complex},
                                                                    ldb::rocsparse_int,
                                                                    buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_no_pivot(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        dl::Ptr{Cfloat}, d::Ptr{Cfloat},
                                                        du::Ptr{Cfloat}, B::Ptr{Cfloat},
                                                        ldb::rocsparse_int,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_no_pivot(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        dl::Ptr{Cdouble}, d::Ptr{Cdouble},
                                                        du::Ptr{Cdouble}, B::Ptr{Cdouble},
                                                        ldb::rocsparse_int,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_no_pivot(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        dl::Ptr{rocsparse_float_complex},
                                                        d::Ptr{rocsparse_float_complex},
                                                        du::Ptr{rocsparse_float_complex},
                                                        B::Ptr{rocsparse_float_complex},
                                                        ldb::rocsparse_int,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgtsv_no_pivot(handle, m, n, dl, d, du, B, ldb, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_no_pivot(handle::rocsparse_handle,
                                                        m::rocsparse_int, n::rocsparse_int,
                                                        dl::Ptr{rocsparse_double_complex},
                                                        d::Ptr{rocsparse_double_complex},
                                                        du::Ptr{rocsparse_double_complex},
                                                        B::Ptr{rocsparse_double_complex},
                                                        ldb::rocsparse_int,
                                                        temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_sgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x,
                                                            batch_count, batch_stride,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_no_pivot_strided_batch_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  dl::Ptr{Cfloat},
                                                                                  d::Ptr{Cfloat},
                                                                                  du::Ptr{Cfloat},
                                                                                  x::Ptr{Cfloat},
                                                                                  batch_count::rocsparse_int,
                                                                                  batch_stride::rocsparse_int,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x,
                                                            batch_count, batch_stride,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_no_pivot_strided_batch_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  dl::Ptr{Cdouble},
                                                                                  d::Ptr{Cdouble},
                                                                                  du::Ptr{Cdouble},
                                                                                  x::Ptr{Cdouble},
                                                                                  batch_count::rocsparse_int,
                                                                                  batch_stride::rocsparse_int,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x,
                                                            batch_count, batch_stride,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_no_pivot_strided_batch_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  dl::Ptr{rocsparse_float_complex},
                                                                                  d::Ptr{rocsparse_float_complex},
                                                                                  du::Ptr{rocsparse_float_complex},
                                                                                  x::Ptr{rocsparse_float_complex},
                                                                                  batch_count::rocsparse_int,
                                                                                  batch_stride::rocsparse_int,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgtsv_no_pivot_strided_batch_buffer_size(handle, m, dl, d, du, x,
                                                            batch_count, batch_stride,
                                                            buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_no_pivot_strided_batch_buffer_size(handle::rocsparse_handle,
                                                                                  m::rocsparse_int,
                                                                                  dl::Ptr{rocsparse_double_complex},
                                                                                  d::Ptr{rocsparse_double_complex},
                                                                                  du::Ptr{rocsparse_double_complex},
                                                                                  x::Ptr{rocsparse_double_complex},
                                                                                  batch_count::rocsparse_int,
                                                                                  batch_stride::rocsparse_int,
                                                                                  buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count,
                                                batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_no_pivot_strided_batch(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      dl::Ptr{Cfloat},
                                                                      d::Ptr{Cfloat},
                                                                      du::Ptr{Cfloat},
                                                                      x::Ptr{Cfloat},
                                                                      batch_count::rocsparse_int,
                                                                      batch_stride::rocsparse_int,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count,
                                                batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_no_pivot_strided_batch(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      dl::Ptr{Cdouble},
                                                                      d::Ptr{Cdouble},
                                                                      du::Ptr{Cdouble},
                                                                      x::Ptr{Cdouble},
                                                                      batch_count::rocsparse_int,
                                                                      batch_stride::rocsparse_int,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count,
                                                batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_no_pivot_strided_batch(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      dl::Ptr{rocsparse_float_complex},
                                                                      d::Ptr{rocsparse_float_complex},
                                                                      du::Ptr{rocsparse_float_complex},
                                                                      x::Ptr{rocsparse_float_complex},
                                                                      batch_count::rocsparse_int,
                                                                      batch_stride::rocsparse_int,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgtsv_no_pivot_strided_batch(handle, m, dl, d, du, x, batch_count,
                                                batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_no_pivot_strided_batch(handle::rocsparse_handle,
                                                                      m::rocsparse_int,
                                                                      dl::Ptr{rocsparse_double_complex},
                                                                      d::Ptr{rocsparse_double_complex},
                                                                      du::Ptr{rocsparse_double_complex},
                                                                      x::Ptr{rocsparse_double_complex},
                                                                      batch_count::rocsparse_int,
                                                                      batch_stride::rocsparse_int,
                                                                      temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

@cenum rocsparse_gtsv_interleaved_alg_::UInt32 begin
    rocsparse_gtsv_interleaved_alg_default = 0
    rocsparse_gtsv_interleaved_alg_thomas = 1
    rocsparse_gtsv_interleaved_alg_lu = 2
    rocsparse_gtsv_interleaved_alg_qr = 3
end

const rocsparse_gtsv_interleaved_alg = rocsparse_gtsv_interleaved_alg_

function rocsparse_sgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gtsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             dl::Ptr{Cfloat},
                                                                             d::Ptr{Cfloat},
                                                                             du::Ptr{Cfloat},
                                                                             x::Ptr{Cfloat},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gtsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             dl::Ptr{Cdouble},
                                                                             d::Ptr{Cdouble},
                                                                             du::Ptr{Cdouble},
                                                                             x::Ptr{Cdouble},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_cgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gtsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             dl::Ptr{rocsparse_float_complex},
                                                                             d::Ptr{rocsparse_float_complex},
                                                                             du::Ptr{rocsparse_float_complex},
                                                                             x::Ptr{rocsparse_float_complex},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zgtsv_interleaved_batch_buffer_size(handle, alg, m, dl, d, du, x,
                                                       batch_count, batch_stride,
                                                       buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_interleaved_batch_buffer_size(handle::rocsparse_handle,
                                                                             alg::rocsparse_gtsv_interleaved_alg,
                                                                             m::rocsparse_int,
                                                                             dl::Ptr{rocsparse_double_complex},
                                                                             d::Ptr{rocsparse_double_complex},
                                                                             du::Ptr{rocsparse_double_complex},
                                                                             x::Ptr{rocsparse_double_complex},
                                                                             batch_count::rocsparse_int,
                                                                             batch_stride::rocsparse_int,
                                                                             buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_sgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count,
                                           batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_sgtsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gtsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 dl::Ptr{Cfloat},
                                                                 d::Ptr{Cfloat},
                                                                 du::Ptr{Cfloat},
                                                                 x::Ptr{Cfloat},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count,
                                           batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dgtsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gtsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 dl::Ptr{Cdouble},
                                                                 d::Ptr{Cdouble},
                                                                 du::Ptr{Cdouble},
                                                                 x::Ptr{Cdouble},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_cgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count,
                                           batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_cgtsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gtsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 dl::Ptr{rocsparse_float_complex},
                                                                 d::Ptr{rocsparse_float_complex},
                                                                 du::Ptr{rocsparse_float_complex},
                                                                 x::Ptr{rocsparse_float_complex},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zgtsv_interleaved_batch(handle, alg, m, dl, d, du, x, batch_count,
                                           batch_stride, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zgtsv_interleaved_batch(handle::rocsparse_handle,
                                                                 alg::rocsparse_gtsv_interleaved_alg,
                                                                 m::rocsparse_int,
                                                                 dl::Ptr{rocsparse_double_complex},
                                                                 d::Ptr{rocsparse_double_complex},
                                                                 du::Ptr{rocsparse_double_complex},
                                                                 x::Ptr{rocsparse_double_complex},
                                                                 batch_count::rocsparse_int,
                                                                 batch_stride::rocsparse_int,
                                                                 temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind,
                             fraction_to_color, ncolors, coloring, reordering, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scsrcolor(handle::rocsparse_handle,
                                                   m::rocsparse_int, nnz::rocsparse_int,
                                                   descr::rocsparse_mat_descr,
                                                   csr_val::Ptr{Cfloat},
                                                   csr_row_ptr::Ptr{rocsparse_int},
                                                   csr_col_ind::Ptr{rocsparse_int},
                                                   fraction_to_color::Ptr{Cfloat},
                                                   ncolors::Ptr{rocsparse_int},
                                                   coloring::Ptr{rocsparse_int},
                                                   reordering::Ptr{rocsparse_int},
                                                   info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_dcsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind,
                             fraction_to_color, ncolors, coloring, reordering, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcsrcolor(handle::rocsparse_handle,
                                                   m::rocsparse_int, nnz::rocsparse_int,
                                                   descr::rocsparse_mat_descr,
                                                   csr_val::Ptr{Cdouble},
                                                   csr_row_ptr::Ptr{rocsparse_int},
                                                   csr_col_ind::Ptr{rocsparse_int},
                                                   fraction_to_color::Ptr{Cdouble},
                                                   ncolors::Ptr{rocsparse_int},
                                                   coloring::Ptr{rocsparse_int},
                                                   reordering::Ptr{rocsparse_int},
                                                   info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_ccsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind,
                             fraction_to_color, ncolors, coloring, reordering, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccsrcolor(handle::rocsparse_handle,
                                                   m::rocsparse_int, nnz::rocsparse_int,
                                                   descr::rocsparse_mat_descr,
                                                   csr_val::Ptr{rocsparse_float_complex},
                                                   csr_row_ptr::Ptr{rocsparse_int},
                                                   csr_col_ind::Ptr{rocsparse_int},
                                                   fraction_to_color::Ptr{Cfloat},
                                                   ncolors::Ptr{rocsparse_int},
                                                   coloring::Ptr{rocsparse_int},
                                                   reordering::Ptr{rocsparse_int},
                                                   info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_zcsrcolor(handle, m, nnz, descr, csr_val, csr_row_ptr, csr_col_ind,
                             fraction_to_color, ncolors, coloring, reordering, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcsrcolor(handle::rocsparse_handle,
                                                   m::rocsparse_int, nnz::rocsparse_int,
                                                   descr::rocsparse_mat_descr,
                                                   csr_val::Ptr{rocsparse_double_complex},
                                                   csr_row_ptr::Ptr{rocsparse_int},
                                                   csr_col_ind::Ptr{rocsparse_int},
                                                   fraction_to_color::Ptr{Cdouble},
                                                   ncolors::Ptr{rocsparse_int},
                                                   coloring::Ptr{rocsparse_int},
                                                   reordering::Ptr{rocsparse_int},
                                                   info::rocsparse_mat_info)::rocsparse_status)
end

function rocsparse_scheck_matrix_coo_buffer_size(handle, m, n, nnz, coo_val, coo_row_ind,
                                                 coo_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_coo_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       coo_val::Ptr{Cfloat},
                                                                       coo_row_ind::Ptr{rocsparse_int},
                                                                       coo_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_coo_buffer_size(handle, m, n, nnz, coo_val, coo_row_ind,
                                                 coo_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_coo_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       coo_val::Ptr{Cdouble},
                                                                       coo_row_ind::Ptr{rocsparse_int},
                                                                       coo_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_coo_buffer_size(handle, m, n, nnz, coo_val, coo_row_ind,
                                                 coo_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_coo_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       coo_val::Ptr{rocsparse_float_complex},
                                                                       coo_row_ind::Ptr{rocsparse_int},
                                                                       coo_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_coo_buffer_size(handle, m, n, nnz, coo_val, coo_row_ind,
                                                 coo_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_coo_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       coo_val::Ptr{rocsparse_double_complex},
                                                                       coo_row_ind::Ptr{rocsparse_int},
                                                                       coo_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_coo(handle, m, n, nnz, coo_val, coo_row_ind, coo_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_coo(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           coo_val::Ptr{Cfloat},
                                                           coo_row_ind::Ptr{rocsparse_int},
                                                           coo_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_coo(handle, m, n, nnz, coo_val, coo_row_ind, coo_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_coo(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           coo_val::Ptr{Cdouble},
                                                           coo_row_ind::Ptr{rocsparse_int},
                                                           coo_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_coo(handle, m, n, nnz, coo_val, coo_row_ind, coo_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_coo(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           coo_val::Ptr{rocsparse_float_complex},
                                                           coo_row_ind::Ptr{rocsparse_int},
                                                           coo_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_coo(handle, m, n, nnz, coo_val, coo_row_ind, coo_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_coo(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           coo_val::Ptr{rocsparse_double_complex},
                                                           coo_row_ind::Ptr{rocsparse_int},
                                                           coo_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scheck_matrix_csc_buffer_size(handle, m, n, nnz, csc_val, csc_col_ptr,
                                                 csc_row_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_csc_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csc_val::Ptr{Cfloat},
                                                                       csc_col_ptr::Ptr{rocsparse_int},
                                                                       csc_row_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_csc_buffer_size(handle, m, n, nnz, csc_val, csc_col_ptr,
                                                 csc_row_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_csc_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csc_val::Ptr{Cdouble},
                                                                       csc_col_ptr::Ptr{rocsparse_int},
                                                                       csc_row_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_csc_buffer_size(handle, m, n, nnz, csc_val, csc_col_ptr,
                                                 csc_row_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_csc_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csc_val::Ptr{rocsparse_float_complex},
                                                                       csc_col_ptr::Ptr{rocsparse_int},
                                                                       csc_row_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_csc_buffer_size(handle, m, n, nnz, csc_val, csc_col_ptr,
                                                 csc_row_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_csc_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csc_val::Ptr{rocsparse_double_complex},
                                                                       csc_col_ptr::Ptr{rocsparse_int},
                                                                       csc_row_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_csc(handle, m, n, nnz, csc_val, csc_col_ptr, csc_row_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_csc(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csc_val::Ptr{Cfloat},
                                                           csc_col_ptr::Ptr{rocsparse_int},
                                                           csc_row_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_csc(handle, m, n, nnz, csc_val, csc_col_ptr, csc_row_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_csc(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csc_val::Ptr{Cdouble},
                                                           csc_col_ptr::Ptr{rocsparse_int},
                                                           csc_row_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_csc(handle, m, n, nnz, csc_val, csc_col_ptr, csc_row_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_csc(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csc_val::Ptr{rocsparse_float_complex},
                                                           csc_col_ptr::Ptr{rocsparse_int},
                                                           csc_row_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_csc(handle, m, n, nnz, csc_val, csc_col_ptr, csc_row_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_csc(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csc_val::Ptr{rocsparse_double_complex},
                                                           csc_col_ptr::Ptr{rocsparse_int},
                                                           csc_row_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scheck_matrix_csr_buffer_size(handle, m, n, nnz, csr_val, csr_row_ptr,
                                                 csr_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_csr_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csr_val::Ptr{Cfloat},
                                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                                       csr_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_csr_buffer_size(handle, m, n, nnz, csr_val, csr_row_ptr,
                                                 csr_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_csr_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csr_val::Ptr{Cdouble},
                                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                                       csr_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_csr_buffer_size(handle, m, n, nnz, csr_val, csr_row_ptr,
                                                 csr_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_csr_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csr_val::Ptr{rocsparse_float_complex},
                                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                                       csr_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_csr_buffer_size(handle, m, n, nnz, csr_val, csr_row_ptr,
                                                 csr_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_csr_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       nnz::rocsparse_int,
                                                                       csr_val::Ptr{rocsparse_double_complex},
                                                                       csr_row_ptr::Ptr{rocsparse_int},
                                                                       csr_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_csr(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_csr(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csr_val::Ptr{Cfloat},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_csr(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_csr(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csr_val::Ptr{Cdouble},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_csr(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_csr(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csr_val::Ptr{rocsparse_float_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_csr(handle, m, n, nnz, csr_val, csr_row_ptr, csr_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_csr(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           nnz::rocsparse_int,
                                                           csr_val::Ptr{rocsparse_double_complex},
                                                           csr_row_ptr::Ptr{rocsparse_int},
                                                           csr_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scheck_matrix_ell_buffer_size(handle, m, n, ell_width, ell_val,
                                                 ell_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_ell_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       ell_width::rocsparse_int,
                                                                       ell_val::Ptr{Cfloat},
                                                                       ell_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_ell_buffer_size(handle, m, n, ell_width, ell_val,
                                                 ell_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_ell_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       ell_width::rocsparse_int,
                                                                       ell_val::Ptr{Cdouble},
                                                                       ell_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_ell_buffer_size(handle, m, n, ell_width, ell_val,
                                                 ell_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_ell_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       ell_width::rocsparse_int,
                                                                       ell_val::Ptr{rocsparse_float_complex},
                                                                       ell_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_ell_buffer_size(handle, m, n, ell_width, ell_val,
                                                 ell_col_ind, idx_base, matrix_type, uplo,
                                                 storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_ell_buffer_size(handle::rocsparse_handle,
                                                                       m::rocsparse_int,
                                                                       n::rocsparse_int,
                                                                       ell_width::rocsparse_int,
                                                                       ell_val::Ptr{rocsparse_double_complex},
                                                                       ell_col_ind::Ptr{rocsparse_int},
                                                                       idx_base::rocsparse_index_base,
                                                                       matrix_type::rocsparse_matrix_type,
                                                                       uplo::rocsparse_fill_mode,
                                                                       storage::rocsparse_storage_mode,
                                                                       buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_ell(handle, m, n, ell_width, ell_val, ell_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_ell(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           ell_width::rocsparse_int,
                                                           ell_val::Ptr{Cfloat},
                                                           ell_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_ell(handle, m, n, ell_width, ell_val, ell_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_ell(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           ell_width::rocsparse_int,
                                                           ell_val::Ptr{Cdouble},
                                                           ell_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_ell(handle, m, n, ell_width, ell_val, ell_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_ell(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           ell_width::rocsparse_int,
                                                           ell_val::Ptr{rocsparse_float_complex},
                                                           ell_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_ell(handle, m, n, ell_width, ell_val, ell_col_ind,
                                     idx_base, matrix_type, uplo, storage, data_status,
                                     temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_ell(handle::rocsparse_handle,
                                                           m::rocsparse_int,
                                                           n::rocsparse_int,
                                                           ell_width::rocsparse_int,
                                                           ell_val::Ptr{rocsparse_double_complex},
                                                           ell_col_ind::Ptr{rocsparse_int},
                                                           idx_base::rocsparse_index_base,
                                                           matrix_type::rocsparse_matrix_type,
                                                           uplo::rocsparse_fill_mode,
                                                           storage::rocsparse_storage_mode,
                                                           data_status::Ptr{rocsparse_data_status},
                                                           temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scheck_matrix_gebsc_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsc_val, bsc_col_ptr,
                                                   bsc_row_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_gebsc_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsc_val::Ptr{Cfloat},
                                                                         bsc_col_ptr::Ptr{rocsparse_int},
                                                                         bsc_row_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_gebsc_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsc_val, bsc_col_ptr,
                                                   bsc_row_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_gebsc_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsc_val::Ptr{Cdouble},
                                                                         bsc_col_ptr::Ptr{rocsparse_int},
                                                                         bsc_row_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_gebsc_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsc_val, bsc_col_ptr,
                                                   bsc_row_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_gebsc_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsc_val::Ptr{rocsparse_float_complex},
                                                                         bsc_col_ptr::Ptr{rocsparse_int},
                                                                         bsc_row_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_gebsc_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsc_val, bsc_col_ptr,
                                                   bsc_row_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_gebsc_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsc_val::Ptr{rocsparse_double_complex},
                                                                         bsc_col_ptr::Ptr{rocsparse_int},
                                                                         bsc_row_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_gebsc(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsc_val, bsc_col_ptr, bsc_row_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_gebsc(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsc_val::Ptr{Cfloat},
                                                             bsc_col_ptr::Ptr{rocsparse_int},
                                                             bsc_row_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_gebsc(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsc_val, bsc_col_ptr, bsc_row_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_gebsc(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsc_val::Ptr{Cdouble},
                                                             bsc_col_ptr::Ptr{rocsparse_int},
                                                             bsc_row_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_gebsc(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsc_val, bsc_col_ptr, bsc_row_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_gebsc(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsc_val::Ptr{rocsparse_float_complex},
                                                             bsc_col_ptr::Ptr{rocsparse_int},
                                                             bsc_row_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_gebsc(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsc_val, bsc_col_ptr, bsc_row_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_gebsc(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsc_val::Ptr{rocsparse_double_complex},
                                                             bsc_col_ptr::Ptr{rocsparse_int},
                                                             bsc_row_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_scheck_matrix_gebsr_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsr_val, bsr_row_ptr,
                                                   bsr_col_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_gebsr_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsr_val::Ptr{Cfloat},
                                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_dcheck_matrix_gebsr_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsr_val, bsr_row_ptr,
                                                   bsr_col_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_gebsr_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsr_val::Ptr{Cdouble},
                                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_ccheck_matrix_gebsr_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsr_val, bsr_row_ptr,
                                                   bsr_col_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_gebsr_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsr_val::Ptr{rocsparse_float_complex},
                                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_zcheck_matrix_gebsr_buffer_size(handle, dir, mb, nb, nnzb, row_block_dim,
                                                   col_block_dim, bsr_val, bsr_row_ptr,
                                                   bsr_col_ind, idx_base, matrix_type, uplo,
                                                   storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_gebsr_buffer_size(handle::rocsparse_handle,
                                                                         dir::rocsparse_direction,
                                                                         mb::rocsparse_int,
                                                                         nb::rocsparse_int,
                                                                         nnzb::rocsparse_int,
                                                                         row_block_dim::rocsparse_int,
                                                                         col_block_dim::rocsparse_int,
                                                                         bsr_val::Ptr{rocsparse_double_complex},
                                                                         bsr_row_ptr::Ptr{rocsparse_int},
                                                                         bsr_col_ind::Ptr{rocsparse_int},
                                                                         idx_base::rocsparse_index_base,
                                                                         matrix_type::rocsparse_matrix_type,
                                                                         uplo::rocsparse_fill_mode,
                                                                         storage::rocsparse_storage_mode,
                                                                         buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_scheck_matrix_gebsr(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsr_val, bsr_row_ptr, bsr_col_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_scheck_matrix_gebsr(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsr_val::Ptr{Cfloat},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_dcheck_matrix_gebsr(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsr_val, bsr_row_ptr, bsr_col_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_dcheck_matrix_gebsr(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsr_val::Ptr{Cdouble},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_ccheck_matrix_gebsr(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsr_val, bsr_row_ptr, bsr_col_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_ccheck_matrix_gebsr(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsr_val::Ptr{rocsparse_float_complex},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_zcheck_matrix_gebsr(handle, dir, mb, nb, nnzb, row_block_dim,
                                       col_block_dim, bsr_val, bsr_row_ptr, bsr_col_ind,
                                       idx_base, matrix_type, uplo, storage, data_status,
                                       temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_zcheck_matrix_gebsr(handle::rocsparse_handle,
                                                             dir::rocsparse_direction,
                                                             mb::rocsparse_int,
                                                             nb::rocsparse_int,
                                                             nnzb::rocsparse_int,
                                                             row_block_dim::rocsparse_int,
                                                             col_block_dim::rocsparse_int,
                                                             bsr_val::Ptr{rocsparse_double_complex},
                                                             bsr_row_ptr::Ptr{rocsparse_int},
                                                             bsr_col_ind::Ptr{rocsparse_int},
                                                             idx_base::rocsparse_index_base,
                                                             matrix_type::rocsparse_matrix_type,
                                                             uplo::rocsparse_fill_mode,
                                                             storage::rocsparse_storage_mode,
                                                             data_status::Ptr{rocsparse_data_status},
                                                             temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

function rocsparse_check_matrix_hyb_buffer_size(handle, hyb, idx_base, matrix_type, uplo,
                                                storage, buffer_size)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_check_matrix_hyb_buffer_size(handle::rocsparse_handle,
                                                                      hyb::rocsparse_hyb_mat,
                                                                      idx_base::rocsparse_index_base,
                                                                      matrix_type::rocsparse_matrix_type,
                                                                      uplo::rocsparse_fill_mode,
                                                                      storage::rocsparse_storage_mode,
                                                                      buffer_size::Ptr{Csize_t})::rocsparse_status)
end

function rocsparse_check_matrix_hyb(handle, hyb, idx_base, matrix_type, uplo, storage,
                                    data_status, temp_buffer)
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_check_matrix_hyb(handle::rocsparse_handle,
                                                          hyb::rocsparse_hyb_mat,
                                                          idx_base::rocsparse_index_base,
                                                          matrix_type::rocsparse_matrix_type,
                                                          uplo::rocsparse_fill_mode,
                                                          storage::rocsparse_storage_mode,
                                                          data_status::Ptr{rocsparse_data_status},
                                                          temp_buffer::Ptr{Cvoid})::rocsparse_status)
end

# no prototype is found for this function at rocsparse-roctx.h:42:6, please use with caution
function rocsparse_enable_roctx()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_enable_roctx()::Cvoid)
end

# no prototype is found for this function at rocsparse-roctx.h:48:23, please use with caution
function rocsparse_disable_roctx()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_disable_roctx()::Cvoid)
end

# no prototype is found for this function at rocsparse-roctx.h:54:22, please use with caution
function rocsparse_state_roctx()
    AMDGPU.prepare_state()
    @check @ccall(librocsparse.rocsparse_state_roctx()::Cint)
end

@cenum rocsparse_layer_mode::UInt32 begin
    rocsparse_layer_mode_none = 0
    rocsparse_layer_mode_log_trace = 1
    rocsparse_layer_mode_log_bench = 2
    rocsparse_layer_mode_log_debug = 4
end

@cenum rocsparse_itilu0_option_::UInt32 begin
    rocsparse_itilu0_option_verbose = 1
    rocsparse_itilu0_option_stopping_criteria = 2
    rocsparse_itilu0_option_compute_nrm_correction = 4
    rocsparse_itilu0_option_compute_nrm_residual = 8
    rocsparse_itilu0_option_convergence_history = 16
    rocsparse_itilu0_option_coo_format = 32
end

const rocsparse_itilu0_option = rocsparse_itilu0_option_

@cenum rocsparse_sptrsv_alg_::UInt32 begin
    rocsparse_sptrsv_alg_default = 0
end

const rocsparse_sptrsv_alg = rocsparse_sptrsv_alg_

@cenum rocsparse_sptrsm_alg_::UInt32 begin
    rocsparse_sptrsm_alg_default = 0
end

const rocsparse_sptrsm_alg = rocsparse_sptrsm_alg_

@cenum rocsparse_spgeam_alg_::UInt32 begin
    rocsparse_spgeam_alg_default = 0
end

const rocsparse_spgeam_alg = rocsparse_spgeam_alg_

struct rocsparse_bfloat16
    data::UInt16
end

# Skipping MacroDefinition: ROCSPARSE_EXPORT __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: ROCSPARSE_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: ROCSPARSE_DEPRECATED __attribute__ ( ( __deprecated__ ) )

# Skipping MacroDefinition: ROCSPARSE_DEVICE_ILF static __device__ __forceinline__

const ROCSPARSE_VERSION_MAJOR = 4

const ROCSPARSE_VERSION_MINOR = 3

const ROCSPARSE_VERSION_PATCH = 0
