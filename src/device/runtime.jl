# ROCm-specific runtime libraries

## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

@inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

function exception_flag()
    convert(Ptr{Int}, kernel_state().exception_flag)
end

function output_context()
    convert(Ptr{GLOBAL_OUTPUT_CONTEXT_TYPE}, kernel_state().output_context)
end

function printf_output_context()
    convert(Ptr{PRINTF_OUTPUT_CONTEXT_TYPE}, kernel_state().printf_output_context)
end

function signal_exception()
    ptr = exception_flag()
    if ptr !== C_NULL
        unsafe_store!(convert(Ptr{Int}, ptr), 1)
        # Stop this wavefront.
        endpgm()
        trap()
    else
        # TODO print that something has gone wrong and should be reported.
    end
    return
end

# function device_string_to_host(ex)
#     # We get a ReadOnlyMemoryError on the host without
#     # making a copy because the data is pinned to the device.
#     ex_ptr = reinterpret(LLVMPtr{UInt8, 1}, ex)
#     ex_len = string_length(ex_ptr)
#     # TODO: Don't use an expensive host malloc
#     ex_str = reinterpret(LLVMPtr{UInt8, 1}, device_malloc(Csize_t(ex_len + 1)))
#     if reinterpret(UInt64, ex_str) == 0 # nullptr
#         @rocprint("Device-to-host string conversion failed\n")
#         return reinterpret(Cstring, 0)
#     end
#     memcpy!(ex_str, ex_ptr, ex_len)
#     unsafe_store!(ex_str + ex_len, UInt8(0))
#     reinterpret(Cstring, ex_str)
# end

"""
TODO
- device_malloc
- device free
- get_global_pointer __global_exception_ring
"""
function report_exception(ex)
    return
end
# report_exception(ex) = device_report_exception(ex)
# function device_report_exception(ex::Ptr{Cchar})
#     # Add kernel ID and exception string to exception ring buffer
#     ring_ptr = get_global_pointer(Val(:__global_exception_ring), LLVMPtr{ExceptionEntry,AS.Global})
#     ring_ptr = unsafe_load(ring_ptr)
#     our_signal = _completion_signal()

#     prev = UInt64(1)
#     while prev != UInt64(0)
#         # Try to write to this slot, and skip if we fail (because another wavefront wrote first)
#         prev = atomic_cas!(
#             reinterpret(LLVMPtr{UInt64,AS.Global}, ring_ptr),
#             UInt64(0), our_signal)
#         if prev == UInt64(0)
#             ex_str = device_string_to_host(ex)
#             Base.unsafe_store!(
#                 reinterpret(LLVMPtr{UInt64,AS.Global}, ring_ptr + sizeof(UInt64)),
#                 reinterpret(UInt64, ex_str))
#             break
#         elseif prev == UInt64(1)
#             # Tail slot, give up
#             break
#         end
#         ring_ptr += sizeof(ExceptionEntry)
#     end
#     return
# end

# report_oom(sz) = device_report_oom(sz)
# device_report_oom(sz::Csize_t) =
#     @rocprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)

# report_exception_name(ex) = device_report_exception_name(ex)
# function device_report_exception_name(ex::Ptr{Cchar})
#     device_report_exception(ex)
#     # Pass argument in host buffer
#     ex_str = device_string_to_host(ex)
#     @rocprintf("""
#         ERROR: a %s was thrown during kernel execution.
#         Stacktrace:
#         """, ex_str)
#     device_free(reinterpret(Ptr{Cvoid}, ex_str))
#     return
# end

# report_exception_frame(idx, func, file, line) =
#     device_report_exception_frame(idx, func, file, line)
# function device_report_exception_frame(idx::Cint, func::Ptr{Cchar}, file::Ptr{Cchar}, line::Cint)
#     # Pass arguments in host buffers
#     func_str = device_string_to_host(func)
#     file_str = device_string_to_host(file)
#     @rocprintf(" [%i] %s at %s:%i\n", idx, func_str, file_str, line)
#     device_free(reinterpret(Ptr{Cvoid}, func_str))
#     device_free(reinterpret(Ptr{Cvoid}, file_str))
#     return
# end
