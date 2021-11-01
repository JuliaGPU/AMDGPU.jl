export HostCall, hostcall!

const DEFAULT_HOSTCALL_LATENCY = 0.01

## Sentinels in order of execution

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

## Error sentinels

"Fatal error on device wavefront accessing the signal."
const DEVICE_ERR_SENTINEL = 5

"Fatal error on host thread accessing the signal."
const HOST_ERR_SENTINEL = 6

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
                  agent=get_default_agent(), buf_len=nothing) where {S<:UInt64}
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
    HSA.signal_store_release(HSA.Signal(signal), READY_SENTINEL)
    memfence!(Val(:seq_cst))
    HostCall{S,RT,AT}(signal, buf_ptr, buf_len)
end

## device signal functions
# TODO: device_signal_load, device_signal_add!, etc.
@inline device_signal_store!(signal::HSA.Signal, value::Int64) =
    device_signal_store!(signal.handle, value)
@noinline @generated function device_signal_store!(signal::UInt64, value::Int64)
    Context() do ctx
        T_nothing = convert(LLVMType, Nothing; ctx)
        T_i32 = LLVM.Int32Type(ctx)
        T_i64 = LLVM.Int64Type(ctx)

        # create a function
        llvm_f, _ = create_function(T_nothing, [T_i64, T_i64])
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            position!(builder, entry)

            T_signal_store = LLVM.FunctionType(T_nothing, [T_i64, T_i64, T_i32])
            signal_store = LLVM.Function(mod, "__ockl_hsa_signal_store", T_signal_store)
            call!(builder, signal_store, [parameters(llvm_f)[1],
                                          parameters(llvm_f)[2],
                                          # __ATOMIC_RELEASE == 3
                                          ConstantInt(Int32(3); ctx)])

            ret!(builder)
        end

        call_function(llvm_f, Nothing, Tuple{UInt64,Int64}, :signal, :value)
    end
end
@inline device_signal_wait(signal::HSA.Signal, value::Int64) =
    device_signal_wait(signal.handle, value)
@noinline @generated function device_signal_wait(signal::UInt64, value::Int64)
    Context() do ctx
        T_nothing = convert(LLVMType, Nothing; ctx)
        T_i32 = LLVM.Int32Type(ctx)
        T_i64 = LLVM.Int64Type(ctx)

        # create a function
        llvm_f, _ = create_function(T_nothing, [T_i64, T_i64])
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry"; ctx)
            signal_match = BasicBlock(llvm_f, "signal_match"; ctx)
            signal_miss = BasicBlock(llvm_f, "signal_miss"; ctx)
            signal_miss_1 = BasicBlock(llvm_f, "signal_miss_1"; ctx)
            signal_miss_2 = BasicBlock(llvm_f, "signal_miss_2"; ctx)
            signal_fail = BasicBlock(llvm_f, "signal_fail"; ctx)

            position!(builder, entry)
            br!(builder, signal_miss)

            position!(builder, signal_miss)
            T_sleep = LLVM.FunctionType(T_nothing, [T_i32])
            sleep_f = LLVM.Function(mod, "llvm.amdgcn.s.sleep", T_sleep)
            call!(builder, sleep_f, [ConstantInt(Int32(1); ctx)])
            T_signal_load = LLVM.FunctionType(T_i64, [T_i64, T_i32])
            signal_load = LLVM.Function(mod, "__ockl_hsa_signal_load", T_signal_load)
            loaded_value = call!(builder, signal_load, [parameters(llvm_f)[1],
                                                        # __ATOMIC_ACQUIRE == 2
                                                        ConstantInt(Int32(2); ctx)])
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, parameters(llvm_f)[2])
            br!(builder, cond, signal_match, signal_miss_1)

            position!(builder, signal_miss_1)
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, ConstantInt(Int64(DEVICE_ERR_SENTINEL); ctx))
            br!(builder, cond, signal_fail, signal_miss_2)

            position!(builder, signal_miss_2)
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, ConstantInt(Int64(HOST_ERR_SENTINEL); ctx))
            br!(builder, cond, signal_fail, signal_miss)

            position!(builder, signal_fail)
            call!(builder, GPUCompiler.Runtime.get(:signal_exception))
            unreachable!(builder)

            position!(builder, signal_match)
            ret!(builder)
        end

        call_function(llvm_f, Nothing, Tuple{UInt64,Int64}, :signal, :value)
    end
