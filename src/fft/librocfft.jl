mutable struct rocfft_plan_t end

const rocfft_plan = Ptr{rocfft_plan_t}

mutable struct rocfft_plan_description_t end

const rocfft_plan_description = Ptr{rocfft_plan_description_t}

mutable struct rocfft_execution_info_t end

const rocfft_execution_info = Ptr{rocfft_execution_info_t}

mutable struct rocfft_field_t end

const rocfft_field = Ptr{rocfft_field_t}

mutable struct rocfft_brick_t end

const rocfft_brick = Ptr{rocfft_brick_t}

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
    rocfft_precision_half = 2
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

@cenum rocfft_comm_type_e::UInt32 begin
    rocfft_comm_none = 0
    rocfft_comm_mpi = 1
end

const rocfft_comm_type = rocfft_comm_type_e

function rocfft_setup()
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_setup()::rocfft_status
end

function rocfft_cleanup()
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_cleanup()::rocfft_status
end

function rocfft_plan_create(plan, placement, transform_type, precision, dimensions, lengths,
                            number_of_transforms, description)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_create(plan::Ptr{rocfft_plan},
                                               placement::rocfft_result_placement,
                                               transform_type::rocfft_transform_type,
                                               precision::rocfft_precision,
                                               dimensions::Csize_t,
                                               lengths::Ptr{Csize_t},
                                               number_of_transforms::Csize_t,
                                               description::rocfft_plan_description)::rocfft_status
end

function rocfft_execute(plan, in_buffer, out_buffer, info)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execute(plan::rocfft_plan, in_buffer::Ptr{Ptr{Cvoid}},
                                           out_buffer::Ptr{Ptr{Cvoid}},
                                           info::rocfft_execution_info)::rocfft_status
end

function rocfft_plan_destroy(plan)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_destroy(plan::rocfft_plan)::rocfft_status
end

function rocfft_plan_description_set_scale_factor(description, scale_factor)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_set_scale_factor(description::rocfft_plan_description,
                                                                     scale_factor::Cdouble)::rocfft_status
end

function rocfft_plan_description_set_data_layout(description, in_array_type, out_array_type,
                                                 in_offsets, out_offsets, in_strides_size,
                                                 in_strides, in_distance, out_strides_size,
                                                 out_strides, out_distance)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_set_data_layout(description::rocfft_plan_description,
                                                                    in_array_type::rocfft_array_type,
                                                                    out_array_type::rocfft_array_type,
                                                                    in_offsets::Ptr{Csize_t},
                                                                    out_offsets::Ptr{Csize_t},
                                                                    in_strides_size::Csize_t,
                                                                    in_strides::Ptr{Csize_t},
                                                                    in_distance::Csize_t,
                                                                    out_strides_size::Csize_t,
                                                                    out_strides::Ptr{Csize_t},
                                                                    out_distance::Csize_t)::rocfft_status
end

function rocfft_field_create(field)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_field_create(field::Ptr{rocfft_field})::rocfft_status
end

function rocfft_field_destroy(field)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_field_destroy(field::rocfft_field)::rocfft_status
end

function rocfft_get_version_string(buf, len)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_get_version_string(buf::Ptr{Cchar},
                                                      len::Csize_t)::rocfft_status
end

function rocfft_plan_description_set_comm(description, comm_type, comm_handle)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_set_comm(description::rocfft_plan_description,
                                                             comm_type::rocfft_comm_type,
                                                             comm_handle::Ptr{Cvoid})::rocfft_status
end

function rocfft_brick_create(brick, field_lower, field_upper, brick_stride, dim, deviceID)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_brick_create(brick::Ptr{rocfft_brick},
                                                field_lower::Ptr{Csize_t},
                                                field_upper::Ptr{Csize_t},
                                                brick_stride::Ptr{Csize_t}, dim::Csize_t,
                                                deviceID::Cint)::rocfft_status
end

function rocfft_brick_destroy(brick)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_brick_destroy(brick::rocfft_brick)::rocfft_status
end

function rocfft_field_add_brick(field, brick)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_field_add_brick(field::rocfft_field,
                                                   brick::rocfft_brick)::rocfft_status
end

function rocfft_plan_description_add_infield(description, field)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_add_infield(description::rocfft_plan_description,
                                                                field::rocfft_field)::rocfft_status
end

function rocfft_plan_description_add_outfield(description, field)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_add_outfield(description::rocfft_plan_description,
                                                                 field::rocfft_field)::rocfft_status
end

function rocfft_plan_get_work_buffer_size(plan, size_in_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_get_work_buffer_size(plan::rocfft_plan,
                                                             size_in_bytes::Ptr{Csize_t})::rocfft_status
end

function rocfft_plan_get_print(plan)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_get_print(plan::rocfft_plan)::rocfft_status
end

function rocfft_plan_description_create(description)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_create(description::Ptr{rocfft_plan_description})::rocfft_status
end

function rocfft_plan_description_destroy(description)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_plan_description_destroy(description::rocfft_plan_description)::rocfft_status
end

function rocfft_execution_info_create(info)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_create(info::Ptr{rocfft_execution_info})::rocfft_status
end

function rocfft_execution_info_destroy(info)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_destroy(info::rocfft_execution_info)::rocfft_status
end

function rocfft_execution_info_set_work_buffer(info, work_buffer, size_in_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_set_work_buffer(info::rocfft_execution_info,
                                                                  work_buffer::Ptr{Cvoid},
                                                                  size_in_bytes::Csize_t)::rocfft_status
end

function rocfft_execution_info_set_stream(info, stream)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_set_stream(info::rocfft_execution_info,
                                                             stream::Ptr{Cvoid})::rocfft_status
end

function rocfft_execution_info_set_load_callback(info, cb_functions, cb_data,
                                                 shared_mem_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_set_load_callback(info::rocfft_execution_info,
                                                                    cb_functions::Ptr{Ptr{Cvoid}},
                                                                    cb_data::Ptr{Ptr{Cvoid}},
                                                                    shared_mem_bytes::Csize_t)::rocfft_status
end

function rocfft_execution_info_set_store_callback(info, cb_functions, cb_data,
                                                  shared_mem_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_execution_info_set_store_callback(info::rocfft_execution_info,
                                                                     cb_functions::Ptr{Ptr{Cvoid}},
                                                                     cb_data::Ptr{Ptr{Cvoid}},
                                                                     shared_mem_bytes::Csize_t)::rocfft_status
end

function rocfft_cache_serialize(buffer, buffer_len_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_cache_serialize(buffer::Ptr{Ptr{Cvoid}},
                                                   buffer_len_bytes::Ptr{Csize_t})::rocfft_status
end

function rocfft_cache_buffer_free(buffer)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_cache_buffer_free(buffer::Ptr{Cvoid})::rocfft_status
end

function rocfft_cache_deserialize(buffer, buffer_len_bytes)
    AMDGPU.prepare_state()
    @check @ccall librocfft.rocfft_cache_deserialize(buffer::Ptr{Cvoid},
                                                     buffer_len_bytes::Csize_t)::rocfft_status
end
