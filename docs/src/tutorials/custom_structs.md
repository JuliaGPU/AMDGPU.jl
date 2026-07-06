# Using Custom Structs in Kernels

Kernels often need more than plain arrays — you may want to pass your own struct bundling several arrays and parameters. The difficulty is that a `ROCArray` lives in host memory management, but inside a kernel it must appear as a device array (`ROCDeviceArray`). AMDGPU.jl handles this conversion automatically for arguments to `@roc`, using [Adapt.jl](https://github.com/JuliaGPU/Adapt.jl) to reach *inside* your struct and convert its array fields.

Declare how your struct should be adapted with `Adapt.@adapt_structure`, then pass an instance to a kernel like any other argument:

```julia
using AMDGPU, Adapt

struct Model{A}
    weights::A
    scale::Float32
end
Adapt.@adapt_structure Model

function apply!(out, m)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    if i <= length(out)
        out[i] = m.weights[i] * m.scale
    end
    return
end

w = AMDGPU.ones(Float32, 16)
m = Model(w, 3f0)
out = AMDGPU.zeros(Float32, 16)

@roc groupsize=16 apply!(out, m)   # out .== 3.0
```

`@adapt_structure` generates the rule that rebuilds `Model` with each field adapted. When `@roc` launches the kernel it calls `AMDGPU.rocconvert` on `m`, which turns the `weights::ROCArray` field into a `ROCDeviceArray` while leaving `scale` untouched. Inside the kernel `m.weights` is therefore a device array you can index directly.

The type parameter `A` matters: it lets the struct hold a `ROCArray` on the host and a `ROCDeviceArray` on the device without you writing two types. Keep the remaining fields `isbits` (numbers, tuples, other adapted structs) so the whole struct can be passed to the GPU.
