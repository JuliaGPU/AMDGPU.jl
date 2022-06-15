# Utilities for working with HSA agents

mutable struct HSAAgent
    agent::HSA.Agent

    # Cached information
    type::HSA.DeviceType
    name::String
    productname::String
    uuid::String

    function HSAAgent(handle::HSA.Agent)
        agent = new(handle)
        agent.type = device_type(agent)
        agent.name = name(agent)
        agent.productname = product_name(agent)
        agent.uuid = uuid(agent)

        agent
    end
end

Base.:(==)(agent1::HSAAgent, agent2::HSAAgent) = agent1.agent == agent2.agent

const DEFAULT_AGENT = Ref{HSAAgent}()
const ALL_AGENTS = Vector{HSAAgent}()
const AGENTS = IdDict{UInt64, HSAAgent}() # Map from agent handles to HSAAgent structs

### @cfunction callbacks ###

function agent_iterate_isas_cb(isa::HSA.ISA, isas)
    push!(isas, isa)
    return HSA.STATUS_SUCCESS
end

function iterate_agents_cb(agent::HSA.Agent, agents)
    push!(agents, HSAAgent(agent))
    return HSA.STATUS_SUCCESS
end

"""
    fetch_agents() -> Vector{HSAAgent}

Returns the list of HSA agents available on the system.
"""
function fetch_agents()
    if !isempty(ALL_AGENTS)
        return copy(ALL_AGENTS)
    end

    agents = Ref(Vector{HSAAgent}())
    GC.@preserve agents begin
        func = @cfunction(iterate_agents_cb, HSA.Status,
                (HSA.Agent, Ref{Vector{HSAAgent}}))
        HSA.iterate_agents(func, agents) |> check
        _agents = agents[]
    end

    # Update the entries in the agent handle dictionary
    for agent in _agents
        push!(ALL_AGENTS, agent)
        AGENTS[agent.agent.handle] = agent
    end

    return _agents
end

"""
    get_default_agent() -> HSAAgent

Returns the default agent, which is used for all kernel and array operations
when one is not explicitly specified. May be changed with
[`set_default_agent!`](@ref).
"""
function get_default_agent()
    if !isassigned(DEFAULT_AGENT)
        error("No GPU agents detected!\nPlease consider rebuilding AMDGPU")
    end
    DEFAULT_AGENT[]
end
"""
    set_default_agent!(agent::HSAAgent) -> HSAAgent

Sets the default agent to `agent`. See [`get_default_agent`](@ref) for more
details.
"""
function set_default_agent!(agent::HSAAgent)
    DEFAULT_AGENT[] = agent
end

function name(agent::HSAAgent)
    #len = Ref(0)
    #hsa_agent_get_info(agent.agent, HSA.AGENT_INFO_NAME_LENGTH, len) |> check
    name = Vector{UInt8}(undef, 64)
    getinfo(agent.agent, HSA.AGENT_INFO_NAME, name) |> check
    return GC.@preserve name unsafe_string(pointer(name))
end

"""
Return all agents available to the runtime.
"""
agents() = copy(ALL_AGENTS)

# Pretty-printing
function Base.show(io::IO, agent::HSAAgent)
    name = agent.uuid

    name *= if agent.name == agent.productname || isempty(agent.productname)
        " [$(agent.name)]"
    else
        " [$(agent.productname) ($(agent.name))]"
    end

    print(io, name)
end

### Agent details

product_name(agent::HSAAgent) = product_name(agent.agent)
function product_name(agent::HSA.Agent)
    name = Vector{UInt8}(undef, 64)
    getinfo(agent, HSA.AMD_AGENT_INFO_PRODUCT_NAME, name) |> check
    rstrip(String(name), '\0')
end

uuid(agent::HSAAgent) = uuid(agent.agent)
function uuid(agent::HSA.Agent)
    uuid = Base.zeros(UInt8, 64) # Doesn't appear to write zero-terminator
    getinfo(agent, HSA.AMD_AGENT_INFO_UUID, uuid) |> check
    rstrip(String(uuid), '\0')
end

