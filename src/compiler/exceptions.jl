struct KernelException <: Exception end

# TODO report what device.
function Base.showerror(io::IO, ex::KernelException)
    print(io, "KernelException: exception thrown during kernel execution on device.")
end

const _exception_flags = Dict{HIP.HIPDevice, Mem.HostBuffer}()

function create_exception!(mod::HIP.HIPModule)
    dev = HIP.device() # TODO store device in mod.
    exception_flag = get!(_exception_flags, dev,
        Mem.HostBuffer(sizeof(Int), HIP.hipHostAllocMapped))
    return Mem.device_ptr(exception_flag)
end

# Check for exceptions on every synchronization.
function check_exceptions()
    for (dev, buf) in _exception_flags
        ptr = convert(Ptr{Int}, buf)
        flag = unsafe_load(ptr)
        if flag != 0
            unsafe_store!(ptr, 0)
            throw(KernelException()) # TODO pass device
        end
    end
end
