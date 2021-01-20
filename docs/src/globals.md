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
[`AMDGPU.get_global_pointer`](@ref) function, which both declares the
global variable, and returns a pointer to it (specifically a
`Core.LLVMPtr`). Once a kernel which declares a global is
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
    ptr = AMDGPU.get_global_pointer(Val(:myglobal), Float32)
    A[idx] += Base.unsafe_load(ptr)
    nothing
end
```

In order to access and modify this global before the kernel is launched, we can
specify a hook function to `@roc` which will be passed the global pointer as an
argument:

```julia
function myglobal_hook(gbl, mod, dev)
    gbl_ptr = Base.unsafe_convert(Ptr{Float32}, gbl.ptr)
    Base.unsafe_store!(gbl_ptr, 42f0)
end
RA = ROCArray(ones(Float32, 4))
wait(@roc groupsize=4 global_hooks=(myglobal=myglobal_hook,) my_kernel(RA))
```

In the above function, `gbl_ptr` is a pointer (specifically a `Ptr{Float32}`)
to the memory that represents the global variable `myglobal`. We can't
guarantee the initial value of an uninitialized global variable, so we need
to write a value to that global variable (in this case `42::Float32`).

We can then read the values of `RA` and see that it's what we expect:

```julia-repl
julia> A = Array(RA)
4-element ROCArray{Float32,1}:
 43.0
 43.0
 43.0
 43.0
```
