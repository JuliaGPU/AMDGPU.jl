## Sentinels in order of execution

### Ready/lock/message sentinels

"Signal is ready for accessing by host or device."
const READY_SENTINEL = 0

"Device has locked the signal."
const DEVICE_LOCK_SENTINEL = 1

"Device-sourced message is available."
const DEVICE_MSG_SENTINEL = 2

"Host has locked the signal."
const HOST_LOCK_SENTINEL = 3

"Host-sourced message is available."
const HOST_MSG_SENTINEL = 4

### Error sentinels

"Fatal error on device wavefront accessing the signal."
const DEVICE_ERR_SENTINEL = 5

"Fatal error on host thread accessing the signal."
const HOST_ERR_SENTINEL = 6

const DEFAULT_HOSTCALL_TIMEOUT = Ref{Union{Float64, Nothing}}(nothing)
const DEFAULT_HOSTCALL_LATENCY = 0.01

include("hostcall_signal_helpers.jl")

"""
    HostCall{RT,AT}

GPU-compatible struct for making hostcalls.
"""
struct HostCall{RT, AT}
    signal_handle::UInt64
    buf_ptr::LLVMPtr{UInt8, AS.Global}
    buf_len::UInt
end

function HostCall(
    RT::Type, AT::Type{<:Tuple}, signal_handle::UInt64;
    device = AMDGPU.default_device(), buf_len = nothing,
)
    if isnothing(buf_len)
        buf_len = 0
        for T in AT.parameters
            @assert isbitstype(T) "Hostcall arguments must be bits-type"
            buf_len += sizeof(T)
        end
    end

    buf_len = max(sizeof(UInt64), buf_len) # make room for return buffer pointer
    buf = Mem.alloc(device, buf_len; coherent=true) # TODO move to HIP
    buf_ptr = LLVMPtr{UInt8, AS.Global}(Base.unsafe_convert(Ptr{UInt8}, buf))
    host_signal_store!(HSA.Signal(signal_handle), READY_SENTINEL)
    HostCall{RT, AT}(signal_handle, buf_ptr, buf_len)
end

"Calls the host function stored in `hc` with arguments `args`."
@inline function hostcall!(hc::HostCall, args...)
    hostcall!(Val{:group}(), hc, args...)
end

@inline function hostcall!(
    ::Val{mode}, hc::HostCall{RT, AT}, args...,
) where {mode, RT, AT}
    hostcall_device_lock!(Val{mode}(), hc)
    hostcall_device_write_args!(Val{mode}(), hc, args...)
    return hostcall_device_trigger_and_return!(Val{mode}(), hc)
end

macro device_execution_gate(mode, exec_ex)
    if mode isa QuoteNode
        mode = mode.value::Symbol
    end
    @assert mode in (:grid, :group, :wave, :lane) "Invalid mode: $mode"
    ex = Expr(:block)
    if mode == :grid
        push!(ex.args, quote
            # Must be on first item of first group
            if $workgroupIdx().x != 1 || $workitemIdx().x != 1
                @goto gated_done
            end
        end)
    elseif mode == :group
        push!(ex.args, quote
            # Must be on first item of each group
            if $workitemIdx().x != 1
                @goto gated_done
            end
        end)
    elseif mode == :wave
        push!(ex.args, quote
            # Must be on first lane of each wavefront of each group
            is_not_first_lane = Core.Intrinsics.urem_int(
                $workitemIdx().x - UInt32(1), $wavefrontsize()) != 0
            if is_not_first_lane
                @goto gated_done
            end
        end)
    end
    push!(ex.args, quote
        $(esc(exec_ex))
        @label gated_done
        $sync_workgroup()
    end)
    return ex
end

@inline function hostcall_device_lock!(hc::HostCall)
    hostcall_device_lock!(Val{:group}(), hc)
end

@inline @generated function hostcall_device_lock!(
    ::Val{mode}, hc::HostCall,
) where mode
    return quote
        @device_execution_gate $mode begin
            # Acquire lock on hostcall buffer
            hostcall_device_signal_wait_cas!(hc.signal_handle, READY_SENTINEL, DEVICE_LOCK_SENTINEL)
        end
    end
end

@inline function hostcall_device_write_args!(hc::HostCall, args...)
    hostcall_device_write_args!(Val{:group}(), hc, args...)
end

@inline @generated function hostcall_device_write_args!(
    ::Val{mode}, hc::HostCall{RT, AT}, args...,
) where {mode, RT, AT}
    ex = Expr(:block)

    # Copy arguments into buffer
    # Modified from CUDAnative src/device/cuda/dynamic_parallelism.jl
    off = 1
    for i in 1:length(args)
        T = args[i]
        sz = sizeof(T)
        # FIXME: Use proper alignment
        ptr = :(reinterpret(LLVMPtr{$T,AS.Global}, hc.buf_ptr + $off - 1))
        push!(ex.args, :(Base.unsafe_store!($ptr, args[$i])))
        off += sz
    end

    return macroexpand(@__MODULE__, quote
        @device_execution_gate $mode begin
            $ex
        end
    end)
