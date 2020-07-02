# Automatically generated using Clang.jl


const rocfft_version_major = 0
const rocfft_version_minor = 9
const rocfft_version_patch = 7
const rocfft_plan_t = Cvoid
const rocfft_plan = Ptr{rocfft_plan_t}
const rocfft_plan_description_t = Cvoid
const rocfft_plan_description = Ptr{rocfft_plan_description_t}
const rocfft_execution_info_t = Cvoid
const rocfft_execution_info = Ptr{rocfft_execution_info_t}

@cenum rocfft_status_e::UInt32 begin
    rocfft_status_success = 0
    rocfft_status_failure = 1
    rocfft_status_invalid_arg_value = 2
    rocfft_status_invalid_dimensions = 3
    rocfft_status_invalid_array_type = 4
    rocfft_status_invalid_strides = 5
    rocfft_status_invalid_distance = 6
    rocfft_status_invalid_offset = 7
end


const rocfft_status = rocfft_status_e

@cenum rocfft_transform_type_e::UInt32 begin
    rocfft_transform_type_complex_forward = 0
    rocfft_transform_type_complex_inverse = 1
    rocfft_transform_type_real_forward = 2
    rocfft_transform_type_real_inverse = 3
end


const rocfft_transform_type = rocfft_transform_type_e

@cenum rocfft_precision_e::UInt32 begin
    rocfft_precision_single = 0
    rocfft_precision_double = 1
end


const rocfft_precision = rocfft_precision_e

@cenum rocfft_result_placement_e::UInt32 begin
    rocfft_placement_inplace = 0
    rocfft_placement_notinplace = 1
end


const rocfft_result_placement = rocfft_result_placement_e

@cenum rocfft_array_type_e::UInt32 begin
    rocfft_array_type_complex_interleaved = 0
    rocfft_array_type_complex_planar = 1
    rocfft_array_type_real = 2
    rocfft_array_type_hermitian_interleaved = 3
    rocfft_array_type_hermitian_planar = 4
    rocfft_array_type_unset = 5
end


const rocfft_array_type = rocfft_array_type_e

@cenum rocfft_execution_mode_e::UInt32 begin
    rocfft_exec_mode_nonblocking = 0
    rocfft_exec_mode_nonblocking_with_flush = 1
    rocfft_exec_mode_blocking = 2
end


const rocfft_execution_mode = rocfft_execution_mode_e

@cenum rocfft_layer_mode_::UInt32 begin
    rocfft_layer_mode_none = 0
    rocfft_layer_mode_log_trace = 1
    rocfft_layer_mode_log_bench = 2
    rocfft_layer_mode_log_profile = 4
end


const rocfft_layer_mode = rocfft_layer_mode_
