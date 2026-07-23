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

## I'm on Arch Linux and ROCm isn't working

For the last few ROCm releases, users have reported problems with the distro-provided ROCm builds and associated tools ([#770](https://github.com/JuliaGPU/AMDGPU.jl/issues/770), [#696](https://github.com/JuliaGPU/AMDGPU.jl/issues/696), [#767](https://github.com/JuliaGPU/AMDGPU.jl/issues/767)). Some have had success with the [`opencl-amd-dev`](https://aur.archlinux.org/packages/opencl-amd-dev) AUR package instead.

## How do I control GPU memory usage?

`ROCArray`s are managed by Julia's garbage collector, and a HIP memory pool caches freed allocations. You can free eagerly, cap usage, and query current usage — see the [Memory Allocation and Intrinsics](@ref) page for `AMDGPU.unsafe_free!`, memory limits, and the caching allocator.

## Where can I get help?

Ask on the [Julia Discourse](https://discourse.julialang.org/c/domain/gpu) GPU domain or the `#gpu` channel of the [Julia Slack](https://julialang.org/community/). Bug reports and feature requests are welcome on the [issue tracker](https://github.com/JuliaGPU/AMDGPU.jl/issues).
