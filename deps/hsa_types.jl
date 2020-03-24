# Automatically generated using Clang.jl wrap_c


# Skipping MacroDefinition: HSA_EXPORT_DECORATOR __attribute__ ( ( visibility ( "default" ) ) )

const HSA_VERSION_1_0 = 1

@cenum(hsa_status_t,
    HSA_STATUS_SUCCESS = 0,
    HSA_STATUS_INFO_BREAK = 1,
    HSA_STATUS_ERROR = 4096,
    HSA_STATUS_ERROR_INVALID_ARGUMENT = 4097,
    HSA_STATUS_ERROR_INVALID_QUEUE_CREATION = 4098,
    HSA_STATUS_ERROR_INVALID_ALLOCATION = 4099,
    HSA_STATUS_ERROR_INVALID_AGENT = 4100,
    HSA_STATUS_ERROR_INVALID_REGION = 4101,
    HSA_STATUS_ERROR_INVALID_SIGNAL = 4102,
    HSA_STATUS_ERROR_INVALID_QUEUE = 4103,
    HSA_STATUS_ERROR_OUT_OF_RESOURCES = 4104,
    HSA_STATUS_ERROR_INVALID_PACKET_FORMAT = 4105,
    HSA_STATUS_ERROR_RESOURCE_FREE = 4106,
    HSA_STATUS_ERROR_NOT_INITIALIZED = 4107,
    HSA_STATUS_ERROR_REFCOUNT_OVERFLOW = 4108,
    HSA_STATUS_ERROR_INCOMPATIBLE_ARGUMENTS = 4109,
    HSA_STATUS_ERROR_INVALID_INDEX = 4110,
    HSA_STATUS_ERROR_INVALID_ISA = 4111,
    HSA_STATUS_ERROR_INVALID_ISA_NAME = 4119,
    HSA_STATUS_ERROR_INVALID_CODE_OBJECT = 4112,
    HSA_STATUS_ERROR_INVALID_EXECUTABLE = 4113,
    HSA_STATUS_ERROR_FROZEN_EXECUTABLE = 4114,
    HSA_STATUS_ERROR_INVALID_SYMBOL_NAME = 4115,
    HSA_STATUS_ERROR_VARIABLE_ALREADY_DEFINED = 4116,
    HSA_STATUS_ERROR_VARIABLE_UNDEFINED = 4117,
    HSA_STATUS_ERROR_EXCEPTION = 4118,
    HSA_STATUS_ERROR_INVALID_CODE_SYMBOL = 4120,
    HSA_STATUS_ERROR_INVALID_EXECUTABLE_SYMBOL = 4121,
    HSA_STATUS_ERROR_INVALID_FILE = 4128,
    HSA_STATUS_ERROR_INVALID_CODE_OBJECT_READER = 4129,
    HSA_STATUS_ERROR_INVALID_CACHE = 4130,
    HSA_STATUS_ERROR_INVALID_WAVEFRONT = 4131,
    HSA_STATUS_ERROR_INVALID_SIGNAL_GROUP = 4132,
    HSA_STATUS_ERROR_INVALID_RUNTIME_STATE = 4133,
)

struct hsa_dim3_s
    x::UInt32
    y::UInt32
    z::UInt32
end

const hsa_dim3_t = hsa_dim3_s

@cenum(hsa_access_permission_t,
    HSA_ACCESS_PERMISSION_RO = 1,
    HSA_ACCESS_PERMISSION_WO = 2,
    HSA_ACCESS_PERMISSION_RW = 3,
)

const hsa_file_t = Cint

@cenum(hsa_endianness_t,
    HSA_ENDIANNESS_LITTLE = 0,
    HSA_ENDIANNESS_BIG = 1,
)
@cenum(hsa_machine_model_t,
    HSA_MACHINE_MODEL_SMALL = 0,
    HSA_MACHINE_MODEL_LARGE = 1,
)
@cenum(hsa_profile_t,
    HSA_PROFILE_BASE = 0,
    HSA_PROFILE_FULL = 1,
)
@cenum(hsa_system_info_t,
    HSA_SYSTEM_INFO_VERSION_MAJOR = 0,
    HSA_SYSTEM_INFO_VERSION_MINOR = 1,
    HSA_SYSTEM_INFO_TIMESTAMP = 2,
    HSA_SYSTEM_INFO_TIMESTAMP_FREQUENCY = 3,
    HSA_SYSTEM_INFO_SIGNAL_MAX_WAIT = 4,
    HSA_SYSTEM_INFO_ENDIANNESS = 5,
    HSA_SYSTEM_INFO_MACHINE_MODEL = 6,
    HSA_SYSTEM_INFO_EXTENSIONS = 7,
)
@cenum(hsa_extension_t,
    HSA_EXTENSION_FINALIZER = 0,
    HSA_EXTENSION_IMAGES = 1,
    HSA_EXTENSION_PERFORMANCE_COUNTERS = 2,
    HSA_EXTENSION_PROFILING_EVENTS = 3,
    HSA_EXTENSION_STD_LAST = 3,
    HSA_AMD_FIRST_EXTENSION = 512,
    HSA_EXTENSION_AMD_PROFILER = 512,
    HSA_EXTENSION_AMD_LOADER = 513,
    HSA_EXTENSION_AMD_AQLPROFILE = 514,
    HSA_AMD_LAST_EXTENSION = 514,
)

