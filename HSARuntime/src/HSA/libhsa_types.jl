# Pointer/type aliases
const QueueInterceptPacketWriter = Ptr{Cvoid}
const QueueInterceptHandler = Ptr{Cvoid}
const RuntimeQueueNotifier = Ptr{Cvoid}
const SignalHandler = Ptr{Cvoid}
const DeallocationCallback = Ptr{Cvoid}
const AQLProfileDataCallback = Ptr{Cvoid}
const SystemEventCallback = Ptr{Cvoid}
const ToolsEvent = UInt64
const SignalValue = Int64
#const SignalValue = Union{Int64,UInt64} #TODO: check me on use of signal_store_relaxed
const MachineVersion = UInt16
const File = Cint
const ExtModule = Ptr{Cvoid}

# Composite types

struct AMDGPUSamplerDescriptor
    size::UInt16
    kind::MetadataKind
    coord::SamplerCoord
    filter::SamplerFilter
    addressing::SamplerAddressing
    reserved1::UInt8
end

struct AMDGPUHSAImageDescriptor
    size::UInt16
    kind::MetadataKind
    geometry::ImageGeometry
    channel_order::ImageChannelOrder
    channel_type::ImageChannelType
    reserved1::UInt8
    width::UInt64
    height::UInt64
    depth::UInt64
    array::UInt64
end

struct NoteCodeObjectVersion
    major_version::UInt32
    minor_version::UInt32
end

struct NoteHSAIL
    hsail_major_version::UInt32
    hsail_minor_version::UInt32
    profile::UInt8
    machine_model::UInt8
    default_float_round::UInt8
end

struct NoteISA
    vendor_name_size::UInt16
    architecture_name_size::UInt16
    major::UInt32
    minor::UInt32
    stepping::UInt32
    vendor_and_architecture_name::NTuple{1, UInt8}
end

struct NoteProducer
    producer_name_size::UInt16
    reserved::UInt16
    producer_major_version::UInt32
    producer_minor_version::UInt32
    producer_name::NTuple{1, UInt8}
end

struct NoteProducerOptions
    producer_options_size::UInt16
    producer_options::NTuple{1, UInt8}
end

struct Dim3
    x::UInt32
    y::UInt32
    z::UInt32
end

struct Agent
    handle::UInt64
end

struct Cache
    handle::UInt64
end

struct Signal
    handle::UInt64
end

struct SignalGroup
    handle::UInt64
end

struct Region
    handle::UInt64
end

struct Queue
    type::QueueType
    features::UInt32
    base_address::Ptr{Cvoid}
    doorbell_signal::Signal
    size::UInt32
    reserved1::UInt32
    id::UInt64
end

struct KernelDispatchPacket
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
    completion_signal::Signal
end

struct AgentDispatchPacket
    header::UInt16
    type::UInt16
    reserved0::UInt32
    return_address::Ptr{Cvoid}
    arg::NTuple{4, UInt64}
    reserved2::UInt64
    completion_signal::Signal
end

struct BarrierAndPacket
    header::UInt16
    reserved0::UInt16
    reserved1::UInt32
    dep_signal::NTuple{5, Signal}
    reserved2::UInt64
    completion_signal::Signal
end

struct BarrierOrPacket
    header::UInt16
    reserved0::UInt16
    reserved1::UInt32
    dep_signal::NTuple{5, Signal}
    reserved2::UInt64
    completion_signal::Signal
end

struct ISA
    handle::UInt64
end

struct Wavefront
    handle::UInt64
end

struct CodeObjectReader
    handle::UInt64
end

struct Executable
    handle::UInt64
end

struct LoadedCodeObject
    handle::UInt64
end

struct ExecutableSymbol
    handle::UInt64
end

struct CodeObject
    handle::UInt64
end

struct CallbackData
    handle::UInt64
end

struct CodeSymbol
    handle::UInt64
end

struct AMDControlDirectives
    enabled_control_directives::EnabledControlDirective
    enable_break_exceptions::UInt16
    enable_detect_exceptions::UInt16
    max_dynamic_group_size::UInt32
    max_flat_grid_size::UInt64
    max_flat_workgroup_size::UInt32
    required_dim::UInt8
    reserved1::NTuple{3, UInt8}
    required_grid_size::NTuple{3, UInt64}
    required_workgroup_size::NTuple{3, UInt32}
    reserved2::NTuple{60, UInt8}
end

