module HSARuntime

# copied from CUDAdrv/src/CUDAdrv.jl
const ext = joinpath(dirname(@__DIR__), "deps", "ext.jl")
isfile(ext) || error("HSARuntime.jl has not been built, please run Pkg.build(\"HSARuntime\").")
include(ext)
if !configured
    # default (non-functional) values for critical variables,
    # making it possible to _load_ the package at all times.
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end

atexit() do
    configured && HSA.shut_down()
end

### Imports ###

using CEnum
using Setfield
using Libdl

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, profile, get_first_isa, launch!
export get_default_agent, get_default_queue

### HSA Runtime Wrapper ###

include(joinpath(@__DIR__, "HSA", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

include("extras.jl")

### HSA Errors ###

export HSAError

struct HSAError <: Exception
    code::Status
end

"""
    description(err::HSAError)

Gets the string description of an error code.
"""
function description(err::HSAError)
    str_ref = Ref{Cstring}()
    HSA.status_string(err.code, str_ref)
    unsafe_string(str_ref[])
end

function Base.showerror(io::IO, err::HSAError)
    print(io, "HSA error (code #$(Int(err.code)), $(description(err)))")
end

Base.show(io::IO, err::HSAError) = print(io, "HSAError($(Int(err.code)),
                                         $(description(err)))")

function check(result)
    if result != HSA.STATUS_SUCCESS
        throw(HSAError(result))
    end
end

### Types ###

mutable struct HSAAgent
    agent::HSA.Agent
end

mutable struct HSAQueue
    agent::HSAAgent
    queue::Ref{Ptr{HSA.Queue}}
end

mutable struct HSAExecutable
    agent::HSAAgent
    executable::Ref{HSA.Executable}
    data::Vector{UInt8}
end

mutable struct HSAKernelInstance{T<:Tuple}
    agent::HSAAgent
    exe::HSAExecutable
    sym::String
    args::T
    # FIXME: Stop being lazy and put in some damn types!
    kernel_object
    kernarg_segment_size
    group_segment_size
    private_segment_size
    kernarg_address::Ref{Ptr{Nothing}}
end

mutable struct HSAArray{T,N} <: AbstractArray{T,N}
    size::Dims{N}
    handle::Ptr{T}
end

mutable struct HSASignal
    signal::Ref{Signal}
end

### Constants ###

const DEFAULT_AGENT = Ref{HSAAgent}()
const DEFAULT_QUEUES = IdDict{HSAAgent,HSAQueue}()

### @cfunction Callbacks ###

function agent_iterate_isas_cb(isa::HSA.ISA, ptr::Ptr{HSA.ISA})
    unsafe_store!(ptr, isa)
    return HSA.STATUS_INFO_BREAK
end

function iterate_agents_cb(agent::HSA.Agent, agents)
    push!(agents, HSAAgent(agent))
    return HSA.STATUS_SUCCESS
end

function finalizer_iterate_isas_cb(isa::HSA.ISA, data)
    @info "Finalizer ISAs:"

    name = repeat(" ", 64)
    getinfo(isa, HSA.ISA_INFO_NAME, name) |> check
    @info "    ISA Name: $name"

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

function iterate_exec_agent_syms_cb(exe::HSA.Executable, agent::HSA.Agent,
                                    sym::HSA.ExecutableSymbol,
                                    sym_ref::Ptr{Cvoid})

    sym_ref = Base.unsafe_convert(Ptr{HSA.ExecutableSymbol}, sym_ref)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE,
                                   sym_type) |> check

    if sym_type[] == HSA.SYMBOL_KIND_KERNEL
        len = Ref(0)
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
        name = Vector{UInt8}(undef, len[])
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
        @debug "    Symbol Name: $(String(name))"
        Base.unsafe_store!(sym_ref, sym)
    end

    return HSA.STATUS_SUCCESS
end
function iterate_exec_prog_syms_cb(exe::HSA.Executable, sym::HSA.ExecutableSymbol, data)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE, sym_type) |> check

    #if sym_type[] == HSA.SYMBOL_KIND_KERNEL
        len = Ref(0)
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
        name = Vector{UInt8}(undef, len[])
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
        @debug "   Symbol Name: $(String(name))"
    #end
    return HSA.STATUS_SUCCESS
end

### Constructors and Finalizers ###

