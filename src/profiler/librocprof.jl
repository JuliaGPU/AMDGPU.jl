using CEnum

const ROCPROFILER_EXPORT_DECORATOR = identity
const ROCPROFILER_IMPORT_DECORATOR = identity
const ROCPROFILER_CALL = identity

# no prototype is found for this function at rocprofiler.h:264:26, please use with caution
function rocprofiler_version_major()
    @ccall librocprofiler64v2.rocprofiler_version_major()::UInt32
end

# no prototype is found for this function at rocprofiler.h:273:26, please use with caution
function rocprofiler_version_minor()
    @ccall librocprofiler64v2.rocprofiler_version_minor()::UInt32
end

@cenum rocprofiler_status_t::Int32 begin
    ROCPROFILER_STATUS_SUCCESS = 0
    ROCPROFILER_STATUS_ERROR = -1
    ROCPROFILER_STATUS_ERROR_ALREADY_INITIALIZED = -2
    ROCPROFILER_STATUS_ERROR_NOT_INITIALIZED = -3
    ROCPROFILER_STATUS_ERROR_SESSION_MISSING_BUFFER = -4
    ROCPROFILER_STATUS_ERROR_TIMESTAMP_NOT_APPLICABLE = -5
    ROCPROFILER_STATUS_ERROR_AGENT_NOT_FOUND = -6
    ROCPROFILER_STATUS_ERROR_AGENT_INFORMATION_MISSING = -7
    ROCPROFILER_STATUS_ERROR_QUEUE_NOT_FOUND = -8
    ROCPROFILER_STATUS_ERROR_QUEUE_INFORMATION_MISSING = -9
    ROCPROFILER_STATUS_ERROR_KERNEL_NOT_FOUND = -10
    ROCPROFILER_STATUS_ERROR_KERNEL_INFORMATION_MISSING = -11
    ROCPROFILER_STATUS_ERROR_COUNTER_NOT_FOUND = -12
    ROCPROFILER_STATUS_ERROR_COUNTER_INFORMATION_MISSING = -13
    ROCPROFILER_STATUS_ERROR_TRACER_API_DATA_NOT_FOUND = -14
    ROCPROFILER_STATUS_ERROR_TRACER_API_DATA_INFORMATION_MISSING = -15
    ROCPROFILER_STATUS_ERROR_INCORRECT_DOMAIN = -16
    ROCPROFILER_STATUS_ERROR_SESSION_NOT_FOUND = -17
    ROCPROFILER_STATUS_ERROR_CORRUPTED_SESSION_BUFFER = -18
    ROCPROFILER_STATUS_ERROR_RECORD_CORRUPTED = -19
    ROCPROFILER_STATUS_ERROR_INCORRECT_REPLAY_MODE = -20
    ROCPROFILER_STATUS_ERROR_SESSION_MISSING_FILTER = -21
    ROCPROFILER_STATUS_ERROR_INCORRECT_SIZE = -22
    ROCPROFILER_STATUS_ERROR_INCORRECT_FLUSH_INTERVAL = -23
    ROCPROFILER_STATUS_ERROR_SESSION_FILTER_DATA_MISMATCH = -24
    ROCPROFILER_STATUS_ERROR_FILTER_DATA_CORRUPTED = -25
    ROCPROFILER_STATUS_ERROR_CORRUPTED_LABEL_DATA = -26
    ROCPROFILER_STATUS_ERROR_RANGE_STACK_IS_EMPTY = -27
    ROCPROFILER_STATUS_ERROR_PASS_NOT_STARTED = -28
    ROCPROFILER_STATUS_ERROR_HAS_ACTIVE_SESSION = -29
    ROCPROFILER_STATUS_ERROR_SESSION_NOT_ACTIVE = -30
    ROCPROFILER_STATUS_ERROR_FILTER_NOT_FOUND = -31
    ROCPROFILER_STATUS_ERROR_BUFFER_NOT_FOUND = -32
    ROCPROFILER_STATUS_ERROR_FILTER_NOT_SUPPORTED = -33
    ROCPROFILER_STATUS_ERROR_INVALID_ARGUMENTS = -34
    ROCPROFILER_STATUS_ERROR_INVALID_OPERATION_ID = -35
    ROCPROFILER_STATUS_ERROR_INVALID_DOMAIN_ID = -36
    ROCPROFILER_STATUS_ERROR_NOT_IMPLEMENTED = -37
    ROCPROFILER_STATUS_ERROR_MISMATCHED_EXTERNAL_CORRELATION_ID = -38
