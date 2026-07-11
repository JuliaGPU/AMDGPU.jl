# Introspection and Reflection

AMDGPU.jl mirrors Julia's `code_*` reflection tools for GPU kernels, letting you inspect what a kernel lowers to at each compilation stage. This is the main way to debug performance and codegen issues — for example checking that a kernel stays type-stable or that a hot loop vectorizes.

Each `@device_code_*` macro wraps a kernel launch (`@roc ...`) and prints the corresponding representation instead of running it:

- `@device_code_lowered` — lowered Julia IR.
- `@device_code_typed` — type-inferred Julia IR (use this to spot type instabilities).
- `@device_code_warntype` — type-inferred IR with instabilities highlighted.
- `@device_code_llvm` — the generated LLVM IR.
- `@device_code_gcn` — the final AMD GCN assembly.
- `@device_code` — dump all of the above into a directory.

```julia
using AMDGPU

function vadd!(c, a, b)
    i = workitemIdx().x
    c[i] = a[i] + b[i]
    return
end

a = AMDGPU.ones(Float32, 16); b = AMDGPU.ones(Float32, 16); c = similar(a)

@device_code_warntype @roc groupsize=16 vadd!(c, a, b)
```

The non-macro forms (`AMDGPU.code_typed`, `AMDGPU.code_llvm`, `AMDGPU.code_gcn`, …) take a function and a tuple of argument types directly, mirroring `Base.code_typed` and friends. These reflection tools are inherited from [GPUCompiler.jl](https://github.com/JuliaGPU/GPUCompiler.jl); see its documentation for the full set of options each macro accepts.
