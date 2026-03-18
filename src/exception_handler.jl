# hash(HIPDevice) => HostBuffer
const GLOBAL_EXCEPTION_INFO = Dict{UInt, Mem.HostBuffer}()

# TODO RT_LOCK?
function exception_info(dev::HIPDevice)::Ptr{UInt64}
    ei = get!(
        () -> Device.alloc_exception_info(),
        GLOBAL_EXCEPTION_INFO, hash(dev))
    return convert(Ptr{UInt64}, Mem.device_ptr(ei))
end

function has_exception(dev::HIPDevice)::Bool
    return unsafe_load(exception_info(dev)) != UInt64(0)
end

function reset_exception_info!(dev::HIPDevice)
    unsafe_store!(exception_info(dev), UInt64(0))
    return
end

function get_exception_info_string(dev::HIPDevice)
    packed = unsafe_load(exception_info(dev))
    info = Device.unpack_exception(packed)
    reason = get(Device.EXCEPTION_REASON_STRINGS, info.code, "Unknown exception (code=$(info.code))")

    return """GPU Kernel Exception:
    $reason
    workgroupIdx: ($(info.wg_x), $(info.wg_y), $(info.wg_z))"""
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
