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

## Hostcall implementation

"""
    HostCall{S,RT,AT}

GPU-compatible struct for making hostcalls.
"""
struct HostCall{S,RT,AT}
    signal::S
    buf_ptr::LLVMPtr{UInt8,AS.Global}
    buf_len::UInt
end
function HostCall(RT::Type, AT::Type{<:Tuple}, signal::S;
                  device=AMDGPU.default_device(), buf_len=nothing) where {S<:UInt64}
    if buf_len === nothing
        buf_len = 0
        for T in AT.parameters
            @assert isbitstype(T) "Hostcall arguments must be bits-type"
            buf_len += sizeof(T)
        end
    end
    buf_len = max(sizeof(UInt64), buf_len) # make room for return buffer pointer
    buf = Mem.alloc(device, buf_len; coherent=true)
    buf_ptr = LLVMPtr{UInt8,AS.Global}(Base.unsafe_convert(Ptr{UInt8}, buf))
    HSA.signal_store_release(HSA.Signal(signal), READY_SENTINEL)
    HostCall{S,RT,AT}(signal, buf_ptr, buf_len)
end

@inline device_sleep(duration::Int32) = ccall("llvm.amdgcn.s.sleep", llvmcall, Cvoid, (Int32,), duration)
@inline device_sethalt(code::Int32=1) = ccall("llvm.amdgcn.s.sethalt", llvmcall, Cvoid, (Int32,), code)

const ATOMIC_MONOTONIC = Int32(1)
const ATOMIC_ACQUIRE = Int32(2)
const ATOMIC_RELEASE = Int32(3)
const ATOMIC_ACQ_REL = Int32(4)
const ATOMIC_SEQ_CST = Int32(5)

## device signal functions
@inline device_signal_load(signal::UInt64, order::Int32=ATOMIC_ACQUIRE) =
    ccall("extern __ockl_hsa_signal_load", llvmcall, Int64, (UInt64, Int32), signal, order)
@inline device_signal_load(signal::HSA.Signal, order::Int32=ATOMIC_ACQUIRE) =
    device_signal_load(signal.handle, order)

@inline device_signal_store!(signal::UInt64, value::Int64, order::Int32=ATOMIC_RELEASE) =
    ccall("extern __ockl_hsa_signal_store", llvmcall, Int64, (UInt64, Int64, Int32), signal, value, order)
@inline device_signal_store!(signal::HSA.Signal, value::Int64, order::Int32=ATOMIC_RELEASE) =
    device_signal_store!(signal.handle, value, order)

@inline device_signal_cas!(signal::UInt64, expected::Int64, value::Int64, order::Int32=ATOMIC_ACQ_REL) =
    ccall("extern __ockl_hsa_signal_cas", llvmcall, Int64, (UInt64, Int64, Int64, Int32), signal, expected, value, order)
@inline device_signal_cas!(signal::HSA.Signal, expected::Int64, value::Int64, order::Int32=ATOMIC_ACQ_REL) =
    device_signal_cas!(signal.handle, expected, value, order)

# hostcall signal helpers

@inline function hostcall_device_signal_wait(signal::UInt64, value::Int64, order::Int32=ATOMIC_ACQUIRE)
    while true
        loaded = device_signal_load(signal, order)
        if loaded == value
            return
        end
        if loaded == DEVICE_ERR_SENTINEL
            signal_exception()
            #trap()
        end
        if loaded == HOST_ERR_SENTINEL
            signal_exception()
            #trap()
        end
        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(5))
    end
end
@inline hostcall_device_signal_wait(signal::HSA.Signal, value::Int64, order::Int32=ATOMIC_ACQUIRE) =
    hostcall_device_signal_wait(signal.handle, value, order)
@inline function hostcall_device_signal_wait_cas!(signal::UInt64, expected::Int64, value::Int64, order::Int32=ATOMIC_ACQ_REL)
    while true
        loaded = device_signal_cas!(signal, expected, value, order)
        if loaded == expected
            return
        end
        if loaded == DEVICE_ERR_SENTINEL
            signal_exception()
            trap()
        end
        if loaded == HOST_ERR_SENTINEL
            signal_exception()
            trap()
        end
        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(127))
    end
