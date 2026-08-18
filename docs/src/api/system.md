# System and Configuration

## Checking the installation

`AMDGPU.versioninfo()` prints a full report of detected ROCm libraries, their versions, and the available devices. `AMDGPU.functional()` returns whether AMDGPU.jl can run at all, and `AMDGPU.functional(component)` queries an individual ROCm component (see [FAQ](@ref) for the component list). `has_rocm_gpu()` additionally requires that a GPU device is present.

```@docs
AMDGPU.versioninfo
AMDGPU.functional
AMDGPU.has_rocm_gpu
```

## Choosing the ROCm provider

By default the ROCm runtime and libraries come from downloaded artifacts; see
[Installation Info](@ref) for how to switch to a local ROCm installation.

```@docs
AMDGPU.set_rocm_version!
AMDGPU.reset_rocm_version!
```

## Configuration preferences

Several behaviours are configured through [Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl) and persist across sessions (they are written to your project's `LocalPreferences.toml`):

| Preference | Set via | Effect |
|:--|:--|:--|
| `version` / `local` | `AMDGPU.set_rocm_version!` | Select the ROCm version, and whether to use downloaded artifacts or a local ROCm installation. |
| `arch` | `AMDGPU.set_rocm_version!` | Override the GPU architectures used to select the ROCm artifact, as a comma-separated list of `gfx` targets. Useful when no GPU is visible at install time. See [Installation Info](@ref). |
| `nonblocking_synchronize` | preference | Use non-blocking stream synchronization (default `true`); disable for slightly lower latency. See [Streams](@ref). |
| `eager_gc` | `AMDGPU.eager_gc!(::Bool)` | Trigger GC before allocations under memory pressure. See [Memory Allocation and Intrinsics](@ref). |
| `hard_memory_limit` | `AMDGPU.hard_memory_limit!("8 GiB")` | Hard cap on GPU memory, checked before every allocation. |
| `soft_memory_limit` | `AMDGPU.soft_memory_limit!("6 GiB")` | Advisory limit for the memory pool. |

The `version`, `local` and `arch` preferences belong to the `ROCm_Runtime` subpackage rather than to AMDGPU itself, so when editing `LocalPreferences.toml` by hand they go under a `[ROCm_Runtime]` section. They are compile-time preferences: changing one invalidates precompilation and takes effect after restarting Julia.

## Debugging kernel launches

Set the environment variable `HIP_LAUNCH_BLOCKING=1` (or toggle `AMDGPU.LAUNCH_BLOCKING[] = true` at runtime) to make kernel launches synchronous. This makes errors surface at the offending launch rather than at a later synchronization point, which is invaluable when tracking down a crashing or misbehaving kernel.
