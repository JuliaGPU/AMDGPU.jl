# Quick Start

## Running a simple kernel

As a simple test, we will try to add two random vectors
and make sure that the results from the CPU and the GPU are indeed the same.

We can start by first performing this simple calculation on the CPU:

```julia
N = 1024
a = rand(Float64, N)
b = rand(Float64, N)
c_cpu = a + b
```

To do the same computation on the GPU, we first need to copy
the two input arrays `a` and `b` to the device.
Toward that end, we will use the `ROCArray` type to represent our GPU arrays.
We can create the two arrays by passing the host data
to the constructor as follows:

```julia
using AMDGPU
a_d = ROCArray(a)
b_d = ROCArray(b)
```

We need to create one additional array `c_d` to store the results:

```julia
c_d = similar(a_d)
```

In this example, the postfix `_d` distinguishes a device memory object
from its host memory counterpart.
This convention is completely arbitrary and you may name your
device-side variables whatever you like; they are regular Julia variables.

Next, we will define the GPU kernel that does the actual computation:

```julia
function vadd!(c, a, b)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    c[i] = a[i] + b[i]
    return
end
```

The index of a single workitem can be uniquely identified by its grid index
(computed linearly as `(workgroupDim().x * (workgroupIdx().x - 1)) + workitemIdx().x`
when only a single dimension is used).

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

The easiest way to launch a GPU kernel is with the `@roc` macro,
specifying `groupsize` and `gridsize` to cover full array,
and calling it like a regular function:

```julia
groupsize = 128
gridsize = cld(length(c_d), groupsize)
@roc gridsize=gridsize groupsize=groupsize vadd!(c_d, a_d, b_d)
```

Keep in mind that kernel launches are asynchronous,
meaning that you need to do some kind of synchronization before you use the result.
For instance, you can call `AMDGPU.synchronize()`:

```julia
@roc groupsize=N vadd!(c_d, a_d, b_d)
AMDGPU.synchronize()
```

Finally, we can make sure that the results match,
by first copying the data to the host and then comparing it with the CPU results:

```julia
c = Array(c_d)

using Test
@test isapprox(c, c_cpu)
```

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

!!! warning
    Since AMDGPU v0.5.0 `gridsize` represents the number of "workgroups"
    (or `blocks` in CUDA) and no longer "workitems * workgroups"
    (or `threads * blocks` in CUDA).