function HSAQueue(agent::HSAAgent)
    queue_size = Ref{UInt32}(0)
    getinfo(agent.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, queue_size) |> check
    @assert queue_size[] > 0
    queue = HSAQueue(agent, Ref{Ptr{HSA.Queue}}())
    HSA.queue_create(agent.agent, queue_size[], HSA.QUEUE_TYPE_SINGLE,
                     C_NULL, C_NULL, typemax(UInt32), typemax(UInt32),
                     queue.queue) |> check

    finalizer(queue) do queue
        HSA.queue_destroy(queue.queue[]) |> check
    end
    return queue
end

function HSASignal()
    signal = HSASignal(Ref{Signal}())
    HSA.signal_create(1, 0, C_NULL, signal.signal)
    finalizer(signal) do signal
        HSA.signal_destroy(signal.signal[]) |> check
    end
    return signal
end

function HSAExecutable(agent::HSAAgent, data::Vector{UInt8}, symbol::String)
    #= NOTE: Everything I can see indicates that profile is always FULL
    profile = Ref{HSA.Profile}()
    HSA.agent_get_info(agent.agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    =#

    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data),
                                              code_object_reader) |> check

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(HSA.PROFILE_BASE,
                              HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
                              C_NULL, executable) |> check

    HSA.executable_load_agent_code_object(executable[], agent.agent,
                                          code_object_reader[],
                                          C_NULL, C_NULL) |> check

    HSA.executable_freeze(executable[], "") |> check
    HSA.code_object_reader_destroy(code_object_reader[]) |> check

    exe = HSAExecutable(agent, executable, data)
    
    finalizer(exe) do exe
        HSA.executable_destroy(exe.executable[]) |> check
    end

    return exe
end

function HSAKernelInstance(agent::HSAAgent, exe::HSAExecutable, symbol::String, args::Tuple)
    agent_func = @cfunction(iterate_exec_agent_syms_cb, HSA.Status,
                           (HSA.Executable, HSA.Agent, HSA.ExecutableSymbol, Ptr{Cvoid}))
    prog_func = @cfunction(iterate_exec_prog_syms_cb, HSA.Status,
                            (HSA.Executable, HSA.ExecutableSymbol, Ptr{Cvoid}))
    exec_symbol = Ref{HSA.ExecutableSymbol}()
    @debug "Agent symbols"
    HSA.executable_iterate_agent_symbols(exe.executable[], agent.agent,
                                     agent_func, exec_symbol) |> check
    #@debug "Program symbols"
    #hsa_executable_iterate_program_symbols(exe.executable[], prog_func, C_NULL) |> check

    # TODO: Conditionally disable once ROCR is fixed
    if !isassigned(exec_symbol)
        agent_ref = Ref(agent.agent)
        GC.@preserve agent_ref begin
            HSA.executable_get_symbol_by_name(exe.executable[], symbol,
                                              agent_ref, exec_symbol) |> check
        end
    end

    kernel_object = Ref{UInt64}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT,
            kernel_object) |> check
    
    kernarg_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE,
            kernarg_segment_size) |> check
    
    if kernarg_segment_size[] == 0
        # FIXME: Hidden arguments!
        kernarg_segment_size[] = sum(sizeof.(args))
    end

    group_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE,
            group_segment_size) |> check

    private_segment_size = Ref{UInt32}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE,
            private_segment_size) |> check

    finegrained_region = get_region(agent, :finegrained)
    kernarg_region = get_region(agent, :kernarg)

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    HSA.memory_allocate(kernarg_region[],
                        kernarg_segment_size[],
                        kernarg_address) |> check
    ctr = 0x0
    
    for arg in args
        rarg = Ref(arg)
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            kernarg_address[]+ctr, rarg, sizeof(arg))
        ctr += sizeof(arg)
    end

    kernel = HSAKernelInstance(agent, exe, symbol, args, kernel_object,
                               kernarg_segment_size, group_segment_size,
                               private_segment_size, kernarg_address)
    finalizer(kernel) do kernel
        HSA.memory_free(kernel.kernarg_address[]) |> check
    end
    return kernel
end

# TODO: Support non-isbitstype allocations
function HSAArray(agent::HSAAgent, ::Type{T}, size::NTuple{N,Int}) where {T,N}
    @assert isprimitivetype(T) "$T is not a primitive type"
    @assert all(x->x>0, size) "Invalid array size: $size"
    
    region = get_region(agent, :finegrained)
    nbytes = sizeof(T) * prod(size)
    handle = Ref{Ptr{T}}()
    HSA.memory_allocate(region[], nbytes, handle) |> check
    arr = HSAArray{T,N}(size, handle[])
    
    finalizer(arr) do arr
        HSA.memory_free(arr.handle) |> check
    end
    
    return arr
