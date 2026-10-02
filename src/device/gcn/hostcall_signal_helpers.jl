const ATOMIC_MONOTONIC = Int32(1)
const ATOMIC_ACQUIRE = Int32(2)
const ATOMIC_RELEASE = Int32(3)
const ATOMIC_ACQ_REL = Int32(4)
const ATOMIC_SEQ_CST = Int32(5)

# Hostcall signal helpers.

@device_function @inline function device_signal_load(
    signal_handle::UInt64, order::Int32 = ATOMIC_ACQUIRE,
)
    ccall("extern __ockl_hsa_signal_load", llvmcall,
        Int64, (UInt64, Int32), signal_handle, order)
end

@device_function @inline function device_signal_store!(
    signal_handle::UInt64, value::Int64, order::Int32 = ATOMIC_RELEASE,
)
    ccall("extern __ockl_hsa_signal_store", llvmcall,
        Int64, (UInt64, Int64, Int32), signal_handle, value, order)
end

@device_function @inline function device_signal_cas!(
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

# Host-side signal synchronization helpers.
# In ROCm, the active memory layout of `amd_signal_t` is defined in `amd_hsa_signal.h`
# (see `https://github.com/ROCm/rocm-systems/blob/release/therock-10.0/projects/rocr-runtime/runtime/hsa-runtime/inc/amd_hsa_signal.h`):
#   - Total size: 64 bytes, 64-byte aligned (`AMD_SIGNAL_ALIGN_BYTES 64`)
#   - Offset 0..7  (int64_t): `kind` = AMD_SIGNAL_KIND_USER (1)
#   - Offset 8..15 (int64_t): `value` = atomic signal payload / counter
# On Windows, where `libhsa-runtime64` is unavailable, we allocate 64-byte pinned coherent
# memory via `HIP.hipHostMalloc` and synchronize using Julia Base intrinsics on `signal.handle + 8`.
#
# Device-side synchronization is performed by `hsa_signal_*`
# (see `https://github.com/ROCm/rocm-systems/blob/release/therock-10.0/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/hsa.cpp`).
#
# Note for Linux unification:
# These operations run entirely on the host CPU. If verified on Linux, these Julia intrinsics could
# replace `HSA.signal_*` calls on Linux as well, eliminating `libhsa-runtime64` for hostcalls.

function create_hostcall_signal(init_val::Int64 = 1)
    @static if Sys.iswindows()
        ptr_ref = Ref{Ptr{Cvoid}}()
        HIP.hipHostMalloc(ptr_ref, 64, HIP.hipHostMallocCoherent)
        # Zero out all 64 bytes
        unsafe_wrap(Array, reinterpret(Ptr{UInt8}, ptr_ref[]), 64) .= 0
        p64 = reinterpret(Ptr{Int64}, ptr_ref[])
        # Offset 0..7: kind = AMD_SIGNAL_KIND_USER (1) (element 1 in Int64 indexing)
        unsafe_store!(p64, Int64(1), 1)
        # Offset 8..15: value = init_val (element 2 in Int64 indexing)
        unsafe_store!(p64, init_val, 2)
        return HSA.Signal(reinterpret(UInt64, ptr_ref[]))
    else
        signal_ref = Ref{HSA.Signal}()
        HSA.signal_create(init_val, 0, C_NULL, signal_ref) |> Runtime.check
        return signal_ref[]
    end
end

function destroy_hostcall_signal!(signal::HSA.Signal)
    @static if Sys.iswindows()
        ptr = reinterpret(Ptr{Cvoid}, signal.handle)
        HIP.hipHostFree(ptr)
    else
        HSA.signal_destroy(signal) |> Runtime.check
    end
end

@inline function host_signal_store!(
    signal::HSA.Signal, value, order::Val{O} = Val{:release}(),
) where O
    if O ∉ (:release, :relaxed)
        throw(ArgumentError("Unsupported `order`: `$order`. Supported values are: `Val{:release}` and `Val{:relaxed}`."))
    end
    @static if Sys.iswindows()
        # In amd_signal_t, .value is at offset 8 (after 8-byte kind; see amd_hsa_signal.h)
        ptr = reinterpret(Ptr{Int64}, signal.handle + 8)
        if O == :release
            Core.Intrinsics.atomic_pointerset(ptr, Int64(value), :release)
        elseif O == :relaxed
            Core.Intrinsics.atomic_pointerset(ptr, Int64(value), :monotonic)
        end
    else
        if O == :release
            HSA.signal_store_screlease(signal, value)
        elseif O == :relaxed
            HSA.signal_store_relaxed(signal, value)
        end
    end
end

@inline function host_signal_load(
    signal::HSA.Signal, order::Val{O} = Val{:acquire}(),
) where O
    if O ∉ (:acquire, :relaxed)
        throw(ArgumentError("Unsupported `order`: `$order`. Supported values are: `Val{:acquire}` and `Val{:relaxed}`."))
    end
    @static if Sys.iswindows()
        # In amd_signal_t, .value is at offset 8 (after 8-byte kind; see amd_hsa_signal.h)
        ptr = reinterpret(Ptr{Int64}, signal.handle + 8)
        if O == :acquire
            return Core.Intrinsics.atomic_pointerref(ptr, :acquire)
        elseif O == :relaxed
            return Core.Intrinsics.atomic_pointerref(ptr, :monotonic)
        end
    else
        if O == :acquire
            return HSA.signal_load_scacquire(signal)
        elseif O == :relaxed
            return HSA.signal_load_relaxed(signal)
        end
    end
end

@inline function host_signal_cmpxchg!(signal::HSA.Signal, expected, value)
    @static if Sys.iswindows()
        # In amd_signal_t, .value is at offset 8 (after 8-byte kind; see amd_hsa_signal.h)
        ptr = reinterpret(Ptr{Int64}, signal.handle + 8)
        return first(Core.Intrinsics.atomic_pointerreplace(
            ptr, Int64(expected), Int64(value), :acquire_release, :acquire))
    else
        HSA.signal_cas_scacq_screl(signal, expected, value)
    end
end

@device_function @inline function device_sleep(duration::Int32)
    ccall("llvm.amdgcn.s.sleep", llvmcall, Cvoid, (Int32,), duration)
end

@device_function @inline function device_sethalt(code::Int32 = Int32(1))
    ccall("llvm.amdgcn.s.sethalt", llvmcall, Cvoid, (Int32,), code)
end

@device_function @inline function memtime()
    ccall("llvm.amdgcn.s.memtime", llvmcall, UInt64, ())
end

@device_function @inline function memrealtime()
    ccall("llvm.amdgcn.s.memrealtime", llvmcall, UInt64, ())
end

@device_function @inline function readcyclecounter()
    ccall("llvm.readcyclecounter", llvmcall, UInt64, ())
end
