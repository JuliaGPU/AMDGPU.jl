# FAQ

## How do I check that AMDGPU.jl works?

`AMDGPU.functional()` returns `true` when the ROCm stack is available and a GPU can be used. For a full report of detected devices, libraries and versions, use `AMDGPU.versioninfo()`.

```julia
using AMDGPU
AMDGPU.functional()     # true if AMDGPU.jl can run on this machine
AMDGPU.versioninfo()    # detailed diagnostics
```

## How should a package depend on AMDGPU.jl?

AMDGPU.jl loads on any machine, but only works when ROCm and a supported GPU are present. Code that should run with or without a GPU must therefore guard GPU use behind `AMDGPU.functional()` rather than assume it — importing the package is not enough.

```julia
using AMDGPU

if AMDGPU.functional()
    x = AMDGPU.ones(Float32, 1024)   # run on the GPU
else
    x = ones(Float32, 1024)          # CPU fallback
end
```

For a hard requirement of GPU hardware specifically, `has_rocm_gpu()` additionally checks that at least one device is present. For a heavier optional dependency, prefer a [package extension](https://pkgdocs.julialang.org/v1/creating-packages/#Conditional-loading-of-code-in-packages-(Extensions)) that loads only when AMDGPU is available, following the pattern used by the wider Julia GPU ecosystem.

## Which ROCm libraries are available?

Individual components are queried with `AMDGPU.functional(component)`, useful when a feature depends on a specific library:

```julia
AMDGPU.functional(:rocblas)     # dense linear algebra (rocBLAS)
AMDGPU.functional(:rocsolver)   # factorizations (rocSOLVER)
AMDGPU.functional(:rocsparse)   # sparse arrays (rocSPARSE)
AMDGPU.functional(:rocfft)      # FFTs (rocFFT)
AMDGPU.functional(:rocrand)     # random numbers (rocRAND)
AMDGPU.functional(:MIOpen)      # deep-learning primitives (MIOpen)
AMDGPU.functional(:all)         # true only if every component is available
```

## My GPU is not detected or a library is missing

Run `AMDGPU.versioninfo()` and check that `hip` and the library you need report as functional. Missing components usually mean the corresponding ROCm package is not installed. See [Installation Info](@ref) for platform-specific setup, including the package list for distributions such as Fedora.

## I installed ROCm 7.14 or newer but it isn't detected

ROCm 7.14 changed its on-disk layout, installing libraries under a versioned `core-<version>` subdirectory (for example `/opt/rocm/core-7.14/lib`). AMDGPU.jl discovers this automatically, but if detection fails on a minimal or custom install, make sure `ROCM_PATH` points at the ROCm root (e.g. `/opt/rocm`) rather than at the versioned subdirectory. See [Installation Info](@ref) for details.

## Can I use the integrated GPU of my Ryzen CPU?

The Radeon graphics of Ryzen 7000 and 9000 desktop CPUs (Raphael/Granite Ridge, `gfx1036`) works, even though ROCm does not officially support it (tested with ROCm 7.2 on Linux). It is small (2 compute units) and shares system memory, so it is mainly useful for development and testing. Kernels, arrays, rocBLAS, rocSOLVER, rocSPARSE, rocRAND, rocFFT and MIOpen work; hipTENSOR has no kernels for this architecture and is reported as unavailable.

On this GPU, kernel results can be silently lost when the host does not synchronize shortly after a launch: the GPU's idle clock gating discards data that is still in its L2 cache. The workaround is to make HIP write back the cache after every kernel ("system-scope fences"), at a small cost per launch. HIP reads this setting once, at initialization, and applies it to all GPUs used by the process, so it is controlled by the `system_scope_fences` preference:

- `"auto"` (default): enabled when every AMD GPU in the system needs it, e.g., when the integrated GPU is your only AMD GPU. On systems that also have a dedicated AMD GPU, the workaround is not enabled, so as not to slow that GPU down, and AMDGPU.jl warns when you use the integrated GPU. GPUs hidden with `ROCR_VISIBLE_DEVICES` or `HIP_VISIBLE_DEVICES` don't count.
- `true` or `false`: always or never enable the workaround, also on GPUs that AMDGPU.jl does not know to be affected.

Change it with `AMDGPU.system_scope_fences!(true)` (or `false`, `"auto"`) and restart Julia. Setting the `AMD_OPT_FLUSH` environment variable overrides the preference: `AMD_OPT_FLUSH=0` enables the workaround, other numbers disable it. The workaround is implemented by setting `AMD_OPT_FLUSH=0` when AMDGPU.jl is loaded, so it is inherited by subprocesses, and it has no effect if another library initialized HIP before AMDGPU.jl was loaded.

If you also have a dedicated AMD GPU, see [Installation Info](@ref) on selecting a device with `HIP_VISIBLE_DEVICES`.

## I'm on Arch Linux and ROCm isn't working

For the last few ROCm releases, users have reported problems with the distro-provided ROCm builds and associated tools ([#770](https://github.com/JuliaGPU/AMDGPU.jl/issues/770), [#696](https://github.com/JuliaGPU/AMDGPU.jl/issues/696), [#767](https://github.com/JuliaGPU/AMDGPU.jl/issues/767)). Some have had success with the [`opencl-amd-dev`](https://aur.archlinux.org/packages/opencl-amd-dev) AUR package instead.

## How do I control GPU memory usage?

`ROCArray`s are managed by Julia's garbage collector, and a HIP memory pool caches freed allocations. You can free eagerly, cap usage, and query current usage — see the [Memory Allocation and Intrinsics](@ref) page for `AMDGPU.unsafe_free!`, memory limits, and the caching allocator.

## Where can I get help?

Ask on the [Julia Discourse](https://discourse.julialang.org/c/domain/gpu) GPU domain or the `#gpu` channel of the [Julia Slack](https://julialang.org/community/). Bug reports and feature requests are welcome on the [issue tracker](https://github.com/JuliaGPU/AMDGPU.jl/issues).
