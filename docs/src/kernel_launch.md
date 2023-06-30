# Kernel Launch

## Launch Configuration

While an almost arbitrarily large number of workitems can be executed per
kernel launch, the hardware can only support executing a limited number of
wavefronts at one time.

To alleviate this, the compiler calculates the
"occupancy" of each compiled kernel (which is the number of wavefronts that can
be simultaneously executing on the GPU), and passes this information to the
hardware; the hardware then launches a limited number of wavefronts at once,
based on the kernel's "occupancy" values.

The rest of the wavefronts are not
launched until hardware resources become available, which means that a kernel
with better occupancy will see more of its wavefronts executing simultaneously
(which often leads to better performance). Suffice to say, it's important to
know the occupancy of kernels if you want the best performance.

Like CUDA.jl, AMDGPU.jl has the ability to calculate kernel occupancy, with the
`launch_configuration` function:

```julia
kernel = @roc launch=false mykernel(args...)
occupancy = AMDGPU.launch_configuration(kernel)
@show occupancy.gridsize
@show occupancy.groupsize
```

Specifically, `launch_configuration` calculates the occupancy of
`mykernel(args...)`, and then calculates an optimal groupsize based on the
occupancy.
This value can then be used to select the groupsize for the kernel:

```julia
@roc groupsize=occupancy.groupsize mykernel(args...)
```
