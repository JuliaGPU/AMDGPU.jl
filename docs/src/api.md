# AMDGPU API Reference

## Kernel launching

```@docs
@roc
AMDGPU.AbstractKernel
AMDGPU.HostKernel
AMDGPU.rocfunction
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
AMDGPU.DevicePtr
```

### Global Variables

```@docs
AMDGPU.get_global_pointer
```
