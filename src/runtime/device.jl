# Utilities for working with HSA devices

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
ROCDevice() = get_default_device()
get_handle(device::ROCDevice) = device.agent.handle

Base.:(==)(device1::ROCDevice, device2::ROCDevice) =
    device1.agent == device2.agent

const DEFAULT_DEVICE = Ref{ROCDevice}()
const ALL_DEVICES = Vector{ROCDevice}()
const DEVICES = Dict{UInt64, ROCDevice}() # Map from device handles to ROCDevice structs

### @cfunction callbacks ###

function agent_iterate_isas_cb(isa::HSA.ISA, isas)
    push!(isas, isa)
    return HSA.STATUS_SUCCESS
end

function iterate_agents_cb(agent::HSA.Agent, devices)
    push!(devices, ROCDevice(agent))
    return HSA.STATUS_SUCCESS
end

"""
    fetch_devices() -> Vector{ROCDevice}

Returns the list of HSA devices available on the system.
"""
function fetch_devices()
    if !isempty(ALL_DEVICES)
        return copy(ALL_DEVICES)
    end

    devices = Ref(Vector{ROCDevice}())
    GC.@preserve devices begin
        func = @cfunction(iterate_agents_cb, HSA.Status,
                (HSA.Agent, Ref{Vector{ROCDevice}}))
        HSA.iterate_agents(func, devices) |> check
        _devices = devices[]
    end

    # Update the entries in the device handle dictionary
    for device in _devices
        push!(ALL_DEVICES, device)
        DEVICES[device.agent.handle] = device
    end

    return _devices
end

"""
    get_default_device() -> ROCDevice

Returns the default device, which is used for all kernel and array operations
when one is not explicitly specified. May be changed with
[`set_default_device!`](@ref).
"""
function get_default_device()
    if !isassigned(DEFAULT_DEVICE)
        error("No GPU devices detected!\nPlease consider rebuilding AMDGPU")
    end
    DEFAULT_DEVICE[]
end
"""
    set_default_device!(device::ROCDevice) -> ROCDevice

Sets the default device to `device`. See [`get_default_device`](@ref) for more
details.
"""
function set_default_device!(device::ROCDevice)
    DEFAULT_DEVICE[] = device
end

"Return all devices available to the runtime."
devices() = copy(ALL_DEVICES)

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

getinfo(agent::HSA.Agent, attribute::HSA.AgentInfo,
        value::Union{Vector, Base.RefValue}) =
    HSA.agent_get_info(agent, attribute, value)
getinfo(agent::HSA.Agent, info::HSA.AMDAgentInfo,
        value::Union{Vector, Base.RefValue}) =
    getinfo(agent, reinterpret(HSA.AgentInfo, info), value)

const AGENT_INFO_MAP = Dict(
    HSA.AGENT_INFO_NAME => Vector{UInt8},
    HSA.AMD_AGENT_INFO_PRODUCT_NAME => Vector{UInt8},
    HSA.AMD_AGENT_INFO_UUID => Vector{UInt8},
    HSA.AGENT_INFO_PROFILE => HSA.Profile,
    HSA.AGENT_INFO_DEVICE => HSA.DeviceType,

    HSA.AGENT_INFO_QUEUE_MAX_SIZE => UInt32,
    HSA.AGENT_INFO_QUEUE_TYPE => HSA.QueueType,

    HSA.AGENT_INFO_WAVEFRONT_SIZE => UInt32, # TODO: Deprecated
    HSA.AGENT_INFO_WORKGROUP_MAX_SIZE => UInt32,
    HSA.AMD_AGENT_INFO_COMPUTE_UNIT_COUNT => UInt32,
    HSA.AMD_AGENT_INFO_NUM_SIMDS_PER_CU => UInt32,
)
getinfo_map(::HSA.Agent) = AGENT_INFO_MAP

getinfo(device::ROCDevice, query) = getinfo(device.agent, query)

const AnyROCDevice = Union{ROCDevice,HSA.Agent}

name(device::AnyROCDevice) =
    getinfo(device, HSA.AGENT_INFO_NAME)

product_name(device::AnyROCDevice) =
    getinfo(device, HSA.AMD_AGENT_INFO_PRODUCT_NAME)

uuid(device::AnyROCDevice) =
    getinfo(device, HSA.AMD_AGENT_INFO_UUID)

profile(device::AnyROCDevice) =
    getinfo(device, HSA.AGENT_INFO_PROFILE)

device_type(device::AnyROCDevice) =
    getinfo(device, HSA.AGENT_INFO_DEVICE)

device_wavefront_size(device::AnyROCDevice) =
    getinfo(device, HSA.AGENT_INFO_WAVEFRONT_SIZE)

