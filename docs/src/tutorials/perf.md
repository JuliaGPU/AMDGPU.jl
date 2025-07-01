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

In tight loops with lots of GPU allocations this will put a lot of pressure on the
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
