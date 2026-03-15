# Kernel Programming

## Launch Configuration

While an almost arbitrarily large number of workitems can be executed per
kernel launch, the hardware can only support executing a limited number of
wavefronts at one time.

To alleviate this, the compiler calculates the
"occupancy" of each compiled kernel (which is the number of wavefronts that can
be simultaneously executing on the GPU), and passes this information to the
hardware; the hardware then launches a limited number of wavefronts at once,
based on the kernel's "occupancy" values.

The rest of the wavefronts are not
launched until hardware resources become available, which means that a kernel
with better occupancy will see more of its wavefronts executing simultaneously
(which often leads to better performance). Suffice to say, it's important to
know the occupancy of kernels if you want the best performance.

Like CUDA.jl, AMDGPU.jl has the ability to calculate kernel occupancy, with the
`launch_configuration` function:

```julia
kernel = @roc launch=false mykernel(args...)
occupancy = AMDGPU.launch_configuration(kernel)
@show occupancy.gridsize
@show occupancy.groupsize
```

Specifically, `launch_configuration` calculates the occupancy of
`mykernel(args...)`, and then calculates an optimal groupsize based on the
occupancy.
This value can then be used to select the groupsize for the kernel:

```julia
@roc groupsize=occupancy.groupsize mykernel(args...)
```

```@docs
AMDGPU.@roc
AMDGPU.Runtime.HIPKernel
AMDGPU.Compiler.hipfunction
```

## Atomics

AMDGPU.jl relies on [Atomix.jl](https://github.com/JuliaConcurrent/Atomix.jl)
for atomics.

Example of a kernel that computes atomic max:

```julia
using AMDGPU

function ker_atomic_max!(target, source, indices)
    i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
    idx = indices[i]
    v = source[i]
    AMDGPU.@atomic max(target[idx], v)
    return
end

n, bins = 1024, 32
source = ROCArray(rand(UInt32, n))
indices = ROCArray(rand(1:bins, n))
target = ROCArray(zeros(UInt32, bins))
@roc groupsize=256 gridsize=4 ker_atomic_max!(target, source, indices)
```

## Wave Matrix Multiply Accumulate (WMMA)

Perform following computation `D = A ⋅ B + C`.
Currently only RDNA 3 is supported and following types:
- `FP16 ⋅ FP16 + FP32 -> FP32`;
- `BFP16 ⋅ BFP16 + FP32 -> FP32`.

All WMMA functionality is in the `AMDGPU.Device.WMMA` submodule.
The tile dimensions are fixed at 16×16×16 (`WMMA.M`, `WMMA.N`, `WMMA.K`).

### Layout types

Two layout types control how matrices are read from and written to memory:

- `WMMA.ColMajor` — column-major (Julia/Fortran) order: element `(row, col)` is at `ptr[col * stride + row]`.
- `WMMA.RowMajor` — row-major (C) order: element `(row, col)` is at `ptr[row * stride + col]`.

### API

```@docs
AMDGPU.Device.WMMA.Fragment
AMDGPU.Device.WMMA.fill_c
AMDGPU.Device.WMMA.load_a
AMDGPU.Device.WMMA.load_b
AMDGPU.Device.WMMA.load_c
AMDGPU.Device.WMMA.store_d
AMDGPU.Device.WMMA.mma
```

`load_c` and `store_d` accept pointer types `Float32`, `Float16`, and `BFloat16`.
When `T` is `Float16` or `BFloat16`, values are widened to `Float32` on load and
narrowed back on store, so the `FragmentC_F32` accumulator type is always `Float32`
regardless of the backing buffer type.

### Example

Below is a matrix multiplication kernel using WMMA with column-major inputs.
Pass `WMMA.RowMajor` instead to load from row-major (C-style) buffers.

```@example wmma-matmul
using AMDGPU
using AMDGPU.Device: WMMA

function wmma_kernel!(C, A::AbstractArray{T}, B, M::Int32, N::Int32, K::Int32, layout) where T
    tile_row = (workgroupIdx().x - Int32(1)) * Int32(WMMA.M)
    tile_col = (workgroupIdx().y - Int32(1)) * Int32(WMMA.N)

    C_ptr = pointer(C)
    A_ptr = pointer(A)
    B_ptr = pointer(B)

    c_frag = WMMA.fill_c(Float32, 0f0)
    k = Int32(0)
    while k < K
        a_ptr, a_stride = _a_tile(A_ptr, layout, tile_row, k, M, K, T)
        b_ptr, b_stride = _b_tile(B_ptr, layout, tile_col, k, N, K, T)

        a_frag = WMMA.load_a(a_ptr, a_stride, layout)
        b_frag = WMMA.load_b(b_ptr, b_stride, layout)
        c_frag = WMMA.mma(a_frag, b_frag, c_frag)

        k += Int32(WMMA.K)
    end

    c_ptr = C_ptr + (tile_col * M + tile_row) * Int32(sizeof(Float32))
    WMMA.store_d(c_ptr, c_frag, M, WMMA.ColMajor)
    return
end

# Tile pointer + stride helpers — dispatched on layout, DCE'd by the compiler.
_a_tile(ptr, ::Type{WMMA.ColMajor}, tile_row, k, M, K, ::Type{T}) where T =
    ptr + (k * M + tile_row) * Int32(sizeof(T)), M
_a_tile(ptr, ::Type{WMMA.RowMajor}, tile_row, k, M, K, ::Type{T}) where T =
    ptr + (tile_row * K + k) * Int32(sizeof(T)), K

_b_tile(ptr, ::Type{WMMA.ColMajor}, tile_col, k, N, K, ::Type{T}) where T =
    ptr + (tile_col * K + k) * Int32(sizeof(T)), K
_b_tile(ptr, ::Type{WMMA.RowMajor}, tile_col, k, N, K, ::Type{T}) where T =
    ptr + (k * N + tile_col) * Int32(sizeof(T)), N

M, N, K = 32, 32, 32
A_host = Float16.(rand(M, K))
B_host = Float16.(rand(K, N))
A, B = ROCArray(A_host), ROCArray(B_host)
C = ROCArray(zeros(Float32, M, N))

tiles_m, tiles_n = M ÷ WMMA.M, N ÷ WMMA.N
@roc gridsize=(tiles_m, tiles_n) groupsize=32 wmma_kernel!(
    C, A, B, Int32(M), Int32(N), Int32(K), WMMA.ColMajor)

@assert maximum(abs.(Float32.(C) .- (Float32.(A) * Float32.(B)))) < 0.1
```

## Device Intrinsics

### Wavefront-Level Primitives

```@docs
AMDGPU.Device.wavefrontsize
AMDGPU.Device.activelane

AMDGPU.Device.ballot
AMDGPU.Device.ballot_sync
AMDGPU.Device.activemask

AMDGPU.Device.bpermute
AMDGPU.Device.permute

AMDGPU.Device.shfl
AMDGPU.Device.shfl_sync
AMDGPU.Device.shfl_up
AMDGPU.Device.shfl_up_sync
AMDGPU.Device.shfl_down
AMDGPU.Device.shfl_down_sync
AMDGPU.Device.shfl_xor
AMDGPU.Device.shfl_xor_sync

AMDGPU.Device.any_sync
AMDGPU.Device.all_sync
```
