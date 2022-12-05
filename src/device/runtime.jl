# ROCm-specific runtime libraries


## GPU runtime library

# reset the runtime cache from global scope, so that any change triggers recompilation
GPUCompiler.reset_runtime()

@inline @generated kernel_state() = GPUCompiler.kernel_state_value(AMDGPU.KernelState)

exception_flag() = kernel_state().exception_flag_ptr
exception_dropped() = kernel_state().exception_dropped_ptr

signal_exception() = device_signal_exception()
function device_signal_exception()
    flag_ptr = exception_flag()
    unsafe_store!(flag_ptr, 1)

    # stop this wavefront
    # TODO: want divergent thread exit
    endpgm()
    trap()
end

function device_string_to_host(ex)
    # We get a ReadOnlyMemoryError on the host without making a copy because the data is pinned to the device
    ex_ptr = reinterpret(LLVMPtr{UInt8,1}, ex)
    ex_len = string_length(ex_ptr)
    # TODO: Don't use an expensive host malloc
    ex_str = reinterpret(LLVMPtr{UInt8,1}, device_malloc(Csize_t(ex_len+1)))
    if reinterpret(UInt64, ex_str) == 0
        @rocprintf("Device-to-host string conversion failed\n")
        return reinterpret(Cstring, 0)
    end
    memcpy!(ex_str, ex_ptr, ex_len)
    unsafe_store!(ex_str+ex_len, UInt8(0))
    reinterpret(Cstring, ex_str)
end

report_exception(ex) = device_report_exception(ex)

report_oom(sz) = device_report_oom(sz)
device_report_oom(sz::Csize_t) =
    @rocprintf("ERROR: Out of dynamic GPU memory (trying to allocate %i bytes)\n", sz)

# Forward to report_exception
report_exception_name(ex) = device_report_exception(ex)

@inline report_exception_frame(idx, func, file, line) =
    device_report_exception_frame(idx, func, file, line)
