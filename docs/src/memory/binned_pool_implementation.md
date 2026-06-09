# BinnedPool: Implementation Guide

## Files Changed

| File | Change |
|------|--------|
| `src/runtime/memory/pool.jl` | **New** — `BinnedPool` type, `alloc!`, `pool_free!`, `destroy!`, `print_histogram`, `binned_pool_stats` |
| `src/runtime/Runtime.jl` | Include `pool.jl` inside `Mem` module |
| `src/memory.jl` | Task-local key/getter/setter; `with_binned_pool`; guards in `pool_alloc` and `pool_free` |
| `src/AMDGPU.jl` | Import and export `BinnedPool`, `with_binned_pool`, `binned_pool_stats`, `print_histogram` |

## `src/runtime/memory/pool.jl`

### Constants

```julia
const _MIN_BIN_SIZE = 256         # smallest bin slot size (bytes)
const _BIN_CEILING  = 8 * 1024^2  # 8 MiB — fall through to HIP pool above this
const _SLAB_SIZE    = 64 * 1024^2 # bytes per hipMalloc slab
const _NUM_BINS     = Int(log2(_BIN_CEILING ÷ _MIN_BIN_SIZE)) + 1  # = 16
```

Bins cover 256 B, 512 B, 1 KiB, 2 KiB, …, 8 MiB (16 bins total).

### `_bin_index(bytesize)`

Maps a byte size to a 1-based bin index (rounds up to nearest power-of-2 slot):

```julia
function _bin_index(bytesize::Int)
    sz  = max(bytesize, _MIN_BIN_SIZE)
    idx = Int(ceil(log2(sz / _MIN_BIN_SIZE))) + 1
    return min(idx, _NUM_BINS)
end
```

Example: 300 B → bin 2 (512 B slots), 1025 B → bin 3 (2 KiB slots).

### `_grow_bin!(pool, bin)`

Called when a bin's freelist is empty. Allocates one `_SLAB_SIZE` block via
`hipMalloc`, records it in `bin.slabs`, then carves it into `n = _SLAB_SIZE ÷
bin.slot_size` same-size slots appended to `bin.freelist`:

```julia
function _grow_bin!(pool::BinnedPool, bin::_Bin)
    slab_ref = Ref{Ptr{Cvoid}}(C_NULL)
    HIP.hipMalloc(slab_ref, _SLAB_SIZE)
    slab_ref[] == C_NULL && throw(HIP.HIPError(HIP.hipErrorOutOfMemory))
    push!(bin.slabs, slab_ref[])
    pool.total_allocated += _SLAB_SIZE
    n = _SLAB_SIZE ÷ bin.slot_size
    for i in 0:(n - 1)
        push!(bin.freelist, slab_ref[] + i * bin.slot_size)
    end
end
```

### `alloc!(pool, bytesize) → HIPBuffer or nothing`

Hot path — O(1), zero HIP calls for binned sizes:

```julia
function alloc!(pool::BinnedPool, bytesize::Int)
    if bytesize > _BIN_CEILING
        pool.overflow_count += 1
        return nothing              # caller falls through to hipMallocFromPoolAsync
    end
    bytesize == 0 && return HIPBuffer(C_NULL, 0; own=false)
    idx = _bin_index(bytesize)
    bin = pool.bins[idx]
    isempty(bin.freelist) && _grow_bin!(pool, bin)
    bin.alloc_count += 1
    ptr = pop!(bin.freelist)        # O(1)
    return HIPBuffer(ptr, bytesize; own=false)  # own=false → no hipFreeAsync
end
```

The `own=false` flag on `HIPBuffer` is critical: it prevents `Mem.free` from
calling `hipFreeAsync`, so `pool_free` in `memory.jl` intercepts instead.

### `pool_free!(pool, buf)`

Returns a slot to the correct bin. O(1), zero HIP calls:

```julia
function pool_free!(pool::BinnedPool, buf::HIPBuffer)
    (buf.bytesize == 0 || buf.ptr == C_NULL) && return
    buf.bytesize > _BIN_CEILING && return  # large bufs owned by HIP pool
    idx = _bin_index(buf.bytesize)
    push!(pool.bins[idx].freelist, buf.ptr)  # O(1)
end
```

### `destroy!(pool)`

Frees all `hipMalloc`'d slabs. Must be called after `AMDGPU.synchronize()`:

```julia
function destroy!(pool::BinnedPool)
    for bin in pool.bins
        for slab in bin.slabs
            HIP.hipFree(slab)
        end
        empty!(bin.slabs)
        empty!(bin.freelist)
    end
    pool.total_allocated = 0
end
```

### `print_histogram(pool)`

Prints a size-distribution table showing count, percentage, slab count, and
VRAM per bin plus the overflow row. Use after a run to tune `_BIN_CEILING`.

## `src/runtime/Runtime.jl`

