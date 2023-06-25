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
    idx = atomic_add!(counter_ptr, Int32(1)) + Int32(1)
    idx > st.n_buffers && return reinterpret(LLVMPtr{UInt64, AS.Global}, 0)

    buf = unsafe_load(st.buffers, idx)
    reinterpret(LLVMPtr{UInt64, AS.Global}, buf)
end

function err_str_buffer!()
    st = kernel_state()
    counter_ptr = reinterpret(LLVMPtr{Int32, AS.Global}, st.str_buffers_counter)
    idx = atomic_add!(counter_ptr, Int32(1)) + Int32(1)
    idx > st.n_str_buffers && return reinterpret(LLVMPtr{UInt8, AS.Global}, 0)

    buf = unsafe_load(kernel_state().string_buffers, idx)
    reinterpret(LLVMPtr{UInt8, AS.Global}, buf)
end

function gate!(value::UInt64)::Bool
    gate_ptr = reinterpret(LLVMPtr{UInt64, AS.Global}, kernel_state().gate)
    old_value = atomic_cas!(gate_ptr, UInt64(0), value)
    ifelse(iszero(old_value), true, value == old_value)
end

# function output_context()
#     convert(Ptr{OUTPUT_CONTEXT_TYPE}, kernel_state().output_context)
# end

# function printf_output_context()
#     convert(Ptr{PRINTF_OUTPUT_CONTEXT_TYPE}, kernel_state().printf_output_context)
# end

# function malloc_hc()
#     convert(Ptr{HostCall{Ptr{Cvoid}, Tuple{Csize_t}}}, kernel_state().malloc_hc)
# end

# function free_hc()
#     convert(Ptr{HostCall{Nothing, Tuple{Ptr{Cvoid}}}}, kernel_state().free_hc)
# end

function signal_exception()
    unsafe_store!(exception_flag(), Int32(1))
    # Without endpgm we'll get hardware exception.
    endpgm()
    return
end

# function device_string_to_host(ex::Ptr{Cchar})
#     # We get a ReadOnlyMemoryError on the host without
#     # making a copy because the data is pinned to the device.
#     ex_ptr = reinterpret(LLVMPtr{UInt8, AS.Global}, ex)
#     ex_len = string_length(ex_ptr)
#     # TODO: Don't use an expensive host malloc
#     # Allocate strlen + null termination.
#     ex_str = reinterpret(LLVMPtr{UInt8, AS.Global}, malloc(Csize_t(ex_len + 1)))
#     # If allocation failed (returned nullptr) - print message.
#     if reinterpret(UInt64, ex_str) == 0
#         @rocprint("Device-to-host string conversion failed.\n")
#         return reinterpret(Cstring, 0)
#     end
#     # Copy `ex` to allocated memory.
#     memcpy!(ex_str, ex_ptr, ex_len)
#     # And null termination.
#     unsafe_store!(ex_str + ex_len, UInt8(0))
#     return reinterpret(Cstring, ex_str)
# end

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
    # @errprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)
    return
end

function report_exception(ex::Ptr{Cchar})
    # ex_str = err_device_string_to_host(ex)
    # @errprintf("""
    #     ERROR: a %s was thrown during kernel execution.
    #            Run Julia on debug level 2 for device stack traces.
    #     """, ex_str)
    return
end

function report_exception_name(ex::Ptr{Cchar})
    # ex_str = err_device_string_to_host(ex)
    # @errprintf("""
    #     ERROR: a %s was thrown during kernel execution.
    #     Stacktrace:
    #     """, ex_str)
    return
end

function report_exception_frame(
    idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint,
)
    # func_str = err_device_string_to_host(func)
    # file_str = err_device_string_to_host(file)
    # @errprintf("""
    #  [%i] %s
    #    @ %s:%i
    # """, idx, func_str, file_str, line)
    return
end
