# Kernel Exceptions

Just like regular CPU-executed Julia functions, GPU kernels can throw exceptions!

For example, the following kernel will throw an out-of-bounds exception:

```julia
julia> function ker!(x)
           x[0] = 1
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray([1]);

julia> @roc ker!(x);

julia> AMDGPU.synchronize()
ERROR: KernelException: BoundsError during kernel execution on work-item (1, 1, 1) of work-group (1, 1, 1): Out-of-bounds array access
Run Julia on debug level 2 for a device stack trace.
Stacktrace:
 [1] throw_if_exception(dev::HIPDevice)
   @ AMDGPU ~/.julia/dev/AMDGPU/src/exception_handler.jl:77
 [2] synchronize(stm::HIPStream; blocking::Bool, stop_hostcalls::Bool)
   @ AMDGPU ~/.julia/dev/AMDGPU/src/highlevel.jl:40
 [3] top-level scope
   @ REPL[4]:1
```

Kernel-thrown exceptions are thrown as an [`AMDGPU.KernelException`](@ref) during the
host synchronization [`AMDGPU.synchronize`](@ref) or on the next kernel launch.
Which exception was thrown, and why, is reported at the default debug level; with
`julia -g2` the exception also has a device stack trace, and with `-g0` only the
work-item that threw is known.

The first work-item to throw records where it threw, and on which work-item, into a
pre-allocated host buffer; others that throw don't overwrite it.
The wavefront throwing the exception stops,
but other wavefronts will continue executing.

```@docs
AMDGPU.KernelException
```
