# Devices

In AMDGPU, all GPU devices are auto-detected by the runtime, if they're supported.

AMDGPU maintains a global default device.
The default device is relevant for all kernel and GPUArray operations.
If one is not specified via `@roc` or an equivalent interface,
then the default device is used for those operations,
which affects compilation and kernel launch.

The device bound to a current Julia task is accessible via [`AMDGPU.device()`](@ref).
The list of available devices can be queried with [`AMDGPU.devices`](@ref).

If you have a `HIPDevice` object, you can also switch
the device with [`AMDGPU.device!`](@ref).
This will switch it **only within the task it is called from**.

```julia
xd1 = AMDGPU.ones(Float32, 16) # On `AMDGPU.device()` device.

AMDGPU.device!(AMDGPU.devices()[2]) # Switch to second device.
xd2 = AMDPGU.ones(Float32, 16) # On second device.
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
AMDGPU.device_id
AMDGPU.device_id!
```
