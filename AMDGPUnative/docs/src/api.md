# AMDGPUnative API Reference

## Kernel launching

```@docs
@roc
AMDGPUnative.AbstractKernel
AMDGPUnative.HostKernel
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

### Pointers

```@docs
AMDGPUnative.DevicePtr
```

### Global Variables

```@docs
AMDGPUnative.get_global_pointer
```
