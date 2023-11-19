# Programming AMD GPUs with Julia

## The Julia AMDGPU stack

Julia support for programming AMD GPUs is currently provided by the
[AMDGPU.jl](https://github.com/JuliaGPU/AMDGPU.jl) package.
This package contains everything necessary to program for AMD GPUs in Julia, including:

* An interface for compiling and running kernels written in Julia through LLVM's AMDGPU backend.
* An interface for working with the HIP runtime API,
    necessary for launching compiled kernels and controlling the GPU.
* An array type implementing the [GPUArrays.jl](https://github.com/JuliaGPU/GPUArrays.jl)
    interface, providing high-level array operations.

## Installation

Simply add the AMDGPU.jl package to your Julia environment:

```julia
using Pkg
Pkg.add("AMDGPU")
```

To ensure that everything works, you can run the test suite:

```julia
using AMDGPU
using Pkg
Pkg.test("AMDGPU")
```

## Requirements

Julia **1.9 or higher**.

Minimal supported ROCm version is **5.3**.
For optimal experience, you should have full ROCm stack installed.
Refer to official ROCm stack installation instructions: <https://rocm.docs.amd.com/en/latest/deploy/linux/index.html>

Currently, AMDGPU.jl utilizes following libraries:

[ROCT](https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface),
[ROCR](https://github.com/RadeonOpenCompute/ROCR-Runtime),
[ROCm-Device-Libs](https://github.com/RadeonOpenCompute/ROCm-Device-Libs),
[HIP](https://github.com/ROCm-Developer-Tools/HIP),
[rocBLAS](https://github.com/ROCmSoftwarePlatform/rocBLAS),
[rocFFT](https://github.com/ROCmSoftwarePlatform/rocFFT),
[rocSOLVER](https://github.com/ROCmSoftwarePlatform/rocSOLVER),
[rocSPARSE](https://github.com/ROCmSoftwarePlatform/rocSPARSE),
[rocRAND](https://github.com/ROCmSoftwarePlatform/rocRAND),
[MIOpen](https://github.com/ROCmSoftwarePlatform/MIOpen).

### ROCm artifacts

There is limited support for ROCm 5.4+ artifacts which can be enabled with
[`AMDGPU.enable_artifacts!`](@ref).

Limited means not all libraries are available and some of the functionality
may be disabled.

```@docs
AMDGPU.enable_artifacts!
```

### Extra Setup Details

List of additional steps that may be needed to take to ensure everything is working:

- Make sure your user is in the same group as `/dev/kfd`, other than `root`.

    For example, it might be the `render` group:

    ```
    crw-rw----   1 root   render  234,   0 Aug  5 11:43 kfd
    ```

    In this case, you can add yourself to it:

    ```
    sudo usermod -aG render username
    ```

- ROCm libraries should be in the standard library locations, or in your `LD_LIBRARY_PATH`.

- If you get an error message along the lines of `GLIB_CXX_... not found`,
    it's possible that the C++ runtime used to build the ROCm stack
    and the one used by Julia are different.
    If you built the ROCm stack yourself this is very likely the case
    since Julia normally ships with its own C++ runtime.

    For more information, check out this [GitHub issue](https://github.com/JuliaLang/julia/issues/34276).
    A quick fix is to use the `LD_PRELOAD` environment variable to make Julia use the system C++ runtime library, for example:

    ```
    LD_PRELOAD=/usr/lib/libstdc++.so julia
    ```

    Alternatively, you can build Julia from source as described
    [here](https://github.com/JuliaLang/julia/blob/master/doc/build/build.md).
    To quickly debug this issue start Julia and try to load a ROCm library:

    ```
    using Libdl
    Libdl.dlopen("/opt/rocm/hsa/lib/libhsa-runtime64.so.1")
    ```

- `ld.lld` should be in your `PATH`.

- For better experience use whatever Linux kernel
    is officially supported by ROCm stack.


Once all of this is setup properly, you should be able to do `using AMDGPU`
successfully.

See the [Quick Start](@ref) documentation for an introduction to using AMDGPU.jl.

## Preferences

AMDGPU.jl supports setting
[preferences](https://github.com/JuliaPackaging/Preferences.jl).
Template of `LocalPreferences.toml` with all options:

```toml
[AMDGPU]
# If `true` then use ROCm libraries provided by artifacts.
# However, not all ROCm libraries are available as artifacts.
use_artifacts = false
# Use non-blocking synchronization for all `AMDGPU.synchronize()` calls.
nonblocking_synchronization = true
# Memory limit specifies maximum amount of memory in percentages
# a current Julia process can use.
# Default is "none", which does not apply any limitation.
hard_memory_limit = "none"
# Notice a space between the value and percentage sign.
# hard_memory_limit = "80 %"
```
