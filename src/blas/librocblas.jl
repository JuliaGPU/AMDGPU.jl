using CEnum

const rocblas_handle = Ptr{Cvoid}

@cenum rocblas_status_::UInt32 begin
    rocblas_status_success = 0
    rocblas_status_invalid_handle = 1
    rocblas_status_not_implemented = 2
    rocblas_status_invalid_pointer = 3
    rocblas_status_invalid_size = 4
    rocblas_status_memory_error = 5
    rocblas_status_internal_error = 6
    rocblas_status_perf_degraded = 7
    rocblas_status_size_query_mismatch = 8
    rocblas_status_size_increased = 9
    rocblas_status_size_unchanged = 10
    rocblas_status_invalid_value = 11
    rocblas_status_continue = 12
    rocblas_status_check_numerics_fail = 13
end

const rocblas_status = rocblas_status_

function rocblas_set_start_stop_events(handle, startEvent, stopEvent)
    ccall((:rocblas_set_start_stop_events, librocblas), rocblas_status, (rocblas_handle, hipEvent_t, hipEvent_t), handle, startEvent, stopEvent)
end

struct rocblas_bfloat16
    data::UInt16
end

mutable struct rocblas_device_malloc_base end

const rocblas_int = Int32

const rocblas_stride = Int64

const rocblas_float = Cfloat

const rocblas_double = Cdouble

struct rocblas_half
    data::UInt16
end

struct rocblas_int8x4
    a::Int8
    b::Int8
    c::Int8
    d::Int8
end

struct rocblas_float_complex
    x::Cfloat
    y::Cfloat
end

struct rocblas_double_complex
    x::Cdouble
    y::Cdouble
end

@cenum rocblas_operation_::UInt32 begin
    rocblas_operation_none = 111
    rocblas_operation_transpose = 112
    rocblas_operation_conjugate_transpose = 113
end

const rocblas_operation = rocblas_operation_

@cenum rocblas_fill_::UInt32 begin
    rocblas_fill_upper = 121
    rocblas_fill_lower = 122
    rocblas_fill_full = 123
end

const rocblas_fill = rocblas_fill_

@cenum rocblas_diagonal_::UInt32 begin
    rocblas_diagonal_non_unit = 131
    rocblas_diagonal_unit = 132
end

const rocblas_diagonal = rocblas_diagonal_

@cenum rocblas_side_::UInt32 begin
    rocblas_side_left = 141
    rocblas_side_right = 142
    rocblas_side_both = 143
end

const rocblas_side = rocblas_side_

@cenum rocblas_datatype_::UInt32 begin
    rocblas_datatype_f16_r = 150
    rocblas_datatype_f32_r = 151
    rocblas_datatype_f64_r = 152
    rocblas_datatype_f16_c = 153
    rocblas_datatype_f32_c = 154
    rocblas_datatype_f64_c = 155
    rocblas_datatype_i8_r = 160
    rocblas_datatype_u8_r = 161
    rocblas_datatype_i32_r = 162
    rocblas_datatype_u32_r = 163
    rocblas_datatype_i8_c = 164
    rocblas_datatype_u8_c = 165
    rocblas_datatype_i32_c = 166
    rocblas_datatype_u32_c = 167
    rocblas_datatype_bf16_r = 168
    rocblas_datatype_bf16_c = 169
end

const rocblas_datatype = rocblas_datatype_

@cenum rocblas_pointer_mode_::UInt32 begin
    rocblas_pointer_mode_host = 0
    rocblas_pointer_mode_device = 1
end

const rocblas_pointer_mode = rocblas_pointer_mode_

@cenum rocblas_atomics_mode_::UInt32 begin
    rocblas_atomics_not_allowed = 0
    rocblas_atomics_allowed = 1
end

const rocblas_atomics_mode = rocblas_atomics_mode_

@cenum rocblas_performance_metric_::UInt32 begin
    rocblas_default_performance_metric = 0
    rocblas_device_efficiency_performance_metric = 1
    rocblas_cu_efficiency_performance_metric = 2
end

const rocblas_performance_metric = rocblas_performance_metric_

@cenum rocblas_layer_mode_::UInt32 begin
    rocblas_layer_mode_none = 0
    rocblas_layer_mode_log_trace = 1
    rocblas_layer_mode_log_bench = 2
    rocblas_layer_mode_log_profile = 4
end

const rocblas_layer_mode = rocblas_layer_mode_

@cenum rocblas_gemm_algo_::UInt32 begin
    rocblas_gemm_algo_standard = 0
end

const rocblas_gemm_algo = rocblas_gemm_algo_

@cenum rocblas_gemm_flags_::UInt32 begin
    rocblas_gemm_flags_none = 0
    rocblas_gemm_flags_pack_int8x4 = 1
    rocblas_gemm_flags_use_cu_efficiency = 2
    rocblas_gemm_flags_fp16_alt_impl = 4
end

const rocblas_gemm_flags = rocblas_gemm_flags_

struct rocblas_union_u
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{rocblas_union_u}, f::Symbol)
    f === :h && return Ptr{rocblas_half}(x + 0)
    f === :s && return Ptr{Cfloat}(x + 0)
    f === :d && return Ptr{Cdouble}(x + 0)
    f === :i && return Ptr{Int32}(x + 0)
    f === :c && return Ptr{rocblas_float_complex}(x + 0)
    f === :z && return Ptr{rocblas_double_complex}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::rocblas_union_u, f::Symbol)
    r = Ref{rocblas_union_u}(x)
    ptr = Base.unsafe_convert(Ptr{rocblas_union_u}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocblas_union_u}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const rocblas_union_t = rocblas_union_u

@cenum rocblas_check_numerics_mode_::UInt32 begin
    rocblas_check_numerics_mode_no_check = 0
    rocblas_check_numerics_mode_info = 1
    rocblas_check_numerics_mode_warn = 2
    rocblas_check_numerics_mode_fail = 4
end

const rocblas_check_numerics_mode = rocblas_check_numerics_mode_

function rocblas_create_handle(handle)
    ccall((:rocblas_create_handle, librocblas), rocblas_status, (Ptr{rocblas_handle},), handle)
end

function rocblas_destroy_handle(handle)
    ccall((:rocblas_destroy_handle, librocblas), rocblas_status, (rocblas_handle,), handle)
end

function rocblas_set_stream(handle, stream)
    ccall((:rocblas_set_stream, librocblas), rocblas_status, (rocblas_handle, hipStream_t), handle, stream)
end

function rocblas_get_stream(handle, stream)
    ccall((:rocblas_get_stream, librocblas), rocblas_status, (rocblas_handle, Ptr{hipStream_t}), handle, stream)
end

function rocblas_set_pointer_mode(handle, pointer_mode)
    ccall((:rocblas_set_pointer_mode, librocblas), rocblas_status, (rocblas_handle, rocblas_pointer_mode), handle, pointer_mode)
end

function rocblas_get_pointer_mode(handle, pointer_mode)
    ccall((:rocblas_get_pointer_mode, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_pointer_mode}), handle, pointer_mode)
end

function rocblas_set_atomics_mode(handle, atomics_mode)
    ccall((:rocblas_set_atomics_mode, librocblas), rocblas_status, (rocblas_handle, rocblas_atomics_mode), handle, atomics_mode)
end

function rocblas_get_atomics_mode(handle, atomics_mode)
    ccall((:rocblas_get_atomics_mode, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_atomics_mode}), handle, atomics_mode)
end

function rocblas_query_int8_layout_flag(handle, flag)
    ccall((:rocblas_query_int8_layout_flag, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_gemm_flags}), handle, flag)
end

function rocblas_pointer_to_mode(ptr)
    ccall((:rocblas_pointer_to_mode, librocblas), rocblas_pointer_mode, (Ptr{Cvoid},), ptr)
end

function rocblas_set_vector(n, elem_size, x, incx, y, incy)
    ccall((:rocblas_set_vector, librocblas), rocblas_status, (rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int), n, elem_size, x, incx, y, incy)
end

