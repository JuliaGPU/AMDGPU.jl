function create_output_context!(#= TODO mod::HIP.HIPModule =#)
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :print_hostcall) do
        buf_len = 2^16
        holder = Device.HostCallHolder(
            Nothing, Tuple{LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global}};
            continuous=true, buf_len,
        ) do _
            str_ptr = reinterpret(
                LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global},
                holder.hc.buf_ptr)
            Core.print(unsafe_load(str_ptr))
            return
        end

        # Pointer to HostCall to be read from device.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.OUTPUT_CONTEXT_TYPE}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end

function create_printf_output_context!()
    dev = AMDGPU.device()
    _, buf = Device.named_perdevice_hostcall(dev, :printf_hostcall) do
        holder = Device.HostCallHolder(
            Nothing, Tuple{LLVMPtr{UInt8, AS.Global}};
            continuous=true, buf_len=2^16,
        ) do _
            printf_buf_ptr = reinterpret(
                LLVMPtr{Device.ROCPrintfBuffer, AS.Global},
                holder.hc.buf_ptr)
            fmt, all_args = unsafe_load(printf_buf_ptr)
            format = Printf.Format(fmt)

            for args in all_args
                try
                    args = map(x -> x isa Cstring ? unsafe_string(x) : x, args)
                    formatted = Printf.format(format, args...)
                    Core.print(formatted)
                catch err
                    @error "@rocprintf error" exception=(err, catch_backtrace())
                end
            end
            return
        end
        # Pointer to HostCall to be read from device.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.PRINTF_OUTPUT_CONTEXT_TYPE}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(buf)
end
