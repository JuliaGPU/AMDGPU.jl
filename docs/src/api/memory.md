```@meta
DocTestSetup = quote
    using AMDGPU
    using GPUArrays
end
```

# Memory Allocation and Intrinsics

## Memory Types

A [`ROCArray`](@ref) can be backed by one of three types of memory, which is its third
type parameter:

- `Mem.HIPBuffer`: device memory, allocated from the memory pool of the device.
  Only the GPU can access it, so the CPU has to copy data to and from it.
  This is the default.
- `Mem.UnifiedBuffer`: unified memory, allocated with `hipMallocManaged`.
  Both the CPU and the GPU can access it, at the same address;
  the pages are migrated to where they are accessed.
- `Mem.HostBuffer`: page-locked host memory that is mapped into the address space of the GPU.
  This is the type of memory that [wrapping a host array](@ref "Wrapping in `ROCArray`") gives.

The memory type can be given to the array constructors, or to [`roc`](@ref):

```jldoctest unified
julia> x = ROCArray{Float32, 1, AMDGPU.Mem.UnifiedBuffer}(undef, 4);

julia> y = roc([1, 2, 3, 4]; unified=true)
4-element ROCArray{Int64, 1, AMDGPU.Runtime.Mem.UnifiedBuffer}:
 1
 2
 3
 4

julia> is_unified(y), is_device(y), is_host(y)
(true, false, false)
```

Arrays derived from such an array (`similar`, `copy`, views, the result of broadcasting, ...)
are backed by the same type of memory. Operations that mix memory types give unified memory.

### Accessing unified memory from the CPU

Arrays backed by unified (or host) memory can be used by code that runs on the CPU.
Indexing them does not copy from the device, so it is allowed without `AMDGPU.@allowscalar`,
and `unsafe_wrap` gives an `Array` that shares their memory:

```jldoctest unified
julia> y .*= 2;      # runs on the GPU

julia> y[2]          # read on the CPU
4

julia> y[1] = 0;

julia> h = unsafe_wrap(Array, y)   # no copy
4-element Vector{Int64}:
 0
 4
 6
 8

julia> sum(y) == sum(h)
true
```

Operations on the GPU execute asynchronously. Accessing a `ROCArray` from the CPU waits
for the operations that use it, but an `Array` wrapped around it does not: after using
the `ROCArray` again, call `AMDGPU.synchronize(y)` before accessing that `Array`, and
keep a reference to the `ROCArray` for as long as the `Array` is in use.

`pointer(y)` gives the address to use on the GPU, e.g. with HIP libraries,
and `pointer(y; type=AMDGPU.Mem.HostBuffer)` the address to use on the CPU.
For device memory, the latter throws an error.

Unified memory is fine-grained, like host memory: the CPU and a running kernel can access
it at the same time. Some hardware atomic instructions don't work on such memory, so
kernels that are launched with arrays backed by it use slower atomics
(see [Kernel Programming](@ref)). If the CPU only accesses an array between kernels, its
memory can be made coarse-grained like device memory, which avoids that:

```julia
hist = ROCArray{Float32, 1, AMDGPU.Mem.UnifiedBuffer}(undef, 32)
AMDGPU.coarse_grained!(hist)
```

```@docs
AMDGPU.coarse_grained!
AMDGPU.is_coarse_grained
```

!!! note
    Each access from the CPU waits for the GPU and may migrate pages, so loops over
    the elements of a large array are still much slower than for an `Array`.
    Unified memory is most useful to hand data to CPU code without copying it,
    or when data does not fit in the memory of the GPU.
    Allocating it is also slower than device memory, as it does not come from a memory pool,
    and it cannot be allocated while [capturing a graph](@ref "Graphs"): that invalidates the capture.

### Default memory type

The type of memory that is used when none is specified can be changed with the
`default_memory` preference, which can be `"device"` (the default), `"unified"` or `"host"`.
It takes effect after restarting Julia:

```julia
using Preferences, AMDGPU
set_preferences!(AMDGPU, "default_memory" => "unified")
```

```@docs
AMDGPU.default_memory
AMDGPU.memory_type
AMDGPU.is_device
AMDGPU.is_unified
AMDGPU.is_host
```

## Memory Varieties

GPUs contain various kinds of memory, just like CPUs:

- Global:
    Globally accessible by all CUs on a GPU, and possibly accessible
    from outside of the GPU (by the CPU host, by other GPUs, by PCIe devices,
    etc.). Slowest form of memory.