struct hsa_agent_s
    handle::UInt64
end

const hsa_agent_t = hsa_agent_s

@cenum(hsa_agent_feature_t,
    HSA_AGENT_FEATURE_KERNEL_DISPATCH = 1,
    HSA_AGENT_FEATURE_AGENT_DISPATCH = 2,
)
@cenum(hsa_device_type_t,
    HSA_DEVICE_TYPE_CPU = 0,
    HSA_DEVICE_TYPE_GPU = 1,
    HSA_DEVICE_TYPE_DSP = 2,
)
@cenum(hsa_default_float_rounding_mode_t,
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_DEFAULT = 0,
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_ZERO = 1,
    HSA_DEFAULT_FLOAT_ROUNDING_MODE_NEAR = 2,
)
@cenum(hsa_agent_info_t,
    HSA_AGENT_INFO_NAME = 0,
    HSA_AGENT_INFO_VENDOR_NAME = 1,
    HSA_AGENT_INFO_FEATURE = 2,
    HSA_AGENT_INFO_MACHINE_MODEL = 3,
    HSA_AGENT_INFO_PROFILE = 4,
    HSA_AGENT_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 5,
    HSA_AGENT_INFO_BASE_PROFILE_DEFAULT_FLOAT_ROUNDING_MODES = 23,
    HSA_AGENT_INFO_FAST_F16_OPERATION = 24,
    HSA_AGENT_INFO_WAVEFRONT_SIZE = 6,
    HSA_AGENT_INFO_WORKGROUP_MAX_DIM = 7,
    HSA_AGENT_INFO_WORKGROUP_MAX_SIZE = 8,
    HSA_AGENT_INFO_GRID_MAX_DIM = 9,
    HSA_AGENT_INFO_GRID_MAX_SIZE = 10,
    HSA_AGENT_INFO_FBARRIER_MAX_SIZE = 11,
    HSA_AGENT_INFO_QUEUES_MAX = 12,
    HSA_AGENT_INFO_QUEUE_MIN_SIZE = 13,
    HSA_AGENT_INFO_QUEUE_MAX_SIZE = 14,
    HSA_AGENT_INFO_QUEUE_TYPE = 15,
    HSA_AGENT_INFO_NODE = 16,
    HSA_AGENT_INFO_DEVICE = 17,
    HSA_AGENT_INFO_CACHE_SIZE = 18,
    HSA_AGENT_INFO_ISA = 19,
    HSA_AGENT_INFO_EXTENSIONS = 20,
    HSA_AGENT_INFO_VERSION_MAJOR = 21,
    HSA_AGENT_INFO_VERSION_MINOR = 22,
)
@cenum(hsa_exception_policy_t,
    HSA_EXCEPTION_POLICY_BREAK = 1,
    HSA_EXCEPTION_POLICY_DETECT = 2,
)

struct hsa_cache_s
    handle::UInt64
end

const hsa_cache_t = hsa_cache_s

@cenum(hsa_cache_info_t,
    HSA_CACHE_INFO_NAME_LENGTH = 0,
    HSA_CACHE_INFO_NAME = 1,
    HSA_CACHE_INFO_LEVEL = 2,
    HSA_CACHE_INFO_SIZE = 3,
)

struct hsa_signal_s
    handle::UInt64
end

const hsa_signal_t = hsa_signal_s
const hsa_signal_value_t = Int64

@cenum(hsa_signal_condition_t,
    HSA_SIGNAL_CONDITION_EQ = 0,
    HSA_SIGNAL_CONDITION_NE = 1,
    HSA_SIGNAL_CONDITION_LT = 2,
    HSA_SIGNAL_CONDITION_GTE = 3,
)
@cenum(hsa_wait_state_t,
    HSA_WAIT_STATE_BLOCKED = 0,
    HSA_WAIT_STATE_ACTIVE = 1,
)

