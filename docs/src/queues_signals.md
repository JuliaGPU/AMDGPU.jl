# Queues

Similar to CUDA streams, ROCm has the concept of queues, which are
buffers used to instruct the GPU hardware which kernels to launch.
ROCm queues are synchronous, like CUDA streams.

Each device has a default queue associated,
which is accessible with [`AMDGPU.queue`](@ref).

To specify which queue to launch a kernel on:

- Using [`AMDGPU.queue!`](@ref), which will execute given function and reset
    to the original queue after completion:

```julia
q = AMDGPU.ROCQueue()
x = AMDGPU.queue!(() -> AMDGPU.ones(Float32, 16), q)
```

- Using `queue` argument to [`@roc`](@ref) macro:

```julia
q = AMDGPU.ROCQueue()
@roc queue=q kernel(...)
```

Queues also have an inherent priority, which allows control of kernel
submission latency and on-device scheduling preference with respect to kernels
submitted on other queues.
There are three priorities: normal (the default), low, and high priority.

Priority of the default `queue` can be set with [`AMDGPU.priority!`](@ref).
Alternatively, it can be set at queue creation time:

```julia
low_prio_queue = ROCQueue(; priority=:low)
high_prio_queue = ROCQueue(; priority=:high)
normal_prio_queue = ROCQueue(; priority=:normal) # or just omit "priority"
```

To get kernels which are currently executing on a given queue,
use [`AMDGPU.active_kernels`](@ref).
It will return a `Vector{ROCKernelSignal}`, which can be inspected to
determine how many (and which) kernels are executing.

If a kernel gets "stuck" and locks up the GPU (noticeable with 100% GPU usage in `rocm-smi`)
you can kill it and all other kernels associated with the queue it is running on
with [`AMDGPU.Runtime.kill_queue!(queue)`](@ref).
This can be "safely" done to the default queue (obtained via [`AMDGPU.queue`](@ref)),
since default queues are recreated as-needed.

```@docs
AMDGPU.queue
AMDGPU.queue!
AMDGPU.priority!
AMDGPU.active_kernels
AMDGPU.ROCQueue
AMDGPU.Runtime.set_queue_pool_size!
AMDGPU.Runtime.kill_queue!
```

# Signals

Unlike CUDA, ROCm kernels are tracked by an associated signal, which is
created and returned by `@roc`, and is `wait`ed on to track kernel completion.
Signals may also be used for manual synchronization (since they work for CPUs
and GPUs equally well). CPU usage is done with the `HSA.signal_*` functions,
and GPU usage is done with the `device_signal_*` and `hostcall_device_signal_*`
functions. For most signalling needs, consider using a hostcall instead.

If custom signal handling is desired, signals can be manually constructed and
passed to `@roc`:

```julia
# A kernel which waits on all signals in `sigs`
function multi_wait(sigs)
    for i in 1:length(sigs)
        AMDGPU.Device.hostcall_device_signal_wait(sigs[i], 0)
    end
    nothing
end

# Create a set of signals
sigs = [ROCSignal() for i in 1:10]
# Get the device-safe signal handles
_sigs = ROCArray(map(sig->sig.signal, sigs))

# Launch multi-waiter ahead of time; this will block on the device
final_sig = @roc multi_wait(_sigs)

# Associate kernels with signals
for sig in sigs
    @roc signal=sig identity(nothing)
end

# Wait on the multi-waiter
wait(final_sig)
```
