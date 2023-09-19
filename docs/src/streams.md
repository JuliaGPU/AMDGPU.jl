# Streams

Similar to CUDA streams, ROCm has HIP streams,
which are buffers used to instruct the GPU hardware which kernels to launch.
HIP streams are synchronous, like CUDA streams.

Each device has a default stream associated,
which is accessible with `AMDGPU.stream()`.

There are several ways to specify which stream to launch a kernel on:

- Using [`AMDGPU.stream!`](@ref) to change default stream to be used
    **within the same Julia task**.

```julia
stream = AMDGPU.HIPStream()
AMDGPU.stream!(stream) # Change default stream to be used for subsequent operations.
AMDGPU.ones(Float32, 16) # Will be executed on `stream`.
```

- Using [`AMDGPU.stream!`](@ref) to execute given function and reset
    to the original stream after completion:

```julia
stream = AMDGPU.HIPStream()
x = AMDGPU.stream!(() -> AMDGPU.ones(Float32, 16), stream)
```

- Using `stream` argument to `@roc` macro:

```julia
stream = AMDGPU.HIPStream()
@roc stream=stream kernel(...)
```

Streams also have an inherent priority, which allows control of kernel
submission latency and on-device scheduling preference with respect to kernels
submitted on other streams.
There are three priorities: normal (the default), low, and high priority.

Priority of the default `stream` can be set with [`AMDGPU.priority!`](@ref).
Alternatively, it can be set at stream creation time:

```julia
low_prio = HIPStream(:low)
high_prio = HIPStream(:high)
normal_prio = HIPStream(:normal) # or just omit "priority"
```

```@docs
AMDGPU.stream
AMDGPU.stream!
AMDGPU.priority!
AMDGPU.HIPStream
```
