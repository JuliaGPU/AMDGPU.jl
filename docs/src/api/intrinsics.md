# AMDGPU API Reference

## Indexing

```@docs
AMDGPU.workitemIdx
AMDGPU.workgroupIdx
AMDGPU.workgroupDim
AMDGPU.gridItemDim
AMDGPU.gridGroupDim
```

Use these functions for compatibility with CUDA.jl.

```@docs
AMDGPU.Device.threadIdx
AMDGPU.Device.blockIdx
AMDGPU.Device.blockDim
```

## Synchronization

```@docs
AMDGPU.sync_workgroup
AMDGPU.sync_workgroup_count
AMDGPU.sync_workgroup_and
AMDGPU.sync_workgroup_or
```