end

function rocprofiler_error_str(status)
    @ccall librocprofiler64v2.rocprofiler_error_str(status::rocprofiler_status_t)::Ptr{Cchar}
end

# no prototype is found for this function at rocprofiler.h:476:38, please use with caution
function rocprofiler_initialize()
    @ccall librocprofiler64v2.rocprofiler_initialize()::rocprofiler_status_t
end

# no prototype is found for this function at rocprofiler.h:486:38, please use with caution
function rocprofiler_finalize()
    @ccall librocprofiler64v2.rocprofiler_finalize()::rocprofiler_status_t
end

struct rocprofiler_session_id_t
    handle::UInt64
end

struct rocprofiler_timestamp_t
    value::UInt64
end

function rocprofiler_get_timestamp(timestamp)
    @ccall librocprofiler64v2.rocprofiler_get_timestamp(timestamp::Ptr{rocprofiler_timestamp_t})::rocprofiler_status_t
end

struct rocprofiler_record_header_timestamp_t
    _begin::rocprofiler_timestamp_t
    _end::rocprofiler_timestamp_t
end

struct rocprofiler_record_id_t
    handle::UInt64
end

@cenum rocprofiler_record_kind_t::UInt32 begin
    ROCPROFILER_PROFILER_RECORD = 0
    ROCPROFILER_TRACER_RECORD = 1
    ROCPROFILER_ATT_TRACER_RECORD = 2
    ROCPROFILER_PC_SAMPLING_RECORD = 3
    ROCPROFILER_SPM_RECORD = 4
    ROCPROFILER_COUNTERS_SAMPLER_RECORD = 5
end

struct rocprofiler_record_header_t
    kind::rocprofiler_record_kind_t
    id::rocprofiler_record_id_t
end

struct rocprofiler_agent_id_t
    handle::UInt64
end

@cenum rocprofiler_agent_type_t::UInt32 begin
    ROCPROFILER_CPU_AGENT = 0
    ROCPROFILER_GPU_AGENT = 1
end

@cenum rocprofiler_agent_info_kind_t::UInt32 begin
    ROCPROFILER_AGENT_NAME = 0
    ROCPROFILER_AGENT_TYPE = 1
end

function rocprofiler_query_agent_info_size(kind, agent_id, data_size)
    @ccall librocprofiler64v2.rocprofiler_query_agent_info_size(kind::rocprofiler_agent_info_kind_t,
                                                                agent_id::rocprofiler_agent_id_t,
                                                                data_size::Ptr{Csize_t})::rocprofiler_status_t
end

function rocprofiler_query_agent_info(kind, descriptor, name)
    @ccall librocprofiler64v2.rocprofiler_query_agent_info(kind::rocprofiler_agent_info_kind_t,
                                                           descriptor::rocprofiler_agent_id_t,
                                                           name::Ptr{Ptr{Cchar}})::rocprofiler_status_t
end

struct rocprofiler_queue_id_t
    handle::UInt64
end

@cenum rocprofiler_queue_info_kind_t::UInt32 begin
    ROCPROFILER_QUEUE_SIZE = 0
end

function rocprofiler_query_queue_info_size(kind, agent_id, data_size)
    @ccall librocprofiler64v2.rocprofiler_query_queue_info_size(kind::rocprofiler_queue_info_kind_t,
                                                                agent_id::rocprofiler_queue_id_t,
                                                                data_size::Ptr{Csize_t})::rocprofiler_status_t
end

function rocprofiler_query_queue_info(kind, descriptor, name)
    @ccall librocprofiler64v2.rocprofiler_query_queue_info(kind::rocprofiler_queue_info_kind_t,
                                                           descriptor::rocprofiler_queue_id_t,
                                                           name::Ptr{Ptr{Cchar}})::rocprofiler_status_t
end

struct rocprofiler_kernel_id_t
    handle::UInt64
end

@cenum rocprofiler_kernel_info_kind_t::UInt32 begin
    ROCPROFILER_KERNEL_NAME = 0
end

function rocprofiler_query_kernel_info_size(kind, kernel_id, data_size)
    @ccall librocprofiler64v2.rocprofiler_query_kernel_info_size(kind::rocprofiler_kernel_info_kind_t,
                                                                 kernel_id::rocprofiler_kernel_id_t,
                                                                 data_size::Ptr{Csize_t})::rocprofiler_status_t
end