struct hsa_signal_group_s
    handle::UInt64
end

const hsa_signal_group_t = hsa_signal_group_s

struct hsa_region_s
    handle::UInt64
end

const hsa_region_t = hsa_region_s

@cenum(hsa_queue_type_t,
    HSA_QUEUE_TYPE_MULTI = 0,
    HSA_QUEUE_TYPE_SINGLE = 1,
)

const hsa_queue_type32_t = UInt32

@cenum(hsa_queue_feature_t,
    HSA_QUEUE_FEATURE_KERNEL_DISPATCH = 1,
    HSA_QUEUE_FEATURE_AGENT_DISPATCH = 2,
)

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

@cenum(hsa_packet_type_t,
    HSA_PACKET_TYPE_VENDOR_SPECIFIC = 0,
    HSA_PACKET_TYPE_INVALID = 1,
    HSA_PACKET_TYPE_KERNEL_DISPATCH = 2,
    HSA_PACKET_TYPE_BARRIER_AND = 3,
    HSA_PACKET_TYPE_AGENT_DISPATCH = 4,
    HSA_PACKET_TYPE_BARRIER_OR = 5,
)
@cenum(hsa_fence_scope_t,
    HSA_FENCE_SCOPE_NONE = 0,
    HSA_FENCE_SCOPE_AGENT = 1,
    HSA_FENCE_SCOPE_SYSTEM = 2,
)
@cenum(hsa_packet_header_t,
    HSA_PACKET_HEADER_TYPE = 0,
    HSA_PACKET_HEADER_BARRIER = 8,
    HSA_PACKET_HEADER_SCACQUIRE_FENCE_SCOPE = 9,
    HSA_PACKET_HEADER_ACQUIRE_FENCE_SCOPE = 9,
    HSA_PACKET_HEADER_SCRELEASE_FENCE_SCOPE = 11,
    HSA_PACKET_HEADER_RELEASE_FENCE_SCOPE = 11,
)
@cenum(hsa_packet_header_width_t,
    HSA_PACKET_HEADER_WIDTH_TYPE = 8,
    HSA_PACKET_HEADER_WIDTH_BARRIER = 1,
    HSA_PACKET_HEADER_WIDTH_SCACQUIRE_FENCE_SCOPE = 2,
    HSA_PACKET_HEADER_WIDTH_ACQUIRE_FENCE_SCOPE = 2,
    HSA_PACKET_HEADER_WIDTH_SCRELEASE_FENCE_SCOPE = 2,
    HSA_PACKET_HEADER_WIDTH_RELEASE_FENCE_SCOPE = 2,
)
@cenum(hsa_kernel_dispatch_packet_setup_t,
    HSA_KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS = 0,
)
@cenum(hsa_kernel_dispatch_packet_setup_width_t,
    HSA_KERNEL_DISPATCH_PACKET_SETUP_WIDTH_DIMENSIONS = 2,
)

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

@cenum(hsa_region_segment_t,
    HSA_REGION_SEGMENT_GLOBAL = 0,
    HSA_REGION_SEGMENT_READONLY = 1,
    HSA_REGION_SEGMENT_PRIVATE = 2,
    HSA_REGION_SEGMENT_GROUP = 3,
    HSA_REGION_SEGMENT_KERNARG = 4,
)
@cenum(hsa_region_global_flag_t,
    HSA_REGION_GLOBAL_FLAG_KERNARG = 1,
    HSA_REGION_GLOBAL_FLAG_FINE_GRAINED = 2,
    HSA_REGION_GLOBAL_FLAG_COARSE_GRAINED = 4,
)
@cenum(hsa_region_info_t,
    HSA_REGION_INFO_SEGMENT = 0,
    HSA_REGION_INFO_GLOBAL_FLAGS = 1,
    HSA_REGION_INFO_SIZE = 2,
    HSA_REGION_INFO_ALLOC_MAX_SIZE = 4,
    HSA_REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE = 8,
    HSA_REGION_INFO_RUNTIME_ALLOC_ALLOWED = 5,
    HSA_REGION_INFO_RUNTIME_ALLOC_GRANULE = 6,
    HSA_REGION_INFO_RUNTIME_ALLOC_ALIGNMENT = 7,
)

struct hsa_isa_s
    handle::UInt64
end

const hsa_isa_t = hsa_isa_s

