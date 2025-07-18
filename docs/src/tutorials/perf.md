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

## Using SIMD

Using vectorized load/store instructions can improve performance of the kernel.
Let's see on a simple vector addition example how to use it.

We define two helper functions:
- `vload` that will load SIMD tile given a pointer into the array;
- `vstore!` that will write SIMD tile into an array given its pointer.

```@example vadd-simd
using AMDGPU, SIMD

@inline function vload(::Type{SIMD.Vec{N, T}}, ptr::Core.LLVMPtr{T, AS}) where {N, T, AS}
    alignment = sizeof(T) * N
    vec_ptr = Base.bitcast(Core.LLVMPtr{SIMD.Vec{N, T}, AS}, ptr)
    return unsafe_load(vec_ptr, 1, Val(alignment))
end

@inline function vstore!(ptr::Core.LLVMPtr{T, AS}, x::SIMD.Vec{N, T}) where {N, T, AS}
    alignment = sizeof(T) * N
    vec_ptr = Base.bitcast(Core.LLVMPtr{SIMD.Vec{N, T}, AS}, ptr)
    unsafe_store!(vec_ptr, x, 1, Val(alignment))
    return
end

function vadd_simd!(c::AbstractVector{T}, a, b, ::Val{tile_size}) where {T, tile_size}
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    tile_idx = (i - 1) * tile_size + 1

    a_ptr = pointer(a, tile_idx)
    b_ptr = pointer(b, tile_idx)
    c_ptr = pointer(c, tile_idx)

    a_tile = vload(SIMD.Vec{tile_size, T}, a_ptr)
    b_tile = vload(SIMD.Vec{tile_size, T}, b_ptr)
    vstore!(c_ptr, a_tile + b_tile)
    return
end

n = 1024
tile_size = Val(4)

a = ROCArray(ones(Int, n))
b = ROCArray(ones(Int, n))
c = ROCArray(zeros(Int, n))

groupsize = 256
gridsize = cld(length(c), groupsize)
@roc groupsize=groupsize gridsize=gridsize vadd_simd!(c, a, b, tile_size)
@assert c == (a .+ b)
```

Examining LLVM IR, we can see vectorized `load <4 x i64>`, `add <4 x i64>`
and `store <4 x i64>` instructions:

```@example vadd-simd
AMDGPU.@device_code_llvm @roc launch=false vadd_simd!(c, a, b, tile_size);
```
