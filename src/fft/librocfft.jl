# Julia wrapper for header: rocfft-version.h
# Automatically generated using Clang.jl

# Julia wrapper for header: rocfft.h
# Automatically generated using Clang.jl


function rocfft_setup()
    @check ccall((:rocfft_setup, librocfft), rocfft_status, ())
end

function rocfft_cleanup()
    @check ccall((:rocfft_cleanup, librocfft), rocfft_status, ())
end

function rocfft_plan_create(plan, placement, transform_type, precision, dimensions,
                            lengths, number_of_transforms, description)
    @check ccall((:rocfft_plan_create, librocfft), rocfft_status,
                 (Ptr{rocfft_plan}, rocfft_result_placement, rocfft_transform_type,
                  rocfft_precision, Csize_t, Ptr{Csize_t}, Csize_t, rocfft_plan_description),
                 plan, placement, transform_type, precision, dimensions, lengths,
                 number_of_transforms, description)
end

function rocfft_execute(plan, in_buffer, out_buffer, info)
    @check ccall((:rocfft_execute, librocfft), rocfft_status,
                 (rocfft_plan, Ptr{Ptr{Cvoid}}, Ptr{Ptr{Cvoid}}, rocfft_execution_info),
                 plan, in_buffer, out_buffer, info)
end

function rocfft_plan_destroy(plan)
    @check ccall((:rocfft_plan_destroy, librocfft), rocfft_status,
                 (rocfft_plan,),
                 plan)
end

function rocfft_plan_description_set_data_layout(description, in_array_type,
                                                 out_array_type, in_offsets, out_offsets,
                                                 in_strides_size, in_strides, in_distance,
                                                 out_strides_size, out_strides, out_distance)
    @check ccall((:rocfft_plan_description_set_data_layout, librocfft), rocfft_status,
                 (rocfft_plan_description, rocfft_array_type, rocfft_array_type,
                  Ptr{Csize_t}, Ptr{Csize_t}, Csize_t, Ptr{Csize_t}, Csize_t, Csize_t,
                  Ptr{Csize_t}, Csize_t),
                 description, in_array_type, out_array_type, in_offsets, out_offsets,
                 in_strides_size, in_strides, in_distance, out_strides_size, out_strides,
                 out_distance)
end

function rocfft_get_version_string(buf, len)
    @check ccall((:rocfft_get_version_string, librocfft), rocfft_status,
                 (Cstring, Csize_t),
                 buf, len)
end

function rocfft_plan_get_work_buffer_size(plan, size_in_bytes)
    @check ccall((:rocfft_plan_get_work_buffer_size, librocfft), rocfft_status,
                 (rocfft_plan, Ptr{Csize_t}),
                 plan, size_in_bytes)
end

function rocfft_plan_get_print(plan)
    @check ccall((:rocfft_plan_get_print, librocfft), rocfft_status,
                 (rocfft_plan,),
                 plan)
end

function rocfft_plan_description_create(description)
    @check ccall((:rocfft_plan_description_create, librocfft), rocfft_status,
                 (Ptr{rocfft_plan_description},),
                 description)
end

function rocfft_plan_description_destroy(description)
    @check ccall((:rocfft_plan_description_destroy, librocfft), rocfft_status,
                 (rocfft_plan_description,),
                 description)
end

function rocfft_execution_info_create(info)
    @check ccall((:rocfft_execution_info_create, librocfft), rocfft_status,
                 (Ptr{rocfft_execution_info},),
                 info)
end

function rocfft_execution_info_destroy(info)
    @check ccall((:rocfft_execution_info_destroy, librocfft), rocfft_status,
                 (rocfft_execution_info,),
                 info)
end

function rocfft_execution_info_set_work_buffer(info, work_buffer, size_in_bytes)
    @check ccall((:rocfft_execution_info_set_work_buffer, librocfft), rocfft_status,
                 (rocfft_execution_info, Ptr{Cvoid}, Csize_t),
                 info, work_buffer, size_in_bytes)
end

function rocfft_execution_info_set_stream(info, stream)
    @check ccall((:rocfft_execution_info_set_stream, librocfft), rocfft_status,
                 (rocfft_execution_info, Ptr{Cvoid}),
                 info, stream)
end
# Julia wrapper for header: rocfft-export.h
# Automatically generated using Clang.jl

