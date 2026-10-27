function create_output_context!(#= TODO mod::HIP.HIPModule =#)
    dev = AMDGPU.device()
    _, hc_buf = Device.named_perdevice_hostcall(dev, :print_hostcall) do
        buf_len = 2^16
        # the device writes the string to the hostcall's buffer, created along with the holder
        buf_ptr = Ref{LLVMPtr{UInt8, AS.Global}}()
        holder = Device.HostCallHolder(
            Nothing, Tuple{LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global}};
            continuous=true, buf_len,
        ) do _
            str_ptr = reinterpret(
                LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global}, buf_ptr[])
            Core.print(unsafe_load(str_ptr))
            return
        end
        buf_ptr[] = holder.hc.buf_ptr

        # Pointer to HostCall to be read from device.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.OUTPUT_CONTEXT_TYPE}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(hc_buf)
end

function create_printf_output_context!()
    dev = AMDGPU.device()
    _, hc_buf = Device.named_perdevice_hostcall(dev, :printf_hostcall) do
        # the device writes its arguments to the hostcall's buffer, created along with the holder
        buf_ptr = Ref{LLVMPtr{UInt8, AS.Global}}()
        holder = Device.HostCallHolder(
            Nothing, Tuple{LLVMPtr{UInt8, AS.Global}};
            continuous=true, buf_len=2^16,
        ) do _
            printf_buf_ptr = reinterpret(
                LLVMPtr{Device.ROCPrintfBuffer, AS.Global}, buf_ptr[])
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
        buf_ptr[] = holder.hc.buf_ptr
        # Pointer to HostCall to be read from device.
        buf = Mem.HostBuffer(sizeof(holder.hc), HIP.hipHostAllocDefault)
        ptr = convert(Ptr{Device.PRINTF_OUTPUT_CONTEXT_TYPE}, buf)
        Base.unsafe_store!(ptr, holder.hc)
        return holder, buf
    end
    return Mem.device_ptr(hc_buf)
end
