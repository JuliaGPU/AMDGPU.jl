# System and Configuration

## Checking the installation

`AMDGPU.versioninfo()` prints a full report of detected ROCm libraries, their versions, and the available devices. `AMDGPU.functional()` returns whether AMDGPU.jl can run at all, and `AMDGPU.functional(component)` queries an individual ROCm component (see [FAQ](@ref) for the component list). `has_rocm_gpu()` additionally requires that a GPU device is present.

```@docs
AMDGPU.versioninfo
AMDGPU.functional
AMDGPU.has_rocm_gpu
```

## Choosing the ROCm provider

By default the ROCm runtime and libraries are downloaded as artifacts. See [Installation Info](@ref) for using a local ROCm installation instead.

```@docs
AMDGPU.set_rocm_version!
AMDGPU.reset_rocm_version!
```

## Configuration preferences

Several behaviours are configured through [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) and persist across sessions (they are written to your project's `LocalPreferences.toml`):

| Preference | Set via | Effect |
|:--|:--|:--|
| `nonblocking_synchronization` | preference | Use non-blocking stream synchronization (default `true`); disable for slightly lower latency. See [Streams](@ref). |
| `eager_gc` | `AMDGPU.eager_gc!(::Bool)` | Trigger GC before allocations under memory pressure. See [Memory Allocation and Intrinsics](@ref). |
| `hard_memory_limit` | `AMDGPU.hard_memory_limit!("8 GiB")` | Hard cap on GPU memory, checked before every allocation. |
| `soft_memory_limit` | `AMDGPU.soft_memory_limit!("6 GiB")` | Advisory limit for the memory pool. |
| `system_scope_fences` | `AMDGPU.system_scope_fences!(true)` | Write back the GPU cache after every kernel (default `"auto"`), needed on the integrated GPU of Ryzen 7000/9000 CPUs. See [FAQ](@ref). Takes effect after a restart. |
| `local` | `AMDGPU.set_rocm_version!(local_rocm=true)` | Use a local ROCm installation instead of the artifacts. See [Installation Info](@ref). Takes effect after a restart. |
| `version` | `AMDGPU.set_rocm_version!(v"10.1")` | ROCm release the artifacts are taken from (default: the newest). Takes effect after a restart. |
| `arch` | `AMDGPU.set_rocm_version!(arch="gfx942")` | GPU architectures to select the artifacts for, when they cannot be detected. Takes effect after a restart. |

The `local`, `version` and `arch` preferences belong to the `ROCm_Runtime` package, so in `LocalPreferences.toml` they go under `[ROCm_Runtime]` rather than `[AMDGPU]`. See [Installation Info](@ref) for setting them by hand.

## Debugging kernel launches

Set the environment variable `HIP_LAUNCH_BLOCKING=1` (or toggle `AMDGPU.LAUNCH_BLOCKING[] = true` at runtime) to make kernel launches synchronous. This makes errors surface at the offending launch rather than at a later synchronization point, which is invaluable when tracking down a crashing or misbehaving kernel.
