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

### Imports ###

using CEnum
using Setfield
using Libdl

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, name, profile, get_first_isa, launch!
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
    kernarg_address::Ref{Ptr{Nothing}}
end

mutable struct HSAArray{T,N} <: AbstractArray{T,N}
    size::Dims{N}
    handle::Ref{Ptr{Cvoid}}
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

### Constructors and Finalizers ###

function HSAQueue(agent::HSAAgent)
    queue_size = Ref{UInt32}(0)
    @check hsa_agent_get_info(agent.agent, HSA_AGENT_INFO_QUEUE_MAX_SIZE, queue_size)
    @assert queue_size[] > 0
    queue = HSAQueue(agent, Ref{Ptr{hsa_queue_t}}())
    @check hsa_queue_create(agent.agent, queue_size[], HSA_QUEUE_TYPE_SINGLE,
            C_NULL, C_NULL, typemax(UInt32), typemax(UInt32), queue.queue[])
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
    #=
    support = Ref{Bool}(false)
    @check hsa_system_extension_supported(HSA_EXTENSION_FINALIZER, 1, 0,
            support)
    @assert support[]

    # Note: Requires the following libraries to be accessible as such:
    # libhsa-ext-finalize64.so
    # libhsa-ext-image64.so
    # libhsa-runtime-tools64.so
    table_1_00 = Ref{hsa_ext_finalizer_1_00_pfn_t}()
    @check hsa_system_get_extension_table(HSA_EXTENSION_FINALIZER, 1, 0,
            table_1_00)

    machine_model = Ref{hsa_machine_model_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_MACHINE_MODEL,
            machine_model)

    profile = Ref{hsa_profile_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_PROFILE, profile)

    ext_module = Ref{hsa_ext_module_t}()
    exe_data = Array{UInt8}(data)
    ext_module[] = reinterpret(Ptr{hsa_ext_module_t}, pointer(exe_data))

    program = Ref{hsa_ext_program_t}()
    @check ccall(table_1_00[].hsa_ext_program_create, hsa_status_t,
        (hsa_machine_model_t, hsa_profile_t, hsa_default_float_rounding_mode_t,
            Cstring, Ptr{hsa_ext_program_t}),
        machine_model[], profile[], HSA_DEFAULT_FLOAT_ROUNDING_MODE_DEFAULT,
            C_NULL, program)

    @check ccall(table_1_00[].hsa_ext_program_add_module, hsa_status_t,
        (hsa_ext_program_t, hsa_ext_module_t),
        program[], ext_module[])

    hsa_isa = Ref{hsa_isa_t}()
    @check hsa_agent_get_info(agent, HSA_AGENT_INFO_ISA, hsa_isa)

    # TODO: Make control_directives configurable?
    control_directives = Ref{hsa_ext_control_directives_t}()
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        control_directives, 0, sizeof(hsa_ext_control_directives_t))
    code_object = Ref{hsa_code_object_t}()
    @check ccall(table_1_00[].hsa_ext_program_finalize, hsa_status_t,
        (hsa_ext_program_t, hsa_isa_t, Int32, hsa_ext_control_directives_t, Cstring, hsa_code_object_type_t, Ptr{hsa_code_object_t}),
        program[], hsa_isa[], 0, control_directives[], "", HSA_CODE_OBJECT_TYPE_PROGRAM, code_object);

    @check ccall(table_1_00[].hsa_ext_program_destroy, hsa_status_t,
        (hsa_ext_program_t,),
        program[])

    executable = Ref{hsa_executable_t}();
    @check hsa_executable_create(profile[], HSA_EXECUTABLE_STATE_UNFROZEN, "",
            executable)

    @check hsa_executable_load_code_object(executable[], agent, code_object[], "")
    @check hsa_executable_freeze(executable[], "")
    =#
    # FIXME
    code_object = Ref{hsa_code_object_t}(hsa_code_object_t(0))
    @check hsa_code_object_deserialize(data, sizeof(data), symbol, code_object)
    @assert code_object[].handle != 0

    executable = Ref{hsa_executable_t}()
    @check hsa_executable_create(HSA_PROFILE_FULL, HSA_EXECUTABLE_STATE_UNFROZEN, C_NULL, executable)
    @show "2"
    @check hsa_executable_load_code_object(executable[], agent.agent, code_object[], C_NULL)
    @show "3"
    @check hsa_executable_freeze(executable[], "")
    @show "4"

    exe = HSAExecutable(agent, executable, code_object, data)
    finalizer(exe) do exe
        @check hsa_executable_destroy(exe.executable[])
        @check hsa_code_object_destroy(exe.code_object[])
    end
    return exe