function rocprofiler_query_kernel_info(kind, kernel_id, data)
    @ccall librocprofiler64v2.rocprofiler_query_kernel_info(kind::rocprofiler_kernel_info_kind_t,
                                                            kernel_id::rocprofiler_kernel_id_t,
                                                            data::Ptr{Ptr{Cchar}})::rocprofiler_status_t
end

struct rocprofiler_thread_id_t
    value::UInt32
end

struct rocprofiler_counter_info_t
    name::Ptr{Cchar}
    description::Ptr{Cchar}
    expression::Ptr{Cchar}
    instances_count::UInt32
    block_name::Ptr{Cchar}
    block_counters::UInt32
end

# typedef int ( * rocprofiler_counters_info_callback_t ) ( rocprofiler_counter_info_t counter , const char * gpu_name , uint32_t gpu_index )
const rocprofiler_counters_info_callback_t = Ptr{Cvoid}

function rocprofiler_iterate_counters(counters_info_callback)
    @ccall librocprofiler64v2.rocprofiler_iterate_counters(counters_info_callback::rocprofiler_counters_info_callback_t)::rocprofiler_status_t
end

struct rocprofiler_counter_id_t
    handle::UInt64
end

@cenum rocprofiler_counter_info_kind_t::UInt32 begin
    ROCPROFILER_COUNTER_NAME = 0
    ROCPROFILER_COUNTER_BLOCK_ID = 2
    ROCPROFILER_COUNTER_HIERARCHY_LEVEL = 3
end

function rocprofiler_query_counter_info_size(session_id, counter_info_type, counter_id,
                                             data_size)
    @ccall librocprofiler64v2.rocprofiler_query_counter_info_size(session_id::rocprofiler_session_id_t,
                                                                  counter_info_type::rocprofiler_counter_info_kind_t,
                                                                  counter_id::rocprofiler_counter_id_t,
                                                                  data_size::Ptr{Csize_t})::rocprofiler_status_t
end

function rocprofiler_query_counter_info(session_id, kind, counter_id, data)
    @ccall librocprofiler64v2.rocprofiler_query_counter_info(session_id::rocprofiler_session_id_t,
                                                             kind::rocprofiler_counter_info_kind_t,
                                                             counter_id::rocprofiler_counter_id_t,
                                                             data::Ptr{Ptr{Cchar}})::rocprofiler_status_t
end

struct rocprofiler_queue_index_t
    value::UInt64
end

struct rocprofiler_record_counter_value_t
    value::Cdouble
end

struct rocprofiler_record_counter_instance_t
    counter_handler::rocprofiler_counter_id_t
    value::rocprofiler_record_counter_value_t
end

struct rocprofiler_record_counters_instances_count_t
    value::UInt64
end

struct rocprofiler_kernel_properties_t
    grid_size::UInt64
    workgroup_size::UInt64
    lds_size::UInt64
    scratch_size::UInt64
    arch_vgpr_count::UInt64
    accum_vgpr_count::UInt64
    sgpr_count::UInt64
    wave_size::UInt64
    signal_handle::UInt64
end

struct rocprofiler_correlation_id_t
    value::UInt64
end

struct rocprofiler_record_profiler_t
    header::rocprofiler_record_header_t
    kernel_id::rocprofiler_kernel_id_t
    gpu_id::rocprofiler_agent_id_t
    queue_id::rocprofiler_queue_id_t
    timestamps::rocprofiler_record_header_timestamp_t
    counters::Ptr{rocprofiler_record_counter_instance_t}
    counters_count::rocprofiler_record_counters_instances_count_t
    kernel_properties::rocprofiler_kernel_properties_t
    thread_id::rocprofiler_thread_id_t
    queue_idx::rocprofiler_queue_index_t
    correlation_id::rocprofiler_correlation_id_t
end

struct rocprofiler_event_id_t
    value::UInt32
end

struct rocprofiler_record_spm_counters_instances_count_t
    value::UInt16
end

struct rocprofiler_record_se_spm_data_t
    counters_data::NTuple{32,rocprofiler_record_spm_counters_instances_count_t}
end

struct rocprofiler_record_spm_t
    header::rocprofiler_record_header_t
    timestamps::rocprofiler_record_header_timestamp_t
    shader_engine_data::NTuple{4,rocprofiler_record_se_spm_data_t}
end

struct rocprofiler_record_se_att_data_t
    buffer_ptr::Ptr{Cvoid}
    buffer_size::UInt32
