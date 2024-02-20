function create_malloc_hostcall!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :malloc_hostcall) do
        holder = Device.HostCallHolder(
            Ptr{Cvoid}, Tuple{Csize_t}; continuous=true,
        ) do bytesize
            buf = Mem.HostBuffer(bytesize, HIP.hipHostAllocDefault)
            dev_ptr = Mem.device_ptr(buf)
            @assert buf.ptr == dev_ptr # TODO
            return dev_ptr
        end

        # Create host pinned memory and store HostCall in it.
        # It will be then accessed by kernels from kernel state.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = Base.unsafe_convert(
            Ptr{Device.HostCall{Ptr{Cvoid}, Tuple{Csize_t}}}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end

function create_free_hostcall!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :free_hostcall) do
        holder = Device.HostCallHolder(
            Nothing, Tuple{Ptr{Cvoid}}; continuous=true,
        ) do ptr
            ptr == C_NULL && return
            # FIXME for some reason it hangs on free function in hostcall...
            # HIP.hipHostFree(ptr) |> HIP.check
            return
        end

        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = Base.unsafe_convert(
            Ptr{Device.HostCall{Nothing, Tuple{Ptr{Cvoid}}}}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end
