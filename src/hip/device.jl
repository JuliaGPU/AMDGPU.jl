struct HIPDevice
    device::hipDevice_t
    device_id::Cint
end

function HIPDevice(device_id::Integer)
    device_ref = Ref{hipDevice_t}()
    hipDeviceGet(device_ref, device_id - 1) |> check
    return HIPDevice(device_ref[], device_id)
end

device_id(d::HIPDevice) = d.device_id - 1

function stack_size()
    value = Ref{Csize_t}()
    hipDeviceGetLimit(value, hipLimitStackSize) |> check
    value[]
end

function stack_size!(value::Integer)
    hipDeviceSetLimit(hipLimitStackSize, value) |> check
end

# TODO heap_size tweaking available since 5.5

function heap_size()
    value = Ref{Csize_t}()
    hipDeviceGetLimit(value, hipLimitMallocHeapSize) |> check
    value[]
end

function heap_size!(value::Integer)
    hipDeviceSetLimit(hipLimitMallocHeapSize, value) |> check
end

Base.hash(dev::HIPDevice, h::UInt) = hash(dev.device, h)

Base.unsafe_convert(::Type{Ptr{T}}, device::HIPDevice) where T =
    reinterpret(Ptr{T}, device.device)

function name(dev::HIPDevice)
    name_vec = zeros(Cuchar, 64)
    hipDeviceGetName(pointer(name_vec), Cint(64), dev.device) |> check
    return String(name_vec)
end

function properties(dev::HIPDevice)
    init_arch_ref = Ref(hipDeviceArch_t())
    arch_field_id = findfirst(i -> i == :arch, fieldnames(hipDeviceProp_t))
    arch_offset = fieldoffset(hipDeviceProp_t, arch_field_id)

    props_ref = Ref{hipDeviceProp_t}()
    ccall(:memset,
        Cvoid, (Ptr{Cvoid}, Cint, Csize_t),
        props_ref, 0, sizeof(hipDeviceProp_t))
    ccall(:memcpy,
        Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
        Base.unsafe_convert(Ptr{Cvoid}, props_ref) + arch_offset,
        init_arch_ref, sizeof(hipDeviceArch_t))

    hipGetDeviceProperties(props_ref, device_id(dev)) |> check
    props_ref[]
end

function Base.show(io::IO, device::HIPDevice)
    print(io, "HIPDevice(name=\"$(name(device))\", id=$(device.device_id))")
end

function ndevices()
    count_ref = Ref{Cint}()
    hipGetDeviceCount(count_ref) |> check
    count_ref[]
end

devices() = [HIPDevice(i) for i in 1:ndevices()]

function device()
    device_id_ref = Ref{Cint}()
    hipGetDevice(device_id_ref) |> check
    return HIPDevice(device_id_ref[]+1)
end

device!(device::HIPDevice) = hipSetDevice(device_id(device)) |> check

device!(device_id::Integer) = hipSetDevice(device_id - 1) |> check

function device!(f::Base.Callable, device::HIPDevice)
    old_device_id_ref = Ref{Cint}()
    hipGetDevice(old_device_id_ref) |> check
    device!(device)
    try
        f()
    finally
        device!(old_device_id_ref[] + 1)
    end
end