device_workgroup_max_size(device::AnyROCDevice) =
    getinfo(device, HSA.AGENT_INFO_WORKGROUP_MAX_SIZE)

device_num_compute_units(device::AnyROCDevice) =
    getinfo(device, HSA.AMD_AGENT_INFO_COMPUTE_UNIT_COUNT)

device_num_simds_per_compute_unit(device::AnyROCDevice) =
    getinfo(device, HSA.AMD_AGENT_INFO_NUM_SIMDS_PER_CU)

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

isas(device::ROCDevice) = isas(device.agent)
function isas(agent::HSA.Agent)
    isas = Ref(HSA.ISA[])
    func = @cfunction(agent_iterate_isas_cb, HSA.Status, (HSA.ISA, Ref{Vector{HSA.ISA}}))
    HSA.agent_iterate_isas(agent, func, isas) |> check
    isas[]
end

# TODO: PCRE regexes are not thread-safe
const isa_regex = r"([a-z]*)-([a-z]*)-([a-z]*)--([a-z0-9]*)([a-zA-Z0-9+\-:]*)"
function parse_isa(isa::HSA.ISA)
    len = Ref{Cuint}(0)
    getinfo(isa, HSA.ISA_INFO_NAME_LENGTH, len) |> check
    name = Vector{UInt8}(undef, len[])
    getinfo(isa, HSA.ISA_INFO_NAME, name) |> check
    name = String(name)
    m = match(isa_regex, name)
    @assert m !== nothing "Failed to match ISA name pattern: $name"
    m
end

function llvm_arch_features(isa::HSA.ISA)
    @memoize isa::HSA.ISA begin
    m = parse_isa(isa)
    arch = String(m.captures[4])
    features = join(map(x->x[1:end-1],
                        filter(x->!isempty(x) && (x[end]=='+'),
                               split(m.captures[5], ':'))),
                    ",+")
    if !isempty(features)
        features = '+'*features
    end
    if Base.libllvm_version < v"12"
        features = replace(features, "sramecc"=>"sram-ecc")
    end
    (arch, features)
    end::Tuple{String, String}
end
architecture(isa::HSA.ISA) = llvm_arch_features(isa)[1]
features(isa::HSA.ISA) = llvm_arch_features(isa)[2]

getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo,
        value::Union{Vector, Base.RefValue}) =
    HSA.isa_get_info_alt(isa, attribute, value)

const ISA_INFO_MAP = Dict(
    HSA.ISA_INFO_WORKGROUP_MAX_SIZE => UInt32,
)
getinfo_map(::HSA.ISA) = ISA_INFO_MAP

isa_workgroup_max_size(isa::HSA.ISA) =
    getinfo(isa, HSA.ISA_INFO_WORKGROUP_MAX_SIZE)

### Regions

struct ROCMemoryRegion
    region::HSA.Region
end
get_handle(region::ROCMemoryRegion) = region.region.handle

function iterate_regions_cb(region::HSA.Region, regions)
    push!(regions, region)
    return HSA.STATUS_SUCCESS
end

function regions(agent::HSA.Agent)
    regions = Ref(HSA.Region[])
    func = @cfunction(iterate_regions_cb, HSA.Status, (HSA.Region, Ref{Vector{HSA.Region}}))
    HSA.agent_iterate_regions(agent, func, regions) |> check
    return map(ROCMemoryRegion, regions[])
end
regions(device::ROCDevice) = regions(device.agent)

getinfo(region::HSA.Region, attribute::HSA.RegionInfo,
        value::Union{Vector,Base.RefValue}) =
    HSA.region_get_info(region, attribute, value)
getinfo(region::HSA.Region, attribute::HSA.AMDRegionInfo,
        value::Union{Vector,Base.RefValue}) =
            getinfo(region, reinterpret(HSA.RegionInfo, attribute), value)

const REGION_INFO_MAP = Dict(
    HSA.REGION_INFO_SEGMENT => HSA.RegionSegment,
    HSA.REGION_INFO_GLOBAL_FLAGS => HSA.RegionGlobalFlag,
    HSA.REGION_INFO_SIZE => Csize_t,
    HSA.REGION_INFO_ALLOC_MAX_SIZE => Csize_t,
    HSA.REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE => Csize_t,
    HSA.REGION_INFO_RUNTIME_ALLOC_ALLOWED => Bool,
    HSA.REGION_INFO_RUNTIME_ALLOC_GRANULE => Csize_t,
    HSA.REGION_INFO_RUNTIME_ALLOC_ALIGNMENT => Csize_t,
    HSA.AMD_REGION_INFO_HOST_ACCESSIBLE => Bool,
)
getinfo_map(::HSA.Region) = REGION_INFO_MAP

