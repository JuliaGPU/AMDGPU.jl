# AMDGPU API Reference

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
