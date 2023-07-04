# Hostcall

Hostcalls provide a means for GPU-CPU communications within running kernels.

AMDGPU.jl provides its own implementation of hostcalls, relying on HSA signals.
Currently, hostcalls are used for device-side allocations, printing and exception reporting.

Some of the hostcalls (global hostcalls), are launched automatically, if their
usage is detected during compilation (e.g. device-side allocations, exception reporting).

Hostcalls require careful usage, since they each spawn their own Tasks.
There should be no blocking operations during this time.

For example, using non-blocking synchronization instead of blocking with
`AMDGPU.synchronize(; blocking=false)`.

Non-blocking synchronization is also responsible for stopping global hostcalls,
otherwise the performance might degarde because of constant pooling
of HSA signals in a loop.

## Example

```julia
hc = Device.HostCallHolder(Float32, Tuple{Float32}) do x
    return x + 42f0
end

function kernel!(y, hc)
    y[1] = Device.hostcall!(hc, y[1])
    return
end

y = ROCArray(Float32[0f0])
@roc kernel!(y, hc)
AMDGPU.synchronize(; blocking=false) # Non-blocking sync to prevent hanging.

@assert Array(y)[1] ≈ 42f0
```

In this example, `HostCallHolder` is used to create and launch `HostCall`.
`HostCallHolder` contains the `HostCall` structure itself that is passed to kernel,
a task that is spawned on creation and some additional info for controlling
the lifetime of the task.

First argument is a function we want to execute when we call the hostcall.
In this case we add `42f0` to input argument `x` and return the result.

Second and third arguments are the return type `Float32` and the tuple of types
of input arguments `Tuple{Float32}`.

`hostcall!` is used to execute the function on the host, wait on the result,
and obtain the return values.
At the moment, it is performed once per workgroup.

## Continuous Host-Call

By default, hostcalls can be used only once.
After executing the function on the host, the task finishes and exits.

However, if you need your hostcall to live indefinitely, pass `continuous=true`
keyword argument to `HostCallHolder(...; continuous=true)`.

To then stop the hostcall, call `Device.non_continuous!(hc)`
or `Device.finish!(hc)` on the `HostCallHolder`.

The difference between them is that `non_continuous!` will allow calling
hostcall one more time before exiting, while `finish!` will exit immediately.

`finish!` can be used on any `HostCallHolder` to force-exit the running
hostcall task.
