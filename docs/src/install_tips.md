# Installation Info

## ROCm libraries

By default, AMDGPU.jl downloads the ROCm runtime (HIP and HSA) and libraries (rocBLAS, rocSOLVER, rocSPARSE, rocFFT, rocRAND, MIOpen and hipTensor) as artifacts, taken from AMD's [TheRock](https://github.com/ROCm/TheRock) distribution for the GPUs detected on the host. No ROCm installation is needed, only the GPU driver. The kernel linker and the device libraries always come from `AMDGPU_LLVM_Backend_jll`; the device libraries are converted to the LLVM version of the running Julia on first use and cached in the depot.

To use a local ROCm installation instead, set the `local` preference and restart Julia:

```julia
AMDGPU.set_rocm_version!(local_rocm=true)
```

Its libraries are then found as described in [Local ROCm discovery](@ref). `AMDGPU.reset_rocm_version!()` goes back to the artifacts.

### Selecting the provider before installing

Pkg reads the `local` preference when it installs the artifacts, so in CI or a fresh depot set it before `Pkg.instantiate()` to avoid downloading a bundle that will not be used. `AMDGPU.set_rocm_version!` needs AMDGPU.jl to be installed, so write the preference by hand instead, under `[ROCm_Runtime]` in the project's `LocalPreferences.toml` (see [Preferences](@ref)):

```toml
[ROCm_Runtime]
local = true
```

Unless `ROCm_Runtime` is a direct dependency, Julia only reads this section when the project's `Project.toml` lists the package (`AMDGPU.set_rocm_version!` adds this entry itself):

```toml
[extras]
ROCm_Runtime = "3129f4d2-de71-4ff3-9833-76037e3ea355"
```

`AMDGPU.local_rocm` tells which provider was selected. Asserting on it in CI keeps a change of default from silently switching the ROCm a job tests.

### When no artifact matches

The bundle is chosen from the GPU architectures detected on the host, which on Linux are read from `/sys/class/kfd/kfd/topology`. If none is detected (in a container without `/dev/kfd`, on a login node, or when the `amdgpu` driver is not loaded), or no bundle supports it, nothing is downloaded, and AMDGPU.jl warns and reports its ROCm components as unavailable. It does not fall back to a ROCm installed on the system; that one is only used with the `local` preference.

The bundles currently shipped are:

```@eval
using AMDGPU, TOML, Markdown
toml = TOML.parsefile(joinpath(pkgdir(AMDGPU.ROCm_Runtime), "Artifacts.toml"))
bundles = Dict{String,Tuple{Set{String},Set{String}}}()
for entry in toml["ROCm_Runtime"]
    platforms, versions = get!(bundles, entry["rocm_arch"], (Set{String}(), Set{String}()))
    push!(platforms, entry["os"])
    push!(versions, entry["rocm"])
end
rows = map(sort(collect(keys(bundles)))) do arch
    platforms, versions = bundles[arch]
    "| `$arch` | $(join(sort(collect(platforms)), ", ")) | $(join(sort(collect(versions); by=VersionNumber), ", ")) |"
end
Markdown.parse(join(vcat("| Bundle | Platforms | ROCm |", "|:--|:--|:--|", rows), "\n"))
```

When the architecture cannot be detected, for example when preparing a depot on a machine without a GPU, select the bundle with the `arch` preference, a `gfx` target or a collection of them:

```julia
AMDGPU.set_rocm_version!(arch="gfx942")
```

Like `local`, it can also be written to `LocalPreferences.toml` before AMDGPU.jl is installed.

The `version` preference selects the ROCm release the bundle is taken from, by default the newest one listed above.

## Local ROCm discovery

Everything in this section applies only when the `local` preference is set, which needs ROCm 6.0 or newer installed on the system. In the default artifact mode the library paths come from the downloaded bundle and `ROCM_PATH` is not consulted; a ROCm reachable through `LD_LIBRARY_PATH` or the device-library variables is still picked up by the runtime and mixed into the process, see the [FAQ](@ref).

The ROCm root is taken from `ROCM_PATH` if set, on Linux otherwise from `hipconfig --rocmpath`, and failing that from the standard paths:

- Linux: `/opt/rocm`, `/usr`
- Windows: `C:/Program Files/AMD/ROCm/<rocm-version>`

If you have non-standard path for ROCm, set `ROCM_PATH=<path>`
environment variable before launching Julia. The `AMDGPU.versioninfo()`
function prints the paths of any libraries found.

!!! note "On Fedora ROCm packages"
    Although not included in the AMD's list of supported Linux distributions,
    Fedora provides its own ROCM packages.
    ```
    sudo dnf install rocminfo rocblas rocfft rocsparse rocsolver rocrand roctracer miopen rocm-hip-devel
    ```

Starting with ROCm 7.14, libraries are installed under a versioned `core-<version>` subdirectory (for example `/opt/rocm/core-7.14/lib`) instead of directly in `/opt/rocm/lib`. AMDGPU.jl handles this automatically by selecting the newest `core-*` directory found under the ROCm root, so keep `ROCM_PATH` pointed at the install root (e.g. `/opt/rocm`) rather than at the versioned subdirectory. A full ("metapackage") install additionally provides a `/opt/rocm/lib` compatibility symlink and needs no special handling; the versioned lookup mainly benefits minimal, GPU-architecture-specific installs that omit that symlink.

## GPU selection and architecture overrides

These also apply with the artifacts, as they are read by the ROCm runtime itself.

Depending on your GPU model and the functionality you want to use, you may have
to force the GPU architecture by setting the `HSA_OVERRIDE_GFX_VERSION`
variable to a compatible version.

You may also have more than one type of GPU, for example a dedicated AMD GPU and an integrated one.
In that case use `AMDGPU.devices()` to find which device they are and set `HIP_VISIBLE_DEVICES` to the specific device you want to use.
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

- With a local ROCm, if you get an error message along the lines of `GLIB_CXX_... not found`,
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
    Libdl.dlopen("/opt/rocm/lib/libhsa-runtime64.so.1")
    ```

Once all of this is setup properly, you should be able to do `using AMDGPU`
successfully.

See the [Quick Start](@ref) documentation for an introduction to using AMDGPU.jl.

## Preferences

AMDGPU.jl supports setting
[preferences](https://github.com/JuliaPackaging/Preferences.jl); see
[Configuration preferences](@ref) for the full list. Template of `LocalPreferences.toml`:

```toml
[ROCm_Runtime]
# Only read when `ROCm_Runtime` is in the `[extras]` of Project.toml (see above).
# Use a local ROCm installation instead of the downloaded artifacts (default is "false").
local = "false"
# ROCm distribution to download (default is the newest one shipped), and the GPU
# architectures to select it for when none can be detected (see above).
# version = "10.1"
# arch = "gfx942"

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
