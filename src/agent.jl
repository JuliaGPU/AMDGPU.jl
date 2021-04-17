# Utilities for working with HSA agents

mutable struct HSAAgent
    agent::HSA.Agent

    # Cached information
    type::Symbol
    name::String
    productname::String

    function HSAAgent(handle::HSA.Agent)
        agent = new(handle)
        agent.type = device_type(agent)
        agent.name = get_name(agent)
        agent.productname = get_product_name(agent)

        agent
    end
end

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

"Determines if a memory region can be used for kernarg allocations."
function get_kernarg_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    segment = Ref{HSA.RegionSegment}()
    HSA.region_get_info(region, HSA.REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA.REGION_SEGMENT_GLOBAL)
        return HSA.STATUS_SUCCESS
    end

    flags = Ref{HSA.RegionGlobalFlag}()
    HSA.region_get_info(region, HSA.REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA.REGION_GLOBAL_FLAG_KERNARG > 0)
        unsafe_store!(data, region)
        return HSA.STATUS_INFO_BREAK
    end

    return HSA.STATUS_SUCCESS
end

"Determines if a memory region can be used for fine grained allocations."
function get_fine_grained_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    segment = Ref{HSA.RegionSegment}()
    HSA.region_get_info(region, HSA.REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA.REGION_SEGMENT_GLOBAL)
        return HSA.STATUS_SUCCESS
    end

    flags = Ref{HSA.RegionGlobalFlag}()
    HSA.region_get_info(region, HSA.REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA.REGION_GLOBAL_FLAG_FINE_GRAINED > 0)
        unsafe_store!(data, region)
        return HSA.STATUS_INFO_BREAK
    end

    return HSA.STATUS_SUCCESS
end

"Determines if a memory region can be used for coarse grained allocations."
function get_coarse_grained_memory_region_cb(region::HSA.Region, data::Ptr{HSA.Region})
    segment = Ref{HSA.RegionSegment}()
    HSA.region_get_info(region, HSA.REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA.REGION_SEGMENT_GLOBAL)
        return HSA.STATUS_SUCCESS
    end

    flags = Ref{HSA.RegionGlobalFlag}()
    HSA.region_get_info(region, HSA.REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA.REGION_GLOBAL_FLAG_COARSE_GRAINED > 0)
        unsafe_store!(data, region)
        return HSA.STATUS_INFO_BREAK
    end

    return HSA.STATUS_SUCCESS
end

function iterate_regions_cb(region::HSA.Region, regions)
    push!(regions, region)
    return HSA.STATUS_SUCCESS
end

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

get_default_agent() = DEFAULT_AGENT[]
function set_default_agent!(kind::Symbol)
    DEFAULT_AGENT[] = first(get_agents(kind))
end
set_default_agent!() = set_default_agent!(:gpu)

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
    name = if agent.name == agent.productname
        "$(agent.name)"
    else
        "$(agent.productname) ($(agent.name))"
    end

    typename = if agent.type == :cpu
        "CPU"
    elseif agent.type == :gpu
        "GPU"
    elseif agent.type == :dsp
        "DSP"
    else
        "(Unknown device type)"
    end

    print(io, "$typename: $name")
end

### Agent details

function get_product_name(agent::HSAAgent)
    name = Vector{UInt8}(undef, 64)
    getinfo(agent.agent, HSA.AMD_AGENT_INFO_PRODUCT_NAME, name) |> check
    rstrip(String(name), '\0')
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
const isa_regex = r"([a-z]*)-([a-z]*)-([a-z]*)--([a-z0-9]*)([a-zA-Z0-9+]*)"
function Base.convert(::Type{String}, isa::HSA.ISA)
    len = Ref{Cuint}(0)
    getinfo(isa, HSA.ISA_INFO_NAME_LENGTH, len) |> check
    name = Vector{UInt8}(undef, len[])
    getinfo(isa, HSA.ISA_INFO_NAME, name) |> check
    name = String(name)
    m = match(isa_regex, name)
    @assert m !== nothing "Failed to match ISA name pattern: $name"
    return m.captures[4]
end
get_first_isa_string(agent::HSAAgent) = convert(String, first(isas(agent)))
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