function rocblas_get_vector(n, elem_size, x, incx, y, incy)
    ccall((:rocblas_get_vector, librocblas), rocblas_status, (rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int), n, elem_size, x, incx, y, incy)
end

function rocblas_set_matrix(rows, cols, elem_size, a, lda, b, ldb)
    ccall((:rocblas_set_matrix, librocblas), rocblas_status, (rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int), rows, cols, elem_size, a, lda, b, ldb)
end

function rocblas_get_matrix(rows, cols, elem_size, a, lda, b, ldb)
    ccall((:rocblas_get_matrix, librocblas), rocblas_status, (rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int), rows, cols, elem_size, a, lda, b, ldb)
end

function rocblas_set_vector_async(n, elem_size, x, incx, y, incy, stream)
    ccall((:rocblas_set_vector_async, librocblas), rocblas_status, (rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int, hipStream_t), n, elem_size, x, incx, y, incy, stream)
end

function rocblas_get_vector_async(n, elem_size, x, incx, y, incy, stream)
    ccall((:rocblas_get_vector_async, librocblas), rocblas_status, (rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int, hipStream_t), n, elem_size, x, incx, y, incy, stream)
end

function rocblas_set_matrix_async(rows, cols, elem_size, a, lda, b, ldb, stream)
    ccall((:rocblas_set_matrix_async, librocblas), rocblas_status, (rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int, hipStream_t), rows, cols, elem_size, a, lda, b, ldb, stream)
end

function rocblas_get_matrix_async(rows, cols, elem_size, a, lda, b, ldb, stream)
    ccall((:rocblas_get_matrix_async, librocblas), rocblas_status, (rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int, hipStream_t), rows, cols, elem_size, a, lda, b, ldb, stream)
end

function rocblas_set_solution_fitness_query(handle, fitness)
    ccall((:rocblas_set_solution_fitness_query, librocblas), rocblas_status, (rocblas_handle, Ptr{Cdouble}), handle, fitness)
end

function rocblas_set_performance_metric(handle, metric)
    ccall((:rocblas_set_performance_metric, librocblas), rocblas_status, (rocblas_handle, rocblas_performance_metric), handle, metric)
end

function rocblas_get_performance_metric(handle, metric)
    ccall((:rocblas_get_performance_metric, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_performance_metric}), handle, metric)
end

