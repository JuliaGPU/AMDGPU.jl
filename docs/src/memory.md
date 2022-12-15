# Memory Allocation and Intrinsics

## Memory Varieties

GPUs contain various kinds of memory, just like CPUs:

- Global: Globally accessible by all CUs on a GPU, and possibly accessible from outside of the GPU (by the CPU host, by other GPUs, by PCIe devices, etc.). Slowest form of memory.
- Constant: Same as global memory, but signals to the hardware that it can use special instructions to access and cache this memory. Can be changed between kernel invocations.
- Region: Also known as Global Data Store (GDS), all wavefronts on a CU can access the same memory region from the same address. Faster than Global/Constant. Automatically allocated by the compiler/runtime, not user accessible.
- Local: Also known as Local Data Store (LDS), all wavefronts in the same workgroup can access the same memory region from the same address. Faster than GDS.
- Private: Uses the hardware scratch space, and is private to each SIMD lane in a wavefront. Fastest form of traditional memory.

## Memory Queries

Most useable memory can be queried via AMDGPU's APIs. There are two sets of
APIs for querying memory: the older "Regions" API, and the newer "Memory Pools"
API. The Regions API is able to query all kinds of memory segments for each
device:

```julia
for device in AMDGPU.devices()
    foreach(println, AMDGPU.Runtime.regions(device)::Vector{AMDGPU.Runtime.ROCMemoryRegion})
end
```

The Memory Pools API is currently only able to query Global and Group memory
segments, but is more reliable (due to getting more development attention from
AMD):

```julia
for device in AMDGPU.devices()
    foreach(println, AMDGPU.Runtime.memory_pools(device)::Vector{AMDGPU.Runtime.ROCMemoryPool})
end
```

Most of the details of each memory segment are available by printing the region
or memory pool in question; they may also be accessed programmatically with the
`AMDGPU.Runtime.region_*` and `AMDGPU.Runtime.pool_*` APIs.

These details are generally not important to the average user, and are handled
automatically by AMDGPU when memory is allocated and freed.

## Memory Allocation/Deallocation

Currently, we can explicitly allocate Global and Local memory from within
kernels, and Global from outside of kernels. Global memory allocations are done
with `AMDGPU.Mem.alloc`, like so:

```julia
buf = AMDGPU.Mem.alloc(device, bytes)
# Or with the extended API if a region or memory pool is already selected:
buf = AMDGPU.Mem.alloc(device, pool, bytes)
buf = AMDGPU.Mem.alloc(device, region, bytes)
```

`buf` in this example is a `Mem.Buffer`, which contains a pointer
to the allocated memory. The buffer can be converted to a pointer by doing
`Base.unsafe_convert(Ptr{Nothing}, buf)`, and may then be converted to the
appropriate pointer type, and loaded from/stored to. By default, memory is
allocated specifically on and for `device`, and is only accessible to that
device unless transferred using the various functions in the `Mem` module. If
memory should be globally accessible by the CPU and by all GPUs, the kwarg
`coherent=true` may be passed, which utilizes "finegrained" memory instead.
Memory should be freed once it's no longer in use with `Mem.free(buf)`.

If allocations are done as
`Mem.alloc(device, bytes; coherent=false, slow_fallback=true)`, and the
allocation is larger than supported for that memory region, then coherent
memory will be automatically used (if possible) to service the allocation. This
can be disabled with `AMDGPU.Mem.enable_slow_allocation_fallback(false)` and
restarting Julia.

## Device-Side Allocations

Global memory allocated by a kernel is automatically freed when the kernel
completes, which is done in the `wait` call on the host. This behavior can be
disabled by passing `cleanup=false` to `wait`.

Global memory may also be allocated and freed dynamically from kernels by
calling `AMDGPU.Device.malloc(::Csize_t)::Ptr{Cvoid}` and
`AMDGPU.Device.free(::Ptr{Cvoid})`.  This memory allocation/deallocation uses
hostcalls to operate, and so is relatively slow, but is also very useful.
Currently, memory allocated with `AMDGPU.Device.malloc` is coherent by default.
Calls to `malloc` and `free` are performed once per workgroup, so ensure that
enough memory has been allocated to feed the lanes that will be accessing it.

As an example, here's how an array could be allocated on-device to store
temporary results:

```julia
function kernel(C, A, B)
    # Allocate memory dynamically and get a pointer to it
    Ctmp_ptr = AMDGPU.Device.malloc(Csize_t(sizeof(Float64)*length(C)))
    # Turn it (a pointer to Float64 elements in Global memory) into a device-side array
    Ctmp = ROCDeviceArray(length(C), reinterpret(Core.LLVMPtr{Float64,1}, Ctmp_ptr))
    # Use it
    idx = AMDGPU.workitemIdx().x
    Ctmp[idx] = A[idx] + B[idx] + C[1]
    AMDGPU.Device.sync_workgroup()
    C[idx] = Ctmp[idx]
    # Make sure to free it
    AMDGPU.Device.free(Ctmp_ptr)
    nothing
end
RA = AMDGPU.rand(4)
RB = AMDGPU.rand(4)
RC = AMDGPU.rand(4)
RC_elem = Array(RC)[1]
wait(@roc groupsize=4 kernel(RC, RA, RB))
@assert Array(RC) ≈ Array(RA) .+ Array(RB) .+ RC_elem
```

Local memory may be allocated within a kernel by calling either
`@ROCStaticLocalArray(T, dims)` or `@ROCDynamicLocalArray(T, dims)` - use the
former if `dims` is passed as a constant value, and otherwise use the latter.
Local memory does not need to be freed, as it is automatically freed by the
hardware. If `@ROCDynamicLocalArray` is used, then local memory is dynamically
allocated at kernel execution time; therefore, the `localmem` option to `@roc`
must be set appropriately to ensure that enough local memory is allocated by
the hardware.

```julia
function kernel(C, A, B)
    # Allocate local memory dynamically
    Ctmp = @ROCDynamicLocalArray(Float64, length(C))
    # Or, allocate local memory statically if the size is known ahead-of-time
    # Ctmp = @ROCStaticLocalArray(Float64, 8) # if we want 8 elements

    # Use it
    idx = AMDGPU.workitemIdx().x
    Ctmp[idx] = A[idx] + B[idx] + C[1]
    AMDGPU.Device.sync_workgroup()
    C[idx] = Ctmp[idx]
    nothing
end
# ...
# Note: The `localmem` option isn't necessary if `@ROCStaticLocalArray` is used
wait(@roc groupsize=4 localmem=sizeof(Float64)*length(RC) kernel(RC, RA, RB))
```

Note that like CUDA's shared memory, AMDGPU's local memory is zero-initialized
automatically. If this behavior is unnecessary (and undesired for performance
reasons), zero-initialization can be disabled with `@ROCDynamicLocalArray(T,
dims, false)` or `@ROCStaticLocalArray(T, dims, false)` (the last argument
is `zeroinit`).

## Memory Modification Intrinsics

Like C, AMDGPU.jl provides the `memset!` and `memcpy!` intrinsics, which are
useful for setting a memory region to a value, or copying one region to
another, respectively. Check `test/device/memory.jl` for examples of their
usage.