end
@noinline @generated function device_signal_wait_cas!(signal::UInt64, expected::Int64, value::Int64)
    JuliaContext() do ctx
        T_nothing = convert(LLVMType, Nothing, ctx)
        T_i32 = LLVM.Int32Type(ctx)
        T_i64 = LLVM.Int64Type(ctx)

        # create a function
        llvm_f, _ = create_function(T_nothing, [T_i64, T_i64, T_i64])
        mod = LLVM.parent(llvm_f)

        # generate IR
        Builder(ctx) do builder
            entry = BasicBlock(llvm_f, "entry", ctx)
            signal_match = BasicBlock(llvm_f, "signal_match", ctx)
            signal_miss = BasicBlock(llvm_f, "signal_miss", ctx)
            signal_miss_1 = BasicBlock(llvm_f, "signal_miss_1", ctx)
            signal_miss_2 = BasicBlock(llvm_f, "signal_miss_2", ctx)
            signal_fail = BasicBlock(llvm_f, "signal_fail", ctx)
            signal_test_and_set = BasicBlock(llvm_f, "signal_test_and_set", ctx)

            position!(builder, entry)
            br!(builder, signal_miss)

            position!(builder, signal_miss)

            # Sleep
            T_sleep = LLVM.FunctionType(T_nothing, [T_i32])
            sleep_f = LLVM.Function(mod, "llvm.amdgcn.s.sleep", T_sleep)
            call!(builder, sleep_f, [ConstantInt(Int32(1), ctx)])

            # Test
            T_signal_load = LLVM.FunctionType(T_i64, [T_i64, T_i32])
            signal_load = LLVM.Function(mod, "__ockl_hsa_signal_load", T_signal_load)
            test_loaded_value = call!(builder, signal_load, [parameters(llvm_f)[1],
                                                             # __ATOMIC_ACQUIRE == 2
                                                             ConstantInt(Int32(2), ctx)])
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, test_loaded_value, parameters(llvm_f)[2])
            br!(builder, cond, signal_test_and_set, signal_miss_1)

            # Test-and-set
            position!(builder, signal_test_and_set)
            T_signal_cas = LLVM.FunctionType(T_i64, [T_i64, T_i64, T_i64, T_i32])
            signal_cas = LLVM.Function(mod, "__ockl_hsa_signal_cas", T_signal_cas)
            set_loaded_value = call!(builder, signal_cas, [parameters(llvm_f)[1],
                                                           parameters(llvm_f)[2],
                                                           parameters(llvm_f)[3],
                                                           # __ATOMIC_ACQREL == 4
                                                           ConstantInt(Int32(4), ctx)])
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, set_loaded_value, parameters(llvm_f)[2])
            br!(builder, cond, signal_match, signal_miss_1)

            position!(builder, signal_miss_1)
            loaded_value = phi!(builder, T_i64, "loaded_value")
            append!(LLVM.incoming(loaded_value), [(test_loaded_value, signal_miss), (set_loaded_value, signal_test_and_set)])

            # Device error
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, ConstantInt(Int64(DEVICE_ERR_SENTINEL), ctx))
            br!(builder, cond, signal_fail, signal_miss_2)

            # Host error
            position!(builder, signal_miss_2)
            cond = icmp!(builder, LLVM.API.LLVMIntEQ, loaded_value, ConstantInt(Int64(HOST_ERR_SENTINEL), ctx))
            br!(builder, cond, signal_fail, signal_miss)

            position!(builder, signal_fail)
            call!(builder, GPUCompiler.Runtime.get(:signal_exception))
            unreachable!(builder)

            position!(builder, signal_match)
            ret!(builder)
        end

        call_function(llvm_f, Nothing, Tuple{UInt64,Int64,Int64}, :((signal,expected,value)))
    end
end
"Calls the host function stored in `hc` with arguments `args`."
@inline function hostcall!(hc::HostCall, args...)
    _hostcall_lock!(hc)
    _hostcall_write_args!(hc, args...)
    _hostcall!(hc)
