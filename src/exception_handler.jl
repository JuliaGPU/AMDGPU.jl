# """
# ExceptionHolder

# - `exception_flag::Mem.HostBuffer`:
#     Pinned host memory. Contains one element of `Int32` type.
#     If stored value is not 0, then there is an exception that occurred
#     during kernel execution on the respective device.
# - `gate::ROCArray{UInt64}`:
#     Linear index for x, y & z dimensions at which the exception occurred.
#     This is used to filter out other threads from duplication exceptions.
# - `buffers_counter::ROCArray{Int32}`:
#     Counts number of printf buffers `errprintf_buffers` currently used.
# - `str_buffers_counter::ROCArray{Int32}`:
#     Error string counter. Counts number of string buffers `string_buffers`
#     used for exception reporting.
# - `errprintf_buffers::Vector{Mem.HostBuffer}`:
#     Array of buffers used for writing exceptions.
#     These buffers are used in the same way as device-printf buffers,
#     except they are pre-allocated.
# - `string_buffers::Vector{Mem.HostBuffer}`:
#     Array of string buffers. These buffers are used every time
#     we need to report the name of the exception, file, or line.
# """
# struct ExceptionHolder
#     exception_flag::Mem.HostBuffer # Main buffer where printf context is written.
#     gate::ROCVector{UInt64, Mem.HIPBuffer}
#     buffers_counter::ROCVector{Int32, Mem.HIPBuffer}
#     str_buffers_counter::ROCVector{Int32, Mem.HIPBuffer}

#     errprintf_buffers::Vector{Mem.HostBuffer} # Buffers used by `@errprintf`.
#     string_buffers::Vector{Mem.HostBuffer} # Buffers used for storing device strings on the host.

#     errprintf_buffers_dev::ROCVector{Ptr{Cvoid}, Mem.HIPBuffer} # Pointers of `errprintf_buffers` on the device.
#     string_buffers_dev::ROCVector{Ptr{Cvoid}, Mem.HIPBuffer} # Pointers of `string_buffers` on the device.

#     function ExceptionHolder()
#         buf_len = 2^11 # 2 KiB
#         str_len = 2^11 # 2 KiB
#         n_buffers = 50
#         n_str_buffers = 100

#         exception_flag = Mem.HostBuffer(sizeof(Int32), HIP.hipHostAllocDefault)
#         gate, buffers_counter, str_buffers_counter = GPUArrays.@uncached begin
#             ROCArray(UInt64[0]), ROCArray(Int32[0]), ROCArray(Int32[0])
#         end

#         errprintf_buffers = [
#             Mem.HostBuffer(buf_len, HIP.hipHostAllocDefault)
#             for _ in 1:n_buffers]
#         str_buffers = [
#             Mem.HostBuffer(str_len, HIP.hipHostAllocDefault)
#             for _ in 1:n_str_buffers]

#         errprintf_buffers_dev, str_buffers_dev = GPUArrays.@uncached begin
#             ROCArray(Mem.device_ptr.(errprintf_buffers)), ROCArray(Mem.device_ptr.(str_buffers))
#         end

#         new(
#             exception_flag, gate, buffers_counter, str_buffers_counter,
#             errprintf_buffers, str_buffers,
#             errprintf_buffers_dev, str_buffers_dev)
#     end
# end

# # hash(dev::HIPDevice) => ExceptionHolder
# const GLOBAL_EXCEPTION_HOLDER = Dict{UInt, ExceptionHolder}()

const GLOBAL_EXCEPTION_INFO = Dict{UInt, Mem.HostBuffer}()

# TODO RT_LOCK?
function exception_info(dev::HIPDevice)
    get!(
        () -> Device.alloc_exception_info(),
        GLOBAL_EXCEPTION_INFO, hash(dev))
end

function has_exception(dev::HIPDevice)::Bool
    ei = exception_info(dev)
    return convert(Ptr{Device.ExceptionInfo}, Mem.device_ptr(ei)).status != 0
end

function reset_exception_info!(dev::HIPDevice)
    ei = exception_info(dev)
    unsafe_store!(
        convert(Ptr{Device.ExceptionInfo}, Mem.device_ptr(ei)),
        Device.ExceptionInfo())
    return
end

function device_str_to_host(str_ptr, str_length)
    str_length == 0 && return ""

    buf = Vector{UInt8}(undef, str_length)
    HSA.memory_copy(
        convert(Ptr{Cvoid}, pointer(buf)),
        convert(Ptr{Cvoid}, str_ptr), str_length) |> Runtime.check
    return String(buf)
end

function get_exception_info_string(dev::HIPDevice)
    ei = exception_info(dev)
    ei_ptr = convert(Ptr{Device.ExceptionInfo}, Mem.device_ptr(ei))
    subtype = device_str_to_host(ei_ptr.subtype, ei_ptr.subtype_length)
    reason = device_str_to_host(ei_ptr.reason, ei_ptr.reason_length)

    workitemIdx = ei_ptr.thread
    workgroupIdx = ei_ptr.block

    isempty(subtype) && (subtype = "Unknown error";)
    isempty(reason) && (reason = "Unknown reason";)
    return """GPU Kernel Exception:
    $subtype: $reason
    workitemIdx: $workitemIdx
    workgroupIdx: $workgroupIdx"""
end

function get_exception_string(dev::HIPDevice)::String
    ex = exception_holder(dev)

    # Use async copy and HIP.synchronize() to avoid triggering
    # error exception checking path and stack-overflowing.
    n_used_buffers = eltype(ex.buffers_counter)[0]
    Base.copyto!(n_used_buffers, 1, ex.buffers_counter, 1, 1; async=true)
    HIP.synchronize(AMDGPU.stream())

    n_strings = min(n_used_buffers[1], length(ex.errprintf_buffers))

    exception_str = ""
    for i in 1:n_strings
        ptr = reinterpret(
            LLVMPtr{Device.ROCPrintfBuffer, AS.Global},
            ex.errprintf_buffers[i].ptr)
        fmt, all_args = unsafe_load(ptr)

        if isempty(all_args)
            exception_str = "$(exception_str)$(fmt)\n"
        else
            args = map(x -> x isa Cstring ? unsafe_string(x) : x, first(all_args))
            str = Printf.format(Printf.Format(fmt), args...)
            exception_str = "$(exception_str)$(str)"
        end
    end
    return exception_str
end

function throw_if_exception(dev::HIPDevice)
    has_exception(dev) || return
    ex_str = get_exception_info_string(dev)
    error(ex_str) # TODO KernelException

    # exception_str = get_exception_string(dev)
    # exception_str = isempty(exception_str) ? "" : "\n$exception_str"
    # reset_exception_holder!(dev)
    # error("GPU Kernel Exception$exception_str")
end

function KernelState(dev::HIPDevice, global_hostcalls::Vector{Symbol})
    malloc_ptr = :malloc_hostcall in global_hostcalls ?
        Compiler.create_malloc_hostcall!() :
        C_NULL
    free_ptr = :free_hostcall in global_hostcalls ?
        Compiler.create_free_hostcall!() :
        C_NULL
    print_ptr = :print_hostcall in global_hostcalls ?
        Compiler.create_output_context!() :
        C_NULL
    printf_ptr = :printf_hostcall in global_hostcalls ?
        Compiler.create_printf_output_context!() :
        C_NULL

    ei = exception_info(dev)
    KernelState(
        Mem.device_ptr(ei),
        malloc_ptr,
        free_ptr,
        print_ptr,
        printf_ptr,
    )
end
