# Devices/Agents

In AMDGPU, all GPU devices (also known as "agents" in HSA parlance) are
auto-detected by the runtime, if they're supported.
There are three classes of devices:
- CPU
- GPU
- DSP

In AMDGPU, we only support compilation and execution on **GPU** devices,
so we will henceforth limit discussion to those;
however, you may see a `kind` `Symbol` available in the APIs of many device
access functions, which defaults to `:gpu`, but could also be `:cpu` or `:dsp`.

AMDGPU maintains a global default device.
The default device is relevant for all kernel and GPUArray operations;
if one is not specified via `@roc` or an equivalent interface,
then the default device is used for those operations,
which affects compilation and kernel launch.

!!! note "Task-Local Storage"
    Since AMDGPU.jl relies on Task-Local Storage, this means that
    default devices are default only within a given task.
    Other tasks migh have different default devices if the user switched them.

The default device is accessible via [`AMDGPU.device()`](@ref).
This function returns a [`ROCDevice`](@ref), which is a handle that references the device.
The list of available devices can be queried with [`AMDGPU.devices`](@ref) to get
a list of all known and potentially usable devices.

If you have a [`ROCDevice`](@ref) object, you can also switch
the default device via [`AMDGPU.device!`](@ref).
This will switch it only within the task it is called from.

To select default device for newly created tasks,
use [`AMDGPU.default_device!`](@ref).

Additionally, devices have an associated numeric ID.
The default device ID can be queried with [`AMDGPU.default_device_id`](@ref),
which returns an `Int`.
This value is bounded between `1` and `length(AMDGPU.devices())`,
and device `1` is the default device when AMDGPU is first loaded.

```@docs
AMDGPU.devices
AMDGPU.device
AMDGPU.device!
AMDGPU.default_device
AMDGPU.default_device!
AMDGPU.default_device_id
AMDGPU.default_device_id!
```
