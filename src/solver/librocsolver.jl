const rocsolver_int = rocblas_int

const rocsolver_stride = rocblas_stride

const rocsolver_float_complex = rocblas_float_complex

const rocsolver_double_complex = rocblas_double_complex

const rocsolver_half = rocblas_half

const rocsolver_handle = rocblas_handle

const rocsolver_operation = rocblas_operation

const rocsolver_fill = rocblas_fill

const rocsolver_diagonal = rocblas_diagonal

const rocsolver_side = rocblas_side

const rocsolver_status = rocblas_status

const rocsolver_layer_mode = rocblas_layer_mode

@cenum rocblas_direct_::UInt32 begin
    rocblas_forward_direction = 171
    rocblas_backward_direction = 172
end

const rocblas_direct = rocblas_direct_

const rocsolver_direction = rocblas_direct

@cenum rocblas_storev_::UInt32 begin
    rocblas_column_wise = 181
    rocblas_row_wise = 182
end

const rocblas_storev = rocblas_storev_

const rocsolver_storev = rocblas_storev

function rocsolver_create_handle(handle)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_create_handle(handle::Ptr{rocsolver_handle})::rocsolver_status)
end

function rocsolver_destroy_handle(handle)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_destroy_handle(handle::rocsolver_handle)::rocsolver_status)
end

function rocsolver_set_stream(handle, stream)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_set_stream(handle::rocsolver_handle,
                                                    stream::hipStream_t)::rocsolver_status)
end

function rocsolver_get_stream(handle, stream)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_stream(handle::rocsolver_handle,
                                                    stream::Ptr{hipStream_t})::rocsolver_status)
end

function rocsolver_set_vector(n, elem_size, x, incx, y, incy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_set_vector(n::rocsolver_int,
                                                    elem_size::rocsolver_int, x::Ptr{Cvoid},
                                                    incx::rocsolver_int, y::Ptr{Cvoid},
                                                    incy::rocsolver_int)::rocsolver_status)
end

function rocsolver_get_vector(n, elem_size, x, incx, y, incy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_vector(n::rocsolver_int,
                                                    elem_size::rocsolver_int, x::Ptr{Cvoid},
                                                    incx::rocsolver_int, y::Ptr{Cvoid},
                                                    incy::rocsolver_int)::rocsolver_status)
end

function rocsolver_set_matrix(rows, cols, elem_size, a, lda, b, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_set_matrix(rows::rocsolver_int,
                                                    cols::rocsolver_int,
                                                    elem_size::rocsolver_int, a::Ptr{Cvoid},
                                                    lda::rocsolver_int, b::Ptr{Cvoid},
                                                    ldb::rocsolver_int)::rocsolver_status)
end

function rocsolver_get_matrix(rows, cols, elem_size, a, lda, b, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_matrix(rows::rocsolver_int,
                                                    cols::rocsolver_int,
                                                    elem_size::rocsolver_int, a::Ptr{Cvoid},
                                                    lda::rocsolver_int, b::Ptr{Cvoid},
                                                    ldb::rocsolver_int)::rocsolver_status)
end

const rocblas_layer_mode_flags = UInt32

@cenum rocblas_layer_mode_ex_::UInt32 begin
    rocblas_layer_mode_ex_log_kernel = 16
end

const rocblas_layer_mode_ex = rocblas_layer_mode_ex_

@cenum rocblas_svect_::UInt32 begin
    rocblas_svect_all = 191
    rocblas_svect_singular = 192
    rocblas_svect_overwrite = 193
    rocblas_svect_none = 194
end

const rocblas_svect = rocblas_svect_

@cenum rocblas_workmode_::UInt32 begin
    rocblas_outofplace = 201
    rocblas_inplace = 202
end

const rocblas_workmode = rocblas_workmode_

@cenum rocblas_evect_::UInt32 begin
    rocblas_evect_original = 211
    rocblas_evect_tridiagonal = 212
    rocblas_evect_none = 213
end

const rocblas_evect = rocblas_evect_

@cenum rocblas_eform_::UInt32 begin
    rocblas_eform_ax = 221
    rocblas_eform_abx = 222
    rocblas_eform_bax = 223
end

const rocblas_eform = rocblas_eform_

@cenum rocblas_erange_::UInt32 begin
    rocblas_erange_all = 231
    rocblas_erange_value = 232
    rocblas_erange_index = 233
end

const rocblas_erange = rocblas_erange_

@cenum rocblas_eorder_::UInt32 begin
    rocblas_eorder_blocks = 241
    rocblas_eorder_entire = 242
end

const rocblas_eorder = rocblas_eorder_

@cenum rocblas_esort_::UInt32 begin
    rocblas_esort_none = 251
    rocblas_esort_ascending = 252
end

const rocblas_esort = rocblas_esort_

@cenum rocblas_srange_::UInt32 begin
    rocblas_srange_all = 261
    rocblas_srange_value = 262
    rocblas_srange_index = 263
end

const rocblas_srange = rocblas_srange_

mutable struct rocsolver_rfinfo_ end

const rocsolver_rfinfo = Ptr{rocsolver_rfinfo_}

@cenum rocsolver_rfinfo_mode_::UInt32 begin
    rocsolver_rfinfo_mode_lu = 271
    rocsolver_rfinfo_mode_cholesky = 272
end

const rocsolver_rfinfo_mode = rocsolver_rfinfo_mode_

@cenum rocblas_pivot_::UInt32 begin
    rocblas_pivot_variable = 281
    rocblas_pivot_top = 282
    rocblas_pivot_bottom = 283
end

const rocblas_pivot = rocblas_pivot_

@cenum rocsolver_alg_mode_::UInt32 begin
    rocsolver_alg_mode_gpu = 291
    rocsolver_alg_mode_hybrid = 292
    rocsolver_alg_mode_mixed = 293
end

const rocsolver_alg_mode = rocsolver_alg_mode_

@cenum rocsolver_function_::UInt32 begin
    rocsolver_function_bdsqr = 401
    rocsolver_function_gesvd = 402
    rocsolver_function_sterf = 403
    rocsolver_function_steqr = 404
    rocsolver_function_syev_heev = 405
end

const rocsolver_function = rocsolver_function_

function rocsolver_get_version_string(buf, len)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_version_string(buf::Ptr{Cchar},
                                                            len::Csize_t)::rocblas_status)
end

function rocsolver_get_version_string_size(len)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_version_string_size(len::Ptr{Csize_t})::rocblas_status)
end

function rocsolver_log_begin()
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_begin()::rocblas_status)
end

function rocsolver_log_end()
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_end()::rocblas_status)
end

function rocsolver_log_set_layer_mode(layer_mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_set_layer_mode(layer_mode::rocblas_layer_mode_flags)::rocblas_status)
end

function rocsolver_log_set_max_levels(max_levels)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_set_max_levels(max_levels::rocblas_int)::rocblas_status)
end

function rocsolver_log_restore_defaults()
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_restore_defaults()::rocblas_status)
end

function rocsolver_log_write_profile()
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_write_profile()::rocblas_status)
end

function rocsolver_log_flush_profile()
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_log_flush_profile()::rocblas_status)
end

function rocsolver_set_alg_mode(handle, func, mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_set_alg_mode(handle::rocblas_handle,
                                                      func::rocsolver_function,
                                                      mode::rocsolver_alg_mode)::rocblas_status)
end

function rocsolver_get_alg_mode(handle, func, mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_alg_mode(handle::rocblas_handle,
                                                      func::rocsolver_function,
                                                      mode::Ptr{rocsolver_alg_mode})::rocblas_status)
end