end
function _hostcall_lock!(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    # Acquire lock on hostcall buffer
    if workitemIdx().x == 1
        device_signal_wait_cas!(hc.signal, READY_SENTINEL, DEVICE_LOCK_SENTINEL)
    end
end
@generated function _hostcall_write_args!(hc::HostCall{UInt64,RT,AT}, args...) where {RT,AT}
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
@generated function _hostcall!(hc::HostCall{UInt64,RT,AT}) where {RT,AT}
    ex = Expr(:block)
    @gensym shmem ptr

    push!(ex.args, quote
        if $RT !== Nothing
            $shmem = $alloc_local(:hostcall_return, $RT, 1)
        end
        if $workitemIdx().x == 1
            # Ensure arguments are written
            $memfence!(Val(:seq_cst))
            $device_signal_wait_cas!(hc.signal, $DEVICE_LOCK_SENTINEL, $DEVICE_MSG_SENTINEL)

            # Wait on host message
            $device_signal_wait(hc.signal, $HOST_MSG_SENTINEL)

            # Get return buffer and load first value
            $memfence!(Val(:seq_cst))
            $ptr = reinterpret(LLVMPtr{LLVMPtr{$RT,AS.Global},AS.Global}, hc.buf_ptr)
            $ptr = unsafe_load($ptr)
            if UInt64($ptr) == 0
                $device_signal_store!(hc.signal, $DEVICE_ERR_SENTINEL)
                AMDGPU.signal_exception()
            end
            if $RT !== Nothing
                unsafe_store!($shmem, unsafe_load($ptr)::$RT)
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

    ex
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
        push!(ex.args, quote
            lref = Ref{$T}()
            HSA.memory_copy(reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{$T}, lref)),
                            reinterpret(Ptr{Cvoid}, hc.buf_ptr+$(off-1)),
                            $sz) |> check
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
        ret_len = 0
        try
            while true
                if !_hostwait(signal; maxlat=maxlat, timeout=timeout)
                    throw(HostCallException("Hostcall: Timeout on signal $(signal.signal[])"))
                end
                # FIXME: Lock the signal
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
                    # TODO: Don't be coherent
                    if isassigned(ret_buf) && (ret_len != sizeof(ret))
                        Mem.free(ret_buf[])
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.alloc(agent, ret_len; coherent=true)
                    elseif !isassigned(ret_buf)
                        ret_len = sizeof(ret)
                        ret_buf[] = Mem.alloc(agent, ret_len; coherent=true)
                    end
                    ret_ref = Ref{rettype}(ret)
                    ret_ptr = Base.unsafe_convert(Ptr{Cvoid}, ret_buf[])
                    if sizeof(ret) > 0
                        GC.@preserve ret_ref begin
                            src_ptr = reinterpret(Ptr{Cvoid}, Base.unsafe_convert(Ptr{rettype}, ret_ref))
                            HSA.memory_copy(ret_ptr, src_ptr, sizeof(ret)) |> check
                        end
                    end
                    args_buf_ptr = reinterpret(Ptr{Cvoid}, hc.buf_ptr)
                    ret_buf_ref = Ref{Ptr{Cvoid}}(ret_ptr)
                    GC.@preserve ret_buf_ref begin
                        unsafe_store!(reinterpret(Ptr{Ptr{Cvoid}}, args_buf_ptr), ret_ptr)
                    end
                    memfence!(Val(:seq_cst))
                    HSA.signal_store_release(signal.signal[], HOST_MSG_SENTINEL)
                catch err
                    throw(HostCallException("Error returning hostcall result", err))
                end
                @debug "Hostcall: Host function return completed"
                continuous || break
            end
        catch err
            @error "Hostcall error" exception=(err,catch_backtrace())
            # TODO: Gracefully terminate just the immediate waiters
            # FIXME: Get the right queue
            kill_queue!(get_default_queue(agent))
            HSA.signal_store_release(signal.signal[], HOST_ERR_SENTINEL)
            continuous || rethrow(err)
        finally
            # TODO: This is probably a bad idea to free while the kernel might
            # still hold a reference. We should probably have some way to
            # reference count these buffers from kernels (other than just
            # using a ROCArray, which can't currently be serialized to the
            # GPU).
            if isassigned(ret_buf)
                Mem.free(ret_buf[])
            end
            Mem.free(hc.buf_ptr)
        end
    end

    if return_task
        return hc, tsk
    else
        return hc
    end
end

# CPU functions
function _hostwait(signal; maxlat=DEFAULT_HOSTCALL_LATENCY, timeout=nothing)
    @debug "Hostcall: Waiting on signal $signal"
    start_time = time_ns()
    while true
        prev = HSA.signal_load_scacquire(signal.signal[])
        if prev == DEVICE_MSG_SENTINEL
            prev = HSA.signal_cas_scacq_screl(signal, DEVICE_MSG_SENTINEL, HOST_LOCK_SENTINEL)
            if prev == DEVICE_MSG_SENTINEL
                @debug "Hostcall: Device message on signal $signal"
                return true
            end
        elseif prev == DEVICE_ERR_SENTINEL
            @debug "Hostcall: Device error on signal $signal"
            throw(HostCallException("Hostcall: Device error on signal $(signal.signal[])"))
        elseif timeout !== nothing
            now_time = time_ns()
            diff_time = (now_time - start_time) / 10^9
            if diff_time > timeout
                @debug "Hostcall: Signal wait timeout on signal $signal"
                return false
            end
        end
        @debug "Hostcall: Value of $prev on signal $signal"
        sleep(maxlat)
    end
end
