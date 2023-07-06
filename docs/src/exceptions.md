# Kernel Exceptions

Just like regular CPU-executed Julia functions, GPU kernels can throw exceptions!

For example, the following kernel will throw an out-of-bounds exception:

```julia
julia> using AMDGPU

julia> function kerr(x)
           x[0] = 1
           return
       end
kerr (generic function with 1 method)

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

julia> @roc kerr(x) # Next kernel launch also throws.
ERROR: GPU Kernel Exception
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:35
 [2] throw_if_exception(dev::HIPDevice)
   @ AMDGPU ~/.julia/dev/AMDGPU/src/exception_handler.jl:115
 [3] #_#30
   @ ~/.julia/dev/AMDGPU/src/runtime/hip-execution.jl:44 [inlined]
 [4] (::AMDGPU.Runtime.HIPKernel{typeof(kerr), Tuple{AMDGPU.Device.ROCDeviceVector{Int64, 1}}})(args::ROCVector{Int64})
   @ AMDGPU.Runtime ~/.julia/dev/AMDGPU/src/runtime/hip-execution.jl:41
 [5] top-level scope
   @ ~/.julia/dev/AMDGPU/src/highlevel.jl:228
```

Kernel-thrown exceptions are thrown during the
host synchronization `AMDGPU.synchronize` or on the next kernel launch.

Kernels that hit an exception will write its information into a pre-allocated
host buffer.
Once complete, the wavefront throwing the exception will lock the buffer
to prevent other wavefronts from overwriting the exception and stop itself,
but other wavefronts will continue executing.