end
@inline hostcall_device_signal_wait_cas!(signal::HSA.Signal, expected::Int64, value::Int64, order::Int32=ATOMIC_ACQ_REL) =
    hostcall_device_signal_wait_cas!(signal.handle, expected, value, order)

## Device

"Calls the host function stored in `hc` with arguments `args`."
@inline function hostcall!(hc::HostCall{UInt64,RT,AT}, args...) where {RT,AT}
    hostcall_device_lock!(hc)
    hostcall_device_write_args!(hc, args...)
    hostcall_device_trigger_and_return!(hc)
end
function hostcall_device_lock!(hc::HostCall)
    # Acquire lock on hostcall buffer
    if workitemIdx().x == 1
        hostcall_device_signal_wait_cas!(hc.signal, READY_SENTINEL, DEVICE_LOCK_SENTINEL)
    end
end
@generated function hostcall_device_write_args!(hc::HostCall{UInt64,RT,AT}, args...) where {RT,AT}
    ex = Expr(:block)

    # Copy arguments into buffer
    # Modified from CUDAnative src/device/cuda/dynamic_parallelism.jl
    off = 1
    for i in 1:length(args)
        T = args[i]
        sz = sizeof(T)
        # FIXME: Use proper alignment
        ptr = :(reinterpret(LLVMPtr{$T,AS.Global}, hc.buf_ptr+$off-1))
        push!(ex.args, :(Base.unsafe_store!($ptr, args[$i])))
        off += sz
    end

    return quote
        if $workitemIdx().x == 1
            $ex
        end
    end
end
@generated function hostcall_device_trigger_and_return!(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    ex = Expr(:block)
    @gensym shmem buf_ptr ret_ptr hostcall_return

    push!(ex.args, quote
        if $RT !== Nothing
            # FIXME: This is not valid without the @inline
            #$shmem = $alloc_local($hostcall_return, $RT, 1)
            # But this is fine (if slower)
            $shmem = $get_global_pointer($(Val(hostcall_return)), $RT)
        end
        if $workitemIdx().x == 1
            # Ensure arguments are written
            $hostcall_device_signal_wait_cas!(hc.signal, $DEVICE_LOCK_SENTINEL, $DEVICE_MSG_SENTINEL)

            # Wait on host message
            $hostcall_device_signal_wait(hc.signal, $HOST_MSG_SENTINEL)

            # Get return buffer and load first value
            if $RT !== Nothing
                $buf_ptr = reinterpret(LLVMPtr{LLVMPtr{$RT,AS.Global},AS.Global}, hc.buf_ptr)
                $ret_ptr = unsafe_load($buf_ptr)
                if UInt64($ret_ptr) == 0
                    $device_signal_store!(hc.signal, $DEVICE_ERR_SENTINEL)
                    AMDGPU.signal_exception()
                    AMDGPU.Device.trap()
                end
                unsafe_store!($shmem, unsafe_load($ret_ptr)::$RT)
            end
            $device_signal_store!(hc.signal, $READY_SENTINEL)
        end
        $sync_workgroup()
        if $RT !== Nothing
            unsafe_load($shmem)
        else
            nothing
        end
    end)

    return ex
end

## Host

@generated function hostcall_host_read_args(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    ex = Expr(:tuple)

    # Copy arguments into buffer
    off = 1
    for i in 1:length(AT.parameters)
        T = AT.parameters[i]
        sz = sizeof(T)
        # FIXME: Use correct alignment
        push!(ex.args, quote
            lref = Ref{$T}()
            HSA.memory_copy(reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{$T}, lref)),
                            reinterpret(Ptr{Cvoid}, hc.buf_ptr+$(off-1)),
                            $sz) |> Runtime.check
            lref[]
        end)
        off += sz
    end

    return ex
end

struct HostCallException <: Exception
    reason::String
    err::Union{Exception,Nothing}
    bt::Union{Vector,Nothing}
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

