## Sentinels in order of execution

CEnum.@cenum HostCallState::UInt32 begin
    ### Ready/lock/message sentinels

    # Signal is ready for accessing by host or device
    READY_SENTINEL

    # Device has locked the signal
    DEVICE_LOCK_SENTINEL

    # Device-sourced message is available
    DEVICE_MSG_SENTINEL

    # Host has locked the signal
    HOST_LOCK_SENTINEL

    # Host-sourced message is available
    HOST_MSG_SENTINEL

    ### Error sentinels

    # Fatal error on device wavefront accessing the signal
    DEVICE_ERR_SENTINEL

    # Fatal error on host thread accessing the signal
    HOST_ERR_SENTINEL
end

# Hostcall signal helpers.

@inline function device_signal_load(
    signal_handle::UInt64, order=Val{:acquire}(),
)
    ccall("extern __ockl_hsa_signal_load", llvmcall,
        Int64, (UInt64, Int32), signal_handle, order)
end

@inline function device_signal_store!(
    signal_handle::UInt64, value::Int64, order=Val{:release}(),
)
    ccall("extern __ockl_hsa_signal_store", llvmcall,
        Int64, (UInt64, Int64, Int32), signal_handle, value, order)
end

@inline function device_signal_cas!(
    signal_handle::UInt64, expected::Int64, value::Int64,
    order=Val{:acquire_release}(),
)
    ccall("extern __ockl_hsa_signal_cas", llvmcall,
        Int64, (UInt64, Int64, Int64, Int32),
        signal_handle, expected, value, order)
end

@inline function hostcall_transition_wait!(
    state::StateMachine{HostCallState,UInt64}, expected, value,
    order=Val{:acquire_release}(),
)
    while true
        loaded = transition!(state, expected, value, order)
        loaded == expected && return nothing

        if (loaded == DEVICE_ERR_SENTINEL) || (loaded == HOST_ERR_SENTINEL)
            signal_exception()
        end

        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(5))
    end
end

@inline function hostcall_waitfor(
    state::StateMachine{HostCallState,UInt64}, value, order=Val{:acquire}()
)
    while true
        loaded = get_value(state, order)
        loaded == value && return nothing

        if (loaded == DEVICE_ERR_SENTINEL) || (loaded == HOST_ERR_SENTINEL)
            signal_exception()
        end

        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(5))
    end
end

@inline function host_signal_store!(
    signal::HSA.Signal, value, order::Val{O} = Val{:release}(),
) where O
    if O == :release
        HSA.signal_store_screlease(signal, value)
    elseif O == :relaxed
        HSA.signal_store_relaxed(signal, value)
    else
        throw(ArgumentError("Unsupported `order`: `$order`. Supported values are: `Val{:release}` and `Val{:relaxed}`."))
    end
end

@inline function host_signal_load(
    signal::HSA.Signal, order::Val{O} = Val{:acquire}(),
) where O
    if O == :acquire
        return HSA.signal_load_scacquire(signal)
    elseif O == :relaxed
        return HSA.signal_load_relaxed(signal)
    end
    throw(ArgumentError("Unsupported `order`: `$order`. Supported values are: `Val{:release}` and `Val{:relaxed}`."))
end

@inline function host_signal_cmpxchg!(signal::HSA.Signal, expected, value)
    HSA.signal_cas_scacq_screl(signal, expected, value)
end

@inline function device_sleep(duration::Int32)
    ccall("llvm.amdgcn.s.sleep", llvmcall, Cvoid, (Int32,), duration)
end

@inline function device_sethalt(code::Int32 = Int32(1))
    ccall("llvm.amdgcn.s.sethalt", llvmcall, Cvoid, (Int32,), code)
end

@inline function device_time()
    ccall("llvm.amdgcn.s.memtime", llvmcall, UInt64, ())
end

@inline function device_realtime()
    ccall("llvm.amdgcn.s.memrealtime", llvmcall, UInt64, ())
end
