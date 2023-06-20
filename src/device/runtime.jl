# ROCm-specific runtime libraries

## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

@inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

function exception_flag()
    convert(Ptr{Int}, kernel_state().exception_flag)
end

function err_buffer()
    reinterpret(LLVMPtr{UInt64, AS.Global}, kernel_state().buffer)
end

function str_buffer!()
    # TODO move to the next after
    raw_ptr = reinterpret(Ptr{Ptr{Cvoid}}, kernel_state().string_buffers)
    buf = unsafe_load(raw_ptr, 1) # TODO use idx
    reinterpret(LLVMPtr{UInt8, AS.Global}, buf)
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
    ptr = exception_flag()
    unsafe_store!(convert(Ptr{Int}, ptr), 1)
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

function device_string_to_host(str::Ptr{Cchar})
    str_ptr = reinterpret(LLVMPtr{UInt8, AS.Global}, str)
    str_len = string_length(str_ptr)

    host_str = str_buffer!()
    if reinterpret(UInt64, host_str) == 0
        return reinterpret(Cstring, 0)
    end

    # Copy `ex` to allocated memory & null termination.
    memcpy!(host_str, str_ptr, str_len)
    unsafe_store!(host_str + str_len, UInt8(0))
    return reinterpret(Cstring, host_str)
end

function report_oom(sz::Csize_t)
    # @rocprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)
    return
end

function report_exception(ex::Ptr{Cchar})
    # TODO report only if the buffer does not contain an exception already
    ex_str = device_string_to_host(ex)
    @errprintf("""
        ERROR: a %s was thrown during kernel execution.
               Run Julia on debug level 2 for device stack traces.
    """, ex_str)
    # ex_str = device_string_to_host(ex)
    # @rocprintf("""
    #     ERROR: a %s was thrown during kernel execution.
    #            Run Julia on debug level 2 for device stack traces.
    #     """, ex_str)
    # free(reinterpret(Ptr{Cvoid}, ex_str))
    return
end

function report_exception_name(ex)
    # ex_str = device_string_to_host(ex)
    # @rocprintf("""
    #     ERROR: a %s was thrown during kernel execution.
    #     Stacktrace:
    #     """, ex_str)
    # free(reinterpret(Ptr{Cvoid}, ex_str))
    return
end

function report_exception_frame(
    idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint,
)
    # func_str = device_string_to_host(func)
    # file_str = device_string_to_host(file)
    # @rocprintf(" [%i] %s at %s:%i\n", idx, func_str, file_str, line)
    # free(reinterpret(Ptr{Cvoid}, func_str))
    # free(reinterpret(Ptr{Cvoid}, file_str))
    return
end
