const DEFAULT_DEVICE = Ref{HIPDevice}()
const ALL_DEVICES = Vector{HIPDevice}()
const HSA_DEVICES = Vector{ROCDevice}()

function fetch_devices()
    isempty(ALL_DEVICES) || return copy(ALL_DEVICES)

    devs = HIP.devices()
    append!(ALL_DEVICES, devs)
    return devs
end

function fetch_hsa_devices()
    isempty(HSA_DEVICES) || return copy(HSA_DEVICES)

    devices = Ref(Vector{ROCDevice}())
    GC.@preserve devices begin
        func = @cfunction(iterate_agents_cb, HSA.Status,
                (HSA.Agent, Ref{Vector{ROCDevice}}))
        HSA.iterate_agents(func, devices) |> check
        _devices = devices[]
    end

    filter!(d -> device_type(d) == HSA.DEVICE_TYPE_GPU, _devices)
    append!(HSA_DEVICES, _devices)
    return _devices
end

hsa_device(device::HIPDevice) = HSA_DEVICES[device.device_id]

"""
    get_default_device() -> HIPDevice

TODO update docs

# Returns the default device, which is used for all kernel and array operations
# when one is not explicitly specified. May be changed with
# [`set_default_device!`](@ref).
"""
function get_default_device()
    if !isassigned(DEFAULT_DEVICE)
        error("No GPU devices detected!")
    end
    DEFAULT_DEVICE[]
end

"""
    set_default_device!(device::ROCDevice) -> ROCDevice

Sets the default device to `device`. See [`get_default_device`](@ref) for more
details.
"""
function set_default_device!(device::HIPDevice)
    DEFAULT_DEVICE[] = device
end

"Return all devices available to the runtime."
devices() = copy(ALL_DEVICES)
