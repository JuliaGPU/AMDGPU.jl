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
    configured && hsa_shut_down()
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

include(joinpath(@__DIR__, "..", "deps", "hsa_types.jl"))
include(joinpath(@__DIR__, "..", "deps", "hsa_interface.jl"))
include(joinpath(@__DIR__, "..", "deps", "hsa_extras.jl"))

struct HSACallException
    code::UInt32
end

"Helper macro to check HSA call results"
macro check(ex::Expr)
    repr_ex = repr(ex)
    quote
        # TODO: Shut this up unless loglevel is Debug
        #println("Checking: ", $repr_ex)
        check($(esc(ex)))
    end
end
function check(result)
    if result != HSA_STATUS_SUCCESS
        @warn "HSA call failed with code: $result"
        throw(HSACallException(result))
    end
end

### Types ###

mutable struct HSAAgent
    agent::hsa_agent_t
end

mutable struct HSAQueue
    agent::HSAAgent
    queue::Ref{Ptr{hsa_queue_t}}
end

mutable struct HSAExecutable
    agent::HSAAgent
    executable::Ref{hsa_executable_t}
    code_object::Ref{hsa_code_object_t}
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
    signal::Ref{hsa_signal_t}
end

### Constants ###

const DEFAULT_AGENT = Ref{HSAAgent}()
const DEFAULT_QUEUES = IdDict{HSAAgent,HSAQueue}()

### @cfunction Callbacks ###

function agent_iterate_isas_cb(isa::hsa_isa_t, ptr::Ptr{hsa_isa_t})
    unsafe_store!(ptr, isa)
    return HSA_STATUS_INFO_BREAK
end

function iterate_agents_cb(agent::hsa_agent_t, agents)
    push!(agents, HSAAgent(agent))
    return HSA_STATUS_SUCCESS
end

function finalizer_iterate_isas_cb(isa::hsa_isa_t, data)
    @info "Finalizer ISAs:"

    name = repeat(" ", 64)
    @check hsa_isa_get_info_alt(isa, HSA_ISA_INFO_NAME, name)
    @info "    ISA Name: $name"

    return HSA_STATUS_SUCCESS
end

"Determines if a memory region can be used for kernarg allocations."
function get_kernarg_memory_region_cb(region::hsa_region_t, data::Ptr{hsa_region_t})
    segment = Ref{hsa_region_segment_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA_REGION_SEGMENT_GLOBAL)
        return HSA_STATUS_SUCCESS
    end

    flags = Ref{hsa_region_global_flag_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA_REGION_GLOBAL_FLAG_KERNARG > 0)
        unsafe_store!(data, region)
        return HSA_STATUS_INFO_BREAK
    end

    return HSA_STATUS_SUCCESS
end

"Determines if a memory region can be used for fine grained allocations."
function get_fine_grained_memory_region_cb(region::hsa_region_t, data::Ptr{hsa_region_t})
    segment = Ref{hsa_region_segment_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_SEGMENT, segment)
    if (segment[] != HSA_REGION_SEGMENT_GLOBAL)
        return HSA_STATUS_SUCCESS
    end

    flags = Ref{hsa_region_global_flag_t}()
    hsa_region_get_info(region, HSA_REGION_INFO_GLOBAL_FLAGS, flags)
    if (flags[] & HSA_REGION_GLOBAL_FLAG_FINE_GRAINED > 0)
        unsafe_store!(data, region)
        return HSA_STATUS_INFO_BREAK
    end

    return HSA_STATUS_SUCCESS
end

function iterate_exec_prog_syms_cb(exe::hsa_executable_t, agent::hsa_agent_t, sym::hsa_executable_symbol_t, data)
    name = repeat(" ", 64)
    @check hsa_executable_symbol_get_info(sym, HSA_EXECUTABLE_SYMBOL_INFO_NAME, name)
    @info "    Symbol Name: $name"

    return HSA_STATUS_SUCCESS
end

### Constructors and Finalizers ###

function HSAQueue(agent::HSAAgent)
    queue_size = Ref{UInt32}(0)
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_QUEUE_MAX_SIZE, queue_size)
    @assert queue_size[] > 0
    queue = HSAQueue(agent, Ref{Ptr{hsa_queue_t}}())
    @check hsa_queue_create(agent.agent, queue_size[], HSA_QUEUE_TYPE_SINGLE,
            C_NULL, C_NULL, typemax(UInt32), typemax(UInt32), queue.queue)
    finalizer(queue) do queue
        @check hsa_queue_destroy(queue.queue[])
    end
    return queue