- Constant:
    Same as global memory, but signals to the hardware that it can use
    special instructions to access and cache this memory.
    Can be changed between kernel invocations.
- Region:
    Also known as Global Data Store (GDS), all wavefronts on a CU
    can access the same memory region from the same address.
    Faster than Global/Constant.
    Automatically allocated by the compiler/runtime, not user accessible.
- Local:
    Also known as Local Data Store (LDS), all wavefronts in the same workgroup
    can access the same memory region from the same address.
    Faster than GDS.
- Private:
    Uses the hardware scratch space, and is private to each SIMD lane
    in a wavefront.
    Fastest form of traditional memory.

## Local Memory

Local memory may be allocated within a kernel by calling either:

- `@ROCStaticLocalArray(T, dims)` - if `dims` is passed as a constant value,
    known at compile-time.
    E.g. `@ROCStaticLocalArray(Float32, 8)`.

- `@ROCDynamicLocalArray(T, dims)` - otherwise.
    E.g. `@ROCStaticLocalArray(Float32, length(X))`.

Local memory is zero-initialized by default.
If this is unnecessary and undesired for performance reasons,
disable this, passing `false` as a last argument:
`@ROCStaticLocalArray(Float32, 8, false)` or
`@ROCStaticLocalArray(Float32, length(X), false)`

Local memory does not need to be freed, as it is automatically freed by the
hardware.

If `@ROCDynamicLocalArray` is used, then local memory is dynamically allocated
at kernel execution time.
The `shmem` option to `@roc` must be set appropriately to ensure that
enough local memory is allocated by the hardware.

It is allocated in addition to the local memory that is statically allocated by
the kernel.

```julia
function kernel(C, A)
    # Allocate local memory dynamically
    Ctmp = @ROCDynamicLocalArray(Float64, length(C))
    # Or, allocate local memory statically if the size is known ahead-of-time
    Ctmp = @ROCStaticLocalArray(Float64, 8) # if we want 8 elements

    idx = AMDGPU.workitemIdx().x
    Ctmp[idx] = A[idx] + C[1]
    AMDGPU.Device.sync_workgroup()

    C[idx] = Ctmp[idx]
    return
end

...
# Note: The `shmem` option isn't necessary if `@ROCStaticLocalArray` is used
shmem = sizeof(Float64) * length(RC)
@roc groupsize=8 shmem=shmem kernel(RC, RA)
```

## Device-Side Allocations

Global memory may be allocated/freed dynamically from kernels by calling
`AMDGPU.Device.malloc(::Csize_t)::Ptr{Cvoid}`
and `AMDGPU.Device.free(::Ptr{Cvoid})`.

This memory allocation/deallocation uses hostcalls to operate,
and so is relatively slow, but is also very useful.
See [Hostcall](@ref) section for more info about them.

Memory allocated with `AMDGPU.Device.malloc` is a host-pinned memory.
Calls to `malloc` and `free` are performed once per workgroup, so ensure that
enough memory has been allocated to feed the lanes that will be accessing it.

As an example, here's how an array could be allocated on-device to store
temporary results:

```julia
function kernel(C, A)
    # Allocate memory dynamically and get a pointer to it.
    Ctmp_ptr = AMDGPU.Device.malloc(Csize_t(sizeof(Float64) * length(C)))
    # Turn a pointer into a device-side array.
    Ctmp = ROCDeviceArray(length(C), reinterpret(Core.LLVMPtr{Float64,1}, Ctmp_ptr))

    # Use it
    idx = AMDGPU.workitemIdx().x
    Ctmp[idx] = A[idx] + C[1]
    AMDGPU.Device.sync_workgroup()

    C[idx] = Ctmp[idx]
    # Make sure to free it.
    AMDGPU.Device.free(Ctmp_ptr)
    return
end

RA = AMDGPU.rand(4)
RC = AMDGPU.rand(4)
RC_elem = Array(RC)[1]
@roc groupsize=4 kernel(RC, RA)
@assert Array(RC) ≈ Array(RA) .+ RC_elem
```

## Memory Modification Intrinsics