struct AMDKernelCode
    AMD_kernel_code_version_major::KernelCodeVersion
    AMD_kernel_code_version_minor::KernelCodeVersion
    AMD_machine_kind::MachineKind
    AMD_machine_version_major::MachineVersion
    AMD_machine_version_minor::MachineVersion
    AMD_machine_version_stepping::MachineVersion
    kernel_code_entry_byte_offset::Int64
    kernel_code_prefetch_byte_offset::Int64
    kernel_code_prefetch_byte_size::UInt64
    max_scratch_backing_memory_byte_size::UInt64
    compute_pgm_rsrc1::ComputePgmRsrcOne
    compute_pgm_rsrc2::ComputePgmRsrcTwo
    kernel_code_properties::KernelCodeProperties
    workitem_private_segment_byte_size::UInt32
    workgroup_group_segment_byte_size::UInt32
    gds_segment_byte_size::UInt32
    kernarg_segment_byte_size::UInt64
    workgroup_fbarrier_count::UInt32
    wavefront_sgpr_count::UInt16
    workitem_vgpr_count::UInt16
    reserved_vgpr_first::UInt16
    reserved_vgpr_count::UInt16
    reserved_sgpr_first::UInt16
    reserved_sgpr_count::UInt16
    debug_wavefront_private_segment_offset_sgpr::UInt16
    debug_private_segment_buffer_sgpr::UInt16
    kernarg_segment_alignment::PowerTwo
    group_segment_alignment::PowerTwo
    private_segment_alignment::PowerTwo
    wavefront_size::PowerTwo
    call_convention::Int32
    reserved1::NTuple{12, UInt8}
    runtime_loader_kernel_symbol::UInt64
    control_directives::AMDControlDirectives
end

struct RuntimeLoaderDebugInfo
    elf_raw::Ptr{Cvoid}
    elf_size::UInt64
    kernel_name::Cstring
    owning_segment::Ptr{Cvoid}
end

struct AMDQueue
    queue::Queue
    reserved1::NTuple{4, UInt32}
    write_dispatch_id::UInt64
    group_segment_aperture_base_hi::UInt32
    private_segment_aperture_base_hi::UInt32
    max_cu_id::UInt32
    max_wave_id::UInt32
    max_legacy_doorbell_dispatch_id_plus_1::UInt64
    legacy_doorbell_lock::UInt32
    reserved2::NTuple{9, UInt32}
    read_dispatch_id::UInt64
    read_dispatch_id_field_base_byte_offset::UInt32
    compute_tmpring_size::UInt32
    scratch_resource_descriptor::NTuple{4, UInt32}
    scratch_backing_memory_location::UInt64
    scratch_backing_memory_byte_size::UInt64
    scratch_wave64_lane_byte_size::UInt32
    queue_properties::QueueProperties
    reserved3::NTuple{2, UInt32}
    queue_inactive_signal::Signal
    reserved4::NTuple{14, UInt32}
end

struct AMDSignal
    kind::SignalKind
    event_mailbox_ptr::UInt64
    event_id::UInt32
    reserved1::UInt32
    start_ts::UInt64
    end_ts::UInt64
    reserved3::NTuple{2, UInt32}
end

struct APITableVersion
    major_id::UInt32
    minor_id::UInt32
    step_id::UInt32
    reserved::UInt32
end

#=
struct HSAAPITable
    version::APITableVersion
    core::Ptr{CoreAPITable}
    AMD_ext::Ptr{AMDExtTable}
    finalizer_ext::Ptr{FinalizerExtTable}
    image_ext::Ptr{ImageExtTable}
end
=#
struct Image
    handle::UInt64
end

struct ImageFormat
    channel_type::ImageChannelType
    channel_order::ImageChannelOrder
end


struct ExtImageDescriptor
    geometry::ImageGeometry
    width::UInt64
    height::UInt64
    depth::UInt64
    array_size::UInt64
    format::ImageFormat
end

struct ImageDataInfo
    size::UInt64
    alignment::UInt64
end

struct ImageRegion
    offset::Dim3
    range::Dim3
end

struct Sampler
    handle::UInt64
end

struct ExtSamplerDescriptor
    coordinate_mode::SamplerCoordinateMode
    filter_mode::SamplerFilterMode
    address_mode::SamplerAddressingMode
end

struct Images_1_00Pfn
    image_get_capability::Ptr{Cvoid}
    image_data_get_info::Ptr{Cvoid}
    image_create::Ptr{Cvoid}
    image_destroy::Ptr{Cvoid}
    image_copy::Ptr{Cvoid}
    image_import::Ptr{Cvoid}
    image_export::Ptr{Cvoid}
    image_clear::Ptr{Cvoid}
    sampler_create::Ptr{Cvoid}
    sampler_destroy::Ptr{Cvoid}
end

struct Images_1Pfn
    image_get_capability::Ptr{Cvoid}
    image_data_get_info::Ptr{Cvoid}
    image_create::Ptr{Cvoid}
    image_destroy::Ptr{Cvoid}
    image_copy::Ptr{Cvoid}
    image_import::Ptr{Cvoid}
    image_export::Ptr{Cvoid}
    image_clear::Ptr{Cvoid}
    sampler_create::Ptr{Cvoid}
    sampler_destroy::Ptr{Cvoid}
    image_get_capability_with_layout::Ptr{Cvoid}
    image_data_get_info_with_layout::Ptr{Cvoid}
    image_create_with_layout::Ptr{Cvoid}
end

struct AMDHDPFlush
    HDP_MEM_FLUSH_CNTL::Ptr{UInt32}
    HDP_REG_FLUSH_CNTL::Ptr{UInt32}
end

struct ProfilingDispatchTime
    start::UInt64
    _end::UInt64
end

