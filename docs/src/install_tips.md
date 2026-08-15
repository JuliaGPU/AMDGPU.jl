# Installation Info

## ROCm libraries

By default, AMDGPU.jl ships the ROCm runtime (HIP and HSA) and the vendor
libraries (rocBLAS, rocSPARSE, rocSOLVER, rocRAND, rocFFT, hipTENSOR, MIOpen) as lazy
artifacts through the `ROCm_Runtime` subpackage, which downloads AMD's TheRock
distribution tarball matching the GPUs detected on the host. `ld.lld` and the
device bitcode libraries always come from `AMDGPU_LLVM_Backend_jll` and
`ROCmDeviceLibs_jll`. No system-wide ROCm installation is needed in this mode.

To use a local ROCm installation instead, set the `local` preference in the
active project and restart Julia:

```julia
AMDGPU.set_rocm_version!(local_rocm=true)
```

The library locations are then discovered through the `ROCm_Runtime_Discovery`
package, as described below. Use `AMDGPU.reset_rocm_version!()` to go back to
the default artifact-based setup.

## Local ROCm discovery

On Linux, AMDGPU.jl queries the location of ROCm libraries through `rocminfo` by default.
If not successful or on Windows, the following standard directories are searched:

Standard paths:
- Linux: `/opt/rocm`, `/usr`
- Windows: `C:/Program Files/AMD/ROCm/<rocm-version>`

If you have non-standard path for ROCm, set `ROCM_PATH=<path>`
environment variable before launching Julia. The `AMDGPU.versioninfo()`
function prints the paths of any libraries found.

Starting with ROCm 7.14, libraries are installed under a versioned `core-<version>` subdirectory (for example `/opt/rocm/core-7.14/lib`) instead of directly in `/opt/rocm/lib`. AMDGPU.jl handles this automatically by selecting the newest `core-*` directory found under the ROCm root, so keep `ROCM_PATH` pointed at the install root (e.g. `/opt/rocm`) rather than at the versioned subdirectory. A full ("metapackage") install additionally provides a `/opt/rocm/lib` compatibility symlink and needs no special handling; the versioned lookup mainly benefits minimal, GPU-architecture-specific installs that omit that symlink.

Depending on your GPU model and the functionality you want to use, you may have
to force the GPU architecture by setting the `HSA_OVERRIDE_GFX_VERSION`
variable to a compatible version.

You may also have more than one type of GPU, for example a dedicated AMD GPU and an integrated one.
In that case use `rocminfo` to find which device they are and setting `HIP_VISIBLE_DEVICES` to the specific device you want to use.
Otherwise the runtime may crash if it sees two different architectures.

## Extra Setup Details

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

Once all of this is setup properly, you should be able to do `using AMDGPU`
successfully.

See the [Quick Start](@ref) documentation for an introduction to using AMDGPU.jl.

## Preferences

AMDGPU.jl supports setting
[preferences](https://github.com/JuliaPackaging/Preferences.jl).
Template of `LocalPreferences.toml` with all options:

```toml
[AMDGPU]
# If `true` (default is `false`), eagerly run GC to keep the pool from growing too big.
# GC is triggered during new allocatoins or synchronization points.
eager_gc = true
# Use non-blocking synchronization for all `AMDGPU.synchronize()` calls (default is `true`).
nonblocking_synchronization = true
# Memory limit specifies maximum amount of memory in percentages
# a current Julia process can use.
# Default is "none", which does not apply any limitation.
hard_memory_limit = "none"
# Notice a space between the value and percentage sign.
# hard_memory_limit = "80 %"
```

## Windows OS missing functionality

Windows **does not** yet support [Hostcall](@ref), which means that
some of the functionality does not work, like:

- device printing;
- dynamic memory allocation (from kernels).

These hostcalls are sometimes launched when AMDGPU detects that a
kernel might throw an exception, specifically during conversions, like:
`Int32(1f0)`.

To avoid this, use 'unsafe' conversion option:
`unsafe_trunc(Int32, 1f0)`.
