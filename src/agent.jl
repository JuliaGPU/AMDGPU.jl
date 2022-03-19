# Utilities for working with HSA agents

mutable struct HSAAgent
    agent::HSA.Agent

    # Cached information
    type::Symbol
    name::String
    productname::String
    uuid::String

    function HSAAgent(handle::HSA.Agent)
        agent = new(handle)
        agent.type = device_type(agent)
        agent.name = get_name(agent)
        agent.productname = get_product_name(agent)
        agent.uuid = get_uuid(agent)

        agent
    end
end

Base.:(==)(agent1::HSAAgent, agent2::HSAAgent) = agent1.agent == agent2.agent

const DEFAULT_AGENT = Ref{HSAAgent}()
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

@inline function get_memory_region(region::HSA.region, data::Ptr{HSA.Region}, kind)
    segment = Ref{HSA.RegionSegment}()
    HSA.region_get_info(region, HSA.REGION_INFO_SEGMENT, segment)
    # Reject non-global regions
    if (segment[] != HSA.REGION_SEGMENT_GLOBAL)
        return HSA.STATUS_SUCCESS
    end

    flags = Ref{HSA.RegionGlobalFlag}()
    HSA.region_get_info(region, HSA.REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & kind > 0)
        unsafe_store!(data, region)
        return HSA.STATUS_INFO_BREAK
    end

    return HSA.STATUS_SUCCESS
end

"Determines if a memory region can be used for kernarg allocations."
function get_kernarg_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    return get_memory_region(region, data, HSA.REGION_GLOBAL_FLAG_KERNARG)
end

"Determines if a memory region can be used for fine grained allocations."
function get_fine_grained_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    return get_memory_region(region, data, HSA.REGION_GLOBAL_FLAG_FINE_GRAINED)
end

"Determines if a memory region can be used for coarse grained allocations."
function get_coarse_grained_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    return get_memory_region(region, data, HSA.REGION_GLOBAL_FLAG_COARSE_GRAINED)
end


function iterate_regions_cb(region::HSA.Region, regions)
    push!(regions, region)
    return HSA.STATUS_SUCCESS
end

"""
    get_agents() -> Vector{HSAAgent}

Returns the list of HSA agents available on the system.
"""
function get_agents()
    agents = Ref(Vector{HSAAgent}())
    GC.@preserve agents begin
        func = @cfunction(iterate_agents_cb, HSA.Status,
                (HSA.Agent, Ref{Vector{HSAAgent}}))
        HSA.iterate_agents(func, agents) |> check
        _agents = agents[]
    end

    # Update the entries in the agent handle dictionary
    for agent in _agents
        AGENTS[agent.agent.handle] = agent
    end

    return _agents
end
get_agents(kind::Symbol) =
    filter(agent->device_type(agent)==kind, get_agents())

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

"""
    device(kind::Symbol=:gpu) -> Int

Returns the numeric ID of the current default device, which is in the range of
`1:length(AMDGPU.get_agents(kind))`. This number should be stable for all
processes on the same node, so long as any device filtering is consistently
applied (such as `ROCR_VISIBLE_DEVICES`). The [`device!`](@ref) function
accepts the same numeric ID that is produced by this function.
"""
device(kind::Symbol=:gpu) = something(findfirst(a->a==get_default_agent(), get_agents(kind)))
"""
    device!(idx::Integer, kind::Symbol=:gpu)

Sets the default device to `AMDGPU.get_agents(kind)[idx]`. See [`device`](@ref)
for details on the numbering semantics.
"""
device!(idx::Integer, kind::Symbol=:gpu) = set_default_agent!(get_agents(kind)[idx])

function get_name(agent::HSAAgent)
    #len = Ref(0)
    #hsa_agent_get_info(agent.agent, HSA.AGENT_INFO_NAME_LENGTH, len) |> check
    #FIXME: this could be better? 
    name = Vector{UInt8}(undef, 64)
    getinfo(agent.agent, HSA.AGENT_INFO_NAME, name) |> check
    return rstrip(String(name), '\0')
