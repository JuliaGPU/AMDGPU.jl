---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "AMDGPU.jl"
  text: "Programming AMD GPUs with Julia"
  actions:
    - theme: brand
      text: Getting Started
      link: /tutorials/quickstart
    - theme: alt
      text: API
      link: /api/devices
    - theme: alt
      text: View on GitHub
      link: https://github.com/JuliaGPU/AMDGPU.jl
  image:
    src: /logo.png
    alt: AMDGPU.jl
---


## Install {#Install}

Simply add the AMDGPU.jl package to your Julia environment:

```julia
using Pkg
Pkg.add("AMDGPU")
```


## Requirements {#Requirements}
- Julia 1.10+
  
- MI300X requires Julia 1.12+
  
- 64-bit Linux or Windows
  
- ROCm 6.0+
  

### Required software {#Required-software}

|                                   Linux                                   |                                     Windows                                     |
|:-------------------------------------------------------------------------:|:-------------------------------------------------------------------------------:|
| [ROCm](https://rocm.docs.amd.com/en/latest/deploy/linux/quick_start.html) |   [ROCm](https://rocm.docs.amd.com/en/latest/deploy/windows/quick_start.html)   |
|                                     -                                     | [AMD Software: Adrenalin Edition](https://www.amd.com/en/technologies/software) |


::: tip On Windows AMD Software

Adrenalin Edition contains HIP library itself, while ROCm provides support for other functionality.

:::

## Test {#Test}

To ensure that everything works, you can run the test suite:

```julia
using AMDGPU
using Pkg
Pkg.test("AMDGPU")
```


## Example {#Example}

Element-wise addition via high-level interface &amp; low-level kernel:

```julia
using AMDGPU

function vadd!(c, a, b)
   i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
   if i ≤ length(a)
       c[i] = a[i] + b[i]
   end
   return
end

a = AMDGPU.ones(Int, 1024)
b = AMDGPU.ones(Int, 1024)
c = AMDGPU.zeros(Int, 1024)

groupsize = 256
gridsize = cld(length(c), groupsize)
@roc groupsize=groupsize gridsize=gridsize vadd!(c, a, b)

@assert (a .+ b) ≈ c
```


## Questions and Contributions {#Questions-and-Contributions}

Usage questions can be posted on the [Julia Discourse forum](https://discourse.julialang.org/c/domain/gpu) under the GPU domain and/or in the `#gpu` channel of the [Julia Slack](https://julialang.org/community/).

Contributions are very welcome, as are feature requests and suggestions. Please open an [issue](https://github.com/JuliaGPU/AMDGPU.jl/issues) if you encounter any problems.

## Acknowledgment {#Acknowledgment}

AMDGPU.jl would not have been possible without the work by Tim Besard and contributors to [CUDA.jl](https://github.com/JuliaGPU/CUDA.jl) and [LLVM.jl](https://github.com/maleadt/LLVM.jl).

## License {#License}

AMDGPU.jl is licensed under the [MIT License](https://github.com/JuliaGPU/AMDGPU.jl/blob/master/LICENSE.md).
