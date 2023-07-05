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
    RT::Type, AT::Type{<:Tuple}, signal_handle::UInt64; buf_len = nothing,
)
    if isnothing(buf_len)
        buf_len = 0
        for T in AT.parameters
            @assert isbitstype(T) "Hostcall arguments must be bits-type"
            buf_len += sizeof(T)
        end
    end

    buf_len = max(sizeof(UInt64), buf_len) # make room for return buffer pointer
    buf = Mem.HostBuffer(buf_len, AMDGPU.HIP.hipHostAllocMapped)
    buf_ptr = LLVMPtr{UInt8, AS.Global}(Base.unsafe_convert(Ptr{UInt8}, buf))
    host_signal_store!(HSA.Signal(signal_handle), READY_SENTINEL)
    HostCall{RT, AT}(signal_handle, buf_ptr, buf_len)
end

struct HostCallHolder
    hc::HostCall
    task::Task
    finish::Ref{Bool}
    continuous::Ref{Bool}
end

include("hostcall_utils.jl")

"""
    HostCallHolder(func, return_type::Type, arg_types::Type{Tuple}) -> HostCall

Construct a `HostCall` that executes `func` with the arguments passed from the
calling kernel.

`func` must be passed arguments of types contained in `arg_types`,
and must return a value of type `return_type`,
or else the hostcall will fail with undefined behavior.

Note: This API is currently experimental and is subject to change at any time.
"""
function HostCallHolder(
    func::Base.Callable, rettype::Type, argtypes::Type{<:Tuple};
    timeout = nothing, continuous = false, buf_len = nothing,
    maxlat = DEFAULT_HOSTCALL_LATENCY,
)
    signal_ref = Ref{HSA.Signal}()
    HSA.signal_create(1, 0, C_NULL, signal_ref) |> Runtime.check
    signal = signal_ref[]
    AMDGPU.hsaref!()

    hc = HostCall(rettype, argtypes, signal.handle; buf_len)
    finish_ref = Ref{Bool}(false)
    continuous_ref = Ref{Bool}(continuous)

    tsk = Threads.@spawn begin
        ret_buf = Ref{Mem.HostBuffer}(Mem.HostBuffer())
        ret_len = 0

        try
            while true
                if !hostcall_host_wait(signal, finish_ref; maxlat, timeout)
                    Runtime.RT_EXITING[] && break
                    finish_ref[] && break
                    throw(HostCallException("Timeout on signal $signal"))
                end

                args = if isempty(argtypes.parameters)
                    ()
                else
                    try
                        hostcall_host_read_args(hc)
                    catch err
                        throw(HostCallException("Error getting arguments", err))
                    end
                end

                ret = try
                    func(args...,)
                catch err
                    throw(HostCallException("Error executing host function", err))
                end

                typeof(ret) == rettype || throw(HostCallException("""
                    Host function result of wrong type:
                        - returned: $(typeof(ret))
                        - expected: $rettype
                    """))
                isbits(ret) || throw(HostCallException(
                    "Host function result not isbits: $(typeof(ret))"))

                try
                    if ret_buf[].ptr != C_NULL && ret_len < sizeof(ret)
                        Mem.free(ret_buf[])
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.HostBuffer(ret_len, AMDGPU.HIP.hipHostAllocMapped)
                    elseif ret_buf[].ptr == C_NULL
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.HostBuffer(ret_len, AMDGPU.HIP.hipHostAllocMapped)
                    end

                    ret_ref = Ref{rettype}(ret)
                    GC.@preserve ret_ref begin
                        ret_ptr = Base.unsafe_convert(Ptr{Cvoid}, ret_buf[])
                        if sizeof(ret) > 0
                            src_ptr = reinterpret(Ptr{Cvoid},
                                Base.unsafe_convert(Ptr{rettype}, ret_ref))
                            HSA.memory_copy(
                                ret_ptr, src_ptr, sizeof(ret)) |> Runtime.check
                        end

                        args_buf_ptr = reinterpret(Ptr{Ptr{Cvoid}}, hc.buf_ptr)
                        unsafe_store!(args_buf_ptr, ret_ptr)
                    end
                    host_signal_store!(signal, HOST_MSG_SENTINEL)
                catch err
                    throw(HostCallException(
                        "Error returning hostcall result", err))
                end
                continuous_ref[] || break
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
            # We need to free the memory buffers, but first we need
            # to ensure that the device has read from these buffers.
            # Therefore we wait either for READY_SENTINEL or else an error signal.
            while !Runtime.RT_EXITING[]
                prev = host_signal_load(signal)
                not_used =
                    prev == READY_SENTINEL ||
                    prev == HOST_ERR_SENTINEL ||
                    prev == DEVICE_ERR_SENTINEL
                if not_used
                    Mem.free(ret_buf[]) # `free` checks for C_NULL.
                    buf_ptr = reinterpret(Ptr{Cvoid}, hc.buf_ptr)
                    Mem.free(Mem.HostBuffer(buf_ptr, 0))
                    break
                end
            end
            # Destroy HSA signal.
            HSA.signal_destroy(signal) |> Runtime.check
            AMDGPU.hsaunref!()
        end
        return
    end
    HostCallHolder(hc, tsk, finish_ref, continuous_ref)
end

Adapt.adapt(to::Runtime.Adaptor, hc::HostCallHolder) = hc.hc

non_continuous!(hc::HostCallHolder) = hc.continuous[] = false

finish!(hc::HostCallHolder) = hc.finish[] = true

Base.istaskdone(hc::HostCallHolder) = istaskdone(hc.task)

function hostcall_host_wait(
    signal_handle::HSA.Signal, finish_ref::Ref{Bool};
    maxlat=DEFAULT_HOSTCALL_LATENCY, timeout=DEFAULT_HOSTCALL_TIMEOUT[],
)
    res::Bool = false
    start_time = time_ns()

    while !Runtime.RT_EXITING[]
        finish_ref[] && break
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