@cenum(hsa_isa_info_t,
    HSA_ISA_INFO_NAME_LENGTH = 0,
    HSA_ISA_INFO_NAME = 1,
    HSA_ISA_INFO_CALL_CONVENTION_COUNT = 2,
    HSA_ISA_INFO_CALL_CONVENTION_INFO_WAVEFRONT_SIZE = 3,
    HSA_ISA_INFO_CALL_CONVENTION_INFO_WAVEFRONTS_PER_COMPUTE_UNIT = 4,
    HSA_ISA_INFO_MACHINE_MODELS = 5,
    HSA_ISA_INFO_PROFILES = 6,
    HSA_ISA_INFO_DEFAULT_FLOAT_ROUNDING_MODES = 7,
    HSA_ISA_INFO_BASE_PROFILE_DEFAULT_FLOAT_ROUNDING_MODES = 8,
    HSA_ISA_INFO_FAST_F16_OPERATION = 9,
    HSA_ISA_INFO_WORKGROUP_MAX_DIM = 12,
    HSA_ISA_INFO_WORKGROUP_MAX_SIZE = 13,
    HSA_ISA_INFO_GRID_MAX_DIM = 14,
    HSA_ISA_INFO_GRID_MAX_SIZE = 16,
    HSA_ISA_INFO_FBARRIER_MAX_SIZE = 17,
)
@cenum(hsa_fp_type_t,
    HSA_FP_TYPE_16 = 1,
    HSA_FP_TYPE_32 = 2,
    HSA_FP_TYPE_64 = 4,
)
@cenum(hsa_flush_mode_t,
    HSA_FLUSH_MODE_FTZ = 1,
    HSA_FLUSH_MODE_NON_FTZ = 2,
)
@cenum(hsa_round_method_t,
    HSA_ROUND_METHOD_SINGLE = 1,
    HSA_ROUND_METHOD_DOUBLE = 2,
)

struct hsa_wavefront_s
    handle::UInt64
end

const hsa_wavefront_t = hsa_wavefront_s

@cenum(hsa_wavefront_info_t,
    HSA_WAVEFRONT_INFO_SIZE = 0,
)

struct hsa_code_object_reader_s
    handle::UInt64
end

const hsa_code_object_reader_t = hsa_code_object_reader_s

struct hsa_executable_s
    handle::UInt64
end

const hsa_executable_t = hsa_executable_s

@cenum(hsa_executable_state_t,
    HSA_EXECUTABLE_STATE_UNFROZEN = 0,
    HSA_EXECUTABLE_STATE_FROZEN = 1,
)

struct hsa_loaded_code_object_s
    handle::UInt64
end

const hsa_loaded_code_object_t = hsa_loaded_code_object_s

@cenum(hsa_executable_info_t,
    HSA_EXECUTABLE_INFO_PROFILE = 1,
    HSA_EXECUTABLE_INFO_STATE = 2,
    HSA_EXECUTABLE_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 3,
)

struct hsa_executable_symbol_s
    handle::UInt64
end

const hsa_executable_symbol_t = hsa_executable_symbol_s

@cenum(hsa_symbol_kind_t,
    HSA_SYMBOL_KIND_VARIABLE = 0,
    HSA_SYMBOL_KIND_KERNEL = 1,
    HSA_SYMBOL_KIND_INDIRECT_FUNCTION = 2,
)
@cenum(hsa_symbol_linkage_t,
    HSA_SYMBOL_LINKAGE_MODULE = 0,
    HSA_SYMBOL_LINKAGE_PROGRAM = 1,
)
@cenum(hsa_variable_allocation_t,
    HSA_VARIABLE_ALLOCATION_AGENT = 0,
    HSA_VARIABLE_ALLOCATION_PROGRAM = 1,
)
@cenum(hsa_variable_segment_t,
    HSA_VARIABLE_SEGMENT_GLOBAL = 0,
    HSA_VARIABLE_SEGMENT_READONLY = 1,
)
@cenum(hsa_executable_symbol_info_t,
    HSA_EXECUTABLE_SYMBOL_INFO_TYPE = 0,
    HSA_EXECUTABLE_SYMBOL_INFO_NAME_LENGTH = 1,
    HSA_EXECUTABLE_SYMBOL_INFO_NAME = 2,
    HSA_EXECUTABLE_SYMBOL_INFO_MODULE_NAME_LENGTH = 3,
    HSA_EXECUTABLE_SYMBOL_INFO_MODULE_NAME = 4,
    HSA_EXECUTABLE_SYMBOL_INFO_AGENT = 20,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ADDRESS = 21,
    HSA_EXECUTABLE_SYMBOL_INFO_LINKAGE = 5,
    HSA_EXECUTABLE_SYMBOL_INFO_IS_DEFINITION = 17,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ALLOCATION = 6,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_SEGMENT = 7,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_ALIGNMENT = 8,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_SIZE = 9,
    HSA_EXECUTABLE_SYMBOL_INFO_VARIABLE_IS_CONST = 10,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT = 22,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE = 11,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_ALIGNMENT = 12,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE = 13,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE = 14,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_DYNAMIC_CALLSTACK = 15,
    HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_CALL_CONVENTION = 18,
    HSA_EXECUTABLE_SYMBOL_INFO_INDIRECT_FUNCTION_OBJECT = 23,
    HSA_EXECUTABLE_SYMBOL_INFO_INDIRECT_FUNCTION_CALL_CONVENTION = 16,
)