end

function HSAKernelInstance(agent::HSAAgent, exe::HSAExecutable, symbol::String, args::Tuple)
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

    # Find a memory region that supports kernel arguments
    kernarg_region = newref!(Ref{hsa_region_t}, typemax(UInt64))
    func = @cfunction(get_kernarg_memory_region_cb, hsa_status_t,
            (hsa_region_t, Ptr{hsa_region_t}))
    hsa_agent_iterate_regions(agent, func, kernarg_region)
    @check (kernarg_region[].handle == typemax(UInt64)) ? HSA_STATUS_ERROR : HSA_STATUS_SUCCESS

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    @check hsa_memory_allocate(kernarg_region[], kernarg_segment_size[], kernarg_address)
    ccall(:memcpy, Cvoid,
        (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
        kernarg_address[], Ref(args), sizeof(args))

    kernel = HSAKernelInstance(agent, exe, symbol, args, kernarg_address)
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
    handle = Ref{Ptr{Cvoid}}()
    @check hsa_memory_allocate(region[], nbytes, handle)
    arr = HSAArray{T,N}(size, handle)
    finalizer(arr) do arr
        @check hsa_memory_free(arr.handle[])
    end
    return arr
end
HSAArray(::Type{T}, size::NTuple{N,Int}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], T, size)

### HSAArray Methods ###

function HSAArray(agent::HSAAgent, arr::Array{T,N}) where {T,N}
    harr = HSAArray(agent, T, size(arr))
    ref_arr = Ref(arr)
    GC.@preserve ref_arr begin
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            harr.handle[], ref_arr, sizeof(arr))
    end
    return harr
end
HSAArray(arr::Array{T,N}) where {T,N} =
    HSAArray(DEFAULT_AGENT[], arr)

function Array(harr::HSAArray{T,N}) where {T,N}
    arr = Array{T}(undef, size(arr))
    ref_arr = Ref(arr)
    GC.@preserve ref_arr begin
        ccall(:memcpy, Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            ref_arr, harr.handle[], sizeof(arr))
    end
    return harr
end

# FIXME: Allow specifying agent
Base.similar(arr::HSAArray{T,N}) where {T,N} =
    HSAArray(T, size(arr))

Base.size(arr::HSAArray) = arr.size

# TODO: Don't use memset?
Base.fill!(arr::HSAArray{T,N}, value::T) where {T,N} =
    ccall(:memset, Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        arr.handle[], 1, 1024*1024*4)
@inline function Base.getindex(arr::HSAArray{T,N}, idx) where {T,N}
    return T(1)
    #return unsafe_load(arr.handle[], idx*sizeof(T))
end
@inline function Base.setindex!(arr::HSAArray{T,N}, value::T, idx) where {T,N}
    return nothing
    #unsafe_store!(arr.handle[], value, idx*sizeof(T));
end

function Base.show(io::IO, arr::HSAArray)
    print(io, "HSAArray: ")
    # FIXME: Reinterpret to Array{T,N} and show
    #Base.show(io, 
end

### Methods ###

function Base.show(io::IO, agent::HSAAgent)
    print(io, "HSAAgent($(agent.agent)): Name=$(name(agent)), Type=$(device_type(agent))")
end