function rocsolver_clacgv(handle, n, x, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clacgv(handle::rocblas_handle, n::rocblas_int,
                                                x::Ptr{rocblas_float_complex},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_zlacgv(handle, n, x, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlacgv(handle::rocblas_handle, n::rocblas_int,
                                                x::Ptr{rocblas_double_complex},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_clacgv_64(handle, n, x, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clacgv_64(handle::rocblas_handle, n::Int64,
                                                   x::Ptr{rocblas_float_complex},
                                                   incx::Int64)::rocblas_status)
end

function rocsolver_zlacgv_64(handle, n, x, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlacgv_64(handle::rocblas_handle, n::Int64,
                                                   x::Ptr{rocblas_double_complex},
                                                   incx::Int64)::rocblas_status)
end

function rocsolver_slaswp(handle, n, A, lda, k1, k2, ipiv, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slaswp(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                k1::rocblas_int, k2::rocblas_int,
                                                ipiv::Ptr{rocblas_int},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_dlaswp(handle, n, A, lda, k1, k2, ipiv, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlaswp(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                k1::rocblas_int, k2::rocblas_int,
                                                ipiv::Ptr{rocblas_int},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_claswp(handle, n, A, lda, k1, k2, ipiv, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_claswp(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, k1::rocblas_int,
                                                k2::rocblas_int, ipiv::Ptr{rocblas_int},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_zlaswp(handle, n, A, lda, k1, k2, ipiv, incx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlaswp(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, k1::rocblas_int,
                                                k2::rocblas_int, ipiv::Ptr{rocblas_int},
                                                incx::rocblas_int)::rocblas_status)
end

function rocsolver_slarfg(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarfg(handle::rocblas_handle, n::rocblas_int,
                                                alpha::Ptr{Cfloat}, x::Ptr{Cfloat},
                                                incx::rocblas_int,
                                                tau::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dlarfg(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarfg(handle::rocblas_handle, n::rocblas_int,
                                                alpha::Ptr{Cdouble}, x::Ptr{Cdouble},
                                                incx::rocblas_int,
                                                tau::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_clarfg(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarfg(handle::rocblas_handle, n::rocblas_int,
                                                alpha::Ptr{rocblas_float_complex},
                                                x::Ptr{rocblas_float_complex},
                                                incx::rocblas_int,
                                                tau::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zlarfg(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarfg(handle::rocblas_handle, n::rocblas_int,
                                                alpha::Ptr{rocblas_double_complex},
                                                x::Ptr{rocblas_double_complex},
                                                incx::rocblas_int,
                                                tau::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_slarfg_64(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarfg_64(handle::rocblas_handle, n::Int64,
                                                   alpha::Ptr{Cfloat}, x::Ptr{Cfloat},
                                                   incx::Int64,
                                                   tau::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dlarfg_64(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarfg_64(handle::rocblas_handle, n::Int64,
                                                   alpha::Ptr{Cdouble}, x::Ptr{Cdouble},
                                                   incx::Int64,
                                                   tau::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_clarfg_64(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarfg_64(handle::rocblas_handle, n::Int64,
                                                   alpha::Ptr{rocblas_float_complex},
                                                   x::Ptr{rocblas_float_complex},
                                                   incx::Int64,
                                                   tau::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zlarfg_64(handle, n, alpha, x, incx, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarfg_64(handle::rocblas_handle, n::Int64,
                                                   alpha::Ptr{rocblas_double_complex},
                                                   x::Ptr{rocblas_double_complex},
                                                   incx::Int64,
                                                   tau::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_slarft(handle, direct, storev, n, k, V, ldv, tau, T, ldt)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarft(handle::rocblas_handle,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, n::rocblas_int,
                                                k::rocblas_int, V::Ptr{Cfloat},
                                                ldv::rocblas_int, tau::Ptr{Cfloat},
                                                T::Ptr{Cfloat},
                                                ldt::rocblas_int)::rocblas_status)
end

function rocsolver_dlarft(handle, direct, storev, n, k, V, ldv, tau, T, ldt)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarft(handle::rocblas_handle,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, n::rocblas_int,
                                                k::rocblas_int, V::Ptr{Cdouble},
                                                ldv::rocblas_int, tau::Ptr{Cdouble},
                                                T::Ptr{Cdouble},
                                                ldt::rocblas_int)::rocblas_status)
end

function rocsolver_clarft(handle, direct, storev, n, k, V, ldv, tau, T, ldt)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarft(handle::rocblas_handle,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, n::rocblas_int,
                                                k::rocblas_int,
                                                V::Ptr{rocblas_float_complex},
                                                ldv::rocblas_int,
                                                tau::Ptr{rocblas_float_complex},
                                                T::Ptr{rocblas_float_complex},
                                                ldt::rocblas_int)::rocblas_status)
end

function rocsolver_zlarft(handle, direct, storev, n, k, V, ldv, tau, T, ldt)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarft(handle::rocblas_handle,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, n::rocblas_int,
                                                k::rocblas_int,
                                                V::Ptr{rocblas_double_complex},
                                                ldv::rocblas_int,
                                                tau::Ptr{rocblas_double_complex},
                                                T::Ptr{rocblas_double_complex},
                                                ldt::rocblas_int)::rocblas_status)
end

function rocsolver_slarf(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarf(handle::rocblas_handle, side::rocblas_side,
                                               m::rocblas_int, n::rocblas_int,
                                               x::Ptr{Cfloat}, incx::rocblas_int,
                                               alpha::Ptr{Cfloat}, A::Ptr{Cfloat},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_dlarf(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarf(handle::rocblas_handle, side::rocblas_side,
                                               m::rocblas_int, n::rocblas_int,
                                               x::Ptr{Cdouble}, incx::rocblas_int,
                                               alpha::Ptr{Cdouble}, A::Ptr{Cdouble},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_clarf(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarf(handle::rocblas_handle, side::rocblas_side,
                                               m::rocblas_int, n::rocblas_int,
                                               x::Ptr{rocblas_float_complex},
                                               incx::rocblas_int,
                                               alpha::Ptr{rocblas_float_complex},
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_zlarf(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarf(handle::rocblas_handle, side::rocblas_side,
                                               m::rocblas_int, n::rocblas_int,
                                               x::Ptr{rocblas_double_complex},
                                               incx::rocblas_int,
                                               alpha::Ptr{rocblas_double_complex},
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_slarf_64(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarf_64(handle::rocblas_handle,
                                                  side::rocblas_side, m::Int64, n::Int64,
                                                  x::Ptr{Cfloat}, incx::Int64,
                                                  alpha::Ptr{Cfloat}, A::Ptr{Cfloat},
                                                  lda::Int64)::rocblas_status)
end

function rocsolver_dlarf_64(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarf_64(handle::rocblas_handle,
                                                  side::rocblas_side, m::Int64, n::Int64,
                                                  x::Ptr{Cdouble}, incx::Int64,
                                                  alpha::Ptr{Cdouble}, A::Ptr{Cdouble},
                                                  lda::Int64)::rocblas_status)
end

function rocsolver_clarf_64(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarf_64(handle::rocblas_handle,
                                                  side::rocblas_side, m::Int64, n::Int64,
                                                  x::Ptr{rocblas_float_complex},
                                                  incx::Int64,
                                                  alpha::Ptr{rocblas_float_complex},
                                                  A::Ptr{rocblas_float_complex},
                                                  lda::Int64)::rocblas_status)
end

function rocsolver_zlarf_64(handle, side, m, n, x, incx, alpha, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarf_64(handle::rocblas_handle,
                                                  side::rocblas_side, m::Int64, n::Int64,
                                                  x::Ptr{rocblas_double_complex},
                                                  incx::Int64,
                                                  alpha::Ptr{rocblas_double_complex},
                                                  A::Ptr{rocblas_double_complex},
                                                  lda::Int64)::rocblas_status)
end

function rocsolver_slarfb(handle, side, trans, direct, storev, m, n, k, V, ldv, T, ldt, A,
                          lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slarfb(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                V::Ptr{Cfloat}, ldv::rocblas_int,
                                                T::Ptr{Cfloat}, ldt::rocblas_int,
                                                A::Ptr{Cfloat},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_dlarfb(handle, side, trans, direct, storev, m, n, k, V, ldv, T, ldt, A,
                          lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlarfb(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                V::Ptr{Cdouble}, ldv::rocblas_int,
                                                T::Ptr{Cdouble}, ldt::rocblas_int,
                                                A::Ptr{Cdouble},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_clarfb(handle, side, trans, direct, storev, m, n, k, V, ldv, T, ldt, A,
                          lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clarfb(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                V::Ptr{rocblas_float_complex},
                                                ldv::rocblas_int,
                                                T::Ptr{rocblas_float_complex},
                                                ldt::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_zlarfb(handle, side, trans, direct, storev, m, n, k, V, ldv, T, ldt, A,
                          lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlarfb(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation,
                                                direct::rocblas_direct,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                V::Ptr{rocblas_double_complex},
                                                ldv::rocblas_int,
                                                T::Ptr{rocblas_double_complex},
                                                ldt::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_slasr(handle, side, pivot, direct, m, n, C, S, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slasr(handle::rocblas_handle, side::rocblas_side,
                                               pivot::rocblas_pivot, direct::rocblas_direct,
                                               m::rocblas_int, n::rocblas_int,
                                               C::Ptr{Cfloat}, S::Ptr{Cfloat},
                                               A::Ptr{Cfloat},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_dlasr(handle, side, pivot, direct, m, n, C, S, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlasr(handle::rocblas_handle, side::rocblas_side,
                                               pivot::rocblas_pivot, direct::rocblas_direct,
                                               m::rocblas_int, n::rocblas_int,
                                               C::Ptr{Cdouble}, S::Ptr{Cdouble},
                                               A::Ptr{Cdouble},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_clasr(handle, side, pivot, direct, m, n, C, S, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clasr(handle::rocblas_handle, side::rocblas_side,
                                               pivot::rocblas_pivot, direct::rocblas_direct,
                                               m::rocblas_int, n::rocblas_int,
                                               C::Ptr{Cfloat}, S::Ptr{Cfloat},
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_zlasr(handle, side, pivot, direct, m, n, C, S, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlasr(handle::rocblas_handle, side::rocblas_side,
                                               pivot::rocblas_pivot, direct::rocblas_direct,
                                               m::rocblas_int, n::rocblas_int,
                                               C::Ptr{Cdouble}, S::Ptr{Cdouble},
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int)::rocblas_status)
end

function rocsolver_slabrd(handle, m, n, k, A, lda, D, E, tauq, taup, X, ldx, Y, ldy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slabrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                tauq::Ptr{Cfloat}, taup::Ptr{Cfloat},
                                                X::Ptr{Cfloat}, ldx::rocblas_int,
                                                Y::Ptr{Cfloat},
                                                ldy::rocblas_int)::rocblas_status)
end

function rocsolver_dlabrd(handle, m, n, k, A, lda, D, E, tauq, taup, X, ldx, Y, ldy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlabrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                tauq::Ptr{Cdouble}, taup::Ptr{Cdouble},
                                                X::Ptr{Cdouble}, ldx::rocblas_int,
                                                Y::Ptr{Cdouble},
                                                ldy::rocblas_int)::rocblas_status)
end

function rocsolver_clabrd(handle, m, n, k, A, lda, D, E, tauq, taup, X, ldx, Y, ldy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clabrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tauq::Ptr{rocblas_float_complex},
                                                taup::Ptr{rocblas_float_complex},
                                                X::Ptr{rocblas_float_complex},
                                                ldx::rocblas_int,
                                                Y::Ptr{rocblas_float_complex},
                                                ldy::rocblas_int)::rocblas_status)
end

function rocsolver_zlabrd(handle, m, n, k, A, lda, D, E, tauq, taup, X, ldx, Y, ldy)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlabrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tauq::Ptr{rocblas_double_complex},
                                                taup::Ptr{rocblas_double_complex},
                                                X::Ptr{rocblas_double_complex},
                                                ldx::rocblas_int,
                                                Y::Ptr{rocblas_double_complex},
                                                ldy::rocblas_int)::rocblas_status)
end

function rocsolver_slatrd(handle, uplo, n, k, A, lda, E, tau, W, ldw)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slatrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                E::Ptr{Cfloat}, tau::Ptr{Cfloat},
                                                W::Ptr{Cfloat},
                                                ldw::rocblas_int)::rocblas_status)
end

function rocsolver_dlatrd(handle, uplo, n, k, A, lda, E, tau, W, ldw)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlatrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                E::Ptr{Cdouble}, tau::Ptr{Cdouble},
                                                W::Ptr{Cdouble},
                                                ldw::rocblas_int)::rocblas_status)
end

function rocsolver_clatrd(handle, uplo, n, k, A, lda, E, tau, W, ldw)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clatrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, E::Ptr{Cfloat},
                                                tau::Ptr{rocblas_float_complex},
                                                W::Ptr{rocblas_float_complex},
                                                ldw::rocblas_int)::rocblas_status)
end

function rocsolver_zlatrd(handle, uplo, n, k, A, lda, E, tau, W, ldw)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlatrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, E::Ptr{Cdouble},
                                                tau::Ptr{rocblas_double_complex},
                                                W::Ptr{rocblas_double_complex},
                                                ldw::rocblas_int)::rocblas_status)
end

function rocsolver_slasyf(handle, uplo, n, nb, kb, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slasyf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nb::rocblas_int,
                                                kb::Ptr{rocblas_int}, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dlasyf(handle, uplo, n, nb, kb, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlasyf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nb::rocblas_int,
                                                kb::Ptr{rocblas_int}, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_clasyf(handle, uplo, n, nb, kb, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clasyf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nb::rocblas_int,
                                                kb::Ptr{rocblas_int},
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zlasyf(handle, uplo, n, nb, kb, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlasyf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nb::rocblas_int,
                                                kb::Ptr{rocblas_int},
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_slauum(handle, uplo, n, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_slauum(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_dlauum(handle, uplo, n, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dlauum(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_clauum(handle, uplo, n, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_clauum(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_zlauum(handle, uplo, n, A, lda)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zlauum(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int)::rocblas_status)
end

function rocsolver_sorg2r(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorg2r(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorg2r(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorg2r(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cung2r(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cung2r(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zung2r(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zung2r(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorgqr(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorgqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorgqr(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cungqr(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zungqr(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zungqr(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorgl2(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorgl2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorgl2(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorgl2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cungl2(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cungl2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zungl2(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zungl2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorglq(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorglq(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorglq(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorglq(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cunglq(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunglq(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zunglq(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunglq(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorg2l(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorg2l(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorg2l(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorg2l(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cung2l(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cung2l(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zung2l(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zung2l(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorgql(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorgql(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorgql(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorgql(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cungql(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cungql(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zungql(handle, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zungql(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorgbr(handle, storev, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorgbr(handle::rocblas_handle,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorgbr(handle, storev, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorgbr(handle::rocblas_handle,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cungbr(handle, storev, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cungbr(handle::rocblas_handle,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zungbr(handle, storev, m, n, k, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zungbr(handle::rocblas_handle,
                                                storev::rocblas_storev, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorgtr(handle, uplo, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorgtr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dorgtr(handle, uplo, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorgtr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cungtr(handle, uplo, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cungtr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zungtr(handle, uplo, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zungtr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sorm2r(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorm2r(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dorm2r(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorm2r(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunm2r(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunm2r(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunm2r(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunm2r(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sormqr(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dormqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dormqr(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunmqr(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunmqr(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunmqr(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sorml2(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorml2(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dorml2(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorml2(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunml2(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunml2(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunml2(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunml2(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sormlq(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sormlq(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dormlq(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dormlq(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunmlq(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunmlq(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunmlq(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunmlq(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sorm2l(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sorm2l(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dorm2l(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dorm2l(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunm2l(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunm2l(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunm2l(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunm2l(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sormql(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sormql(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dormql(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dormql(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunmql(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunmql(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunmql(handle, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunmql(handle::rocblas_handle, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sormbr(handle, storev, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sormbr(handle::rocblas_handle,
                                                storev::rocblas_storev, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{Cfloat}, C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dormbr(handle, storev, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dormbr(handle::rocblas_handle,
                                                storev::rocblas_storev, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{Cdouble}, C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunmbr(handle, storev, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunmbr(handle::rocblas_handle,
                                                storev::rocblas_storev, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunmbr(handle, storev, side, trans, m, n, k, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunmbr(handle::rocblas_handle,
                                                storev::rocblas_storev, side::rocblas_side,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, k::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sormtr(handle, side, uplo, trans, m, n, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sormtr(handle::rocblas_handle, side::rocblas_side,
                                                uplo::rocblas_fill,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                C::Ptr{Cfloat},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_dormtr(handle, side, uplo, trans, m, n, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dormtr(handle::rocblas_handle, side::rocblas_side,
                                                uplo::rocblas_fill,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{Cdouble},
                                                C::Ptr{Cdouble},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_cunmtr(handle, side, uplo, trans, m, n, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cunmtr(handle::rocblas_handle, side::rocblas_side,
                                                uplo::rocblas_fill,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_zunmtr(handle, side, uplo, trans, m, n, A, lda, ipiv, C, ldc)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zunmtr(handle::rocblas_handle, side::rocblas_side,
                                                uplo::rocblas_fill,
                                                trans::rocblas_operation, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int)::rocblas_status)
end

function rocsolver_sbdsqr(handle, uplo, n, nv, nu, nc, D, E, V, ldv, U, ldu, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sbdsqr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nv::rocblas_int,
                                                nu::rocblas_int, nc::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                V::Ptr{Cfloat}, ldv::rocblas_int,
                                                U::Ptr{Cfloat}, ldu::rocblas_int,
                                                C::Ptr{Cfloat}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dbdsqr(handle, uplo, n, nv, nu, nc, D, E, V, ldv, U, ldu, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dbdsqr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nv::rocblas_int,
                                                nu::rocblas_int, nc::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                V::Ptr{Cdouble}, ldv::rocblas_int,
                                                U::Ptr{Cdouble}, ldu::rocblas_int,
                                                C::Ptr{Cdouble}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cbdsqr(handle, uplo, n, nv, nu, nc, D, E, V, ldv, U, ldu, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cbdsqr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nv::rocblas_int,
                                                nu::rocblas_int, nc::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                V::Ptr{rocblas_float_complex},
                                                ldv::rocblas_int,
                                                U::Ptr{rocblas_float_complex},
                                                ldu::rocblas_int,
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zbdsqr(handle, uplo, n, nv, nu, nc, D, E, V, ldv, U, ldu, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zbdsqr(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nv::rocblas_int,
                                                nu::rocblas_int, nc::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                V::Ptr{rocblas_double_complex},
                                                ldv::rocblas_int,
                                                U::Ptr{rocblas_double_complex},
                                                ldu::rocblas_int,
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssterf(handle, n, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssterf(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsterf(handle, n, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsterf(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssteqr(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssteqr(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                C::Ptr{Cfloat}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsteqr(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsteqr(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                C::Ptr{Cdouble}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_csteqr(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csteqr(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zsteqr(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsteqr(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sstedc(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sstedc(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                C::Ptr{Cfloat}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dstedc(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dstedc(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                C::Ptr{Cdouble}, ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cstedc(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cstedc(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                C::Ptr{rocblas_float_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zstedc(handle, evect, n, D, E, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zstedc(handle::rocblas_handle,
                                                evect::rocblas_evect, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                C::Ptr{rocblas_double_complex},
                                                ldc::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sstebz(handle, erange, eorder, n, vl, vu, il, iu, abstol, D, E, nev,
                          nsplit, W, iblock, isplit, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sstebz(handle::rocblas_handle,
                                                erange::rocblas_erange,
                                                eorder::rocblas_eorder, n::rocblas_int,
                                                vl::Cfloat, vu::Cfloat, il::rocblas_int,
                                                iu::rocblas_int, abstol::Cfloat,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                nev::Ptr{rocblas_int},
                                                nsplit::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dstebz(handle, erange, eorder, n, vl, vu, il, iu, abstol, D, E, nev,
                          nsplit, W, iblock, isplit, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dstebz(handle::rocblas_handle,
                                                erange::rocblas_erange,
                                                eorder::rocblas_eorder, n::rocblas_int,
                                                vl::Cdouble, vu::Cdouble, il::rocblas_int,
                                                iu::rocblas_int, abstol::Cdouble,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                nev::Ptr{rocblas_int},
                                                nsplit::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sstein(handle, n, D, E, nev, W, iblock, isplit, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sstein(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int}, Z::Ptr{Cfloat},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dstein(handle, n, D, E, nev, W, iblock, isplit, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dstein(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int}, Z::Ptr{Cdouble},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cstein(handle, n, D, E, nev, W, iblock, isplit, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cstein(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int},
                                                Z::Ptr{rocblas_float_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zstein(handle, n, D, E, nev, W, iblock, isplit, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zstein(handle::rocblas_handle, n::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                iblock::Ptr{rocblas_int},
                                                isplit::Ptr{rocblas_int},
                                                Z::Ptr{rocblas_double_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sbdsvdx(handle, uplo, svect, srange, n, D, E, vl, vu, il, iu, nsv, S, Z,
                           ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sbdsvdx(handle::rocblas_handle, uplo::rocblas_fill,
                                                 svect::rocblas_svect,
                                                 srange::rocblas_srange, n::rocblas_int,
                                                 D::Ptr{Cfloat}, E::Ptr{Cfloat}, vl::Cfloat,
                                                 vu::Cfloat, il::rocblas_int,
                                                 iu::rocblas_int, nsv::Ptr{rocblas_int},
                                                 S::Ptr{Cfloat}, Z::Ptr{Cfloat},
                                                 ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dbdsvdx(handle, uplo, svect, srange, n, D, E, vl, vu, il, iu, nsv, S, Z,
                           ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dbdsvdx(handle::rocblas_handle, uplo::rocblas_fill,
                                                 svect::rocblas_svect,
                                                 srange::rocblas_srange, n::rocblas_int,
                                                 D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                 vl::Cdouble, vu::Cdouble, il::rocblas_int,
                                                 iu::rocblas_int, nsv::Ptr{rocblas_int},
                                                 S::Ptr{Cdouble}, Z::Ptr{Cdouble},
                                                 ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetf2_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int, A::Ptr{Cfloat},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetf2_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int, A::Ptr{Cdouble},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetf2_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int,
                                                     A::Ptr{rocblas_float_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetf2_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int,
                                                     A::Ptr{rocblas_double_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetf2_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64, A::Ptr{Cfloat},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dgetf2_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64, A::Ptr{Cdouble},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cgetf2_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64,
                                                        A::Ptr{rocblas_float_complex},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zgetf2_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64,
                                                        A::Ptr{rocblas_double_complex},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_sgetf2_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{Cfloat}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetf2_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{Cdouble}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetf2_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_float_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetf2_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_double_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetf2_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{Cfloat}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetf2_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{Cdouble}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetf2_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{rocblas_float_complex}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetf2_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{rocblas_double_complex}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetf2_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cfloat},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetf2_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cdouble},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetf2_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_float_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetf2_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_double_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetf2_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{Cfloat},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetf2_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{Cdouble},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetf2_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{rocblas_float_complex},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetf2_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{rocblas_double_complex},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetrf_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int, A::Ptr{Cfloat},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetrf_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int, A::Ptr{Cdouble},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetrf_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int,
                                                     A::Ptr{rocblas_float_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetrf_npvt(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt(handle::rocblas_handle, m::rocblas_int,
                                                     n::rocblas_int,
                                                     A::Ptr{rocblas_double_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetrf_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64, A::Ptr{Cfloat},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dgetrf_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64, A::Ptr{Cdouble},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cgetrf_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64,
                                                        A::Ptr{rocblas_float_complex},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zgetrf_npvt_64(handle, m, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt_64(handle::rocblas_handle, m::Int64,
                                                        n::Int64,
                                                        A::Ptr{rocblas_double_complex},
                                                        lda::Int64,
                                                        info::Ptr{Int64})::rocblas_status)
end

function rocsolver_sgetrf_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{Cfloat}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrf_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{Cdouble}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrf_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_float_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrf_npvt_batched(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt_batched(handle::rocblas_handle,
                                                             m::rocblas_int, n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_double_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrf_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{Cfloat}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrf_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{Cdouble}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrf_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{rocblas_float_complex}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrf_npvt_batched_64(handle, m, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt_batched_64(handle::rocblas_handle,
                                                                m::Int64, n::Int64,
                                                                A::Ptr{Ptr{rocblas_double_complex}},
                                                                lda::Int64,
                                                                info::Ptr{Int64},
                                                                batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetrf_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cfloat},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrf_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cdouble},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrf_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_float_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrf_npvt_strided_batched(handle, m, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt_strided_batched(handle::rocblas_handle,
                                                                     m::rocblas_int,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_double_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrf_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{Cfloat},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrf_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{Cdouble},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrf_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{rocblas_float_complex},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrf_npvt_strided_batched_64(handle, m, n, A, lda, strideA, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_npvt_strided_batched_64(handle::rocblas_handle,
                                                                        m::Int64, n::Int64,
                                                                        A::Ptr{rocblas_double_complex},
                                                                        lda::Int64,
                                                                        strideA::rocblas_stride,
                                                                        info::Ptr{Int64},
                                                                        batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetf2(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetf2(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetf2(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetf2(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetf2_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dgetf2_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cgetf2_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_float_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zgetf2_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_double_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_sgetf2_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetf2_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetf2_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetf2_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetf2_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cfloat}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetf2_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cdouble}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetf2_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetf2_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetf2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetf2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetf2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetf2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetf2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetf2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetf2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetf2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetf2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetf2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetf2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetf2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetrf(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetrf_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dgetrf_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cgetrf_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_float_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zgetrf_64(handle, m, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_double_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_sgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrf_batched(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrf_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cfloat}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrf_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cdouble}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrf_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrf_batched_64(handle, m, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sgeqr2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeqr2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeqr2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeqr2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeqr2_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeqr2_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeqr2_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_float_complex},
                                                   lda::Int64,
                                                   ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeqr2_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_double_complex},
                                                   lda::Int64,
                                                   ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeqr2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqr2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqr2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqr2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqr2_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cfloat}},
                                                           lda::Int64, ipiv::Ptr{Cfloat},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dgeqr2_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cdouble}},
                                                           lda::Int64, ipiv::Ptr{Cdouble},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cgeqr2_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64,
                                                           ipiv::Ptr{rocblas_float_complex},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zgeqr2_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64,
                                                           ipiv::Ptr{rocblas_double_complex},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_sgeqr2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqr2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqr2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqr2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqr2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqr2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Cfloat},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dgeqr2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqr2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Cdouble},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cgeqr2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqr2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{rocblas_float_complex},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zgeqr2_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqr2_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{rocblas_double_complex},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sgerq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgerq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgerq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgerq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgerq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgerq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgerq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgerq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgerq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgerq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgerq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgerq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeql2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeql2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeql2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeql2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeql2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeql2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeql2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeql2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeql2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeql2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeql2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeql2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeql2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeql2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeql2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeql2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeql2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeql2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeql2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeql2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeql2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeql2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeql2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeql2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgelq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgelq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgelq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgelq2(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelq2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgelq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgelq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgelq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgelq2_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelq2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgelq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgelq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgelq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgelq2_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelq2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeqrf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeqrf_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeqrf_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeqrf_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_float_complex},
                                                   lda::Int64,
                                                   ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeqrf_64(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf_64(handle::rocblas_handle, m::Int64,
                                                   n::Int64, A::Ptr{rocblas_double_complex},
                                                   lda::Int64,
                                                   ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeqrf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqrf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqrf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqrf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqrf_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cfloat}},
                                                           lda::Int64, ipiv::Ptr{Cfloat},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dgeqrf_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64, A::Ptr{Ptr{Cdouble}},
                                                           lda::Int64, ipiv::Ptr{Cdouble},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cgeqrf_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64,
                                                           ipiv::Ptr{rocblas_float_complex},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zgeqrf_batched_64(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf_batched_64(handle::rocblas_handle, m::Int64,
                                                           n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64,
                                                           ipiv::Ptr{rocblas_double_complex},
                                                           strideP::rocblas_stride,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_sgeqrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqrf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Cfloat},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dgeqrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Cdouble},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cgeqrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{rocblas_float_complex},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zgeqrf_strided_batched_64(handle, m, n, A, lda, strideA, ipiv, strideP,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqrf_strided_batched_64(handle::rocblas_handle,
                                                                   m::Int64, n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{rocblas_double_complex},
                                                                   strideP::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sgerqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgerqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgerqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgerqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgerqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgerqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgerqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgerqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgerqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgerqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgerqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgerqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgerqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgerqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgerqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgerqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqlf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqlf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgeqlf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqlf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgeqlf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqlf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgeqlf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqlf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgeqlf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqlf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqlf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqlf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqlf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqlf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqlf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqlf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeqlf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeqlf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeqlf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeqlf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeqlf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeqlf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeqlf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeqlf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgelqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgelqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                ipiv::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgelqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgelqf(handle, m, n, A, lda, ipiv)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelqf(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                ipiv::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgelqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, ipiv::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgelqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgelqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgelqf_batched(handle, m, n, A, lda, ipiv, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelqf_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgelqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgelqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgelqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgelqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgelqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgelqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgelqf_strided_batched(handle, m, n, A, lda, strideA, ipiv, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgelqf_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgebd2(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebd2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat}, tauq::Ptr{Cfloat},
                                                taup::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgebd2(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebd2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble}, tauq::Ptr{Cdouble},
                                                taup::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgebd2(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebd2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tauq::Ptr{rocblas_float_complex},
                                                taup::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgebd2(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebd2(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tauq::Ptr{rocblas_double_complex},
                                                taup::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgebd2_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebd2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{Cfloat},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgebd2_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebd2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{Cdouble},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgebd2_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebd2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{rocblas_float_complex},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgebd2_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebd2_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{rocblas_double_complex},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgebd2_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebd2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{Cfloat},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgebd2_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebd2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{Cdouble},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgebd2_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebd2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{rocblas_float_complex},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgebd2_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebd2_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{rocblas_double_complex},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgebrd(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat}, tauq::Ptr{Cfloat},
                                                taup::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dgebrd(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble}, tauq::Ptr{Cdouble},
                                                taup::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_cgebrd(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tauq::Ptr{rocblas_float_complex},
                                                taup::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zgebrd(handle, m, n, A, lda, D, E, tauq, taup)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebrd(handle::rocblas_handle, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tauq::Ptr{rocblas_double_complex},
                                                taup::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_sgebrd_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebrd_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{Cfloat},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgebrd_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebrd_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{Cdouble},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgebrd_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebrd_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{rocblas_float_complex},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgebrd_batched(handle, m, n, A, lda, D, strideD, E, strideE, tauq,
                                  strideQ, taup, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebrd_batched(handle::rocblas_handle,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tauq::Ptr{rocblas_double_complex},
                                                        strideQ::rocblas_stride,
                                                        taup::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgebrd_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgebrd_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{Cfloat},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgebrd_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgebrd_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{Cdouble},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgebrd_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgebrd_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{rocblas_float_complex},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgebrd_strided_batched(handle, m, n, A, lda, strideA, D, strideD, E,
                                          strideE, tauq, strideQ, taup, strideP,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgebrd_strided_batched(handle::rocblas_handle,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tauq::Ptr{rocblas_double_complex},
                                                                strideQ::rocblas_stride,
                                                                taup::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs(handle::rocblas_handle,
                                                trans::rocblas_operation, n::rocblas_int,
                                                nrhs::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                B::Ptr{Cfloat},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs(handle::rocblas_handle,
                                                trans::rocblas_operation, n::rocblas_int,
                                                nrhs::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                B::Ptr{Cdouble},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs(handle::rocblas_handle,
                                                trans::rocblas_operation, n::rocblas_int,
                                                nrhs::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrs(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs(handle::rocblas_handle,
                                                trans::rocblas_operation, n::rocblas_int,
                                                nrhs::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrs_64(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs_64(handle::rocblas_handle,
                                                   trans::rocblas_operation, n::Int64,
                                                   nrhs::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   ipiv::Ptr{Int64}, B::Ptr{Cfloat},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_dgetrs_64(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs_64(handle::rocblas_handle,
                                                   trans::rocblas_operation, n::Int64,
                                                   nrhs::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   ipiv::Ptr{Int64}, B::Ptr{Cdouble},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_cgetrs_64(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs_64(handle::rocblas_handle,
                                                   trans::rocblas_operation, n::Int64,
                                                   nrhs::Int64,
                                                   A::Ptr{rocblas_float_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   B::Ptr{rocblas_float_complex},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_zgetrs_64(handle, trans, n, nrhs, A, lda, ipiv, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs_64(handle::rocblas_handle,
                                                   trans::rocblas_operation, n::Int64,
                                                   nrhs::Int64,
                                                   A::Ptr{rocblas_double_complex},
                                                   lda::Int64, ipiv::Ptr{Int64},
                                                   B::Ptr{rocblas_double_complex},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_sgetrs_batched(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs_batched(handle::rocblas_handle,
                                                        trans::rocblas_operation,
                                                        n::rocblas_int, nrhs::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrs_batched(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs_batched(handle::rocblas_handle,
                                                        trans::rocblas_operation,
                                                        n::rocblas_int, nrhs::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrs_batched(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs_batched(handle::rocblas_handle,
                                                        trans::rocblas_operation,
                                                        n::rocblas_int, nrhs::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrs_batched(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs_batched(handle::rocblas_handle,
                                                        trans::rocblas_operation,
                                                        n::rocblas_int, nrhs::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrs_batched_64(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs_batched_64(handle::rocblas_handle,
                                                           trans::rocblas_operation,
                                                           n::Int64, nrhs::Int64,
                                                           A::Ptr{Ptr{Cfloat}}, lda::Int64,
                                                           ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           B::Ptr{Ptr{Cfloat}}, ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrs_batched_64(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs_batched_64(handle::rocblas_handle,
                                                           trans::rocblas_operation,
                                                           n::Int64, nrhs::Int64,
                                                           A::Ptr{Ptr{Cdouble}}, lda::Int64,
                                                           ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           B::Ptr{Ptr{Cdouble}}, ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrs_batched_64(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs_batched_64(handle::rocblas_handle,
                                                           trans::rocblas_operation,
                                                           n::Int64, nrhs::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           B::Ptr{Ptr{rocblas_float_complex}},
                                                           ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrs_batched_64(handle, trans, n, nrhs, A, lda, ipiv, strideP, B, ldb,
                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs_batched_64(handle::rocblas_handle,
                                                           trans::rocblas_operation,
                                                           n::Int64, nrhs::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64, ipiv::Ptr{Int64},
                                                           strideP::rocblas_stride,
                                                           B::Ptr{Ptr{rocblas_double_complex}},
                                                           ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_sgetrs_strided_batched(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                          strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs_strided_batched(handle::rocblas_handle,
                                                                trans::rocblas_operation,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetrs_strided_batched(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                          strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs_strided_batched(handle::rocblas_handle,
                                                                trans::rocblas_operation,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetrs_strided_batched(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                          strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs_strided_batched(handle::rocblas_handle,
                                                                trans::rocblas_operation,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetrs_strided_batched(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                          strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs_strided_batched(handle::rocblas_handle,
                                                                trans::rocblas_operation,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetrs_strided_batched_64(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                             strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetrs_strided_batched_64(handle::rocblas_handle,
                                                                   trans::rocblas_operation,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   B::Ptr{Cfloat},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dgetrs_strided_batched_64(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                             strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetrs_strided_batched_64(handle::rocblas_handle,
                                                                   trans::rocblas_operation,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   B::Ptr{Cdouble},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cgetrs_strided_batched_64(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                             strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetrs_strided_batched_64(handle::rocblas_handle,
                                                                   trans::rocblas_operation,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   B::Ptr{rocblas_float_complex},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zgetrs_strided_batched_64(handle, trans, n, nrhs, A, lda, strideA, ipiv,
                                             strideP, B, ldb, strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetrs_strided_batched_64(handle::rocblas_handle,
                                                                   trans::rocblas_operation,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   ipiv::Ptr{Int64},
                                                                   strideP::rocblas_stride,
                                                                   B::Ptr{rocblas_double_complex},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sgesv(handle, n, nrhs, A, lda, ipiv, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesv(handle::rocblas_handle, n::rocblas_int,
                                               nrhs::rocblas_int, A::Ptr{Cfloat},
                                               lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                               B::Ptr{Cfloat}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgesv(handle, n, nrhs, A, lda, ipiv, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesv(handle::rocblas_handle, n::rocblas_int,
                                               nrhs::rocblas_int, A::Ptr{Cdouble},
                                               lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                               B::Ptr{Cdouble}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgesv(handle, n, nrhs, A, lda, ipiv, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesv(handle::rocblas_handle, n::rocblas_int,
                                               nrhs::rocblas_int,
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                               B::Ptr{rocblas_float_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgesv(handle, n, nrhs, A, lda, ipiv, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesv(handle::rocblas_handle, n::rocblas_int,
                                               nrhs::rocblas_int,
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                               B::Ptr{rocblas_double_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgesv_batched(handle, n, nrhs, A, lda, ipiv, strideP, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesv_batched(handle::rocblas_handle,
                                                       n::rocblas_int, nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cfloat}},
                                                       lda::rocblas_int,
                                                       ipiv::Ptr{rocblas_int},
                                                       strideP::rocblas_stride,
                                                       B::Ptr{Ptr{Cfloat}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesv_batched(handle, n, nrhs, A, lda, ipiv, strideP, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesv_batched(handle::rocblas_handle,
                                                       n::rocblas_int, nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cdouble}},
                                                       lda::rocblas_int,
                                                       ipiv::Ptr{rocblas_int},
                                                       strideP::rocblas_stride,
                                                       B::Ptr{Ptr{Cdouble}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesv_batched(handle, n, nrhs, A, lda, ipiv, strideP, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesv_batched(handle::rocblas_handle,
                                                       n::rocblas_int, nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_float_complex}},
                                                       lda::rocblas_int,
                                                       ipiv::Ptr{rocblas_int},
                                                       strideP::rocblas_stride,
                                                       B::Ptr{Ptr{rocblas_float_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesv_batched(handle, n, nrhs, A, lda, ipiv, strideP, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesv_batched(handle::rocblas_handle,
                                                       n::rocblas_int, nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_double_complex}},
                                                       lda::rocblas_int,
                                                       ipiv::Ptr{rocblas_int},
                                                       strideP::rocblas_stride,
                                                       B::Ptr{Ptr{rocblas_double_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesv_strided_batched(handle, n, nrhs, A, lda, strideA, ipiv, strideP, B,
                                         ldb, strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesv_strided_batched(handle::rocblas_handle,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cfloat},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               ipiv::Ptr{rocblas_int},
                                                               strideP::rocblas_stride,
                                                               B::Ptr{Cfloat},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesv_strided_batched(handle, n, nrhs, A, lda, strideA, ipiv, strideP, B,
                                         ldb, strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesv_strided_batched(handle::rocblas_handle,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cdouble},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               ipiv::Ptr{rocblas_int},
                                                               strideP::rocblas_stride,
                                                               B::Ptr{Cdouble},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesv_strided_batched(handle, n, nrhs, A, lda, strideA, ipiv, strideP, B,
                                         ldb, strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesv_strided_batched(handle::rocblas_handle,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_float_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               ipiv::Ptr{rocblas_int},
                                                               strideP::rocblas_stride,
                                                               B::Ptr{rocblas_float_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesv_strided_batched(handle, n, nrhs, A, lda, strideA, ipiv, strideP, B,
                                         ldb, strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesv_strided_batched(handle::rocblas_handle,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_double_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               ipiv::Ptr{rocblas_int},
                                                               strideP::rocblas_stride,
                                                               B::Ptr{rocblas_double_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri(handle, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetri(handle, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetri(handle, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetri(handle, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri(handle::rocblas_handle, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_batched(handle::rocblas_handle,
                                                        n::rocblas_int, A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_batched(handle::rocblas_handle,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_batched(handle::rocblas_handle,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_batched(handle, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_batched(handle::rocblas_handle,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_strided_batched(handle, n, A, lda, strideA, ipiv, strideP, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_strided_batched(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_strided_batched(handle, n, A, lda, strideA, ipiv, strideP, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_strided_batched(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_strided_batched(handle, n, A, lda, strideA, ipiv, strideP, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_strided_batched(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_strided_batched(handle, n, A, lda, strideA, ipiv, strideP, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_strided_batched(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_npvt(handle, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt(handle::rocblas_handle, n::rocblas_int,
                                                     A::Ptr{Cfloat}, lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetri_npvt(handle, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt(handle::rocblas_handle, n::rocblas_int,
                                                     A::Ptr{Cdouble}, lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetri_npvt(handle, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt(handle::rocblas_handle, n::rocblas_int,
                                                     A::Ptr{rocblas_float_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetri_npvt(handle, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt(handle::rocblas_handle, n::rocblas_int,
                                                     A::Ptr{rocblas_double_complex},
                                                     lda::rocblas_int,
                                                     info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetri_npvt_batched(handle, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt_batched(handle::rocblas_handle,
                                                             n::rocblas_int,
                                                             A::Ptr{Ptr{Cfloat}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_npvt_batched(handle, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt_batched(handle::rocblas_handle,
                                                             n::rocblas_int,
                                                             A::Ptr{Ptr{Cdouble}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_npvt_batched(handle, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt_batched(handle::rocblas_handle,
                                                             n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_float_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_npvt_batched(handle, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt_batched(handle::rocblas_handle,
                                                             n::rocblas_int,
                                                             A::Ptr{Ptr{rocblas_double_complex}},
                                                             lda::rocblas_int,
                                                             info::Ptr{rocblas_int},
                                                             batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_npvt_strided_batched(handle, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt_strided_batched(handle::rocblas_handle,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cfloat},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_npvt_strided_batched(handle, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt_strided_batched(handle::rocblas_handle,
                                                                     n::rocblas_int,
                                                                     A::Ptr{Cdouble},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_npvt_strided_batched(handle, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt_strided_batched(handle::rocblas_handle,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_float_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_npvt_strided_batched(handle, n, A, lda, strideA, info,
                                               batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt_strided_batched(handle::rocblas_handle,
                                                                     n::rocblas_int,
                                                                     A::Ptr{rocblas_double_complex},
                                                                     lda::rocblas_int,
                                                                     strideA::rocblas_stride,
                                                                     info::Ptr{rocblas_int},
                                                                     batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgels(handle, trans, m, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgels(handle::rocblas_handle,
                                               trans::rocblas_operation, m::rocblas_int,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{Cfloat}, lda::rocblas_int,
                                               B::Ptr{Cfloat}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgels(handle, trans, m, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgels(handle::rocblas_handle,
                                               trans::rocblas_operation, m::rocblas_int,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{Cdouble}, lda::rocblas_int,
                                               B::Ptr{Cdouble}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgels(handle, trans, m, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgels(handle::rocblas_handle,
                                               trans::rocblas_operation, m::rocblas_int,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_float_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgels(handle, trans, m, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgels(handle::rocblas_handle,
                                               trans::rocblas_operation, m::rocblas_int,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_double_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgels_batched(handle, trans, m, n, nrhs, A, lda, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgels_batched(handle::rocblas_handle,
                                                       trans::rocblas_operation,
                                                       m::rocblas_int, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cfloat}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cfloat}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgels_batched(handle, trans, m, n, nrhs, A, lda, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgels_batched(handle::rocblas_handle,
                                                       trans::rocblas_operation,
                                                       m::rocblas_int, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cdouble}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cdouble}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgels_batched(handle, trans, m, n, nrhs, A, lda, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgels_batched(handle::rocblas_handle,
                                                       trans::rocblas_operation,
                                                       m::rocblas_int, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_float_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_float_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgels_batched(handle, trans, m, n, nrhs, A, lda, B, ldb, info,
                                 batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgels_batched(handle::rocblas_handle,
                                                       trans::rocblas_operation,
                                                       m::rocblas_int, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_double_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_double_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgels_strided_batched(handle, trans, m, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgels_strided_batched(handle::rocblas_handle,
                                                               trans::rocblas_operation,
                                                               m::rocblas_int,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cfloat},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cfloat},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgels_strided_batched(handle, trans, m, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgels_strided_batched(handle::rocblas_handle,
                                                               trans::rocblas_operation,
                                                               m::rocblas_int,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cdouble},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cdouble},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgels_strided_batched(handle, trans, m, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgels_strided_batched(handle::rocblas_handle,
                                                               trans::rocblas_operation,
                                                               m::rocblas_int,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_float_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_float_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgels_strided_batched(handle, trans, m, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgels_strided_batched(handle::rocblas_handle,
                                                               trans::rocblas_operation,
                                                               m::rocblas_int,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_double_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_double_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotf2(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dpotf2(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cpotf2(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zpotf2(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_spotf2_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{Cfloat}, lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dpotf2_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{Cdouble}, lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cpotf2_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{rocblas_float_complex},
                                                   lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zpotf2_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{rocblas_double_complex},
                                                   lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_spotf2_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotf2_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotf2_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotf2_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotf2_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{Cfloat}}, lda::Int64,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotf2_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{Cdouble}}, lda::Int64,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotf2_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64, info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotf2_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64, info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_spotf2_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotf2_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotf2_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotf2_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotf2_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotf2_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotf2_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotf2_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotf2_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotf2_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotf2_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotf2_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_spotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zpotrf(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_spotrf_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{Cfloat}, lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_dpotrf_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{Cdouble}, lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_cpotrf_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{rocblas_float_complex},
                                                   lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_zpotrf_64(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   A::Ptr{rocblas_double_complex},
                                                   lda::Int64,
                                                   info::Ptr{Int64})::rocblas_status)
end

function rocsolver_spotrf_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotrf_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotrf_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotrf_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotrf_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{Cfloat}}, lda::Int64,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotrf_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{Cdouble}}, lda::Int64,
                                                           info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotrf_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64, info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotrf_batched_64(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64, info::Ptr{Int64},
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_spotrf_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotrf_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotrf_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotrf_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotrf_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrf_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotrf_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrf_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotrf_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrf_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotrf_strided_batched_64(handle, uplo, n, A, lda, strideA, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrf_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   info::Ptr{Int64},
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_spotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nrhs::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                B::Ptr{Cfloat},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_dpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nrhs::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                B::Ptr{Cdouble},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_cpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nrhs::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_zpotrs(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, nrhs::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_spotrs_64(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   nrhs::Int64, A::Ptr{Cfloat}, lda::Int64,
                                                   B::Ptr{Cfloat},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_dpotrs_64(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   nrhs::Int64, A::Ptr{Cdouble}, lda::Int64,
                                                   B::Ptr{Cdouble},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_cpotrs_64(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   nrhs::Int64,
                                                   A::Ptr{rocblas_float_complex},
                                                   lda::Int64,
                                                   B::Ptr{rocblas_float_complex},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_zpotrs_64(handle, uplo, n, nrhs, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs_64(handle::rocblas_handle,
                                                   uplo::rocblas_fill, n::Int64,
                                                   nrhs::Int64,
                                                   A::Ptr{rocblas_double_complex},
                                                   lda::Int64,
                                                   B::Ptr{rocblas_double_complex},
                                                   ldb::Int64)::rocblas_status)
end

function rocsolver_spotrs_batched(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotrs_batched(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotrs_batched(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotrs_batched(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotrs_batched_64(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           nrhs::Int64, A::Ptr{Ptr{Cfloat}},
                                                           lda::Int64, B::Ptr{Ptr{Cfloat}},
                                                           ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotrs_batched_64(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           nrhs::Int64,
                                                           A::Ptr{Ptr{Cdouble}}, lda::Int64,
                                                           B::Ptr{Ptr{Cdouble}}, ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotrs_batched_64(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           nrhs::Int64,
                                                           A::Ptr{Ptr{rocblas_float_complex}},
                                                           lda::Int64,
                                                           B::Ptr{Ptr{rocblas_float_complex}},
                                                           ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotrs_batched_64(handle, uplo, n, nrhs, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs_batched_64(handle::rocblas_handle,
                                                           uplo::rocblas_fill, n::Int64,
                                                           nrhs::Int64,
                                                           A::Ptr{Ptr{rocblas_double_complex}},
                                                           lda::Int64,
                                                           B::Ptr{Ptr{rocblas_double_complex}},
                                                           ldb::Int64,
                                                           batch_count::Int64)::rocblas_status)
end

function rocsolver_spotrs_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotrs_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotrs_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotrs_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotrs_strided_batched_64(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                             strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotrs_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{Cfloat},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   B::Ptr{Cfloat},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_dpotrs_strided_batched_64(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                             strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotrs_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{Cdouble},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   B::Ptr{Cdouble},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_cpotrs_strided_batched_64(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                             strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotrs_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{rocblas_float_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   B::Ptr{rocblas_float_complex},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_zpotrs_strided_batched_64(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                             strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotrs_strided_batched_64(handle::rocblas_handle,
                                                                   uplo::rocblas_fill,
                                                                   n::Int64, nrhs::Int64,
                                                                   A::Ptr{rocblas_double_complex},
                                                                   lda::Int64,
                                                                   strideA::rocblas_stride,
                                                                   B::Ptr{rocblas_double_complex},
                                                                   ldb::Int64,
                                                                   strideB::rocblas_stride,
                                                                   batch_count::Int64)::rocblas_status)
end

function rocsolver_sposv(handle, uplo, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sposv(handle::rocblas_handle, uplo::rocblas_fill,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{Cfloat}, lda::rocblas_int,
                                               B::Ptr{Cfloat}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dposv(handle, uplo, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dposv(handle::rocblas_handle, uplo::rocblas_fill,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{Cdouble}, lda::rocblas_int,
                                               B::Ptr{Cdouble}, ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cposv(handle, uplo, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cposv(handle::rocblas_handle, uplo::rocblas_fill,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_float_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zposv(handle, uplo, n, nrhs, A, lda, B, ldb, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zposv(handle::rocblas_handle, uplo::rocblas_fill,
                                               n::rocblas_int, nrhs::rocblas_int,
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_double_complex},
                                               ldb::rocblas_int,
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sposv_batched(handle, uplo, n, nrhs, A, lda, B, ldb, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sposv_batched(handle::rocblas_handle,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cfloat}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cfloat}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dposv_batched(handle, uplo, n, nrhs, A, lda, B, ldb, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dposv_batched(handle::rocblas_handle,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{Cdouble}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cdouble}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cposv_batched(handle, uplo, n, nrhs, A, lda, B, ldb, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cposv_batched(handle::rocblas_handle,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_float_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_float_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zposv_batched(handle, uplo, n, nrhs, A, lda, B, ldb, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zposv_batched(handle::rocblas_handle,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       nrhs::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_double_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_double_complex}},
                                                       ldb::rocblas_int,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sposv_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sposv_strided_batched(handle::rocblas_handle,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cfloat},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cfloat},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dposv_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dposv_strided_batched(handle::rocblas_handle,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{Cdouble},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cdouble},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cposv_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cposv_strided_batched(handle::rocblas_handle,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_float_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_float_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zposv_strided_batched(handle, uplo, n, nrhs, A, lda, strideA, B, ldb,
                                         strideB, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zposv_strided_batched(handle::rocblas_handle,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               nrhs::rocblas_int,
                                                               A::Ptr{rocblas_double_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_double_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotri(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotri(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dpotri(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotri(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cpotri(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotri(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zpotri(handle, uplo, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotri(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_spotri_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotri_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotri_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotri_batched(handle, uplo, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_spotri_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_spotri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dpotri_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dpotri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cpotri_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cpotri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zpotri_strided_batched(handle, uplo, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zpotri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          E, fast_alg, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, S::Ptr{Cfloat},
                                                U::Ptr{Cfloat}, ldu::rocblas_int,
                                                V::Ptr{Cfloat}, ldv::rocblas_int,
                                                E::Ptr{Cfloat}, fast_alg::rocblas_workmode,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgesvd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          E, fast_alg, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, S::Ptr{Cdouble},
                                                U::Ptr{Cdouble}, ldu::rocblas_int,
                                                V::Ptr{Cdouble}, ldv::rocblas_int,
                                                E::Ptr{Cdouble}, fast_alg::rocblas_workmode,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgesvd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          E, fast_alg, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, S::Ptr{Cfloat},
                                                U::Ptr{rocblas_float_complex},
                                                ldu::rocblas_int,
                                                V::Ptr{rocblas_float_complex},
                                                ldv::rocblas_int, E::Ptr{Cfloat},
                                                fast_alg::rocblas_workmode,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgesvd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          E, fast_alg, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, S::Ptr{Cdouble},
                                                U::Ptr{rocblas_double_complex},
                                                ldu::rocblas_int,
                                                V::Ptr{rocblas_double_complex},
                                                ldv::rocblas_int, E::Ptr{Cdouble},
                                                fast_alg::rocblas_workmode,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgesvd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, E, strideE, fast_alg,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, S::Ptr{Cfloat},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{Cfloat}, ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{Cfloat}, ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        fast_alg::rocblas_workmode,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, E, strideE, fast_alg,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, S::Ptr{Cdouble},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{Cdouble}, ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{Cdouble}, ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        fast_alg::rocblas_workmode,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, E, strideE, fast_alg,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, S::Ptr{Cfloat},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{rocblas_float_complex},
                                                        ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{rocblas_float_complex},
                                                        ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        fast_alg::rocblas_workmode,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, E, strideE, fast_alg,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, S::Ptr{Cdouble},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{rocblas_double_complex},
                                                        ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{rocblas_double_complex},
                                                        ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        fast_alg::rocblas_workmode,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, E, strideE, fast_alg, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cfloat},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{Cfloat},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{Cfloat},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                fast_alg::rocblas_workmode,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, E, strideE, fast_alg, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cdouble},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{Cdouble},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{Cdouble},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                fast_alg::rocblas_workmode,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, E, strideE, fast_alg, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cfloat},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{rocblas_float_complex},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{rocblas_float_complex},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                fast_alg::rocblas_workmode,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, E, strideE, fast_alg, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cdouble},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{rocblas_double_complex},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{rocblas_double_complex},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                fast_alg::rocblas_workmode,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesdd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesdd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, S::Ptr{Cfloat},
                                                U::Ptr{Cfloat}, ldu::rocblas_int,
                                                V::Ptr{Cfloat}, ldv::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgesdd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesdd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, S::Ptr{Cdouble},
                                                U::Ptr{Cdouble}, ldu::rocblas_int,
                                                V::Ptr{Cdouble}, ldv::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgesdd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesdd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, S::Ptr{Cfloat},
                                                U::Ptr{rocblas_float_complex},
                                                ldu::rocblas_int,
                                                V::Ptr{rocblas_float_complex},
                                                ldv::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgesdd(handle, left_svect, right_svect, m, n, A, lda, S, U, ldu, V, ldv,
                          info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesdd(handle::rocblas_handle,
                                                left_svect::rocblas_svect,
                                                right_svect::rocblas_svect, m::rocblas_int,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, S::Ptr{Cdouble},
                                                U::Ptr{rocblas_double_complex},
                                                ldu::rocblas_int,
                                                V::Ptr{rocblas_double_complex},
                                                ldv::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgesdd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesdd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, S::Ptr{Cfloat},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{Cfloat}, ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{Cfloat}, ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesdd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesdd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, S::Ptr{Cdouble},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{Cdouble}, ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{Cdouble}, ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesdd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesdd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, S::Ptr{Cfloat},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{rocblas_float_complex},
                                                        ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{rocblas_float_complex},
                                                        ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesdd_batched(handle, left_svect, right_svect, m, n, A, lda, S, strideS,
                                  U, ldu, strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesdd_batched(handle::rocblas_handle,
                                                        left_svect::rocblas_svect,
                                                        right_svect::rocblas_svect,
                                                        m::rocblas_int, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, S::Ptr{Cdouble},
                                                        strideS::rocblas_stride,
                                                        U::Ptr{rocblas_double_complex},
                                                        ldu::rocblas_int,
                                                        strideU::rocblas_stride,
                                                        V::Ptr{rocblas_double_complex},
                                                        ldv::rocblas_int,
                                                        strideV::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesdd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesdd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cfloat},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{Cfloat},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{Cfloat},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesdd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesdd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cdouble},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{Cdouble},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{Cdouble},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesdd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesdd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cfloat},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{rocblas_float_complex},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{rocblas_float_complex},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesdd_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                          strideA, S, strideS, U, ldu, strideU, V, ldv,
                                          strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesdd_strided_batched(handle::rocblas_handle,
                                                                left_svect::rocblas_svect,
                                                                right_svect::rocblas_svect,
                                                                m::rocblas_int,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                S::Ptr{Cdouble},
                                                                strideS::rocblas_stride,
                                                                U::Ptr{rocblas_double_complex},
                                                                ldu::rocblas_int,
                                                                strideU::rocblas_stride,
                                                                V::Ptr{rocblas_double_complex},
                                                                ldv::rocblas_int,
                                                                strideV::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual,
                           max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdj(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect, m::rocblas_int,
                                                 n::rocblas_int, A::Ptr{Cfloat},
                                                 lda::rocblas_int, abstol::Cfloat,
                                                 residual::Ptr{Cfloat},
                                                 max_sweeps::rocblas_int,
                                                 n_sweeps::Ptr{rocblas_int}, S::Ptr{Cfloat},
                                                 U::Ptr{Cfloat}, ldu::rocblas_int,
                                                 V::Ptr{Cfloat}, ldv::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual,
                           max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdj(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect, m::rocblas_int,
                                                 n::rocblas_int, A::Ptr{Cdouble},
                                                 lda::rocblas_int, abstol::Cdouble,
                                                 residual::Ptr{Cdouble},
                                                 max_sweeps::rocblas_int,
                                                 n_sweeps::Ptr{rocblas_int},
                                                 S::Ptr{Cdouble}, U::Ptr{Cdouble},
                                                 ldu::rocblas_int, V::Ptr{Cdouble},
                                                 ldv::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual,
                           max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdj(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect, m::rocblas_int,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int, abstol::Cfloat,
                                                 residual::Ptr{Cfloat},
                                                 max_sweeps::rocblas_int,
                                                 n_sweeps::Ptr{rocblas_int}, S::Ptr{Cfloat},
                                                 U::Ptr{rocblas_float_complex},
                                                 ldu::rocblas_int,
                                                 V::Ptr{rocblas_float_complex},
                                                 ldv::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgesvdj(handle, left_svect, right_svect, m, n, A, lda, abstol, residual,
                           max_sweeps, n_sweeps, S, U, ldu, V, ldv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdj(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect, m::rocblas_int,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int, abstol::Cdouble,
                                                 residual::Ptr{Cdouble},
                                                 max_sweeps::rocblas_int,
                                                 n_sweeps::Ptr{rocblas_int},
                                                 S::Ptr{Cdouble},
                                                 U::Ptr{rocblas_double_complex},
                                                 ldu::rocblas_int,
                                                 V::Ptr{rocblas_double_complex},
                                                 ldv::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgesvdj_batched(handle, left_svect, right_svect, m, n, A, lda, abstol,
                                   residual, max_sweeps, n_sweeps, S, strideS, U, ldu,
                                   strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdj_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int, abstol::Cfloat,
                                                         residual::Ptr{Cfloat},
                                                         max_sweeps::rocblas_int,
                                                         n_sweeps::Ptr{rocblas_int},
                                                         S::Ptr{Cfloat},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{Cfloat}, ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{Cfloat}, ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvdj_batched(handle, left_svect, right_svect, m, n, A, lda, abstol,
                                   residual, max_sweeps, n_sweeps, S, strideS, U, ldu,
                                   strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdj_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int, abstol::Cdouble,
                                                         residual::Ptr{Cdouble},
                                                         max_sweeps::rocblas_int,
                                                         n_sweeps::Ptr{rocblas_int},
                                                         S::Ptr{Cdouble},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{Cdouble}, ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{Cdouble}, ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvdj_batched(handle, left_svect, right_svect, m, n, A, lda, abstol,
                                   residual, max_sweeps, n_sweeps, S, strideS, U, ldu,
                                   strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdj_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int, abstol::Cfloat,
                                                         residual::Ptr{Cfloat},
                                                         max_sweeps::rocblas_int,
                                                         n_sweeps::Ptr{rocblas_int},
                                                         S::Ptr{Cfloat},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{rocblas_float_complex},
                                                         ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{rocblas_float_complex},
                                                         ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvdj_batched(handle, left_svect, right_svect, m, n, A, lda, abstol,
                                   residual, max_sweeps, n_sweeps, S, strideS, U, ldu,
                                   strideU, V, ldv, strideV, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdj_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int, abstol::Cdouble,
                                                         residual::Ptr{Cdouble},
                                                         max_sweeps::rocblas_int,
                                                         n_sweeps::Ptr{rocblas_int},
                                                         S::Ptr{Cdouble},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{rocblas_double_complex},
                                                         ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{rocblas_double_complex},
                                                         ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvdj_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                           strideA, abstol, residual, max_sweeps, n_sweeps,
                                           S, strideS, U, ldu, strideU, V, ldv, strideV,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdj_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 abstol::Cfloat,
                                                                 residual::Ptr{Cfloat},
                                                                 max_sweeps::rocblas_int,
                                                                 n_sweeps::Ptr{rocblas_int},
                                                                 S::Ptr{Cfloat},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{Cfloat},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{Cfloat},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvdj_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                           strideA, abstol, residual, max_sweeps, n_sweeps,
                                           S, strideS, U, ldu, strideU, V, ldv, strideV,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdj_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 abstol::Cdouble,
                                                                 residual::Ptr{Cdouble},
                                                                 max_sweeps::rocblas_int,
                                                                 n_sweeps::Ptr{rocblas_int},
                                                                 S::Ptr{Cdouble},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{Cdouble},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{Cdouble},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvdj_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                           strideA, abstol, residual, max_sweeps, n_sweeps,
                                           S, strideS, U, ldu, strideU, V, ldv, strideV,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdj_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 abstol::Cfloat,
                                                                 residual::Ptr{Cfloat},
                                                                 max_sweeps::rocblas_int,
                                                                 n_sweeps::Ptr{rocblas_int},
                                                                 S::Ptr{Cfloat},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{rocblas_float_complex},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{rocblas_float_complex},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvdj_strided_batched(handle, left_svect, right_svect, m, n, A, lda,
                                           strideA, abstol, residual, max_sweeps, n_sweeps,
                                           S, strideS, U, ldu, strideU, V, ldv, strideV,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdj_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 abstol::Cdouble,
                                                                 residual::Ptr{Cdouble},
                                                                 max_sweeps::rocblas_int,
                                                                 n_sweeps::Ptr{rocblas_int},
                                                                 S::Ptr{Cdouble},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{rocblas_double_complex},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{rocblas_double_complex},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvdx(handle, left_svect, right_svect, srange, m, n, A, lda, vl, vu,
                           il, iu, nsv, S, U, ldu, V, ldv, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdx(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect,
                                                 srange::rocblas_srange, m::rocblas_int,
                                                 n::rocblas_int, A::Ptr{Cfloat},
                                                 lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nsv::Ptr{rocblas_int}, S::Ptr{Cfloat},
                                                 U::Ptr{Cfloat}, ldu::rocblas_int,
                                                 V::Ptr{Cfloat}, ldv::rocblas_int,
                                                 ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgesvdx(handle, left_svect, right_svect, srange, m, n, A, lda, vl, vu,
                           il, iu, nsv, S, U, ldu, V, ldv, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdx(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect,
                                                 srange::rocblas_srange, m::rocblas_int,
                                                 n::rocblas_int, A::Ptr{Cdouble},
                                                 lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nsv::Ptr{rocblas_int}, S::Ptr{Cdouble},
                                                 U::Ptr{Cdouble}, ldu::rocblas_int,
                                                 V::Ptr{Cdouble}, ldv::rocblas_int,
                                                 ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgesvdx(handle, left_svect, right_svect, srange, m, n, A, lda, vl, vu,
                           il, iu, nsv, S, U, ldu, V, ldv, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdx(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect,
                                                 srange::rocblas_srange, m::rocblas_int,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nsv::Ptr{rocblas_int}, S::Ptr{Cfloat},
                                                 U::Ptr{rocblas_float_complex},
                                                 ldu::rocblas_int,
                                                 V::Ptr{rocblas_float_complex},
                                                 ldv::rocblas_int, ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgesvdx(handle, left_svect, right_svect, srange, m, n, A, lda, vl, vu,
                           il, iu, nsv, S, U, ldu, V, ldv, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdx(handle::rocblas_handle,
                                                 left_svect::rocblas_svect,
                                                 right_svect::rocblas_svect,
                                                 srange::rocblas_srange, m::rocblas_int,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nsv::Ptr{rocblas_int}, S::Ptr{Cdouble},
                                                 U::Ptr{rocblas_double_complex},
                                                 ldu::rocblas_int,
                                                 V::Ptr{rocblas_double_complex},
                                                 ldv::rocblas_int, ifail::Ptr{rocblas_int},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgesvdx_batched(handle, left_svect, right_svect, srange, m, n, A, lda,
                                   vl, vu, il, iu, nsv, S, strideS, U, ldu, strideU, V, ldv,
                                   strideV, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdx_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         srange::rocblas_srange,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nsv::Ptr{rocblas_int},
                                                         S::Ptr{Cfloat},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{Cfloat}, ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{Cfloat}, ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         ifail::Ptr{rocblas_int},
                                                         strideF::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvdx_batched(handle, left_svect, right_svect, srange, m, n, A, lda,
                                   vl, vu, il, iu, nsv, S, strideS, U, ldu, strideU, V, ldv,
                                   strideV, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdx_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         srange::rocblas_srange,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nsv::Ptr{rocblas_int},
                                                         S::Ptr{Cdouble},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{Cdouble}, ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{Cdouble}, ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         ifail::Ptr{rocblas_int},
                                                         strideF::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvdx_batched(handle, left_svect, right_svect, srange, m, n, A, lda,
                                   vl, vu, il, iu, nsv, S, strideS, U, ldu, strideU, V, ldv,
                                   strideV, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdx_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         srange::rocblas_srange,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nsv::Ptr{rocblas_int},
                                                         S::Ptr{Cfloat},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{rocblas_float_complex},
                                                         ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{rocblas_float_complex},
                                                         ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         ifail::Ptr{rocblas_int},
                                                         strideF::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvdx_batched(handle, left_svect, right_svect, srange, m, n, A, lda,
                                   vl, vu, il, iu, nsv, S, strideS, U, ldu, strideU, V, ldv,
                                   strideV, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdx_batched(handle::rocblas_handle,
                                                         left_svect::rocblas_svect,
                                                         right_svect::rocblas_svect,
                                                         srange::rocblas_srange,
                                                         m::rocblas_int, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nsv::Ptr{rocblas_int},
                                                         S::Ptr{Cdouble},
                                                         strideS::rocblas_stride,
                                                         U::Ptr{rocblas_double_complex},
                                                         ldu::rocblas_int,
                                                         strideU::rocblas_stride,
                                                         V::Ptr{rocblas_double_complex},
                                                         ldv::rocblas_int,
                                                         strideV::rocblas_stride,
                                                         ifail::Ptr{rocblas_int},
                                                         strideF::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgesvdx_strided_batched(handle, left_svect, right_svect, srange, m, n, A,
                                           lda, strideA, vl, vu, il, iu, nsv, S, strideS, U,
                                           ldu, strideU, V, ldv, strideV, ifail, strideF,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgesvdx_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 srange::rocblas_srange,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nsv::Ptr{rocblas_int},
                                                                 S::Ptr{Cfloat},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{Cfloat},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{Cfloat},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 ifail::Ptr{rocblas_int},
                                                                 strideF::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgesvdx_strided_batched(handle, left_svect, right_svect, srange, m, n, A,
                                           lda, strideA, vl, vu, il, iu, nsv, S, strideS, U,
                                           ldu, strideU, V, ldv, strideV, ifail, strideF,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgesvdx_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 srange::rocblas_srange,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nsv::Ptr{rocblas_int},
                                                                 S::Ptr{Cdouble},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{Cdouble},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{Cdouble},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 ifail::Ptr{rocblas_int},
                                                                 strideF::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgesvdx_strided_batched(handle, left_svect, right_svect, srange, m, n, A,
                                           lda, strideA, vl, vu, il, iu, nsv, S, strideS, U,
                                           ldu, strideU, V, ldv, strideV, ifail, strideF,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgesvdx_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 srange::rocblas_srange,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nsv::Ptr{rocblas_int},
                                                                 S::Ptr{Cfloat},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{rocblas_float_complex},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{rocblas_float_complex},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 ifail::Ptr{rocblas_int},
                                                                 strideF::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgesvdx_strided_batched(handle, left_svect, right_svect, srange, m, n, A,
                                           lda, strideA, vl, vu, il, iu, nsv, S, strideS, U,
                                           ldu, strideU, V, ldv, strideV, ifail, strideF,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgesvdx_strided_batched(handle::rocblas_handle,
                                                                 left_svect::rocblas_svect,
                                                                 right_svect::rocblas_svect,
                                                                 srange::rocblas_srange,
                                                                 m::rocblas_int,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nsv::Ptr{rocblas_int},
                                                                 S::Ptr{Cdouble},
                                                                 strideS::rocblas_stride,
                                                                 U::Ptr{rocblas_double_complex},
                                                                 ldu::rocblas_int,
                                                                 strideU::rocblas_stride,
                                                                 V::Ptr{rocblas_double_complex},
                                                                 ldv::rocblas_int,
                                                                 strideV::rocblas_stride,
                                                                 ifail::Ptr{rocblas_int},
                                                                 strideF::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytd2(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytd2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tau::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dsytd2(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytd2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tau::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_chetd2(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetd2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tau::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zhetd2(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetd2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tau::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_ssytd2_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytd2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytd2_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytd2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chetd2_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetd2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhetd2_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetd2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytd2_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytd2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytd2_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytd2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chetd2_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetd2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhetd2_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetd2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytrd(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tau::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dsytrd(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tau::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_chetrd(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                tau::Ptr{rocblas_float_complex})::rocblas_status)
end

function rocsolver_zhetrd(handle, uplo, n, A, lda, D, E, tau)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetrd(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                tau::Ptr{rocblas_double_complex})::rocblas_status)
end

function rocsolver_ssytrd_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrd_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{Cfloat},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytrd_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrd_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{Cdouble},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chetrd_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetrd_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{rocblas_float_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhetrd_batched(handle, uplo, n, A, lda, D, strideD, E, strideE, tau,
                                  strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetrd_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        tau::Ptr{rocblas_double_complex},
                                                        strideP::rocblas_stride,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytrd_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrd_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{Cfloat},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytrd_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrd_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{Cdouble},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chetrd_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chetrd_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{rocblas_float_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhetrd_strided_batched(handle, uplo, n, A, lda, strideA, D, strideD, E,
                                          strideE, tau, strideP, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhetrd_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                tau::Ptr{rocblas_double_complex},
                                                                strideP::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygs2(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygs2(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, B::Ptr{Cfloat},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_dsygs2(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygs2(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, B::Ptr{Cdouble},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_chegs2(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegs2(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_zhegs2(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegs2(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_ssygs2_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygs2_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygs2_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygs2_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegs2_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegs2_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegs2_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegs2_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygs2_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygs2_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygs2_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygs2_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegs2_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegs2_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegs2_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegs2_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygst(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygst(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, B::Ptr{Cfloat},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_dsygst(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygst(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, B::Ptr{Cdouble},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_chegst(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegst(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_zhegst(handle, itype, uplo, n, A, lda, B, ldb)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegst(handle::rocblas_handle,
                                                itype::rocblas_eform, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int)::rocblas_status)
end

function rocsolver_ssygst_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygst_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygst_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygst_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegst_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegst_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegst_batched(handle, itype, uplo, n, A, lda, B, ldb, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegst_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int,
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygst_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygst_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygst_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygst_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegst_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegst_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegst_strided_batched(handle, itype, uplo, n, A, lda, strideA, B, ldb,
                                          strideB, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegst_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyev(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyev(handle::rocblas_handle, evect::rocblas_evect,
                                               uplo::rocblas_fill, n::rocblas_int,
                                               A::Ptr{Cfloat}, lda::rocblas_int,
                                               D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyev(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyev(handle::rocblas_handle, evect::rocblas_evect,
                                               uplo::rocblas_fill, n::rocblas_int,
                                               A::Ptr{Cdouble}, lda::rocblas_int,
                                               D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheev(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheev(handle::rocblas_handle, evect::rocblas_evect,
                                               uplo::rocblas_fill, n::rocblas_int,
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int, D::Ptr{Cfloat},
                                               E::Ptr{Cfloat},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheev(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheev(handle::rocblas_handle, evect::rocblas_evect,
                                               uplo::rocblas_fill, n::rocblas_int,
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int, D::Ptr{Cdouble},
                                               E::Ptr{Cdouble},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyev_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                 info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyev_batched(handle::rocblas_handle,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{Cfloat}},
                                                       lda::rocblas_int, D::Ptr{Cfloat},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cfloat},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyev_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                 info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyev_batched(handle::rocblas_handle,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{Cdouble}},
                                                       lda::rocblas_int, D::Ptr{Cdouble},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cdouble},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheev_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                 info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheev_batched(handle::rocblas_handle,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_float_complex}},
                                                       lda::rocblas_int, D::Ptr{Cfloat},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cfloat},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheev_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                 info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheev_batched(handle::rocblas_handle,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_double_complex}},
                                                       lda::rocblas_int, D::Ptr{Cdouble},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cdouble},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyev_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                         strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyev_strided_batched(handle::rocblas_handle,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{Cfloat},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               D::Ptr{Cfloat},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cfloat},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyev_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                         strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyev_strided_batched(handle::rocblas_handle,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{Cdouble},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               D::Ptr{Cdouble},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cdouble},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheev_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                         strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheev_strided_batched(handle::rocblas_handle,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{rocblas_float_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               D::Ptr{Cfloat},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cfloat},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheev_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                         strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheev_strided_batched(handle::rocblas_handle,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{rocblas_double_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               D::Ptr{Cdouble},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cdouble},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevd(handle::rocblas_handle,
                                                evect::rocblas_evect, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevd(handle::rocblas_handle,
                                                evect::rocblas_evect, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevd(handle::rocblas_handle,
                                                evect::rocblas_evect, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheevd(handle, evect, uplo, n, A, lda, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevd(handle::rocblas_handle,
                                                evect::rocblas_evect, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyevd_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevd_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevd_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevd_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevd_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevd_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevd_batched(handle, evect, uplo, n, A, lda, D, strideD, E, strideE,
                                  info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevd_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevd_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                          strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevd_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevd_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                          strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevd_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevd_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                          strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevd_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevd_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                          strideD, E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevd_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevdj(handle, evect, uplo, n, A, lda, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdj(handle::rocblas_handle,
                                                 evect::rocblas_evect, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cfloat},
                                                 lda::rocblas_int, D::Ptr{Cfloat},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyevdj(handle, evect, uplo, n, A, lda, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdj(handle::rocblas_handle,
                                                 evect::rocblas_evect, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cdouble},
                                                 lda::rocblas_int, D::Ptr{Cdouble},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheevdj(handle, evect, uplo, n, A, lda, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdj(handle::rocblas_handle,
                                                 evect::rocblas_evect, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int, D::Ptr{Cfloat},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheevdj(handle, evect, uplo, n, A, lda, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdj(handle::rocblas_handle,
                                                 evect::rocblas_evect, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int, D::Ptr{Cdouble},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyevdj_batched(handle, evect, uplo, n, A, lda, D, strideD, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdj_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int, D::Ptr{Cfloat},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevdj_batched(handle, evect, uplo, n, A, lda, D, strideD, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdj_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int, D::Ptr{Cdouble},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevdj_batched(handle, evect, uplo, n, A, lda, D, strideD, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdj_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int, D::Ptr{Cfloat},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevdj_batched(handle, evect, uplo, n, A, lda, D, strideD, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdj_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int, D::Ptr{Cdouble},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevdj_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                           strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdj_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 D::Ptr{Cfloat},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevdj_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                           strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdj_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 D::Ptr{Cdouble},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevdj_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                           strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdj_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 D::Ptr{Cfloat},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevdj_strided_batched(handle, evect, uplo, n, A, lda, strideA, D,
                                           strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdj_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 D::Ptr{Cdouble},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvdj(handle, itype, evect, uplo, n, A, lda, B, ldb, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdj(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 uplo::rocblas_fill, n::rocblas_int,
                                                 A::Ptr{Cfloat}, lda::rocblas_int,
                                                 B::Ptr{Cfloat}, ldb::rocblas_int,
                                                 D::Ptr{Cfloat},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygvdj(handle, itype, evect, uplo, n, A, lda, B, ldb, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdj(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 uplo::rocblas_fill, n::rocblas_int,
                                                 A::Ptr{Cdouble}, lda::rocblas_int,
                                                 B::Ptr{Cdouble}, ldb::rocblas_int,
                                                 D::Ptr{Cdouble},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegvdj(handle, itype, evect, uplo, n, A, lda, B, ldb, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdj(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 uplo::rocblas_fill, n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int,
                                                 B::Ptr{rocblas_float_complex},
                                                 ldb::rocblas_int, D::Ptr{Cfloat},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegvdj(handle, itype, evect, uplo, n, A, lda, B, ldb, D, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdj(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 uplo::rocblas_fill, n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int,
                                                 B::Ptr{rocblas_double_complex},
                                                 ldb::rocblas_int, D::Ptr{Cdouble},
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygvdj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D,
                                   strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdj_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{Cfloat}},
                                                         ldb::rocblas_int, D::Ptr{Cfloat},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvdj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D,
                                   strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdj_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{Cdouble}},
                                                         ldb::rocblas_int, D::Ptr{Cdouble},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvdj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D,
                                   strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdj_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{rocblas_float_complex}},
                                                         ldb::rocblas_int, D::Ptr{Cfloat},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvdj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D,
                                   strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdj_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{rocblas_double_complex}},
                                                         ldb::rocblas_int, D::Ptr{Cdouble},
                                                         strideD::rocblas_stride,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvdj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA,
                                           B, ldb, strideB, D, strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdj_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{Cfloat},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 D::Ptr{Cfloat},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvdj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA,
                                           B, ldb, strideB, D, strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdj_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{Cdouble},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 D::Ptr{Cdouble},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvdj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA,
                                           B, ldb, strideB, D, strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdj_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{rocblas_float_complex},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 D::Ptr{Cfloat},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvdj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA,
                                           B, ldb, strideB, D, strideD, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdj_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{rocblas_double_complex},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 D::Ptr{Cdouble},
                                                                 strideD::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevj(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevj(handle::rocblas_handle,
                                                esort::rocblas_esort, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                abstol::Cfloat, residual::Ptr{Cfloat},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyevj(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevj(handle::rocblas_handle,
                                                esort::rocblas_esort, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                abstol::Cdouble, residual::Ptr{Cdouble},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheevj(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevj(handle::rocblas_handle,
                                                esort::rocblas_esort, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, abstol::Cfloat,
                                                residual::Ptr{Cfloat},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheevj(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevj(handle::rocblas_handle,
                                                esort::rocblas_esort, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, abstol::Cdouble,
                                                residual::Ptr{Cdouble},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyevj_batched(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                                  max_sweeps, n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevj_batched(handle::rocblas_handle,
                                                        esort::rocblas_esort,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, abstol::Cfloat,
                                                        residual::Ptr{Cfloat},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevj_batched(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                                  max_sweeps, n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevj_batched(handle::rocblas_handle,
                                                        esort::rocblas_esort,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, abstol::Cdouble,
                                                        residual::Ptr{Cdouble},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevj_batched(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                                  max_sweeps, n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevj_batched(handle::rocblas_handle,
                                                        esort::rocblas_esort,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, abstol::Cfloat,
                                                        residual::Ptr{Cfloat},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevj_batched(handle, esort, evect, uplo, n, A, lda, abstol, residual,
                                  max_sweeps, n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevj_batched(handle::rocblas_handle,
                                                        esort::rocblas_esort,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, abstol::Cdouble,
                                                        residual::Ptr{Cdouble},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevj_strided_batched(handle, esort, evect, uplo, n, A, lda, strideA,
                                          abstol, residual, max_sweeps, n_sweeps, W,
                                          strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevj_strided_batched(handle::rocblas_handle,
                                                                esort::rocblas_esort,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                abstol::Cfloat,
                                                                residual::Ptr{Cfloat},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevj_strided_batched(handle, esort, evect, uplo, n, A, lda, strideA,
                                          abstol, residual, max_sweeps, n_sweeps, W,
                                          strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevj_strided_batched(handle::rocblas_handle,
                                                                esort::rocblas_esort,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                abstol::Cdouble,
                                                                residual::Ptr{Cdouble},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevj_strided_batched(handle, esort, evect, uplo, n, A, lda, strideA,
                                          abstol, residual, max_sweeps, n_sweeps, W,
                                          strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevj_strided_batched(handle::rocblas_handle,
                                                                esort::rocblas_esort,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                abstol::Cfloat,
                                                                residual::Ptr{Cfloat},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevj_strided_batched(handle, esort, evect, uplo, n, A, lda, strideA,
                                          abstol, residual, max_sweeps, n_sweeps, W,
                                          strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevj_strided_batched(handle::rocblas_handle,
                                                                esort::rocblas_esort,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                abstol::Cdouble,
                                                                residual::Ptr{Cdouble},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, abstol,
                          nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevx(handle::rocblas_handle,
                                                evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cfloat, nev::Ptr{rocblas_int},
                                                W::Ptr{Cfloat}, Z::Ptr{Cfloat},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyevx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, abstol,
                          nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevx(handle::rocblas_handle,
                                                evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cdouble, nev::Ptr{rocblas_int},
                                                W::Ptr{Cdouble}, Z::Ptr{Cdouble},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheevx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, abstol,
                          nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevx(handle::rocblas_handle,
                                                evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cfloat, nev::Ptr{rocblas_int},
                                                W::Ptr{Cfloat},
                                                Z::Ptr{rocblas_float_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheevx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, abstol,
                          nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevx(handle::rocblas_handle,
                                                evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cdouble, nev::Ptr{rocblas_int},
                                                W::Ptr{Cdouble},
                                                Z::Ptr{rocblas_double_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyevx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                  abstol, nev, W, strideW, Z, ldz, ifail, strideF, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevx_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int, vl::Cfloat,
                                                        vu::Cfloat, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cfloat,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{Cfloat}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                  abstol, nev, W, strideW, Z, ldz, ifail, strideF, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevx_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int, vl::Cdouble,
                                                        vu::Cdouble, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cdouble,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{Cdouble}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                  abstol, nev, W, strideW, Z, ldz, ifail, strideF, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevx_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int, vl::Cfloat,
                                                        vu::Cfloat, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cfloat,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{rocblas_float_complex}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                  abstol, nev, W, strideW, Z, ldz, ifail, strideF, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevx_batched(handle::rocblas_handle,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int, vl::Cdouble,
                                                        vu::Cdouble, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cdouble,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{rocblas_double_complex}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                          vl, vu, il, iu, abstol, nev, W, strideW, Z, ldz,
                                          strideZ, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevx_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                vl::Cfloat, vu::Cfloat,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cfloat,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{Cfloat},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                          vl, vu, il, iu, abstol, nev, W, strideW, Z, ldz,
                                          strideZ, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevx_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                vl::Cdouble, vu::Cdouble,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cdouble,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{Cdouble},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                          vl, vu, il, iu, abstol, nev, W, strideW, Z, ldz,
                                          strideZ, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevx_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                vl::Cfloat, vu::Cfloat,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cfloat,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{rocblas_float_complex},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                          vl, vu, il, iu, abstol, nev, W, strideW, Z, ldz,
                                          strideZ, ifail, strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevx_strided_batched(handle::rocblas_handle,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                vl::Cdouble, vu::Cdouble,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cdouble,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{rocblas_double_complex},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygv(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygv(handle::rocblas_handle, itype::rocblas_eform,
                                               evect::rocblas_evect, uplo::rocblas_fill,
                                               n::rocblas_int, A::Ptr{Cfloat},
                                               lda::rocblas_int, B::Ptr{Cfloat},
                                               ldb::rocblas_int, D::Ptr{Cfloat},
                                               E::Ptr{Cfloat},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygv(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygv(handle::rocblas_handle, itype::rocblas_eform,
                                               evect::rocblas_evect, uplo::rocblas_fill,
                                               n::rocblas_int, A::Ptr{Cdouble},
                                               lda::rocblas_int, B::Ptr{Cdouble},
                                               ldb::rocblas_int, D::Ptr{Cdouble},
                                               E::Ptr{Cdouble},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegv(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegv(handle::rocblas_handle, itype::rocblas_eform,
                                               evect::rocblas_evect, uplo::rocblas_fill,
                                               n::rocblas_int,
                                               A::Ptr{rocblas_float_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_float_complex},
                                               ldb::rocblas_int, D::Ptr{Cfloat},
                                               E::Ptr{Cfloat},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegv(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegv(handle::rocblas_handle, itype::rocblas_eform,
                                               evect::rocblas_evect, uplo::rocblas_fill,
                                               n::rocblas_int,
                                               A::Ptr{rocblas_double_complex},
                                               lda::rocblas_int,
                                               B::Ptr{rocblas_double_complex},
                                               ldb::rocblas_int, D::Ptr{Cdouble},
                                               E::Ptr{Cdouble},
                                               info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygv_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                 E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygv_batched(handle::rocblas_handle,
                                                       itype::rocblas_eform,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{Cfloat}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cfloat}},
                                                       ldb::rocblas_int, D::Ptr{Cfloat},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cfloat},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygv_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                 E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygv_batched(handle::rocblas_handle,
                                                       itype::rocblas_eform,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{Cdouble}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{Cdouble}},
                                                       ldb::rocblas_int, D::Ptr{Cdouble},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cdouble},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegv_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                 E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegv_batched(handle::rocblas_handle,
                                                       itype::rocblas_eform,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_float_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_float_complex}},
                                                       ldb::rocblas_int, D::Ptr{Cfloat},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cfloat},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegv_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                 E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegv_batched(handle::rocblas_handle,
                                                       itype::rocblas_eform,
                                                       evect::rocblas_evect,
                                                       uplo::rocblas_fill, n::rocblas_int,
                                                       A::Ptr{Ptr{rocblas_double_complex}},
                                                       lda::rocblas_int,
                                                       B::Ptr{Ptr{rocblas_double_complex}},
                                                       ldb::rocblas_int, D::Ptr{Cdouble},
                                                       strideD::rocblas_stride,
                                                       E::Ptr{Cdouble},
                                                       strideE::rocblas_stride,
                                                       info::Ptr{rocblas_int},
                                                       batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygv_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                         ldb, strideB, D, strideD, E, strideE, info,
                                         batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygv_strided_batched(handle::rocblas_handle,
                                                               itype::rocblas_eform,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{Cfloat},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cfloat},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               D::Ptr{Cfloat},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cfloat},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygv_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                         ldb, strideB, D, strideD, E, strideE, info,
                                         batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygv_strided_batched(handle::rocblas_handle,
                                                               itype::rocblas_eform,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{Cdouble},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{Cdouble},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               D::Ptr{Cdouble},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cdouble},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegv_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                         ldb, strideB, D, strideD, E, strideE, info,
                                         batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegv_strided_batched(handle::rocblas_handle,
                                                               itype::rocblas_eform,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{rocblas_float_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_float_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               D::Ptr{Cfloat},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cfloat},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegv_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                         ldb, strideB, D, strideD, E, strideE, info,
                                         batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegv_strided_batched(handle::rocblas_handle,
                                                               itype::rocblas_eform,
                                                               evect::rocblas_evect,
                                                               uplo::rocblas_fill,
                                                               n::rocblas_int,
                                                               A::Ptr{rocblas_double_complex},
                                                               lda::rocblas_int,
                                                               strideA::rocblas_stride,
                                                               B::Ptr{rocblas_double_complex},
                                                               ldb::rocblas_int,
                                                               strideB::rocblas_stride,
                                                               D::Ptr{Cdouble},
                                                               strideD::rocblas_stride,
                                                               E::Ptr{Cdouble},
                                                               strideE::rocblas_stride,
                                                               info::Ptr{rocblas_int},
                                                               batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvd(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvd(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                B::Ptr{Cfloat}, ldb::rocblas_int,
                                                D::Ptr{Cfloat}, E::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygvd(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvd(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                B::Ptr{Cdouble}, ldb::rocblas_int,
                                                D::Ptr{Cdouble}, E::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegvd(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvd(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int, D::Ptr{Cfloat},
                                                E::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegvd(handle, itype, evect, uplo, n, A, lda, B, ldb, D, E, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvd(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int, D::Ptr{Cdouble},
                                                E::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygvd_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                  E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvd_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvd_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                  E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvd_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvd_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                  E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvd_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int, D::Ptr{Cfloat},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cfloat},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvd_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, D, strideD,
                                  E, strideE, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvd_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int, D::Ptr{Cdouble},
                                                        strideD::rocblas_stride,
                                                        E::Ptr{Cdouble},
                                                        strideE::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvd_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, D, strideD, E, strideE, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvd_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvd_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, D, strideD, E, strideE, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvd_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvd_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, D, strideD, E, strideE, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvd_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                D::Ptr{Cfloat},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cfloat},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvd_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, D, strideD, E, strideE, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvd_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                D::Ptr{Cdouble},
                                                                strideD::rocblas_stride,
                                                                E::Ptr{Cdouble},
                                                                strideE::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvj(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvj(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                B::Ptr{Cfloat}, ldb::rocblas_int,
                                                abstol::Cfloat, residual::Ptr{Cfloat},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygvj(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvj(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                B::Ptr{Cdouble}, ldb::rocblas_int,
                                                abstol::Cdouble, residual::Ptr{Cdouble},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegvj(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvj(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int, abstol::Cfloat,
                                                residual::Ptr{Cfloat},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegvj(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol, residual,
                          max_sweeps, n_sweeps, W, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvj(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                uplo::rocblas_fill, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int, abstol::Cdouble,
                                                residual::Ptr{Cdouble},
                                                max_sweeps::rocblas_int,
                                                n_sweeps::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygvj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol,
                                  residual, max_sweeps, n_sweeps, W, strideW, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvj_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int, abstol::Cfloat,
                                                        residual::Ptr{Cfloat},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol,
                                  residual, max_sweeps, n_sweeps, W, strideW, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvj_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int, abstol::Cdouble,
                                                        residual::Ptr{Cdouble},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol,
                                  residual, max_sweeps, n_sweeps, W, strideW, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvj_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int, abstol::Cfloat,
                                                        residual::Ptr{Cfloat},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvj_batched(handle, itype, evect, uplo, n, A, lda, B, ldb, abstol,
                                  residual, max_sweeps, n_sweeps, W, strideW, info,
                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvj_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int, abstol::Cdouble,
                                                        residual::Ptr{Cdouble},
                                                        max_sweeps::rocblas_int,
                                                        n_sweeps::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, abstol, residual, max_sweeps,
                                          n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvj_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                abstol::Cfloat,
                                                                residual::Ptr{Cfloat},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, abstol, residual, max_sweeps,
                                          n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvj_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                abstol::Cdouble,
                                                                residual::Ptr{Cdouble},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, abstol, residual, max_sweeps,
                                          n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvj_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                abstol::Cfloat,
                                                                residual::Ptr{Cfloat},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvj_strided_batched(handle, itype, evect, uplo, n, A, lda, strideA, B,
                                          ldb, strideB, abstol, residual, max_sweeps,
                                          n_sweeps, W, strideW, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvj_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                abstol::Cdouble,
                                                                residual::Ptr{Cdouble},
                                                                max_sweeps::rocblas_int,
                                                                n_sweeps::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu, il,
                          iu, abstol, nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvx(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, B::Ptr{Cfloat},
                                                ldb::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cfloat, nev::Ptr{rocblas_int},
                                                W::Ptr{Cfloat}, Z::Ptr{Cfloat},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygvx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu, il,
                          iu, abstol, nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvx(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, B::Ptr{Cdouble},
                                                ldb::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cdouble, nev::Ptr{rocblas_int},
                                                W::Ptr{Cdouble}, Z::Ptr{Cdouble},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegvx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu, il,
                          iu, abstol, nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvx(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_float_complex},
                                                ldb::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cfloat, nev::Ptr{rocblas_int},
                                                W::Ptr{Cfloat},
                                                Z::Ptr{rocblas_float_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegvx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu, il,
                          iu, abstol, nev, W, Z, ldz, ifail, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvx(handle::rocblas_handle,
                                                itype::rocblas_eform, evect::rocblas_evect,
                                                erange::rocblas_erange, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                B::Ptr{rocblas_double_complex},
                                                ldb::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                il::rocblas_int, iu::rocblas_int,
                                                abstol::Cdouble, nev::Ptr{rocblas_int},
                                                W::Ptr{Cdouble},
                                                Z::Ptr{rocblas_double_complex},
                                                ldz::rocblas_int, ifail::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygvx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl,
                                  vu, il, iu, abstol, nev, W, strideW, Z, ldz, ifail,
                                  strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvx_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cfloat}},
                                                        ldb::rocblas_int, vl::Cfloat,
                                                        vu::Cfloat, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cfloat,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{Cfloat}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl,
                                  vu, il, iu, abstol, nev, W, strideW, Z, ldz, ifail,
                                  strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvx_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{Cdouble}},
                                                        ldb::rocblas_int, vl::Cdouble,
                                                        vu::Cdouble, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cdouble,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{Cdouble}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl,
                                  vu, il, iu, abstol, nev, W, strideW, Z, ldz, ifail,
                                  strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvx_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_float_complex}},
                                                        ldb::rocblas_int, vl::Cfloat,
                                                        vu::Cfloat, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cfloat,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cfloat},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{rocblas_float_complex}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl,
                                  vu, il, iu, abstol, nev, W, strideW, Z, ldz, ifail,
                                  strideF, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvx_batched(handle::rocblas_handle,
                                                        itype::rocblas_eform,
                                                        evect::rocblas_evect,
                                                        erange::rocblas_erange,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        B::Ptr{Ptr{rocblas_double_complex}},
                                                        ldb::rocblas_int, vl::Cdouble,
                                                        vu::Cdouble, il::rocblas_int,
                                                        iu::rocblas_int, abstol::Cdouble,
                                                        nev::Ptr{rocblas_int},
                                                        W::Ptr{Cdouble},
                                                        strideW::rocblas_stride,
                                                        Z::Ptr{Ptr{rocblas_double_complex}},
                                                        ldz::rocblas_int,
                                                        ifail::Ptr{rocblas_int},
                                                        strideF::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                          strideA, B, ldb, strideB, vl, vu, il, iu, abstol,
                                          nev, W, strideW, Z, ldz, strideZ, ifail, strideF,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvx_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cfloat},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                vl::Cfloat, vu::Cfloat,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cfloat,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{Cfloat},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                          strideA, B, ldb, strideB, vl, vu, il, iu, abstol,
                                          nev, W, strideW, Z, ldz, strideZ, ifail, strideF,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvx_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{Cdouble},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                vl::Cdouble, vu::Cdouble,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cdouble,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{Cdouble},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                          strideA, B, ldb, strideB, vl, vu, il, iu, abstol,
                                          nev, W, strideW, Z, ldz, strideZ, ifail, strideF,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvx_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_float_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                vl::Cfloat, vu::Cfloat,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cfloat,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cfloat},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{rocblas_float_complex},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                          strideA, B, ldb, strideB, vl, vu, il, iu, abstol,
                                          nev, W, strideW, Z, ldz, strideZ, ifail, strideF,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvx_strided_batched(handle::rocblas_handle,
                                                                itype::rocblas_eform,
                                                                evect::rocblas_evect,
                                                                erange::rocblas_erange,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                B::Ptr{rocblas_double_complex},
                                                                ldb::rocblas_int,
                                                                strideB::rocblas_stride,
                                                                vl::Cdouble, vu::Cdouble,
                                                                il::rocblas_int,
                                                                iu::rocblas_int,
                                                                abstol::Cdouble,
                                                                nev::Ptr{rocblas_int},
                                                                W::Ptr{Cdouble},
                                                                strideW::rocblas_stride,
                                                                Z::Ptr{rocblas_double_complex},
                                                                ldz::rocblas_int,
                                                                strideZ::rocblas_stride,
                                                                ifail::Ptr{rocblas_int},
                                                                strideF::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_outofplace(handle, n, A, lda, ipiv, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_outofplace(handle::rocblas_handle,
                                                           n::rocblas_int, A::Ptr{Cfloat},
                                                           lda::rocblas_int,
                                                           ipiv::Ptr{rocblas_int},
                                                           C::Ptr{Cfloat}, ldc::rocblas_int,
                                                           info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetri_outofplace(handle, n, A, lda, ipiv, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_outofplace(handle::rocblas_handle,
                                                           n::rocblas_int, A::Ptr{Cdouble},
                                                           lda::rocblas_int,
                                                           ipiv::Ptr{rocblas_int},
                                                           C::Ptr{Cdouble},
                                                           ldc::rocblas_int,
                                                           info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetri_outofplace(handle, n, A, lda, ipiv, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_outofplace(handle::rocblas_handle,
                                                           n::rocblas_int,
                                                           A::Ptr{rocblas_float_complex},
                                                           lda::rocblas_int,
                                                           ipiv::Ptr{rocblas_int},
                                                           C::Ptr{rocblas_float_complex},
                                                           ldc::rocblas_int,
                                                           info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetri_outofplace(handle, n, A, lda, ipiv, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_outofplace(handle::rocblas_handle,
                                                           n::rocblas_int,
                                                           A::Ptr{rocblas_double_complex},
                                                           lda::rocblas_int,
                                                           ipiv::Ptr{rocblas_int},
                                                           C::Ptr{rocblas_double_complex},
                                                           ldc::rocblas_int,
                                                           info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetri_outofplace_batched(handle, n, A, lda, ipiv, strideP, C, ldc, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_outofplace_batched(handle::rocblas_handle,
                                                                   n::rocblas_int,
                                                                   A::Ptr{Ptr{Cfloat}},
                                                                   lda::rocblas_int,
                                                                   ipiv::Ptr{rocblas_int},
                                                                   strideP::rocblas_stride,
                                                                   C::Ptr{Ptr{Cfloat}},
                                                                   ldc::rocblas_int,
                                                                   info::Ptr{rocblas_int},
                                                                   batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_outofplace_batched(handle, n, A, lda, ipiv, strideP, C, ldc, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_outofplace_batched(handle::rocblas_handle,
                                                                   n::rocblas_int,
                                                                   A::Ptr{Ptr{Cdouble}},
                                                                   lda::rocblas_int,
                                                                   ipiv::Ptr{rocblas_int},
                                                                   strideP::rocblas_stride,
                                                                   C::Ptr{Ptr{Cdouble}},
                                                                   ldc::rocblas_int,
                                                                   info::Ptr{rocblas_int},
                                                                   batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_outofplace_batched(handle, n, A, lda, ipiv, strideP, C, ldc, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_outofplace_batched(handle::rocblas_handle,
                                                                   n::rocblas_int,
                                                                   A::Ptr{Ptr{rocblas_float_complex}},
                                                                   lda::rocblas_int,
                                                                   ipiv::Ptr{rocblas_int},
                                                                   strideP::rocblas_stride,
                                                                   C::Ptr{Ptr{rocblas_float_complex}},
                                                                   ldc::rocblas_int,
                                                                   info::Ptr{rocblas_int},
                                                                   batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_outofplace_batched(handle, n, A, lda, ipiv, strideP, C, ldc, info,
                                             batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_outofplace_batched(handle::rocblas_handle,
                                                                   n::rocblas_int,
                                                                   A::Ptr{Ptr{rocblas_double_complex}},
                                                                   lda::rocblas_int,
                                                                   ipiv::Ptr{rocblas_int},
                                                                   strideP::rocblas_stride,
                                                                   C::Ptr{Ptr{rocblas_double_complex}},
                                                                   ldc::rocblas_int,
                                                                   info::Ptr{rocblas_int},
                                                                   batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_outofplace_strided_batched(handle, n, A, lda, strideA, ipiv,
                                                     strideP, C, ldc, strideC, info,
                                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_outofplace_strided_batched(handle::rocblas_handle,
                                                                           n::rocblas_int,
                                                                           A::Ptr{Cfloat},
                                                                           lda::rocblas_int,
                                                                           strideA::rocblas_stride,
                                                                           ipiv::Ptr{rocblas_int},
                                                                           strideP::rocblas_stride,
                                                                           C::Ptr{Cfloat},
                                                                           ldc::rocblas_int,
                                                                           strideC::rocblas_stride,
                                                                           info::Ptr{rocblas_int},
                                                                           batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_outofplace_strided_batched(handle, n, A, lda, strideA, ipiv,
                                                     strideP, C, ldc, strideC, info,
                                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_outofplace_strided_batched(handle::rocblas_handle,
                                                                           n::rocblas_int,
                                                                           A::Ptr{Cdouble},
                                                                           lda::rocblas_int,
                                                                           strideA::rocblas_stride,
                                                                           ipiv::Ptr{rocblas_int},
                                                                           strideP::rocblas_stride,
                                                                           C::Ptr{Cdouble},
                                                                           ldc::rocblas_int,
                                                                           strideC::rocblas_stride,
                                                                           info::Ptr{rocblas_int},
                                                                           batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_outofplace_strided_batched(handle, n, A, lda, strideA, ipiv,
                                                     strideP, C, ldc, strideC, info,
                                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_outofplace_strided_batched(handle::rocblas_handle,
                                                                           n::rocblas_int,
                                                                           A::Ptr{rocblas_float_complex},
                                                                           lda::rocblas_int,
                                                                           strideA::rocblas_stride,
                                                                           ipiv::Ptr{rocblas_int},
                                                                           strideP::rocblas_stride,
                                                                           C::Ptr{rocblas_float_complex},
                                                                           ldc::rocblas_int,
                                                                           strideC::rocblas_stride,
                                                                           info::Ptr{rocblas_int},
                                                                           batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_outofplace_strided_batched(handle, n, A, lda, strideA, ipiv,
                                                     strideP, C, ldc, strideC, info,
                                                     batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_outofplace_strided_batched(handle::rocblas_handle,
                                                                           n::rocblas_int,
                                                                           A::Ptr{rocblas_double_complex},
                                                                           lda::rocblas_int,
                                                                           strideA::rocblas_stride,
                                                                           ipiv::Ptr{rocblas_int},
                                                                           strideP::rocblas_stride,
                                                                           C::Ptr{rocblas_double_complex},
                                                                           ldc::rocblas_int,
                                                                           strideC::rocblas_stride,
                                                                           info::Ptr{rocblas_int},
                                                                           batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_npvt_outofplace(handle, n, A, lda, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt_outofplace(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                C::Ptr{Cfloat},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgetri_npvt_outofplace(handle, n, A, lda, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt_outofplace(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                C::Ptr{Cdouble},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgetri_npvt_outofplace(handle, n, A, lda, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt_outofplace(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                C::Ptr{rocblas_float_complex},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgetri_npvt_outofplace(handle, n, A, lda, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt_outofplace(handle::rocblas_handle,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                C::Ptr{rocblas_double_complex},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgetri_npvt_outofplace_batched(handle, n, A, lda, C, ldc, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt_outofplace_batched(handle::rocblas_handle,
                                                                        n::rocblas_int,
                                                                        A::Ptr{Ptr{Cfloat}},
                                                                        lda::rocblas_int,
                                                                        C::Ptr{Ptr{Cfloat}},
                                                                        ldc::rocblas_int,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_npvt_outofplace_batched(handle, n, A, lda, C, ldc, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt_outofplace_batched(handle::rocblas_handle,
                                                                        n::rocblas_int,
                                                                        A::Ptr{Ptr{Cdouble}},
                                                                        lda::rocblas_int,
                                                                        C::Ptr{Ptr{Cdouble}},
                                                                        ldc::rocblas_int,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_npvt_outofplace_batched(handle, n, A, lda, C, ldc, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt_outofplace_batched(handle::rocblas_handle,
                                                                        n::rocblas_int,
                                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                                        lda::rocblas_int,
                                                                        C::Ptr{Ptr{rocblas_float_complex}},
                                                                        ldc::rocblas_int,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_npvt_outofplace_batched(handle, n, A, lda, C, ldc, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt_outofplace_batched(handle::rocblas_handle,
                                                                        n::rocblas_int,
                                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                                        lda::rocblas_int,
                                                                        C::Ptr{Ptr{rocblas_double_complex}},
                                                                        ldc::rocblas_int,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgetri_npvt_outofplace_strided_batched(handle, n, A, lda, strideA, C,
                                                          ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgetri_npvt_outofplace_strided_batched(handle::rocblas_handle,
                                                                                n::rocblas_int,
                                                                                A::Ptr{Cfloat},
                                                                                lda::rocblas_int,
                                                                                strideA::rocblas_stride,
                                                                                C::Ptr{Cfloat},
                                                                                ldc::rocblas_int,
                                                                                strideC::rocblas_stride,
                                                                                info::Ptr{rocblas_int},
                                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgetri_npvt_outofplace_strided_batched(handle, n, A, lda, strideA, C,
                                                          ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgetri_npvt_outofplace_strided_batched(handle::rocblas_handle,
                                                                                n::rocblas_int,
                                                                                A::Ptr{Cdouble},
                                                                                lda::rocblas_int,
                                                                                strideA::rocblas_stride,
                                                                                C::Ptr{Cdouble},
                                                                                ldc::rocblas_int,
                                                                                strideC::rocblas_stride,
                                                                                info::Ptr{rocblas_int},
                                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgetri_npvt_outofplace_strided_batched(handle, n, A, lda, strideA, C,
                                                          ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgetri_npvt_outofplace_strided_batched(handle::rocblas_handle,
                                                                                n::rocblas_int,
                                                                                A::Ptr{rocblas_float_complex},
                                                                                lda::rocblas_int,
                                                                                strideA::rocblas_stride,
                                                                                C::Ptr{rocblas_float_complex},
                                                                                ldc::rocblas_int,
                                                                                strideC::rocblas_stride,
                                                                                info::Ptr{rocblas_int},
                                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgetri_npvt_outofplace_strided_batched(handle, n, A, lda, strideA, C,
                                                          ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgetri_npvt_outofplace_strided_batched(handle::rocblas_handle,
                                                                                n::rocblas_int,
                                                                                A::Ptr{rocblas_double_complex},
                                                                                lda::rocblas_int,
                                                                                strideA::rocblas_stride,
                                                                                C::Ptr{rocblas_double_complex},
                                                                                ldc::rocblas_int,
                                                                                strideC::rocblas_stride,
                                                                                info::Ptr{rocblas_int},
                                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_strtri(handle, uplo, diag, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_strtri(handle::rocblas_handle, uplo::rocblas_fill,
                                                diag::rocblas_diagonal, n::rocblas_int,
                                                A::Ptr{Cfloat}, lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dtrtri(handle, uplo, diag, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dtrtri(handle::rocblas_handle, uplo::rocblas_fill,
                                                diag::rocblas_diagonal, n::rocblas_int,
                                                A::Ptr{Cdouble}, lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ctrtri(handle, uplo, diag, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ctrtri(handle::rocblas_handle, uplo::rocblas_fill,
                                                diag::rocblas_diagonal, n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ztrtri(handle, uplo, diag, n, A, lda, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ztrtri(handle::rocblas_handle, uplo::rocblas_fill,
                                                diag::rocblas_diagonal, n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int,
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_strtri_batched(handle, uplo, diag, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_strtri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill,
                                                        diag::rocblas_diagonal,
                                                        n::rocblas_int, A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dtrtri_batched(handle, uplo, diag, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dtrtri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill,
                                                        diag::rocblas_diagonal,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ctrtri_batched(handle, uplo, diag, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ctrtri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill,
                                                        diag::rocblas_diagonal,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ztrtri_batched(handle, uplo, diag, n, A, lda, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ztrtri_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill,
                                                        diag::rocblas_diagonal,
                                                        n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_strtri_strided_batched(handle, uplo, diag, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_strtri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                diag::rocblas_diagonal,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dtrtri_strided_batched(handle, uplo, diag, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dtrtri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                diag::rocblas_diagonal,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ctrtri_strided_batched(handle, uplo, diag, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ctrtri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                diag::rocblas_diagonal,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ztrtri_strided_batched(handle, uplo, diag, n, A, lda, strideA, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ztrtri_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                diag::rocblas_diagonal,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytf2(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsytf2(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_csytf2(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zsytf2(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytf2(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssytf2_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytf2_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_csytf2_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zsytf2_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytf2_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytf2_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytf2_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_csytf2_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zsytf2_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytf2_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cfloat},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int, A::Ptr{Cdouble},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_csytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_float_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zsytrf(handle, uplo, n, A, lda, ipiv, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytrf(handle::rocblas_handle, uplo::rocblas_fill,
                                                n::rocblas_int,
                                                A::Ptr{rocblas_double_complex},
                                                lda::rocblas_int, ipiv::Ptr{rocblas_int},
                                                info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssytrf_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cfloat}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytrf_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{Cdouble}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_csytrf_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_float_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zsytrf_batched(handle, uplo, n, A, lda, ipiv, strideP, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytrf_batched(handle::rocblas_handle,
                                                        uplo::rocblas_fill, n::rocblas_int,
                                                        A::Ptr{Ptr{rocblas_double_complex}},
                                                        lda::rocblas_int,
                                                        ipiv::Ptr{rocblas_int},
                                                        strideP::rocblas_stride,
                                                        info::Ptr{rocblas_int},
                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssytrf_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssytrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cfloat},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsytrf_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsytrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{Cdouble},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_csytrf_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_csytrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_float_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zsytrf_strided_batched(handle, uplo, n, A, lda, strideA, ipiv, strideP,
                                          info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zsytrf_strided_batched(handle::rocblas_handle,
                                                                uplo::rocblas_fill,
                                                                n::rocblas_int,
                                                                A::Ptr{rocblas_double_complex},
                                                                lda::rocblas_int,
                                                                strideA::rocblas_stride,
                                                                ipiv::Ptr{rocblas_int},
                                                                strideP::rocblas_stride,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrf_npvt(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrf_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        A::Ptr{Cfloat}, lda::rocblas_int,
                                                        B::Ptr{Cfloat}, ldb::rocblas_int,
                                                        C::Ptr{Cfloat}, ldc::rocblas_int,
                                                        info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dgeblttrf_npvt(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrf_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        A::Ptr{Cdouble}, lda::rocblas_int,
                                                        B::Ptr{Cdouble}, ldb::rocblas_int,
                                                        C::Ptr{Cdouble}, ldc::rocblas_int,
                                                        info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cgeblttrf_npvt(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrf_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        A::Ptr{rocblas_float_complex},
                                                        lda::rocblas_int,
                                                        B::Ptr{rocblas_float_complex},
                                                        ldb::rocblas_int,
                                                        C::Ptr{rocblas_float_complex},
                                                        ldc::rocblas_int,
                                                        info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zgeblttrf_npvt(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrf_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        A::Ptr{rocblas_double_complex},
                                                        lda::rocblas_int,
                                                        B::Ptr{rocblas_double_complex},
                                                        ldb::rocblas_int,
                                                        C::Ptr{rocblas_double_complex},
                                                        ldc::rocblas_int,
                                                        info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_sgeblttrf_npvt_batched(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrf_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                A::Ptr{Ptr{Cfloat}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{Cfloat}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{Cfloat}},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrf_npvt_batched(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrf_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                A::Ptr{Ptr{Cdouble}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{Cdouble}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{Cdouble}},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrf_npvt_batched(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrf_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                A::Ptr{Ptr{rocblas_float_complex}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{rocblas_float_complex}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{rocblas_float_complex}},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrf_npvt_batched(handle, nb, nblocks, A, lda, B, ldb, C, ldc, info,
                                          batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrf_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                A::Ptr{Ptr{rocblas_double_complex}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{rocblas_double_complex}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{rocblas_double_complex}},
                                                                ldc::rocblas_int,
                                                                info::Ptr{rocblas_int},
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrf_npvt_strided_batched(handle, nb, nblocks, A, lda, strideA, B,
                                                  ldb, strideB, C, ldc, strideC, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrf_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        A::Ptr{Cfloat},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{Cfloat},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{Cfloat},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrf_npvt_strided_batched(handle, nb, nblocks, A, lda, strideA, B,
                                                  ldb, strideB, C, ldc, strideC, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrf_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        A::Ptr{Cdouble},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{Cdouble},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{Cdouble},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrf_npvt_strided_batched(handle, nb, nblocks, A, lda, strideA, B,
                                                  ldb, strideB, C, ldc, strideC, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrf_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        A::Ptr{rocblas_float_complex},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{rocblas_float_complex},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{rocblas_float_complex},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrf_npvt_strided_batched(handle, nb, nblocks, A, lda, strideA, B,
                                                  ldb, strideB, C, ldc, strideC, info,
                                                  batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrf_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        A::Ptr{rocblas_double_complex},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{rocblas_double_complex},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{rocblas_double_complex},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        info::Ptr{rocblas_int},
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrf_npvt_interleaved_batched(handle, nb, nblocks, A, inca, lda,
                                                      strideA, B, incb, ldb, strideB, C,
                                                      incc, ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrf_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            A::Ptr{Cfloat},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{Cfloat},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{Cfloat},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            info::Ptr{rocblas_int},
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrf_npvt_interleaved_batched(handle, nb, nblocks, A, inca, lda,
                                                      strideA, B, incb, ldb, strideB, C,
                                                      incc, ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrf_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            A::Ptr{Cdouble},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{Cdouble},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{Cdouble},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            info::Ptr{rocblas_int},
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrf_npvt_interleaved_batched(handle, nb, nblocks, A, inca, lda,
                                                      strideA, B, incb, ldb, strideB, C,
                                                      incc, ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrf_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            A::Ptr{rocblas_float_complex},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{rocblas_float_complex},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{rocblas_float_complex},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            info::Ptr{rocblas_int},
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrf_npvt_interleaved_batched(handle, nb, nblocks, A, inca, lda,
                                                      strideA, B, incb, ldb, strideB, C,
                                                      incc, ldc, strideC, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrf_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            A::Ptr{rocblas_double_complex},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{rocblas_double_complex},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{rocblas_double_complex},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            info::Ptr{rocblas_int},
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrs_npvt(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc, X, ldx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrs_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        nrhs::rocblas_int, A::Ptr{Cfloat},
                                                        lda::rocblas_int, B::Ptr{Cfloat},
                                                        ldb::rocblas_int, C::Ptr{Cfloat},
                                                        ldc::rocblas_int, X::Ptr{Cfloat},
                                                        ldx::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrs_npvt(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc, X, ldx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrs_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        nrhs::rocblas_int, A::Ptr{Cdouble},
                                                        lda::rocblas_int, B::Ptr{Cdouble},
                                                        ldb::rocblas_int, C::Ptr{Cdouble},
                                                        ldc::rocblas_int, X::Ptr{Cdouble},
                                                        ldx::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrs_npvt(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc, X, ldx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrs_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{rocblas_float_complex},
                                                        lda::rocblas_int,
                                                        B::Ptr{rocblas_float_complex},
                                                        ldb::rocblas_int,
                                                        C::Ptr{rocblas_float_complex},
                                                        ldc::rocblas_int,
                                                        X::Ptr{rocblas_float_complex},
                                                        ldx::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrs_npvt(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc, X, ldx)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrs_npvt(handle::rocblas_handle,
                                                        nb::rocblas_int,
                                                        nblocks::rocblas_int,
                                                        nrhs::rocblas_int,
                                                        A::Ptr{rocblas_double_complex},
                                                        lda::rocblas_int,
                                                        B::Ptr{rocblas_double_complex},
                                                        ldb::rocblas_int,
                                                        C::Ptr{rocblas_double_complex},
                                                        ldc::rocblas_int,
                                                        X::Ptr{rocblas_double_complex},
                                                        ldx::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrs_npvt_batched(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc,
                                          X, ldx, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrs_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Ptr{Cfloat}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{Cfloat}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{Cfloat}},
                                                                ldc::rocblas_int,
                                                                X::Ptr{Ptr{Cfloat}},
                                                                ldx::rocblas_int,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrs_npvt_batched(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc,
                                          X, ldx, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrs_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Ptr{Cdouble}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{Cdouble}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{Cdouble}},
                                                                ldc::rocblas_int,
                                                                X::Ptr{Ptr{Cdouble}},
                                                                ldx::rocblas_int,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrs_npvt_batched(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc,
                                          X, ldx, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrs_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Ptr{rocblas_float_complex}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{rocblas_float_complex}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{rocblas_float_complex}},
                                                                ldc::rocblas_int,
                                                                X::Ptr{Ptr{rocblas_float_complex}},
                                                                ldx::rocblas_int,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrs_npvt_batched(handle, nb, nblocks, nrhs, A, lda, B, ldb, C, ldc,
                                          X, ldx, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrs_npvt_batched(handle::rocblas_handle,
                                                                nb::rocblas_int,
                                                                nblocks::rocblas_int,
                                                                nrhs::rocblas_int,
                                                                A::Ptr{Ptr{rocblas_double_complex}},
                                                                lda::rocblas_int,
                                                                B::Ptr{Ptr{rocblas_double_complex}},
                                                                ldb::rocblas_int,
                                                                C::Ptr{Ptr{rocblas_double_complex}},
                                                                ldc::rocblas_int,
                                                                X::Ptr{Ptr{rocblas_double_complex}},
                                                                ldx::rocblas_int,
                                                                batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrs_npvt_strided_batched(handle, nb, nblocks, nrhs, A, lda,
                                                  strideA, B, ldb, strideB, C, ldc, strideC,
                                                  X, ldx, strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrs_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        nrhs::rocblas_int,
                                                                        A::Ptr{Cfloat},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{Cfloat},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{Cfloat},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        X::Ptr{Cfloat},
                                                                        ldx::rocblas_int,
                                                                        strideX::rocblas_stride,
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrs_npvt_strided_batched(handle, nb, nblocks, nrhs, A, lda,
                                                  strideA, B, ldb, strideB, C, ldc, strideC,
                                                  X, ldx, strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrs_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        nrhs::rocblas_int,
                                                                        A::Ptr{Cdouble},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{Cdouble},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{Cdouble},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        X::Ptr{Cdouble},
                                                                        ldx::rocblas_int,
                                                                        strideX::rocblas_stride,
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrs_npvt_strided_batched(handle, nb, nblocks, nrhs, A, lda,
                                                  strideA, B, ldb, strideB, C, ldc, strideC,
                                                  X, ldx, strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrs_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        nrhs::rocblas_int,
                                                                        A::Ptr{rocblas_float_complex},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{rocblas_float_complex},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{rocblas_float_complex},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        X::Ptr{rocblas_float_complex},
                                                                        ldx::rocblas_int,
                                                                        strideX::rocblas_stride,
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrs_npvt_strided_batched(handle, nb, nblocks, nrhs, A, lda,
                                                  strideA, B, ldb, strideB, C, ldc, strideC,
                                                  X, ldx, strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrs_npvt_strided_batched(handle::rocblas_handle,
                                                                        nb::rocblas_int,
                                                                        nblocks::rocblas_int,
                                                                        nrhs::rocblas_int,
                                                                        A::Ptr{rocblas_double_complex},
                                                                        lda::rocblas_int,
                                                                        strideA::rocblas_stride,
                                                                        B::Ptr{rocblas_double_complex},
                                                                        ldb::rocblas_int,
                                                                        strideB::rocblas_stride,
                                                                        C::Ptr{rocblas_double_complex},
                                                                        ldc::rocblas_int,
                                                                        strideC::rocblas_stride,
                                                                        X::Ptr{rocblas_double_complex},
                                                                        ldx::rocblas_int,
                                                                        strideX::rocblas_stride,
                                                                        batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_sgeblttrs_npvt_interleaved_batched(handle, nb, nblocks, nrhs, A, inca,
                                                      lda, strideA, B, incb, ldb, strideB,
                                                      C, incc, ldc, strideC, X, incx, ldx,
                                                      strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_sgeblttrs_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            nrhs::rocblas_int,
                                                                            A::Ptr{Cfloat},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{Cfloat},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{Cfloat},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            X::Ptr{Cfloat},
                                                                            incx::rocblas_int,
                                                                            ldx::rocblas_int,
                                                                            strideX::rocblas_stride,
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dgeblttrs_npvt_interleaved_batched(handle, nb, nblocks, nrhs, A, inca,
                                                      lda, strideA, B, incb, ldb, strideB,
                                                      C, incc, ldc, strideC, X, incx, ldx,
                                                      strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dgeblttrs_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            nrhs::rocblas_int,
                                                                            A::Ptr{Cdouble},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{Cdouble},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{Cdouble},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            X::Ptr{Cdouble},
                                                                            incx::rocblas_int,
                                                                            ldx::rocblas_int,
                                                                            strideX::rocblas_stride,
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cgeblttrs_npvt_interleaved_batched(handle, nb, nblocks, nrhs, A, inca,
                                                      lda, strideA, B, incb, ldb, strideB,
                                                      C, incc, ldc, strideC, X, incx, ldx,
                                                      strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cgeblttrs_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            nrhs::rocblas_int,
                                                                            A::Ptr{rocblas_float_complex},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{rocblas_float_complex},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{rocblas_float_complex},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            X::Ptr{rocblas_float_complex},
                                                                            incx::rocblas_int,
                                                                            ldx::rocblas_int,
                                                                            strideX::rocblas_stride,
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zgeblttrs_npvt_interleaved_batched(handle, nb, nblocks, nrhs, A, inca,
                                                      lda, strideA, B, incb, ldb, strideB,
                                                      C, incc, ldc, strideC, X, incx, ldx,
                                                      strideX, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zgeblttrs_npvt_interleaved_batched(handle::rocblas_handle,
                                                                            nb::rocblas_int,
                                                                            nblocks::rocblas_int,
                                                                            nrhs::rocblas_int,
                                                                            A::Ptr{rocblas_double_complex},
                                                                            inca::rocblas_int,
                                                                            lda::rocblas_int,
                                                                            strideA::rocblas_stride,
                                                                            B::Ptr{rocblas_double_complex},
                                                                            incb::rocblas_int,
                                                                            ldb::rocblas_int,
                                                                            strideB::rocblas_stride,
                                                                            C::Ptr{rocblas_double_complex},
                                                                            incc::rocblas_int,
                                                                            ldc::rocblas_int,
                                                                            strideC::rocblas_stride,
                                                                            X::Ptr{rocblas_double_complex},
                                                                            incx::rocblas_int,
                                                                            ldx::rocblas_int,
                                                                            strideX::rocblas_stride,
                                                                            batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_create_rfinfo(rfinfo, handle)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_create_rfinfo(rfinfo::Ptr{rocsolver_rfinfo},
                                                       handle::rocblas_handle)::rocblas_status)
end

function rocsolver_destroy_rfinfo(rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_destroy_rfinfo(rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_set_rfinfo_mode(rfinfo, mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_set_rfinfo_mode(rfinfo::rocsolver_rfinfo,
                                                         mode::rocsolver_rfinfo_mode)::rocblas_status)
end

function rocsolver_get_rfinfo_mode(rfinfo, mode)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_get_rfinfo_mode(rfinfo::rocsolver_rfinfo,
                                                         mode::Ptr{rocsolver_rfinfo_mode})::rocblas_status)
end

function rocsolver_scsrrf_sumlu(handle, n, nnzL, ptrL, indL, valL, nnzU, ptrU, indU, valU,
                                ptrT, indT, valT)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_sumlu(handle::rocblas_handle,
                                                      n::rocblas_int, nnzL::rocblas_int,
                                                      ptrL::Ptr{rocblas_int},
                                                      indL::Ptr{rocblas_int},
                                                      valL::Ptr{Cfloat}, nnzU::rocblas_int,
                                                      ptrU::Ptr{rocblas_int},
                                                      indU::Ptr{rocblas_int},
                                                      valU::Ptr{Cfloat},
                                                      ptrT::Ptr{rocblas_int},
                                                      indT::Ptr{rocblas_int},
                                                      valT::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dcsrrf_sumlu(handle, n, nnzL, ptrL, indL, valL, nnzU, ptrU, indU, valU,
                                ptrT, indT, valT)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_sumlu(handle::rocblas_handle,
                                                      n::rocblas_int, nnzL::rocblas_int,
                                                      ptrL::Ptr{rocblas_int},
                                                      indL::Ptr{rocblas_int},
                                                      valL::Ptr{Cdouble}, nnzU::rocblas_int,
                                                      ptrU::Ptr{rocblas_int},
                                                      indU::Ptr{rocblas_int},
                                                      valU::Ptr{Cdouble},
                                                      ptrT::Ptr{rocblas_int},
                                                      indT::Ptr{rocblas_int},
                                                      valT::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_scsrrf_splitlu(handle, n, nnzT, ptrT, indT, valT, ptrL, indL, valL, ptrU,
                                  indU, valU)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_splitlu(handle::rocblas_handle,
                                                        n::rocblas_int, nnzT::rocblas_int,
                                                        ptrT::Ptr{rocblas_int},
                                                        indT::Ptr{rocblas_int},
                                                        valT::Ptr{Cfloat},
                                                        ptrL::Ptr{rocblas_int},
                                                        indL::Ptr{rocblas_int},
                                                        valL::Ptr{Cfloat},
                                                        ptrU::Ptr{rocblas_int},
                                                        indU::Ptr{rocblas_int},
                                                        valU::Ptr{Cfloat})::rocblas_status)
end

function rocsolver_dcsrrf_splitlu(handle, n, nnzT, ptrT, indT, valT, ptrL, indL, valL, ptrU,
                                  indU, valU)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_splitlu(handle::rocblas_handle,
                                                        n::rocblas_int, nnzT::rocblas_int,
                                                        ptrT::Ptr{rocblas_int},
                                                        indT::Ptr{rocblas_int},
                                                        valT::Ptr{Cdouble},
                                                        ptrL::Ptr{rocblas_int},
                                                        indL::Ptr{rocblas_int},
                                                        valL::Ptr{Cdouble},
                                                        ptrU::Ptr{rocblas_int},
                                                        indU::Ptr{rocblas_int},
                                                        valU::Ptr{Cdouble})::rocblas_status)
end

function rocsolver_scsrrf_analysis(handle, n, nrhs, nnzM, ptrM, indM, valM, nnzT, ptrT,
                                   indT, valT, pivP, pivQ, B, ldb, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_analysis(handle::rocblas_handle,
                                                         n::rocblas_int, nrhs::rocblas_int,
                                                         nnzM::rocblas_int,
                                                         ptrM::Ptr{rocblas_int},
                                                         indM::Ptr{rocblas_int},
                                                         valM::Ptr{Cfloat},
                                                         nnzT::rocblas_int,
                                                         ptrT::Ptr{rocblas_int},
                                                         indT::Ptr{rocblas_int},
                                                         valT::Ptr{Cfloat},
                                                         pivP::Ptr{rocblas_int},
                                                         pivQ::Ptr{rocblas_int},
                                                         B::Ptr{Cfloat}, ldb::rocblas_int,
                                                         rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_dcsrrf_analysis(handle, n, nrhs, nnzM, ptrM, indM, valM, nnzT, ptrT,
                                   indT, valT, pivP, pivQ, B, ldb, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_analysis(handle::rocblas_handle,
                                                         n::rocblas_int, nrhs::rocblas_int,
                                                         nnzM::rocblas_int,
                                                         ptrM::Ptr{rocblas_int},
                                                         indM::Ptr{rocblas_int},
                                                         valM::Ptr{Cdouble},
                                                         nnzT::rocblas_int,
                                                         ptrT::Ptr{rocblas_int},
                                                         indT::Ptr{rocblas_int},
                                                         valT::Ptr{Cdouble},
                                                         pivP::Ptr{rocblas_int},
                                                         pivQ::Ptr{rocblas_int},
                                                         B::Ptr{Cdouble}, ldb::rocblas_int,
                                                         rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_scsrrf_refactlu(handle, n, nnzA, ptrA, indA, valA, nnzT, ptrT, indT,
                                   valT, pivP, pivQ, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_refactlu(handle::rocblas_handle,
                                                         n::rocblas_int, nnzA::rocblas_int,
                                                         ptrA::Ptr{rocblas_int},
                                                         indA::Ptr{rocblas_int},
                                                         valA::Ptr{Cfloat},
                                                         nnzT::rocblas_int,
                                                         ptrT::Ptr{rocblas_int},
                                                         indT::Ptr{rocblas_int},
                                                         valT::Ptr{Cfloat},
                                                         pivP::Ptr{rocblas_int},
                                                         pivQ::Ptr{rocblas_int},
                                                         rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_dcsrrf_refactlu(handle, n, nnzA, ptrA, indA, valA, nnzT, ptrT, indT,
                                   valT, pivP, pivQ, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_refactlu(handle::rocblas_handle,
                                                         n::rocblas_int, nnzA::rocblas_int,
                                                         ptrA::Ptr{rocblas_int},
                                                         indA::Ptr{rocblas_int},
                                                         valA::Ptr{Cdouble},
                                                         nnzT::rocblas_int,
                                                         ptrT::Ptr{rocblas_int},
                                                         indT::Ptr{rocblas_int},
                                                         valT::Ptr{Cdouble},
                                                         pivP::Ptr{rocblas_int},
                                                         pivQ::Ptr{rocblas_int},
                                                         rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_scsrrf_refactchol(handle, n, nnzA, ptrA, indA, valA, nnzT, ptrT, indT,
                                     valT, pivQ, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_refactchol(handle::rocblas_handle,
                                                           n::rocblas_int,
                                                           nnzA::rocblas_int,
                                                           ptrA::Ptr{rocblas_int},
                                                           indA::Ptr{rocblas_int},
                                                           valA::Ptr{Cfloat},
                                                           nnzT::rocblas_int,
                                                           ptrT::Ptr{rocblas_int},
                                                           indT::Ptr{rocblas_int},
                                                           valT::Ptr{Cfloat},
                                                           pivQ::Ptr{rocblas_int},
                                                           rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_dcsrrf_refactchol(handle, n, nnzA, ptrA, indA, valA, nnzT, ptrT, indT,
                                     valT, pivQ, rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_refactchol(handle::rocblas_handle,
                                                           n::rocblas_int,
                                                           nnzA::rocblas_int,
                                                           ptrA::Ptr{rocblas_int},
                                                           indA::Ptr{rocblas_int},
                                                           valA::Ptr{Cdouble},
                                                           nnzT::rocblas_int,
                                                           ptrT::Ptr{rocblas_int},
                                                           indT::Ptr{rocblas_int},
                                                           valT::Ptr{Cdouble},
                                                           pivQ::Ptr{rocblas_int},
                                                           rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_scsrrf_solve(handle, n, nrhs, nnzT, ptrT, indT, valT, pivP, pivQ, B, ldb,
                                rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_scsrrf_solve(handle::rocblas_handle,
                                                      n::rocblas_int, nrhs::rocblas_int,
                                                      nnzT::rocblas_int,
                                                      ptrT::Ptr{rocblas_int},
                                                      indT::Ptr{rocblas_int},
                                                      valT::Ptr{Cfloat},
                                                      pivP::Ptr{rocblas_int},
                                                      pivQ::Ptr{rocblas_int},
                                                      B::Ptr{Cfloat}, ldb::rocblas_int,
                                                      rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_dcsrrf_solve(handle, n, nrhs, nnzT, ptrT, indT, valT, pivP, pivQ, B, ldb,
                                rfinfo)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dcsrrf_solve(handle::rocblas_handle,
                                                      n::rocblas_int, nrhs::rocblas_int,
                                                      nnzT::rocblas_int,
                                                      ptrT::Ptr{rocblas_int},
                                                      indT::Ptr{rocblas_int},
                                                      valT::Ptr{Cdouble},
                                                      pivP::Ptr{rocblas_int},
                                                      pivQ::Ptr{rocblas_int},
                                                      B::Ptr{Cdouble}, ldb::rocblas_int,
                                                      rfinfo::rocsolver_rfinfo)::rocblas_status)
end

function rocsolver_ssyevdx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, nev, W,
                           Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdx(handle::rocblas_handle,
                                                 evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cfloat},
                                                 lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                 Z::Ptr{Cfloat}, ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsyevdx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, nev, W,
                           Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdx(handle::rocblas_handle,
                                                 evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cdouble},
                                                 lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                 Z::Ptr{Cdouble}, ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_cheevdx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, nev, W,
                           Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdx(handle::rocblas_handle,
                                                 evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                 Z::Ptr{rocblas_float_complex},
                                                 ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zheevdx(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu, nev, W,
                           Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdx(handle::rocblas_handle,
                                                 evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                 Z::Ptr{rocblas_double_complex},
                                                 ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssyevdx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                   nev, W, strideW, Z, ldz, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdx_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cfloat},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{Cfloat}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevdx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                   nev, W, strideW, Z, ldz, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdx_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cdouble},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{Cdouble}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevdx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                   nev, W, strideW, Z, ldz, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdx_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cfloat},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{rocblas_float_complex}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevdx_batched(handle, evect, erange, uplo, n, A, lda, vl, vu, il, iu,
                                   nev, W, strideW, Z, ldz, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdx_batched(handle::rocblas_handle,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cdouble},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{rocblas_double_complex}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssyevdx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                           vl, vu, il, iu, nev, W, strideW, Z, ldz, strideZ,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssyevdx_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cfloat},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{Cfloat},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsyevdx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                           vl, vu, il, iu, nev, W, strideW, Z, ldz, strideZ,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsyevdx_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cdouble},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{Cdouble},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_cheevdx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                           vl, vu, il, iu, nev, W, strideW, Z, ldz, strideZ,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_cheevdx_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cfloat},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{rocblas_float_complex},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zheevdx_strided_batched(handle, evect, erange, uplo, n, A, lda, strideA,
                                           vl, vu, il, iu, nev, W, strideW, Z, ldz, strideZ,
                                           info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zheevdx_strided_batched(handle::rocblas_handle,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cdouble},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{rocblas_double_complex},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvdx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu,
                           il, iu, nev, W, Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdx(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cfloat},
                                                 lda::rocblas_int, B::Ptr{Cfloat},
                                                 ldb::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                 Z::Ptr{Cfloat}, ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_dsygvdx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu,
                           il, iu, nev, W, Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdx(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int, A::Ptr{Cdouble},
                                                 lda::rocblas_int, B::Ptr{Cdouble},
                                                 ldb::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                 Z::Ptr{Cdouble}, ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_chegvdx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu,
                           il, iu, nev, W, Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdx(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_float_complex},
                                                 lda::rocblas_int,
                                                 B::Ptr{rocblas_float_complex},
                                                 ldb::rocblas_int, vl::Cfloat, vu::Cfloat,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cfloat},
                                                 Z::Ptr{rocblas_float_complex},
                                                 ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_zhegvdx(handle, itype, evect, erange, uplo, n, A, lda, B, ldb, vl, vu,
                           il, iu, nev, W, Z, ldz, info)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdx(handle::rocblas_handle,
                                                 itype::rocblas_eform, evect::rocblas_evect,
                                                 erange::rocblas_erange, uplo::rocblas_fill,
                                                 n::rocblas_int,
                                                 A::Ptr{rocblas_double_complex},
                                                 lda::rocblas_int,
                                                 B::Ptr{rocblas_double_complex},
                                                 ldb::rocblas_int, vl::Cdouble, vu::Cdouble,
                                                 il::rocblas_int, iu::rocblas_int,
                                                 nev::Ptr{rocblas_int}, W::Ptr{Cdouble},
                                                 Z::Ptr{rocblas_double_complex},
                                                 ldz::rocblas_int,
                                                 info::Ptr{rocblas_int})::rocblas_status)
end

function rocsolver_ssygvdx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb,
                                   vl, vu, il, iu, nev, W, strideW, Z, ldz, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdx_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cfloat}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{Cfloat}},
                                                         ldb::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cfloat},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{Cfloat}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvdx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb,
                                   vl, vu, il, iu, nev, W, strideW, Z, ldz, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdx_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{Cdouble}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{Cdouble}},
                                                         ldb::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cdouble},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{Cdouble}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvdx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb,
                                   vl, vu, il, iu, nev, W, strideW, Z, ldz, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdx_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_float_complex}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{rocblas_float_complex}},
                                                         ldb::rocblas_int, vl::Cfloat,
                                                         vu::Cfloat, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cfloat},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{rocblas_float_complex}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvdx_batched(handle, itype, evect, erange, uplo, n, A, lda, B, ldb,
                                   vl, vu, il, iu, nev, W, strideW, Z, ldz, info,
                                   batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdx_batched(handle::rocblas_handle,
                                                         itype::rocblas_eform,
                                                         evect::rocblas_evect,
                                                         erange::rocblas_erange,
                                                         uplo::rocblas_fill, n::rocblas_int,
                                                         A::Ptr{Ptr{rocblas_double_complex}},
                                                         lda::rocblas_int,
                                                         B::Ptr{Ptr{rocblas_double_complex}},
                                                         ldb::rocblas_int, vl::Cdouble,
                                                         vu::Cdouble, il::rocblas_int,
                                                         iu::rocblas_int,
                                                         nev::Ptr{rocblas_int},
                                                         W::Ptr{Cdouble},
                                                         strideW::rocblas_stride,
                                                         Z::Ptr{Ptr{rocblas_double_complex}},
                                                         ldz::rocblas_int,
                                                         info::Ptr{rocblas_int},
                                                         batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_ssygvdx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                           strideA, B, ldb, strideB, vl, vu, il, iu, nev, W,
                                           strideW, Z, ldz, strideZ, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_ssygvdx_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cfloat},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{Cfloat},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cfloat},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{Cfloat},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_dsygvdx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                           strideA, B, ldb, strideB, vl, vu, il, iu, nev, W,
                                           strideW, Z, ldz, strideZ, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_dsygvdx_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{Cdouble},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{Cdouble},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cdouble},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{Cdouble},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_chegvdx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                           strideA, B, ldb, strideB, vl, vu, il, iu, nev, W,
                                           strideW, Z, ldz, strideZ, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_chegvdx_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_float_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{rocblas_float_complex},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 vl::Cfloat, vu::Cfloat,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cfloat},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{rocblas_float_complex},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

function rocsolver_zhegvdx_strided_batched(handle, itype, evect, erange, uplo, n, A, lda,
                                           strideA, B, ldb, strideB, vl, vu, il, iu, nev, W,
                                           strideW, Z, ldz, strideZ, info, batch_count)
    AMDGPU.prepare_state()
    @check @ccall(librocsolver.rocsolver_zhegvdx_strided_batched(handle::rocblas_handle,
                                                                 itype::rocblas_eform,
                                                                 evect::rocblas_evect,
                                                                 erange::rocblas_erange,
                                                                 uplo::rocblas_fill,
                                                                 n::rocblas_int,
                                                                 A::Ptr{rocblas_double_complex},
                                                                 lda::rocblas_int,
                                                                 strideA::rocblas_stride,
                                                                 B::Ptr{rocblas_double_complex},
                                                                 ldb::rocblas_int,
                                                                 strideB::rocblas_stride,
                                                                 vl::Cdouble, vu::Cdouble,
                                                                 il::rocblas_int,
                                                                 iu::rocblas_int,
                                                                 nev::Ptr{rocblas_int},
                                                                 W::Ptr{Cdouble},
                                                                 strideW::rocblas_stride,
                                                                 Z::Ptr{rocblas_double_complex},
                                                                 ldz::rocblas_int,
                                                                 strideZ::rocblas_stride,
                                                                 info::Ptr{rocblas_int},
                                                                 batch_count::rocblas_int)::rocblas_status)
end

# Skipping MacroDefinition: ROCSOLVER_DEPRECATED_X ( x ) __attribute__ ( ( deprecated ( x ) ) )

# Skipping MacroDefinition: ROCSOLVER_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: ROCSOLVER_DEPRECATED __attribute__ ( ( __deprecated__ ) )

const ROCSOLVER_DEPRECATED_EXPORT = ROCSOLVER_EXPORT(ROCSOLVER_DEPRECATED)

const ROCSOLVER_DEPRECATED_NO_EXPORT = ROCSOLVER_NO_EXPORT(ROCSOLVER_DEPRECATED)

const ROCSOLVER_VERSION_MAJOR = 3

const ROCSOLVER_VERSION_MINOR = 32

const ROCSOLVER_VERSION_PATCH = 0

const ROCSOLVER_VERSION_TWEAK = fa20130872
