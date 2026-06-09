# BinnedPool: Userspace GPU Memory Allocator — Design Document

## Problem

AMDGPU.jl's default allocator calls `hipMallocFromPoolAsync` and `hipFreeAsync`
for every GPU tensor allocation. This causes two performance problems:

### 1. `__amd_rocclr_copyBuffer` kernel overhead

Memory allocated via `hipMallocFromPoolAsync` uses a VMM region descriptor that
the SDMA copy engine cannot address directly. Any device-to-device copy involving
pool-allocated memory falls back to `__amd_rocclr_copyBuffer`, a software kernel
that runs on compute units and competes with GEMM and SVD kernels.

### 2. ROCm pool trimming regression

Some ROCm versions aggressively return GPU memory to the OS/HSA after each
`hipFreeAsync` by setting a low `hipMemPoolAttrReleaseThreshold`. The next
`hipMallocFromPoolAsync` cannot reuse the cached block and instead pays a fresh
HSA VMM mapping cost, significantly increasing per-call latency.

## Solution: Persistent Binned Pool Allocator

Implement a userspace pool allocator backed by `hipMalloc` slabs. Unlike
`hipMallocFromPoolAsync` memory, `hipMalloc` memory is:

- **SDMA-eligible**: device-to-device copies route through hardware copy engines
  rather than the `__amd_rocclr_copyBuffer` blit kernel
- **Unaffected by ROCm pool trimming**: the allocator manages its own memory
  with zero HIP calls on the hot alloc/free path
- **Persistent across simulation steps**: freed slots return to size-class
  freelists and are reused in subsequent steps without any HIP calls

### Design

```
BinnedPool
├── bins[1..N_BINS]           # power-of-2 size classes: 256 B → BIN_CEILING
│   ├── slot_size             # bytes per slot in this bin
│   ├── freelist[]            # host-side stack of free device pointers (O(1) push/pop)
│   ├── slabs[]               # hipMalloc'd slab base pointers (for destroy!)
│   └── alloc_count           # histogram counter for tuning
├── overflow_count            # allocations > BIN_CEILING → hipMallocFromPoolAsync
└── total_allocated           # total hipMalloc'd bytes
```

**Size classes**: power-of-2 from `_MIN_BIN_SIZE` (256 B) to `_BIN_CEILING` (8 MiB).

**Slab growth**: when a bin's freelist is empty, a new `_SLAB_SIZE` (64 MiB)
slab is allocated via `hipMalloc` and carved into same-size slots. Slabs are
never returned to the OS until `destroy!` is called.

**Overflow**: allocations exceeding `_BIN_CEILING` fall through to the standard
`hipMallocFromPoolAsync` path. At 8 MiB ceiling, this is ~0.5–1% of calls.

**Thread safety**: designed for single-stream workloads. No locking.

### Integration: Task-Local Override

The pool integrates transparently via Julia's `task_local_storage`:

```julia
pool = BinnedPool(AMDGPU.device())
with_binned_pool(pool) do
    # All pool_alloc calls in this scope use the binned pool
    # All pool_free calls return slots to the binned pool
    run_simulation!(...)
end
AMDGPU.synchronize()   # ensure all GPU work is done before freeing slabs
destroy!(pool)
```

`pool_alloc` and `pool_free` in `src/memory.jl` check the task-local pool first
before falling through to the original `hipMallocFromPoolAsync` path.

## Parameter Tuning

Use `print_histogram(pool)` after a run to see the allocation size distribution:

```
BinnedPool allocation histogram (total=5176525)
  Size class    Count       %        Slabs  VRAM
  ----------------------------------------------------------
  256 B         4054544     78.33    1×64MiB  64.0 MiB
  ...
  8 MiB         12015       0.23     59×64MiB  3776.0 MiB
  >BIN_CEILING  50786       0.98%  (→ hipMallocFromPoolAsync)
  Total VRAM held by pool: 12736.0 MiB
```

**`_BIN_CEILING`**: set so overflow is < 1% of total allocations. Run with your
workload and check the overflow row in the histogram to confirm.

**`_SLAB_SIZE`**: fixed at 64 MiB. Larger slabs reduce `hipMalloc` call count
but increase VRAM waste for large size classes (few slots per slab). The current
tradeoff is appropriate for workloads where large-bin slot counts are low.

## Limitations

- Slabs never shrink within a run (monotonic VRAM growth to peak working set)
- Large allocations (> `_BIN_CEILING`) still use `hipMallocFromPoolAsync`
- Single-stream workloads only; multi-stream requires atomic freelist operations
