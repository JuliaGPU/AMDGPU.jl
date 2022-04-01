module LibHSARuntime

using CEnum

import ...AMDGPU: libhsaruntime

const HSA_EXPORT_DECORATOR = identity
const HSA_CALL = nothing


@cenum hsa_status_t::UInt32 begin
    HSA_STATUS_SUCCESS = 0
    HSA_STATUS_INFO_BREAK = 1
    HSA_STATUS_ERROR = 4096
    HSA_STATUS_ERROR_INVALID_ARGUMENT = 4097
    HSA_STATUS_ERROR_INVALID_QUEUE_CREATION = 4098
    HSA_STATUS_ERROR_INVALID_ALLOCATION = 4099
    HSA_STATUS_ERROR_INVALID_AGENT = 4100
    HSA_STATUS_ERROR_INVALID_REGION = 4101
    HSA_STATUS_ERROR_INVALID_SIGNAL = 4102
    HSA_STATUS_ERROR_INVALID_QUEUE = 4103
    HSA_STATUS_ERROR_OUT_OF_RESOURCES = 4104
    HSA_STATUS_ERROR_INVALID_PACKET_FORMAT = 4105
    HSA_STATUS_ERROR_RESOURCE_FREE = 4106
    HSA_STATUS_ERROR_NOT_INITIALIZED = 4107
    HSA_STATUS_ERROR_REFCOUNT_OVERFLOW = 4108
    HSA_STATUS_ERROR_INCOMPATIBLE_ARGUMENTS = 4109
    HSA_STATUS_ERROR_INVALID_INDEX = 4110
    HSA_STATUS_ERROR_INVALID_ISA = 4111
    HSA_STATUS_ERROR_INVALID_ISA_NAME = 4119
    HSA_STATUS_ERROR_INVALID_CODE_OBJECT = 4112
    HSA_STATUS_ERROR_INVALID_EXECUTABLE = 4113
    HSA_STATUS_ERROR_FROZEN_EXECUTABLE = 4114
    HSA_STATUS_ERROR_INVALID_SYMBOL_NAME = 4115
    HSA_STATUS_ERROR_VARIABLE_ALREADY_DEFINED = 4116
    HSA_STATUS_ERROR_VARIABLE_UNDEFINED = 4117
    HSA_STATUS_ERROR_EXCEPTION = 4118
    HSA_STATUS_ERROR_INVALID_CODE_SYMBOL = 4120
    HSA_STATUS_ERROR_INVALID_EXECUTABLE_SYMBOL = 4121
    HSA_STATUS_ERROR_INVALID_FILE = 4128
    HSA_STATUS_ERROR_INVALID_CODE_OBJECT_READER = 4129
    HSA_STATUS_ERROR_INVALID_CACHE = 4130
    HSA_STATUS_ERROR_INVALID_WAVEFRONT = 4131
    HSA_STATUS_ERROR_INVALID_SIGNAL_GROUP = 4132
    HSA_STATUS_ERROR_INVALID_RUNTIME_STATE = 4133
    HSA_STATUS_ERROR_FATAL = 4134
end

function hsa_status_string(status, status_string)
    ccall((:hsa_status_string, libhsaruntime), hsa_status_t, (hsa_status_t, Ptr{Ptr{Cchar}}), status, status_string)
end

struct hsa_dim3_s
    x::UInt32
    y::UInt32
    z::UInt32
end

const hsa_dim3_t = hsa_dim3_s

@cenum hsa_access_permission_t::UInt32 begin
    HSA_ACCESS_PERMISSION_RO = 1
    HSA_ACCESS_PERMISSION_WO = 2
    HSA_ACCESS_PERMISSION_RW = 3
end

const hsa_file_t = Cint

# no prototype is found for this function at hsa.h:359:22, please use with caution
function hsa_init()
    ccall((:hsa_init, libhsaruntime), hsa_status_t, ())
end

# no prototype is found for this function at hsa.h:381:22, please use with caution
function hsa_shut_down()
    ccall((:hsa_shut_down, libhsaruntime), hsa_status_t, ())
end

@cenum hsa_endianness_t::UInt32 begin
    HSA_ENDIANNESS_LITTLE = 0
    HSA_ENDIANNESS_BIG = 1
end

@cenum hsa_machine_model_t::UInt32 begin
    HSA_MACHINE_MODEL_SMALL = 0
    HSA_MACHINE_MODEL_LARGE = 1
end

@cenum hsa_profile_t::UInt32 begin
    HSA_PROFILE_BASE = 0
    HSA_PROFILE_FULL = 1
end

@cenum hsa_system_info_t::UInt32 begin
    HSA_SYSTEM_INFO_VERSION_MAJOR = 0
    HSA_SYSTEM_INFO_VERSION_MINOR = 1
    HSA_SYSTEM_INFO_TIMESTAMP = 2
    HSA_SYSTEM_INFO_TIMESTAMP_FREQUENCY = 3
    HSA_SYSTEM_INFO_SIGNAL_MAX_WAIT = 4
    HSA_SYSTEM_INFO_ENDIANNESS = 5
    HSA_SYSTEM_INFO_MACHINE_MODEL = 6
    HSA_SYSTEM_INFO_EXTENSIONS = 7
    HSA_AMD_SYSTEM_INFO_BUILD_VERSION = 512
end

function hsa_system_get_info(attribute, value)
    ccall((:hsa_system_get_info, libhsaruntime), hsa_status_t, (hsa_system_info_t, Ptr{Cvoid}), attribute, value)
end

@cenum hsa_extension_t::UInt32 begin
    HSA_EXTENSION_FINALIZER = 0
    HSA_EXTENSION_IMAGES = 1
    HSA_EXTENSION_PERFORMANCE_COUNTERS = 2
    HSA_EXTENSION_PROFILING_EVENTS = 3
    HSA_EXTENSION_STD_LAST = 3
    HSA_AMD_FIRST_EXTENSION = 512
    HSA_EXTENSION_AMD_PROFILER = 512
    HSA_EXTENSION_AMD_LOADER = 513
    HSA_EXTENSION_AMD_AQLPROFILE = 514
    HSA_AMD_LAST_EXTENSION = 514
end

function hsa_extension_get_name(extension, name)
    ccall((:hsa_extension_get_name, libhsaruntime), hsa_status_t, (UInt16, Ptr{Ptr{Cchar}}), extension, name)
end

function hsa_system_extension_supported(extension, version_major, version_minor, result)
    ccall((:hsa_system_extension_supported, libhsaruntime), hsa_status_t, (UInt16, UInt16, UInt16, Ptr{Bool}), extension, version_major, version_minor, result)
end

function hsa_system_major_extension_supported(extension, version_major, version_minor, result)
    ccall((:hsa_system_major_extension_supported, libhsaruntime), hsa_status_t, (UInt16, UInt16, Ptr{UInt16}, Ptr{Bool}), extension, version_major, version_minor, result)
end

function hsa_system_get_extension_table(extension, version_major, version_minor, table)
    ccall((:hsa_system_get_extension_table, libhsaruntime), hsa_status_t, (UInt16, UInt16, UInt16, Ptr{Cvoid}), extension, version_major, version_minor, table)
end

function hsa_system_get_major_extension_table(extension, version_major, table_length, table)
    ccall((:hsa_system_get_major_extension_table, libhsaruntime), hsa_status_t, (UInt16, UInt16, Csize_t, Ptr{Cvoid}), extension, version_major, table_length, table)
end

struct hsa_agent_s
    handle::UInt64
end

const hsa_agent_t = hsa_agent_s

@cenum hsa_agent_feature_t::UInt32 begin
    HSA_AGENT_FEATURE_KERNEL_DISPATCH = 1
    HSA_AGENT_FEATURE_AGENT_DISPATCH = 2
end

@cenum hsa_device_type_t::UInt32 begin
    HSA_DEVICE_TYPE_CPU = 0
    HSA_DEVICE_TYPE_GPU = 1
    HSA_DEVICE_TYPE_DSP = 2
end

@cenum hsa_default_float_rounding_mode_t::UInt32 begin
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_DEFAULT = 0
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_ZERO = 1
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_NEAR = 2
end

@cenum hsa_agent_info_t::UInt32 begin
    HSA_AGENT_INFO_NAME = 0
    HSA_AGENT_INFO_VENDOR_NAME = 1
    HSA_AGENT_INFO_FEATURE = 2
    HSA_AGENT_INFO_MACHINE_MODEL = 3
    HSA_AGENT_INFO_PROFILE = 4
    HSA_AGENT_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 5
    HSA_AGENT_INFO_BASE_PROFILE_DEFAULT_FLOAT_ROUNDING_MODES = 23
    HSA_AGENT_INFO_FAST_F16_OPERATION = 24
    HSA_AGENT_INFO_WAVEFRONT_SIZE = 6
    HSA_AGENT_INFO_WORKGROUP_MAX_DIM = 7
    HSA_AGENT_INFO_WORKGROUP_MAX_SIZE = 8
    HSA_AGENT_INFO_GRID_MAX_DIM = 9
    HSA_AGENT_INFO_GRID_MAX_SIZE = 10
    HSA_AGENT_INFO_FBARRIER_MAX_SIZE = 11
    HSA_AGENT_INFO_QUEUES_MAX = 12
    HSA_AGENT_INFO_QUEUE_MIN_SIZE = 13
    HSA_AGENT_INFO_QUEUE_MAX_SIZE = 14
    HSA_AGENT_INFO_QUEUE_TYPE = 15
    HSA_AGENT_INFO_NODE = 16
    HSA_AGENT_INFO_DEVICE = 17
    HSA_AGENT_INFO_CACHE_SIZE = 18
    HSA_AGENT_INFO_ISA = 19
    HSA_AGENT_INFO_EXTENSIONS = 20
    HSA_AGENT_INFO_VERSION_MAJOR = 21
    HSA_AGENT_INFO_VERSION_MINOR = 22
end

function hsa_agent_get_info(agent, attribute, value)
    ccall((:hsa_agent_get_info, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ptr{Cvoid}), agent, attribute, value)
end

function hsa_iterate_agents(callback, data)
    ccall((:hsa_iterate_agents, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), callback, data)
end

@cenum hsa_exception_policy_t::UInt32 begin
    HSA_EXCEPTION_POLICY_BREAK = 1
    HSA_EXCEPTION_POLICY_DETECT = 2
end

function hsa_agent_get_exception_policies(agent, profile, mask)
    ccall((:hsa_agent_get_exception_policies, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_profile_t, Ptr{UInt16}), agent, profile, mask)
end

struct hsa_cache_s
    handle::UInt64
end

const hsa_cache_t = hsa_cache_s

@cenum hsa_cache_info_t::UInt32 begin
    HSA_CACHE_INFO_NAME_LENGTH = 0
    HSA_CACHE_INFO_NAME = 1
    HSA_CACHE_INFO_LEVEL = 2
    HSA_CACHE_INFO_SIZE = 3
