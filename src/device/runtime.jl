using Core: LLVMPtr
# ROCm-specific runtime libraries

## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

@inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

exception_flag() = kernel_state().exception_flag

function err_buffer!()
    st = kernel_state()
    counter_ptr = reinterpret(LLVMPtr{Int32, AS.Global}, st.buffers_counter)
    idx, _ = UnsafeAtomics.modify!(counter_ptr, +, Int32(1), UnsafeAtomics.acquire_release)
    idx += Int32(1)
    idx > st.n_buffers && return reinterpret(LLVMPtr{UInt64, AS.Global}, 0)

    buf = unsafe_load(st.buffers, idx)
    reinterpret(LLVMPtr{UInt64, AS.Global}, buf)
end

function err_str_buffer!()
    st = kernel_state()
    counter_ptr = reinterpret(LLVMPtr{Int32, AS.Global}, st.str_buffers_counter)
    idx, _ = UnsafeAtomics.modify!(counter_ptr, +, Int32(1), UnsafeAtomics.acquire_release)
    idx += Int32(1)
    idx > st.n_str_buffers && return reinterpret(LLVMPtr{UInt8, AS.Global}, 0)

    buf = unsafe_load(kernel_state().string_buffers, idx)
    reinterpret(LLVMPtr{UInt8, AS.Global}, buf)
end

@generated function llvm_atomic_cas(ptr::LLVMPtr{T,A}, cmp::T, val::T) where {T, A}
    @dispose ctx=Context() begin
        T_val = convert(LLVMType, T)
        T_ptr = convert(LLVMType, ptr)

        T_typed_ptr = LLVM.PointerType(T_val, A)
        llvm_f, _ = create_function(T_val, [T_ptr, T_val, T_val])

        @dispose builder=IRBuilder() begin
            entry = BasicBlock(llvm_f, "entry")
            position!(builder, entry)

            typed_ptr = bitcast!(builder, parameters(llvm_f)[1], T_typed_ptr)
            res = atomic_cmpxchg!(
                builder, typed_ptr, parameters(llvm_f)[2],
                parameters(llvm_f)[3],
                LLVM.API.LLVMAtomicOrderingAcquireRelease,
                LLVM.API.LLVMAtomicOrderingAcquire,
                #=single threaded=# false)

            rv = extract_value!(builder, res, 0)
            ret!(builder, rv)
        end
        call_function(llvm_f, T, Tuple{LLVMPtr{T,A}, T, T}, :ptr, :cmp, :val)
    end
end

function gate!(value::UInt64)::Bool
    gate_ptr = reinterpret(LLVMPtr{UInt64, AS.Global}, kernel_state().gate)
    old_value = llvm_atomic_cas(gate_ptr, UInt64(0), value)
    ifelse(iszero(old_value), true, value == old_value)
end

function output_context()
    ptr = convert(Ptr{OUTPUT_CONTEXT_TYPE}, kernel_state().output_context)

    x = alloc_local(:__print_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

function printf_output_context()
    ptr = convert(
        Ptr{PRINTF_OUTPUT_CONTEXT_TYPE},
        kernel_state().printf_output_context)

    x = alloc_local(:__printf_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

function malloc_hc()
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

function free_hc()
    ptr = convert(
        Ptr{HostCall{Nothing, Tuple{Ptr{Cvoid}}}},
        kernel_state().free_hc)

    x = alloc_local(:__free_hostcall, UInt64, 1)
    unsafe_store!(x, reinterpret(UInt64, ptr))
    return ptr
end

function signal_exception()
    unsafe_store!(exception_flag(), Int32(1))
    # Without endpgm we'll get hardware exception.
    endpgm()
    return
end

function err_device_string_to_host(str::Ptr{Cchar})
    host_str = reinterpret(LLVMPtr{UInt8, AS.Global}, C_NULL)
    @⊡ host_str = err_str_buffer!()
    reinterpret(UInt64, host_str) == 0 && return reinterpret(Cstring, 0)

    str_ptr = reinterpret(LLVMPtr{UInt8, AS.Global}, str)
    str_len = string_length(str_ptr)

    # Copy `ex` to allocated memory & null termination.
    memcpy!(host_str, str_ptr, str_len)
    unsafe_store!(host_str + str_len, UInt8(0))
    return reinterpret(Cstring, host_str)
end

function report_oom(sz::Csize_t)
    @errprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)
    return
end

function report_exception(ex::Ptr{Cchar})
    ex_str = err_device_string_to_host(ex)
    @errprintf("""
        ERROR: a %s was thrown during kernel execution.
               Run Julia on debug level 2 for device stack traces.
        """, ex_str)
    return
end

function report_exception_name(ex::Ptr{Cchar})
    ex_str = err_device_string_to_host(ex)
    @errprintf("""
        ERROR: a %s was thrown during kernel execution.
        Stacktrace:
        """, ex_str)
    return
end

function report_exception_frame(
    idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint,
)
    func_str = err_device_string_to_host(func)
    file_str = err_device_string_to_host(file)
    @errprintf("""
     [%i] %s
       @ %s:%i
    """, idx, func_str, file_str, line)
    return
end