getinfo(region::ROCMemoryRegion, query) = getinfo(region.region, query)

const AnyROCMemoryRegion = Union{ROCMemoryRegion,HSA.Region}

region_segment(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_SEGMENT)
region_global_flags(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_GLOBAL_FLAGS)
region_size(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_SIZE)
region_alloc_max_size(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_ALLOC_MAX_SIZE)
region_alloc_max_private_workgroup_size(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE)
region_runtime_alloc_allowed(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_RUNTIME_ALLOC_ALLOWED)
region_runtime_alloc_granule(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_RUNTIME_ALLOC_GRANULE)
region_runtime_alloc_alignment(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.REGION_INFO_RUNTIME_ALLOC_ALIGNMENT)
region_host_accessible(region::AnyROCMemoryRegion) =
    getinfo(region, HSA.AMD_REGION_INFO_HOST_ACCESSIBLE)

function get_region(device::ROCDevice, kind::Symbol)
    _regions = regions(device)
    flag = if kind == :finegrained
        HSA.REGION_GLOBAL_FLAG_FINE_GRAINED
    elseif kind == :coarsegrained || kind == :coarsegrained_host
        HSA.REGION_GLOBAL_FLAG_COARSE_GRAINED
    elseif kind == :kernarg
        HSA.REGION_GLOBAL_FLAG_KERNARG
    else
        error("Region kind $kind not supported")
    end
    _regions = filter(region->region_global_flags(region) & flag > 0, _regions)
    if kind == :coarsegrained
        _regions = filter(region->!region_host_accessible(region), _regions)
    end
    @assert !isempty(_regions) "No region of kind $kind in device $device"
    return first(_regions)
end

function Base.show(io::IO, region::ROCMemoryRegion)
    segment_map = Dict(HSA.REGION_SEGMENT_GLOBAL   => :global,
                       HSA.REGION_SEGMENT_READONLY => :readonly,
                       HSA.REGION_SEGMENT_PRIVATE  => :private,
                       HSA.REGION_SEGMENT_GROUP    => :group,
                       HSA.REGION_SEGMENT_KERNARG  => :kernarg)
    segment = segment_map[region_segment(region)]

    _flags = region_global_flags(region)
    flags = Symbol[]
    flag_map = Dict(UInt32(HSA.REGION_GLOBAL_FLAG_KERNARG)        => :kernarg,
                    UInt32(HSA.REGION_GLOBAL_FLAG_FINE_GRAINED)   => :finegrained,
                    UInt32(HSA.REGION_GLOBAL_FLAG_COARSE_GRAINED) => :coarsegrained)
    for (flag, flag_name) in CEnum.namemap(HSA.RegionGlobalFlag)
        if flag & _flags > 0
            push!(flags, flag_map[flag])
        end
    end
    flags = "($(join(flags, ", ")))"

    size = Base.format_bytes(region_size(region))

    private_workgroup_size = segment == :private ? Base.format_bytes(region_alloc_max_private_workgroup_size(region)) : nothing

    runtime_alloc = region_runtime_alloc_allowed(region)

    alloc_granule = Base.format_bytes(region_runtime_alloc_granule(region))

    alloc_align = Base.format_bytes(region_runtime_alloc_alignment(region))

    max_size = Base.format_bytes(region_alloc_max_size(region))

    host_access = region_host_accessible(region)

    print(io, "ROCMemoryRegion @ $(repr(region.region.handle)): Segment $segment, Flags $flags, Size $size ($max_size max allocation), ")
    if segment == :private
        print(io, "Workgroup Max Alloc: $private_workgroup_size, ")
    end
    print(io, "Runtime Alloc: "); printstyled(io, "$runtime_alloc"; color=runtime_alloc ? :green : :red); print(io, " ($alloc_granule granularity, $alloc_align alignment), ")
    print(io, "Host Accessible: "); printstyled(io, "$host_access"; color=host_access ? :green : :red)
end

### Memory Pools

struct ROCMemoryPool
    pool::HSA.AMDMemoryPool
end
get_handle(pool::ROCMemoryPool) = pool.pool.handle

function iterate_pools_cb(pool::HSA.AMDMemoryPool, pools)
    push!(pools, pool)
    return HSA.STATUS_SUCCESS
end

function memory_pools(agent::HSA.Agent)
    pools = Ref(HSA.AMDMemoryPool[])
    func = @cfunction(iterate_pools_cb, HSA.Status, (HSA.AMDMemoryPool, Ref{Vector{HSA.AMDMemoryPool}}))
    HSA.amd_agent_iterate_memory_pools(agent, func, pools) |> check
    return map(ROCMemoryPool, pools[])