end

struct rocprofiler_intercepted_codeobj_t
    filepath::Ptr{Cchar}
    base_address::UInt64
    data::Ptr{Cchar}
    size::UInt64
    clock_start::rocprofiler_timestamp_t
    clock_end::rocprofiler_timestamp_t
end

@cenum rocprofiler_codeobj_capture_mode_t::UInt32 begin
    ROCPROFILER_CAPTURE_SYMBOLS_ONLY = 0
    ROCPROFILER_CAPTURE_COPY_MEMORY = 1
    ROCPROFILER_CAPTURE_COPY_FILE_AND_MEMORY = 2
end

struct rocprofiler_codeobj_symbols_t
    symbols::Ptr{rocprofiler_intercepted_codeobj_t}
    count::UInt64
    userdata::UInt64
end

struct rocprofiler_record_att_tracer_t
    header::rocprofiler_record_header_t
    kernel_id::rocprofiler_kernel_id_t
    gpu_id::rocprofiler_agent_id_t
    queue_id::rocprofiler_queue_id_t
    kernel_properties::rocprofiler_kernel_properties_t
    thread_id::rocprofiler_thread_id_t
    queue_idx::rocprofiler_queue_index_t
    writer_id::UInt64
    shader_engine_data::Ptr{rocprofiler_record_se_att_data_t}
    shader_engine_data_count::UInt64
    intercept_list::rocprofiler_codeobj_symbols_t
end

@cenum rocprofiler_tracer_activity_domain_t::UInt32 begin
    ACTIVITY_DOMAIN_HSA_API = 0
    ACTIVITY_DOMAIN_HSA_OPS = 1
    ACTIVITY_DOMAIN_HIP_OPS = 2
    ACTIVITY_DOMAIN_HIP_API = 3
    ACTIVITY_DOMAIN_KFD_API = 4
    ACTIVITY_DOMAIN_EXT_API = 5
    ACTIVITY_DOMAIN_ROCTX = 6
    ACTIVITY_DOMAIN_HSA_EVT = 7
    ACTIVITY_DOMAIN_NUMBER = 8
end

struct rocprofiler_tracer_operation_id_t
    id::UInt32
end

struct rocprofiler_tracer_activity_correlation_id_t
    value::UInt64
end

