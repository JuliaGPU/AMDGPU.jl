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

By default, [`AMDGPU.synchronize`](@ref) does not block the calling thread:
it briefly polls the stream, and then waits for it on a separate worker
thread, so that other tasks can run on the calling thread in the meantime.
This is required for [Hostcall](@ref), whose host side runs as a task.
Synchronizing events and `HIP.device_synchronize()` works the same way.
Inside finalizers, which cannot switch tasks, synchronization blocks.

Users, however, can switch to a blocking synchronization globally
with `nonblocking_synchronization`
[preference](https://github.com/JuliaPackaging/Preferences.jl)
or with fine-grained `AMDGPU.synchronize(; blocking=true)`.
Blocking synchronization might offer slightly lower latency,
but must not be used while hostcalls are running.

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

## Implicit synchronization of arrays

AMDGPU.jl keeps track of the stream that last used the memory of each `ROCArray`.
Using the array on another stream (launching a kernel, copying,
or taking its pointer) first waits, on the host, for the stream that used it before,
so that operations on different streams are ordered.
[`AMDGPU.synchronize(A)`](@ref AMDGPU.synchronize) waits for the stream
that last used `A`.

This implicit synchronization can be disabled per array, e.g. to let kernels
that work on disjoint parts of an array run concurrently on different streams.
Ordering the streams is then up to the user:

```julia
s1, s2 = HIPStream(), HIPStream()
AMDGPU.enable_synchronization!(A, false)
@roc stream=s1 kernel_a!(A)  # e.g. computes the interior of `A`
@roc stream=s2 kernel_b!(A)  # e.g. computes the boundary of `A`, concurrently
AMDGPU.synchronize(s1); AMDGPU.synchronize(s2)
AMDGPU.enable_synchronization!(A)
```

```@docs
AMDGPU.enable_synchronization!
AMDGPU.synchronization_enabled
```
