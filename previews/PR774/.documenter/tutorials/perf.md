


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

::: tip Hostcalls

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


```ansi
[90m;  @ float.jl:336 within `unsafe_trunc`[39m
[95mdefine[39m [36mi64[39m [93m@julia_unsafe_trunc_6478[39m[33m([39m[36mdouble[39m [0m%0[33m)[39m [0m#0 [33m{[39m
[91mtop:[39m
  [0m%1 [0m= [96m[1mfptosi[22m[39m [36mdouble[39m [0m%0 [95mto[39m [36mi64[39m
  [0m%2 [0m= [96m[1mfreeze[22m[39m [36mi64[39m [0m%1
  [96m[1mret[22m[39m [36mi64[39m [0m%2
[33m}[39m
```


== Int(1.0)

```julia
using InteractiveUtils
InteractiveUtils.@code_llvm Int(1.0)
```


```ansi
[90m;  @ float.jl:908 within `Int64`[39m
[95mdefine[39m [36mi64[39m [93m@julia_Int64_6501[39m[33m([39m[36mdouble[39m [0m%0[33m)[39m [0m#0 [33m{[39m
[91mtop:[39m
  [0m%gcframe10 [0m= [96m[1malloca[22m[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m, [95malign[39m [33m16[39m
  [0m%gcframe10.sub [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m, [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10[0m, [36mi64[39m [33m0[39m[0m, [36mi64[39m [33m0[39m
  [0m%1 [0m= [96m[1mbitcast[22m[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10 [95mto[39m [36mi8[39m[0m*
  [96m[1mcall[22m[39m [36mvoid[39m [93m@llvm.memset.p0i8.i64[39m[33m([39m[36mi8[39m[0m* [95malign[39m [33m16[39m [0m%1[0m, [36mi8[39m [33m0[39m[0m, [36mi64[39m [33m48[39m[0m, [36mi1[39m [95mtrue[39m[33m)[39m
  [0m%thread_ptr [0m= [95mcall[39m [36mi8[39m[0m* [95masm[39m [0m"movq %fs:0, $0"[0m, [0m"=r"[33m([39m[33m)[39m [0m#12
  [0m%tls_ppgcstack [0m= [96m[1mgetelementptr[22m[39m [36mi8[39m[0m, [36mi8[39m[0m* [0m%thread_ptr[0m, [36mi64[39m [33m-8[39m
  [0m%2 [0m= [96m[1mbitcast[22m[39m [36mi8[39m[0m* [0m%tls_ppgcstack [95mto[39m [33m{[39m[33m}[39m[0m****
  [0m%tls_pgcstack [0m= [96m[1mload[22m[39m [33m{[39m[33m}[39m[0m***[0m, [33m{[39m[33m}[39m[0m**** [0m%2[0m, [95malign[39m [33m8[39m
[90m;  @ float.jl:909 within `Int64`[39m
[90m; ┌ @ float.jl:537 within `<=`[39m
   [0m%3 [0m= [96m[1mbitcast[22m[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10 [95mto[39m [36mi64[39m[0m*
   [96m[1mstore[22m[39m [36mi64[39m [33m16[39m[0m, [36mi64[39m[0m* [0m%3[0m, [95malign[39m [33m16[39m
   [0m%4 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m, [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10[0m, [36mi64[39m [33m0[39m[0m, [36mi64[39m [33m1[39m
   [0m%5 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m** [0m%4 [95mto[39m [33m{[39m[33m}[39m[0m***
   [0m%6 [0m= [96m[1mload[22m[39m [33m{[39m[33m}[39m[0m**[0m, [33m{[39m[33m}[39m[0m*** [0m%tls_pgcstack[0m, [95malign[39m [33m8[39m
   [96m[1mstore[22m[39m [33m{[39m[33m}[39m[0m** [0m%6[0m, [33m{[39m[33m}[39m[0m*** [0m%5[0m, [95malign[39m [33m8[39m
   [0m%7 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m*** [0m%tls_pgcstack [95mto[39m [33m{[39m[33m}[39m[0m***
   [96m[1mstore[22m[39m [33m{[39m[33m}[39m[0m** [0m%gcframe10.sub[0m, [33m{[39m[33m}[39m[0m*** [0m%7[0m, [95malign[39m [33m8[39m
   [0m%8 [0m= [96m[1mfcmp[22m[39m [96m[1mult[22m[39m [36mdouble[39m [0m%0[0m, [33m0xC3E0000000000000[39m
[90m; └[39m
  [0m%9 [0m= [96m[1mfcmp[22m[39m [96m[1muge[22m[39m [36mdouble[39m [0m%0[0m, [33m0x43E0000000000000[39m
  [0m%10 [0m= [96m[1mor[22m[39m [36mi1[39m [0m%8[0m, [0m%9
  [96m[1mbr[22m[39m [36mi1[39m [0m%10[0m, [36mlabel[39m [91m%L16[39m[0m, [36mlabel[39m [91m%L8[39m

[91mL8:[39m                                               [90m; preds = %top[39m
[90m; ┌ @ floatfuncs.jl:45 within `isinteger`[39m
[90m; │┌ @ floatfuncs.jl:153 within `trunc`[39m
[90m; ││┌ @ floatfuncs.jl:153 within `#trunc#806`[39m
[90m; │││┌ @ float.jl:393 within `round`[39m
      [0m%11 [0m= [96m[1mcall[22m[39m [36mdouble[39m [93m@llvm.trunc.f64[39m[33m([39m[36mdouble[39m [0m%0[33m)[39m
[90m; │└└└[39m
[90m; │┌ @ float.jl:410 within `-`[39m
    [0m%12 [0m= [96m[1mfsub[22m[39m [36mdouble[39m [0m%0[0m, [0m%11
[90m; │└[39m
[90m; │┌ @ float.jl:572 within `==` @ float.jl:534[39m
    [0m%13 [0m= [96m[1mfcmp[22m[39m [96m[1mune[22m[39m [36mdouble[39m [0m%12[0m, [33m0.000000e+00[39m
[90m; └└[39m
  [96m[1mbr[22m[39m [36mi1[39m [0m%13[0m, [36mlabel[39m [91m%L16[39m[0m, [36mlabel[39m [91m%L14[39m

[91mL14:[39m                                              [90m; preds = %L8[39m
[90m;  @ float.jl:910 within `Int64`[39m
[90m; ┌ @ float.jl:336 within `unsafe_trunc`[39m
   [0m%14 [0m= [96m[1mfptosi[22m[39m [36mdouble[39m [0m%0 [95mto[39m [36mi64[39m
   [0m%15 [0m= [96m[1mfreeze[22m[39m [36mi64[39m [0m%14
   [0m%16 [0m= [96m[1mload[22m[39m [33m{[39m[33m}[39m[0m*[0m, [33m{[39m[33m}[39m[0m** [0m%4[0m, [95malign[39m [33m8[39m
   [0m%17 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m*** [0m%tls_pgcstack [95mto[39m [33m{[39m[33m}[39m[0m**
   [96m[1mstore[22m[39m [33m{[39m[33m}[39m[0m* [0m%16[0m, [33m{[39m[33m}[39m[0m** [0m%17[0m, [95malign[39m [33m8[39m
[90m; └[39m
  [96m[1mret[22m[39m [36mi64[39m [0m%15

[91mL16:[39m                                              [90m; preds = %L8, %top[39m
  [0m%18 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m, [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10[0m, [36mi64[39m [33m0[39m[0m, [36mi64[39m [33m2[39m
  [0m%19 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m** [0m%18 [95mto[39m [33m[[39m[33m3[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m*
[90m;  @ float.jl:912 within `Int64`[39m
  [0m%ptls_field11 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [33m{[39m[33m}[39m[0m**[0m, [33m{[39m[33m}[39m[0m*** [0m%tls_pgcstack[0m, [36mi64[39m [33m2[39m
  [0m%20 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m*** [0m%ptls_field11 [95mto[39m [36mi8[39m[0m**
  [0m%ptls_load1213 [0m= [96m[1mload[22m[39m [36mi8[39m[0m*[0m, [36mi8[39m[0m** [0m%20[0m, [95malign[39m [33m8[39m
  [0m%box [0m= [96m[1mcall[22m[39m [95mnoalias[39m [95mnonnull[39m [95mdereferenceable[39m[33m([39m[33m16[39m[33m)[39m [33m{[39m[33m}[39m[0m* [93m@ijl_gc_pool_alloc[39m[33m([39m[36mi8[39m[0m* [0m%ptls_load1213[0m, [36mi32[39m [33m752[39m[0m, [36mi32[39m [33m16[39m[33m)[39m [0m#9
  [0m%21 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m* [0m%box [95mto[39m [36mi64[39m[0m*
  [0m%22 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [36mi64[39m[0m, [36mi64[39m[0m* [0m%21[0m, [36mi64[39m [33m-1[39m
  [96m[1mstore[22m[39m [95matomic[39m [36mi64[39m [33m134619096953088[39m[0m, [36mi64[39m[0m* [0m%22 [95munordered[39m[0m, [95malign[39m [33m8[39m
  [0m%23 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m* [0m%box [95mto[39m [36mdouble[39m[0m*
  [96m[1mstore[22m[39m [36mdouble[39m [0m%0[0m, [36mdouble[39m[0m* [0m%23[0m, [95malign[39m [33m8[39m
  [0m%24 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m, [33m[[39m[33m6[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [0m%gcframe10[0m, [36mi64[39m [33m0[39m[0m, [36mi64[39m [33m5[39m
  [96m[1mstore[22m[39m [33m{[39m[33m}[39m[0m* [0m%box[0m, [33m{[39m[33m}[39m[0m** [0m%24[0m, [95malign[39m [33m8[39m
  [96m[1mcall[22m[39m [36mvoid[39m [93m@j_InexactError_6503[39m[33m([39m[33m[[39m[33m3[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[0m* [95mnoalias[39m [95mnocapture[39m [95mnoundef[39m [95mnonnull[39m [95msret[39m[33m([39m[33m[[39m[33m3[39m [0mx [33m{[39m[33m}[39m[0m*[33m][39m[33m)[39m [0m%19[0m, [33m{[39m[33m}[39m[0m* [95minttoptr[39m [33m([39m[36mi64[39m [33m134619255670208[39m [95mto[39m [33m{[39m[33m}[39m[0m*[33m)[39m[0m, [33m{[39m[33m}[39m[0m* [95mreadonly[39m [95minttoptr[39m [33m([39m[36mi64[39m [33m134619096953888[39m [95mto[39m [33m{[39m[33m}[39m[0m*[33m)[39m[0m, [33m{[39m[33m}[39m[0m* [95mnonnull[39m [95mreadonly[39m [0m%box[33m)[39m
  [0m%ptls_load81415 [0m= [96m[1mload[22m[39m [36mi8[39m[0m*[0m, [36mi8[39m[0m** [0m%20[0m, [95malign[39m [33m8[39m
  [0m%box3 [0m= [96m[1mcall[22m[39m [95mnoalias[39m [95mnonnull[39m [95mdereferenceable[39m[33m([39m[33m32[39m[33m)[39m [33m{[39m[33m}[39m[0m* [93m@ijl_gc_pool_alloc[39m[33m([39m[36mi8[39m[0m* [0m%ptls_load81415[0m, [36mi32[39m [33m800[39m[0m, [36mi32[39m [33m32[39m[33m)[39m [0m#9
  [0m%25 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m* [0m%box3 [95mto[39m [36mi64[39m[0m*
  [0m%26 [0m= [96m[1mgetelementptr[22m[39m [95minbounds[39m [36mi64[39m[0m, [36mi64[39m[0m* [0m%25[0m, [36mi64[39m [33m-1[39m
  [96m[1mstore[22m[39m [95matomic[39m [36mi64[39m [33m134619066017136[39m[0m, [36mi64[39m[0m* [0m%26 [95munordered[39m[0m, [95malign[39m [33m8[39m
  [0m%27 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m* [0m%box3 [95mto[39m [36mi8[39m[0m*
  [0m%28 [0m= [96m[1mbitcast[22m[39m [33m{[39m[33m}[39m[0m** [0m%18 [95mto[39m [36mi8[39m[0m*
  [96m[1mcall[22m[39m [36mvoid[39m [93m@llvm.memcpy.p0i8.p0i8.i64[39m[33m([39m[36mi8[39m[0m* [95mnoundef[39m [95mnonnull[39m [95malign[39m [33m8[39m [95mdereferenceable[39m[33m([39m[33m24[39m[33m)[39m [0m%27[0m, [36mi8[39m[0m* [95mnoundef[39m [95mnonnull[39m [95malign[39m [33m16[39m [95mdereferenceable[39m[33m([39m[33m24[39m[33m)[39m [0m%28[0m, [36mi64[39m [33m24[39m[0m, [36mi1[39m [95mfalse[39m[33m)[39m
  [96m[1mcall[22m[39m [36mvoid[39m [93m@ijl_throw[39m[33m([39m[33m{[39m[33m}[39m[0m* [0m%box3[33m)[39m
  [96m[1munreachable[22m[39m
[33m}[39m
```


:::
