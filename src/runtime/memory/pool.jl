# Persistent binned pool allocator backed by hipMalloc slabs.
#
# hipMalloc memory is SDMA-eligible unlike hipMallocFromPoolAsync memory,
# so device-to-device copies involving pool memory route through hardware
# copy engines rather than __amd_rocclr_copyBuffer.
#
# Design:
#   - Size classes: power-of-2 from MIN_BIN_SIZE (256 B) to BIN_CEILING (16 MiB)
#   - Each bin: host-side freelist (Vector{Ptr}) of same-size device slots
#   - Growth: when a bin is empty, allocate a new SLAB_SIZE slab via hipMalloc
#             and carve it into slots, appending to the freelist
#   - Large allocations (> BIN_CEILING): return nothing — caller falls through
#             to standard hipMallocFromPoolAsync
#   - Persistence: freelists survive across Trotter steps; slots freed in step N
#             serve step N+1 with no HIP calls
#   - Thread safety: designed for single-stream workloads; no locking

const _MIN_BIN_SIZE  = 256          # bytes — smallest bin
const _MAX_bin_ceiling() = 64 * 1024^2  # 64 MiB — hard upper limit for NUM_BINS sizing
const _SLAB_SIZE     = 64 * 1024^2  # 64 MiB per slab growth
const _NUM_BINS      = Int(log2(_MAX_bin_ceiling() ÷ _MIN_BIN_SIZE)) + 1  # = 19 (covers all possible ceilings)

function _bin_ceiling()
    mib = parse(Int, get(ENV, "AMDGPU_BINNED_POOL_CEILING_MIB", "4"))
    return mib * 1024^2
end

mutable struct _Bin
    slot_size::Int
    freelist::Vector{Ptr{Cvoid}}   # host-side stack of free device pointers
    slabs::Vector{Ptr{Cvoid}}      # hipMalloc'd slab base pointers
    alloc_count::Int               # histogram counter
end

mutable struct BinnedPool
    bins::Vector{_Bin}
    device::HIPDevice
    total_allocated::Int
    overflow_count::Int            # allocations > _bin_ceiling() (fell through to HIP pool)
end

function _bin_index(bytesize::Int)
    sz = max(bytesize, _MIN_BIN_SIZE)
    idx = Int(ceil(log2(sz / _MIN_BIN_SIZE))) + 1
    # Cap at the number of bins that cover the active ceiling
    active_num_bins = Int(log2(_bin_ceiling() ÷ _MIN_BIN_SIZE)) + 1
    return min(idx, active_num_bins)
end

function BinnedPool(dev::HIPDevice = AMDGPU.device())
    bins = [_Bin(_MIN_BIN_SIZE * (1 << (i - 1)), Ptr{Cvoid}[], Ptr{Cvoid}[], 0)
            for i in 1:_NUM_BINS]
    BinnedPool(bins, dev, 0, 0)
end

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

"""
    alloc!(pool::BinnedPool, bytesize::Int) -> HIPBuffer or nothing

Return a `HIPBuffer` backed by the pool for allocations ≤ `_bin_ceiling()`.
Returns `nothing` for large allocations — the caller should fall through to
the standard `hipMallocFromPoolAsync` path.

The returned buffer has `own = false` so it will not call `hipFreeAsync` when
freed; the caller must return the slot via `pool_free!(pool, buf)`.
"""
function alloc!(pool::BinnedPool, bytesize::Int)
    if bytesize > _bin_ceiling()
        pool.overflow_count += 1
        return nothing
    end
    bytesize == 0 && return HIPBuffer(C_NULL, 0; own=false)

    idx = _bin_index(bytesize)
    bin = pool.bins[idx]
    isempty(bin.freelist) && _grow_bin!(pool, bin)

    bin.alloc_count += 1
    ptr = pop!(bin.freelist)   # O(1) — no HIP call
    return HIPBuffer(ptr, bytesize; own=false)
end

"""
    pool_free!(pool::BinnedPool, buf::HIPBuffer)

Return a slot to the appropriate size-class bin. Must be called only after
the GPU stream has finished using the buffer (stream ordering guarantees this
in single-stream workloads).
"""
function pool_free!(pool::BinnedPool, buf::HIPBuffer)
    (buf.bytesize == 0 || buf.ptr == C_NULL) && return
    buf.bytesize > _bin_ceiling() && return  # large bufs are owned by HIP pool

    idx = _bin_index(buf.bytesize)
    push!(pool.bins[idx].freelist, buf.ptr)  # O(1) — no HIP call
end

"""
    destroy!(pool::BinnedPool)

Free all hipMalloc'd slabs. Must be called after stream synchronization
ensures no GPU work is still using pool memory.
"""
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

function Base.show(io::IO, pool::BinnedPool)
    total_free = sum(length(b.freelist) * b.slot_size for b in pool.bins)
    print(io, "BinnedPool(allocated=$(Base.format_bytes(pool.total_allocated)), ",
              "free≈$(Base.format_bytes(total_free)), bins=$(_NUM_BINS))")
end

"""
    binned_pool_stats(pool::BinnedPool)

Return a named tuple with per-bin and overall memory statistics.
"""
function binned_pool_stats(pool::BinnedPool)
    bin_stats = [(slot_size  = b.slot_size,
                  free_slots = length(b.freelist),
                  slabs      = length(b.slabs),
                  slab_bytes = length(b.slabs) * _SLAB_SIZE,
                  alloc_count = b.alloc_count)
                 for b in pool.bins if !isempty(b.slabs)]
    return (total_allocated_mb = pool.total_allocated / 1024^2,
            overflow_count = pool.overflow_count,
            bins = bin_stats)
end

"""
    print_histogram(pool::BinnedPool; io=stdout)

Print an allocation histogram showing the size distribution across bins and
the overflow (>BIN_CEILING) count. Use this to tune `_bin_ceiling()`:
- If overflow_count is large relative to bin totals, raise the ceiling.
- If the top few bins have near-zero counts, lower the ceiling to save VRAM.
"""
function print_histogram(pool::BinnedPool; io=stdout)
    total_binned = sum(b.alloc_count for b in pool.bins)
    grand_total  = total_binned + pool.overflow_count
    grand_total == 0 && (println(io, "BinnedPool: no allocations recorded"); return)

    println(io, "\nBinnedPool allocation histogram (total=$(grand_total))")
    println(io, "  $(rpad("Size class", 12))  $(rpad("Count", 10))  $(rpad("%", 7))  Slabs  VRAM")
    println(io, "  ", "-"^58)
    for bin in pool.bins
        bin.alloc_count == 0 && isempty(bin.slabs) && continue
        pct  = 100.0 * bin.alloc_count / grand_total
        vram = length(bin.slabs) * _SLAB_SIZE / 1024^2
        sz   = bin.slot_size >= 1024^2 ? "$(bin.slot_size÷1024^2) MiB" :
               bin.slot_size >= 1024   ? "$(bin.slot_size÷1024) KiB" :
                                         "$(bin.slot_size) B"
        println(io, "  $(rpad(sz, 12))  $(rpad(bin.alloc_count, 10))  $(rpad(round(pct,digits=2), 7))  $(length(bin.slabs))×64MiB  $(round(vram,digits=0)) MiB")
    end
    pct_overflow = 100.0 * pool.overflow_count / grand_total
    println(io, "  $(rpad(">BIN_CEILING", 12))  $(rpad(pool.overflow_count, 10))  $(round(pct_overflow,digits=2))%  (→ hipMallocFromPoolAsync)")
    println(io, "  Total VRAM held by pool: $(round(pool.total_allocated/1024^2, digits=0)) MiB")
end
