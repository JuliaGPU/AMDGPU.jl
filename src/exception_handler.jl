"""
ExceptionHolder

- `exception_flag::Mem.HostBuffer`:
    Pinned host memory. Contains one element of `Int32` type.
    If stored value is not 0, then there is an exception that occurred
    during kernel execution on the respective device.
- `gate::ROCArray{UInt64}`:
    Linear index for x, y & z dimensions at which the exception occurred.
    This is used to filter out other threads from duplication exceptions.
- `buffers_counter::ROCArray{Int32}`:
    Counts number of printf buffers `errprintf_buffers` currently used.
- `str_buffers_counter::ROCArray{Int32}`:
    Error string counter. Counts number of string buffers `string_buffers`
    used for exception reporting.
- `errprintf_buffers::Vector{Mem.HostBuffer}`:
    Array of buffers used for writing exceptions.
    These buffers are used in the same way as device-printf buffers,
    except they are pre-allocated.
- `string_buffers::Vector{Mem.HostBuffer}`:
    Array of string buffers. These buffers are used every time
    we need to report the name of the exception, file, or line.
"""
struct ExceptionHolder
    exception_flag::Mem.HostBuffer # Main buffer where printf context is written.
    gate::ROCArray{UInt64}
    buffers_counter::ROCArray{Int32}
    str_buffers_counter::ROCArray{Int32}

    errprintf_buffers::Vector{Mem.HostBuffer} # Buffers used by `@errprintf`.
    string_buffers::Vector{Mem.HostBuffer} # Buffers used for storing device strings on the host.

    errprintf_buffers_dev::ROCArray{Ptr{Cvoid}} # Pointers of `errprintf_buffers` on the device.
    string_buffers_dev::ROCArray{Ptr{Cvoid}} # Pointers of `string_buffers` on the device.

    function ExceptionHolder()
        buf_len = 2^11 # 2 KiB
        str_len = 2^11 # 2 KiB
        n_buffers = 50
        n_str_buffers = 100

        exception_flag = Mem.HostBuffer(sizeof(Int32), HIP.hipHostAllocMapped)
        gate = ROCArray(UInt64[0])
        buffers_counter = ROCArray(Int32[0])
        str_buffers_counter = ROCArray(Int32[0])

        errprintf_buffers = [
            Mem.HostBuffer(buf_len, HIP.hipHostAllocMapped)
            for _ in 1:n_buffers]
        str_buffers = [
            Mem.HostBuffer(str_len, HIP.hipHostAllocMapped)
            for _ in 1:n_str_buffers]

        errprintf_buffers_dev = ROCArray(Mem.device_ptr.(errprintf_buffers))
        str_buffers_dev = ROCArray(Mem.device_ptr.(str_buffers))

        new(
            exception_flag, gate, buffers_counter, str_buffers_counter,
            errprintf_buffers, str_buffers,
            errprintf_buffers_dev, str_buffers_dev)
    end
end

# hash(dev::HIPDevice) => ExceptionHolder
const GLOBAL_EXCEPTION_HOLDER = Dict{UInt, ExceptionHolder}()

function exception_holder(dev::HIPDevice)
    # TODO lock using RT_LOCK
    get!(() -> ExceptionHolder(), GLOBAL_EXCEPTION_HOLDER, hash(dev))
end

function has_exception(dev::HIPDevice)::Bool
    ex = exception_holder(dev)
    ptr = Base.unsafe_convert(Ptr{Int}, ex.exception_flag)
    unsafe_load(ptr) != 0
end

function reset_exception_holder!(dev::HIPDevice)
    ex = exception_holder(dev)
    ptr = Base.unsafe_convert(Ptr{Int}, ex.exception_flag)
    unsafe_store!(ptr, 0)

    fill!(ex.buffers_counter, 0)
    fill!(ex.str_buffers_counter, 0)
    return
end

function get_exception_string(dev::HIPDevice)::String
    ex = exception_holder(dev)
    n_strings = min(Array(ex.buffers_counter)[1], length(ex.errprintf_buffers))

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

    exception_str = get_exception_string(dev)
    exception_str = isempty(exception_str) ? "" : "\n$exception_str"
    error("GPU Kernel Exception$exception_str")
end

function KernelState(dev::HIPDevice, global_hostcalls::Set{Symbol})
    @show global_hostcalls
    malloc_ptr = if :malloc_hostcall in global_hostcalls
        @warn "Starting global malloc hostcall."
        Compiler.create_malloc_hostcall!()
    else
        C_NULL
    end

    ex = exception_holder(dev)
    KernelState(
        # Exception reporting buffers.
        Mem.device_ptr(ex.exception_flag),
        pointer(ex.gate),
        pointer(ex.buffers_counter),
        pointer(ex.str_buffers_counter),

        pointer(ex.errprintf_buffers_dev),
        pointer(ex.string_buffers_dev),
        Int32(length(ex.errprintf_buffers_dev)),
        Int32(length(ex.string_buffers_dev)),

        # Malloc hostcall pointer.
        malloc_ptr,
    )
end
