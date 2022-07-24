# Devices/Agents

In AMDGPU, all GPU devices (also known as "agents" in HSA parlance) are
auto-detected by the runtime, if they're supported. There are three classes of
devices: CPU, GPU, and DSP. In AMDGPU, we only support compilation and
execution on GPU devices, so we will henceforth limit discussion to those;
however, you may see a `kind` `Symbol` available in the APIs of many device
access functions, which defaults to `:gpu`, but could also be `:cpu` or `:dsp`.

AMDGPU maintains a global default device. The default device is relevant for
all kernel and GPUArray operations; if one is not specified via `@roc` or an
equivalent interface, then the default device is used for those operations,
which affects compilation and kernel launch.

The default device is accessible via `AMDGPU.get_default_agent()`. This
function returns an `ROCDevice`, which is a handle that references the device.
The list of available devices can be queried with `AMDGPU.get_agents()` to get
a list of all known and potentially usable devices. If you have an `ROCDevice`
object, you can also switch the default device via
`AMDGPU.set_default_agent!(agent)`.

Additionally, devices have an associated numeric ID. The default device ID can
be queried with `AMDGPU.device()`, which returns an `Int`. This value is
bounded between `1` and `length(AMDGPU.get_agents())`, and device `1` is the
default device when AMDGPU is first loaded. The default device may be switched
with `AMDGPU.device!(idx)`.

```@docs
AMDGPU.get_agents
AMDGPU.get_default_agent
AMDGPU.set_default_agent!
AMDGPU.device
AMDGPU.device!
```
