# hash(HIPDevice) => HostBuffer
const GLOBAL_EXCEPTION_INFO = Dict{UInt, Mem.HostBuffer}()

# TODO RT_LOCK?
function exception_info(dev::HIPDevice)::Ptr{Device.ExceptionInfo}
    ei = get!(
        () -> Device.alloc_exception_info(),
        GLOBAL_EXCEPTION_INFO, hash(dev))
    return convert(Ptr{Device.ExceptionInfo}, Mem.device_ptr(ei))
end

function has_exception(dev::HIPDevice)::Bool
    return exception_info(dev).status != 0
end

function reset_exception_info!(dev::HIPDevice)
    unsafe_store!(exception_info(dev), Device.ExceptionInfo())
    return
end

function device_str_to_host(str_ptr, str_length)
    str_length == 0 && return ""

    buf = Vector{UInt8}(undef, str_length)
    HSA.memory_copy(
        convert(Ptr{Cvoid}, pointer(buf)),
        reinterpret(Ptr{Cvoid}, str_ptr), str_length) |> Runtime.check
    return String(buf)
end

function get_exception_info_string(dev::HIPDevice)
    ei = exception_info(dev)
    subtype = device_str_to_host(ei.subtype, ei.subtype_length)
    reason = device_str_to_host(ei.reason, ei.reason_length)

    workitemIdx = ei.thread
    workgroupIdx = ei.block

    isempty(subtype) && (subtype = "Unknown error";)
    isempty(reason) && (reason = "Unknown reason";)
    return """GPU Kernel Exception:
    $subtype: $reason
    workitemIdx: $workitemIdx
    workgroupIdx: $workgroupIdx"""
end

function throw_if_exception(dev::HIPDevice)
    has_exception(dev) || return
    ex_str = get_exception_info_string(dev)
    reset_exception_info!(dev)
    error(ex_str) # TODO KernelException
end

function KernelState(dev::HIPDevice, global_hostcalls::Vector{Symbol})
    malloc_ptr = :malloc_hostcall in global_hostcalls ?
        Compiler.create_malloc_hostcall!() : C_NULL
    free_ptr = :free_hostcall in global_hostcalls ?
        Compiler.create_free_hostcall!() : C_NULL
    print_ptr = :print_hostcall in global_hostcalls ?
        Compiler.create_output_context!() : C_NULL
    printf_ptr = :printf_hostcall in global_hostcalls ?
        Compiler.create_printf_output_context!() : C_NULL

    return KernelState(exception_info(dev), malloc_ptr, free_ptr, print_ptr, printf_ptr)
end