end

function hsa_cache_get_info(cache, attribute, value)
    ccall((:hsa_cache_get_info, libhsaruntime), hsa_status_t, (hsa_cache_t, hsa_cache_info_t, Ptr{Cvoid}), cache, attribute, value)
end

function hsa_agent_iterate_caches(agent, callback, data)
    ccall((:hsa_agent_iterate_caches, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_agent_extension_supported(extension, agent, version_major, version_minor, result)
    ccall((:hsa_agent_extension_supported, libhsaruntime), hsa_status_t, (UInt16, hsa_agent_t, UInt16, UInt16, Ptr{Bool}), extension, agent, version_major, version_minor, result)
end

function hsa_agent_major_extension_supported(extension, agent, version_major, version_minor, result)
    ccall((:hsa_agent_major_extension_supported, libhsaruntime), hsa_status_t, (UInt16, hsa_agent_t, UInt16, Ptr{UInt16}, Ptr{Bool}), extension, agent, version_major, version_minor, result)
end

struct hsa_signal_s
    handle::UInt64
end

const hsa_signal_t = hsa_signal_s

const hsa_signal_value_t = Int64

function hsa_signal_create(initial_value, num_consumers, consumers, signal)
    ccall((:hsa_signal_create, libhsaruntime), hsa_status_t, (hsa_signal_value_t, UInt32, Ptr{hsa_agent_t}, Ptr{hsa_signal_t}), initial_value, num_consumers, consumers, signal)
end

function hsa_signal_destroy(signal)
    ccall((:hsa_signal_destroy, libhsaruntime), hsa_status_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_scacquire(signal)
    ccall((:hsa_signal_load_scacquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_relaxed(signal)
    ccall((:hsa_signal_load_relaxed, libhsaruntime), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_load_acquire(signal)
    ccall((:hsa_signal_load_acquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t,), signal)
end

function hsa_signal_store_relaxed(signal, value)
    ccall((:hsa_signal_store_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_store_screlease(signal, value)
    ccall((:hsa_signal_store_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_store_release(signal, value)
    ccall((:hsa_signal_store_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_silent_store_relaxed(signal, value)
    ccall((:hsa_signal_silent_store_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_silent_store_screlease(signal, value)
    ccall((:hsa_signal_silent_store_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_scacq_screl(signal, value)
    ccall((:hsa_signal_exchange_scacq_screl, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_acq_rel(signal, value)
    ccall((:hsa_signal_exchange_acq_rel, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_scacquire(signal, value)
    ccall((:hsa_signal_exchange_scacquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_acquire(signal, value)
    ccall((:hsa_signal_exchange_acquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_relaxed(signal, value)
    ccall((:hsa_signal_exchange_relaxed, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_screlease(signal, value)
    ccall((:hsa_signal_exchange_screlease, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_exchange_release(signal, value)
    ccall((:hsa_signal_exchange_release, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_cas_scacq_screl(signal, expected, value)
    ccall((:hsa_signal_cas_scacq_screl, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_acq_rel(signal, expected, value)
    ccall((:hsa_signal_cas_acq_rel, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_scacquire(signal, expected, value)
    ccall((:hsa_signal_cas_scacquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_acquire(signal, expected, value)
    ccall((:hsa_signal_cas_acquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_relaxed(signal, expected, value)
    ccall((:hsa_signal_cas_relaxed, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_screlease(signal, expected, value)
    ccall((:hsa_signal_cas_screlease, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_cas_release(signal, expected, value)
    ccall((:hsa_signal_cas_release, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_value_t, hsa_signal_value_t), signal, expected, value)
end

function hsa_signal_add_scacq_screl(signal, value)
    ccall((:hsa_signal_add_scacq_screl, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_acq_rel(signal, value)
    ccall((:hsa_signal_add_acq_rel, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_scacquire(signal, value)
    ccall((:hsa_signal_add_scacquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_acquire(signal, value)
    ccall((:hsa_signal_add_acquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_relaxed(signal, value)
    ccall((:hsa_signal_add_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_screlease(signal, value)
    ccall((:hsa_signal_add_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_add_release(signal, value)
    ccall((:hsa_signal_add_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_scacq_screl(signal, value)
    ccall((:hsa_signal_subtract_scacq_screl, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_acq_rel(signal, value)
    ccall((:hsa_signal_subtract_acq_rel, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_scacquire(signal, value)
    ccall((:hsa_signal_subtract_scacquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_acquire(signal, value)
    ccall((:hsa_signal_subtract_acquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_relaxed(signal, value)
    ccall((:hsa_signal_subtract_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_screlease(signal, value)
    ccall((:hsa_signal_subtract_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_subtract_release(signal, value)
    ccall((:hsa_signal_subtract_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_scacq_screl(signal, value)
    ccall((:hsa_signal_and_scacq_screl, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_acq_rel(signal, value)
    ccall((:hsa_signal_and_acq_rel, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_scacquire(signal, value)
    ccall((:hsa_signal_and_scacquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_acquire(signal, value)
    ccall((:hsa_signal_and_acquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_relaxed(signal, value)
    ccall((:hsa_signal_and_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_screlease(signal, value)
    ccall((:hsa_signal_and_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_and_release(signal, value)
    ccall((:hsa_signal_and_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_scacq_screl(signal, value)
    ccall((:hsa_signal_or_scacq_screl, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_acq_rel(signal, value)
    ccall((:hsa_signal_or_acq_rel, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_scacquire(signal, value)
    ccall((:hsa_signal_or_scacquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_acquire(signal, value)
    ccall((:hsa_signal_or_acquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_relaxed(signal, value)
    ccall((:hsa_signal_or_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_screlease(signal, value)
    ccall((:hsa_signal_or_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_or_release(signal, value)
    ccall((:hsa_signal_or_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_scacq_screl(signal, value)
    ccall((:hsa_signal_xor_scacq_screl, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_acq_rel(signal, value)
    ccall((:hsa_signal_xor_acq_rel, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_scacquire(signal, value)
    ccall((:hsa_signal_xor_scacquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_acquire(signal, value)
    ccall((:hsa_signal_xor_acquire, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_relaxed(signal, value)
    ccall((:hsa_signal_xor_relaxed, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_screlease(signal, value)
    ccall((:hsa_signal_xor_screlease, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

function hsa_signal_xor_release(signal, value)
    ccall((:hsa_signal_xor_release, libhsaruntime), Cvoid, (hsa_signal_t, hsa_signal_value_t), signal, value)
end

@cenum hsa_signal_condition_t::UInt32 begin
    HSA_SIGNAL_CONDITION_EQ = 0
    HSA_SIGNAL_CONDITION_NE = 1
    HSA_SIGNAL_CONDITION_LT = 2
    HSA_SIGNAL_CONDITION_GTE = 3
end

@cenum hsa_wait_state_t::UInt32 begin
    HSA_WAIT_STATE_BLOCKED = 0
    HSA_WAIT_STATE_ACTIVE = 1
end

function hsa_signal_wait_scacquire(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_scacquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function hsa_signal_wait_relaxed(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_relaxed, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

function hsa_signal_wait_acquire(signal, condition, compare_value, timeout_hint, wait_state_hint)
    ccall((:hsa_signal_wait_acquire, libhsaruntime), hsa_signal_value_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, UInt64, hsa_wait_state_t), signal, condition, compare_value, timeout_hint, wait_state_hint)
end

struct hsa_signal_group_s
    handle::UInt64
end

const hsa_signal_group_t = hsa_signal_group_s

function hsa_signal_group_create(num_signals, signals, num_consumers, consumers, signal_group)
    ccall((:hsa_signal_group_create, libhsaruntime), hsa_status_t, (UInt32, Ptr{hsa_signal_t}, UInt32, Ptr{hsa_agent_t}, Ptr{hsa_signal_group_t}), num_signals, signals, num_consumers, consumers, signal_group)
end

function hsa_signal_group_destroy(signal_group)
    ccall((:hsa_signal_group_destroy, libhsaruntime), hsa_status_t, (hsa_signal_group_t,), signal_group)
end

function hsa_signal_group_wait_any_scacquire(signal_group, conditions, compare_values, wait_state_hint, signal, value)
    ccall((:hsa_signal_group_wait_any_scacquire, libhsaruntime), hsa_status_t, (hsa_signal_group_t, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, hsa_wait_state_t, Ptr{hsa_signal_t}, Ptr{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

function hsa_signal_group_wait_any_relaxed(signal_group, conditions, compare_values, wait_state_hint, signal, value)
    ccall((:hsa_signal_group_wait_any_relaxed, libhsaruntime), hsa_status_t, (hsa_signal_group_t, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, hsa_wait_state_t, Ptr{hsa_signal_t}, Ptr{hsa_signal_value_t}), signal_group, conditions, compare_values, wait_state_hint, signal, value)
end

struct hsa_region_s
    handle::UInt64
end

const hsa_region_t = hsa_region_s

@cenum hsa_queue_type_t::UInt32 begin
    HSA_QUEUE_TYPE_MULTI = 0
    HSA_QUEUE_TYPE_SINGLE = 1
    HSA_QUEUE_TYPE_COOPERATIVE = 2
end

const hsa_queue_type32_t = UInt32

@cenum hsa_queue_feature_t::UInt32 begin
    HSA_QUEUE_FEATURE_KERNEL_DISPATCH = 1
    HSA_QUEUE_FEATURE_AGENT_DISPATCH = 2
end

struct hsa_queue_s
    type::hsa_queue_type32_t
    features::UInt32
    base_address::Ptr{Cvoid}
    doorbell_signal::hsa_signal_t
    size::UInt32
    reserved1::UInt32
    id::UInt64
end

const hsa_queue_t = hsa_queue_s

function hsa_queue_create(agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
    ccall((:hsa_queue_create, libhsaruntime), hsa_status_t, (hsa_agent_t, UInt32, hsa_queue_type32_t, Ptr{Cvoid}, Ptr{Cvoid}, UInt32, UInt32, Ptr{Ptr{hsa_queue_t}}), agent, size, type, callback, data, private_segment_size, group_segment_size, queue)
end

function hsa_soft_queue_create(region, size, type, features, doorbell_signal, queue)
    ccall((:hsa_soft_queue_create, libhsaruntime), hsa_status_t, (hsa_region_t, UInt32, hsa_queue_type32_t, UInt32, hsa_signal_t, Ptr{Ptr{hsa_queue_t}}), region, size, type, features, doorbell_signal, queue)
end

function hsa_queue_destroy(queue)
    ccall((:hsa_queue_destroy, libhsaruntime), hsa_status_t, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_inactivate(queue)
    ccall((:hsa_queue_inactivate, libhsaruntime), hsa_status_t, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_acquire(queue)
    ccall((:hsa_queue_load_read_index_acquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_scacquire(queue)
    ccall((:hsa_queue_load_read_index_scacquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_read_index_relaxed(queue)
    ccall((:hsa_queue_load_read_index_relaxed, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_acquire(queue)
    ccall((:hsa_queue_load_write_index_acquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_scacquire(queue)
    ccall((:hsa_queue_load_write_index_scacquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_load_write_index_relaxed(queue)
    ccall((:hsa_queue_load_write_index_relaxed, libhsaruntime), UInt64, (Ptr{hsa_queue_t},), queue)
end

function hsa_queue_store_write_index_relaxed(queue, value)
    ccall((:hsa_queue_store_write_index_relaxed, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_write_index_release(queue, value)
    ccall((:hsa_queue_store_write_index_release, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_write_index_screlease(queue, value)
    ccall((:hsa_queue_store_write_index_screlease, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_cas_write_index_acq_rel(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_acq_rel, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_scacq_screl(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_scacq_screl, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_acquire(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_acquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_scacquire(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_scacquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_relaxed(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_relaxed, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_release(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_release, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_cas_write_index_screlease(queue, expected, value)
    ccall((:hsa_queue_cas_write_index_screlease, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64, UInt64), queue, expected, value)
end

function hsa_queue_add_write_index_acq_rel(queue, value)
    ccall((:hsa_queue_add_write_index_acq_rel, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_scacq_screl(queue, value)
    ccall((:hsa_queue_add_write_index_scacq_screl, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_acquire(queue, value)
    ccall((:hsa_queue_add_write_index_acquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_scacquire(queue, value)
    ccall((:hsa_queue_add_write_index_scacquire, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_relaxed(queue, value)
    ccall((:hsa_queue_add_write_index_relaxed, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_release(queue, value)
    ccall((:hsa_queue_add_write_index_release, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_add_write_index_screlease(queue, value)
    ccall((:hsa_queue_add_write_index_screlease, libhsaruntime), UInt64, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_relaxed(queue, value)
    ccall((:hsa_queue_store_read_index_relaxed, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_release(queue, value)
    ccall((:hsa_queue_store_read_index_release, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

function hsa_queue_store_read_index_screlease(queue, value)
    ccall((:hsa_queue_store_read_index_screlease, libhsaruntime), Cvoid, (Ptr{hsa_queue_t}, UInt64), queue, value)
end

@cenum hsa_packet_type_t::UInt32 begin
    HSA_PACKET_TYPE_VENDOR_SPECIFIC = 0
    HSA_PACKET_TYPE_INVALID = 1
    HSA_PACKET_TYPE_KERNEL_DISPATCH = 2
    HSA_PACKET_TYPE_BARRIER_AND = 3
    HSA_PACKET_TYPE_AGENT_DISPATCH = 4
    HSA_PACKET_TYPE_BARRIER_OR = 5
end

@cenum hsa_fence_scope_t::UInt32 begin
    HSA_FENCE_SCOPE_NONE = 0
    HSA_FENCE_SCOPE_AGENT = 1
    HSA_FENCE_SCOPE_SYSTEM = 2
end

@cenum hsa_packet_header_t::UInt32 begin
    HSA_PACKET_HEADER_TYPE = 0
    HSA_PACKET_HEADER_BARRIER = 8
    HSA_PACKET_HEADER_SCACQUIRE_FENCE_SCOPE = 9
    HSA_PACKET_HEADER_ACQUIRE_FENCE_SCOPE = 9
    HSA_PACKET_HEADER_SCRELEASE_FENCE_SCOPE = 11
    HSA_PACKET_HEADER_RELEASE_FENCE_SCOPE = 11
end

@cenum hsa_packet_header_width_t::UInt32 begin
    HSA_PACKET_HEADER_WIDTH_TYPE = 8
    HSA_PACKET_HEADER_WIDTH_BARRIER = 1
    HSA_PACKET_HEADER_WIDTH_SCACQUIRE_FENCE_SCOPE = 2
    HSA_PACKET_HEADER_WIDTH_ACQUIRE_FENCE_SCOPE = 2
    HSA_PACKET_HEADER_WIDTH_SCRELEASE_FENCE_SCOPE = 2
    HSA_PACKET_HEADER_WIDTH_RELEASE_FENCE_SCOPE = 2
end

@cenum hsa_kernel_dispatch_packet_setup_t::UInt32 begin
    HSA_KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS = 0
end

@cenum hsa_kernel_dispatch_packet_setup_width_t::UInt32 begin
    HSA_KERNEL_DISPATCH_PACKET_SETUP_WIDTH_DIMENSIONS = 2
end

struct hsa_kernel_dispatch_packet_s
    header::UInt16
    setup::UInt16
    workgroup_size_x::UInt16
    workgroup_size_y::UInt16
    workgroup_size_z::UInt16
    reserved0::UInt16
    grid_size_x::UInt32
    grid_size_y::UInt32
    grid_size_z::UInt32
    private_segment_size::UInt32
    group_segment_size::UInt32
    kernel_object::UInt64
    kernarg_address::Ptr{Cvoid}
    reserved2::UInt64
    completion_signal::hsa_signal_t
end

const hsa_kernel_dispatch_packet_t = hsa_kernel_dispatch_packet_s

struct hsa_agent_dispatch_packet_s
    header::UInt16
    type::UInt16
    reserved0::UInt32
    return_address::Ptr{Cvoid}
    arg::NTuple{4, UInt64}
    reserved2::UInt64
    completion_signal::hsa_signal_t
end

const hsa_agent_dispatch_packet_t = hsa_agent_dispatch_packet_s

struct hsa_barrier_and_packet_s
    header::UInt16
    reserved0::UInt16
    reserved1::UInt32
    dep_signal::NTuple{5, hsa_signal_t}
    reserved2::UInt64
    completion_signal::hsa_signal_t
end

const hsa_barrier_and_packet_t = hsa_barrier_and_packet_s

struct hsa_barrier_or_packet_s
    header::UInt16
    reserved0::UInt16
    reserved1::UInt32
    dep_signal::NTuple{5, hsa_signal_t}
    reserved2::UInt64
    completion_signal::hsa_signal_t
end

const hsa_barrier_or_packet_t = hsa_barrier_or_packet_s

@cenum hsa_region_segment_t::UInt32 begin
    HSA_REGION_SEGMENT_GLOBAL = 0
    HSA_REGION_SEGMENT_READONLY = 1
    HSA_REGION_SEGMENT_PRIVATE = 2
    HSA_REGION_SEGMENT_GROUP = 3
    HSA_REGION_SEGMENT_KERNARG = 4
end

@cenum hsa_region_global_flag_t::UInt32 begin
    HSA_REGION_GLOBAL_FLAG_KERNARG = 1
    HSA_REGION_GLOBAL_FLAG_FINE_GRAINED = 2
    HSA_REGION_GLOBAL_FLAG_COARSE_GRAINED = 4
end

@cenum hsa_region_info_t::UInt32 begin
    HSA_REGION_INFO_SEGMENT = 0
    HSA_REGION_INFO_GLOBAL_FLAGS = 1
    HSA_REGION_INFO_SIZE = 2
    HSA_REGION_INFO_ALLOC_MAX_SIZE = 4
    HSA_REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE = 8
    HSA_REGION_INFO_RUNTIME_ALLOC_ALLOWED = 5
    HSA_REGION_INFO_RUNTIME_ALLOC_GRANULE = 6
    HSA_REGION_INFO_RUNTIME_ALLOC_ALIGNMENT = 7
end

function hsa_region_get_info(region, attribute, value)
    ccall((:hsa_region_get_info, libhsaruntime), hsa_status_t, (hsa_region_t, hsa_region_info_t, Ptr{Cvoid}), region, attribute, value)
end

function hsa_agent_iterate_regions(agent, callback, data)
    ccall((:hsa_agent_iterate_regions, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_memory_allocate(region, size, ptr)
    ccall((:hsa_memory_allocate, libhsaruntime), hsa_status_t, (hsa_region_t, Csize_t, Ptr{Ptr{Cvoid}}), region, size, ptr)
end

function hsa_memory_free(ptr)
    ccall((:hsa_memory_free, libhsaruntime), hsa_status_t, (Ptr{Cvoid},), ptr)
end

function hsa_memory_copy(dst, src, size)
    ccall((:hsa_memory_copy, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), dst, src, size)
end

function hsa_memory_assign_agent(ptr, agent, access)
    ccall((:hsa_memory_assign_agent, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, hsa_agent_t, hsa_access_permission_t), ptr, agent, access)
end

function hsa_memory_register(ptr, size)
    ccall((:hsa_memory_register, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t), ptr, size)
end

function hsa_memory_deregister(ptr, size)
    ccall((:hsa_memory_deregister, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t), ptr, size)
end

struct hsa_isa_s
    handle::UInt64
end

const hsa_isa_t = hsa_isa_s

function hsa_isa_from_name(name, isa)
    ccall((:hsa_isa_from_name, libhsaruntime), hsa_status_t, (Ptr{Cchar}, Ptr{hsa_isa_t}), name, isa)
end

function hsa_agent_iterate_isas(agent, callback, data)
    ccall((:hsa_agent_iterate_isas, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

@cenum hsa_isa_info_t::UInt32 begin
    HSA_ISA_INFO_NAME_LENGTH = 0
    HSA_ISA_INFO_NAME = 1
    HSA_ISA_INFO_CALL_CONVENTION_COUNT = 2
    HSA_ISA_INFO_CALL_CONVENTION_INFO_WAVEFRONT_SIZE = 3
    HSA_ISA_INFO_CALL_CONVENTION_INFO_WAVEFRONTS_PER_COMPUTE_UNIT = 4
    HSA_ISA_INFO_MACHINE_MODELS = 5
    HSA_ISA_INFO_PROFILES = 6
    HSA_ISA_INFO_DEFAULT_FLOAT_ROUNDING_MODES = 7
    HSA_ISA_INFO_BASE_PROFILE_DEFAULT_FLOAT_ROUNDING_MODES = 8
    HSA_ISA_INFO_FAST_F16_OPERATION = 9
    HSA_ISA_INFO_WORKGROUP_MAX_DIM = 12
    HSA_ISA_INFO_WORKGROUP_MAX_SIZE = 13
    HSA_ISA_INFO_GRID_MAX_DIM = 14
    HSA_ISA_INFO_GRID_MAX_SIZE = 16
    HSA_ISA_INFO_FBARRIER_MAX_SIZE = 17
end

function hsa_isa_get_info(isa, attribute, index, value)
    ccall((:hsa_isa_get_info, libhsaruntime), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, UInt32, Ptr{Cvoid}), isa, attribute, index, value)
end

function hsa_isa_get_info_alt(isa, attribute, value)
    ccall((:hsa_isa_get_info_alt, libhsaruntime), hsa_status_t, (hsa_isa_t, hsa_isa_info_t, Ptr{Cvoid}), isa, attribute, value)
end

function hsa_isa_get_exception_policies(isa, profile, mask)
    ccall((:hsa_isa_get_exception_policies, libhsaruntime), hsa_status_t, (hsa_isa_t, hsa_profile_t, Ptr{UInt16}), isa, profile, mask)
end

@cenum hsa_fp_type_t::UInt32 begin
    HSA_FP_TYPE_16 = 1
    HSA_FP_TYPE_32 = 2
    HSA_FP_TYPE_64 = 4
end

@cenum hsa_flush_mode_t::UInt32 begin
    HSA_FLUSH_MODE_FTZ = 1
    HSA_FLUSH_MODE_NON_FTZ = 2
end

@cenum hsa_round_method_t::UInt32 begin
    HSA_ROUND_METHOD_SINGLE = 1
    HSA_ROUND_METHOD_DOUBLE = 2
end

function hsa_isa_get_round_method(isa, fp_type, flush_mode, round_method)
    ccall((:hsa_isa_get_round_method, libhsaruntime), hsa_status_t, (hsa_isa_t, hsa_fp_type_t, hsa_flush_mode_t, Ptr{hsa_round_method_t}), isa, fp_type, flush_mode, round_method)
end

struct hsa_wavefront_s
    handle::UInt64
end

const hsa_wavefront_t = hsa_wavefront_s

@cenum hsa_wavefront_info_t::UInt32 begin
    HSA_WAVEFRONT_INFO_SIZE = 0
end

function hsa_wavefront_get_info(wavefront, attribute, value)
    ccall((:hsa_wavefront_get_info, libhsaruntime), hsa_status_t, (hsa_wavefront_t, hsa_wavefront_info_t, Ptr{Cvoid}), wavefront, attribute, value)
end

function hsa_isa_iterate_wavefronts(isa, callback, data)
    ccall((:hsa_isa_iterate_wavefronts, libhsaruntime), hsa_status_t, (hsa_isa_t, Ptr{Cvoid}, Ptr{Cvoid}), isa, callback, data)
end

function hsa_isa_compatible(code_object_isa, agent_isa, result)
    ccall((:hsa_isa_compatible, libhsaruntime), hsa_status_t, (hsa_isa_t, hsa_isa_t, Ptr{Bool}), code_object_isa, agent_isa, result)
end

struct hsa_code_object_reader_s
    handle::UInt64
end

const hsa_code_object_reader_t = hsa_code_object_reader_s

function hsa_code_object_reader_create_from_file(file, code_object_reader)
    ccall((:hsa_code_object_reader_create_from_file, libhsaruntime), hsa_status_t, (hsa_file_t, Ptr{hsa_code_object_reader_t}), file, code_object_reader)
end

function hsa_code_object_reader_create_from_memory(code_object, size, code_object_reader)
    ccall((:hsa_code_object_reader_create_from_memory, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_code_object_reader_t}), code_object, size, code_object_reader)
end

function hsa_code_object_reader_destroy(code_object_reader)
    ccall((:hsa_code_object_reader_destroy, libhsaruntime), hsa_status_t, (hsa_code_object_reader_t,), code_object_reader)
end

struct hsa_executable_s
    handle::UInt64
end

const hsa_executable_t = hsa_executable_s

@cenum hsa_executable_state_t::UInt32 begin
    HSA_EXECUTABLE_STATE_UNFROZEN = 0
    HSA_EXECUTABLE_STATE_FROZEN = 1
end

function hsa_executable_create(profile, executable_state, options, executable)
    ccall((:hsa_executable_create, libhsaruntime), hsa_status_t, (hsa_profile_t, hsa_executable_state_t, Ptr{Cchar}, Ptr{hsa_executable_t}), profile, executable_state, options, executable)
end

function hsa_executable_create_alt(profile, default_float_rounding_mode, options, executable)
    ccall((:hsa_executable_create_alt, libhsaruntime), hsa_status_t, (hsa_profile_t, hsa_default_float_rounding_mode_t, Ptr{Cchar}, Ptr{hsa_executable_t}), profile, default_float_rounding_mode, options, executable)
end

function hsa_executable_destroy(executable)
    ccall((:hsa_executable_destroy, libhsaruntime), hsa_status_t, (hsa_executable_t,), executable)
end

struct hsa_loaded_code_object_s
    handle::UInt64
end

const hsa_loaded_code_object_t = hsa_loaded_code_object_s

function hsa_executable_load_program_code_object(executable, code_object_reader, options, loaded_code_object)
    ccall((:hsa_executable_load_program_code_object, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_code_object_reader_t, Ptr{Cchar}, Ptr{hsa_loaded_code_object_t}), executable, code_object_reader, options, loaded_code_object)
end

function hsa_executable_load_agent_code_object(executable, agent, code_object_reader, options, loaded_code_object)
    ccall((:hsa_executable_load_agent_code_object, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_reader_t, Ptr{Cchar}, Ptr{hsa_loaded_code_object_t}), executable, agent, code_object_reader, options, loaded_code_object)
end

function hsa_executable_freeze(executable, options)
    ccall((:hsa_executable_freeze, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cchar}), executable, options)
end

@cenum hsa_executable_info_t::UInt32 begin
    HSA_EXECUTABLE_INFO_PROFILE = 1
    HSA_EXECUTABLE_INFO_STATE = 2
    HSA_EXECUTABLE_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 3
end

function hsa_executable_get_info(executable, attribute, value)
    ccall((:hsa_executable_get_info, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_executable_info_t, Ptr{Cvoid}), executable, attribute, value)
end

function hsa_executable_global_variable_define(executable, variable_name, address)
    ccall((:hsa_executable_global_variable_define, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cchar}, Ptr{Cvoid}), executable, variable_name, address)
end

function hsa_executable_agent_global_variable_define(executable, agent, variable_name, address)
    ccall((:hsa_executable_agent_global_variable_define, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_agent_t, Ptr{Cchar}, Ptr{Cvoid}), executable, agent, variable_name, address)
end

function hsa_executable_readonly_variable_define(executable, agent, variable_name, address)
    ccall((:hsa_executable_readonly_variable_define, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_agent_t, Ptr{Cchar}, Ptr{Cvoid}), executable, agent, variable_name, address)
end

function hsa_executable_validate(executable, result)
    ccall((:hsa_executable_validate, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{UInt32}), executable, result)
end

function hsa_executable_validate_alt(executable, options, result)
    ccall((:hsa_executable_validate_alt, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cchar}, Ptr{UInt32}), executable, options, result)
end

struct hsa_executable_symbol_s
    handle::UInt64
end

const hsa_executable_symbol_t = hsa_executable_symbol_s

function hsa_executable_get_symbol(executable, module_name, symbol_name, agent, call_convention, symbol)
    ccall((:hsa_executable_get_symbol, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cchar}, Ptr{Cchar}, hsa_agent_t, Int32, Ptr{hsa_executable_symbol_t}), executable, module_name, symbol_name, agent, call_convention, symbol)
end

function hsa_executable_get_symbol_by_name(executable, symbol_name, agent, symbol)
    ccall((:hsa_executable_get_symbol_by_name, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cchar}, Ptr{hsa_agent_t}, Ptr{hsa_executable_symbol_t}), executable, symbol_name, agent, symbol)
end

@cenum hsa_symbol_kind_t::UInt32 begin
    HSA_SYMBOL_KIND_VARIABLE = 0
    HSA_SYMBOL_KIND_KERNEL = 1
    HSA_SYMBOL_KIND_INDIRECT_FUNCTION = 2
end

@cenum hsa_symbol_linkage_t::UInt32 begin
    HSA_SYMBOL_LINKAGE_MODULE = 0
    HSA_SYMBOL_LINKAGE_PROGRAM = 1
end

@cenum hsa_variable_allocation_t::UInt32 begin
    HSA_VARIABLE_ALLOCATION_AGENT = 0
    HSA_VARIABLE_ALLOCATION_PROGRAM = 1
end

@cenum hsa_variable_segment_t::UInt32 begin
    HSA_VARIABLE_SEGMENT_GLOBAL = 0
    HSA_VARIABLE_SEGMENT_READONLY = 1
end

@cenum hsa_executable_symbol_info_t::UInt32 begin
    HSA_EXECUTABLE_SYMBOL_INFO_TYPE = 0
    HSA_EXECUTABLE_SYMBOL_INFO_NAME_LENGTH = 1
    HSA_EXECUTABLE_SYMBOL_INFO_NAME = 2
    HSA_EXECUTABLE_SYMBOL_INFO_MODULE_NAME_LENGTH = 3
    HSA_EXECUTABLE_SYMBOL_INFO_MODULE_NAME = 4
    HSA_EXECUTABLE_SYMBOL_INFO_AGENT = 20
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ADDRESS = 21
    HSA_EXECUTABLE_SYMBOL_INFO_LINKAGE = 5
    HSA_EXECUTABLE_SYMBOL_INFO_IS_DEFINITION = 17
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ALLOCATION = 6
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_SEGMENT = 7
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ALIGNMENT = 8
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_SIZE = 9
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_IS_CONST = 10
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT = 22
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE = 11
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_ALIGNMENT = 12
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE = 13
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE = 14
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_DYNAMIC_CALLSTACK = 15
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_CALL_CONVENTION = 18
    HSA_EXECUTABLE_SYMBOL_INFO_INDIRECT_FUNCTION_OBJECT = 23
    HSA_EXECUTABLE_SYMBOL_INFO_INDIRECT_FUNCTION_CALL_CONVENTION = 16
end

function hsa_executable_symbol_get_info(executable_symbol, attribute, value)
    ccall((:hsa_executable_symbol_get_info, libhsaruntime), hsa_status_t, (hsa_executable_symbol_t, hsa_executable_symbol_info_t, Ptr{Cvoid}), executable_symbol, attribute, value)
end

function hsa_executable_iterate_symbols(executable, callback, data)
    ccall((:hsa_executable_iterate_symbols, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, callback, data)
end

function hsa_executable_iterate_agent_symbols(executable, agent, callback, data)
    ccall((:hsa_executable_iterate_agent_symbols, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, agent, callback, data)
end

function hsa_executable_iterate_program_symbols(executable, callback, data)
    ccall((:hsa_executable_iterate_program_symbols, libhsaruntime), hsa_status_t, (hsa_executable_t, Ptr{Cvoid}, Ptr{Cvoid}), executable, callback, data)
end

struct hsa_code_object_s
    handle::UInt64
end

const hsa_code_object_t = hsa_code_object_s

struct hsa_callback_data_s
    handle::UInt64
end

const hsa_callback_data_t = hsa_callback_data_s

function hsa_code_object_serialize(code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
    ccall((:hsa_code_object_serialize, libhsaruntime), hsa_status_t, (hsa_code_object_t, Ptr{Cvoid}, hsa_callback_data_t, Ptr{Cchar}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}), code_object, alloc_callback, callback_data, options, serialized_code_object, serialized_code_object_size)
end

function hsa_code_object_deserialize(serialized_code_object, serialized_code_object_size, options, code_object)
    ccall((:hsa_code_object_deserialize, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{Cchar}, Ptr{hsa_code_object_t}), serialized_code_object, serialized_code_object_size, options, code_object)
end

function hsa_code_object_destroy(code_object)
    ccall((:hsa_code_object_destroy, libhsaruntime), hsa_status_t, (hsa_code_object_t,), code_object)
end

@cenum hsa_code_object_type_t::UInt32 begin
    HSA_CODE_OBJECT_TYPE_PROGRAM = 0
end

@cenum hsa_code_object_info_t::UInt32 begin
    HSA_CODE_OBJECT_INFO_VERSION = 0
    HSA_CODE_OBJECT_INFO_TYPE = 1
    HSA_CODE_OBJECT_INFO_ISA = 2
    HSA_CODE_OBJECT_INFO_MACHINE_MODEL = 3
    HSA_CODE_OBJECT_INFO_PROFILE = 4
    HSA_CODE_OBJECT_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 5
end

function hsa_code_object_get_info(code_object, attribute, value)
    ccall((:hsa_code_object_get_info, libhsaruntime), hsa_status_t, (hsa_code_object_t, hsa_code_object_info_t, Ptr{Cvoid}), code_object, attribute, value)
end

function hsa_executable_load_code_object(executable, agent, code_object, options)
    ccall((:hsa_executable_load_code_object, libhsaruntime), hsa_status_t, (hsa_executable_t, hsa_agent_t, hsa_code_object_t, Ptr{Cchar}), executable, agent, code_object, options)
end

struct hsa_code_symbol_s
    handle::UInt64
end

const hsa_code_symbol_t = hsa_code_symbol_s

function hsa_code_object_get_symbol(code_object, symbol_name, symbol)
    ccall((:hsa_code_object_get_symbol, libhsaruntime), hsa_status_t, (hsa_code_object_t, Ptr{Cchar}, Ptr{hsa_code_symbol_t}), code_object, symbol_name, symbol)
end

function hsa_code_object_get_symbol_from_name(code_object, module_name, symbol_name, symbol)
    ccall((:hsa_code_object_get_symbol_from_name, libhsaruntime), hsa_status_t, (hsa_code_object_t, Ptr{Cchar}, Ptr{Cchar}, Ptr{hsa_code_symbol_t}), code_object, module_name, symbol_name, symbol)
end

@cenum hsa_code_symbol_info_t::UInt32 begin
    HSA_CODE_SYMBOL_INFO_TYPE = 0
    HSA_CODE_SYMBOL_INFO_NAME_LENGTH = 1
    HSA_CODE_SYMBOL_INFO_NAME = 2
    HSA_CODE_SYMBOL_INFO_MODULE_NAME_LENGTH = 3
    HSA_CODE_SYMBOL_INFO_MODULE_NAME = 4
    HSA_CODE_SYMBOL_INFO_LINKAGE = 5
    HSA_CODE_SYMBOL_INFO_IS_DEFINITION = 17
    HSA_CODE_SYMBOL_INFO_VARIABLE_ALLOCATION = 6
    HSA_CODE_SYMBOL_INFO_VARIABLE_SEGMENT = 7
    HSA_CODE_SYMBOL_INFO_VARIABLE_ALIGNMENT = 8
    HSA_CODE_SYMBOL_INFO_VARIABLE_SIZE = 9
    HSA_CODE_SYMBOL_INFO_VARIABLE_IS_CONST = 10
    HSA_CODE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE = 11
    HSA_CODE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_ALIGNMENT = 12
    HSA_CODE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE = 13
    HSA_CODE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE = 14
    HSA_CODE_SYMBOL_INFO_KERNEL_DYNAMIC_CALLSTACK = 15
    HSA_CODE_SYMBOL_INFO_KERNEL_CALL_CONVENTION = 18
    HSA_CODE_SYMBOL_INFO_INDIRECT_FUNCTION_CALL_CONVENTION = 16
end

function hsa_code_symbol_get_info(code_symbol, attribute, value)
    ccall((:hsa_code_symbol_get_info, libhsaruntime), hsa_status_t, (hsa_code_symbol_t, hsa_code_symbol_info_t, Ptr{Cvoid}), code_symbol, attribute, value)
end

function hsa_code_object_iterate_symbols(code_object, callback, data)
    ccall((:hsa_code_object_iterate_symbols, libhsaruntime), hsa_status_t, (hsa_code_object_t, Ptr{Cvoid}, Ptr{Cvoid}), code_object, callback, data)
end

@cenum var"##Ctag#317"::UInt32 begin
    HSA_EXT_STATUS_ERROR_IMAGE_FORMAT_UNSUPPORTED = 12288
    HSA_EXT_STATUS_ERROR_IMAGE_SIZE_UNSUPPORTED = 12289
    HSA_EXT_STATUS_ERROR_IMAGE_PITCH_UNSUPPORTED = 12290
    HSA_EXT_STATUS_ERROR_SAMPLER_DESCRIPTOR_UNSUPPORTED = 12291
end

@cenum var"##Ctag#318"::UInt32 begin
    HSA_EXT_AGENT_INFO_IMAGE_1D_MAX_ELEMENTS = 12288
    HSA_EXT_AGENT_INFO_IMAGE_1DA_MAX_ELEMENTS = 12289
    HSA_EXT_AGENT_INFO_IMAGE_1DB_MAX_ELEMENTS = 12290
    HSA_EXT_AGENT_INFO_IMAGE_2D_MAX_ELEMENTS = 12291
    HSA_EXT_AGENT_INFO_IMAGE_2DA_MAX_ELEMENTS = 12292
    HSA_EXT_AGENT_INFO_IMAGE_2DDEPTH_MAX_ELEMENTS = 12293
    HSA_EXT_AGENT_INFO_IMAGE_2DADEPTH_MAX_ELEMENTS = 12294
    HSA_EXT_AGENT_INFO_IMAGE_3D_MAX_ELEMENTS = 12295
    HSA_EXT_AGENT_INFO_IMAGE_ARRAY_MAX_LAYERS = 12296
    HSA_EXT_AGENT_INFO_MAX_IMAGE_RD_HANDLES = 12297
    HSA_EXT_AGENT_INFO_MAX_IMAGE_RORW_HANDLES = 12298
    HSA_EXT_AGENT_INFO_MAX_SAMPLER_HANDLERS = 12299
    HSA_EXT_AGENT_INFO_IMAGE_LINEAR_ROW_PITCH_ALIGNMENT = 12300
end

struct hsa_ext_image_s
    handle::UInt64
end

const hsa_ext_image_t = hsa_ext_image_s

@cenum hsa_ext_image_geometry_t::UInt32 begin
    HSA_EXT_IMAGE_GEOMETRY_1D = 0
    HSA_EXT_IMAGE_GEOMETRY_2D = 1
    HSA_EXT_IMAGE_GEOMETRY_3D = 2
    HSA_EXT_IMAGE_GEOMETRY_1DA = 3
    HSA_EXT_IMAGE_GEOMETRY_2DA = 4
    HSA_EXT_IMAGE_GEOMETRY_1DB = 5
    HSA_EXT_IMAGE_GEOMETRY_2DDEPTH = 6
    HSA_EXT_IMAGE_GEOMETRY_2DADEPTH = 7
end

@cenum hsa_ext_image_channel_type_t::UInt32 begin
    HSA_EXT_IMAGE_CHANNEL_TYPE_SNORM_INT8 = 0
    HSA_EXT_IMAGE_CHANNEL_TYPE_SNORM_INT16 = 1
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT8 = 2
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT16 = 3
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT24 = 4
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_555 = 5
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_565 = 6
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_101010 = 7
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT8 = 8
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT16 = 9
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT32 = 10
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT8 = 11
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT16 = 12
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT32 = 13
    HSA_EXT_IMAGE_CHANNEL_TYPE_HALF_FLOAT = 14
    HSA_EXT_IMAGE_CHANNEL_TYPE_FLOAT = 15
end

const hsa_ext_image_channel_type32_t = UInt32

@cenum hsa_ext_image_channel_order_t::UInt32 begin
    HSA_EXT_IMAGE_CHANNEL_ORDER_A = 0
    HSA_EXT_IMAGE_CHANNEL_ORDER_R = 1
    HSA_EXT_IMAGE_CHANNEL_ORDER_RX = 2
    HSA_EXT_IMAGE_CHANNEL_ORDER_RG = 3
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGX = 4
    HSA_EXT_IMAGE_CHANNEL_ORDER_RA = 5
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGB = 6
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGBX = 7
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGBA = 8
    HSA_EXT_IMAGE_CHANNEL_ORDER_BGRA = 9
    HSA_EXT_IMAGE_CHANNEL_ORDER_ARGB = 10
    HSA_EXT_IMAGE_CHANNEL_ORDER_ABGR = 11
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGB = 12
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGBX = 13
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGBA = 14
    HSA_EXT_IMAGE_CHANNEL_ORDER_SBGRA = 15
    HSA_EXT_IMAGE_CHANNEL_ORDER_INTENSITY = 16
    HSA_EXT_IMAGE_CHANNEL_ORDER_LUMINANCE = 17
    HSA_EXT_IMAGE_CHANNEL_ORDER_DEPTH = 18
    HSA_EXT_IMAGE_CHANNEL_ORDER_DEPTH_STENCIL = 19
end

const hsa_ext_image_channel_order32_t = UInt32

struct hsa_ext_image_format_s
    channel_type::hsa_ext_image_channel_type32_t
    channel_order::hsa_ext_image_channel_order32_t
end

const hsa_ext_image_format_t = hsa_ext_image_format_s

struct hsa_ext_image_descriptor_s
    geometry::hsa_ext_image_geometry_t
    width::Csize_t
    height::Csize_t
    depth::Csize_t
    array_size::Csize_t
    format::hsa_ext_image_format_t
end

const hsa_ext_image_descriptor_t = hsa_ext_image_descriptor_s

@cenum hsa_ext_image_capability_t::UInt32 begin
    HSA_EXT_IMAGE_CAPABILITY_NOT_SUPPORTED = 0
    HSA_EXT_IMAGE_CAPABILITY_READ_ONLY = 1
    HSA_EXT_IMAGE_CAPABILITY_WRITE_ONLY = 2
    HSA_EXT_IMAGE_CAPABILITY_READ_WRITE = 4
    HSA_EXT_IMAGE_CAPABILITY_READ_MODIFY_WRITE = 8
    HSA_EXT_IMAGE_CAPABILITY_ACCESS_INVARIANT_DATA_LAYOUT = 16
end

@cenum hsa_ext_image_data_layout_t::UInt32 begin
    HSA_EXT_IMAGE_DATA_LAYOUT_OPAQUE = 0
    HSA_EXT_IMAGE_DATA_LAYOUT_LINEAR = 1
end

function hsa_ext_image_get_capability(agent, geometry, image_format, capability_mask)
    ccall((:hsa_ext_image_get_capability, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ptr{hsa_ext_image_format_t}, Ptr{UInt32}), agent, geometry, image_format, capability_mask)
end

function hsa_ext_image_get_capability_with_layout(agent, geometry, image_format, image_data_layout, capability_mask)
    ccall((:hsa_ext_image_get_capability_with_layout, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_geometry_t, Ptr{hsa_ext_image_format_t}, hsa_ext_image_data_layout_t, Ptr{UInt32}), agent, geometry, image_format, image_data_layout, capability_mask)
end

struct hsa_ext_image_data_info_s
    size::Csize_t
    alignment::Csize_t
end

const hsa_ext_image_data_info_t = hsa_ext_image_data_info_s

function hsa_ext_image_data_get_info(agent, image_descriptor, access_permission, image_data_info)
    ccall((:hsa_ext_image_data_get_info, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, hsa_access_permission_t, Ptr{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_info)
end

function hsa_ext_image_data_get_info_with_layout(agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
    ccall((:hsa_ext_image_data_get_info_with_layout, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ptr{hsa_ext_image_data_info_t}), agent, image_descriptor, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image_data_info)
end

function hsa_ext_image_create(agent, image_descriptor, image_data, access_permission, image)
    ccall((:hsa_ext_image_create, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image)
end

function hsa_ext_image_create_with_layout(agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
    ccall((:hsa_ext_image_create_with_layout, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, hsa_ext_image_data_layout_t, Csize_t, Csize_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_data, access_permission, image_data_layout, image_data_row_pitch, image_data_slice_pitch, image)
end

function hsa_ext_image_destroy(agent, image)
    ccall((:hsa_ext_image_destroy, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_t), agent, image)
end

function hsa_ext_image_copy(agent, src_image, src_offset, dst_image, dst_offset, range)
    ccall((:hsa_ext_image_copy, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{hsa_dim3_t}, hsa_ext_image_t, Ptr{hsa_dim3_t}, Ptr{hsa_dim3_t}), agent, src_image, src_offset, dst_image, dst_offset, range)
end

struct hsa_ext_image_region_s
    offset::hsa_dim3_t
    range::hsa_dim3_t
end

const hsa_ext_image_region_t = hsa_ext_image_region_s

function hsa_ext_image_import(agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
    ccall((:hsa_ext_image_import, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Csize_t, Csize_t, hsa_ext_image_t, Ptr{hsa_ext_image_region_t}), agent, src_memory, src_row_pitch, src_slice_pitch, dst_image, image_region)
end

function hsa_ext_image_export(agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
    ccall((:hsa_ext_image_export, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{Cvoid}, Csize_t, Csize_t, Ptr{hsa_ext_image_region_t}), agent, src_image, dst_memory, dst_row_pitch, dst_slice_pitch, image_region)
end

function hsa_ext_image_clear(agent, image, data, image_region)
    ccall((:hsa_ext_image_clear, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_image_t, Ptr{Cvoid}, Ptr{hsa_ext_image_region_t}), agent, image, data, image_region)
end

struct hsa_ext_sampler_s
    handle::UInt64
end

const hsa_ext_sampler_t = hsa_ext_sampler_s

@cenum hsa_ext_sampler_addressing_mode_t::UInt32 begin
    HSA_EXT_SAMPLER_ADDRESSING_MODE_UNDEFINED = 0
    HSA_EXT_SAMPLER_ADDRESSING_MODE_CLAMP_TO_EDGE = 1
    HSA_EXT_SAMPLER_ADDRESSING_MODE_CLAMP_TO_BORDER = 2
    HSA_EXT_SAMPLER_ADDRESSING_MODE_REPEAT = 3
    HSA_EXT_SAMPLER_ADDRESSING_MODE_MIRRORED_REPEAT = 4
end

const hsa_ext_sampler_addressing_mode32_t = UInt32

@cenum hsa_ext_sampler_coordinate_mode_t::UInt32 begin
    HSA_EXT_SAMPLER_COORDINATE_MODE_UNNORMALIZED = 0
    HSA_EXT_SAMPLER_COORDINATE_MODE_NORMALIZED = 1
end

const hsa_ext_sampler_coordinate_mode32_t = UInt32

@cenum hsa_ext_sampler_filter_mode_t::UInt32 begin
    HSA_EXT_SAMPLER_FILTER_MODE_NEAREST = 0
    HSA_EXT_SAMPLER_FILTER_MODE_LINEAR = 1
end

const hsa_ext_sampler_filter_mode32_t = UInt32

struct hsa_ext_sampler_descriptor_s
    coordinate_mode::hsa_ext_sampler_coordinate_mode32_t
    filter_mode::hsa_ext_sampler_filter_mode32_t
    address_mode::hsa_ext_sampler_addressing_mode32_t
end

const hsa_ext_sampler_descriptor_t = hsa_ext_sampler_descriptor_s

function hsa_ext_sampler_create(agent, sampler_descriptor, sampler)
    ccall((:hsa_ext_sampler_create, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_sampler_descriptor_t}, Ptr{hsa_ext_sampler_t}), agent, sampler_descriptor, sampler)
end

function hsa_ext_sampler_destroy(agent, sampler)
    ccall((:hsa_ext_sampler_destroy, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_ext_sampler_t), agent, sampler)
end

struct hsa_ext_images_1_00_pfn_s
    hsa_ext_image_get_capability::Ptr{Cvoid}
    hsa_ext_image_data_get_info::Ptr{Cvoid}
    hsa_ext_image_create::Ptr{Cvoid}
    hsa_ext_image_destroy::Ptr{Cvoid}
    hsa_ext_image_copy::Ptr{Cvoid}
    hsa_ext_image_import::Ptr{Cvoid}
    hsa_ext_image_export::Ptr{Cvoid}
    hsa_ext_image_clear::Ptr{Cvoid}
    hsa_ext_sampler_create::Ptr{Cvoid}
    hsa_ext_sampler_destroy::Ptr{Cvoid}
end

const hsa_ext_images_1_00_pfn_t = hsa_ext_images_1_00_pfn_s

struct hsa_ext_images_1_pfn_s
    hsa_ext_image_get_capability::Ptr{Cvoid}
    hsa_ext_image_data_get_info::Ptr{Cvoid}
    hsa_ext_image_create::Ptr{Cvoid}
    hsa_ext_image_destroy::Ptr{Cvoid}
    hsa_ext_image_copy::Ptr{Cvoid}
    hsa_ext_image_import::Ptr{Cvoid}
    hsa_ext_image_export::Ptr{Cvoid}
    hsa_ext_image_clear::Ptr{Cvoid}
    hsa_ext_sampler_create::Ptr{Cvoid}
    hsa_ext_sampler_destroy::Ptr{Cvoid}
    hsa_ext_image_get_capability_with_layout::Ptr{Cvoid}
    hsa_ext_image_data_get_info_with_layout::Ptr{Cvoid}
    hsa_ext_image_create_with_layout::Ptr{Cvoid}
end

const hsa_ext_images_1_pfn_t = hsa_ext_images_1_pfn_s

const hsa_signal_condition32_t = UInt32

@cenum hsa_amd_packet_type_t::UInt32 begin
    HSA_AMD_PACKET_TYPE_BARRIER_VALUE = 2
end

const hsa_amd_packet_type8_t = UInt8

struct hsa_amd_packet_header_s
    header::UInt16
    AmdFormat::hsa_amd_packet_type8_t
    reserved::UInt8
end

const hsa_amd_vendor_packet_header_t = hsa_amd_packet_header_s

struct hsa_amd_barrier_value_packet_s
    header::hsa_amd_vendor_packet_header_t
    reserved0::UInt32
    signal::hsa_signal_t
    value::hsa_signal_value_t
    mask::hsa_signal_value_t
    cond::hsa_signal_condition32_t
    reserved1::UInt32
    reserved2::UInt64
    reserved3::UInt64
    completion_signal::hsa_signal_t
end

const hsa_amd_barrier_value_packet_t = hsa_amd_barrier_value_packet_s

@cenum var"##Ctag#328"::UInt32 begin
    HSA_STATUS_ERROR_INVALID_MEMORY_POOL = 40
    HSA_STATUS_ERROR_MEMORY_APERTURE_VIOLATION = 41
    HSA_STATUS_ERROR_ILLEGAL_INSTRUCTION = 42
end

@cenum hsa_amd_agent_info_s::UInt32 begin
    HSA_AMD_AGENT_INFO_CHIP_ID = 40960
    HSA_AMD_AGENT_INFO_CACHELINE_SIZE = 40961
    HSA_AMD_AGENT_INFO_COMPUTE_UNIT_COUNT = 40962
    HSA_AMD_AGENT_INFO_MAX_CLOCK_FREQUENCY = 40963
    HSA_AMD_AGENT_INFO_DRIVER_NODE_ID = 40964
    HSA_AMD_AGENT_INFO_MAX_ADDRESS_WATCH_POINTS = 40965
    HSA_AMD_AGENT_INFO_BDFID = 40966
    HSA_AMD_AGENT_INFO_MEMORY_WIDTH = 40967
    HSA_AMD_AGENT_INFO_MEMORY_MAX_FREQUENCY = 40968
    HSA_AMD_AGENT_INFO_PRODUCT_NAME = 40969
    HSA_AMD_AGENT_INFO_MAX_WAVES_PER_CU = 40970
    HSA_AMD_AGENT_INFO_NUM_SIMDS_PER_CU = 40971
    HSA_AMD_AGENT_INFO_NUM_SHADER_ENGINES = 40972
    HSA_AMD_AGENT_INFO_NUM_SHADER_ARRAYS_PER_SE = 40973
    HSA_AMD_AGENT_INFO_HDP_FLUSH = 40974
    HSA_AMD_AGENT_INFO_DOMAIN = 40975
    HSA_AMD_AGENT_INFO_COOPERATIVE_QUEUES = 40976
    HSA_AMD_AGENT_INFO_UUID = 40977
    HSA_AMD_AGENT_INFO_ASIC_REVISION = 40978
end

const hsa_amd_agent_info_t = hsa_amd_agent_info_s

struct hsa_amd_hdp_flush_s
    HDP_MEM_FLUSH_CNTL::Ptr{UInt32}
    HDP_REG_FLUSH_CNTL::Ptr{UInt32}
end

const hsa_amd_hdp_flush_t = hsa_amd_hdp_flush_s

@cenum hsa_amd_region_info_s::UInt32 begin
    HSA_AMD_REGION_INFO_HOST_ACCESSIBLE = 40960
    HSA_AMD_REGION_INFO_BASE = 40961
    HSA_AMD_REGION_INFO_BUS_WIDTH = 40962
    HSA_AMD_REGION_INFO_MAX_CLOCK_FREQUENCY = 40963
end

const hsa_amd_region_info_t = hsa_amd_region_info_s

@cenum hsa_amd_coherency_type_s::UInt32 begin
    HSA_AMD_COHERENCY_TYPE_COHERENT = 0
    HSA_AMD_COHERENCY_TYPE_NONCOHERENT = 1
end

const hsa_amd_coherency_type_t = hsa_amd_coherency_type_s

function hsa_amd_coherency_get_type(agent, type)
    ccall((:hsa_amd_coherency_get_type, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_amd_coherency_type_t}), agent, type)
end

function hsa_amd_coherency_set_type(agent, type)
    ccall((:hsa_amd_coherency_set_type, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_amd_coherency_type_t), agent, type)
end

struct hsa_amd_profiling_dispatch_time_s
    start::UInt64
    _end::UInt64
end

const hsa_amd_profiling_dispatch_time_t = hsa_amd_profiling_dispatch_time_s

struct hsa_amd_profiling_async_copy_time_s
    start::UInt64
    _end::UInt64
end

const hsa_amd_profiling_async_copy_time_t = hsa_amd_profiling_async_copy_time_s

function hsa_amd_profiling_set_profiler_enabled(queue, enable)
    ccall((:hsa_amd_profiling_set_profiler_enabled, libhsaruntime), hsa_status_t, (Ptr{hsa_queue_t}, Cint), queue, enable)
end

function hsa_amd_profiling_async_copy_enable(enable)
    ccall((:hsa_amd_profiling_async_copy_enable, libhsaruntime), hsa_status_t, (Bool,), enable)
end

function hsa_amd_profiling_get_dispatch_time(agent, signal, time)
    ccall((:hsa_amd_profiling_get_dispatch_time, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_signal_t, Ptr{hsa_amd_profiling_dispatch_time_t}), agent, signal, time)
end

function hsa_amd_profiling_get_async_copy_time(signal, time)
    ccall((:hsa_amd_profiling_get_async_copy_time, libhsaruntime), hsa_status_t, (hsa_signal_t, Ptr{hsa_amd_profiling_async_copy_time_t}), signal, time)
end

function hsa_amd_profiling_convert_tick_to_system_domain(agent, agent_tick, system_tick)
    ccall((:hsa_amd_profiling_convert_tick_to_system_domain, libhsaruntime), hsa_status_t, (hsa_agent_t, UInt64, Ptr{UInt64}), agent, agent_tick, system_tick)
end

@cenum hsa_amd_signal_attribute_t::UInt32 begin
    HSA_AMD_SIGNAL_AMD_GPU_ONLY = 1
    HSA_AMD_SIGNAL_IPC = 2
end

function hsa_amd_signal_create(initial_value, num_consumers, consumers, attributes, signal)
    ccall((:hsa_amd_signal_create, libhsaruntime), hsa_status_t, (hsa_signal_value_t, UInt32, Ptr{hsa_agent_t}, UInt64, Ptr{hsa_signal_t}), initial_value, num_consumers, consumers, attributes, signal)
end

function hsa_amd_signal_value_pointer(signal, value_ptr)
    ccall((:hsa_amd_signal_value_pointer, libhsaruntime), hsa_status_t, (hsa_signal_t, Ptr{Ptr{hsa_signal_value_t}}), signal, value_ptr)
end

# typedef bool ( * hsa_amd_signal_handler ) ( hsa_signal_value_t value , void * arg )
const hsa_amd_signal_handler = Ptr{Cvoid}

function hsa_amd_signal_async_handler(signal, cond, value, handler, arg)
    ccall((:hsa_amd_signal_async_handler, libhsaruntime), hsa_status_t, (hsa_signal_t, hsa_signal_condition_t, hsa_signal_value_t, hsa_amd_signal_handler, Ptr{Cvoid}), signal, cond, value, handler, arg)
end

function hsa_amd_async_function(callback, arg)
    ccall((:hsa_amd_async_function, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), callback, arg)
end

function hsa_amd_signal_wait_any(signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
    ccall((:hsa_amd_signal_wait_any, libhsaruntime), UInt32, (UInt32, Ptr{hsa_signal_t}, Ptr{hsa_signal_condition_t}, Ptr{hsa_signal_value_t}, UInt64, hsa_wait_state_t, Ptr{hsa_signal_value_t}), signal_count, signals, conds, values, timeout_hint, wait_hint, satisfying_value)
end

function hsa_amd_image_get_info_max_dim(agent, attribute, value)
    ccall((:hsa_amd_image_get_info_max_dim, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_agent_info_t, Ptr{Cvoid}), agent, attribute, value)
end

function hsa_amd_queue_cu_set_mask(queue, num_cu_mask_count, cu_mask)
    ccall((:hsa_amd_queue_cu_set_mask, libhsaruntime), hsa_status_t, (Ptr{hsa_queue_t}, UInt32, Ptr{UInt32}), queue, num_cu_mask_count, cu_mask)
end

@cenum hsa_amd_segment_t::UInt32 begin
    HSA_AMD_SEGMENT_GLOBAL = 0
    HSA_AMD_SEGMENT_READONLY = 1
    HSA_AMD_SEGMENT_PRIVATE = 2
    HSA_AMD_SEGMENT_GROUP = 3
end

struct hsa_amd_memory_pool_s
    handle::UInt64
end

const hsa_amd_memory_pool_t = hsa_amd_memory_pool_s

@cenum hsa_amd_memory_pool_global_flag_s::UInt32 begin
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_KERNARG_INIT = 1
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_FINE_GRAINED = 2
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_COARSE_GRAINED = 4
end

const hsa_amd_memory_pool_global_flag_t = hsa_amd_memory_pool_global_flag_s

@cenum hsa_amd_memory_pool_info_t::UInt32 begin
    HSA_AMD_MEMORY_POOL_INFO_SEGMENT = 0
    HSA_AMD_MEMORY_POOL_INFO_GLOBAL_FLAGS = 1
    HSA_AMD_MEMORY_POOL_INFO_SIZE = 2
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALLOWED = 5
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_GRANULE = 6
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALIGNMENT = 7
    HSA_AMD_MEMORY_POOL_INFO_ACCESSIBLE_BY_ALL = 15
    HSA_AMD_MEMORY_POOL_INFO_ALLOC_MAX_SIZE = 16
end

function hsa_amd_memory_pool_get_info(memory_pool, attribute, value)
    ccall((:hsa_amd_memory_pool_get_info, libhsaruntime), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_info_t, Ptr{Cvoid}), memory_pool, attribute, value)
end

function hsa_amd_agent_iterate_memory_pools(agent, callback, data)
    ccall((:hsa_amd_agent_iterate_memory_pools, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{Cvoid}, Ptr{Cvoid}), agent, callback, data)
end

function hsa_amd_memory_pool_allocate(memory_pool, size, flags, ptr)
    ccall((:hsa_amd_memory_pool_allocate, libhsaruntime), hsa_status_t, (hsa_amd_memory_pool_t, Csize_t, UInt32, Ptr{Ptr{Cvoid}}), memory_pool, size, flags, ptr)
end

function hsa_amd_memory_pool_free(ptr)
    ccall((:hsa_amd_memory_pool_free, libhsaruntime), hsa_status_t, (Ptr{Cvoid},), ptr)
end

function hsa_amd_memory_async_copy(dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
    ccall((:hsa_amd_memory_async_copy, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, hsa_agent_t, Ptr{Cvoid}, hsa_agent_t, Csize_t, UInt32, Ptr{hsa_signal_t}, hsa_signal_t), dst, dst_agent, src, src_agent, size, num_dep_signals, dep_signals, completion_signal)
end

struct hsa_pitched_ptr_s
    base::Ptr{Cvoid}
    pitch::Csize_t
    slice::Csize_t
end

const hsa_pitched_ptr_t = hsa_pitched_ptr_s

@cenum hsa_amd_copy_direction_t::UInt32 begin
    hsaHostToHost = 0
    hsaHostToDevice = 1
    hsaDeviceToHost = 2
    hsaDeviceToDevice = 3
end

function hsa_amd_memory_async_copy_rect(dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal)
    ccall((:hsa_amd_memory_async_copy_rect, libhsaruntime), hsa_status_t, (Ptr{hsa_pitched_ptr_t}, Ptr{hsa_dim3_t}, Ptr{hsa_pitched_ptr_t}, Ptr{hsa_dim3_t}, Ptr{hsa_dim3_t}, hsa_agent_t, hsa_amd_copy_direction_t, UInt32, Ptr{hsa_signal_t}, hsa_signal_t), dst, dst_offset, src, src_offset, range, copy_agent, dir, num_dep_signals, dep_signals, completion_signal)
end

@cenum hsa_amd_memory_pool_access_t::UInt32 begin
    HSA_AMD_MEMORY_POOL_ACCESS_NEVER_ALLOWED = 0
    HSA_AMD_MEMORY_POOL_ACCESS_ALLOWED_BY_DEFAULT = 1
    HSA_AMD_MEMORY_POOL_ACCESS_DISALLOWED_BY_DEFAULT = 2
end

@cenum hsa_amd_link_info_type_t::UInt32 begin
    HSA_AMD_LINK_INFO_TYPE_HYPERTRANSPORT = 0
    HSA_AMD_LINK_INFO_TYPE_QPI = 1
    HSA_AMD_LINK_INFO_TYPE_PCIE = 2
    HSA_AMD_LINK_INFO_TYPE_INFINBAND = 3
    HSA_AMD_LINK_INFO_TYPE_XGMI = 4
end

struct hsa_amd_memory_pool_link_info_s
    min_latency::UInt32
    max_latency::UInt32
    min_bandwidth::UInt32
    max_bandwidth::UInt32
    atomic_support_32bit::Bool
    atomic_support_64bit::Bool
    coherent_support::Bool
    link_type::hsa_amd_link_info_type_t
    numa_distance::UInt32
end

const hsa_amd_memory_pool_link_info_t = hsa_amd_memory_pool_link_info_s

@cenum hsa_amd_agent_memory_pool_info_t::UInt32 begin
    HSA_AMD_AGENT_MEMORY_POOL_INFO_ACCESS = 0
    HSA_AMD_AGENT_MEMORY_POOL_INFO_NUM_LINK_HOPS = 1
    HSA_AMD_AGENT_MEMORY_POOL_INFO_LINK_INFO = 2
end

function hsa_amd_agent_memory_pool_get_info(agent, memory_pool, attribute, value)
    ccall((:hsa_amd_agent_memory_pool_get_info, libhsaruntime), hsa_status_t, (hsa_agent_t, hsa_amd_memory_pool_t, hsa_amd_agent_memory_pool_info_t, Ptr{Cvoid}), agent, memory_pool, attribute, value)
end

function hsa_amd_agents_allow_access(num_agents, agents, flags, ptr)
    ccall((:hsa_amd_agents_allow_access, libhsaruntime), hsa_status_t, (UInt32, Ptr{hsa_agent_t}, Ptr{UInt32}, Ptr{Cvoid}), num_agents, agents, flags, ptr)
end

function hsa_amd_memory_pool_can_migrate(src_memory_pool, dst_memory_pool, result)
    ccall((:hsa_amd_memory_pool_can_migrate, libhsaruntime), hsa_status_t, (hsa_amd_memory_pool_t, hsa_amd_memory_pool_t, Ptr{Bool}), src_memory_pool, dst_memory_pool, result)
end

function hsa_amd_memory_migrate(ptr, memory_pool, flags)
    ccall((:hsa_amd_memory_migrate, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, hsa_amd_memory_pool_t, UInt32), ptr, memory_pool, flags)
end

function hsa_amd_memory_lock(host_ptr, size, agents, num_agent, agent_ptr)
    ccall((:hsa_amd_memory_lock, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_agent_t}, Cint, Ptr{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, agent_ptr)
end

function hsa_amd_memory_lock_to_pool(host_ptr, size, agents, num_agent, pool, flags, agent_ptr)
    ccall((:hsa_amd_memory_lock_to_pool, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_agent_t}, Cint, hsa_amd_memory_pool_t, UInt32, Ptr{Ptr{Cvoid}}), host_ptr, size, agents, num_agent, pool, flags, agent_ptr)
end

function hsa_amd_memory_unlock(host_ptr)
    ccall((:hsa_amd_memory_unlock, libhsaruntime), hsa_status_t, (Ptr{Cvoid},), host_ptr)
end

function hsa_amd_memory_fill(ptr, value, count)
    ccall((:hsa_amd_memory_fill, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, UInt32, Csize_t), ptr, value, count)
end

function hsa_amd_interop_map_buffer(num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
    ccall((:hsa_amd_interop_map_buffer, libhsaruntime), hsa_status_t, (UInt32, Ptr{hsa_agent_t}, Cint, UInt32, Ptr{Csize_t}, Ptr{Ptr{Cvoid}}, Ptr{Csize_t}, Ptr{Ptr{Cvoid}}), num_agents, agents, interop_handle, flags, size, ptr, metadata_size, metadata)
end

function hsa_amd_interop_unmap_buffer(ptr)
    ccall((:hsa_amd_interop_unmap_buffer, libhsaruntime), hsa_status_t, (Ptr{Cvoid},), ptr)
end

struct hsa_amd_image_descriptor_s
    version::UInt32
    deviceID::UInt32
    data::NTuple{1, UInt32}
end

const hsa_amd_image_descriptor_t = hsa_amd_image_descriptor_s

function hsa_amd_image_create(agent, image_descriptor, image_layout, image_data, access_permission, image)
    ccall((:hsa_amd_image_create, libhsaruntime), hsa_status_t, (hsa_agent_t, Ptr{hsa_ext_image_descriptor_t}, Ptr{hsa_amd_image_descriptor_t}, Ptr{Cvoid}, hsa_access_permission_t, Ptr{hsa_ext_image_t}), agent, image_descriptor, image_layout, image_data, access_permission, image)
end

@cenum hsa_amd_pointer_type_t::UInt32 begin
    HSA_EXT_POINTER_TYPE_UNKNOWN = 0
    HSA_EXT_POINTER_TYPE_HSA = 1
    HSA_EXT_POINTER_TYPE_LOCKED = 2
    HSA_EXT_POINTER_TYPE_GRAPHICS = 3
    HSA_EXT_POINTER_TYPE_IPC = 4
end

struct hsa_amd_pointer_info_s
    size::UInt32
    type::hsa_amd_pointer_type_t
    agentBaseAddress::Ptr{Cvoid}
    hostBaseAddress::Ptr{Cvoid}
    sizeInBytes::Csize_t
    userData::Ptr{Cvoid}
    agentOwner::hsa_agent_t
end

const hsa_amd_pointer_info_t = hsa_amd_pointer_info_s

function hsa_amd_pointer_info(ptr, info, alloc, num_agents_accessible, accessible)
    ccall((:hsa_amd_pointer_info, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Ptr{hsa_amd_pointer_info_t}, Ptr{Cvoid}, Ptr{UInt32}, Ptr{Ptr{hsa_agent_t}}), ptr, info, alloc, num_agents_accessible, accessible)
end

function hsa_amd_pointer_info_set_userdata(ptr, userdata)
    ccall((:hsa_amd_pointer_info_set_userdata, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Ptr{Cvoid}), ptr, userdata)
end

struct hsa_amd_ipc_memory_s
    handle::NTuple{8, UInt32}
end

const hsa_amd_ipc_memory_t = hsa_amd_ipc_memory_s

function hsa_amd_ipc_memory_create(ptr, len, handle)
    ccall((:hsa_amd_ipc_memory_create, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, Csize_t, Ptr{hsa_amd_ipc_memory_t}), ptr, len, handle)
end

function hsa_amd_ipc_memory_attach(handle, len, num_agents, mapping_agents, mapped_ptr)
    ccall((:hsa_amd_ipc_memory_attach, libhsaruntime), hsa_status_t, (Ptr{hsa_amd_ipc_memory_t}, Csize_t, UInt32, Ptr{hsa_agent_t}, Ptr{Ptr{Cvoid}}), handle, len, num_agents, mapping_agents, mapped_ptr)
end

function hsa_amd_ipc_memory_detach(mapped_ptr)
    ccall((:hsa_amd_ipc_memory_detach, libhsaruntime), hsa_status_t, (Ptr{Cvoid},), mapped_ptr)
end

const hsa_amd_ipc_signal_t = hsa_amd_ipc_memory_t

function hsa_amd_ipc_signal_create(signal, handle)
    ccall((:hsa_amd_ipc_signal_create, libhsaruntime), hsa_status_t, (hsa_signal_t, Ptr{hsa_amd_ipc_signal_t}), signal, handle)
end

function hsa_amd_ipc_signal_attach(handle, signal)
    ccall((:hsa_amd_ipc_signal_attach, libhsaruntime), hsa_status_t, (Ptr{hsa_amd_ipc_signal_t}, Ptr{hsa_signal_t}), handle, signal)
end

@cenum hsa_amd_event_type_s::UInt32 begin
    HSA_AMD_GPU_MEMORY_FAULT_EVENT = 0
end

const hsa_amd_event_type_t = hsa_amd_event_type_s

@cenum hsa_amd_memory_fault_reason_t::Int32 begin
    HSA_AMD_MEMORY_FAULT_PAGE_NOT_PRESENT = 1
    HSA_AMD_MEMORY_FAULT_READ_ONLY = 2
    HSA_AMD_MEMORY_FAULT_NX = 4
    HSA_AMD_MEMORY_FAULT_HOST_ONLY = 8
    HSA_AMD_MEMORY_FAULT_DRAMECC = 16
    HSA_AMD_MEMORY_FAULT_IMPRECISE = 32
    HSA_AMD_MEMORY_FAULT_SRAMECC = 64
    HSA_AMD_MEMORY_FAULT_HANG = -2147483648
end

struct hsa_amd_gpu_memory_fault_info_s
    agent::hsa_agent_t
    virtual_address::UInt64
    fault_reason_mask::UInt32
end

const hsa_amd_gpu_memory_fault_info_t = hsa_amd_gpu_memory_fault_info_s

struct hsa_amd_event_s
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{hsa_amd_event_s}, f::Symbol)
    f === :event_type && return Ptr{hsa_amd_event_type_t}(x + 0)
    f === :memory_fault && return Ptr{hsa_amd_gpu_memory_fault_info_t}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hsa_amd_event_s, f::Symbol)
    r = Ref{hsa_amd_event_s}(x)
    ptr = Base.unsafe_convert(Ptr{hsa_amd_event_s}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hsa_amd_event_s}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hsa_amd_event_t = hsa_amd_event_s

# typedef hsa_status_t ( * hsa_amd_system_event_callback_t ) ( const hsa_amd_event_t * event , void * data )
const hsa_amd_system_event_callback_t = Ptr{Cvoid}

function hsa_amd_register_system_event_handler(callback, data)
    ccall((:hsa_amd_register_system_event_handler, libhsaruntime), hsa_status_t, (hsa_amd_system_event_callback_t, Ptr{Cvoid}), callback, data)
end

@cenum hsa_amd_queue_priority_s::UInt32 begin
    HSA_AMD_QUEUE_PRIORITY_LOW = 0
    HSA_AMD_QUEUE_PRIORITY_NORMAL = 1
    HSA_AMD_QUEUE_PRIORITY_HIGH = 2
end

const hsa_amd_queue_priority_t = hsa_amd_queue_priority_s

function hsa_amd_queue_set_priority(queue, priority)
    ccall((:hsa_amd_queue_set_priority, libhsaruntime), hsa_status_t, (Ptr{hsa_queue_t}, hsa_amd_queue_priority_t), queue, priority)
end

# typedef void ( * hsa_amd_deallocation_callback_t ) ( void * ptr , void * user_data )
const hsa_amd_deallocation_callback_t = Ptr{Cvoid}

function hsa_amd_register_deallocation_callback(ptr, callback, user_data)
    ccall((:hsa_amd_register_deallocation_callback, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, hsa_amd_deallocation_callback_t, Ptr{Cvoid}), ptr, callback, user_data)
end

function hsa_amd_deregister_deallocation_callback(ptr, callback)
    ccall((:hsa_amd_deregister_deallocation_callback, libhsaruntime), hsa_status_t, (Ptr{Cvoid}, hsa_amd_deallocation_callback_t), ptr, callback)
end

# Skipping MacroDefinition: HSA_EXPORT_DECORATOR __attribute__ ( ( visibility ( "default" ) ) )

const HSA_API_EXPORT = HSA_EXPORT_DECORATOR(HSA_CALL)

const HSA_API_IMPORT = HSA_CALL

const HSA_API = HSA_API_IMPORT

const HSA_VERSION_1_0 = 1

const HSA_AMD_INTERFACE_VERSION_MAJOR = 1

const HSA_AMD_INTERFACE_VERSION_MINOR = 0

# exports
const PREFIXES = ["HSA", "hsa_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
