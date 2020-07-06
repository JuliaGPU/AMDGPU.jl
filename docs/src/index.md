# Programming AMD GPUs with Julia

!!! tip
    This documentation assumes that you are familiar with the main concepts of GPU programming and mostly describes the specifics of running Julia code on AMD GPUs.
    For a much more gentle introduction to GPGPU with Julia consult the well-written [CUDA.jl documentation](https://juliagpu.gitlab.io/CUDA.jl).

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

Even though you don't need HIP to use Julia on AMDGPU, it might be wise to make sure that you can build and run simple HIP programs to ensure that your ROCm installation works properly before trying to use it from Julia.

## The Julia AMDGPU stack

Julia support for programming AMD GPUs is currently provided by the [AMDGPU.jl package](https://github.com/jpsamaroo/AMDGPU.jl). This package contains everything necessary to program for AMD GPUs in Julia, including:

* An interface for working with the HSA runtime API, necessary for launching compiled kernels and controlling the GPU.
* An interface for compiling and running kernels written in Julia through LLVM's AMDGPU backend.
* An array type implementing the [GPUArrays.jl](https://github.com/JuliaGPU/GPUArrays.jl) interface, providing high-level array operations.

## Requirements
* [ROCR](https://github.com/RadeonOpenCompute/ROCR-Runtime)
* [ROCT](https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface)
* Recent Linux kernel with AMDGPU and HSA enabled

### Setup Instructions
Currently, the requirements to get everything working properly is a bit poorly
documented in the upstream docs for any distro other than Ubuntu.  So here is a
list of requirements I've found through the process of making this work:

Make sure /dev/kfd has a group other than root that you can add your user to.
I recommend adding your user to the "video" group, and setting the
ownership of /dev/kfd to root:video with 660 permissions.

The correct libraries in your LD_LIBRARY_PATH or standard library locations:
* libhsa-runtime64.so
* libhsakmt.so

In terms of Linux kernel versions, just pick the newest one you can. If
building your own kernel, make sure all the regular AMDGPU and HSA options are
enabled.

You will also need `ld.lld` installed on your system (provided by LLVM/Clang);
if you built Julia from source, you should have a copy somewhere in
`deps/scratch/llvm-*/*/bin/` that you can add to your PATH.

Once all of this is setup properly, you should be able to `] build AMDGPU`
successfully; after that, if you have a supported GPU attached and enabled, `]
test AMDGPU` should work exactly as you might expect.