end
function HSASignal()
    signal = HSASignal(Ref{hsa_signal_t}())
    hsa_signal_create(1, 0, C_NULL, signal.signal)
    finalizer(signal) do signal
        @check hsa_signal_destroy(signal.signal[])
    end
    return signal
end
function HSAExecutable(agent::HSAAgent, data::Vector{UInt8}, symbol::String)
    #= NOTE: Everything I can see indicates that profile is always FULL
    profile = Ref{hsa_profile_t}()
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_PROFILE, profile)
    =#

    code_object = Ref{hsa_code_object_t}(hsa_code_object_t(0))
    @check hsa_code_object_deserialize(data, sizeof(data), C_NULL, code_object)
    @assert code_object[].handle != 0

    executable = Ref{hsa_executable_t}()
    @check hsa_executable_create(HSA_PROFILE_FULL, HSA_EXECUTABLE_STATE_UNFROZEN, C_NULL, executable)
    @check hsa_executable_load_code_object(executable[], agent.agent, code_object[], C_NULL)
    @check hsa_executable_freeze(executable[], "")

    exe = HSAExecutable(agent, executable, code_object, data)
    finalizer(exe) do exe
        @check hsa_executable_destroy(exe.executable[])
        @check hsa_code_object_destroy(exe.code_object[])
    end
    return exe
end

function HSAKernelInstance(agent::HSAAgent, exe::HSAExecutable, symbol::String, args::Tuple)
    #= TODO: Make this available for debugging purposes
    func = @cfunction(iterate_exec_prog_syms_cb, hsa_status_t,
            (hsa_executable_t, hsa_agent_t, hsa_executable_symbol_t, Ptr{Cvoid}))
    @check hsa_executable_iterate_agent_symbols(exe.executable[], agent.agent, func, C_NULL)
    =#

    exec_symbol = Ref{hsa_executable_symbol_t}()
    @check hsa_executable_get_symbol(exe.executable[], C_NULL, symbol, agent.agent, 0, exec_symbol)

    kernel_object = Ref{UInt64}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT, kernel_object)

    kernarg_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE, kernarg_segment_size)

    group_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE, group_segment_size)

    private_segment_size = Ref{UInt32}(0)
    @check hsa_executable_symbol_get_info(exec_symbol[], HSA_EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE, private_segment_size)

    finegrained_region = get_region(agent, :finegrained)
    kernarg_region = get_region(agent, :kernarg)

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    @check hsa_memory_allocate(kernarg_region[], kernarg_segment_size[], kernarg_address)
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
        @check hsa_memory_free(kernel.kernarg_address[])
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
    @check hsa_memory_allocate(region[], nbytes, handle)
    arr = HSAArray{T,N}(size, handle[])
    finalizer(arr) do arr
        @check hsa_memory_free(arr.handle)
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
        func = @cfunction(iterate_agents_cb, hsa_status_t,
                (hsa_agent_t, Ref{Vector{HSAAgent}}))
        @check hsa_iterate_agents(func, agents)
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
get_default_queue() =
    get_default_queue(get_default_agent())

function get_name(agent::HSAAgent)
    # TODO: Get name length first!
    name = repeat(" ", 64)
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_NAME, name)
    return name
end
function profile(agent::HSAAgent)
    profile = Ref{hsa_profile_t}()
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_PROFILE, profile)
    return profile[]
end

function device_type(agent::HSAAgent)
    devtype = Ref{UInt32}()
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_DEVICE, devtype)
    if hsa_device_type_t(devtype[]) == HSA_DEVICE_TYPE_CPU
        return :cpu
    elseif hsa_device_type_t(devtype[]) == HSA_DEVICE_TYPE_GPU
        return :gpu
    elseif hsa_device_type_t(devtype[]) == HSA_DEVICE_TYPE_DSP
        return :dsp
    end
end