end

@inline function hostcall_device_trigger_and_return!(hc::HostCall)
    hostcall_device_trigger_and_return!(Val{:group}(), hc::HostCall)
end

@inline @generated function hostcall_device_trigger_and_return!(
    ::Val{mode}, hc::HostCall{RT, AT},
) where {mode, RT, AT}
    ex = Expr(:block)
    @gensym shmem buf_ptr ret_ptr

    push!(ex.args, quote
        if $RT !== Nothing
            $shmem = $alloc_local(:hostcall_return, $RT, 1)
        end

        @device_execution_gate $mode begin
            # Ensure arguments are written
            $hostcall_device_signal_wait_cas!(hc.signal_handle, $DEVICE_LOCK_SENTINEL, $DEVICE_MSG_SENTINEL)
            # Wait on host message
            $hostcall_device_signal_wait(hc.signal_handle, $HOST_MSG_SENTINEL)
            # Get return buffer and load first value
            if $RT !== Nothing
                $buf_ptr = reinterpret(LLVMPtr{LLVMPtr{$RT,AS.Global}, AS.Global}, hc.buf_ptr)
                $ret_ptr = unsafe_load($buf_ptr)
                if UInt64($ret_ptr) == 0
                    $device_signal_store!(hc.signal_handle, $DEVICE_ERR_SENTINEL)
                    $signal_exception()
                    $trap()
                end
                unsafe_store!($shmem, unsafe_load($ret_ptr)::$RT)
            end
            $device_signal_store!(hc.signal_handle, $READY_SENTINEL)
        end
        if $RT !== Nothing
            return unsafe_load($shmem)
        else
            return nothing
        end
    end)

    return ex
end

@inline @generated function hostcall_device_args_size(args...)
    sz = 0
    for arg in args
        sz += sizeof(arg)
    end
    return sz
end

@generated function hostcall_host_read_args(hc::HostCall{RT,AT}) where {RT,AT}
    ex = Expr(:tuple)

    # Copy arguments into buffer
    off = 1
    for i in 1:length(AT.parameters)
        T = AT.parameters[i]
        sz = sizeof(T)
        # FIXME: Use correct alignment
        push!(ex.args, quote
            lref = Ref{$T}()
            HSA.memory_copy(
                reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{$T}, lref)),
                reinterpret(Ptr{Cvoid}, hc.buf_ptr + $off - 1), $sz) |> Runtime.check
            lref[]
        end)
        off += sz
    end

    return ex
end

struct HostCallException <: Exception
    reason::String
    err::Union{Exception, Nothing}
    bt::Union{Vector, Nothing}
end

HostCallException(reason) = HostCallException(reason, nothing, backtrace())

HostCallException(reason, err) = HostCallException(reason, err, catch_backtrace())

function Base.showerror(io::IO, err::HostCallException)
    print(io, "HostCallException: $(err.reason)")
    if err.err !== nothing || err.bt !== nothing
        print(io, ":\n")
    end
    err.err !== nothing && Base.showerror(io, err.err)
    err.bt !== nothing && Base.show_backtrace(io, err.bt)
end

const NAMED_PERDEVICE_HOSTCALLS = Dict{
    Runtime.ROCDevice, Dict{Symbol, Tuple{HostCall, Mem.HostBuffer}}}()

function named_perdevice_hostcall(func, dev::Runtime.ROCDevice, name::Symbol)
    lock(Runtime.RT_LOCK) do
        hcs = get!(
            () -> Dict{Symbol, Tuple{HostCall, Mem.HostBuffer}}(),
            NAMED_PERDEVICE_HOSTCALLS, dev)
        return get!(func, hcs, name)
    end
end

