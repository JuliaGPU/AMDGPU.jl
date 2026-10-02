# Devices

In AMDGPU, all GPU devices are auto-detected by the runtime, if they're supported.

Each Julia task has a current device, used for kernel launches and array
allocations unless another device is specified via `@roc` or an equivalent interface.
The device bound to the current task is accessible via [`AMDGPU.device`](@ref) method.
The list of available devices can be queried with [`AMDGPU.devices`](@ref) method.

If you have a `HIPDevice` object, you can also switch
the device with [`AMDGPU.device!`](@ref).
This switches the calling task, and also makes the device the default device,
which tasks start on the first time they use AMDGPU.
Pass a function to switch only while it runs, without changing the default.

```julia
xd1 = AMDGPU.ones(Float32, 16) # On `AMDGPU.device()` device.

AMDGPU.device!(AMDGPU.devices()[2]) # Switch to second device.
xd2 = AMDGPU.ones(Float32, 16) # On second device.

AMDGPU.device!(AMDGPU.devices()[1]) do
    xd3 = AMDGPU.ones(Float32, 16) # On first device.
end # Back on second device.
```

To change only the device that new tasks start on,
use [`AMDGPU.default_device!`](@ref):

```julia
AMDGPU.default_device!(AMDGPU.devices()[3]) # New tasks start on third device.
Threads.@spawn begin
    x = AMDGPU.ones(Float32, 16) # On third device.
    return
end
```

Additionally, devices have an associated numeric ID.
This value is bounded between `1` and `length(AMDGPU.devices())`,
and device `1` is the default device when AMDGPU is first loaded.
The ID of the device associated with the current task can be queried
with [`AMDGPU.device_id`](@ref) and changed with [`AMDGPU.device_id!`](@ref).

```@docs
AMDGPU.devices
AMDGPU.device
AMDGPU.device!
AMDGPU.default_device
AMDGPU.default_device!
AMDGPU.device_id
AMDGPU.device_id!
```

## Device Properties

```@docs
AMDGPU.HIP.name
AMDGPU.HIP.wavefrontsize
AMDGPU.HIP.gcn_arch
AMDGPU.HIP.device_id
AMDGPU.HIP.properties
```