struct hsa_code_object_s
    handle::UInt64
end

const hsa_code_object_t = hsa_code_object_s

struct hsa_callback_data_s
    handle::UInt64
end

const hsa_callback_data_t = hsa_callback_data_s

@cenum(hsa_code_object_type_t,
    HSA_CODE_OBJECT_TYPE_PROGRAM = 0,
)
@cenum(hsa_code_object_info_t,
    HSA_CODE_OBJECT_INFO_VERSION = 0,
    HSA_CODE_OBJECT_INFO_TYPE = 1,
    HSA_CODE_OBJECT_INFO_ISA = 2,
    HSA_CODE_OBJECT_INFO_MACHINE_MODEL = 3,
    HSA_CODE_OBJECT_INFO_PROFILE = 4,
    HSA_CODE_OBJECT_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 5,
)

struct hsa_code_symbol_s
    handle::UInt64
end

const hsa_code_symbol_t = hsa_code_symbol_s

@cenum(hsa_code_symbol_info_t,
    HSA_CODE_SYMBOL_INFO_TYPE = 0,
    HSA_CODE_SYMBOL_INFO_NAME_LENGTH = 1,
    HSA_CODE_SYMBOL_INFO_NAME = 2,
    HSA_CODE_SYMBOL_INFO_MODULE_NAME_LENGTH = 3,
    HSA_CODE_SYMBOL_INFO_MODULE_NAME = 4,
    HSA_CODE_SYMBOL_INFO_LINKAGE = 5,
    HSA_CODE_SYMBOL_INFO_IS_DEFINITION = 17,
    HSA_CODE_SYMBOL_INFO_VARIABLE_ALLOCATION = 6,
    HSA_CODE_SYMBOL_INFO_VARIABLE_SEGMENT = 7,
    HSA_CODE_SYMBOL_INFO_VARIABLE_ALIGNMENT = 8,
    HSA_CODE_SYMBOL_INFO_VARIABLE_SIZE = 9,
    HSA_CODE_SYMBOL_INFO_VARIABLE_IS_CONST = 10,
    HSA_CODE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE = 11,
    HSA_CODE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_ALIGNMENT = 12,
    HSA_CODE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE = 13,
    HSA_CODE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE = 14,
    HSA_CODE_SYMBOL_INFO_KERNEL_DYNAMIC_CALLSTACK = 15,
    HSA_CODE_SYMBOL_INFO_KERNEL_CALL_CONVENTION = 18,
    HSA_CODE_SYMBOL_INFO_INDIRECT_FUNCTION_CALL_CONVENTION = 16,
)

const HSA_AMD_INTERFACE_VERSION_MAJOR = 1
const HSA_AMD_INTERFACE_VERSION_MINOR = 0

@cenum(hsa_amd_agent_info_s,
    HSA_AMD_AGENT_INFO_CHIP_ID = 40960,
    HSA_AMD_AGENT_INFO_CACHELINE_SIZE = 40961,
    HSA_AMD_AGENT_INFO_COMPUTE_UNIT_COUNT = 40962,
    HSA_AMD_AGENT_INFO_MAX_CLOCK_FREQUENCY = 40963,
    HSA_AMD_AGENT_INFO_DRIVER_NODE_ID = 40964,
    HSA_AMD_AGENT_INFO_MAX_ADDRESS_WATCH_POINTS = 40965,
    HSA_AMD_AGENT_INFO_BDFID = 40966,
    HSA_AMD_AGENT_INFO_MEMORY_WIDTH = 40967,
    HSA_AMD_AGENT_INFO_MEMORY_MAX_FREQUENCY = 40968,
    HSA_AMD_AGENT_INFO_PRODUCT_NAME = 40969,
    HSA_AMD_AGENT_INFO_MAX_WAVES_PER_CU = 40970,
    HSA_AMD_AGENT_INFO_NUM_SIMDS_PER_CU = 40971,
    HSA_AMD_AGENT_INFO_NUM_SHADER_ENGINES = 40972,
    HSA_AMD_AGENT_INFO_NUM_SHADER_ARRAYS_PER_SE = 40973,
)