end
HSAArray(::Type{T}, size::NTuple{N,Int}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], T, size)

### HSAArray Methods ###

function HSAArray(agent::HSAAgent, arr::Array{T,N}) where {T,N}
    harr = HSAArray(agent, T, size(arr))
    for idx in eachindex(arr)
        harr[idx] = arr[idx]
    end
    return harr
end
HSAArray(arr::Array{T,N}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], arr)

function Array(harr::HSAArray{T,N}) where {T,N}
    arr = Array{T}(undef, size(harr))
    ref_arr = Ref(arr)
    GC.@preserve ref_arr begin
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            ref_arr, harr.handle, sizeof(arr))
    end
    return harr
end

Base.pointer(arr::HSAArray) = arr.handle
Base.IndexStyle(::Type{<:HSAArray}) = Base.IndexLinear()
Base.IndexStyle(::HSAArray) = Base.IndexLinear()
function Base.iterate(A::HSAArray, i=1) # copy-pasta from Base
    Base.@_inline_meta
    (i % UInt) - 1 < length(A) ? (@inbounds A[i], i + 1) : nothing
end
Base.similar(arr::HSAArray{T,N}) where {T,N} =
    HSAArray(T, size(arr))
Base.similar(agent, arr::HSAArray{T,N}) where {T,N} =
    HSAArray(agent, T, size(arr))

Base.size(arr::HSAArray) = arr.size
Base.length(arr::HSAArray) = sum(size(arr))

function Base.fill!(arr::HSAArray{T,N}, value::T) where {T,N}
    for idx in 1:length(arr)
        arr[idx] = value
    end