"""
    HostCall(func, return_type::Type, arg_types::Type{Tuple}) -> HostCall

Construct a `HostCall` that executes `func` with the arguments passed from the
calling kernel. `func` must be passed arguments of types contained in
`arg_types`, and must return a value of type `return_type`, or else the
hostcall will fail with undefined behavior.

Note: This API is currently experimental and is subject to change at any time.
"""
function HostCall(
    func::Base.Callable, rettype::Type, argtypes::Type{<:Tuple};
    return_task::Bool = false, device = AMDGPU.default_device(),
    maxlat = DEFAULT_HOSTCALL_LATENCY, timeout = nothing,
    continuous = false, buf_len = nothing,
)
    # Create raw HSA signal to avoid ROCSignal finalizer
    # being called too early in the HostCall task.
    signal_ref = Ref{HSA.Signal}()
    HSA.signal_create(1, 0, C_NULL, signal_ref) |> Runtime.check
    signal = signal_ref[]
    AMDGPU.hsaref!()

    hc = HostCall(rettype, argtypes, signal.handle; device, buf_len)

    tsk = Threads.@spawn begin
        ret_buf = Ref{Mem.Buffer}()
        ret_len = 0
        try
            while true
                if !hostcall_host_wait(signal; maxlat=maxlat, timeout=timeout)
                    throw(HostCallException("Hostcall: Timeout on signal $signal"))
                end

                if length(argtypes.parameters) > 0
                    args = try
                        hostcall_host_read_args(hc)
                    catch err
                        throw(HostCallException("Error getting arguments", err))
                    end
                else
                    args = ()
                end
                ret = try
                    func(args...,)
                catch err
                    throw(HostCallException("Error executing host function", err))
                end
                if typeof(ret) != rettype
                    throw(HostCallException("Host function result of wrong type: $(typeof(ret)), expected $rettype"))
                end
                if !isbits(ret)
                    throw(HostCallException("Host function result not isbits: $(typeof(ret))"))
                end

                try
                    if isassigned(ret_buf) && (ret_len < sizeof(ret))
                        Mem.free(ret_buf[])
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.alloc(device, ret_len; coherent=true)
                    elseif !isassigned(ret_buf)
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.alloc(device, ret_len; coherent=true)
                    end
                    ret_ref = Ref{rettype}(ret)
                    GC.@preserve ret_ref begin
                        ret_ptr = Base.unsafe_convert(Ptr{Cvoid}, ret_buf[])
                        if sizeof(ret) > 0
                            src_ptr = reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{rettype}, ret_ref))
                            HSA.memory_copy(ret_ptr, src_ptr, sizeof(ret)) |> Runtime.check
                        end

                        args_buf_ptr = reinterpret(Ptr{Ptr{Cvoid}}, hc.buf_ptr)
                        unsafe_store!(args_buf_ptr, ret_ptr)
                    end
                    host_signal_store!(signal, HOST_MSG_SENTINEL)
                catch err
                    throw(HostCallException("Error returning hostcall result", err))
                end
                continuous || break
            end
        catch err
            # Gracefully terminate all waiters
            host_signal_store!(signal, HOST_ERR_SENTINEL)
            if err isa EOFError
                # If EOF, then Julia is exiting, no need to re-throw.
            else
                @error "HostCall error" exception=(err,catch_backtrace())
                rethrow(err)
            end
        finally
            # We need to free the memory buffers, but first we need to ensure that
            # the device has read from these buffers. Therefore we wait either for
            # READY_SENTINEL or else an error signal.
            while !Runtime.RT_EXITING[]
                prev = host_signal_load(signal)
                if prev == READY_SENTINEL || prev == HOST_ERR_SENTINEL || prev == DEVICE_ERR_SENTINEL
                    if isassigned(ret_buf)
                        Mem.free(ret_buf[])
                    end
                    buf_ptr = reinterpret(Ptr{Cvoid}, hc.buf_ptr)
                    Mem.free(Mem.Buffer(buf_ptr, C_NULL, buf_ptr, 0, device, true, false))
                    break
                end
            end
            # Destroy HSA signal.
            HSA.signal_destroy(signal) |> Runtime.check
            AMDGPU.hsaunref!()
        end
    end

    if return_task
        return hc, tsk
    else
        return hc
    end
end

function hostcall_host_wait(
    signal_handle::HSA.Signal; maxlat=DEFAULT_HOSTCALL_LATENCY,
    timeout=DEFAULT_HOSTCALL_TIMEOUT[],
)
    res::Bool = false
    start_time = time_ns()

    while !Runtime.RT_EXITING[]
        prev = host_signal_load(signal_handle)

        # If device-sourced message is available,
        # lock on host to prevent further writes from the device.
        # If successfully locked on host, done waiting.
        if prev == DEVICE_MSG_SENTINEL
            prev = host_signal_cmpxchg!(
                signal_handle, DEVICE_MSG_SENTINEL, HOST_LOCK_SENTINEL)
            if prev == DEVICE_MSG_SENTINEL
                res = true
                break
            end
        elseif prev == DEVICE_ERR_SENTINEL
            throw(HostCallException("Device error on signal $signal_handle"))
        end

        if timeout !== nothing
            now_time = time_ns()
            diff_time = (now_time - start_time) / 10^9
            if diff_time > timeout
                res = false
                break
            end
        end

        Libc.systemsleep(maxlat)
        yield()
    end
    return res
end