end
memory_pools(device::ROCDevice) = memory_pools(device.agent)

getinfo(pool::HSA.AMDMemoryPool, attribute::HSA.AMDMemoryPoolInfo,
        value::Union{Vector,Base.RefValue}) =
    HSA.amd_memory_pool_get_info(pool, attribute, value)

const POOL_INFO_MAP = Dict(
    HSA.AMD_MEMORY_POOL_INFO_SEGMENT => HSA.AMDSegment,
    HSA.AMD_MEMORY_POOL_INFO_GLOBAL_FLAGS => HSA.AMDMemoryPoolGlobalFlag,
    HSA.AMD_MEMORY_POOL_INFO_SIZE => Csize_t,
    HSA.AMD_MEMORY_POOL_INFO_ALLOC_MAX_SIZE => Csize_t,
    HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALLOWED => Bool,
    HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_GRANULE => Csize_t,
    HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALIGNMENT => Csize_t,
    HSA.AMD_MEMORY_POOL_INFO_ACCESSIBLE_BY_ALL => Bool,
)
getinfo_map(::HSA.AMDMemoryPool) = POOL_INFO_MAP

getinfo(pool::ROCMemoryPool, query) = getinfo(pool.pool, query)

const AnyROCMemoryPool = Union{ROCMemoryPool, HSA.AMDMemoryPool}

pool_segment(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_SEGMENT)
pool_global_flags(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_GLOBAL_FLAGS)
pool_size(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_SIZE)
pool_alloc_max_size(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_ALLOC_MAX_SIZE)
pool_runtime_alloc_allowed(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALLOWED)
pool_runtime_alloc_granule(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_GRANULE)
pool_runtime_alloc_alignment(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALIGNMENT)
pool_accessible_by_all(pool::AnyROCMemoryPool) =
    getinfo(pool, HSA.AMD_MEMORY_POOL_INFO_ACCESSIBLE_BY_ALL)

function Base.show(io::IO, pool::ROCMemoryPool)
    segment_map = Dict(HSA.AMD_SEGMENT_GLOBAL   => :global,
                       HSA.AMD_SEGMENT_READONLY => :readonly,
                       HSA.AMD_SEGMENT_PRIVATE  => :private,
                       HSA.AMD_SEGMENT_GROUP    => :group)
    segment = segment_map[pool_segment(pool)]

    _flags = pool_global_flags(pool)
    flags = Symbol[]
    flag_map = Dict(UInt32(HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_KERNARG_INIT)   => :kernarg,
                    UInt32(HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_FINE_GRAINED)   => :finegrained,
                    UInt32(HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_COARSE_GRAINED) => :coarsegrained)
    for (flag, flag_name) in CEnum.namemap(HSA.AMDMemoryPoolGlobalFlag)
        if flag & _flags > 0
            push!(flags, flag_map[flag])
        end
    end
    flags = "($(join(flags, ", ")))"

    size = Base.format_bytes(pool_size(pool))

    runtime_alloc = pool_runtime_alloc_allowed(pool)

    alloc_granule = Base.format_bytes(pool_runtime_alloc_granule(pool))

    alloc_align = Base.format_bytes(pool_runtime_alloc_alignment(pool))

    accessible_all = pool_accessible_by_all(pool)

    max_size = Base.format_bytes(pool_alloc_max_size(pool))

    print(io, "ROCMemoryPool @ $(repr(pool.pool.handle)): Segment $segment, Flags $flags, Size $size ($max_size max allocation), ")
    print(io, "Runtime Alloc: "); printstyled(io, "$runtime_alloc"; color=runtime_alloc ? :green : :red); print(io, " ($alloc_granule granularity, $alloc_align alignment), ")
    print(io, "All Accessible: "); printstyled(io, "$accessible_all"; color=accessible_all ? :green : :red)
end

function get_memory_pool(device::ROCDevice, kind::Symbol)
    _pools = memory_pools(device)
    flag = if kind == :finegrained
        HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_FINE_GRAINED
    elseif kind == :coarsegrained || kind == :coarsegrained_host
        HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_COARSE_GRAINED
    elseif kind == :kernarg
        HSA.AMD_MEMORY_POOL_GLOBAL_FLAG_KERNARG_INIT
    else
        error("Region kind $kind not supported")
    end
    _pools = filter(pool->pool_global_flags(pool) & flag > 0, _pools)
    if kind == :coarsegrained
        _pools = filter(pool->!pool_accessible_by_all(pool), _pools)
    end
    @assert !isempty(_pools) "No memory pool of kind $kind in device $device"
    return first(_pools)
end
