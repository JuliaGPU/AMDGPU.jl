# KernelAbstractions

[KernelAbstractions.jl](https://github.com/JuliaGPU/KernelAbstractions.jl) lets you write a single kernel that runs on CPUs and on all supported GPU backends. AMDGPU.jl provides the `ROCBackend` for it, so KernelAbstractions is the recommended way to write **portable** kernels — code that works unchanged on AMDGPU, CUDA, and others.

KernelAbstractions is a separate package; add it alongside AMDGPU:

```julia
using Pkg
Pkg.add("KernelAbstractions")
```

Write kernels with the `@kernel` macro and index them with `@index` instead of the AMDGPU-specific `workitemIdx`/`workgroupIdx` intrinsics:

```julia
using AMDGPU
using KernelAbstractions

@kernel function vadd!(c, a, b)
    i = @index(Global)
    c[i] = a[i] + b[i]
end

a = AMDGPU.ones(Float32, 1024)
b = AMDGPU.ones(Float32, 1024)
c = similar(a)

backend = ROCBackend()
vadd!(backend, 256)(c, a, b; ndrange = length(c))
KernelAbstractions.synchronize(backend)
```

`ROCBackend()` selects AMDGPU as the execution backend. The `256` is the workgroup size, and `ndrange` is the total number of work items. `get_backend(::ROCArray)` returns a `ROCBackend`, so generic code can obtain the right backend directly from its arrays.

For the kernel-authoring API (`@kernel`, `@index`, `@localmem`, `@synchronize`, …), see the [KernelAbstractions documentation](https://juliagpu.github.io/KernelAbstractions.jl/stable/). To write AMDGPU-specific kernels with the native intrinsics instead, see [Kernel Programming](@ref).

```@docs
AMDGPU.ROCBackend
```
