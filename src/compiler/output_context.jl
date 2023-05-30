function create_output_context!(#= TODO mod::HIP.HIPModule =#)
    hsa_dev = AMDGPU.device()
    hc = Device.named_perdevice_hostcall(hsa_dev, :global_output_context) do
        buf_len = 2^16
        # Create HostCall.
        print_hc = Device.HostCall(
            Nothing, Tuple{LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global}};
            continuous=true, buf_len,
        ) do _
            str_ptr = reinterpret(
                LLVMPtr{Device.DeviceStaticString{buf_len}, AS.Global},
                print_hc.buf_ptr)
            str = unsafe_load(str_ptr)
            Core.print(str)
            return nothing
        end
        # Pointer to HostCall to be read from device.
        print_hc_buf = Mem.HostBuffer(sizeof(print_hc), HIP.hipHostAllocMapped)
        print_hc_ptr = Base.unsafe_convert(
            Ptr{Device.OUTPUT_CONTEXT_TYPE}, print_hc_buf)
        Base.unsafe_store!(print_hc_ptr, print_hc)
        return print_hc, print_hc_buf
    end
    return Mem.device_ptr(hc[2])
end

function create_printf_output_context!()
    hsa_dev = AMDGPU.device()
    hc = Device.named_perdevice_hostcall(hsa_dev, :global_printf_context) do
        # Create HostCall.
        printf_hc = Device.HostCall(
            Nothing, Tuple{LLVMPtr{UInt8, AS.Global}};
            continuous=true, buf_len=2^16,
        ) do _
            printf_buf_ptr = reinterpret(
                LLVMPtr{Device.ROCPrintfBuffer, AS.Global},
                printf_hc.buf_ptr)
            fmt, all_args = unsafe_load(printf_buf_ptr)
            format = Printf.Format(fmt)

            for args in all_args
                try
                    args = map(x -> x isa Cstring ? unsafe_string(x) : x, args)
                    formatted = Printf.format(format, args...)
                    Core.println(formatted)
                catch err
                    @error "@rocprintf error" exception=(err, catch_backtrace())
                end
            end
            return nothing
        end
        # Pointer to HostCall to be read from device.
        hc_buf = Mem.HostBuffer(sizeof(printf_hc), HIP.hipHostAllocMapped)
        hc_ptr = Base.unsafe_convert(
            Ptr{Device.PRINTF_OUTPUT_CONTEXT_TYPE}, hc_buf)
        Base.unsafe_store!(hc_ptr, printf_hc)
        return printf_hc, hc_buf
    end
    return Mem.device_ptr(hc[2])
end
