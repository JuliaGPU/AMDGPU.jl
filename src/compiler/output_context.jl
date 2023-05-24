# TODO do not store per device, have one global.
const _output_context = Dict{
    HIP.HIPDevice, Tuple{Device.GLOBAL_OUTPUT_CONTEXT_TYPE, Mem.HostBuffer}}()

function create_output_context!(#= mod::HIP.HIPModule =#)
    hsa_dev = AMDGPU.device()
    hip_dev = HIP.device()

    oc = get(_output_context, hip_dev, nothing)
    if isnothing(oc)
        output_context = Device.OutputContext(stdout; device=hsa_dev)
        oc_buf = Mem.HostBuffer(sizeof(output_context), HIP.hipHostAllocMapped)
        _output_context[hip_dev] = (output_context, oc_buf)

        oc_ptr = Base.unsafe_convert(
            Ptr{Device.GLOBAL_OUTPUT_CONTEXT_TYPE}, oc_buf)
        Base.unsafe_store!(oc_ptr, output_context)
        return Mem.device_ptr(oc_buf)
    end
    return Mem.device_ptr(oc[2])
end
