const ATOMIC_MONOTONIC = Int32(1)
const ATOMIC_ACQUIRE = Int32(2)
const ATOMIC_RELEASE = Int32(3)
const ATOMIC_ACQ_REL = Int32(4)
const ATOMIC_SEQ_CST = Int32(5)

# Hostcall signal helpers.

@inline function device_signal_load(
    signal_handle::UInt64, order::Int32 = ATOMIC_ACQUIRE,
)
    ccall("extern __ockl_hsa_signal_load", llvmcall,
        Int64, (UInt64, Int32), signal_handle, order)
end

@inline function device_signal_store!(
    signal_handle::UInt64, value::Int64, order::Int32 = ATOMIC_RELEASE,
)
    ccall("extern __ockl_hsa_signal_store", llvmcall,
        Int64, (UInt64, Int64, Int32), signal_handle, value, order)
end

@inline function device_signal_cas!(
    signal_handle::UInt64, expected::Int64, value::Int64,
    order::Int32 = ATOMIC_ACQ_REL,
)
    ccall("extern __ockl_hsa_signal_cas", llvmcall,
        Int64, (UInt64, Int64, Int64, Int32),
        signal_handle, expected, value, order)
end

@inline function hostcall_device_signal_wait_cas!(
    signal_handle::UInt64, expected::Int64,
    value::Int64, order::Int32 = ATOMIC_ACQ_REL,
)
    while true
        loaded = device_signal_cas!(signal_handle, expected, value, order)
        loaded == expected && return nothing

        if (loaded == DEVICE_ERR_SENTINEL) || (loaded == HOST_ERR_SENTINEL)
            signal_exception()
        end

        # FIXME: Make kernel actually sleep
        # device_sethalt(Int32(1))
        device_sleep(Int32(5))
    end
end

@inline function hostcall_device_signal_wait_cas!(
    signal::HSA.Signal, expected::Int64,
    value::Int64, order::Int32 = ATOMIC_ACQ_REL,
)
    hostcall_device_signal_wait_cas!(signal.handle, expected, value, order)
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

@inline function hostcall_device_signal_wait(
    signal::HSA.Signal, value::Int64, order::Int32 = ATOMIC_ACQUIRE,
)
    hostcall_device_signal_wait(signal.handle, value, order)
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