function get_agents()
    agents = Ref(Vector{HSAAgent}())
    GC.@preserve agents begin
        func = @cfunction(iterate_agents_cb, hsa_status_t,
                (hsa_agent_t, Ref{Vector{HSAAgent}}))
        @check hsa_iterate_agents(func, agents)
        _agents = agents[]
    end
    #=
    # TODO: Remove this
    agents = agents[]
    _agents = HSAAgent[]
    for idx in 1:length(agents)
        !isassigned(agents, idx) && break
        push!(_agents, agents[idx])
    end
    =#
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

function name(agent::HSAAgent)
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
    @assert kind == :finegrained "Non-finegrained regions not yet implemented"
    region = newref!(Ref{hsa_region_t}, typemax(UInt64))
    func = @cfunction(get_fine_grained_memory_region_cb, hsa_status_t,
            (hsa_region_t, Ptr{hsa_region_t}))
    hsa_agent_iterate_regions(agent.agent, func, region)
    @check (region[].handle == typemax(UInt64)) ? HSA_STATUS_ERROR : HSA_STATUS_SUCCESS
    return region
end

function launch!(queue::HSAQueue, kernel::HSAKernelInstance,
                 signal::HSASignal; workgroup_size=nothing, grid_size=nothing)
    @assert workgroup_size !== nothing "Must specify workgroup_size kwarg"
    @assert grid_size !== nothing "Must specify grid_size kwarg"

    queue = queue.queue
    signal = signal.signal
    args = kernel.args

    # Obtain the current queue write index
    index = hsa_queue_load_write_index_relaxed(queue[])

    # Write the aql packet at the calculated queue index address
    header = Ref{UInt16}(0)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_ACQUIRE_FENCE_SCOPE)
    header[] |= Int(HSA_FENCE_SCOPE_SYSTEM) << Int(HSA_PACKET_HEADER_RELEASE_FENCE_SCOPE)
    header[] |= Int(HSA_PACKET_TYPE_KERNEL_DISPATCH) << Int(HSA_PACKET_HEADER_TYPE)
    # FIXME: __atomic_store_n((uint16_t*)(&dispatch_packet->header), header, __ATOMIC_RELEASE);

    # TODO: Make this less bad!
    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}()
    _packet = dispatch_packet[]
    @set! _packet.header = header[]
    @set! _packet.setup |= 1 << Int(HSA_KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
    @set! _packet.workgroup_size_x = workgroup_size[1]
    @set! _packet.workgroup_size_y = workgroup_size[2]
    @set! _packet.workgroup_size_z = workgroup_size[3]
    @set! _packet.grid_size_x = grid_size[1]
    @set! _packet.grid_size_y = grid_size[2]
    @set! _packet.grid_size_z = grid_size[3]
    @set! _packet.completion_signal = signal[]
    @set! _packet.kernel_object = kernel_object[]
    @set! _packet.kernarg_address = kernarg_address[]
    @set! _packet.private_segment_size = private_segment_size[]
    @set! _packet.group_segment_size = group_segment_size[]
    dispatch_packet = Ref{hsa_kernel_dispatch_packet_t}(_packet)

    _queue = unsafe_load(queue[])
    queueMask = UInt32(_queue.size - 1)
    baseaddr_ptr = Ptr{hsa_kernel_dispatch_packet_t}(_queue.base_address)
    baseaddr_ptr += sizeof(hsa_kernel_dispatch_packet_t) * (index & queueMask)
    dispatch_packet_ptr = Base.unsafe_convert(Ptr{hsa_kernel_dispatch_packet_t}, dispatch_packet)
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

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

function __init__()
    configured || return

    # Make sure we load the library found by the last `] build`
    # TODO: Should we `dlopen` here to make sure the library is still there?
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))

    # NOTE: We want to always be able to load the package, regardless of
    # whether HSA libraries are found (just like the CUDA* packages)
    @check hsa_init()
    atexit() do
        hsa_shut_down()
    end
end

end
