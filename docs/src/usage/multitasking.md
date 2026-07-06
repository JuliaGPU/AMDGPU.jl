# Tasks, Streams and Multiple GPUs

AMDGPU.jl follows a **task-local** execution model: the active device and stream are properties of the current Julia task. Switching either one affects only the task that makes the switch, so concurrent tasks can drive different devices or streams without interfering with each other. This makes ordinary Julia task-based parallelism the natural way to overlap work and to use several GPUs at once.

## Selecting a device

All supported GPUs are auto-detected. The device bound to the current task is returned by `AMDGPU.device()`, and `AMDGPU.devices()` lists all of them. Switch the current task's device with `AMDGPU.device!`:

```julia
AMDGPU.devices()                      # all detected devices
AMDGPU.device()                       # device of the current task

AMDGPU.device!(AMDGPU.devices()[2])   # switch this task to the second device
x = AMDGPU.ones(Float32, 16)          # allocated on the second device
```

Arrays and kernels use the current task's device, so allocate and launch after switching. See [Devices](@ref) for the full reference and device-property queries.

## Streams and asynchrony

Kernel launches and most operations are asynchronous with respect to the host: they are enqueued on a HIP stream and return immediately. Work on the same stream runs in order; work on different streams may overlap. Each task has a default stream, and you pick a stream per launch or per task:

```julia
stream = AMDGPU.HIPStream()
@roc stream=stream kernel(args...)                 # launch on a specific stream
AMDGPU.stream!(stream)                              # or make it the task default
```

Because launches are asynchronous, synchronize before reading results back or timing code. `AMDGPU.synchronize()` waits for the current stream, `AMDGPU.@sync` wraps an expression and synchronizes after it, and `AMDGPU.device_synchronize()` waits for the whole device:

```julia
AMDGPU.@sync @roc groupsize=256 gridsize=n kernel(args...)
```

Streams also carry a priority (`:normal`, `:low`, `:high`) to bias scheduling. See [Streams](@ref) for stream priorities, synchronization details, and the blocking-vs-nonblocking preference.

## Using multiple GPUs

Because device selection is task-local, drive several GPUs by spawning one task per device. Each task switches to its device, then allocates and launches there:

```julia
devs = AMDGPU.devices()
@sync for (i, dev) in enumerate(devs)
    Threads.@spawn begin
        AMDGPU.device!(dev)
        a = AMDGPU.ones(Float32, 1024)
        b = a .+ i
        AMDGPU.synchronize()
    end
end
```

Data does not move between devices automatically. To share results, copy through the host (`Array(x)` on the source device, then `ROCArray` on the destination) or use peer-to-peer transfers where supported.