struct rocprofiler_tracer_api_data_t
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{rocprofiler_tracer_api_data_t}, f::Symbol)
    f === :hip && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :hsa && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :roctx && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::rocprofiler_tracer_api_data_t, f::Symbol)
    r = Ref{rocprofiler_tracer_api_data_t}(x)
    ptr = Base.unsafe_convert(Ptr{rocprofiler_tracer_api_data_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocprofiler_tracer_api_data_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function rocprofiler_query_tracer_operation_name(domain, operation_id, name)
    @ccall librocprofiler64v2.rocprofiler_query_tracer_operation_name(domain::rocprofiler_tracer_activity_domain_t,
                                                                      operation_id::rocprofiler_tracer_operation_id_t,
                                                                      name::Ptr{Ptr{Cchar}})::rocprofiler_status_t
end

function rocprofiler_tracer_operation_id(domain, name, operation_id)
    @ccall librocprofiler64v2.rocprofiler_tracer_operation_id(domain::rocprofiler_tracer_activity_domain_t,
                                                              name::Ptr{Cchar},
                                                              operation_id::Ptr{rocprofiler_tracer_operation_id_t})::rocprofiler_status_t
end

struct rocprofiler_tracer_external_id_t
    id::UInt64
end

@cenum rocprofiler_api_tracing_phase_t::UInt32 begin
    ROCPROFILER_PHASE_NONE = 0
    ROCPROFILER_PHASE_ENTER = 1
    ROCPROFILER_PHASE_EXIT = 2
end

struct rocprofiler_record_tracer_t
    header::rocprofiler_record_header_t
    external_id::rocprofiler_tracer_external_id_t
    domain::rocprofiler_tracer_activity_domain_t
    operation_id::rocprofiler_tracer_operation_id_t
    api_data::rocprofiler_tracer_api_data_t
    correlation_id::rocprofiler_tracer_activity_correlation_id_t
    timestamps::rocprofiler_record_header_timestamp_t
    agent_id::rocprofiler_agent_id_t
    queue_id::rocprofiler_queue_id_t
    thread_id::rocprofiler_thread_id_t
    phase::rocprofiler_api_tracing_phase_t
    name::Ptr{Cchar}
end

struct rocprofiler_kernel_dispatch_id_t
    value::UInt64
end

struct rocprofiler_pc_sample_t
    data::NTuple{40,UInt8}
end

function Base.getproperty(x::Ptr{rocprofiler_pc_sample_t}, f::Symbol)
    f === :dispatch_id && return Ptr{rocprofiler_kernel_dispatch_id_t}(x + 0)
    f === :timestamp && return Ptr{rocprofiler_timestamp_t}(x + 8)
    f === :cycle && return Ptr{UInt64}(x + 8)
    f === :pc && return Ptr{UInt64}(x + 16)
    f === :se && return Ptr{UInt32}(x + 24)
    f === :gpu_id && return Ptr{rocprofiler_agent_id_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::rocprofiler_pc_sample_t, f::Symbol)
    r = Ref{rocprofiler_pc_sample_t}(x)
    ptr = Base.unsafe_convert(Ptr{rocprofiler_pc_sample_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocprofiler_pc_sample_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct rocprofiler_record_pc_sample_t
    header::rocprofiler_record_header_t
    pc_sample::rocprofiler_pc_sample_t
end

@cenum rocprofiler_buffer_property_kind_t::UInt32 begin
    ROCPROFILER_BUFFER_PROPERTY_KIND_INTERVAL_FLUSH = 0
end

struct rocprofiler_buffer_property_t
    kind::rocprofiler_buffer_property_kind_t
    value::UInt64
end

struct rocprofiler_buffer_id_t
    value::UInt64
end

struct rocprofiler_filter_id_t
    value::UInt64
end

# typedef void ( * rocprofiler_buffer_callback_t ) ( const rocprofiler_record_header_t * begin , const rocprofiler_record_header_t * end , rocprofiler_session_id_t session_id , rocprofiler_buffer_id_t buffer_id )
const rocprofiler_buffer_callback_t = Ptr{Cvoid}

function rocprofiler_flush_data(session_id, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_flush_data(session_id::rocprofiler_session_id_t,
                                                     buffer_id::rocprofiler_buffer_id_t)::rocprofiler_status_t
end

function rocprofiler_next_record(record, next, session_id, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_next_record(record::Ptr{rocprofiler_record_header_t},
                                                      next::Ptr{Ptr{rocprofiler_record_header_t}},
                                                      session_id::rocprofiler_session_id_t,
                                                      buffer_id::rocprofiler_buffer_id_t)::rocprofiler_status_t
end

@cenum rocprofiler_replay_mode_t::Int32 begin
    ROCPROFILER_NONE_REPLAY_MODE = -1
end

function rocprofiler_create_session(replay_mode, session_id)
    @ccall librocprofiler64v2.rocprofiler_create_session(replay_mode::rocprofiler_replay_mode_t,
                                                         session_id::Ptr{rocprofiler_session_id_t})::rocprofiler_status_t
end

function rocprofiler_destroy_session(session_id)
    @ccall librocprofiler64v2.rocprofiler_destroy_session(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

@cenum rocprofiler_filter_kind_t::UInt32 begin
    ROCPROFILER_DISPATCH_TIMESTAMPS_COLLECTION = 1
    ROCPROFILER_COUNTERS_COLLECTION = 2
    ROCPROFILER_PC_SAMPLING_COLLECTION = 3
    ROCPROFILER_ATT_TRACE_COLLECTION = 4
    ROCPROFILER_SPM_COLLECTION = 5
    ROCPROFILER_API_TRACE = 6
    ROCPROFILER_COUNTERS_SAMPLER = 7
end

@cenum rocprofiler_filter_property_kind_t::UInt32 begin
    ROCPROFILER_FILTER_HSA_TRACER_API_FUNCTIONS = 1
    ROCPROFILER_FILTER_HIP_TRACER_API_FUNCTIONS = 2
    ROCPROFILER_FILTER_GPU_NAME = 3
    ROCPROFILER_FILTER_RANGE = 4
    ROCPROFILER_FILTER_KERNEL_NAMES = 5
    ROCPROFILER_FILTER_DISPATCH_IDS = 6
end

const rocprofiler_hip_function_name_t = Ptr{Cchar}

const rocprofiler_hsa_function_name_t = Ptr{Cchar}

@cenum rocprofiler_att_parameter_name_t::UInt32 begin
    ROCPROFILER_ATT_COMPUTE_UNIT = 0
    ROCPROFILER_ATT_VMID_MASK = 1
    ROCPROFILER_ATT_SE_MASK = 5
    ROCPROFILER_ATT_SIMD_SELECT = 8
    ROCPROFILER_ATT_OCCUPANCY = 9
    ROCPROFILER_ATT_BUFFER_SIZE = 10
    ROCPROFILER_ATT_CAPTURE_MODE = 11
    ROCPROFILER_ATT_PERF_MASK = 240
    ROCPROFILER_ATT_PERF_CTRL = 241
    ROCPROFILER_ATT_PERFCOUNTER = 242
    ROCPROFILER_ATT_PERFCOUNTER_NAME = 243
    ROCPROFILER_ATT_MAXVALUE = 244
    ROCPROFILER_ATT_MASK = 2
    ROCPROFILER_ATT_TOKEN_MASK = 3
    ROCPROFILER_ATT_TOKEN_MASK2 = 4
    ROCPROFILER_ATT_SAMPLE_RATE = 6
end

struct rocprofiler_att_parameter_t
    data::NTuple{16,UInt8}
end

function Base.getproperty(x::Ptr{rocprofiler_att_parameter_t}, f::Symbol)
    f === :parameter_name && return Ptr{rocprofiler_att_parameter_name_t}(x + 0)
    f === :value && return Ptr{UInt32}(x + 8)
    f === :counter_name && return Ptr{Ptr{Cchar}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::rocprofiler_att_parameter_t, f::Symbol)
    r = Ref{rocprofiler_att_parameter_t}(x)
    ptr = Base.unsafe_convert(Ptr{rocprofiler_att_parameter_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocprofiler_att_parameter_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct rocprofiler_filter_property_t
    data::NTuple{24,UInt8}
end

function Base.getproperty(x::Ptr{rocprofiler_filter_property_t}, f::Symbol)
    f === :kind && return Ptr{rocprofiler_filter_property_kind_t}(x + 0)
    f === :name_regex && return Ptr{Ptr{Ptr{Cchar}}}(x + 8)
    f === :hip_functions_names && return Ptr{Ptr{rocprofiler_hip_function_name_t}}(x + 8)
    f === :hsa_functions_names && return Ptr{Ptr{rocprofiler_hsa_function_name_t}}(x + 8)
    f === :range && return Ptr{NTuple{2,UInt32}}(x + 8)
    f === :dispatch_ids && return Ptr{Ptr{UInt64}}(x + 8)
    f === :data_count && return Ptr{UInt64}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::rocprofiler_filter_property_t, f::Symbol)
    r = Ref{rocprofiler_filter_property_t}(x)
    ptr = Base.unsafe_convert(Ptr{rocprofiler_filter_property_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocprofiler_filter_property_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct rocprofiler_spm_parameter_t
    counters_names::Ptr{Ptr{Cchar}}
    counters_count::Cint
    sampling_rate::UInt32
    gpu_agent_id::Ptr{rocprofiler_agent_id_t}
end

@cenum rocprofiler_counters_sampler_counter_type_t::UInt32 begin
    ROCPROFILER_COUNTERS_SAMPLER_PCIE_COUNTERS = 0
    ROCPROFILER_COUNTERS_SAMPLER_XGMI_COUNTERS = 1
end

struct rocprofiler_counters_sampler_counter_input_t
    name::Ptr{Cchar}
    type::rocprofiler_counters_sampler_counter_type_t
end

struct rocprofiler_counters_sampler_counter_output_t
    type::rocprofiler_counters_sampler_counter_type_t
    value::rocprofiler_record_counter_value_t
end

struct rocprofiler_counters_sampler_parameters_t
    counters::Ptr{rocprofiler_counters_sampler_counter_input_t}
    counters_num::Cint
    sampling_rate::UInt32
    sampling_duration::UInt32
    initial_delay::UInt32
    gpu_agent_index::Cint
end

struct rocprofiler_record_counters_sampler_t
    header::rocprofiler_record_header_t
    gpu_id::rocprofiler_agent_id_t
    counters::Ptr{rocprofiler_counters_sampler_counter_output_t}
    num_counters::UInt32
end

struct rocprofiler_filter_data_t
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{rocprofiler_filter_data_t}, f::Symbol)
    f === :trace_apis && return Ptr{Ptr{rocprofiler_tracer_activity_domain_t}}(x + 0)
    f === :counters_names && return Ptr{Ptr{Ptr{Cchar}}}(x + 0)
    f === :att_parameters && return Ptr{Ptr{rocprofiler_att_parameter_t}}(x + 0)
    f === :spm_parameters && return Ptr{Ptr{rocprofiler_spm_parameter_t}}(x + 0)
    f === :counters_sampler_parameters &&
        return Ptr{rocprofiler_counters_sampler_parameters_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::rocprofiler_filter_data_t, f::Symbol)
    r = Ref{rocprofiler_filter_data_t}(x)
    ptr = Base.unsafe_convert(Ptr{rocprofiler_filter_data_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{rocprofiler_filter_data_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function rocprofiler_create_filter(session_id, filter_kind, data, data_count, filter_id,
                                   property)
    @ccall librocprofiler64v2.rocprofiler_create_filter(session_id::rocprofiler_session_id_t,
                                                        filter_kind::rocprofiler_filter_kind_t,
                                                        data::rocprofiler_filter_data_t,
                                                        data_count::UInt64,
                                                        filter_id::Ptr{rocprofiler_filter_id_t},
                                                        property::rocprofiler_filter_property_t)::rocprofiler_status_t
end

function rocprofiler_set_filter_buffer(session_id, filter_id, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_set_filter_buffer(session_id::rocprofiler_session_id_t,
                                                            filter_id::rocprofiler_filter_id_t,
                                                            buffer_id::rocprofiler_buffer_id_t)::rocprofiler_status_t
end

# typedef void ( * rocprofiler_sync_callback_t ) ( rocprofiler_record_tracer_t record , rocprofiler_session_id_t session_id )
const rocprofiler_sync_callback_t = Ptr{Cvoid}

function rocprofiler_set_api_trace_sync_callback(session_id, filter_id, callback)
    @ccall librocprofiler64v2.rocprofiler_set_api_trace_sync_callback(session_id::rocprofiler_session_id_t,
                                                                      filter_id::rocprofiler_filter_id_t,
                                                                      callback::rocprofiler_sync_callback_t)::rocprofiler_status_t
end

function rocprofiler_destroy_filter(session_id, filter_id)
    @ccall librocprofiler64v2.rocprofiler_destroy_filter(session_id::rocprofiler_session_id_t,
                                                         filter_id::rocprofiler_filter_id_t)::rocprofiler_status_t
end

function rocprofiler_create_buffer(session_id, buffer_callback, buffer_size, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_create_buffer(session_id::rocprofiler_session_id_t,
                                                        buffer_callback::rocprofiler_buffer_callback_t,
                                                        buffer_size::Csize_t,
                                                        buffer_id::Ptr{rocprofiler_buffer_id_t})::rocprofiler_status_t
end

function rocprofiler_set_buffer_properties(session_id, buffer_id, buffer_properties,
                                           buffer_properties_count)
    @ccall librocprofiler64v2.rocprofiler_set_buffer_properties(session_id::rocprofiler_session_id_t,
                                                                buffer_id::rocprofiler_buffer_id_t,
                                                                buffer_properties::Ptr{rocprofiler_buffer_property_t},
                                                                buffer_properties_count::UInt32)::rocprofiler_status_t
end

function rocprofiler_destroy_buffer(session_id, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_destroy_buffer(session_id::rocprofiler_session_id_t,
                                                         buffer_id::rocprofiler_buffer_id_t)::rocprofiler_status_t
end

function rocprofiler_create_ready_session(replay_mode, filter_kind, data, data_count,
                                          buffer_size, buffer_callback, session_id,
                                          property, callback)
    @ccall librocprofiler64v2.rocprofiler_create_ready_session(replay_mode::rocprofiler_replay_mode_t,
                                                               filter_kind::rocprofiler_filter_kind_t,
                                                               data::rocprofiler_filter_data_t,
                                                               data_count::UInt64,
                                                               buffer_size::Csize_t,
                                                               buffer_callback::rocprofiler_buffer_callback_t,
                                                               session_id::Ptr{rocprofiler_session_id_t},
                                                               property::rocprofiler_filter_property_t,
                                                               callback::rocprofiler_sync_callback_t)::rocprofiler_status_t
end

function rocprofiler_start_session(session_id)
    @ccall librocprofiler64v2.rocprofiler_start_session(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

function rocprofiler_terminate_session(session_id)
    @ccall librocprofiler64v2.rocprofiler_terminate_session(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

struct rocprofiler_counter_value_t
    value::Cdouble
end

struct rocprofiler_device_profile_metric_t
    metric_name::NTuple{64,Cchar}
    value::rocprofiler_counter_value_t
end

function rocprofiler_device_profiling_session_create(counter_names, num_counters,
                                                     session_id, cpu_index, gpu_index)
    @ccall librocprofiler64v2.rocprofiler_device_profiling_session_create(counter_names::Ptr{Ptr{Cchar}},
                                                                          num_counters::UInt64,
                                                                          session_id::Ptr{rocprofiler_session_id_t},
                                                                          cpu_index::Cint,
                                                                          gpu_index::Cint)::rocprofiler_status_t
end

function rocprofiler_device_profiling_session_start(session_id)
    @ccall librocprofiler64v2.rocprofiler_device_profiling_session_start(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

function rocprofiler_device_profiling_session_poll(session_id, data)
    @ccall librocprofiler64v2.rocprofiler_device_profiling_session_poll(session_id::rocprofiler_session_id_t,
                                                                        data::Ptr{rocprofiler_device_profile_metric_t})::rocprofiler_status_t
end

function rocprofiler_device_profiling_session_stop(session_id)
    @ccall librocprofiler64v2.rocprofiler_device_profiling_session_stop(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

function rocprofiler_device_profiling_session_destroy(session_id)
    @ccall librocprofiler64v2.rocprofiler_device_profiling_session_destroy(session_id::rocprofiler_session_id_t)::rocprofiler_status_t
end

function rocprofiler_codeobj_capture_create(id, mode, userdata)
    @ccall librocprofiler64v2.rocprofiler_codeobj_capture_create(id::Ptr{rocprofiler_record_id_t},
                                                                 mode::rocprofiler_codeobj_capture_mode_t,
                                                                 userdata::UInt64)::rocprofiler_status_t
end

function rocprofiler_codeobj_capture_get(id, capture)
    @ccall librocprofiler64v2.rocprofiler_codeobj_capture_get(id::rocprofiler_record_id_t,
                                                              capture::Ptr{rocprofiler_codeobj_symbols_t})::rocprofiler_status_t
end

function rocprofiler_codeobj_capture_free(id)
    @ccall librocprofiler64v2.rocprofiler_codeobj_capture_free(id::rocprofiler_record_id_t)::rocprofiler_status_t
end

function rocprofiler_codeobj_capture_start(id)
    @ccall librocprofiler64v2.rocprofiler_codeobj_capture_start(id::rocprofiler_record_id_t)::rocprofiler_status_t
end

function rocprofiler_codeobj_capture_stop(id)
    @ccall librocprofiler64v2.rocprofiler_codeobj_capture_stop(id::rocprofiler_record_id_t)::rocprofiler_status_t
end

function rocprofiler_plugin_initialize(rocprofiler_major_version, rocprofiler_minor_version,
                                       data)
    @ccall librocprofiler64v2.rocprofiler_plugin_initialize(rocprofiler_major_version::UInt32,
                                                            rocprofiler_minor_version::UInt32,
                                                            data::Ptr{Cvoid})::Cint
end

# no prototype is found for this function at rocprofiler_plugin.h:93:25, please use with caution
function rocprofiler_plugin_finalize()
    @ccall librocprofiler64v2.rocprofiler_plugin_finalize()::Cvoid
end

function rocprofiler_plugin_write_buffer_records(_begin, _end, session_id, buffer_id)
    @ccall librocprofiler64v2.rocprofiler_plugin_write_buffer_records(_begin::Ptr{rocprofiler_record_header_t},
                                                                      _end::Ptr{rocprofiler_record_header_t},
                                                                      session_id::rocprofiler_session_id_t,
                                                                      buffer_id::rocprofiler_buffer_id_t)::Cint
end

function rocprofiler_plugin_write_record(record)
    @ccall librocprofiler64v2.rocprofiler_plugin_write_record(record::rocprofiler_record_tracer_t)::Cint
end

# Skipping MacroDefinition: ROCPROFILER_EXPORT_DECORATOR __attribute__ ( ( visibility ( "default" ) ) )

const ROCPROFILER_EXPORT = ROCPROFILER_EXPORT_DECORATOR(ROCPROFILER_CALL)

const ROCPROFILER_IMPORT = ROCPROFILER_IMPORT_DECORATOR(ROCPROFILER_CALL)

const ROCPROFILER_API = ROCPROFILER_IMPORT

const ROCPROFILER_VERSION_MAJOR = 9

const ROCPROFILER_VERSION_MINOR = 0
