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
AMDGPU.workitemIdx
AMDGPU.workgroupIdx
AMDGPU.workgroupDim
AMDGPU.gridItemDim
AMDGPU.gridGroupDim
```

#### CUDA nomenclature

Use these functions for compatibility with CUDA.jl.

```@docs
AMDGPU.Device.threadIdx
AMDGPU.Device.blockIdx
AMDGPU.Device.blockDim
```

### Synchronization

```@docs
AMDGPU.sync_workgroup
```

### Global Variables

```@docs
AMDGPU.Device.get_global_pointer
```
