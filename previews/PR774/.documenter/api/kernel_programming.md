
# Kernel Programming {#Kernel-Programming}

## Launch Configuration {#Launch-Configuration}

While an almost arbitrarily large number of workitems can be executed per kernel launch, the hardware can only support executing a limited number of wavefronts at one time.

To alleviate this, the compiler calculates the &quot;occupancy&quot; of each compiled kernel (which is the number of wavefronts that can be simultaneously executing on the GPU), and passes this information to the hardware; the hardware then launches a limited number of wavefronts at once, based on the kernel&#39;s &quot;occupancy&quot; values.

The rest of the wavefronts are not launched until hardware resources become available, which means that a kernel with better occupancy will see more of its wavefronts executing simultaneously (which often leads to better performance). Suffice to say, it&#39;s important to know the occupancy of kernels if you want the best performance.

Like CUDA.jl, AMDGPU.jl has the ability to calculate kernel occupancy, with the `launch_configuration` function:

```julia
kernel = @roc launch=false mykernel(args...)
occupancy = AMDGPU.launch_configuration(kernel)
@show occupancy.gridsize
@show occupancy.groupsize
```


Specifically, `launch_configuration` calculates the occupancy of `mykernel(args...)`, and then calculates an optimal groupsize based on the occupancy. This value can then be used to select the groupsize for the kernel:

```julia
@roc groupsize=occupancy.groupsize mykernel(args...)
```

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.@roc' href='#AMDGPU.@roc'><span class="jlbinding">AMDGPU.@roc</span></a> <Badge type="info" class="jlObjectType jlMacro" text="Macro" /></summary>



```julia
@roc [kwargs...] func(args...)
```


High-level interface for launching kernels on GPU. Upon a first call it will be compiled, subsequent calls will re-use the compiled object.

Several keyword arguments are supported:
- `launch::Bool = true`: whether to launch the kernel.   If `false`, then returns a compiled kernel which can be launched by   calling it and passing arguments.
  