const hsa_amd_agent_info_t = hsa_amd_agent_info_s

@cenum(hsa_amd_region_info_s,
    HSA_AMD_REGION_INFO_HOST_ACCESSIBLE = 40960,
    HSA_AMD_REGION_INFO_BASE = 40961,
    HSA_AMD_REGION_INFO_BUS_WIDTH = 40962,
    HSA_AMD_REGION_INFO_MAX_CLOCK_FREQUENCY = 40963,
)

const hsa_amd_region_info_t = hsa_amd_region_info_s

@cenum(hsa_amd_coherency_type_s,
    HSA_AMD_COHERENCY_TYPE_COHERENT = 0,
    HSA_AMD_COHERENCY_TYPE_NONCOHERENT = 1,
)

const hsa_amd_coherency_type_t = hsa_amd_coherency_type_s

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

@cenum(hsa_amd_signal_attribute_t,
    HSA_AMD_SIGNAL_AMD_GPU_ONLY = 1,
    HSA_AMD_SIGNAL_IPC = 2,
)

const hsa_amd_signal_handler = Ptr{Cvoid}

@cenum(hsa_amd_segment_t,
    HSA_AMD_SEGMENT_GLOBAL = 0,
    HSA_AMD_SEGMENT_READONLY = 1,
    HSA_AMD_SEGMENT_PRIVATE = 2,
    HSA_AMD_SEGMENT_GROUP = 3,
)

struct hsa_amd_memory_pool_s
    handle::UInt64
end

const hsa_amd_memory_pool_t = hsa_amd_memory_pool_s

@cenum(hsa_amd_memory_pool_global_flag_s,
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_KERNARG_INIT = 1,
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_FINE_GRAINED = 2,
    HSA_AMD_MEMORY_POOL_GLOBAL_FLAG_COARSE_GRAINED = 4,
)

const hsa_amd_memory_pool_global_flag_t = hsa_amd_memory_pool_global_flag_s

@cenum(hsa_amd_memory_pool_info_t,
    HSA_AMD_MEMORY_POOL_INFO_SEGMENT = 0,
    HSA_AMD_MEMORY_POOL_INFO_GLOBAL_FLAGS = 1,
    HSA_AMD_MEMORY_POOL_INFO_SIZE = 2,
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALLOWED = 5,
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_GRANULE = 6,
    HSA_AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALIGNMENT = 7,
    HSA_AMD_MEMORY_POOL_INFO_ACCESSIBLE_BY_ALL = 15,
)
@cenum(hsa_amd_memory_pool_access_t,
    HSA_AMD_MEMORY_POOL_ACCESS_NEVER_ALLOWED = 0,
    HSA_AMD_MEMORY_POOL_ACCESS_ALLOWED_BY_DEFAULT = 1,
    HSA_AMD_MEMORY_POOL_ACCESS_DISALLOWED_BY_DEFAULT = 2,
)
@cenum(hsa_amd_link_info_type_t,
    HSA_AMD_LINK_INFO_TYPE_HYPERTRANSPORT = 0,
    HSA_AMD_LINK_INFO_TYPE_QPI = 1,
    HSA_AMD_LINK_INFO_TYPE_PCIE = 2,
    HSA_AMD_LINK_INFO_TYPE_INFINBAND = 3,
)

struct hsa_amd_memory_pool_link_info_s
    min_latency::UInt32
    max_latency::UInt32
    min_bandwidth::UInt32
    max_bandwidth::UInt32
    atomic_support_32bit::Bool
    atomic_support_64bit::Bool
    coherent_support::Bool
    link_type::hsa_amd_link_info_type_t
end

const hsa_amd_memory_pool_link_info_t = hsa_amd_memory_pool_link_info_s

@cenum(hsa_amd_agent_memory_pool_info_t,
    HSA_AMD_AGENT_MEMORY_POOL_INFO_ACCESS = 0,
    HSA_AMD_AGENT_MEMORY_POOL_INFO_NUM_LINK_HOPS = 1,
    HSA_AMD_AGENT_MEMORY_POOL_INFO_LINK_INFO = 2,
)

