using CEnum

mutable struct rocfft_plan_t end

const rocfft_plan = Ptr{rocfft_plan_t}

mutable struct rocfft_plan_description_t end

const rocfft_plan_description = Ptr{rocfft_plan_description_t}

mutable struct rocfft_execution_info_t end

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
    rocfft_status_invalid_work_buffer = 8
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

# no prototype is found for this function at rocfft.h:124:29, please use with caution
function rocfft_setup()
    AMDGPU.prepare_state()
    ccall((:rocfft_setup, librocfft), rocfft_status, ()) |> check
end

# no prototype is found for this function at rocfft.h:128:29, please use with caution
function rocfft_cleanup()
    AMDGPU.prepare_state()
    ccall((:rocfft_cleanup, librocfft), rocfft_status, ()) |> check
end

function rocfft_plan_create(plan, placement, transform_type, precision, dimensions, lengths, number_of_transforms, description)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_create, librocfft), rocfft_status, (Ptr{rocfft_plan}, rocfft_result_placement, rocfft_transform_type, rocfft_precision, Cint, Ptr{Cint}, Cint, rocfft_plan_description), plan, placement, transform_type, precision, dimensions, lengths, number_of_transforms, description) |> check
end

function rocfft_execute(plan, in_buffer, out_buffer, info)
    AMDGPU.prepare_state()
    ccall((:rocfft_execute, librocfft), rocfft_status, (rocfft_plan, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, rocfft_execution_info), plan, in_buffer, out_buffer, info) |> check
end

function rocfft_plan_destroy(plan)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_destroy, librocfft), rocfft_status, (rocfft_plan,), plan) |> check
end

function rocfft_plan_description_set_scale_factor(description, scale_factor)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_description_set_scale_factor, librocfft), rocfft_status, (rocfft_plan_description, Cdouble), description, scale_factor) |> check
end

function rocfft_plan_description_set_data_layout(description, in_array_type, out_array_type, in_offsets, out_offsets, in_strides_size, in_strides, in_distance, out_strides_size, out_strides, out_distance)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_description_set_data_layout, librocfft), rocfft_status, (rocfft_plan_description, rocfft_array_type, rocfft_array_type, Ptr{Cint}, Ptr{Cint}, Cint, Ptr{Cint}, Cint, Cint, Ptr{Cint}, Cint), description, in_array_type, out_array_type, in_offsets, out_offsets, in_strides_size, in_strides, in_distance, out_strides_size, out_strides, out_distance) |> check
end

function rocfft_get_version_string(buf, len)
    AMDGPU.prepare_state()
    ccall((:rocfft_get_version_string, librocfft), rocfft_status, (Ptr{Cchar}, Cint), buf, len) |> check
end

function rocfft_plan_get_work_buffer_size(plan, size_in_bytes)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_get_work_buffer_size, librocfft), rocfft_status, (rocfft_plan, Ptr{Cint}), plan, size_in_bytes) |> check
end

function rocfft_plan_get_print(plan)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_get_print, librocfft), rocfft_status, (rocfft_plan,), plan) |> check
end

function rocfft_plan_description_create(description)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_description_create, librocfft), rocfft_status, (Ptr{rocfft_plan_description},), description) |> check
end

function rocfft_plan_description_destroy(description)
    AMDGPU.prepare_state()
    ccall((:rocfft_plan_description_destroy, librocfft), rocfft_status, (rocfft_plan_description,), description) |> check
end

function rocfft_execution_info_create(info)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_create, librocfft), rocfft_status, (Ptr{rocfft_execution_info},), info) |> check
end

function rocfft_execution_info_destroy(info)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_destroy, librocfft), rocfft_status, (rocfft_execution_info,), info) |> check
end

function rocfft_execution_info_set_work_buffer(info, work_buffer, size_in_bytes)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_set_work_buffer, librocfft), rocfft_status, (rocfft_execution_info, Ptr{Cvoid}, Cint), info, work_buffer, size_in_bytes) |> check
end

function rocfft_execution_info_set_stream(info, stream)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_set_stream, librocfft), rocfft_status, (rocfft_execution_info, hipStream_t), info, stream) |> check
end

function rocfft_execution_info_set_load_callback(info, cb_functions, cb_data, shared_mem_bytes)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_set_load_callback, librocfft), rocfft_status, (rocfft_execution_info, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Cint), info, cb_functions, cb_data, shared_mem_bytes) |> check
end

function rocfft_execution_info_set_store_callback(info, cb_functions, cb_data, shared_mem_bytes)
    AMDGPU.prepare_state()
    ccall((:rocfft_execution_info_set_store_callback, librocfft), rocfft_status, (rocfft_execution_info, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, Cint), info, cb_functions, cb_data, shared_mem_bytes) |> check
end

const rocfft_version_major = 1

const rocfft_version_minor = 0

const rocfft_version_patch = 21