profile(agent::HSAAgent) = profile(agent.agent)
function profile(agent::HSA.Agent)
    profile = Ref{HSA.Profile}()
    getinfo(agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    return profile[]
end

device_type(agent::HSAAgent) = device_type(agent.agent)
function device_type(agent::HSA.Agent)
    devtype = Ref{HSA.DeviceType}()
    getinfo(agent, HSA.AGENT_INFO_DEVICE, devtype) |> check
    return devtype[]
end

function getinfo(agent::HSA.Agent, attribute::HSA.AgentInfo,
                 value::Union{Vector,Base.RefValue,String})
    # TODO: allocation/create Refs here
    # based on value of AgentInfo
    HSA.agent_get_info(agent, attribute, value)
end
getinfo(agent::HSA.Agent, info::HSA.AMDAgentInfo, ret::Union{String, Base.RefValue, Vector}) =
    getinfo(agent, reinterpret(HSA.AgentInfo, info), ret)

### ISAs

isas(agent::HSAAgent) = isas(agent.agent)
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
    m = parse_isa(isa)
    arch = m.captures[4]
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
    return (arch, features)
end
architecture(isa::HSA.ISA) = llvm_arch_features(isa)[1]
features(isa::HSA.ISA) = llvm_arch_features(isa)[2]

function max_group_size(isa::HSA.ISA)
    size = Ref{UInt32}(0)
    getinfo(isa, HSA.ISA_INFO_WORKGROUP_MAX_SIZE, size)
    size[]
end

function getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.isa_get_info_alt(isa, attribute, value)
end

### Regions

struct HSARegion
    region::HSA.Region
end

function iterate_regions_cb(region::HSA.Region, regions)
    push!(regions, region)
    return HSA.STATUS_SUCCESS
end

function regions(agent::HSAAgent)
    regions = Ref(HSA.Region[])
    func = @cfunction(iterate_regions_cb, HSA.Status, (HSA.Region, Ref{Vector{HSA.Region}}))
    HSA.agent_iterate_regions(agent.agent, func, regions) |> check
    map(HSARegion, regions[])
end

function getinfo(region::HSA.Region, attribute::HSA.RegionInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.region_get_info(region, attribute, value) |> check
end

function region_segment(region::HSARegion)
    segment = Ref{HSA.RegionSegment}()
    getinfo(region.region, HSA.REGION_INFO_SEGMENT, segment)
    segment[]
end
function region_global_flags(region::HSARegion)
    flags = Ref{HSA.RegionGlobalFlag}()
    getinfo(region.region, HSA.REGION_INFO_GLOBAL_FLAGS, flags)
    flags[]
end
function region_size(region::HSARegion)
    size = Ref{Csize_t}(0)
    getinfo(region.region, HSA.REGION_INFO_SIZE, size)
    size[]
end
function region_alloc_max_size(region::HSARegion)
    size = Ref{Csize_t}(0)
    getinfo(region.region, HSA.REGION_INFO_ALLOC_MAX_SIZE, size)
    size[]
end
function region_alloc_max_private_workgroup_size(region::HSARegion)
    size = Ref{Csize_t}(0)
    getinfo(region.region, HSA.REGION_INFO_ALLOC_MAX_PRIVATE_WORKGROUP_SIZE, size)
    size[]
end
function region_runtime_alloc_allowed(region::HSARegion)
    runtime_alloc = Ref{Bool}(false)
    getinfo(region.region, HSA.REGION_INFO_RUNTIME_ALLOC_ALLOWED, runtime_alloc)
    runtime_alloc[]
end
function region_runtime_alloc_granule(region::HSARegion)
    runtime_alloc_granule = Ref{Csize_t}(0)
    getinfo(region.region, HSA.REGION_INFO_RUNTIME_ALLOC_GRANULE, runtime_alloc_granule)
    runtime_alloc_granule[]
end
function region_runtime_alloc_alignment(region::HSARegion)
    runtime_alloc_align = Ref{Csize_t}(0)
    getinfo(region.region, HSA.REGION_INFO_RUNTIME_ALLOC_ALIGNMENT, runtime_alloc_align)
    runtime_alloc_align[]
end
function region_host_accessible(region::HSARegion)
    host_accessible = Ref(false)
    getinfo(region.region,
            reinterpret(HSA.RegionInfo, HSA.AMD_REGION_INFO_HOST_ACCESSIBLE),
            host_accessible)
    host_accessible[]
end

function get_region(agent::HSAAgent, kind::Symbol)
    _regions = regions(agent)
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
    @assert !isempty(_regions) "No region of kind $kind in agent $agent"
    return first(_regions)
end

function Base.show(io::IO, region::HSARegion)
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

    print(io, "HSARegion @ $(repr(region.region.handle)): Segment $segment, Flags $flags, Size $size ($max_size max allocation), ")
    if segment == :private
        print(io, "Workgroup Max Alloc: $private_workgroup_size, ")
    end
    print(io, "Runtime Alloc: "); printstyled(io, "$runtime_alloc"; color=runtime_alloc ? :green : :red); print(io, " ($alloc_granule granularity, $alloc_align alignment), ")
    print(io, "Host Accessible: "); printstyled(io, "$host_access"; color=host_access ? :green : :red)
end

### Memory Pools

struct HSAMemoryPool
    pool::HSA.AMDMemoryPool
end

function iterate_pools_cb(pool::HSA.AMDMemoryPool, pools)
    push!(pools, pool)
    return HSA.STATUS_SUCCESS
end

function memory_pools(agent::HSAAgent)
    pools = Ref(HSA.AMDMemoryPool[])
    func = @cfunction(iterate_pools_cb, HSA.Status, (HSA.AMDMemoryPool, Ref{Vector{HSA.AMDMemoryPool}}))
    HSA.amd_agent_iterate_memory_pools(agent.agent, func, pools) |> check
    map(HSAMemoryPool, pools[])
end

function getinfo(pool::HSA.AMDMemoryPool, attribute::HSA.AMDMemoryPoolInfo,
                 value::Union{Vector,Base.RefValue,String})
    HSA.amd_memory_pool_get_info(pool, attribute, value) |> check
end

function pool_segment(pool::HSAMemoryPool)
    segment = Ref{HSA.AMDSegment}()
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_SEGMENT, segment)
    segment[]
end
function pool_global_flags(pool::HSAMemoryPool)
    flags = Ref{HSA.AMDMemoryPoolGlobalFlag}()
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_GLOBAL_FLAGS, flags)
    flags[]