end
@inline function Base.getindex(arr::HSAArray{T,N}, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_load(pointer(arr), idx)::T
end
@inline function Base.setindex!(arr::HSAArray{T,N}, value, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_store!(pointer(arr), value, idx)
end

### Methods ###

function Base.show(io::IO, agent::HSAAgent)
    print(io, "HSAAgent($(agent.agent)): Name=$(get_name(agent)), Type=$(device_type(agent))")
end

function get_agents()
    agents = Ref(Vector{HSAAgent}())
    GC.@preserve agents begin
        func = @cfunction(iterate_agents_cb, HSA.Status,
                (HSA.Agent, Ref{Vector{HSAAgent}}))
        HSA.iterate_agents(func, agents) |> check
        _agents = agents[]
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

"Gets the default queue for an agent, creating it if necessary"
function get_default_queue(agent::HSAAgent)
    queue = get!(DEFAULT_QUEUES, agent, HSAQueue(agent))
    return queue
end

get_default_queue() = get_default_queue(get_default_agent())

function get_name(agent::HSAAgent)
    #len = Ref(0)
    #hsa_agent_get_info(agent.agent, HSA.AGENT_INFO_NAME_LENGTH, len) |> check
    #FIXME: this could be better? 
    name = Vector{UInt8}(undef, 64)
    getinfo(agent.agent, HSA.AGENT_INFO_NAME, name) |> check
    return rstrip(String(name), '\0')
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
    end

end

# TODO: Get all ISAs
function get_first_isa(agent::HSAAgent)
    isa = Ref{HSA.ISA}()
    func = @cfunction(agent_iterate_isas_cb, HSA.Status,
        (HSA.ISA, Ptr{HSA.ISA}))
    ret = HSA.agent_iterate_isas(agent.agent, func, isa)
    @assert ret == HSA.STATUS_INFO_BREAK "Failed to find an agent ISA"

    len = Ref{Cuint}(0)
    getinfo(isa[], HSA.ISA_INFO_NAME_LENGTH, len) |> check
    name = repeat(" ", len[])
    getinfo(isa[], HSA.ISA_INFO_NAME, name) |> check
    isa_name = string(rstrip(last(split(name, "-")), '\0'))
    return isa_name
end

function get_region(agent::HSAAgent, kind::Symbol)
    region = newref!(Ref{HSA.Region}, typemax(UInt64))
    if kind == :finegrained
        func = @cfunction(get_fine_grained_memory_region_cb, HSA.Status,
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

@eval atomic_store_n!(x::Ptr{UInt16}, v::UInt16) =
    Base.llvmcall($"""
    %ptr = inttoptr i$(Sys.WORD_SIZE) %0 to i16*
    store atomic i16 %1, i16* %ptr release, align 16
    ret void
    """, Cvoid, Tuple{Ptr{UInt16}, UInt16},
    Base.unsafe_convert(Ptr{UInt16}, x), v)
function launch!(queue::HSAQueue, kernel::HSAKernelInstance, signal::HSASignal;
                 workgroup_size=nothing, grid_size=nothing)
    @assert workgroup_size !== nothing "Must specify workgroup_size kwarg"
    @assert grid_size !== nothing "Must specify grid_size kwarg"

    queue = queue.queue
    signal = signal.signal
    args = kernel.args

    # Obtain the current queue write index
    index = HSA.queue_load_write_index_relaxed(queue[])

    # TODO: Make this less ugly
    dispatch_packet = Ref{HSA.KernelDispatchPacket}()
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        dispatch_packet, 0, sizeof(dispatch_packet[]))
    _packet = dispatch_packet[]
    @set! _packet.setup = 0
    @set! _packet.setup |= 3 << Int(HSA.KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
    @set! _packet.workgroup_size_x = workgroup_size[1]
    @set! _packet.workgroup_size_y = workgroup_size[2]
    @set! _packet.workgroup_size_z = workgroup_size[3]
    @set! _packet.grid_size_x = grid_size[1]
    @set! _packet.grid_size_y = grid_size[2]
    @set! _packet.grid_size_z = grid_size[3]
    @set! _packet.completion_signal = signal[]
    @set! _packet.kernel_object = kernel.kernel_object[]
    @set! _packet.kernarg_address = kernel.kernarg_address[]
    @set! _packet.private_segment_size = kernel.private_segment_size[]
    @set! _packet.group_segment_size = kernel.group_segment_size[]
    dispatch_packet = Ref{HSA.KernelDispatchPacket}(_packet)

    _queue = unsafe_load(queue[])
    queueMask = UInt32(_queue.size - 1)
    baseaddr_ptr = Ptr{HSA.KernelDispatchPacket}(_queue.base_address)
    baseaddr_ptr += sizeof(HSA.KernelDispatchPacket) * (index & queueMask)
    dispatch_packet_ptr = Base.unsafe_convert(Ptr{HSA.KernelDispatchPacket}, dispatch_packet)
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

    # Atomically store the header
    header = Ref{UInt16}(0)
    header[] |= Int(HSA.FENCE_SCOPE_SYSTEM) << Int(HSA.PACKET_HEADER_ACQUIRE_FENCE_SCOPE)
    header[] |= Int(HSA.FENCE_SCOPE_SYSTEM) << Int(HSA.PACKET_HEADER_RELEASE_FENCE_SCOPE)
    header[] |= Int(HSA.PACKET_TYPE_KERNEL_DISPATCH) << Int(HSA.PACKET_HEADER_TYPE)
    atomic_store_n!(Base.unsafe_convert(Ptr{UInt16}, baseaddr_ptr), header[])

    # Increment the write index and ring the doorbell to dispatch the kernel
    HSA.queue_store_write_index_relaxed(queue[], index+1)
    HSA.signal_store_relaxed(_queue.doorbell_signal, Int64(index))
end

"""
    Base.wait(signal::HSASignal; soft=true, minlat=0.01)

Waits on an `HSASignal` to decrease below 1. If `soft=true` (default), uses
tasks to poll the signal, otherwise uses HSA's signal waiter. `minlat` sets
the minimum latency for the software waiter; lower values can decrease latency
at the cost of increased polling load.
"""
function Base.wait(signal::HSASignal; soft=true, minlat=0.01)
    if soft
        while true
            value = HSA.signal_load_scacquire(signal.signal[])
            if value < 1
                return
            end
            sleep(minlat)
        end
    else
        # Wait on the dispatch completion signal until the kernel is finished
        HSA.signal_wait_acquire(signal.signal[],
                                HSA.SIGNAL_CONDITION_LT, 1, typemax(UInt64),
                                HSA.WAIT_STATE_BLOCKED)
    end
end

include("memory.jl")

function __init__()
    # We want to always be able to load the package, regardless of
    # whether HSA libraries are found
    configured || return

    # Make sure we load the library found by the last `] build`
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
    # TODO: Do the same (if possible) for the debug library

    HSA.init() |> check

    agents = get_agents(:gpu)
    if length(agents) > 0
        DEFAULT_AGENT[] = first(agents)
    end
end

end
