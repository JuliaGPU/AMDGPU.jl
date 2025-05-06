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

## Synchronization

AMDGPU.jl by default uses non-blocking stream synchronization with
[`AMDGPU.synchronize`](@ref) to work correctly with TLS and [Hostcall](@ref).

Users, however, can switch to a blocking synchronization globally
with `nonblocking_synchronization`
[preference](https://github.com/JuliaPackaging/Preferences.jl)
or with fine-grained `AMDGPU.synchronize(; blocking=true)`.
Blocking synchronization might offer slightly lower latency.

You can also perform synchronization of the expression with
[`AMDGPU.@sync`](@ref) macro, which will execute given expression and
synchronize afterwards (using [`AMDGPU.synchronize`](@ref) under the hood).

```julia
AMDGPU.@sync begin
    @roc ...
end
```

Finally, you can perform full device synchronization with
[`AMDGPU.device_synchronize`](@ref).

```@docs
AMDGPU.synchronize
AMDGPU.@sync
AMDGPU.device_synchronize
```
