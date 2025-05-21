


# Performance Tips {#Performance-Tips}

## Use Caching Memory Allocator {#Use-Caching-Memory-Allocator}

Julia relies on Garbage-Collection (GC) for memory management, because of that it will not free `ROCArrays` immediately as they are no longer used.

In tight loops with lots of GPU allocations this will put a lot of pressure on the allocator and may interfere with other programs that use that GPU.

Using [caching allocator](https://juliagpu.github.io/GPUArrays.jl/dev/interface/#Caching-Allocator) gives users a precise control of GPU memory, even if the allocations happen in code that&#39;s not controlled by the user.

You should use `GPUArrays.@cached` around parts of the code with repeating memory allocation patterns, for example, on the training loops.

Example below requires `8 MiB` of VRAM per iteration. In the worst case (if GC does not kick in) it would quickly fill up to `8 GiB` of VRAM, but with caching allocator it uses exactly `8 MiB`, which you can then immediately free to reclaim the memory.

```julia
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


For a more sophisticated real-world example, see how [GaussianSplatting.jl](https://github.com/JuliaNeuralGraphics/GaussianSplatting.jl/blob/e4ef1324c187371e336bef875b053023afe7fb2c/src/training.jl#L183) handles it.

## Avoid triggering Hostcalls {#Avoid-triggering-Hostcalls}

Some functions in the kernel may cause an exception, capturing the original value of the variable that caused it. These are usually related to float-to-integer conversion, so functions like `Int(1.0), ceil(Int, 1.0), floor(Int, 1.0)` will cause it.

This will perform dynamic memory allocation and launch a `Hostcall` for that, which will sit in the background thread until kernel finishes execution and the user synchronizes the `stream`. Having a hostcall unnecessarily slows execution down and you can avoid that by using &quot;GPU-friendly&quot; version of the function.

::: info

Hostcalls should be used mostly for debugging. When performance matters, they should be avoided.

:::

For example, let&#39;s see how we may deal with `ceil(Int, x)` and convert it to GPU-friendly version.

Starting with the bad example:

```julia
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


Here we can see that using &quot;un-optimized&quot; version of `ceil(Int, x[1])` causes a `malloc_hostcall` to be launched. Which we then have to stop by passing `stop_hostcalls=true` to the synchronization functions.

We can avoid this by using &quot;unsafe&quot; version that avoids checking for errors under-the-hood.

```julia
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


By doing `ceil(x[1])` first, then &quot;unsafely&quot; converting `Float32` to `Int` we can avoid error-checking &amp; hostcalls.

We can compare LLVM IR of the function that converts `Float32` to `Int` to see how they differ:

::: tabs

== unsafe_trunc(Int, 1.0)

```julia
using InteractiveUtils
InteractiveUtils.@code_llvm unsafe_trunc(Int, 1.0)
```


```
;  @ float.jl:336 within `unsafe_trunc`
define i64 @julia_unsafe_trunc_7070(double %0) #0 {
top:
  %1 = fptosi double %0 to i64
  %2 = freeze i64 %1
  ret i64 %2
}
```


== Int(1.0)

```julia
using InteractiveUtils
InteractiveUtils.@code_llvm Int(1.0)
```


```
;  @ float.jl:908 within `Int64`
define i64 @julia_Int64_7072(double %0) #0 {
top:
  %gcframe10 = alloca [6 x {}*], align 16
  %gcframe10.sub = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 0
  %1 = bitcast [6 x {}*]* %gcframe10 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %1, i8 0, i64 48, i1 true)
  %thread_ptr = call i8* asm "movq %fs:0, $0", "=r"() #12
  %tls_ppgcstack = getelementptr i8, i8* %thread_ptr, i64 -8
  %2 = bitcast i8* %tls_ppgcstack to {}****
  %tls_pgcstack = load {}***, {}**** %2, align 8
;  @ float.jl:909 within `Int64`
; ┌ @ float.jl:537 within `<=`
   %3 = bitcast [6 x {}*]* %gcframe10 to i64*
   store i64 16, i64* %3, align 16
   %4 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 1
   %5 = bitcast {}** %4 to {}***
   %6 = load {}**, {}*** %tls_pgcstack, align 8
   store {}** %6, {}*** %5, align 8
   %7 = bitcast {}*** %tls_pgcstack to {}***
   store {}** %gcframe10.sub, {}*** %7, align 8
   %8 = fcmp ult double %0, 0xC3E0000000000000
; └
  %9 = fcmp uge double %0, 0x43E0000000000000
  %10 = or i1 %8, %9
  br i1 %10, label %L16, label %L8

L8:                                               ; preds = %top
; ┌ @ floatfuncs.jl:45 within `isinteger`
; │┌ @ floatfuncs.jl:153 within `trunc`
; ││┌ @ floatfuncs.jl:153 within `#trunc#806`
; │││┌ @ float.jl:393 within `round`
      %11 = call double @llvm.trunc.f64(double %0)
; │└└└
; │┌ @ float.jl:410 within `-`
    %12 = fsub double %0, %11
; │└
; │┌ @ float.jl:572 within `==` @ float.jl:534
    %13 = fcmp une double %12, 0.000000e+00
; └└
  br i1 %13, label %L16, label %L14

L14:                                              ; preds = %L8
;  @ float.jl:910 within `Int64`
; ┌ @ float.jl:336 within `unsafe_trunc`
   %14 = fptosi double %0 to i64
   %15 = freeze i64 %14
   %16 = load {}*, {}** %4, align 8
   %17 = bitcast {}*** %tls_pgcstack to {}**
   store {}* %16, {}** %17, align 8
; └
  ret i64 %15

L16:                                              ; preds = %L8, %top
  %18 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 2
  %19 = bitcast {}** %18 to [3 x {}*]*
;  @ float.jl:912 within `Int64`
  %ptls_field11 = getelementptr inbounds {}**, {}*** %tls_pgcstack, i64 2
  %20 = bitcast {}*** %ptls_field11 to i8**
  %ptls_load1213 = load i8*, i8** %20, align 8
  %box = call noalias nonnull dereferenceable(16) {}* @ijl_gc_pool_alloc(i8* %ptls_load1213, i32 752, i32 16) #9
  %21 = bitcast {}* %box to i64*
  %22 = getelementptr inbounds i64, i64* %21, i64 -1
  store atomic i64 132116674523392, i64* %22 unordered, align 8
  %23 = bitcast {}* %box to double*
  store double %0, double* %23, align 8
  %24 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 5
  store {}* %box, {}** %24, align 8
  call void @j_InexactError_7074([3 x {}*]* noalias nocapture noundef nonnull sret([3 x {}*]) %19, {}* inttoptr (i64 132116833240512 to {}*), {}* readonly inttoptr (i64 132116674524192 to {}*), {}* nonnull readonly %box)
  %ptls_load81415 = load i8*, i8** %20, align 8
  %box3 = call noalias nonnull dereferenceable(32) {}* @ijl_gc_pool_alloc(i8* %ptls_load81415, i32 800, i32 32) #9
  %25 = bitcast {}* %box3 to i64*
  %26 = getelementptr inbounds i64, i64* %25, i64 -1
  store atomic i64 132116643587440, i64* %26 unordered, align 8
  %27 = bitcast {}* %box3 to i8*
  %28 = bitcast {}** %18 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %27, i8* noundef nonnull align 16 dereferenceable(24) %28, i64 24, i1 false)
  call void @ijl_throw({}* %box3)
  unreachable
}
```


:::
