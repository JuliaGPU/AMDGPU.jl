# Queues

Similar to CUDA streams, ROCm has the concept of queues, which are
buffers used to instruct the GPU hardware which kernels to launch. ROCm queues
are asynchronous, unlike CUDA streams. Each agent has a default queue
associated, which is accessible with `get_default_queue(agent)` (or
`get_default_queue()` for the default agent's default queue). You can specify
which queue to launch a kernel on with the `queue` argument to `@roc`:

```julia
q = AMDGPU.HSAQueue(agent)
@roc queue=q kernel(...)
```

If you want to query which kernels are currently executing on a given queue,
calling `AMDGPU.active_kernels(queue)` will return a `Vector{HSAStatusSignal}`,
which can be inspected to determine how many (and which) kernels are executing
by comparing the signals returned from `@roc`. You can also omit the `queue`
argument, which will then check the default queue.

If a kernel ever gets "stuck" and locks up the GPU (noticeable with 100% GPU
usage in `rocm-smi`), you can kill the kernel and all other kernels in the
queue with `kill_queue!(queue)`. This can be "safely" done to the default
queue, since default queues are recreated as-needed.

# Signals

Unlike CUDA, ROCm kernels are tracked by an associated signal, which is
returned by `@roc`, and is `wait`ed on to track kernel completion. Signals may
also be used for manual synchronization (since they work for CPUs and GPUs
equally well). CPU usage is done with the `HSA.signal_*` functions, and GPU
usage is done with the `device_signal_*` functions. For most signalling needs,
consider using a hostcall instead.
