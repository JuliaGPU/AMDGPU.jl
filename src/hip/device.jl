struct HIPDevice
    device::hipDevice_t
    device_id::Cint
    gcn_arch::String
    wavefrontsize::Cint
end

const DEFAULT_DEVICE = Ref{Union{Nothing, HIPDevice}}(nothing)
const ALL_DEVICES = Vector{HIPDevice}()

function HIPDevice(device_id::Integer)
    isempty(ALL_DEVICES) || return ALL_DEVICES[device_id]

    device_ref = Ref{hipDevice_t}()
    hipDeviceGet(device_ref, device_id - 1)

    props = properties(device_id - 1)
    gcn_arch = unsafe_string(pointer([props.gcnArchName...]))
    HIPDevice(device_ref[], device_id, gcn_arch, props.warpSize)
end

"""
    device_id(d::HIPDevice)

Zero-based device ID as expected by HIP functions.
Differs from [`AMDGPU.device_id`](@ref) method by `1`.
"""
device_id(d::HIPDevice) = d.device_id - 1

"""
    wavefrontsize(d::HIPDevice)::Cint

Get size of the wavefront. AMD GPUs support either 32 or 64.
"""
wavefrontsize(d::HIPDevice)::Cint = d.wavefrontsize

"""
    gcn_arch(d::HIPDevice)::String

Get GCN architecture for the device.
"""
gcn_arch(d::HIPDevice)::String = d.gcn_arch

function stack_size()
    value = Ref{Csize_t}()
    hipDeviceGetLimit(value, hipLimitStackSize)
    value[]
end

function stack_size!(value::Integer)
    hipDeviceSetLimit(hipLimitStackSize, value)
end

function heap_size()
    value = Ref{Csize_t}()
    hipDeviceGetLimit(value, hipLimitMallocHeapSize)
    value[]
end

function heap_size!(value::Integer)
    hipDeviceSetLimit(hipLimitMallocHeapSize, value)
end

Base.unsafe_convert(::Type{hipDevice_t}, device::HIPDevice) = device.device
Base.:(==)(a::HIPDevice, b::HIPDevice) = a.device == b.device
Base.hash(dev::HIPDevice, h::UInt) = hash(dev.device, h)

"""
    name(dev::HIPDevice)::String

Get name of the device.
"""
function name(dev::HIPDevice)::String
    name_vec = zeros(Cuchar, 64)
    hipDeviceGetName(pointer(name_vec), Cint(64), dev.device)
    return strip(String(name_vec), '\0')
end

"""
    properties(dev::HIPDevice)::hipDeviceProp_t

Get all properties for the device.
See HIP documentation for `hipDeviceProp_t` for the meaning of each field.
"""
properties(dev::HIPDevice) = properties(device_id(dev))

function properties(dev_id::Int)
    props_ref = Ref{hipDeviceProp_t}()
    hipGetDeviceProperties(props_ref, dev_id)
    props_ref[]
end

function attribute(dev::HIPDevice, attr)
    v = Ref{Cint}()
    hipDeviceGetAttribute(v, attr, device_id(dev))
    v[]
end

function ndevices()
    count_ref = Ref{Cint}()
    hipGetDeviceCount(count_ref)
    count_ref[]
end

function devices()
    isempty(ALL_DEVICES) || return copy(ALL_DEVICES)

    devs = Vector{HIPDevice}(undef, ndevices())
    for i in 1:length(devs)
        d = HIPDevice(i)

        arch = gcn_arch(d)
        if occursin("gfx11", arch) && VERSION < v"1.10-"
            @error "Navi 3 ($arch) requires Julia 1.10+ and ROCm 5.5 or higher."
        end
        devs[i] = d
    end
    append!(ALL_DEVICES, devs)
    return devs
end

function device()
    device_id_ref = Ref{Cint}()
    hipGetDevice(device_id_ref)
    return HIPDevice(device_id_ref[] + 1)
end

device!(device::HIPDevice) = hipSetDevice(device_id(device))

device!(device_id::Integer) = hipSetDevice(device_id - 1)

function device!(f::Base.Callable, device::HIPDevice)
    old_device_id_ref = Ref{Cint}()
    hipGetDevice(old_device_id_ref)
    device!(device)
    try
        f()
    finally
        device!(old_device_id_ref[] + 1)
    end
end

function can_access_peer(dev::HIPDevice, peer::HIPDevice)
    result = Ref{Cint}(0)
    hipDeviceCanAccessPeer(result, device_id(dev), device_id(peer))
    return result[] == 1
end

# Pretty-printing.

function Base.show(io::IO, dev::HIPDevice)
    print(io, "HIPDevice(id=$(dev.device_id), name=$(name(dev)), gcn_arch=$(dev.gcn_arch))")
end

function __pretty_data(dev::HIPDevice)
    props = properties(dev)
    name_ptr = pointer([props.name...])
    name = unsafe_string(name_ptr)
    reshape(String[
        "$(dev.device_id)", name, "$(dev.gcn_arch)",
        "$(dev.wavefrontsize)", "$(Base.format_bytes(props.totalGlobalMem))",
    ], 1, :)
end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, dev::HIPDevice)
    PrettyTables.pretty_table(io, __pretty_data(dev); header=[
        "Id", "Name", "GCN arch", "Wavefront", "Memory"])
end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, devs::Vector{HIPDevice})
    PrettyTables.pretty_table(io, vcat(__pretty_data.(devs)...); header=[
        "Id", "Name", "GCN arch", "Wavefront", "Memory"])
end
