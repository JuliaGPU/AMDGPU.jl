function create_malloc_hostcall!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :malloc_hostcall) do
        holder = Device.HostCallHolder(
            Ptr{Cvoid}, Tuple{Csize_t}; continuous=true,
        ) do bytesize
            buf = Mem.HostBuffer(bytesize, HIP.hipHostAllocMapped)
            return Mem.device_ptr(buf) # TODO this works if device ptr == host ptr
        end

        # Create host pinned memory and store HostCall in it.
        # It will be then accessed by kernels from kernel state.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocMapped)
        ptr = Base.unsafe_convert(
            Ptr{Device.HostCall{Ptr{Cvoid}, Tuple{Csize_t}}}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end

# function create_free_hostcall!()
#     dev = AMDGPU.device()
#     hc = Device.named_perdevice_hostcall(dev, :free_hostcall) do
#         free_hc = Device.HostCall(
#             Nothing, Tuple{Ptr{Cvoid}}; continuous=true,
#         ) do ptr
#             HIP.hipHostFree(ptr) |> HIP.check
#             return nothing
#         end
#         free_hc_buf = Mem.HostBuffer(sizeof(free_hc), HIP.hipHostAllocMapped)
#         free_hc_ptr = Base.unsafe_convert(
#             Ptr{Device.HostCall{Nothing, Tuple{Ptr{Cvoid}}}}, free_hc_buf)
#         Base.unsafe_store!(free_hc_ptr, free_hc)
#         return free_hc, free_hc_buf
#     end
#     return Mem.device_ptr(hc[2])
# end