Add `pool.jl` inside the `Mem` module, after `hip.jl` (which defines `HIPBuffer`):

```julia
module Mem
    ...
    include(joinpath("memory", "hip.jl"))
    include(joinpath("memory", "pool.jl"))  # ← added
end
```

## `src/memory.jl`

### Task-local storage

```julia
const _BINNED_POOL_KEY = :__AMDGPU_binned_pool__
_get_binned_pool() = get(task_local_storage(), _BINNED_POOL_KEY, nothing)
_set_binned_pool!(pool) = task_local_storage(_BINNED_POOL_KEY, pool)
```

Uses Julia base `task_local_storage` (available since Julia 1.0) rather than
`TaskLocalValue` (which is not available in Julia 1.13).

### `with_binned_pool(f, pool)`

```julia
function with_binned_pool(f, pool::Mem.BinnedPool)
    _set_binned_pool!(pool)
    try
        f()
    finally
        _set_binned_pool!(nothing)
    end
end
```

### Modified `pool_alloc`

Fast path before the original implementation:

```julia
function pool_alloc(::Type{B}, bytesize) where B
    bp = _get_binned_pool()
    if bp !== nothing
        buf = Mem.alloc!(bp, bytesize)
        if buf !== nothing
            s = AMDGPU.stream()
            return Managed(buf; stream=s, captured=AMDGPU.is_capturing())
        end
        # nothing → bytesize > BIN_CEILING, fall through
    end
    # original hipMallocFromPoolAsync path unchanged below
    maybe_collect()
    ...
end
```

### Modified `pool_free`

Fast path before the original `hipFreeAsync`:

```julia
function pool_free(managed::Managed{M}) where M
    sz = Int(sizeof(managed.mem))
    sz == 0 && return

    bp = _get_binned_pool()
    if bp !== nothing && !managed.mem.own
        Mem.pool_free!(bp, managed.mem)
        return
    end
    # original hipFreeAsync path unchanged below
    ...
end
```

The `!managed.mem.own` guard ensures only binned-pool buffers (`own=false`)
are returned to the pool. Standard HIP pool buffers (`own=true`) follow the
original path.

## `src/AMDGPU.jl`

```julia
import .Runtime.Mem: BinnedPool, binned_pool_stats, print_histogram
include("memory.jl")
export BinnedPool, with_binned_pool, binned_pool_stats, print_histogram
```

## Usage Pattern

```julia
using AMDGPU

pool = BinnedPool(AMDGPU.device())

with_binned_pool(pool) do
    for step in 1:num_steps
        run_step!(state, gates[step])
        AMDGPU.synchronize()   # stream ordering ensures safe slot reuse
    end
end

print_histogram(pool)   # inspect size distribution for tuning
AMDGPU.synchronize()    # ensure no GPU work uses pool memory
Mem.destroy!(pool)      # free all hipMalloc'd slabs
```

## Testing

```bash
# Correctness: overlap values must match reference
ROCM_PATH=/opt/rocm-7.2.0 HIP_DEVICE_LIB_PATH=/opt/rocm-7.2.0/amdgcn/bitcode \
  julia +1.13 --project=. test/runtests.jl

# Performance verification: check hipMallocFromPoolAsync call count drops >99%
ROCM_PATH=/opt/rocm-7.2.0 rocprofv3 --hip-trace --output-directory /tmp/pool_test -- \
  julia +1.13 --project=<workload> compute_overlaps_gpu.jl heavy_hex_3x3 3
# Then check hip_api_sum: hipMallocFromPoolAsync should show ~36K calls (not ~1.7M)

# Histogram for ceiling tuning
ROCM_PATH=/opt/rocm-7.2.0 ... julia ... compute_overlaps_gpu.jl heavy_hex_3x3 9
# Check: overflow_count / total < 1%
# Check: total VRAM held by pool is within budget
```

## Known Limitations and Future Work

1. **Large-allocation overflow** (~1% of calls): allocations above `_BIN_CEILING`
   still use `hipMallocFromPoolAsync`. An exact-size freelist keyed by `bytesize`
   would eliminate all pool calls, at the cost of higher implementation complexity.

2. **Slab reclamation**: slabs are never returned to the OS within a run.
   For workloads with non-monotonic memory usage, a `trim_empty_slabs!` function
   could be added that frees slabs whose entire freelist is present.

3. **Multi-stream**: `bin.alloc_count` and `bin.freelist` are not thread-safe.
   Wrapping with a spinlock or using atomic operations would enable multi-stream use.

4. **`_SLAB_SIZE` tuning**: the fixed 64 MiB slab wastes VRAM for large bins
   (e.g. 8 MiB bin: 8 slots/slab, 59 slabs = 3.7 GiB for 12K allocations).
   A proportional `_SLAB_SIZE = max(4 MiB, slot_size * 8)` would reduce this
   but increases `hipMalloc` call frequency for small bins.
