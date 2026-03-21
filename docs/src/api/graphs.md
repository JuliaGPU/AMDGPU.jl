# Graphs

[Graphs](https://rocm.docs.amd.com/projects/HIP/en/latest/how-to/hip_runtime_api/hipgraph.html)
allow capturing GPU kernels and executing them as one unit, reducing host overhead.

Simple operations can be captured as is:

```@example graph-1
using AMDGPU

f!(o) = o .+= 1f0

z = AMDGPU.zeros(Int, 4, 4)
graph = AMDGPU.@captured f!(z)
@assert sum(z) == 16

AMDGPU.launch(graph)
@assert sum(z) == 16 * 2
```

However, if your code contains more complex flow, it requires more preparations:
- if code contains malloc and respective frees, then it can be captured and relaunched as is.
- if code contains **only** allocations (without freeing), allocations must be cached with `GPUArrays.@cached` beforehand (see example below).
- other unsupported operations (e.g. RNG init) must be done beforehand as well.
- updating graph, does not update allocated pointers, only instantiation is supported in such cases.

```@example graph-2
using AMDGPU, GPUArrays

function f(o)
    x = AMDGPU.rand(Float32, size(o))
    y = AMDGPU.rand(Float32, size(o))
    o .+= sin.(x) * cos.(y) .+ 1f0
    return
end

cache = GPUArrays.AllocCache()
z = AMDGPU.zeros(Float32, 256, 256)
N = 10

# Execute function normally and cache all allocations.
GPUArrays.@cached cache f(z)

# Capture graph using AllocCache to avoid capturing malloc/free calls.
graph = GPUArrays.@cached cache AMDGPU.@captured f(z)

# Allocations cache must be kept alive while executing graph.
for i in 1:N
    AMDGPU.launch(graph)
end
AMDGPU.synchronize()
```

```@docs
AMDGPU.capture
AMDGPU.@captured
AMDGPU.instantiate
AMDGPU.update
AMDGPU.is_capturing
AMDGPU.launch
```
