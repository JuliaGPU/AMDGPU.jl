using Core: LLVMPtr

## GPU runtime library

@device_function @inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

@llvmgenerated builder function llvm_atomic_cas(ptr::LLVMPtr{T,A}, cmp::T, val::T)::T where {T, A}
    T_typed_ptr = LLVM.PointerType(convert(LLVMType, T), A)
    typed_ptr = bitcast!(builder, ptr, T_typed_ptr)
    res = atomic_cmpxchg!(builder, typed_ptr, cmp, val,
                          LLVM.AtomicOrdering.AcquireRelease, LLVM.AtomicOrdering.Acquire)
    extract_value!(builder, res, 0)
end

@device_function function output_context()
    ptr = convert(Ptr{OUTPUT_CONTEXT_TYPE}, kernel_state().output_context)
    x = alloc_local(:__print_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

@device_function function printf_output_context()
    ptr = convert(
        Ptr{PRINTF_OUTPUT_CONTEXT_TYPE},
        kernel_state().printf_output_context)

    x = alloc_local(:__printf_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

@device_function function malloc_hc()
    ptr = convert(
        Ptr{HostCall{Ptr{Cvoid}, Tuple{Csize_t}}},
        kernel_state().malloc_hc)

    # FIXME
    # Hack to detect when global malloc hostcall is used.
    # Create global variable and write pointer to it to prevent it
    # from being optimized away.
    x = alloc_local(:__malloc_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

@device_function function free_hc()
    ptr = convert(
        Ptr{HostCall{Nothing, Tuple{Ptr{Cvoid}}}},
        kernel_state().free_hc)

    x = alloc_local(:__free_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

# reports an exception thrown at `site`, see `GPUCompiler.uses_exception_sites`
@device_function function exception_site(site::Int32)
    signal_exception!(site)
    return
end

# for failures outside of throw sites, e.g. of hostcalls
@device_function function signal_exception()
    signal_exception!(0 % Int32)
    return
end

function report_oom(sz::Csize_t)
    return
end