function rocblas_sscal(handle, n, alpha, x, incx)
    ccall((:rocblas_sscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_dscal(handle, n, alpha, x, incx)
    ccall((:rocblas_dscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_cscal(handle, n, alpha, x, incx)
    ccall((:rocblas_cscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_zscal(handle, n, alpha, x, incx)
    ccall((:rocblas_zscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_csscal(handle, n, alpha, x, incx)
    ccall((:rocblas_csscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_zdscal(handle, n, alpha, x, incx)
    ccall((:rocblas_zdscal, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, n, alpha, x, incx)
end

function rocblas_sscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_sscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_dscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_dscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_cscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_cscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_zscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_zscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_csscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_csscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_zdscal_batched(handle, n, alpha, x, incx, batch_count)
    ccall((:rocblas_zdscal_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, batch_count)
end

function rocblas_sscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_sscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_dscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_dscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_cscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_cscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_zscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_zscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_csscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_csscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_zdscal_strided_batched(handle, n, alpha, x, incx, stride_x, batch_count)
    ccall((:rocblas_zdscal_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stride_x, batch_count)
end

function rocblas_scopy(handle, n, x, incx, y, incy)
    ccall((:rocblas_scopy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_dcopy(handle, n, x, incx, y, incy)
    ccall((:rocblas_dcopy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_ccopy(handle, n, x, incx, y, incy)
    ccall((:rocblas_ccopy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_zcopy(handle, n, x, incx, y, incy)
    ccall((:rocblas_zcopy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_scopy_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_scopy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_dcopy_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_dcopy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_ccopy_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_ccopy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_zcopy_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_zcopy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_scopy_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_scopy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_dcopy_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_dcopy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_ccopy_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_ccopy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_zcopy_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_zcopy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_sdot(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_sdot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, y, incy, result)
end

function rocblas_ddot(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_ddot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, y, incy, result)
end

function rocblas_hdot(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_hdot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}), handle, n, x, incx, y, incy, result)
end

function rocblas_bfdot(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_bfdot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_bfloat16}, rocblas_int, Ptr{rocblas_bfloat16}, rocblas_int, Ptr{rocblas_bfloat16}), handle, n, x, incx, y, incy, result)
end

function rocblas_cdotu(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_cdotu, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, y, incy, result)
end

function rocblas_zdotu(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_zdotu, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, y, incy, result)
end

function rocblas_cdotc(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_cdotc, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, y, incy, result)
end

function rocblas_zdotc(handle, n, x, incx, y, incy, result)
    ccall((:rocblas_zdotc, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, y, incy, result)
end

function rocblas_sdot_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_sdot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_ddot_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_ddot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_hdot_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_hdot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{Ptr{rocblas_half}}, rocblas_int, rocblas_int, Ptr{rocblas_half}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_bfdot_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_bfdot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_bfloat16}}, rocblas_int, Ptr{Ptr{rocblas_bfloat16}}, rocblas_int, rocblas_int, Ptr{rocblas_bfloat16}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_cdotu_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_cdotu_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_zdotu_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_zdotu_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_cdotc_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_cdotc_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_zdotc_batched(handle, n, x, incx, y, incy, batch_count, result)
    ccall((:rocblas_zdotc_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, y, incy, batch_count, result)
end

function rocblas_sdot_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_sdot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_ddot_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_ddot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_hdot_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_hdot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_half}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_bfdot_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_bfdot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_bfloat16}, rocblas_int, rocblas_stride, Ptr{rocblas_bfloat16}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_bfloat16}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_cdotu_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_cdotu_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_zdotu_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_zdotu_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_cdotc_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_cdotc_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_float_complex}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_zdotc_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
    ccall((:rocblas_zdotc_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_double_complex}), handle, n, x, incx, stridex, y, incy, stridey, batch_count, result)
end

function rocblas_sswap(handle, n, x, incx, y, incy)
    ccall((:rocblas_sswap, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_dswap(handle, n, x, incx, y, incy)
    ccall((:rocblas_dswap, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_cswap(handle, n, x, incx, y, incy)
    ccall((:rocblas_cswap, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_zswap(handle, n, x, incx, y, incy)
    ccall((:rocblas_zswap, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, n, x, incx, y, incy)
end

function rocblas_sswap_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_sswap_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_dswap_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_dswap_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_cswap_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_cswap_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_zswap_batched(handle, n, x, incx, y, incy, batch_count)
    ccall((:rocblas_zswap_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, n, x, incx, y, incy, batch_count)
end

function rocblas_sswap_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_sswap_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_dswap_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_dswap_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_cswap_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_cswap_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_zswap_strided_batched(handle, n, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_zswap_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_saxpy(handle, n, alpha, x, incx, y, incy)
    ccall((:rocblas_saxpy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, n, alpha, x, incx, y, incy)
end

function rocblas_daxpy(handle, n, alpha, x, incx, y, incy)
    ccall((:rocblas_daxpy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, n, alpha, x, incx, y, incy)
end

function rocblas_haxpy(handle, n, alpha, x, incx, y, incy)
    ccall((:rocblas_haxpy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, rocblas_int), handle, n, alpha, x, incx, y, incy)
end

function rocblas_caxpy(handle, n, alpha, x, incx, y, incy)
    ccall((:rocblas_caxpy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, n, alpha, x, incx, y, incy)
end

function rocblas_zaxpy(handle, n, alpha, x, incx, y, incy)
    ccall((:rocblas_zaxpy, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, n, alpha, x, incx, y, incy)
end

function rocblas_haxpy_batched(handle, n, alpha, x, incx, y, incy, batch_count)
    ccall((:rocblas_haxpy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_half}, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{Ptr{rocblas_half}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, y, incy, batch_count)
end

function rocblas_saxpy_batched(handle, n, alpha, x, incx, y, incy, batch_count)
    ccall((:rocblas_saxpy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, y, incy, batch_count)
end

function rocblas_daxpy_batched(handle, n, alpha, x, incx, y, incy, batch_count)
    ccall((:rocblas_daxpy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, y, incy, batch_count)
end

function rocblas_caxpy_batched(handle, n, alpha, x, incx, y, incy, batch_count)
    ccall((:rocblas_caxpy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, y, incy, batch_count)
end

function rocblas_zaxpy_batched(handle, n, alpha, x, incx, y, incy, batch_count)
    ccall((:rocblas_zaxpy_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, n, alpha, x, incx, y, incy, batch_count)
end

function rocblas_haxpy_strided_batched(handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_haxpy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_saxpy_strided_batched(handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_saxpy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_daxpy_strided_batched(handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_daxpy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_caxpy_strided_batched(handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_caxpy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_zaxpy_strided_batched(handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
    ccall((:rocblas_zaxpy_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, n, alpha, x, incx, stridex, y, incy, stridey, batch_count)
end

function rocblas_sasum(handle, n, x, incx, result)
    ccall((:rocblas_sasum, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, result)
end

function rocblas_dasum(handle, n, x, incx, result)
    ccall((:rocblas_dasum, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, result)
end

function rocblas_scasum(handle, n, x, incx, result)
    ccall((:rocblas_scasum, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, result)
end

function rocblas_dzasum(handle, n, x, incx, result)
    ccall((:rocblas_dzasum, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, result)
end

function rocblas_sasum_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_sasum_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, batch_count, results)
end

function rocblas_dasum_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_dasum_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, batch_count, results)
end

function rocblas_scasum_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_scasum_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, batch_count, results)
end

function rocblas_dzasum_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_dzasum_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, batch_count, results)
end

function rocblas_sasum_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_sasum_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_dasum_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_dasum_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_scasum_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_scasum_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_dzasum_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_dzasum_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_snrm2(handle, n, x, incx, result)
    ccall((:rocblas_snrm2, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, result)
end

function rocblas_dnrm2(handle, n, x, incx, result)
    ccall((:rocblas_dnrm2, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, result)
end

function rocblas_scnrm2(handle, n, x, incx, result)
    ccall((:rocblas_scnrm2, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, result)
end

function rocblas_dznrm2(handle, n, x, incx, result)
    ccall((:rocblas_dznrm2, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, result)
end

function rocblas_snrm2_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_snrm2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, batch_count, results)
end

function rocblas_dnrm2_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_dnrm2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, batch_count, results)
end

function rocblas_scnrm2_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_scnrm2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, batch_count, results)
end

function rocblas_dznrm2_batched(handle, n, x, incx, batch_count, results)
    ccall((:rocblas_dznrm2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, batch_count, results)
end

function rocblas_snrm2_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_snrm2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_dnrm2_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_dnrm2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_scnrm2_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_scnrm2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_dznrm2_strided_batched(handle, n, x, incx, stridex, batch_count, results)
    ccall((:rocblas_dznrm2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, stridex, batch_count, results)
end

function rocblas_isamax(handle, n, x, incx, result)
    ccall((:rocblas_isamax, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_idamax(handle, n, x, incx, result)
    ccall((:rocblas_idamax, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_icamax(handle, n, x, incx, result)
    ccall((:rocblas_icamax, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_izamax(handle, n, x, incx, result)
    ccall((:rocblas_izamax, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_isamax_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_isamax_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_idamax_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_idamax_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_icamax_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_icamax_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_izamax_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_izamax_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_isamax_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_isamax_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_idamax_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_idamax_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_icamax_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_icamax_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_izamax_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_izamax_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_isamin(handle, n, x, incx, result)
    ccall((:rocblas_isamin, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_idamin(handle, n, x, incx, result)
    ccall((:rocblas_idamin, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_icamin(handle, n, x, incx, result)
    ccall((:rocblas_icamin, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_izamin(handle, n, x, incx, result)
    ccall((:rocblas_izamin, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, result)
end

function rocblas_isamin_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_isamin_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_idamin_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_idamin_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_icamin_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_icamin_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_izamin_batched(handle, n, x, incx, batch_count, result)
    ccall((:rocblas_izamin_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, batch_count, result)
end

function rocblas_isamin_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_isamin_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_idamin_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_idamin_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_icamin_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_icamin_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_izamin_strided_batched(handle, n, x, incx, stridex, batch_count, result)
    ccall((:rocblas_izamin_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int, Ptr{rocblas_int}), handle, n, x, incx, stridex, batch_count, result)
end

function rocblas_srot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_srot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_drot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_drot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_crot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_crot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_csrot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_csrot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_zrot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_zrot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_zdrot(handle, n, x, incx, y, incy, c, s)
    ccall((:rocblas_zdrot, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}), handle, n, x, incx, y, incy, c, s)
end

function rocblas_srot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_srot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_drot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_drot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_crot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_crot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_csrot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_csrot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_zrot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_zrot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_zdrot_batched(handle, n, x, incx, y, incy, c, s, batch_count)
    ccall((:rocblas_zdrot_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, y, incy, c, s, batch_count)
end

function rocblas_srot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_srot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_drot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_drot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_crot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_crot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_csrot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_csrot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_zrot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_zrot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_zdrot_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
    ccall((:rocblas_zdrot_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, c, s, batch_count)
end

function rocblas_srotg(handle, a, b, c, s)
    ccall((:rocblas_srotg, librocblas), rocblas_status, (rocblas_handle, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, a, b, c, s)
end

function rocblas_drotg(handle, a, b, c, s)
    ccall((:rocblas_drotg, librocblas), rocblas_status, (rocblas_handle, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, a, b, c, s)
end

function rocblas_crotg(handle, a, b, c, s)
    ccall((:rocblas_crotg, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, Ptr{Cfloat}, Ptr{rocblas_float_complex}), handle, a, b, c, s)
end

function rocblas_zrotg(handle, a, b, c, s)
    ccall((:rocblas_zrotg, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, Ptr{Cdouble}, Ptr{rocblas_double_complex}), handle, a, b, c, s)
end

function rocblas_srotg_batched(handle, a, b, c, s, batch_count)
    ccall((:rocblas_srotg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, rocblas_int), handle, a, b, c, s, batch_count)
end

function rocblas_drotg_batched(handle, a, b, c, s, batch_count)
    ccall((:rocblas_drotg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, rocblas_int), handle, a, b, c, s, batch_count)
end

function rocblas_crotg_batched(handle, a, b, c, s, batch_count)
    ccall((:rocblas_crotg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{rocblas_float_complex}}, Ptr{Ptr{rocblas_float_complex}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int), handle, a, b, c, s, batch_count)
end

function rocblas_zrotg_batched(handle, a, b, c, s, batch_count)
    ccall((:rocblas_zrotg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{rocblas_double_complex}}, Ptr{Ptr{rocblas_double_complex}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int), handle, a, b, c, s, batch_count)
end

function rocblas_srotg_strided_batched(handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
    ccall((:rocblas_srotg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, rocblas_int), handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
end

function rocblas_drotg_strided_batched(handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
    ccall((:rocblas_drotg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, rocblas_int), handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
end

function rocblas_crotg_strided_batched(handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
    ccall((:rocblas_crotg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_float_complex}, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_stride, rocblas_int), handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
end

function rocblas_zrotg_strided_batched(handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
    ccall((:rocblas_zrotg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{rocblas_double_complex}, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_stride, rocblas_int), handle, a, stride_a, b, stride_b, c, stride_c, s, stride_s, batch_count)
end

function rocblas_srotm(handle, n, x, incx, y, incy, param)
    ccall((:rocblas_srotm, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, n, x, incx, y, incy, param)
end

function rocblas_drotm(handle, n, x, incx, y, incy, param)
    ccall((:rocblas_drotm, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, n, x, incx, y, incy, param)
end

function rocblas_srotm_batched(handle, n, x, incx, y, incy, param, batch_count)
    ccall((:rocblas_srotm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int), handle, n, x, incx, y, incy, param, batch_count)
end

function rocblas_drotm_batched(handle, n, x, incx, y, incy, param, batch_count)
    ccall((:rocblas_drotm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int), handle, n, x, incx, y, incy, param, batch_count)
end

function rocblas_srotm_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, param, stride_param, batch_count)
    ccall((:rocblas_srotm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_stride, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, param, stride_param, batch_count)
end

function rocblas_drotm_strided_batched(handle, n, x, incx, stride_x, y, incy, stride_y, param, stride_param, batch_count)
    ccall((:rocblas_drotm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_stride, rocblas_int), handle, n, x, incx, stride_x, y, incy, stride_y, param, stride_param, batch_count)
end

function rocblas_srotmg(handle, d1, d2, x1, y1, param)
    ccall((:rocblas_srotmg, librocblas), rocblas_status, (rocblas_handle, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), handle, d1, d2, x1, y1, param)
end

function rocblas_drotmg(handle, d1, d2, x1, y1, param)
    ccall((:rocblas_drotmg, librocblas), rocblas_status, (rocblas_handle, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), handle, d1, d2, x1, y1, param)
end

function rocblas_srotmg_batched(handle, d1, d2, x1, y1, param, batch_count)
    ccall((:rocblas_srotmg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, rocblas_int), handle, d1, d2, x1, y1, param, batch_count)
end

function rocblas_drotmg_batched(handle, d1, d2, x1, y1, param, batch_count)
    ccall((:rocblas_drotmg_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, rocblas_int), handle, d1, d2, x1, y1, param, batch_count)
end

function rocblas_srotmg_strided_batched(handle, d1, stride_d1, d2, stride_d2, x1, stride_x1, y1, stride_y1, param, stride_param, batch_count)
    ccall((:rocblas_srotmg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_stride, rocblas_int), handle, d1, stride_d1, d2, stride_d2, x1, stride_x1, y1, stride_y1, param, stride_param, batch_count)
end

function rocblas_drotmg_strided_batched(handle, d1, stride_d1, d2, stride_d2, x1, stride_x1, y1, stride_y1, param, stride_param, batch_count)
    ccall((:rocblas_drotmg_strided_batched, librocblas), rocblas_status, (rocblas_handle, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_stride, rocblas_int), handle, d1, stride_d1, d2, stride_d2, x1, stride_x1, y1, stride_y1, param, stride_param, batch_count)
end

function rocblas_sgbmv(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_sgbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_dgbmv(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_dgbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_cgbmv(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_cgbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_zgbmv(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_zgbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_sgbmv_batched(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_sgbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_dgbmv_batched(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_dgbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_cgbmv_batched(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_cgbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_zgbmv_batched(handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zgbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_sgbmv_strided_batched(handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_sgbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_dgbmv_strided_batched(handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_dgbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_cgbmv_strided_batched(handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_cgbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_zgbmv_strided_batched(handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_zgbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, trans, m, n, kl, ku, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_sgemv(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_sgemv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_dgemv(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_dgemv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_cgemv(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_cgemv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_zgemv(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_zgemv, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_sgemv_batched(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_sgemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_dgemv_batched(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_dgemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_cgemv_batched(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_cgemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_zgemv_batched(handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zgemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, trans, m, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_sgemv_strided_batched(handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_sgemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_dgemv_strided_batched(handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_dgemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_cgemv_strided_batched(handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_cgemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_zgemv_strided_batched(handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_zgemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, m, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_chbmv(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_chbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_zhbmv(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_zhbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_chbmv_batched(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_chbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_zhbmv_batched(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zhbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_chbmv_strided_batched(handle, uplo, n, k, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_chbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, k, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_zhbmv_strided_batched(handle, uplo, n, k, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_zhbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, k, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_chemv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_chemv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_zhemv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_zhemv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_chemv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_chemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_zhemv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zhemv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_chemv_strided_batched(handle, uplo, n, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_chemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_zhemv_strided_batched(handle, uplo, n, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_zhemv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_cher(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_cher, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_zher(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_zher, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_cher_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_cher_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_zher_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_zher_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_cher_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, A, lda, stride_A, batch_count)
    ccall((:rocblas_cher_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, A, lda, stride_A, batch_count)
end

function rocblas_zher_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, A, lda, stride_A, batch_count)
    ccall((:rocblas_zher_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, A, lda, stride_A, batch_count)
end

function rocblas_cher2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_cher2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_zher2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_zher2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_cher2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_cher2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_zher2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_zher2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_cher2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, A, lda, stride_A, batch_count)
    ccall((:rocblas_cher2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, A, lda, stride_A, batch_count)
end

function rocblas_zher2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, A, lda, stride_A, batch_count)
    ccall((:rocblas_zher2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, A, lda, stride_A, batch_count)
end

function rocblas_chpmv(handle, uplo, n, alpha, AP, x, incx, beta, y, incy)
    ccall((:rocblas_chpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, AP, x, incx, beta, y, incy)
end

function rocblas_zhpmv(handle, uplo, n, alpha, AP, x, incx, beta, y, incy)
    ccall((:rocblas_zhpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, AP, x, incx, beta, y, incy)
end

function rocblas_chpmv_batched(handle, uplo, n, alpha, AP, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_chpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, AP, x, incx, beta, y, incy, batch_count)
end

function rocblas_zhpmv_batched(handle, uplo, n, alpha, AP, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zhpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, AP, x, incx, beta, y, incy, batch_count)
end

function rocblas_chpmv_strided_batched(handle, uplo, n, alpha, AP, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_chpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, AP, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_zhpmv_strided_batched(handle, uplo, n, alpha, AP, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
    ccall((:rocblas_zhpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, AP, stride_A, x, incx, stride_x, beta, y, incy, stride_y, batch_count)
end

function rocblas_chpr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_chpr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_zhpr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_zhpr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_chpr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_chpr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_zhpr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_zhpr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_chpr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_chpr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_zhpr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_zhpr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_chpr2(handle, uplo, n, alpha, x, incx, y, incy, AP)
    ccall((:rocblas_chpr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}), handle, uplo, n, alpha, x, incx, y, incy, AP)
end

function rocblas_zhpr2(handle, uplo, n, alpha, x, incx, y, incy, AP)
    ccall((:rocblas_zhpr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}), handle, uplo, n, alpha, x, incx, y, incy, AP)
end

function rocblas_chpr2_batched(handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
    ccall((:rocblas_chpr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
end

function rocblas_zhpr2_batched(handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
    ccall((:rocblas_zhpr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
end

function rocblas_chpr2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
    ccall((:rocblas_chpr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
end

function rocblas_zhpr2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
    ccall((:rocblas_zhpr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
end

function rocblas_strmv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_strmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_dtrmv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_dtrmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_ctrmv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_ctrmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_ztrmv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_ztrmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_strmv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_strmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_dtrmv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_dtrmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_ctrmv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_ctrmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_ztrmv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_ztrmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_strmv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_strmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtrmv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtrmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctrmv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctrmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztrmv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztrmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_stpmv(handle, uplo, transA, diag, m, A, x, incx)
    ccall((:rocblas_stpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, diag, m, A, x, incx)
end

function rocblas_dtpmv(handle, uplo, transA, diag, m, A, x, incx)
    ccall((:rocblas_dtpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, diag, m, A, x, incx)
end

function rocblas_ctpmv(handle, uplo, transA, diag, m, A, x, incx)
    ccall((:rocblas_ctpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, diag, m, A, x, incx)
end

function rocblas_ztpmv(handle, uplo, transA, diag, m, A, x, incx)
    ccall((:rocblas_ztpmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, diag, m, A, x, incx)
end

function rocblas_stpmv_batched(handle, uplo, transA, diag, m, A, x, incx, batch_count)
    ccall((:rocblas_stpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, x, incx, batch_count)
end

function rocblas_dtpmv_batched(handle, uplo, transA, diag, m, A, x, incx, batch_count)
    ccall((:rocblas_dtpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, x, incx, batch_count)
end

function rocblas_ctpmv_batched(handle, uplo, transA, diag, m, A, x, incx, batch_count)
    ccall((:rocblas_ctpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, x, incx, batch_count)
end

function rocblas_ztpmv_batched(handle, uplo, transA, diag, m, A, x, incx, batch_count)
    ccall((:rocblas_ztpmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, x, incx, batch_count)
end

function rocblas_stpmv_strided_batched(handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_stpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtpmv_strided_batched(handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctpmv_strided_batched(handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztpmv_strided_batched(handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztpmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_stbmv(handle, uplo, trans, diag, m, k, A, lda, x, incx)
    ccall((:rocblas_stbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx)
end

function rocblas_dtbmv(handle, uplo, trans, diag, m, k, A, lda, x, incx)
    ccall((:rocblas_dtbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx)
end

function rocblas_ctbmv(handle, uplo, trans, diag, m, k, A, lda, x, incx)
    ccall((:rocblas_ctbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx)
end

function rocblas_ztbmv(handle, uplo, trans, diag, m, k, A, lda, x, incx)
    ccall((:rocblas_ztbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx)
end

function rocblas_stbmv_batched(handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_stbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
end

function rocblas_dtbmv_batched(handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_dtbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
end

function rocblas_ctbmv_batched(handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_ctbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
end

function rocblas_ztbmv_batched(handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_ztbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, x, incx, batch_count)
end

function rocblas_stbmv_strided_batched(handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_stbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtbmv_strided_batched(handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctbmv_strided_batched(handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztbmv_strided_batched(handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, diag, m, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_stbsv(handle, uplo, transA, diag, n, k, A, lda, x, incx)
    ccall((:rocblas_stbsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx)
end

function rocblas_dtbsv(handle, uplo, transA, diag, n, k, A, lda, x, incx)
    ccall((:rocblas_dtbsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx)
end

function rocblas_ctbsv(handle, uplo, transA, diag, n, k, A, lda, x, incx)
    ccall((:rocblas_ctbsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx)
end

function rocblas_ztbsv(handle, uplo, transA, diag, n, k, A, lda, x, incx)
    ccall((:rocblas_ztbsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx)
end

function rocblas_stbsv_batched(handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_stbsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
end

function rocblas_dtbsv_batched(handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_dtbsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
end

function rocblas_ctbsv_batched(handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_ctbsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
end

function rocblas_ztbsv_batched(handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
    ccall((:rocblas_ztbsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, x, incx, batch_count)
end

function rocblas_stbsv_strided_batched(handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_stbsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtbsv_strided_batched(handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtbsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctbsv_strided_batched(handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctbsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztbsv_strided_batched(handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztbsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, k, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_strsv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_strsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_dtrsv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_dtrsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_ctrsv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_ctrsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_ztrsv(handle, uplo, transA, diag, m, A, lda, x, incx)
    ccall((:rocblas_ztrsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx)
end

function rocblas_strsv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_strsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_dtrsv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_dtrsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_ctrsv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_ctrsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_ztrsv_batched(handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
    ccall((:rocblas_ztrsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, m, A, lda, x, incx, batch_count)
end

function rocblas_strsv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_strsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtrsv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtrsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctrsv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctrsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztrsv_strided_batched(handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztrsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, m, A, lda, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_stpsv(handle, uplo, transA, diag, n, AP, x, incx)
    ccall((:rocblas_stpsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx)
end

function rocblas_dtpsv(handle, uplo, transA, diag, n, AP, x, incx)
    ccall((:rocblas_dtpsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx)
end

function rocblas_ctpsv(handle, uplo, transA, diag, n, AP, x, incx)
    ccall((:rocblas_ctpsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx)
end

function rocblas_ztpsv(handle, uplo, transA, diag, n, AP, x, incx)
    ccall((:rocblas_ztpsv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx)
end

function rocblas_stpsv_batched(handle, uplo, transA, diag, n, AP, x, incx, batch_count)
    ccall((:rocblas_stpsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx, batch_count)
end

function rocblas_dtpsv_batched(handle, uplo, transA, diag, n, AP, x, incx, batch_count)
    ccall((:rocblas_dtpsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx, batch_count)
end

function rocblas_ctpsv_batched(handle, uplo, transA, diag, n, AP, x, incx, batch_count)
    ccall((:rocblas_ctpsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx, batch_count)
end

function rocblas_ztpsv_batched(handle, uplo, transA, diag, n, AP, x, incx, batch_count)
    ccall((:rocblas_ztpsv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, diag, n, AP, x, incx, batch_count)
end

function rocblas_stpsv_strided_batched(handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_stpsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_dtpsv_strided_batched(handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_dtpsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ctpsv_strided_batched(handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ctpsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ztpsv_strided_batched(handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
    ccall((:rocblas_ztpsv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, diag, n, AP, stride_A, x, incx, stride_x, batch_count)
end

function rocblas_ssymv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_ssymv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_dsymv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_dsymv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_csymv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_csymv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_zsymv(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_zsymv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_ssymv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_ssymv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_dsymv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_dsymv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_csymv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_csymv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_zsymv_batched(handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_zsymv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_ssymv_strided_batched(handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_ssymv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_dsymv_strided_batched(handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_dsymv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_csymv_strided_batched(handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_csymv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_zsymv_strided_batched(handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_zsymv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_sspmv(handle, uplo, n, alpha, A, x, incx, beta, y, incy)
    ccall((:rocblas_sspmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, n, alpha, A, x, incx, beta, y, incy)
end

function rocblas_dspmv(handle, uplo, n, alpha, A, x, incx, beta, y, incy)
    ccall((:rocblas_dspmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, n, alpha, A, x, incx, beta, y, incy)
end

function rocblas_sspmv_batched(handle, uplo, n, alpha, A, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_sspmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, x, incx, beta, y, incy, batch_count)
end

function rocblas_dspmv_batched(handle, uplo, n, alpha, A, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_dspmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, A, x, incx, beta, y, incy, batch_count)
end

function rocblas_sspmv_strided_batched(handle, uplo, n, alpha, A, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_sspmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_dspmv_strided_batched(handle, uplo, n, alpha, A, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_dspmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, A, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_ssbmv(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_ssbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_dsbmv(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
    ccall((:rocblas_dsbmv, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy)
end

function rocblas_dsbmv_batched(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_dsbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_ssbmv_batched(handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
    ccall((:rocblas_ssbmv_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, n, k, alpha, A, lda, x, incx, beta, y, incy, batch_count)
end

function rocblas_ssbmv_strided_batched(handle, uplo, n, k, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_ssbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, k, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_dsbmv_strided_batched(handle, uplo, n, k, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
    ccall((:rocblas_dsbmv_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, k, alpha, A, lda, strideA, x, incx, stridex, beta, y, incy, stridey, batch_count)
end

function rocblas_sger(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_sger, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_dger(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_dger, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_cgeru(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_cgeru, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_zgeru(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_zgeru, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_cgerc(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_cgerc, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_zgerc(handle, m, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_zgerc, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_sger_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_sger_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_dger_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_dger_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_cgeru_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_cgeru_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_zgeru_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_zgeru_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_cgerc_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_cgerc_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_zgerc_batched(handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_zgerc_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, m, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_sger_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_sger_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_dger_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_dger_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_cgeru_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_cgeru_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_zgeru_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_zgeru_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_cgerc_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_cgerc_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_zgerc_strided_batched(handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_zgerc_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, m, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_sspr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_sspr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_dspr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_dspr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_cspr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_cspr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_zspr(handle, uplo, n, alpha, x, incx, AP)
    ccall((:rocblas_zspr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}), handle, uplo, n, alpha, x, incx, AP)
end

function rocblas_sspr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_sspr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_dspr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_dspr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_cspr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_cspr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_zspr_batched(handle, uplo, n, alpha, x, incx, AP, batch_count)
    ccall((:rocblas_zspr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int), handle, uplo, n, alpha, x, incx, AP, batch_count)
end

function rocblas_sspr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_sspr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_dspr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_dspr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_cspr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_cspr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_zspr_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
    ccall((:rocblas_zspr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, AP, stride_A, batch_count)
end

function rocblas_sspr2(handle, uplo, n, alpha, x, incx, y, incy, AP)
    ccall((:rocblas_sspr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}), handle, uplo, n, alpha, x, incx, y, incy, AP)
end

function rocblas_dspr2(handle, uplo, n, alpha, x, incx, y, incy, AP)
    ccall((:rocblas_dspr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}), handle, uplo, n, alpha, x, incx, y, incy, AP)
end

function rocblas_sspr2_batched(handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
    ccall((:rocblas_sspr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
end

function rocblas_dspr2_batched(handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
    ccall((:rocblas_dspr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, AP, batch_count)
end

function rocblas_sspr2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
    ccall((:rocblas_sspr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
end

function rocblas_dspr2_strided_batched(handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
    ccall((:rocblas_dspr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stride_x, y, incy, stride_y, AP, stride_A, batch_count)
end

function rocblas_ssyr(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_ssyr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_dsyr(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_dsyr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_csyr(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_csyr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_zsyr(handle, uplo, n, alpha, x, incx, A, lda)
    ccall((:rocblas_zsyr, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda)
end

function rocblas_ssyr_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_ssyr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_dsyr_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_dsyr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_csyr_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_csyr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_zsyr_batched(handle, uplo, n, alpha, x, incx, A, lda, batch_count)
    ccall((:rocblas_zsyr_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, A, lda, batch_count)
end

function rocblas_ssyr_strided_batched(handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
    ccall((:rocblas_ssyr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
end

function rocblas_dsyr_strided_batched(handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
    ccall((:rocblas_dsyr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
end

function rocblas_csyr_strided_batched(handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
    ccall((:rocblas_csyr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
end

function rocblas_zsyr_strided_batched(handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
    ccall((:rocblas_zsyr_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, A, lda, strideA, batch_count)
end

function rocblas_ssyr2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_ssyr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_dsyr2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_dsyr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_csyr2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_csyr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_zsyr2(handle, uplo, n, alpha, x, incx, y, incy, A, lda)
    ccall((:rocblas_zsyr2, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda)
end

function rocblas_ssyr2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_ssyr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_dsyr2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_dsyr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_csyr2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_csyr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_zsyr2_batched(handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
    ccall((:rocblas_zsyr2_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, n, alpha, x, incx, y, incy, A, lda, batch_count)
end

function rocblas_ssyr2_strided_batched(handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_ssyr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_dsyr2_strided_batched(handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_dsyr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_csyr2_strided_batched(handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_csyr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_zsyr2_strided_batched(handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
    ccall((:rocblas_zsyr2_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, n, alpha, x, incx, stridex, y, incy, stridey, A, lda, strideA, batch_count)
end

function rocblas_chemm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_chemm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zhemm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zhemm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_chemm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_chemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zhemm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zhemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_chemm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_chemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zhemm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zhemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_cherk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_cherk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_zherk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_zherk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_cherk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_cherk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_zherk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_zherk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_cherk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_cherk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zherk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zherk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_cher2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_cher2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zher2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zher2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_cher2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_cher2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zher2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zher2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_cher2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_cher2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zher2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zher2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_cherkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_cherkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zherkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zherkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_cherkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_cherkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zherkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zherkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_cherkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_cherkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zherkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zherkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_ssymm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_ssymm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_dsymm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_dsymm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_csymm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_csymm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zsymm(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zsymm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_ssymm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_ssymm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_dsymm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_dsymm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_csymm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_csymm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zsymm_batched(handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zsymm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_ssymm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ssymm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_dsymm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dsymm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_csymm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_csymm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zsymm_strided_batched(handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zsymm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_ssyrk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_ssyrk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_dsyrk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_dsyrk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_csyrk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_csyrk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_zsyrk(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
    ccall((:rocblas_zsyrk, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc)
end

function rocblas_ssyrk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_ssyrk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_dsyrk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_dsyrk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_csyrk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_csyrk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_zsyrk_batched(handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
    ccall((:rocblas_zsyrk_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, beta, C, ldc, batch_count)
end

function rocblas_ssyrk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ssyrk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_dsyrk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dsyrk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_csyrk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_csyrk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zsyrk_strided_batched(handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zsyrk_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, transA, n, k, alpha, A, lda, stride_A, beta, C, ldc, stride_C, batch_count)
end

function rocblas_ssyr2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_ssyr2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_dsyr2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_dsyr2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_csyr2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_csyr2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zsyr2k(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zsyr2k, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_ssyr2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_ssyr2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_dsyr2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_dsyr2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_csyr2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_csyr2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zsyr2k_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zsyr2k_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_ssyr2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ssyr2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_dsyr2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dsyr2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_csyr2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_csyr2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zsyr2k_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zsyr2k_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_ssyrkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_ssyrkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_dsyrkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_dsyrkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_csyrkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_csyrkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zsyrkx(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zsyrkx, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_ssyrkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_ssyrkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_dsyrkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_dsyrkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_csyrkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_csyrkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zsyrkx_batched(handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zsyrkx_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_ssyrkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ssyrkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_dsyrkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dsyrkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_csyrkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_csyrkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_zsyrkx_strided_batched(handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zsyrkx_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, trans, n, k, alpha, A, lda, stride_A, B, ldb, stride_B, beta, C, ldc, stride_C, batch_count)
end

function rocblas_strmm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_strmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_dtrmm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_dtrmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_ctrmm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_ctrmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_ztrmm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_ztrmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_strmm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_strmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_dtrmm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_dtrmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_ctrmm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_ctrmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_ztrmm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_ztrmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_strmm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
    ccall((:rocblas_strmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
end

function rocblas_dtrmm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
    ccall((:rocblas_dtrmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
end

function rocblas_ctrmm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
    ccall((:rocblas_ctrmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
end

function rocblas_ztrmm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
    ccall((:rocblas_ztrmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count)
end

function rocblas_strmm_outofplace(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
    ccall((:rocblas_strmm_outofplace, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
end

function rocblas_dtrmm_outofplace(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
    ccall((:rocblas_dtrmm_outofplace, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
end

function rocblas_ctrmm_outofplace(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
    ccall((:rocblas_ctrmm_outofplace, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
end

function rocblas_ztrmm_outofplace(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
    ccall((:rocblas_ztrmm_outofplace, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc)
end

function rocblas_strmm_outofplace_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_strmm_outofplace_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
end

function rocblas_dtrmm_outofplace_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_dtrmm_outofplace_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
end

function rocblas_ctrmm_outofplace_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_ctrmm_outofplace_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
end

function rocblas_ztrmm_outofplace_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_ztrmm_outofplace_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, C, ldc, batch_count)
end

function rocblas_strmm_outofplace_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_strmm_outofplace_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_dtrmm_outofplace_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dtrmm_outofplace_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_ctrmm_outofplace_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ctrmm_outofplace_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_ztrmm_outofplace_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ztrmm_outofplace_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_strtri(handle, uplo, diag, n, A, lda, invA, ldinvA)
    ccall((:rocblas_strtri, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA)
end

function rocblas_dtrtri(handle, uplo, diag, n, A, lda, invA, ldinvA)
    ccall((:rocblas_dtrtri, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA)
end

function rocblas_ctrtri(handle, uplo, diag, n, A, lda, invA, ldinvA)
    ccall((:rocblas_ctrtri, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA)
end

function rocblas_ztrtri(handle, uplo, diag, n, A, lda, invA, ldinvA)
    ccall((:rocblas_ztrtri, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA)
end

function rocblas_strtri_batched(handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
    ccall((:rocblas_strtri_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
end

function rocblas_dtrtri_batched(handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
    ccall((:rocblas_dtrtri_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
end

function rocblas_ctrtri_batched(handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
    ccall((:rocblas_ctrtri_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
end

function rocblas_ztrtri_batched(handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
    ccall((:rocblas_ztrtri_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, uplo, diag, n, A, lda, invA, ldinvA, batch_count)
end

function rocblas_strtri_strided_batched(handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
    ccall((:rocblas_strtri_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
end

function rocblas_dtrtri_strided_batched(handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
    ccall((:rocblas_dtrtri_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
end

function rocblas_ctrtri_strided_batched(handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
    ccall((:rocblas_ctrtri_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
end

function rocblas_ztrtri_strided_batched(handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
    ccall((:rocblas_ztrtri_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_fill, rocblas_diagonal, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, uplo, diag, n, A, lda, stride_a, invA, ldinvA, stride_invA, batch_count)
end

function rocblas_strsm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_strsm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_dtrsm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_dtrsm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_ctrsm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_ctrsm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_ztrsm(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
    ccall((:rocblas_ztrsm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb)
end

function rocblas_strsm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_strsm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_dtrsm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_dtrsm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_ctrsm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_ctrsm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_ztrsm_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
    ccall((:rocblas_ztrsm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count)
end

function rocblas_strsm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
    ccall((:rocblas_strsm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
end

function rocblas_dtrsm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
    ccall((:rocblas_dtrsm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
end

function rocblas_ctrsm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
    ccall((:rocblas_ctrsm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
end

function rocblas_ztrsm_strided_batched(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
    ccall((:rocblas_ztrsm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_a, B, ldb, stride_b, batch_count)
end

function rocblas_sgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_sgemm, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_dgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_dgemm, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_hgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_hgemm, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_cgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_cgemm, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_zgemm(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
    ccall((:rocblas_zgemm, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc)
end

function rocblas_sgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_sgemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_dgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_dgemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_hgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_hgemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{Ptr{rocblas_half}}, rocblas_int, Ptr{rocblas_half}, Ptr{Ptr{rocblas_half}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_cgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_cgemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_zgemm_batched(handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
    ccall((:rocblas_zgemm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, B, ldb, beta, C, ldc, batch_count)
end

function rocblas_sgemm_strided_batched(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_sgemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_dgemm_strided_batched(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_dgemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_hgemm_strided_batched(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_hgemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_hgemm_kernel_name(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_hgemm_kernel_name, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, rocblas_int, rocblas_stride, Ptr{rocblas_half}, Ptr{rocblas_half}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_sgemm_kernel_name(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_sgemm_kernel_name, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_dgemm_kernel_name(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_dgemm_kernel_name, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_cgemm_strided_batched(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_cgemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_zgemm_strided_batched(handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
    ccall((:rocblas_zgemm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, k, alpha, A, lda, stride_a, B, ldb, stride_b, beta, C, ldc, stride_c, batch_count)
end

function rocblas_sdgmm(handle, side, m, n, A, lda, x, incx, C, ldc)
    ccall((:rocblas_sdgmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc)
end

function rocblas_ddgmm(handle, side, m, n, A, lda, x, incx, C, ldc)
    ccall((:rocblas_ddgmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc)
end

function rocblas_cdgmm(handle, side, m, n, A, lda, x, incx, C, ldc)
    ccall((:rocblas_cdgmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc)
end

function rocblas_zdgmm(handle, side, m, n, A, lda, x, incx, C, ldc)
    ccall((:rocblas_zdgmm, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc)
end

function rocblas_sdgmm_batched(handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
    ccall((:rocblas_sdgmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
end

function rocblas_ddgmm_batched(handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
    ccall((:rocblas_ddgmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
end

function rocblas_cdgmm_batched(handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
    ccall((:rocblas_cdgmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
end

function rocblas_zdgmm_batched(handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
    ccall((:rocblas_zdgmm_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, side, m, n, A, lda, x, incx, C, ldc, batch_count)
end

function rocblas_sdgmm_strided_batched(handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
    ccall((:rocblas_sdgmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
end

function rocblas_ddgmm_strided_batched(handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
    ccall((:rocblas_ddgmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
end

function rocblas_cdgmm_strided_batched(handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
    ccall((:rocblas_cdgmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
end

function rocblas_zdgmm_strided_batched(handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zdgmm_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, side, m, n, A, lda, stride_A, x, incx, stride_x, C, ldc, stride_C, batch_count)
end

function rocblas_sgeam(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
    ccall((:rocblas_sgeam, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, Ptr{Cfloat}, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
end

function rocblas_dgeam(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
    ccall((:rocblas_dgeam, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, Ptr{Cdouble}, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
end

function rocblas_cgeam(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
    ccall((:rocblas_cgeam, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, Ptr{rocblas_float_complex}, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
end

function rocblas_zgeam(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
    ccall((:rocblas_zgeam, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, Ptr{rocblas_double_complex}, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc)
end

function rocblas_sgeam_batched(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_sgeam_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Cfloat}, Ptr{Ptr{Cfloat}}, rocblas_int, Ptr{Ptr{Cfloat}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
end

function rocblas_dgeam_batched(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_dgeam_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Cdouble}, Ptr{Ptr{Cdouble}}, rocblas_int, Ptr{Ptr{Cdouble}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
end

function rocblas_cgeam_batched(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_cgeam_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{rocblas_float_complex}, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, Ptr{Ptr{rocblas_float_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
end

function rocblas_zgeam_batched(handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
    ccall((:rocblas_zgeam_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{rocblas_double_complex}, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, Ptr{Ptr{rocblas_double_complex}}, rocblas_int, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, beta, B, ldb, C, ldc, batch_count)
end

function rocblas_sgeam_strided_batched(handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_sgeam_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, Ptr{Cfloat}, rocblas_int, rocblas_stride, Ptr{Cfloat}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_dgeam_strided_batched(handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_dgeam_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, Ptr{Cdouble}, rocblas_int, rocblas_stride, Ptr{Cdouble}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_cgeam_strided_batched(handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_cgeam_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_float_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_zgeam_strided_batched(handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
    ccall((:rocblas_zgeam_strided_batched, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, Ptr{rocblas_double_complex}, rocblas_int, rocblas_stride, rocblas_int), handle, transA, transB, m, n, alpha, A, lda, stride_A, beta, B, ldb, stride_B, C, ldc, stride_C, batch_count)
end

function rocblas_gemm_batched_ex(handle, transA, transB, m, n, k, alpha, a, a_type, lda, b, b_type, ldb, beta, c, c_type, ldc, d, d_type, ldd, batch_count, compute_type, algo, solution_index, flags)
    ccall((:rocblas_gemm_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_operation, rocblas_operation, rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, rocblas_datatype, rocblas_gemm_algo, Int32, UInt32), handle, transA, transB, m, n, k, alpha, a, a_type, lda, b, b_type, ldb, beta, c, c_type, ldc, d, d_type, ldd, batch_count, compute_type, algo, solution_index, flags)
end

function rocblas_gemm_ext2(handle, m, n, k, alpha, a, a_type, row_stride_a, col_stride_a, b, b_type, row_stride_b, col_stride_b, beta, c, c_type, row_stride_c, col_stride_c, d, d_type, row_stride_d, col_stride_d, compute_type, algo, solution_index, flags)
    ccall((:rocblas_gemm_ext2, librocblas), rocblas_status, (rocblas_handle, rocblas_int, rocblas_int, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_stride, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_stride, rocblas_stride, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_stride, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_stride, rocblas_stride, rocblas_datatype, rocblas_gemm_algo, Int32, UInt32), handle, m, n, k, alpha, a, a_type, row_stride_a, col_stride_a, b, b_type, row_stride_b, col_stride_b, beta, c, c_type, row_stride_c, col_stride_c, d, d_type, row_stride_d, col_stride_d, compute_type, algo, solution_index, flags)
end

function rocblas_trsm_batched_ex(handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count, invA, invA_size, compute_type)
    ccall((:rocblas_trsm_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_int, Ptr{Cvoid}, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_int, rocblas_datatype), handle, side, uplo, transA, diag, m, n, alpha, A, lda, B, ldb, batch_count, invA, invA_size, compute_type)
end

function rocblas_trsm_strided_batched_ex(handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count, invA, invA_size, stride_invA, compute_type)
    ccall((:rocblas_trsm_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_side, rocblas_fill, rocblas_operation, rocblas_diagonal, rocblas_int, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_int, rocblas_stride, Ptr{Cvoid}, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cvoid}, rocblas_int, rocblas_stride, rocblas_datatype), handle, side, uplo, transA, diag, m, n, alpha, A, lda, stride_A, B, ldb, stride_B, batch_count, invA, invA_size, stride_invA, compute_type)
end

function rocblas_axpy_ex(handle, n, alpha, alpha_type, x, x_type, incx, y, y_type, incy, execution_type)
    ccall((:rocblas_axpy_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, y, y_type, incy, execution_type)
end

function rocblas_axpy_batched_ex(handle, n, alpha, alpha_type, x, x_type, incx, y, y_type, incy, batch_count, execution_type)
    ccall((:rocblas_axpy_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, y, y_type, incy, batch_count, execution_type)
end

function rocblas_axpy_strided_batched_ex(handle, n, alpha, alpha_type, x, x_type, incx, stridex, y, y_type, incy, stridey, batch_count, execution_type)
    ccall((:rocblas_axpy_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, stridex, y, y_type, incy, stridey, batch_count, execution_type)
end

function rocblas_dot_ex(handle, n, x, x_type, incx, y, y_type, incy, result, result_type, execution_type)
    ccall((:rocblas_dot_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, result, result_type, execution_type)
end

function rocblas_dotc_ex(handle, n, x, x_type, incx, y, y_type, incy, result, result_type, execution_type)
    ccall((:rocblas_dotc_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, result, result_type, execution_type)
end

function rocblas_dot_batched_ex(handle, n, x, x_type, incx, y, y_type, incy, batch_count, result, result_type, execution_type)
    ccall((:rocblas_dot_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, batch_count, result, result_type, execution_type)
end

function rocblas_dotc_batched_ex(handle, n, x, x_type, incx, y, y_type, incy, batch_count, result, result_type, execution_type)
    ccall((:rocblas_dotc_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, batch_count, result, result_type, execution_type)
end

function rocblas_dot_strided_batched_ex(handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, batch_count, result, result_type, execution_type)
    ccall((:rocblas_dot_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, batch_count, result, result_type, execution_type)
end

function rocblas_dotc_strided_batched_ex(handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, batch_count, result, result_type, execution_type)
    ccall((:rocblas_dotc_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, batch_count, result, result_type, execution_type)
end

function rocblas_nrm2_ex(handle, n, x, x_type, incx, results, result_type, execution_type)
    ccall((:rocblas_nrm2_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, results, result_type, execution_type)
end

function rocblas_nrm2_batched_ex(handle, n, x, x_type, incx, batch_count, results, result_type, execution_type)
    ccall((:rocblas_nrm2_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, batch_count, results, result_type, execution_type)
end

function rocblas_nrm2_strided_batched_ex(handle, n, x, x_type, incx, stride_x, batch_count, results, result_type, execution_type)
    ccall((:rocblas_nrm2_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, stride_x, batch_count, results, result_type, execution_type)
end

function rocblas_rot_ex(handle, n, x, x_type, incx, y, y_type, incy, c, s, cs_type, execution_type)
    ccall((:rocblas_rot_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, c, s, cs_type, execution_type)
end

function rocblas_rot_batched_ex(handle, n, x, x_type, incx, y, y_type, incy, c, s, cs_type, batch_count, execution_type)
    ccall((:rocblas_rot_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_datatype), handle, n, x, x_type, incx, y, y_type, incy, c, s, cs_type, batch_count, execution_type)
end

function rocblas_rot_strided_batched_ex(handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, c, s, cs_type, batch_count, execution_type)
    ccall((:rocblas_rot_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, Ptr{Cvoid}, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_datatype), handle, n, x, x_type, incx, stride_x, y, y_type, incy, stride_y, c, s, cs_type, batch_count, execution_type)
end

function rocblas_scal_ex(handle, n, alpha, alpha_type, x, x_type, incx, execution_type)
    ccall((:rocblas_scal_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, execution_type)
end

function rocblas_scal_batched_ex(handle, n, alpha, alpha_type, x, x_type, incx, batch_count, execution_type)
    ccall((:rocblas_scal_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, batch_count, execution_type)
end

function rocblas_scal_strided_batched_ex(handle, n, alpha, alpha_type, x, x_type, incx, stridex, batch_count, execution_type)
    ccall((:rocblas_scal_strided_batched_ex, librocblas), rocblas_status, (rocblas_handle, rocblas_int, Ptr{Cvoid}, rocblas_datatype, Ptr{Cvoid}, rocblas_datatype, rocblas_int, rocblas_stride, rocblas_int, rocblas_datatype), handle, n, alpha, alpha_type, x, x_type, incx, stridex, batch_count, execution_type)
end

function rocblas_status_to_string(status)
    ccall((:rocblas_status_to_string, librocblas), Ptr{Cchar}, (rocblas_status,), status)
end

function rocblas_initialize()
    ccall((:rocblas_initialize, librocblas), Cvoid, ())
end

function rocblas_get_version_string(buf, len)
    ccall((:rocblas_get_version_string, librocblas), rocblas_status, (Ptr{Cchar}, Csize_t), buf, len)
end

function rocblas_get_version_string_size(len)
    ccall((:rocblas_get_version_string_size, librocblas), rocblas_status, (Ptr{Csize_t},), len)
end

function rocblas_start_device_memory_size_query(handle)
    ccall((:rocblas_start_device_memory_size_query, librocblas), rocblas_status, (rocblas_handle,), handle)
end

function rocblas_stop_device_memory_size_query(handle, size)
    ccall((:rocblas_stop_device_memory_size_query, librocblas), rocblas_status, (rocblas_handle, Ptr{Csize_t}), handle, size)
end

function rocblas_is_device_memory_size_query(handle)
    ccall((:rocblas_is_device_memory_size_query, librocblas), Bool, (rocblas_handle,), handle)
end

function rocblas_device_malloc_success(ptr)
    ccall((:rocblas_device_malloc_success, librocblas), Bool, (Ptr{rocblas_device_malloc_base},), ptr)
end

function rocblas_device_malloc_ptr(ptr, res)
    ccall((:rocblas_device_malloc_ptr, librocblas), rocblas_status, (Ptr{rocblas_device_malloc_base}, Ptr{Ptr{Cvoid}}), ptr, res)
end

function rocblas_device_malloc_get(ptr, index, res)
    ccall((:rocblas_device_malloc_get, librocblas), rocblas_status, (Ptr{rocblas_device_malloc_base}, Csize_t, Ptr{Ptr{Cvoid}}), ptr, index, res)
end

function rocblas_device_malloc_free(ptr)
    ccall((:rocblas_device_malloc_free, librocblas), rocblas_status, (Ptr{rocblas_device_malloc_base},), ptr)
end

function rocblas_device_malloc_set_default_memory_size(size)
    ccall((:rocblas_device_malloc_set_default_memory_size, librocblas), Cvoid, (Csize_t,), size)
end

function rocblas_get_device_memory_size(handle, size)
    ccall((:rocblas_get_device_memory_size, librocblas), rocblas_status, (rocblas_handle, Ptr{Csize_t}), handle, size)
end

function rocblas_set_device_memory_size(handle, size)
    ccall((:rocblas_set_device_memory_size, librocblas), rocblas_status, (rocblas_handle, Csize_t), handle, size)
end

function rocblas_set_workspace(handle, addr, size)
    ccall((:rocblas_set_workspace, librocblas), rocblas_status, (rocblas_handle, Ptr{Cvoid}, Csize_t), handle, addr, size)
end

function rocblas_is_managing_device_memory(handle)
    ccall((:rocblas_is_managing_device_memory, librocblas), Bool, (rocblas_handle,), handle)
end

function rocblas_is_user_managing_device_memory(handle)
    ccall((:rocblas_is_user_managing_device_memory, librocblas), Bool, (rocblas_handle,), handle)
end

function rocblas_abort()
    ccall((:rocblas_abort, librocblas), Cvoid, ())
end