end

"""
Return all agents available to the runtime.
"""
agents() = collect(values(AGENTS))

# Pretty-printing
function Base.show(io::IO, agent::HSAAgent)
    name = agent.uuid

    name *= if agent.name == agent.productname
        " [$(agent.name)]"
    else
        " [$(agent.productname) ($(agent.name))]"
    end

    print(io, name)
end

### Agent details

function get_product_name(agent::HSAAgent)
    name = Vector{UInt8}(undef, 64)
    getinfo(agent.agent, HSA.AMD_AGENT_INFO_PRODUCT_NAME, name) |> check
    rstrip(String(name), '\0')
end

function get_uuid(agent::HSAAgent)
    uuid = Base.zeros(UInt8, 64) # Doesn't appear to write zero-terminator
    getinfo(agent.agent, HSA.AMD_AGENT_INFO_UUID, uuid) |> check
    rstrip(String(uuid), '\0')
end

function profile(agent::HSAAgent)
    profile = Ref{HSA.Profile}()
    getinfo(agent.agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    return profile[]
end

function device_type(agent::HSAAgent)
    devtype = Ref{UInt32}()
    getinfo(agent.agent, HSA.AGENT_INFO_DEVICE, devtype) |> check

    if HSA.DeviceType(devtype[]) == HSA.DEVICE_TYPE_CPU
        return :cpu
    elseif HSA.DeviceType(devtype[]) == HSA.DEVICE_TYPE_GPU
        return :gpu
    elseif HSA.DeviceType(devtype[]) == HSA.DEVICE_TYPE_DSP
        return :dsp
    else
        return :unknown
    end
end

### ISAs

function isas(agent::HSAAgent)
    isas = Ref(HSA.ISA[])
    func = @cfunction(agent_iterate_isas_cb, HSA.Status, (HSA.ISA, Ref{Vector{HSA.ISA}}))
    HSA.agent_iterate_isas(agent.agent, func, isas) |> check
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

get_first_isa_string(agent::HSAAgent) = architecture(first(isas(agent)))
get_first_feature_string(agent::HSAAgent) = features(first(isas(agent)))

function max_group_size(isa::HSA.ISA)
    size = Ref{UInt32}(0)
    getinfo(isa, HSA.ISA_INFO_WORKGROUP_MAX_SIZE, size)
    size[]
end

### Regions

function regions(agent::HSAAgent)
    regions = Ref(HSA.Region[])
    func = @cfunction(iterate_regions_cb, HSA.Status, (HSA.Region, Ref{Vector{HSA.Region}}))
    HSA.agent_iterate_regions(agent.agent, func, regions) |> check
    regions[]
end
function segment_type(region::HSA.Region)
    segment = Ref{HSA.RegionSegment}()
    HSA.region_get_info(region, HSA.REGION_INFO_SEGMENT, segment) |> check
    segment[]
end
function max_size(region::HSA.Region)
    size = Ref{Csize_t}(0)
    HSA.region_get_info(region, HSA.REGION_INFO_SIZE, size) |> check
    size[]
end

function get_region(agent::HSAAgent, kind::Symbol)
    region = newref!(Ref{HSA.Region}, typemax(UInt64))
    if kind == :finegrained
        func = @cfunction(get_fine_grained_memory_region_cb, HSA.Status,
                (HSA.Region, Ptr{HSA.Region}))
    elseif kind == :coarsegrained
        func = @cfunction(get_coarse_grained_memory_region_cb, HSA.Status,
                (HSA.Region, Ptr{HSA.Region}))
    elseif kind == :kernarg
        func = @cfunction(get_kernarg_memory_region_cb, HSA.Status,
                (HSA.Region, Ptr{HSA.Region}))
    else
        error("Region kind $kind not supported")
    end
    HSA.agent_iterate_regions(agent.agent, func, region)
    check((region[].handle == typemax(UInt64)) ? HSA.STATUS_ERROR : HSA.STATUS_SUCCESS)
    return region
end