# TODO: Get all ISAs
function get_first_isa(agent::HSAAgent)
    isa = Ref{hsa_isa_t}()
    func = @cfunction(agent_iterate_isas_cb, hsa_status_t,
        (hsa_isa_t, Ptr{hsa_isa_t}))
    ret = hsa_agent_iterate_isas(agent.agent, func, isa)
    @assert ret == HSA_STATUS_INFO_BREAK "Failed to find an agent ISA"

    len = Ref{Cuint}(0)
    @check hsa_isa_get_info_alt(isa[], HSA_ISA_INFO_NAME_LENGTH, len)
    name = repeat(" ", len[])
    @check hsa_isa_get_info_alt(isa[], HSA_ISA_INFO_NAME, name)
    isa_name = string(rstrip(last(split(name, "-")), '\0'))
    return isa_name
end

function get_region(agent::HSAAgent, kind::Symbol)
    region = newref!(Ref{hsa_region_t}, typemax(UInt64))
    if kind == :finegrained
        func = @cfunction(get_fine_grained_memory_region_cb, hsa_status_t,
                (hsa_region_t, Ptr{hsa_region_t}))
    elseif kind == :kernarg
        func = @cfunction(get_kernarg_memory_region_cb, hsa_status_t,
                (hsa_region_t, Ptr{hsa_region_t}))
    else
        error("Region kind $kind not supported")
    end
    hsa_agent_iterate_regions(agent.agent, func, region)
    @check (region[].handle == typemax(UInt64)) ? HSA_STATUS_ERROR : HSA_STATUS_SUCCESS
    return region
end

function launch!(queue::HSAQueue, kernel::HSAKernelInstance, signal::HSASignal;
                 workgroup_size=nothing, grid_size=nothing)
    @assert workgroup_size !== nothing "Must specify workgroup_size kwarg"
    @assert grid_size !== nothing "Must specify grid_size kwarg"

    queue = queue.queue
    signal = signal.signal
    args = kernel.args

    # Obtain the current queue write index
    index = hsa_queue_load_write_index_relaxed(queue[])

    # TODO: Make this less ugly
    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}()
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        dispatch_packet, 0, sizeof(dispatch_packet[]))
    _packet = dispatch_packet[]
    @set! _packet.setup = 0
    @set! _packet.setup |= 1 << Int(HSA_KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
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
    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}(_packet)

    _queue = unsafe_load(queue[])
    queueMask = UInt32(_queue.size - 1)
    baseaddr_ptr = Ptr{hsa_kernel_dispatch_packet_t}(_queue.base_address)
    baseaddr_ptr += sizeof(hsa_kernel_dispatch_packet_t) * (index & queueMask)
    dispatch_packet_ptr = Base.unsafe_convert(Ptr{hsa_kernel_dispatch_packet_t}, dispatch_packet)
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

    # Atomically store the header
    atomic_store_n!(x::Ptr{UInt16}, v::UInt16) =
        Base.llvmcall("""
        %ptr = inttoptr i$(Sys.WORD_SIZE) %0 to i16*
        store atomic i16 %1, i16* %ptr release, align 16
        ret void
        """, Cvoid, Tuple{Ptr{UInt16}, UInt16},
        Base.unsafe_convert(Ptr{UInt16}, x), v)
    header = Ref{UInt16}(0)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_ACQUIRE_FENCE_SCOPE)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_RELEASE_FENCE_SCOPE)
    header[] |= Int(HSA_PACKET_TYPE_KERNEL_DISPATCH) << Int(HSA_PACKET_HEADER_TYPE)
    atomic_store_n!(Base.unsafe_convert(Ptr{UInt16}, baseaddr_ptr), header[])

    # Increment the write index and ring the doorbell to dispatch the kernel
    hsa_queue_store_write_index_relaxed(queue[], index+1)
    hsa_signal_store_relaxed(_queue.doorbell_signal, index)
end

# FIXME: Make this non-blocking for libuv
function Base.wait(signal::HSASignal)
    # Wait on the dispatch completion signal until the kernel is finished
    value = Ref{hsa_signal_value_t}()
    value[] = hsa_signal_wait_acquire(signal.signal[],
                                      HSA_SIGNAL_CONDITION_LT, 1, typemax(UInt64),
                                      HSA_WAIT_STATE_BLOCKED)
end

include("memory.jl")

function __init__()
    configured || return

    # Make sure we load the library found by the last `] build`
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
    #rtlib = dlopen("libhsa-runtime64.so")

    # Also load the debug library
    # TODO: Remove this or ensure it's available before loading
    #debuglib = dlopen("librocr_debug_agent64.so")

    # NOTE: We want to always be able to load the package, regardless of
    # whether HSA libraries are found (just like the CUDA* packages)
    @check hsa_init()
end

end