end
function pool_size(pool::HSAMemoryPool)
    size = Ref{Csize_t}(0)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_SIZE, size)
    size[]
end
function pool_runtime_alloc_allowed(pool::HSAMemoryPool)
    runtime_alloc = Ref{Bool}(false)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALLOWED, runtime_alloc)
    runtime_alloc[]
end
function pool_runtime_alloc_granule(pool::HSAMemoryPool)
    runtime_alloc_granule = Ref{Csize_t}(0)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_GRANULE, runtime_alloc_granule)
    runtime_alloc_granule[]
end
function pool_runtime_alloc_alignment(pool::HSAMemoryPool)
    runtime_alloc_align = Ref{Csize_t}(0)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_RUNTIME_ALLOC_ALIGNMENT, runtime_alloc_align)
    runtime_alloc_align[]
end
function pool_accessible_by_all(pool::HSAMemoryPool)
    accessible_all = Ref{Bool}(false)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_ACCESSIBLE_BY_ALL, accessible_all)
    accessible_all[]
end
function pool_alloc_max_size(pool::HSAMemoryPool)
    size = Ref{Csize_t}(0)
    getinfo(pool.pool, HSA.AMD_MEMORY_POOL_INFO_ALLOC_MAX_SIZE, size)
    size[]
end

function Base.show(io::IO, pool::HSAMemoryPool)
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

    print(io, "HSAMemoryPool @ $(repr(pool.pool.handle)): Segment $segment, Flags $flags, Size $size ($max_size max allocation), ")
    print(io, "Runtime Alloc: "); printstyled(io, "$runtime_alloc"; color=runtime_alloc ? :green : :red); print(io, " ($alloc_granule granularity, $alloc_align alignment), ")
    print(io, "All Accessible: "); printstyled(io, "$accessible_all"; color=accessible_all ? :green : :red)
end

function get_memory_pool(agent::HSAAgent, kind::Symbol)
    _pools = memory_pools(agent)
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
    @assert !isempty(_pools) "No memory pool of kind $kind in agent $agent"
    return first(_pools)
end
