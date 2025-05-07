```@raw html
---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "AMDGPU.jl"
  text: "Programming AMD GPUs with Julia"
  actions:
    - theme: brand
      text: Tutorials
      link: /tutorials
    - theme: alt
      text: API
      link: /api
    - theme: alt
      text: View on GitHub
      link: https://github.com/JuliaGPU/AMDGPU.jl
  image:
    src: /logo.png
    alt: AMDGPU.jl
---
```

## Install

Simply add the AMDGPU.jl package to your Julia environment:

```julia
using Pkg
Pkg.add("AMDGPU")
```

## Requirements

- Julia 1.10+:
- MI300X requires Julia 1.12+.
- 64-bit Linux or Windows.
- ROCm 6.0+.

### Required software

|Linux|Windows|
|:---:|:---:|
|[ROCm](https://rocm.docs.amd.com/en/latest/deploy/linux/quick_start.html)|[ROCm](https://rocm.docs.amd.com/en/latest/deploy/windows/quick_start.html)|
|-|[AMD Software: Adrenalin Edition](https://www.amd.com/en/technologies/software)|

::: info Note

On Windows AMD Software: Adrenalin Edition contains HIP library itself,
while ROCm provides support for other functionality.

:::

## Test

To ensure that everything works, you can run the test suite:

```julia
using AMDGPU
using Pkg
Pkg.test("AMDGPU")
```

## Example

Element-wise addition via high-level interface & low-level kernel:

```@example vadd
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
