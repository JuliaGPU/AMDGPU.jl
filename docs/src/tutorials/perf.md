```@meta
DocTestSetup = quote
    using AMDGPU
    using GPUArrays
end
```

# Performance Tips

## Use Caching Memory Allocator

Julia relies on Garbage-Collection (GC) for memory management, because of that
it will not free `ROCArrays` immediately as they are no longer used.

In a tight loops with lots of GPU allocations this will put a lot of pressure on the
allocator and may interfere with other programs that use that GPU.

Using [caching allocator](https://juliagpu.github.io/GPUArrays.jl/dev/interface/#Caching-Allocator) gives users a precise control of GPU memory,
even if the allocations happen in code that's not controlled by the user.

You should use `GPUArrays.@cached` around parts of the code with repeating memory allocation patterns,
for example, on the training loops.

Example below requires `8 MiB` of VRAM per iteration.
In the worst case (if GC does not kick in) it would quickly fill up to `8 GiB` of VRAM,
but with caching allocator it uses exactly `8 MiB`, which you can then immediately free to reclaim the memory.

```jldoctest caching-alloc
julia> cache = GPUArrays.AllocCache()
AllocCache(n_free=0, n_busy=0, sizeof=0 bytes)

julia> for i in 1:1000
           GPUArrays.@cached cache begin
               sin.(AMDGPU.rand(Float32, 1024^2))
           end
       end

julia> cache
AllocCache(n_free=2, n_busy=0, sizeof=8.000 MiB)

julia> GPUArrays.unsafe_free!(cache)
```

For a more sophisticated real-world example, see how
[GaussianSplatting.jl](https://github.com/JuliaNeuralGraphics/GaussianSplatting.jl/blob/e4ef1324c187371e336bef875b053023afe7fb2c/src/training.jl#L183)
handles it.

## Avoid triggering Hostcalls

Some functions in the kernel may cause an exception,
capturing the original value of the variable that caused it.
These are usually related to float-to-integer conversion, so functions like
`Int(1.0), ceil(Int, 1.0), floor(Int, 1.0)` will cause it.

This will perform dynamic memory allocation & launch a `Hostcall` for that,
which will sit in the background thread until kernel finishes execution & user synchronizes the `stream`.
Having a hostcall unnecessarily slows things down and you can avoid that by using
"GPU-friendly" version of the function.

::: info

Hostcalls should be used mostly for debugging. When performance matters, they should be avoided.

:::

For example, let's see how we may deal with `ceil(Int, x)` and convert it to GPU-friendly version.

Starting with the bad example:

```jldoctest hostcall
julia> function bad_kernel!(y, x)
           @inbounds y[1] = ceil(Int, x[1])
           return
       end
bad_kernel! (generic function with 1 method)

julia> x = ROCArray(Float32[1.1f0]);

julia> y = ROCArray(zeros(Int, 1));

julia> @roc bad_kernel!(y, x);
┌ Info: Global hostcalls detected!
│ - Source: MethodInstance for bad_kernel!(::AMDGPU.Device.ROCDeviceVector{Int64, 1}, ::AMDGPU.Device.ROCDeviceVector{Float32, 1})
│ - Hostcalls: [:malloc_hostcall]
│
│ Use `AMDGPU.synchronize(; stop_hostcalls=true)` to synchronize and stop them.
└ Otherwise, performance might degrade if they keep running in the background.

julia> y
1-element ROCArray{Int64, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 2

julia> AMDGPU.synchronize(; stop_hostcalls=true)
[ Info: Stopped global hostcall: `malloc_hostcall`.
```

Here we can see that using "un-optimized" version of `ceil(Int, x[1])`
causes a `malloc_hostcall` to be launched.
Which we then have to stop by passing `stop_hostcalls=true` to the synchronization functions.

We can avoid this by using "unsafe" version that avoids checking for errors under-the-hood.

```jldoctest hostcall
julia> function good_kernel!(y, x)
           @inbounds y[1] = unsafe_trunc(Int, ceil(x[1]))
           return
       end
good_kernel! (generic function with 1 method)

julia> fill!(y, 0);

julia> @roc good_kernel!(y, x);

julia> AMDGPU.synchronize(; stop_hostcalls=true) # Nothing is printed, so no hostcall was launched & stopped.

julia> y
1-element ROCArray{Int64, 1, AMDGPU.Runtime.Mem.HIPBuffer}:
 2
```

By doing `ceil(x[1])` first, then "unsafely" converting `Float32` to `Int`
we can avoid error-checking & hostcalls.

We can compare LLVM IR of the function that converts `Float32` to `Int` to see how they differ:

::: tabs

== unsafe_trunc(Int, 1.0)

```@example good-conversion
using InteractiveUtils
InteractiveUtils.@code_llvm unsafe_trunc(Int, 1.0)
```

== Int(1.0)

```@example bad-conversion
using InteractiveUtils
InteractiveUtils.@code_llvm Int(1.0)
```

:::
