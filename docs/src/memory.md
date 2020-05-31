# Memory Allocation and Intrinsics

## Memory Varieties

GPUs contain various kinds of memory, just like CPUs:

- Global: Globally accessible by all CUs on a GPU, and possibly accessible from outside of the GPU (by the CPU host, by other GPUs, by PCIe devices, etc.). Slowest form of memory.
- Constant: Same as global memory, but signals to the hardware that it can use special instructions to access and cache this memory. Can be changed between kernel invocations.
- Region: Also known as Global Data Store (GDS), all wavefronts on a CU can access the same memory region from the same address. Faster than Global/Constant. Automatically allocated by the compiler/runtime, not user accessible.
- Local: Also known as Local Data Store (LDS), all wavefronts in the same workgroup can access the same memory region from the same address. Faster than GDS.
- Private: Uses the hardware scratch space, and is private to each SIMD lane in a wavefront. Fastest form of traditional memory.

## Memory Allocation/Deallocation

Currently, we can explicitly allocate Global and Local memory from within
kernels, and Global from outside of kernels. Global memory allocations are done
with `AMDGPU.Mem.alloc`, like so:

```julia
buf = Mem.alloc(agent, bytes)
```

`buf` in this example is a `Mem.Buffer`, which contains a pointer that points
to the allocated memory. The buffer can be converted to a pointer by doing
`Base.unsafe_convert(Ptr{Nothing}, buf)`, and may then be converted to the
appropriate pointer type, and loaded from/stored to. By default, memory is
allocated specifically on and for `agent`, and is only accessible to that agent
unless transferred using the various functions in the `Mem` module. If memory
should be globally accessible by the CPU and by all GPUs, the kwarg
`coherent=true` may be passed, which utilizes Unified Memory instead. Memory
should be freed once no longer necessary with `Mem.free(buf)`.

Global memory allocated by a kernel is automatically freed when the kernel
completes, which is done in the `wait` call on the host. This behavior can be
disabled by passing `cleanup=false` to `wait`.

Global memory may also be allocated and freed dynamically from kernels by
calling `AMDGPU.malloc(::Csize_t)::DevicePtr` and `AMDGPU.free(::DevicePtr)`.
This memory allocation/deallocation uses hostcalls to operate, and so is
relatively slow, but is also very useful. Currently, memory allocated with
`AMDGPU.malloc` is coherent.

Local memory may be allocated within a kernel by calling
`alloc_local(id, T, len)`, where `id` is some sort of bitstype ID for the local
allocation, `T` is the Julia element type, and `len` is the number of elements
of type `T` to allocate. Local memory does not need to be freed, as it is
automatically allocated/freed by the hardware.

## Memory Modification Intrinsics

Like C, AMDGPU.jl provides the `memset!` and `memcpy!` intrinsics, which are
useful for setting a memory region to a value, or copying one region to
another, respectively. Check `test/device/memory.jl` for examples of their
usage.
