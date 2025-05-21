
# Kernel Exceptions {#Kernel-Exceptions}

Just like regular CPU-executed Julia functions, GPU kernels can throw exceptions!

For example, the following kernel will throw an out-of-bounds exception:

```julia
julia> function ker!(x)
           x[0] = 1
           return
       end
ker! (generic function with 1 method)

julia> x = ROCArray([1]);

julia> @roc kerr(x);

julia> AMDGPU.synchronize()
ERROR: GPU Kernel Exception
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:35
 [2] throw_if_exception(dev::HIPDevice)
   @ AMDGPU ~/.julia/dev/AMDGPU/src/exception_handler.jl:115
 [3] synchronize(stm::HIPStream)
   @ AMDGPU ~/.julia/dev/AMDGPU/src/highlevel.jl:154
 [4] synchronize()
   @ AMDGPU ~/.julia/dev/AMDGPU/src/highlevel.jl:154
 [5] top-level scope
   @ REPL[5]:1
```


Kernel-thrown exceptions are thrown during the host synchronization [`AMDGPU.synchronize`](/api/streams#AMDGPU.synchronize) or on the next kernel launch.

Kernels that hit an exception will write its information into a pre-allocated host buffer. Once complete, the wavefront throwing the exception will lock the buffer to prevent other wavefronts from overwriting the exception and stop itself, but other wavefronts will continue executing.
