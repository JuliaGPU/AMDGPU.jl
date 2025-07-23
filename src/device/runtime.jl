using Core: LLVMPtr

## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

@inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

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
    ei = kernel_state().exception_info
    ei.status = Int32(0x1)
    # Lock in case it was not locked before, to get workitem and workgroup info.
    lock_output!(ei)
    endpgm() # Without endpgm we'll get hardware exception.
    return
end

function report_oom(sz::Csize_t)
    return
end

function report_exception(ex::Ptr{Cchar})
    return
end

function report_exception_name(ex::Ptr{Cchar})
    return
end

function report_exception_frame(idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint)
    return
end