struct hsa_amd_image_descriptor_s
    version::UInt32
    deviceID::UInt32
    data::NTuple{1, UInt32}
end

const hsa_amd_image_descriptor_t = hsa_amd_image_descriptor_s

@cenum(hsa_amd_pointer_type_t,
    HSA_EXT_POINTER_TYPE_UNKNOWN = 0,
    HSA_EXT_POINTER_TYPE_HSA = 1,
    HSA_EXT_POINTER_TYPE_LOCKED = 2,
    HSA_EXT_POINTER_TYPE_GRAPHICS = 3,
    HSA_EXT_POINTER_TYPE_IPC = 4,
)

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

struct hsa_amd_ipc_memory_s
    handle::NTuple{8, UInt32}
end

const hsa_amd_ipc_memory_t = hsa_amd_ipc_memory_s
const hsa_amd_ipc_signal_t = hsa_amd_ipc_memory_t
const BrigModuleHeader = Cvoid
const BrigModule_t = Ptr{BrigModuleHeader}
const hsa_ext_module_t = BrigModule_t

struct hsa_ext_program_s
    handle::UInt64
end

const hsa_ext_program_t = hsa_ext_program_s

@cenum(hsa_ext_program_info_t,
    HSA_EXT_PROGRAM_INFO_MACHINE_MODEL = 0,
    HSA_EXT_PROGRAM_INFO_PROFILE = 1,
    HSA_EXT_PROGRAM_INFO_DEFAULT_FLOAT_ROUNDING_MODE = 2,
)
@cenum(hsa_ext_finalizer_call_convention_t::Int32,
    HSA_EXT_FINALIZER_CALL_CONVENTION_AUTO = -1,
)

struct hsa_ext_control_directives_s
    control_directives_mask::UInt64
    break_exceptions_mask::UInt16
    detect_exceptions_mask::UInt16
    max_dynamic_group_size::UInt32
    max_flat_grid_size::UInt64
    max_flat_workgroup_size::UInt32
    reserved1::UInt32
    required_grid_size::NTuple{3, UInt64}
    required_workgroup_size::hsa_dim3_t
    required_dim::UInt8
    reserved2::NTuple{75, UInt8}
end

const hsa_ext_control_directives_t = hsa_ext_control_directives_s

struct hsa_ext_finalizer_1_00_pfn_s
    hsa_ext_program_create::Ptr{Cvoid}
    hsa_ext_program_destroy::Ptr{Cvoid}
    hsa_ext_program_add_module::Ptr{Cvoid}
    hsa_ext_program_iterate_modules::Ptr{Cvoid}
    hsa_ext_program_get_info::Ptr{Cvoid}
    hsa_ext_program_finalize::Ptr{Cvoid}
end

const hsa_ext_finalizer_1_00_pfn_t = hsa_ext_finalizer_1_00_pfn_s

struct hsa_ext_image_s
    handle::UInt64
end

const hsa_ext_image_t = hsa_ext_image_s

@cenum(hsa_ext_image_geometry_t,
    HSA_EXT_IMAGE_GEOMETRY_1D = 0,
    HSA_EXT_IMAGE_GEOMETRY_2D = 1,
    HSA_EXT_IMAGE_GEOMETRY_3D = 2,
    HSA_EXT_IMAGE_GEOMETRY_1DA = 3,
    HSA_EXT_IMAGE_GEOMETRY_2DA = 4,
    HSA_EXT_IMAGE_GEOMETRY_1DB = 5,
    HSA_EXT_IMAGE_GEOMETRY_2DDEPTH = 6,
    HSA_EXT_IMAGE_GEOMETRY_2DADEPTH = 7,
)
@cenum(hsa_ext_image_channel_type_t,
    HSA_EXT_IMAGE_CHANNEL_TYPE_SNORM_INT8 = 0,
    HSA_EXT_IMAGE_CHANNEL_TYPE_SNORM_INT16 = 1,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT8 = 2,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT16 = 3,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_INT24 = 4,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_555 = 5,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_565 = 6,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNORM_SHORT_101010 = 7,
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT8 = 8,
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT16 = 9,
    HSA_EXT_IMAGE_CHANNEL_TYPE_SIGNED_INT32 = 10,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT8 = 11,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT16 = 12,
    HSA_EXT_IMAGE_CHANNEL_TYPE_UNSIGNED_INT32 = 13,
    HSA_EXT_IMAGE_CHANNEL_TYPE_HALF_FLOAT = 14,
    HSA_EXT_IMAGE_CHANNEL_TYPE_FLOAT = 15,
)

