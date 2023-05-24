# TODO modify named perdevice call to accept HostBuffer?
# TODO add RT LOCK
const _output_context = Dict{
    HIP.HIPDevice, Tuple{Device.GLOBAL_OUTPUT_CONTEXT_TYPE, Mem.HostBuffer}}()

function create_output_context!(#= mod::HIP.HIPModule =#)
    hsa_dev = AMDGPU.device()
    hip_dev = HIP.device()

    oc = get(_output_context, hip_dev, nothing)
    isnothing(oc) || return Mem.device_ptr(oc[2])

    output_context = Device.OutputContext(; device=hsa_dev)
    # Pointer to `output_context` struct to be read from device.
    oc_buf = Mem.HostBuffer(sizeof(output_context), HIP.hipHostAllocMapped)
    _output_context[hip_dev] = (output_context, oc_buf)

    oc_ptr = Base.unsafe_convert(
        Ptr{Device.GLOBAL_OUTPUT_CONTEXT_TYPE}, oc_buf)
    Base.unsafe_store!(oc_ptr, output_context)
    return Mem.device_ptr(oc_buf)
end

const _printf_output_context = Dict{
    HIP.HIPDevice, Tuple{Device.PRINTF_OUTPUT_CONTEXT_TYPE, Mem.HostBuffer}}()

function create_printf_output_context!()
    hsa_dev = AMDGPU.device()
    hip_dev = HIP.device()

    hc = get(_printf_output_context, hip_dev, nothing)
    isnothing(hc) || return Mem.device_ptr(hc[2])

    ret_type = Nothing
    args_type = Tuple{LLVMPtr{UInt8, AS.Global}}
    printf_output_context = Device.HostCall(
        ret_type, args_type; device=hsa_dev, continuous=true, buf_len=2^16,
    ) do _
        printf_buf_ptr = reinterpret(
            LLVMPtr{Device.ROCPrintfBuffer, AS.Global},
            printf_output_context.buf_ptr)
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

    # Pointer to `output_context` struct to be read from device.
    hc_buf = Mem.HostBuffer(sizeof(printf_output_context), HIP.hipHostAllocMapped)
    _printf_output_context[hip_dev] = (printf_output_context, hc_buf)

    hc_ptr = Base.unsafe_convert(
        Ptr{Device.PRINTF_OUTPUT_CONTEXT_TYPE}, hc_buf)
    Base.unsafe_store!(hc_ptr, printf_output_context)
    return Mem.device_ptr(hc_buf)
end
