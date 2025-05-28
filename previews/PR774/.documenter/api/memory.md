
# Memory Allocation and Intrinsics {#Memory-Allocation-and-Intrinsics}

## Memory Varieties {#Memory-Varieties}

GPUs contain various kinds of memory, just like CPUs:
- Global:   Globally accessible by all CUs on a GPU, and possibly accessible   from outside of the GPU (by the CPU host, by other GPUs, by PCIe devices,   etc.). Slowest form of memory.
  
- Constant:   Same as global memory, but signals to the hardware that it can use   special instructions to access and cache this memory.   Can be changed between kernel invocations.
  
- Region:   Also known as Global Data Store (GDS), all wavefronts on a CU   can access the same memory region from the same address.   Faster than Global/Constant.   Automatically allocated by the compiler/runtime, not user accessible.
  
- Local:   Also known as Local Data Store (LDS), all wavefronts in the same workgroup   can access the same memory region from the same address.   Faster than GDS.
  
- Private:   Uses the hardware scratch space, and is private to each SIMD lane   in a wavefront.   Fastest form of traditional memory.
  

## Local Memory {#Local-Memory}

Local memory may be allocated within a kernel by calling either:
- `@ROCStaticLocalArray(T, dims)` - if `dims` is passed as a constant value,   known at compile-time.   E.g. `@ROCStaticLocalArray(Float32, 8)`.
  
- `@ROCDynamicLocalArray(T, dims)` - otherwise.   E.g. `@ROCStaticLocalArray(Float32, length(X))`.
  

Local memory is zero-initialized by default. If this is unnecessary and undesired for performance reasons, disable this, passing `false` as a last argument: `@ROCStaticLocalArray(Float32, 8, false)` or `@ROCStaticLocalArray(Float32, length(X), false)`

Local memory does not need to be freed, as it is automatically freed by the hardware.

If `@ROCDynamicLocalArray` is used, then local memory is dynamically allocated at kernel execution time. The `shmem` option to `@roc` must be set appropriately to ensure that enough local memory is allocated by the hardware.

It is allocated in addition to the local memory that is statically allocated by the kernel.

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


## Device-Side Allocations {#Device-Side-Allocations}

Global memory may be allocated/freed dynamically from kernels by calling `AMDGPU.Device.malloc(::Csize_t)::Ptr{Cvoid}` and `AMDGPU.Device.free(::Ptr{Cvoid})`.

This memory allocation/deallocation uses hostcalls to operate, and so is relatively slow, but is also very useful. See [Hostcall](/api/hostcall#Hostcall) section for more info about them.

Memory allocated with `AMDGPU.Device.malloc` is a host-pinned memory. Calls to `malloc` and `free` are performed once per workgroup, so ensure that enough memory has been allocated to feed the lanes that will be accessing it.

As an example, here&#39;s how an array could be allocated on-device to store temporary results:

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


## Memory Modification Intrinsics {#Memory-Modification-Intrinsics}

Like C, AMDGPU.jl provides the `memset!` and `memcpy!` intrinsics, which are useful for setting a memory region to a value, or copying one region to another, respectively. Check [test/device/memory.jl](https://github.com/JuliaGPU/AMDGPU.jl/blob/master/test/device/memory.jl) for examples of their usage.

## Wrapping in `ROCArray` {#Wrapping-in-ROCArray}

You can wrap host array to be accessible (pinned) on the device with:

```julia
x = rand(Float32, 4, 4)
xd = unsafe_wrap(ROCArray, pointer(x), size(x))

# Pointer to `xd` is a device-mapped pointer, not host pointer.
@show pointer(xd) == xd.buf.dev_ptr
@show pointer(xd) == xd.buf.ptr

# Can be used in kernels, host array `x` is also updated.
xd .+= 1f0

# Can be used with HIP libraries.
xd * xd
```


Pinned memory is automatically unregistered upon array destruction. You can&#39;t free it, since it is managed by the host.

Additionally, you can wrap the device array with:

```julia
x = AMDGPU.rand(Float32, 4, 4)
xd = unsafe_wrap(ROCArray, pointer(x), size(x); lock=false)

# Can be used in kernels, `x` is also updated.
xd .+= 1f0

# Can be used with HIP libraries.
xd * xd

# Freeing is a no-op for `xd`, since `xd` does not own the underlying memory.
AMDGPU.unsafe_free!(xd) # No-op.
```


Notice mandatory `; lock=false` keyword, this is to be able to differentiate between host &amp; device pointers.