const hsa_ext_image_channel_type32_t = UInt32

@cenum(hsa_ext_image_channel_order_t,
    HSA_EXT_IMAGE_CHANNEL_ORDER_A = 0,
    HSA_EXT_IMAGE_CHANNEL_ORDER_R = 1,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RX = 2,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RG = 3,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGX = 4,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RA = 5,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGB = 6,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGBX = 7,
    HSA_EXT_IMAGE_CHANNEL_ORDER_RGBA = 8,
    HSA_EXT_IMAGE_CHANNEL_ORDER_BGRA = 9,
    HSA_EXT_IMAGE_CHANNEL_ORDER_ARGB = 10,
    HSA_EXT_IMAGE_CHANNEL_ORDER_ABGR = 11,
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGB = 12,
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGBX = 13,
    HSA_EXT_IMAGE_CHANNEL_ORDER_SRGBA = 14,
    HSA_EXT_IMAGE_CHANNEL_ORDER_SBGRA = 15,
    HSA_EXT_IMAGE_CHANNEL_ORDER_INTENSITY = 16,
    HSA_EXT_IMAGE_CHANNEL_ORDER_LUMINANCE = 17,
    HSA_EXT_IMAGE_CHANNEL_ORDER_DEPTH = 18,
    HSA_EXT_IMAGE_CHANNEL_ORDER_DEPTH_STENCIL = 19,
)

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

@cenum(hsa_ext_image_capability_t,
    HSA_EXT_IMAGE_CAPABILITY_NOT_SUPPORTED = 0,
    HSA_EXT_IMAGE_CAPABILITY_READ_ONLY = 1,
    HSA_EXT_IMAGE_CAPABILITY_WRITE_ONLY = 2,
    HSA_EXT_IMAGE_CAPABILITY_READ_WRITE = 4,
    HSA_EXT_IMAGE_CAPABILITY_READ_MODIFY_WRITE = 8,
    HSA_EXT_IMAGE_CAPABILITY_ACCESS_INVARIANT_DATA_LAYOUT = 16,
)
@cenum(hsa_ext_image_data_layout_t,
    HSA_EXT_IMAGE_DATA_LAYOUT_OPAQUE = 0,
    HSA_EXT_IMAGE_DATA_LAYOUT_LINEAR = 1,
)

struct hsa_ext_image_data_info_s
    size::Csize_t
    alignment::Csize_t
end

const hsa_ext_image_data_info_t = hsa_ext_image_data_info_s

struct hsa_ext_image_region_s
    offset::hsa_dim3_t
    range::hsa_dim3_t
end

const hsa_ext_image_region_t = hsa_ext_image_region_s

struct hsa_ext_sampler_s
    handle::UInt64
end

const hsa_ext_sampler_t = hsa_ext_sampler_s

@cenum(hsa_ext_sampler_addressing_mode_t,
    HSA_EXT_SAMPLER_ADDRESSING_MODE_UNDEFINED = 0,
    HSA_EXT_SAMPLER_ADDRESSING_MODE_CLAMP_TO_EDGE = 1,
    HSA_EXT_SAMPLER_ADDRESSING_MODE_CLAMP_TO_BORDER = 2,
    HSA_EXT_SAMPLER_ADDRESSING_MODE_REPEAT = 3,
    HSA_EXT_SAMPLER_ADDRESSING_MODE_MIRRORED_REPEAT = 4,
)

const hsa_ext_sampler_addressing_mode32_t = UInt32

@cenum(hsa_ext_sampler_coordinate_mode_t,
    HSA_EXT_SAMPLER_COORDINATE_MODE_UNNORMALIZED = 0,
    HSA_EXT_SAMPLER_COORDINATE_MODE_NORMALIZED = 1,
)

const hsa_ext_sampler_coordinate_mode32_t = UInt32

@cenum(hsa_ext_sampler_filter_mode_t,
    HSA_EXT_SAMPLER_FILTER_MODE_NEAREST = 0,
    HSA_EXT_SAMPLER_FILTER_MODE_LINEAR = 1,
)

const hsa_ext_sampler_filter_mode32_t = UInt32

struct hsa_ext_sampler_descriptor_s
    coordinate_mode::hsa_ext_sampler_coordinate_mode32_t
    filter_mode::hsa_ext_sampler_filter_mode32_t
    address_mode::hsa_ext_sampler_addressing_mode32_t
end

const hsa_ext_sampler_descriptor_t = hsa_ext_sampler_descriptor_s

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

struct hsa_log_t
    handle::UInt64
end
