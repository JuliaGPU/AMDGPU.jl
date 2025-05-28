
# Intrinsics {#Intrinsics}

API Reference

## Indexing {#Indexing}
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.workitemIdx' href='#AMDGPU.Device.workitemIdx'><span class="jlbinding">AMDGPU.Device.workitemIdx</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
workitemIdx()::ROCDim3
```


Returns the work item index within the work group. See also: [`threadIdx`](/api/intrinsics#AMDGPU.Device.threadIdx)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L116-L121" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.workgroupIdx' href='#AMDGPU.Device.workgroupIdx'><span class="jlbinding">AMDGPU.Device.workgroupIdx</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
workgroupIdx()::ROCDim3
```


Returns the work group index. See also: [`blockIdx`](/api/intrinsics#AMDGPU.Device.blockIdx)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L124-L129" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.workgroupDim' href='#AMDGPU.Device.workgroupDim'><span class="jlbinding">AMDGPU.Device.workgroupDim</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
workgroupDim()::ROCDim3
```


Returns the size of each workgroup in workitems. See also: [`blockDim`](/api/intrinsics#AMDGPU.Device.blockDim)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L132-L137" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.gridItemDim' href='#AMDGPU.Device.gridItemDim'><span class="jlbinding">AMDGPU.Device.gridItemDim</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
gridItemDim()::ROCDim3
```


Returns the size of the grid in workitems. This behaviour is different from CUDA where `gridDim` gives the size of the grid in blocks.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L140-L145" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.gridGroupDim' href='#AMDGPU.Device.gridGroupDim'><span class="jlbinding">AMDGPU.Device.gridGroupDim</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
gridGroupDim()::ROCDim3
```


Returns the size of the grid in workgroups. This is equivalent to CUDA&#39;s `gridDim`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L148-L153" target="_blank" rel="noreferrer">source</a></Badge>

</details>


Use these functions for compatibility with CUDA.jl.
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.threadIdx' href='#AMDGPU.Device.threadIdx'><span class="jlbinding">AMDGPU.Device.threadIdx</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
threadIdx()::ROCDim3
```


Returns the thread index within the block. See also: [`workitemIdx`](/api/intrinsics#AMDGPU.Device.workitemIdx)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L158-L163" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.blockIdx' href='#AMDGPU.Device.blockIdx'><span class="jlbinding">AMDGPU.Device.blockIdx</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
blockIdx()::ROCDim3
```


Returns the block index within the grid. See also: [`workgroupIdx`](/api/intrinsics#AMDGPU.Device.workgroupIdx)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L166-L171" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.blockDim' href='#AMDGPU.Device.blockDim'><span class="jlbinding">AMDGPU.Device.blockDim</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
blockDim()::ROCDim3
```


Returns the dimensions of the block. See also: [`workgroupDim`](/api/intrinsics#AMDGPU.Device.workgroupDim)


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/indexing.jl#L174-L179" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Synchronization {#Synchronization}
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.sync_workgroup' href='#AMDGPU.Device.sync_workgroup'><span class="jlbinding">AMDGPU.Device.sync_workgroup</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
sync_workgroup()
```


Waits until all wavefronts in a workgroup have reached this call.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/synchronization.jl#L1-L5" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.sync_workgroup_count' href='#AMDGPU.Device.sync_workgroup_count'><span class="jlbinding">AMDGPU.Device.sync_workgroup_count</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
sync_workgroup_count(predicate::Cint)::Cint
```


Identical to `sync_workgroup`, with the additional feature that it evaluates the predicate for all workitems in the workgroup and returns the number of workitems for which predicate evaluates to non-zero.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/synchronization.jl#L9-L15" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.sync_workgroup_and' href='#AMDGPU.Device.sync_workgroup_and'><span class="jlbinding">AMDGPU.Device.sync_workgroup_and</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
sync_workgroup_and(predicate::Cint)::Cint
```


Identical to `sync_workgroup`, with the additional feature that it evaluates the predicate for all workitems in the workgroup and returns non-zero if and only if predicate evaluates to non-zero for all of them.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/synchronization.jl#L22-L28" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.sync_workgroup_or' href='#AMDGPU.Device.sync_workgroup_or'><span class="jlbinding">AMDGPU.Device.sync_workgroup_or</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
sync_workgroup_or(predicate::Cint)::Cint
```


Identical to `sync_workgroup`, with the additional feature that it evaluates the predicate for all workitems in the workgroup and returns non-zero if and only if predicate evaluates to non-zero for any of them.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/synchronization.jl#L35-L41" target="_blank" rel="noreferrer">source</a></Badge>

</details>

