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

Local memory may be allocated within a kernel by calling
`AMDGPU.Device.alloc_local(id, T, len)`, where `id` is some sort of bitstype ID
for the local allocation, `T` is the Julia element type, and `len` is the
number of elements of type `T` to allocate. Local memory does not need to be
freed, as it is automatically allocated/freed by the hardware.

## Memory Modification Intrinsics

Like C, AMDGPU.jl provides the `memset!` and `memcpy!` intrinsics, which are
useful for setting a memory region to a value, or copying one region to
another, respectively. Check `test/device/memory.jl` for examples of their
usage.
