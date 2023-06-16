mutable struct ROCDevice
    agent::HSA.Agent

    # Cached information
    type::HSA.DeviceType
    name::String
    productname::String
    uuid::String

    function ROCDevice(handle::HSA.Agent)
        device = new(handle)
        device.type = device_type(device)
        device.name = name(device)
        device.productname = product_name(device)
        device.uuid = uuid(device)

        return device
    end
end
ROCDevice() = AMDGPU.device()
get_handle(device::ROCDevice) = device.agent.handle

Base.:(==)(device1::ROCDevice, device2::ROCDevice) =
    device1.agent == device2.agent

function agent_iterate_isas_cb(isa::HSA.ISA, isas)
    push!(isas, isa)
    return HSA.STATUS_SUCCESS
end

function iterate_agents_cb(agent::HSA.Agent, devices)
    push!(devices, ROCDevice(agent))
    return HSA.STATUS_SUCCESS
end

# Pretty-printing
function Base.show(io::IO, device::ROCDevice)
    name = device.uuid

    name *= if device.name == device.productname || isempty(device.productname)
        " [$(device.name)]"
    else
        " [$(device.productname) ($(device.name))]"
    end

    print(io, name)
end

### Device details

getinfo(
    agent::HSA.Agent, attribute::HSA.AgentInfo,
    value::Union{Vector, Base.RefValue},
) = HSA.agent_get_info(agent, attribute, value)

getinfo(
    agent::HSA.Agent, info::HSA.AMDAgentInfo,
    value::Union{Vector, Base.RefValue},
) = getinfo(agent, reinterpret(HSA.AgentInfo, info), value)

getinfo(device::ROCDevice, query, value) = getinfo(device.agent, query, value)

const AnyROCDevice = Union{ROCDevice,HSA.Agent}

name(device::AnyROCDevice) =
    getinfo(String, device, HSA.AGENT_INFO_NAME)

product_name(device::AnyROCDevice) =
    getinfo(String, device, HSA.AMD_AGENT_INFO_PRODUCT_NAME)

uuid(device::AnyROCDevice) =
    getinfo(String, device, HSA.AMD_AGENT_INFO_UUID)

profile(device::AnyROCDevice) =
    getinfo(HSA.Profile, device, HSA.AGENT_INFO_PROFILE)

device_type(device::AnyROCDevice) =
    getinfo(HSA.DeviceType, device, HSA.AGENT_INFO_DEVICE)

device_wavefront_size(device::AnyROCDevice) =
    getinfo(UInt32, device, HSA.AGENT_INFO_WAVEFRONT_SIZE)

device_workgroup_max_size(device::AnyROCDevice) =
    getinfo(UInt32, device, HSA.AGENT_INFO_WORKGROUP_MAX_SIZE)

device_num_compute_units(device::AnyROCDevice) =
    getinfo(UInt32, device, HSA.AMD_AGENT_INFO_COMPUTE_UNIT_COUNT)

device_num_simds_per_compute_unit(device::AnyROCDevice) =
    getinfo(UInt32, device, HSA.AMD_AGENT_INFO_NUM_SIMDS_PER_CU)

function device_local_memory_size(device::AnyROCDevice)
    _regions = regions(device)
    for region in _regions
        if region_segment(region) == HSA.REGION_SEGMENT_GROUP
            return region_size(region)
        end
    end
    error("Failed to find local memory region for $device")
end

### ISAs

struct HSAISA
    hsa_isa::HSA.ISA
    arch_features::Tuple{String, String}
end

function HSAISA(hsa_isa::HSA.ISA)
    HSAISA(hsa_isa, llvm_arch_features(hsa_isa))
end

isas(device::ROCDevice) = isas(device.agent)
function isas(agent::HSA.Agent)
    isas = Ref(HSA.ISA[])
    func = @cfunction(agent_iterate_isas_cb, HSA.Status, (HSA.ISA, Ref{Vector{HSA.ISA}}))
    HSA.agent_iterate_isas(agent, func, isas) |> check
    HSAISA.(isas[])
end

# Device handle => default ISA.
const DEFAULT_ISAS = Dict{UInt64, HSAISA}()

function default_isa(device::ROCDevice)
    lock(RT_LOCK) do
        get!(
            () -> first(Runtime.isas(device)),
            DEFAULT_ISAS, Runtime.get_handle(device))
    end
end

# TODO: PCRE regexes are not thread-safe
const isa_regex = r"([a-z]*)-([a-z]*)-([a-z]*)--([a-z0-9]*)([a-zA-Z0-9+\-:]*)"
function parse_isa(isa::HSA.ISA)
    len = isa_name_length(isa)
    name = Vector{UInt8}(undef, len)
    getinfo(isa, HSA.ISA_INFO_NAME, name) |> check
    name = String(name)
    m = match(isa_regex, name)
    @assert m !== nothing "Failed to match ISA name pattern: $name"
    m
end

function llvm_arch_features(isa::HSA.ISA)
    m = parse_isa(isa)
    arch = String(m.captures[4])
    features = join(map(x->x[1:end-1],
                        filter!(x->!isempty(x) && (x[end]=='+'),
                               split(m.captures[5], ':'))),
                    ",+")
    if !isempty(features)
        features = '+'*features
    end
    if Base.libllvm_version < v"12"
        features = replace(features, "sramecc"=>"sram-ecc")
    end
    (arch, features)
end

architecture(isa::HSA.ISA) = llvm_arch_features(isa)[1]

features(isa::HSA.ISA) = llvm_arch_features(isa)[2]

getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo, value::Union{Vector, Base.RefValue}) =
    HSA.isa_get_info_alt(isa, attribute, value)

isa_name_length(isa::HSA.ISA) = getinfo(Cuint, isa, HSA.ISA_INFO_NAME_LENGTH)

isa_workgroup_max_size(isa::HSA.ISA) =
    getinfo(UInt32, isa, HSA.ISA_INFO_WORKGROUP_MAX_SIZE)
