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
AMDGPU.Device.workitemIdx
AMDGPU.Device.workgroupIdx
AMDGPU.Device.workgroupDim
AMDGPU.Device.gridDim
AMDGPU.Device.gridDimWG
```

#### CUDA nomenclature

Use these functions for compatibility with CUDAnative.jl.

```@docs
AMDGPU.Device.threadIdx
AMDGPU.Device.blockIdx
AMDGPU.Device.blockDim
```

### Synchronization

```@docs
AMDGPU.Device.sync_workgroup
```

### Global Variables

```@docs
AMDGPU.Device.get_global_pointer
```
