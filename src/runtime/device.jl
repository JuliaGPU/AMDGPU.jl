const DEFAULT_DEVICE = Ref{Union{Nothing, HIPDevice}}(nothing)
const ALL_DEVICES = Vector{HIPDevice}()

function fetch_devices()
    isempty(ALL_DEVICES) || return copy(ALL_DEVICES)

    devs = HIP.devices()
    append!(ALL_DEVICES, devs)
    return devs
end

"Return all devices available to the runtime."
devices() = copy(ALL_DEVICES)
