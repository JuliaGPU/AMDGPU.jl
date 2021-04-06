export HostCall, hostcall!

const SENTINEL_COUNTER = Ref{Int}(2)
const SENTINEL_LOCK = ReentrantLock()
const DEFAULT_HOSTCALL_LATENCY = 0.01

"""
    HostCall{S,RT,AT}

GPU-compatible struct for making hostcalls.
"""
struct HostCall{S,RT,AT}
    signal::S
    host_sentinel::Int
    device_sentinel::Int
    buf_ptr::LLVMPtr{UInt8,AS.Global}
    buf_len::UInt
end
function HostCall(RT::Type, AT::Type{<:Tuple}, signal::S;
                  agent=get_default_agent(), buf_len=nothing) where {S<:UInt64}
    # FIXME: atomic_add!
    host_sentinel, device_sentinel = lock(SENTINEL_LOCK) do
        host_sentinel = SENTINEL_COUNTER[]
        SENTINEL_COUNTER[] += 1
        device_sentinel = SENTINEL_COUNTER[]
        SENTINEL_COUNTER[] += 1
        if SENTINEL_COUNTER[] > typemax(Int64)-2
            SENTINEL_COUNTER[] = 2
            @debug "Sentinel counter wrapped around!"
        end
        return host_sentinel, device_sentinel
    end
    if buf_len === nothing
        buf_len = 0
        for T in AT.parameters
            @assert isbitstype(T) "Hostcall arguments must be bits-type"
            buf_len += sizeof(T)
        end
    end
    buf_len = max(sizeof(UInt64), buf_len) # make room for return buffer pointer
    buf = Mem.alloc(agent, buf_len; coherent=true)
    buf_ptr = LLVMPtr{UInt8,AS.Global}(Base.unsafe_convert(Ptr{UInt8}, buf))
    HostCall{S,RT,AT}(signal, host_sentinel, device_sentinel, buf_ptr, buf_len)
end

## device signal functions
# TODO: device_signal_load, device_signal_add!, etc.
@inline device_signal_store!(signal::HSA.Signal, value::Int64) =
    device_signal_store!(signal.handle, value)
@inline @generated function device_signal_store!(signal::UInt64, value::Int64)
    JuliaContext() do ctx
        T_nothing = convert(LLVMType, Nothing, ctx)
        T_i32 = LLVM.Int32Type(ctx)
        T_i64 = LLVM.Int64Type(ctx)

        # create a function
        llvm_f, _ = create_function(T_nothing, [T_i64, T_i64])
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            position!(builder, entry)

            T_signal_store = LLVM.FunctionType(T_nothing, [T_i64, T_i64, T_i32])
            signal_store = LLVM.Function(mod, "__ockl_hsa_signal_store", T_signal_store)
            call!(builder, signal_store, [parameters(llvm_f)[1],
                                          parameters(llvm_f)[2],
                                          # __ATOMIC_RELEASE == 3
                                          ConstantInt(Int32(3), ctx)])

            ret!(builder)
        end

        call_function(llvm_f, Nothing, Tuple{UInt64,Int64}, :((signal,value)))
    end
end
@inline device_signal_wait(signal::HSA.Signal, value::Int64) =
    device_signal_wait(signal.handle, value)
@inline @generated function device_signal_wait(signal::UInt64, value::Int64)
    JuliaContext() do ctx
        T_nothing = convert(LLVMType, Nothing, ctx)
        T_i32 = LLVM.Int32Type(ctx)
        T_i64 = LLVM.Int64Type(ctx)

        # create a function
        llvm_f, _ = create_function(T_nothing, [T_i64, T_i64])
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            signal_match = BasicBlock(llvm_f, "signal_match", ctx)
            signal_miss = BasicBlock(llvm_f, "signal_miss", ctx)

            position!(builder, entry)
            br!(builder, signal_miss)

            position!(builder, signal_miss)
            T_sleep = LLVM.FunctionType(T_nothing, [T_i32])
            sleep_f = LLVM.Function(mod, "llvm.amdgcn.s.sleep", T_sleep)
            call!(builder, sleep_f, [ConstantInt(Int32(1), ctx)])
            T_signal_load = LLVM.FunctionType(T_i64, [T_i64, T_i32])
            signal_load = LLVM.Function(mod, "__ockl_hsa_signal_load", T_signal_load)
            loaded_value = call!(builder, signal_load, [parameters(llvm_f)[1],
                                                        # __ATOMIC_ACQUIRE == 2
                                                        ConstantInt(Int32(2), ctx)])
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, parameters(llvm_f)[2])
            br!(builder, cond, signal_match, signal_miss)

            position!(builder, signal_match)
            ret!(builder)
        end

        call_function(llvm_f, Nothing, Tuple{UInt64,Int64}, :((signal,value)))
    end
end

## Device

"Calls the host function stored in `hc` with arguments `args`."
@inline function hostcall!(hc::HostCall{UInt64,RT,AT}, args...) where {RT,AT}
    _hostcall_write_args!(hc, args...)
    _hostcall!(hc)
