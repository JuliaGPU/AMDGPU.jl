# Hostcall signal helpers.

@inline function hostcall_device_signal_wait_cas!(
    signal_handle::UInt64, expected::Int64, value::Int64,
    order::Int32 = ATOMIC_ACQ_REL,
)
    while true
        loaded = device_signal_cas!(signal_handle, expected, value, order)
        loaded == expected && return nothing

        if (loaded == DEVICE_ERR_SENTINEL) || (loaded == HOST_ERR_SENTINEL)
            signal_exception()
        end

        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(127))
    end
end

@inline function hostcall_device_signal_wait(
    signal_handle::UInt64, value::Int64, order::Int32 = ATOMIC_ACQUIRE,
)
    while true
        loaded = device_signal_load(signal_handle, order)
        loaded == value && return nothing

        if (loaded == DEVICE_ERR_SENTINEL) || (loaded == HOST_ERR_SENTINEL)
            signal_exception()
        end

        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(5))
    end
end

@inline function device_signal_load(
    signal_handle::UInt64, order::Int32 = ATOMIC_ACQUIRE,
)
    ccall(
        "extern __ockl_hsa_signal_load", llvmcall,
        Int64, (UInt64, Int32), signal_handle, order)
end

@inline function device_signal_store!(
    signal_handle::UInt64, value::Int64, order::Int32 = ATOMIC_RELEASE,
)
    ccall(
        "extern __ockl_hsa_signal_store", llvmcall,
        Int64, (UInt64, Int64, Int32), signal_handle, value, order)
end

@inline function device_signal_cas!(
    signal_handle::UInt64, expected::Int64, value::Int64,
    order::Int32 = ATOMIC_ACQ_REL,
)
    ccall(
        "extern __ockl_hsa_signal_cas", llvmcall,
        Int64, (UInt64, Int64, Int64, Int32),
        signal_handle, expected, value, order)
end

@inline function store_release!(signal::HSA.Signal, value)
    HSA.signal_store_screlease(signal, value)
end

@inline function set_value_acq_rel!(signal::HSA.Signal, expected, value)
    HSA.signal_cas_scacq_screl(signal, expected, value)
end

@inline function get_value(signal::HSA.Signal)
    HSA.signal_load_scacquire(signal)
end

@inline function device_sleep(duration::Int32)
    ccall("llvm.amdgcn.s.sleep", llvmcall, Cvoid, (Int32,), duration)
end

@inline function device_sethalt(code::Int32 = Int32(1))
    ccall("llvm.amdgcn.s.sethalt", llvmcall, Cvoid, (Int32,), code)
end
