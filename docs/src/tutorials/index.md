```@meta
DocTestSetup = quote
    using AMDGPU
end
```

# Quick Start

## Simple example

As a simple example, let's add two vectors both on CPU and GPU
and make sure that the results are the same:

First, we do this on CPU:

```jldoctest simple-example
julia> n = 1024;

julia> a = fill(1.0, n);

julia> b = fill(2.0, n);

julia> c = a .+ b;
```

To do the same computation on the GPU, we first need to copy the
host arrays to the device and then simply add them together element-wise:

```jldoctest simple-example
julia> a_d = ROCArray(a);

julia> b_d = ROCArray(b);

julia> c_d = a_d .+ b_d;
```

Now, let's check that the results are the same on CPU and GPU by
transferring GPU array back to host and comparing the results:

```jldoctest simple-example
julia> Array(c_d) ≈ c
true
```

## Kernel example

Alternatively, we can perform the same computation by writing our custom
GPU kernel:

```jldoctest simple-example
julia> function vadd!(c, a, b)
           i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
           c[i] = a[i] + b[i]
           return
       end
vadd! (generic function with 1 method)
```

The index `i` of a single workitem can be uniquely identified by its grid index.
In this case only one dimension is used, so we take only `.x` coordinate
into account.

A kernel is compiled upon its first launch.
Subsequent launches re-use it, without recompilation.
Let's launch a kernel, but first clear-out the memory of the resulting vector `cd`.

```jldoctest simple-example
julia> fill!(c_d, 0.0);

julia> groupsize = 256;

julia> gridsize = cld(n, groupsize);

julia> @roc groupsize=groupsize gridsize=gridsize vadd!(c_d, a_d, b_d);

julia> Array(c_d) ≈ c
true
```

The easiest way to launch a GPU kernel is with the `@roc` macro,
specifying `groupsize` and `gridsize` to cover full array,
and calling it like a regular function.

Keep in mind that kernel launches are asynchronous,
meaning that you need to synchronize before you can use the result
(e.g. with [`AMDGPU.synchronize`](@ref)).
However, GPU <-> CPU transfers synchronize implicitly.

The grid is the domain over which the *entire* kernel executes over.
The grid will be split into multiple workgroups by hardware automatically,
and the kernel does not complete until all workgroups complete.

Like OpenCL, AMDGPU has the concept of "workitems", "workgroups", and the "grid".
A workitem is a single thread of execution, capable of performing arithmentic
operations.
Workitems are grouped into "wavefronts" ("warps" in CUDA) which
share the same compute unit, and execute the same instructions simulatenously.
The workgroup is a logical unit of compute supported by hardware
which comprises multiple wavefronts, which shares resources
(specifically local memory) and can be efficiently synchronized.
A workgroup may be executed by one or multiple hardware compute units,
making it often the only dimension of importance for smaller kernel launches.

Notice how we explicitly specify that this function does not return a value
by adding the `return` statement.
This is necessary for all GPU kernels and we can enforce it by adding a `return`,
`return nothing`, or even `nothing` at the end of the kernel.
If this statement is omitted, Julia will attempt to return the value
of the last evaluated expression, in this case a `Float64`,
which will cause a compilation failure as kernels cannot return values.

## Naming conventions

Throughout this example we use terms like "work group" and "work item".
These terms are used by the Khronos consortium and their APIs
including OpenCL and Vulkan, as well as the HSA foundation.

NVIDIA, on the other hand, uses some different terms in their CUDA API,
which might be confusing to some users porting their kernels from CUDA to AMDGPU.

As a quick summary, here is a mapping of the most common terms:

| AMDGPU | CUDA |
|:---:|:---:|
| [`workitemIdx`](@ref) | `threadIdx` |
| [`workgroupIdx`](@ref) | `blockIdx` |
| [`workgroupDim`](@ref) | `blockDim` |
| [`gridItemDim`](@ref) | No equivalent |
| [`gridGroupDim`](@ref) | `gridDim` |
| `groupsize` | `threads` |
| `gridsize` | `blocks` |
| `stream` | `stream` |
