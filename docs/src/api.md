# AMDGPUnative API Reference

## Kernel launching

```@docs
@roc
AMDGPUnative.AbstractKernel
AMDGPUnative.rocfunction
```

## Device code API

### Thread indexing

#### HSA nomenclature

```@docs
workitemIdx
workgroupIdx
workgroupDim
gridDim
gridDimWG
```

#### CUDA nomenclature

Use these functions for compatibility with CUDAnative.jl.

```@docs
threadIdx
blockIdx
blockDim
```

### Synchronization

```@docs
sync_workgroup
```