Like C, AMDGPU.jl provides the `memset!` and `memcpy!` intrinsics, which are
useful for setting a memory region to a value, or copying one region to
another, respectively.
Check [test/device/memory.jl](https://github.com/JuliaGPU/AMDGPU.jl/blob/main/test/device/memory.jl)
for examples of their usage.

## Wrapping in `ROCArray`

You can wrap host array to be accessible (pinned) on the device with:

```jldoctest unsafe_wrap
julia> x = zeros(Float32, 4, 4);

julia> xd = unsafe_wrap(ROCArray, pointer(x), size(x));

julia> pointer(xd) == xd.buf[].mem.dev_ptr # Pointer to `xd` is a device-mapped pointer, not host pointer.
true

julia> xd .+= 1f0 # Can be used in kernels, host array `x` is also updated.
4×4 ROCArray{Float32, 2, AMDGPU.Runtime.Mem.HostBuffer}:
 1.0  1.0  1.0  1.0
 1.0  1.0  1.0  1.0
 1.0  1.0  1.0  1.0
 1.0  1.0  1.0  1.0

julia> xd * xd # Can be used with HIP libraries.
4×4 ROCArray{Float32, 2, AMDGPU.Runtime.Mem.HostBuffer}:
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
```

Additionally, you can wrap the device array with:

```jldoctest unsafe_wrap
julia> x = AMDGPU.zeros(Float32, 4, 4);

julia> xd = unsafe_wrap(ROCArray, pointer(x), size(x));

julia> xd .+= 1f0; # Can be used in kernels, `x` is also updated.

julia> all(x .== 1f0)
true

julia> xd * xd # Can be used with HIP libraries.
4×4 ROCArray{Float32, 2, AMDGPU.Runtime.Mem.HIPBuffer}:
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
 4.0  4.0  4.0  4.0
```

!!! note
    Passing `own=true` keyword will make the wrapped array take the ownership of the memory.
    For device memory it will free it on destruction.
    For host memory it will unregister (unpin) it on destruction.
    Multiple wraps of the same host pointer are reference-counted,
    so the actual unregister only happens when the last wrapper is freed.

## GPU Memory Management

Instances of `ROCArray` are managed by the Julia garbage collector.
When a `ROCArray` becomes unreachable it is eventually collected
and the underlying GPU memory is released.
There is no need for manual memory management in normal use.

### Memory pool

Behind the scenes, a HIP memory pool caches freed allocations to speed up
future requests.
As a result, GPU memory may appear occupied even after arrays have been freed.
When memory pressure is high, the pool automatically releases cached memory.

To query current GPU memory usage:

```julia
AMDGPU.info()   # (free_bytes, total_bytes)
AMDGPU.free()   # free bytes
AMDGPU.total()  # total bytes
AMDGPU.used()   # used bytes (total - free)
```

To manually release all cached pool memory back to the system:

```julia
AMDGPU.HIP.reclaim()
```

### Exportable memory pool (IPC, GPU-aware MPI)

By default (on Linux), the memory pools are created with an export handle type
(`hipMemHandleTypePosixFileDescriptor`), which makes device memory IPC-capable:
it can be shared with other processes via `hipIpcGetMemHandle`, as GPU-aware MPI
implementations do when `ROCArray`s are passed to MPI.
On ROCm 7.1 and later, memory from a pool without export handle type is backed by a
virtual-memory heap that cannot be exported.

```julia
AMDGPU.memory_pool_exportable()          # whether ROCArrays of the current device are IPC-capable
AMDGPU.memory_pool_handle_type!("none")  # pools without export handle type (takes effect after restart)
AMDGPU.memory_pool_handle_type!("posix_fd")  # default on Linux
```

If the exportable pool cannot be created on a platform, AMDGPU.jl warns once and falls
back to a pool without export handle type.

### Avoiding GC pressure

To explicitly free a `ROCArray` without waiting for the garbage collector:

```julia
AMDGPU.unsafe_free!(x)
```

After this call `x` is invalid and must not be used again.

### Eager GC

When enabled, proactively triggers garbage collection before
allocations when GPU memory pressure exceeds ~75%.
This prevents out-of-memory errors in allocation-heavy workloads at
small runtime cost.

```julia
AMDGPU.eager_gc!(true)   # or false
```

### Memory limits

Constrain how much GPU memory usage is allowed.
Values are strings in the form `"8 GiB"`, `"50 %"`, or `"none"` (default).
These are persisted via `Preferences.jl`.

```julia
AMDGPU.hard_memory_limit!("8 GiB")  # hard cap checked before every allocation
AMDGPU.soft_memory_limit!("6 GiB")  # advisory limit for the memory pool
AMDGPU.hard_memory_limit!("none")   # disable (default)
```
