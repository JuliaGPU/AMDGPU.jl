# ENV["HSA_TOOLS_LIB"] = "/opt/rocm/lib/librocprofiler64v2.so"
# ENV["ROCPROFILER_METRICS_PATH"] = "/opt/rocm/libexec/rocprofiler/counters/derived_counters.xml"

using AMDGPU
import AMDGPU: Profiler, @check

@show Profiler.version()

# Application tracing

## Initialize tools
@check Profiler.rocprofiler_initialize()

## create session with replay mode
r_id = Ref{Profiler.rocprofiler_session_id_t}()
@check Profiler.rocprofiler_create_session(Profiler.ROCPROFILER_NONE_REPLAY_MODE, r_id)
id = r_id[]

## Create output buffer for the data
function output_callback(record, end_record, session_id, buffer_id)
    @info "Output callback" record, end_record, session_id, buffer_id
    return nothing
end

r_buffer_id = Ref{Profiler.rocprofiler_buffer_id_t}()
@check Profiler.rocprofiler_create_buffer(
    id,
    @cfunction(output_callback, Cvoid, (
                                 Ptr{Profiler.rocprofiler_record_header_t},
                                 Ptr{Profiler.rocprofiler_record_header_t},
                                 Profiler.rocprofiler_session_id_t,
                                 Profiler.rocprofiler_buffer_id_t)),
    0x9999, r_buffer_id
    )
buffer_id = r_buffer_id[]

# Specifying the APIs to be traced in a vector
apis_requested = Vector{Profiler.rocprofiler_tracer_activity_domain_t}(undef, 0)
push!(apis_requested, Profiler.ACTIVITY_DOMAIN_HIP_API)
push!(apis_requested, Profiler.ACTIVITY_DOMAIN_HIP_OPS)
push!(apis_requested, Profiler.ACTIVITY_DOMAIN_HSA_API)
push!(apis_requested, Profiler.ACTIVITY_DOMAIN_HSA_OPS)
push!(apis_requested, Profiler.ACTIVITY_DOMAIN_ROCTX)

GC.@preserve apis_requested begin 
    # Looking at the code we can release the pointer after rocprofiler_create_filter
    filter_data = Ref{Profiler.rocprofiler_filter_data_t}()
    GC.@preserve filter_data begin
        ptr = Base.unsafe_convert(Ptr{Profiler.rocprofiler_filter_data_t}, filter_data)
        Base.memset(ptr, UInt8(0), sizeof(Profiler.rocprofiler_filter_data_t))

        ptr.trace_apis = pointer(apis_requested)
    end

    r_api_tracing_filter_id = Ref{Profiler.rocprofiler_filter_id_t}()
    filter_property = Ref{Profiler.rocprofiler_filter_property_t}()
    GC.@preserve filter_property begin
        ptr = Base.unsafe_convert(Ptr{Profiler.rocprofiler_filter_property_t}, filter_property)
        Base.memset(ptr, UInt8(0), sizeof(Profiler.rocprofiler_filter_property_t))
    end

    # Creating filter for tracing APIs
    @check Profiler.rocprofiler_create_filter(
        id, Profiler.ROCPROFILER_API_TRACE,
        filter_data[], length(apis_requested),
        r_api_tracing_filter_id, filter_property[]
    )
    api_tracing_filter_id = r_api_tracing_filter_id[]
end
api_tracing_filter_id

function timestamp()
    r = Ref{Profiler.rocprofiler_timestamp_t}()
    Profiler.rocprofiler_get_timestamp(r)
    return r[].value
end

function trace_sync_callback(record::Profiler.rocprofiler_record_tracer_t, session_id)
    if record.domain == Profiler.ACTIVITY_DOMAIN_HSA_API ||
       record.domain == Profiler.ACTIVITY_DOMAIN_HIP_API
        r_fn_name = Ref{Ptr{Cchar}}()

        @check Profiler.rocprofiler_query_tracer_operation_name(
            record.domain, record.operation_id, r_fn_name
        )
        fn_name = Base.unsafe_string(r_fn_name[])
    else
        fn_name = nothing
    end
    
    if record.phase == Profiler.ROCPROFILER_PHASE_ENTER
        ts_begin = timestamp()
        ts_end = nothing
    elseif record.phase == Profiler.ROCPROFILER_PHASE_EXIT
        ts_begin = nothing
        ts_end = timestamp()
    else
        ts_begin = record.timestamps._begin.value 
        ts_end = record.timestamps._end.value 
    end

    if record.name != C_NULL
        name = Base.unsafe_string(record.name)
    else
        name = nothing
    end

    @info "trace_sync" domain=record.domain phase=record.phase correlation=record.correlation_id.value ts_begin ts_end fn_name record.name
    return nothing
end

@check Profiler.rocprofiler_set_filter_buffer(id, api_tracing_filter_id, buffer_id)
@check Profiler.rocprofiler_set_api_trace_sync_callback(
    id, api_tracing_filter_id,
    @cfunction(trace_sync_callback, Cvoid, (
                    Profiler.rocprofiler_record_tracer_t,
                    Profiler.rocprofiler_session_id_t,
                    )),
)

# Kernel tracing 
filter_data = Ref{Profiler.rocprofiler_filter_data_t}()
GC.@preserve filter_data begin
    ptr = Base.unsafe_convert(Ptr{Profiler.rocprofiler_filter_data_t}, filter_data)
    Base.memset(ptr, UInt8(0), sizeof(Profiler.rocprofiler_filter_data_t))
end

r_kernel_tracing_filter_id = Ref{Profiler.rocprofiler_filter_id_t}()
@check Profiler.rocprofiler_create_filter(
    id, Profiler.ROCPROFILER_DISPATCH_TIMESTAMPS_COLLECTION,
    filter_data[], 0, r_kernel_tracing_filter_id, filter_property[]
)
kernel_tracing_filter_id = r_kernel_tracing_filter_id[]

function kernel()
    return nothing
end

@roc kernel()

Profiler.rocprofiler_start_session(id)

@roc kernel()
AMDGPU.synchronize()

Profiler.rocprofiler_terminate_session(id)
Profiler.rocprofiler_flush_data(id, buffer_id)
Profiler.rocprofiler_destroy_session(id)
Profiler.rocprofiler_finalize()