- Arguments that influence kernel compilation, see   [`AMDGPU.Compiler.hipfunction`](/api/kernel_programming#AMDGPU.Compiler.hipfunction).
  
- Arguments that influence kernel launch, see [`AMDGPU.Runtime.HIPKernel`](/api/kernel_programming#AMDGPU.Runtime.HIPKernel).
  


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/highlevel.jl#L99-L113" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Runtime.HIPKernel' href='#AMDGPU.Runtime.HIPKernel'><span class="jlbinding">AMDGPU.Runtime.HIPKernel</span></a> <Badge type="info" class="jlObjectType jlType" text="Type" /></summary>



```julia
(ker::HIPKernel)(args::Vararg{Any, N}; kwargs...)
```


Launch compiled HIPKernel by passing arguments to it.

The following kwargs are supported:
- `gridsize::ROCDim = 1`: Size of the grid.
  
- `groupsize::ROCDim = 1`:  Size of the workgroup.
  
- `shmem::Integer = 0`:   Amount of dynamically-allocated shared memory in bytes.
  
- `stream::HIP.HIPStream = AMDGPU.stream()`:   Stream on which to launch the kernel.
  


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/runtime/hip-execution.jl#L1-L13" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Compiler.hipfunction' href='#AMDGPU.Compiler.hipfunction'><span class="jlbinding">AMDGPU.Compiler.hipfunction</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
hipfunction(f::F, tt::TT = Tuple{}; kwargs...)
```


Compile Julia function `f` to a HIP kernel given a tuple of argument&#39;s types `tt` that it accepts.

The following kwargs are supported:
- `name::Union{String, Nothing} = nothing`:   A unique name to give a compiled kernel.
  
- `unsafe_fp_atomics::Bool = true`:   Whether to use &#39;unsafe&#39; floating-point atomics.   AMD GPU devices support fast atomic read-modify-write (RMW)   operations on floating-point values.   On single- or double-precision floating-point values this may generate   a hardware RMW instruction that is faster than emulating   the atomic operation using an atomic compare-and-swap (CAS) loop.
  


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/compiler/codegen.jl#L136-L153" target="_blank" rel="noreferrer">source</a></Badge>

</details>


## Atomics {#Atomics}

AMDGPU.jl relies on [Atomix.jl](https://github.com/JuliaConcurrent/Atomix.jl) for atomics.

Example of a kernel that computes atomic max:

```julia
using AMDGPU

function ker_atomic_max!(target, source, indices)
    i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
    idx = indices[i]
    v = source[i]
    AMDGPU.@atomic max(target[idx], v)
    return
end

n, bins = 1024, 32
source = ROCArray(rand(UInt32, n))
indices = ROCArray(rand(1:bins, n))
target = ROCArray(zeros(UInt32, bins))
@roc groupsize=256 gridsize=4 ker_atomic_max!(target, source, indices)
```


## Device Intrinsics {#Device-Intrinsics}

### Wavefront-Level Primitives {#Wavefront-Level-Primitives}
<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.wavefrontsize' href='#AMDGPU.Device.wavefrontsize'><span class="jlbinding">AMDGPU.Device.wavefrontsize</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
wavefrontsize()::Cuint
```


Get the wavefront size of the device that executes current kernel.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L79-L83" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.activelane' href='#AMDGPU.Device.activelane'><span class="jlbinding">AMDGPU.Device.activelane</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
activelane()::Cuint
```


Get id of the current lane within a wavefront/warp.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = i
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Array(x)
1×8 Matrix{Int32}:
 0  1  2  3  4  5  6  7
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L86-L107" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.ballot' href='#AMDGPU.Device.ballot'><span class="jlbinding">AMDGPU.Device.ballot</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
ballot(predicate::Bool)::UInt64
```


Return a value whose `N`th bit is set if and only if `predicate` evaluates to `true` for the `N`th lane and the lane is active.

```julia
julia> function ker!(x)
           x[1] = AMDGPU.Device.ballot(true)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Culong}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{UInt64, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 0x00000000ffffffff
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L110-L131" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.ballot_sync' href='#AMDGPU.Device.ballot_sync'><span class="jlbinding">AMDGPU.Device.ballot_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
ballot_sync(mask::UInt64, predicate::Bool)::UInt64
```


Evaluate `predicate` for all non-exited threads in `mask` and return an integer whose Nth bit is set if and only if `predicate` is `true` for the Nth thread of the wavefront and the Nth thread is active.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.ballot_sync(mask, true)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt64}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> bitstring(Array(x)[1])
"0000000000000000000000000000000001010101010101010101010101010101"
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L16-L41" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.activemask' href='#AMDGPU.Device.activemask'><span class="jlbinding">AMDGPU.Device.activemask</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
activemask()::UInt64
```


Get the mask of all active lanes in a warp.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L140-L144" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.bpermute' href='#AMDGPU.Device.bpermute'><span class="jlbinding">AMDGPU.Device.bpermute</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
bpermute(addr::Integer, val::Cint)::Cint
```


Read data stored in `val` from the lane VGPR (vector general purpose register) given by `addr`.

The permute instruction moves data between lanes but still uses the notion of byte addressing, as do other LDS instructions. Hence, the value in the `addr` VGPR should be `desired_lane_id * 4`, since VGPR values are 4 bytes wide.

Example below shifts all values in the wavefront by 1 to the &quot;left&quot;.

```julia
julia> function ker!(x)
           i::Cint = AMDGPU.Device.activelane()
           # `addr` points to the next immediate lane.
           addr = ((i + 1) % 8) * 4 # VGPRs are 4 bytes wide
           # Read data from the next immediate lane.
           x[i + 1] = AMDGPU.Device.bpermute(addr, i)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int32, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  0
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L147-L179" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.permute' href='#AMDGPU.Device.permute'><span class="jlbinding">AMDGPU.Device.permute</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
permute(addr::Integer, val::Cint)::Cint
```


Put data stored in `val` to the lane VGPR (vector general purpose register) given by `addr`.

Example below shifts all values in the wavefront by 1 to the &quot;right&quot;.

```julia
julia> function ker!(x)
           i::Cint = AMDGPU.Device.activelane()
           # `addr` points to the next immediate lane.
           addr = ((i + 1) % 8) * 4 # VGPRs are 4 bytes wide
           # Put data into the next immediate lane.
           x[i + 1] = AMDGPU.Device.permute(addr, i)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Cint}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int32, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 7  0  1  2  3  4  5  6
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L183-L210" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl' href='#AMDGPU.Device.shfl'><span class="jlbinding">AMDGPU.Device.shfl</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl(val, lane, width = wavefrontsize())
```


Read data stored in `val` from a `lane` (this is a more high-level op than [`bpermute`](/api/kernel_programming#AMDGPU.Device.bpermute)).

If `lane` is outside the range `[0:width - 1]`, the value returned corresponds to the value held by the `lane modulo width` (within the same subsection).

```julia
julia> function ker!(x)
           i::UInt32 = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl(i, i + 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt32}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Int.(x)
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  0
```


If `width` is less than wavefront size then each subsection of the wavefront behaves as a separate entity with a starting logical lane ID of 0.

```julia
julia> function ker!(x)
           i::UInt32 = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl(i, i + 1, 4) # <-- Notice width = 4.
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{UInt32}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> Int.(x)
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  0  5  6  7  4
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L264-L309" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_sync' href='#AMDGPU.Device.shfl_sync'><span class="jlbinding">AMDGPU.Device.shfl_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_sync(mask::UInt64, val, lane, width = wavefrontsize())
```


Synchronize threads according to a `mask` and read data stored in `val` from a `lane` ID.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L103-L108" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_up' href='#AMDGPU.Device.shfl_up'><span class="jlbinding">AMDGPU.Device.shfl_up</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_up(val, δ, width = wavefrontsize())
```


Same as [`shfl`](/api/kernel_programming#AMDGPU.Device.shfl), but instead of specifying lane ID, accepts `δ` that is subtracted from the current lane ID. I.e. read from a lane with lower ID relative to the caller.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_up(i, 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 0  0  1  2  3  4  5  6
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L312-L335" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_up_sync' href='#AMDGPU.Device.shfl_up_sync'><span class="jlbinding">AMDGPU.Device.shfl_up_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_up_sync(mask::UInt64, val, δ, width = wavefrontsize())
```


Synchronize threads according to a `mask` and read data stored in `val` from a `lane` with lower ID relative to the caller.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L114-L119" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_down' href='#AMDGPU.Device.shfl_down'><span class="jlbinding">AMDGPU.Device.shfl_down</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_down(val, δ, width = wavefrontsize())
```


Same as [`shfl`](/api/kernel_programming#AMDGPU.Device.shfl), but instead of specifying lane ID, accepts `δ` that is added to the current lane ID. I.e. read from a lane with higher ID relative to the caller.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_down(i, 1, 8)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  2  3  4  5  6  7  7
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L338-L361" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_down_sync' href='#AMDGPU.Device.shfl_down_sync'><span class="jlbinding">AMDGPU.Device.shfl_down_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_down_sync(mask::UInt64, val, δ, width = wavefrontsize())
```


Synchronize threads according to a `mask` and read data stored in `val` from a `lane` with higher ID relative to the caller.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L125-L130" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_xor' href='#AMDGPU.Device.shfl_xor'><span class="jlbinding">AMDGPU.Device.shfl_xor</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_xor(val, lane_mask, width = wavefrontsize())
```


Same as [`shfl`](/api/kernel_programming#AMDGPU.Device.shfl), but instead of specifying lane ID, performs bitwise XOR of the caller&#39;s lane ID with the `lane_mask`.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           x[i + 1] = AMDGPU.Device.shfl_xor(i, 1)
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Int}(undef, 1, 8);

julia> @roc groupsize=8 ker!(x);

julia> x
1×8 ROCArray{Int64, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 1  0  3  2  5  4  7  6
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront.jl#L365-L387" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.shfl_xor_sync' href='#AMDGPU.Device.shfl_xor_sync'><span class="jlbinding">AMDGPU.Device.shfl_xor_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
shfl_xor_sync(mask::UInt64, val, lane_mask, width = wavefrontsize())
```


Synchronize threads according to a `mask` and read data stored in `val` from a lane according to a bitwise XOR of the caller&#39;s lane ID with the `lane_mask`.


<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L136-L142" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.any_sync' href='#AMDGPU.Device.any_sync'><span class="jlbinding">AMDGPU.Device.any_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
any_sync(mask::UInt64, predicate::Bool)::Bool
```


Evaluate `predicate` for all non-exited threads in `mask` and return non-zero if and only if `predicate` evaluates to non-zero for any of them.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.any_sync(mask, i == 0)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Bool}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{Bool, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 1
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L47-L72" target="_blank" rel="noreferrer">source</a></Badge>

</details>

<details class='jldocstring custom-block' open>
<summary><a id='AMDGPU.Device.all_sync' href='#AMDGPU.Device.all_sync'><span class="jlbinding">AMDGPU.Device.all_sync</span></a> <Badge type="info" class="jlObjectType jlFunction" text="Function" /></summary>



```julia
all_sync(mask::UInt64, predicate::Bool)::Bool
```


Evaluate `predicate` for all non-exited threads in `mask` and return non-zero if and only if `predicate` evaluates to non-zero for all of them.

```julia
julia> function ker!(x)
           i = AMDGPU.Device.activelane()
           if i % 2 == 0
               mask = 0x0000000055555555 # Only even threads.
               x[1] = AMDGPU.Device.all_sync(mask, true)
           end
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray{Bool}(undef, 1);

julia> @roc groupsize=32 ker!(x);

julia> x
1-element ROCArray{Bool, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 1
```



<Badge type="info" class="source-link" text="source"><a href="https://github.com/JuliaGPU/AMDGPU.jl/blob/v1.3.2/src/device/gcn/wavefront_sync.jl#L75-L100" target="_blank" rel="noreferrer">source</a></Badge>

</details>