end
@inline @generated function _hostcall_write_args!(hc::HostCall{UInt64,RT,AT}, args...) where {RT,AT}
    ex = Expr(:block)

    # Copy arguments into buffer
    # Modified from CUDAnative src/device/cuda/dynamic_parallelism.jl
    off = 1
    for i in 1:length(args)
        T = args[i]
        sz = sizeof(T)
        # TODO: Should we do what CUDAnative does instead?
        ptr = :(reinterpret(LLVMPtr{$T,AS.Global}, hc.buf_ptr+$off-1))
        push!(ex.args, :(Base.unsafe_store!($ptr, args[$i])))
        off += sz
    end

    return ex
end
@inline @generated function _hostcall!(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    ex = Expr(:block)

    # Ring the doorbell
    push!(ex.args, :($device_signal_store!(hc.signal, hc.device_sentinel)))

    # Wait on doorbell
    push!(ex.args, :($device_signal_wait(hc.signal, hc.host_sentinel)))

    # Get return buffer and load first value
    ptr = :(reinterpret(LLVMPtr{LLVMPtr{$RT,AS.Global},AS.Global}, hc.buf_ptr))
    push!(ex.args, :(unsafe_load(unsafe_load($ptr))))

    return ex
end

## Host

@generated function _hostcall_args(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    ex = Expr(:tuple)

    # Copy arguments into buffer
    off = 1
    for i in 1:length(AT.parameters)
        T = AT.parameters[i]
        sz = sizeof(T)
        # TODO: Should we do what CUDAnative does instead?
        ptr = :(reinterpret(LLVMPtr{$T,AS.Global}, hc.buf_ptr+$off-1))
        # FIXME: We should not be using a device intrinsic here, even though it works...
        push!(ex.args, :(Base.unsafe_load($ptr)))
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

"""
    HostCall(func, return_type::Type, arg_types::Type{Tuple}) -> HostCall

Construct a `HostCall` that executes `func` with the arguments passed from the
calling kernel. `func` must be passed arguments of types contained in
`arg_types`, and must return a value of type `return_type`, or else the
hostcall will fail with undefined behavior.

Note: This API is currently experimental and is subject to change at any time.
"""
function HostCall(func, rettype, argtypes; return_task=false,
                  agent=get_default_agent(), maxlat=DEFAULT_HOSTCALL_LATENCY,
                  timeout=nothing, continuous=false, buf_len=nothing)
    signal = HSASignal()
    hc = HostCall(rettype, argtypes, signal.signal[].handle; agent=agent, buf_len=buf_len)

    tsk = @async begin
        ret_buf = Ref{Mem.Buffer}()
        while true
            try
                try
                    if !_hostwait(signal, hc.device_sentinel; maxlat=maxlat, timeout=timeout)
                        error("Hostwait timeout")
                    end
                catch err
                    throw(HostCallException("Error during hostwait", err))
                end
                if length(argtypes.parameters) > 0
                    args = try
                        _hostcall_args(hc)
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
                    ret_len = sizeof(ret)
                    ret_buf = Mem.alloc(agent, ret_len; coherent=true) # FIXME: Don't be coherent
                    ret_buf_ptr = Base.unsafe_convert(Ptr{typeof(ret)}, ret_buf)
                    Base.unsafe_store!(ret_buf_ptr, ret)
                    ret_buf_ptr = Base.unsafe_convert(Ptr{UInt64}, ret_buf)
                    args_buf_ptr = reinterpret(Ptr{UInt64}, hc.buf_ptr)
                    Base.unsafe_store!(args_buf_ptr, ret_buf_ptr)
                    HSA.signal_store_release(signal.signal[], hc.host_sentinel)
                catch err
                    throw(HostCallException("Error returning hostcall result", err))
                end
                @debug "Hostcall: Host function return completed"
                continuous || break
            catch err
                @error "Hostcall error" exception=(err,catch_backtrace())
                # TODO: Gracefully terminate just the immediate waiters
                # FIXME: Get the right queue
                kill_queue!(get_default_queue(agent))
                continuous || rethrow(err)
            end
        end
        # TODO: This is probably a bad idea to free while the kernel might
        # still hold a reference. We should probably have some way to
        # reference count these buffers from kernels (other than just
        # using a ROCArray, which can't currently be serialized to the
        # GPU).
        if isassigned(ret_buf)
            Mem.free(ret_buf)
        end
        Mem.free(hc.buf_ptr)
    end

    if return_task
        return hc, tsk
    else
        return hc
    end
end

# CPU functions
get_value(hc::HostCall{UInt64,RT,AT} where {RT,AT}) =
    HSA.signal_load_scacquire(HSA.Signal(hc.signal))
function _hostwait(signal, sentinel; maxlat=DEFAULT_HOSTCALL_LATENCY, timeout=nothing)
    @debug "Hostcall: Waiting on signal for sentinel: $sentinel"
    start_time = time_ns()
    while true
        value = HSA.signal_load_scacquire(signal.signal[])
        if value == sentinel
            @debug "Hostcall: Signal triggered with sentinel: $sentinel"
            return true
        end
        if timeout !== nothing
            now_time = time_ns()
            diff_time = (now_time - start_time) / 10^9
            if diff_time > timeout
                @debug "Hostcall: Signal wait timeout with sentinel: $sentinel"
                return false
            end
        end
        sleep(maxlat)
    end
end