const NAMED_PERDEVICE_HOSTCALLS = Dict{Runtime.ROCDevice, Dict{Symbol, HostCall}}()

function named_perdevice_hostcall(func, device::Runtime.ROCDevice, name::Symbol)
    lock(Runtime.RT_LOCK) do
        hcs = get!(()->Dict{Symbol, HostCall}(), NAMED_PERDEVICE_HOSTCALLS, device)
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
function HostCall(func, rettype, argtypes; return_task=false,
                  device=AMDGPU.default_device(), maxlat=DEFAULT_HOSTCALL_LATENCY[],
                  timeout=nothing, continuous=false, buf_len=nothing)
    signal = Runtime.ROCSignal()
    hc = HostCall(rettype, argtypes, signal.signal[].handle; device=device, buf_len=buf_len)

    tsk = Threads.@spawn begin
        ret_buf = Ref{Mem.Buffer}()
        ret_len = 0
        try
            while true
                if !hostcall_host_wait(signal; maxlat=maxlat, timeout=timeout)
                    throw(HostCallException("Hostcall: Timeout on signal $(signal.signal[])"))
                end
                if length(argtypes.parameters) > 0
                    args = try
                        hostcall_host_read_args(hc)
                    catch err
                        throw(HostCallException("Error getting arguments", err))
                    end
                    @debug "Hostcall: Got arguments of length $(length(args))"
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
                @debug "Hostcall: Host function returning value of type $(typeof(ret))"
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
                    HSA.signal_store_screlease(signal.signal[], HOST_MSG_SENTINEL)
                catch err
                    throw(HostCallException("Error returning hostcall result", err))
                end
                @debug "Hostcall: Host function return completed"
                continuous || break
            end
        catch err
            # Gracefully terminate all waiters
            @error "HostCall error" exception=(err,catch_backtrace())
            HSA.signal_store_screlease(signal.signal[], HOST_ERR_SENTINEL)
            rethrow(err)
        finally
            # We need to free the memory buffers, but first we need to ensure that
            # the device has read from these buffers. Therefore we wait either for
            # READY_SENTINEL or else an error signal.
            while !Runtime.RT_EXITING[]
                prev = HSA.signal_load_scacquire(signal.signal[])

                if prev == READY_SENTINEL || prev == HOST_ERR_SENTINEL || prev == DEVICE_ERR_SENTINEL
                    if isassigned(ret_buf)
                        Mem.free(ret_buf[])
                    end
                    Mem.free(Mem.Buffer(reinterpret(Ptr{Cvoid}, hc.buf_ptr), C_NULL, 0, device, true, false))
                    break
                end
            end

        end
    end

    if return_task
        return hc, tsk
    else
        return hc
    end
end

const DEFAULT_HOSTCALL_TIMEOUT = Ref{Union{Float64, Nothing}}(nothing)
const DEFAULT_HOSTCALL_LATENCY = Ref{Float64}(0.01)

# CPU functions
function hostcall_host_wait(signal; maxlat=DEFAULT_HOSTCALL_LATENCY[], timeout=DEFAULT_HOSTCALL_TIMEOUT[])
    @debug "Hostcall: Waiting on signal $signal"
    start_time = time_ns()
    while !Runtime.RT_EXITING[]
        prev = HSA.signal_load_scacquire(signal.signal[])
        if prev == DEVICE_MSG_SENTINEL
            prev = HSA.signal_cas_scacq_screl(signal.signal[], DEVICE_MSG_SENTINEL, HOST_LOCK_SENTINEL)
            if prev == DEVICE_MSG_SENTINEL
                @debug "Hostcall: Device message on signal $signal"
                return true
            end
        elseif prev == DEVICE_ERR_SENTINEL
            @debug "Hostcall: Device error on signal $signal"
            throw(HostCallException("Device error on signal $(signal.signal[])"))
        end
        if timeout !== nothing
            now_time = time_ns()
            diff_time = (now_time - start_time) / 10^9
            if diff_time > timeout
                @debug "Hostcall: Signal wait timeout on signal $signal"
                return false
            end
        end
        sleep(maxlat)
    end
end
