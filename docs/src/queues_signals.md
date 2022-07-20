# Queues

Similar to CUDA streams, ROCm has the concept of queues, which are
buffers used to instruct the GPU hardware which kernels to launch. ROCm queues
are asynchronous, unlike CUDA streams. Each agent has a default queue
associated, which is accessible with `get_default_queue(agent)` (or
`get_default_queue()` for the default agent's default queue). You can specify
which queue to launch a kernel on with the `queue` argument to `@roc`:

```julia
q = AMDGPU.ROCQueue(agent)
@roc queue=q kernel(...)
```

If you want to query which kernels are currently executing on a given queue,
calling `AMDGPU.active_kernels(queue)` will return a `Vector{ROCKernelSignal}`,
which can be inspected to determine how many (and which) kernels are executing
by comparing the signals returned from `@roc`. You can also omit the `queue`
argument, which will then check the default queue.

If a kernel ever gets "stuck" and locks up the GPU (noticeable with 100% GPU
usage in `rocm-smi`), you can kill the kernel and all other kernels in the
queue with `kill_queue!(queue)`. This can be "safely" done to the default
queue, since default queues are recreated as-needed.

# Signals

Unlike CUDA, ROCm kernels are tracked by an associated signal, which is
created and returned by `@roc`, and is `wait`ed on to track kernel completion.
Signals may also be used for manual synchronization (since they work for CPUs
and GPUs equally well). CPU usage is done with the `HSA.signal_*` functions,
and GPU usage is done with the `device_signal_*` functions. For most signalling
needs, consider using a hostcall instead.

If custom signal handling is desired, signals can be manually constructed and
passed to `@roc`:

```julia
# A kernel which waits on all signals in `sigs`
function multi_wait(sigs)
    for i in 1:length(sigs)
        AMDGPU.device_signal_wait(sigs[i], 0)
    end
    nothing
end

# Create a set of signals
sigs = [ROCSignal() for i in 1:10]
# Get the device-safe signal handles
_sigs = ROCArray(map(sig->sig.signal[], sigs))

# Launch multi-waiter ahead of time; this will block on the device
final_sig = @roc multi_wait(_sigs)

# Associate kernels with signals
for sig in sigs
    @roc signal=sig identity(nothing)
end

# Wait on the multi-waiter
wait(final_sig)
```
