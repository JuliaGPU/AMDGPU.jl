function create_malloc_hostcall!()
    hsa_dev = AMDGPU.device()
    hc = Device.named_perdevice_hostcall(hsa_dev, :malloc_hostcall) do
        malloc_hc = Device.HostCall(
            Ptr{Cvoid}, Tuple{Csize_t}; continuous=true,
        ) do bytesize
            buf = Mem.HostBuffer(bytesize, HIP.hipHostAllocMapped)
            # TODO push to HIPModule metadata for off-device free?
            return Mem.device_ptr(buf)
        end
        malloc_hc_buf = Mem.HostBuffer(sizeof(malloc_hc), HIP.hipHostAllocMapped)
        malloc_hc_ptr = Base.unsafe_convert(
            Ptr{Device.HostCall{Ptr{Cvoid}, Tuple{Csize_t}}}, malloc_hc_buf)
        Base.unsafe_store!(malloc_hc_ptr, malloc_hc)
        return malloc_hc, malloc_hc_buf
    end
    return Mem.device_ptr(hc[2])
end

function create_free_hostcall!()
    hsa_dev = AMDGPU.device()
    hc = Device.named_perdevice_hostcall(hsa_dev, :free_hostcall) do
        free_hc = Device.HostCall(
            Nothing, Tuple{Ptr{Cvoid}}; continuous=true,
        ) do ptr
            HIP.hipHostFree(ptr) |> HIP.check
            return nothing
        end
        free_hc_buf = Mem.HostBuffer(sizeof(free_hc), HIP.hipHostAllocMapped)
        free_hc_ptr = Base.unsafe_convert(
            Ptr{Device.HostCall{Nothing, Tuple{Ptr{Cvoid}}}}, free_hc_buf)
        Base.unsafe_store!(free_hc_ptr, free_hc)
        return free_hc, free_hc_buf
    end
    return Mem.device_ptr(hc[2])
end