struct ProfilingAsyncCopyTime
    start::UInt64
    _end::UInt64
end

struct MemoryPool
    handle::UInt64
end

struct PitchedPtr
    base::Ptr{Cvoid}
    pitch::UInt64
    slice::UInt64
end

struct MemoryPoolLinkInfo
    min_latency::UInt32
    max_latency::UInt32
    min_bandwidth::UInt32
    max_bandwidth::UInt32
    atomic_support_32bit::Bool
    atomic_support_64bit::Bool
    coherent_support::Bool
    link_type::LinkInfoType
    numa_distance::UInt32
end

struct AMDImageDescriptor
    version::UInt32
    deviceID::UInt32
    data::NTuple{1, UInt32}
end

struct PointerInfo
    size::UInt32
    type::PointerType
    agentBaseAddress::Ptr{Cvoid}
    hostBaseAddress::Ptr{Cvoid}
    sizeInBytes::UInt64
    userData::Ptr{Cvoid}
    agentOwner::Agent
end

struct IPCMemory
    handle::NTuple{8, UInt32}
end

const IPCSignal = IPCMemory

struct GpuMemoryFaultInfo
    agent::Agent
    virtual_address::UInt64
    fault_reason_mask::UInt32
end

struct Event
    event_type::AMDEventType
end

struct ExtToolsExceptionPolicy
    exception_mask::UInt32
    wave_action::WaveAction
    host_action::HostAction
    wave_mode::WaveMode
end

struct DispatchDebugInfo
    scratch_memory_descriptor::NTuple{4, UInt32}
    global_memory_descriptor::NTuple{4, UInt32}
end

struct WaveMsgAmdGen2
    ui32::UInt32
    reserved0::UInt32
end


struct WaveControlMessage
    memory_va::Ptr{Cvoid}
end

struct KernelExecutionMode
    ui32::UInt32
end

struct ExtProgram
    handle::UInt64
end

struct ExtControlDirectives
    control_directives_mask::UInt64
    break_exceptions_mask::UInt16
    detect_exceptions_mask::UInt16
    max_dynamic_group_size::UInt32
    max_flat_grid_size::UInt64
    max_flat_workgroup_size::UInt32
    reserved1::UInt32
    required_grid_size::NTuple{3, UInt64}
    required_workgroup_size::Dim3
    required_dim::UInt8
    reserved2::NTuple{75, UInt8}
end

struct ExtFinalizer_1_00Pfn
    EXT_program_create::Ptr{Cvoid}
    EXT_program_destroy::Ptr{Cvoid}
    EXT_program_add_module::Ptr{Cvoid}
    EXT_program_iterate_modules::Ptr{Cvoid}
    EXT_program_get_info::Ptr{Cvoid}
    EXT_program_finalize::Ptr{Cvoid}
end

struct AQLProfileEvent
    block_name::AQLProfileBlockName
    block_index::UInt32
    counter_id::UInt32
end

struct AQLProfileParameter
    parameter_name::AQLProfileParameterName
    value::UInt32
end

struct AQLProfileDescriptor
    ptr::Ptr{Cvoid}
    size::UInt32
end

struct AQLProfile
    agent::Agent
    type::AQLProfileEventType
    events::Ptr{AQLProfileEvent}
    event_count::UInt32
    parameters::Ptr{AQLProfileParameter}
    parameter_count::UInt32
    output_buffer::AQLProfileDescriptor
    command_buffer::AQLProfileDescriptor
end

struct AQLPm4Packet
    header::UInt16
    pm4_command::NTuple{27, UInt16}
    completion_signal::Signal
end

struct AQLProfileInfoData
    sample_id::UInt32
end

struct AQLProfileIDQuery
    name::Cstring
    id::UInt32
    instance_count::UInt32
end

struct AQLProfile_1_00Pfn
    version_major::Ptr{Cvoid}
    version_minor::Ptr{Cvoid}
    error_string::Ptr{Cvoid}
    validate_event::Ptr{Cvoid}
    start::Ptr{Cvoid}
    stop::Ptr{Cvoid}
    read::Ptr{Cvoid}
    legacy_get_pm4::Ptr{Cvoid}
    get_info::Ptr{Cvoid}
    iterate_data::Ptr{Cvoid}
end

struct SegmentDescriptor
    agent::Agent
    executable::Executable
    code_object_storage_type::CodeObjectStorageType
    code_object_storage_base::Ptr{Cvoid}
    code_object_storage_size::UInt64
    code_object_storage_offset::UInt64
    segment_base::Ptr{Cvoid}
    segment_size::UInt64
end

struct AMDLoader_1_00Pfn
    host_address::Ptr{Cvoid}
    segment_descriptors::Ptr{Cvoid}
    executable::Ptr{Cvoid}
end

struct AMDLoader_1_01Pfn
    query_host_address::Ptr{Cvoid}
    query_segment_descriptors::Ptr{Cvoid}
    query_executable::Ptr{Cvoid}
    executable_iterate_loaded_code_objects::Ptr{Cvoid}
    loaded_code_object_get_info::Ptr{Cvoid}
end

