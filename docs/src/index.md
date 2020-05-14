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

Julia support for programming AMD GPUs is currently provided by the following three packages:

* [HSARuntime.jl](https://github.com/jpsamaroo/HSARuntime.jl) - Provides an interface for working with the HSA runtime API, necessary for launching compiled kernels and controlling the GPU.
* [AMDGPUnative.jl](https://github.com/JuliaGPU/AMDGPUnative.jl) - Provides an interface for compiling and running kernels written in Julia through LLVM's AMDGPU backend. Uses and depends on HSARuntime.jl.
* [ROCArrays.jl](https://github.com/jpsamaroo/ROCArrays.jl) - Implements the [GPUArrays.jl](https://github.com/JuliaGPU/GPUArrays.jl) interface, providing high-level array operations on top of AMDGPUnative.jl.

