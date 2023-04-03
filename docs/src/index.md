# Programming AMD GPUs with Julia

!!! tip
    This documentation assumes that you are familiar with the main concepts of GPU programming and mostly describes the specifics of running Julia code on AMD GPUs.
    For a much more gentle introduction to GPGPU with Julia consult the well-written [CUDA.jl documentation](https://cuda.juliagpu.org/stable/).

## The ROCm stack

ROCm (short for Radeon Open Compute platforM) is AMD's open-source GPU computing platform, supported by most modern AMD GPUs ([detailed hardware support](https://github.com/RadeonOpenCompute/ROCm#hardware-and-software-support)) and some AMD APUs.
ROCm works solely on Linux and no plans to support either Windows or macOS have been announced by AMD.

A necessary prerequisite to use this Julia package is to have a working ROCm stack installed.
A quick way to verify this is to check the output of `rocminfo`.
For more information, consult the official [installation guide](https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html).
Even though the only platforms officially supported by AMD are certain versions of Ubuntu, CentOS, RHEL, and SLES [^1], there are options to install ROCm on other Linux distributions, including:
 * Arch Linux - See the [rocm-arch](https://github.com/rocm-arch/rocm-arch) repository or the slightly older PKGBUILDs in the AUR.
 * Gentoo - Check Portage for the `rocr-runtime` package and [justxi's rocm repo](https://github.com/justxi/rocm) for unofficial ROCm package ebuilds.

[^1]: <https://github.com/RadeonOpenCompute/ROCm/wiki#supported-operating-systems>

## The Julia AMDGPU stack

Julia support for programming AMD GPUs is currently provided by the [AMDGPU.jl package](https://github.com/jpsamaroo/AMDGPU.jl). This package contains everything necessary to program for AMD GPUs in Julia, including:

* An interface for working with the HSA runtime API, necessary for launching compiled kernels and controlling the GPU.
* An interface for compiling and running kernels written in Julia through LLVM's AMDGPU backend.
* An array type implementing the [GPUArrays.jl](https://github.com/JuliaGPU/GPUArrays.jl) interface, providing high-level array operations.

## Required Software

* [ROCT](https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface) (JLL available)
* [ROCR](https://github.com/RadeonOpenCompute/ROCR-Runtime) (JLL available)
* [ROCm-Device-Libs](https://github.com/RadeonOpenCompute/ROCm-Device-Libs) (JLL available)
* [HIP](https://github.com/ROCm-Developer-Tools/HIP) (JLL available)
* Recent Linux kernel with AMDGPU and HSA enabled (Cannot be provided as a JLL)
* `ld.lld` binary provided by system LLVM (No JLL yet)

### Optional Packages

* [rocBLAS](https://github.com/ROCmSoftwarePlatform/rocBLAS) for BLAS support (JLL available)
* [rocFFT](https://github.com/ROCmSoftwarePlatform/rocFFT) for FFT support (No JLL yet)
* [rocRAND](https://github.com/ROCmSoftwarePlatform/rocRAND) for RNG support (JLL available)
* [MIOpen](https://github.com/ROCmSoftwarePlatform/MIOpen) for DNN support (JLL available on Julia 1.9)

Other ROCm packages are currently unused by AMDGPU.

### JLL usage

By default, AMDGPU provides and uses JLL packages for core libraries,
so as long as `ld.lld` is available, you should be all set for most basic functionality.
For example, Julia 1.9 provides ROCm 5.2.3 libraries.

If this does not work for you, or if you have a full ROCm installation available
on your system (common for HPC/supercomputer users),
you can set the `JULIA_AMDGPU_DISABLE_ARTIFACTS` environment variable to "1"
to disable usage of JLL artifacts:

```bash
JULIA_AMDGPU_DISABLE_ARTIFACTS=1 julia --project=.
```

Note that currently ROCm-Device-Libs are always provided by AMDGPU to ensure
compatibility with Julia's version of LLVM; please file an issue if this is
problematic on your system.

!!! note "LLVM compatibility"
    For proper support, Julia's LLVM version should match ROCm LLVM's version.
    For example, Julia 1.9 relies on LLVM 14,
    so the matching ROCm version is `5.2.x`.

### Extra Setup Details

Currently, the requirements to get everything working properly is a bit poorly
documented in the upstream docs for any distro other than Ubuntu.
So here is a list of requirements I've found through the process of making this work:

- Make sure `/dev/kfd` has a group other than root that you can add your user to.
    I recommend adding your user to the `video` group, and setting the
    ownership of `/dev/kfd` to `root:video` with `660` permissions.

- These libraries should be in the standard library locations, or in your `LD_LIBRARY_PATH`:
    * libhsakmt.so
    * libhsa-runtime64.so.1
    * libamdhip64.so

- And `ld.lld` should be in your `PATH`.

In terms of Linux kernel versions, just pick the newest one you can. If
building your own kernel, make sure all the regular AMDGPU and HSA options are
enabled.

Once all of this is setup properly, you should be able to do `using AMDGPU`
successfully. See the Quickstart documentation for an introduction to using
AMDGPU.jl.

#### Navi 2 (GFX103x) support

ROCm stack officially supports only GFX1030 (6900XT).
However, the ISA between GFX103x devices is nearly identical (if not identical).

Therefore, if you have any other GFX103x device,
you can override your gfx version with `HSA_OVERRIDE_GFX_VERSION=10.3.0` env variable
before launching Julia and be able to use your device:

```bash
HSA_OVERRIDE_GFX_VERSION=10.3.0 julia --project=.
```
