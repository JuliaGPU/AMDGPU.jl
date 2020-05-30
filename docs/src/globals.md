# Global Variables

Most programmers are familiar with the concept of a "global variable": a
variable which is globally accessible to any function in the user's program. In
Julia, programmers are told to avoid using global variables (also known as
"globals") because of their tendency to introduce type instabilities. However,
they're often useful for sharing data between functions in distinct areas of
the user's program.

In the JuliaGPU ecosystem, globals in the Julia sense are not available unless
their value is constant and inlinable into the function referencing them, as
all GPU kernels must be statically compileable. However, a different sort of
global variable is available which serves a very similar purpose. This variant
of global variable is statically typed and sized, and is accessible from: all
kernels with the same function signature (e.g. `mykernel(a::Int32,
b::Float64)`), the CPU host, and other devices and kernels when accessed by
pointer.

Global variables can be created within kernels with the
[`AMDGPUnative.get_global_pointer`](@ref) function, which both declares the
global variable, and returns a pointer to it (specifically a
[`AMDGPUnative.DevicePtr`](@ref)). Once a kernel which declares a global is
compiled for GPU execution (either by [`@roc`](@ref) or [`rocfunction`](@ref)),
the global is allocated memory and made available to the kernel (during the
linking stage). Globals are unique by name, and so you shouldn't attempt to
call `get_global_pointer` with the same name but a different type; if you do,
undefined behavior will result. Like regular pointers in Julia, you can use
functions like `Base.unsafe_load` and `Base.unsafe_store!` to read from and
write to the global variable, respectively.

As a concrete example of global variable usage, let's define a kernel which
creates a global and uses its value to increment the indices of an array:

```julia
function my_kernel(A)
    idx = workitemIdx().x
    ptr = AMDGPUnative.get_global_pointer(Val(:myglobal), Int64)
    A[idx] += Base.unsafe_load(ptr)
    nothing
end
```

Now, let's compile this kernel and get a pointer to this newly-declared global
variable. We'll also create an `HSAArray` that we intend to pass to the kernel:

```julia
HA = HSAArray(ones(Float32, 4))
kern = rocfunction(my_kernel, Tuple{typeof(rocconvert(HA))})
gbl = HSARuntime.get_global(kern.mod.exe, :myglobal)
gbl_ptr = Base.unsafe_convert(Ptr{Int64}, gbl.ptr)
```

And now `gbl_ptr` is a pointer (specifically a `Ptr{Int64}`) to the memory that
represents the global variable `myglobal`. We can't guarantee the initial value
of a newly-initialized global variable, so let's write a value to that global
variable and then read it back:

```julia
Base.unsafe_store!(gbl_ptr, 42)
println(Base.unsafe_load(gbl_ptr))
```

And now `myglobal` has the value 42, of type `Int64`. Now, let's invoke the
kernel with `@roc` (keeping in mind that the kernel's signature must be the
same as in our call to `rocfunction` above:

```julia
wait(@roc groupsize=4 my_kernel(HA))
```

We can then read the values of `HA` and see that it's what we expect:

```julia-repl
julia> A = Array(HA)
4-element HSAArray{Float32,1}:
 43.0
 43.0
 43.0
 43.0
```
