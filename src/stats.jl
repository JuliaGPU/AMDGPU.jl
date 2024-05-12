"""
    info()

Returns a tuple of two integers, indicating respectively the free and total amount of memory
(in bytes) available for allocation on the device.
"""
function info()
    free_ref = Ref{Csize_t}()
    total_ref = Ref{Csize_t}()
    HIP.hipMemGetInfo(free_ref, total_ref) |> HIP.check
    return convert(Int, free_ref[]), convert(Int, total_ref[])
end

"""
    free()

Returns the free amount of memory (in bytes), available for allocation on the device.
"""
free() = info()[1]

"""
    total()

Returns the total amount of memory (in bytes), available for allocation on the device.
"""
total() = info()[2]

"""
    used()

Returns the used amount of memory (in bytes), allocated on the device.
"""
used() = total() - free()

function parse_memory_limit(limit_str::String)::UInt64
    limit_str == "none" && return typemax(UInt64)

    units = ("%", "MiB", "GiB")

    value, unit = split(limit_str) # TODO check length 2 before split
    unit in units || throw(ArgumentError("""
    Memory limit must be specified in `$units` units, but `$unit` was given.
    """))

    total_memory = total()
    limit = if unit == "%"
        v = parse(Int, value)
        0 < v ≤ 100 || throw(ArgumentError("""
        Invalid percentage value for memory limit `$v`.
        Must be in (0, 100] range or 'none'.
        """))
        floor(UInt64, total_memory * (v / 100))
    else
        scale = unit == "MiB" ? (1024^2) : (1024^3)
        parse(UInt64, value) * scale
    end

    limit > total_memory && throw(ArgumentError("""
    Memory limit `$(Base.format_bytes(limit))` is bigger than the actual memory `$(Base.format_bytes(total_memory))`.
    Set to `none` to disable memory limit.
    """))
    return limit
end

"""
Set a hard limit for total GPU memory allocations.
"""
set_memory_alloc_limit!(limit::String) =
    @set_preferences!("hard_memory_limit" => limit)

const HARD_MEMORY_LIMIT = Ref{Union{Nothing, UInt64}}(nothing)
function hard_memory_limit()
    l = HARD_MEMORY_LIMIT[]
    l ≢ nothing && return l

    HARD_MEMORY_LIMIT[] = parse_memory_limit(
        @load_preference("hard_memory_limit", "none"))
end

mutable struct MemoryStats
    # Maximum size of the heap.
    # Estimated during `maybe_collect` stage.
    Base.@atomic size::Int
    Base.@atomic last_updated::Float64

    # Live bytes.
    Base.@atomic live::Int

    # Last `maybe_collect` update.
    Base.@atomic last_time::Float64
    # Amount of time last GC call took.
    Base.@atomic last_gc_time::Float64
    # Amount of freed memory during last `maybe_collect`.
    Base.@atomic last_freed::Int
end

MemoryStats() = MemoryStats(0, 0.0, 0, 0.0, 0.0, 0)

const MEMORY_STATS = AMDGPU.LockedObject(Dict{Int, MemoryStats}())

function memory_stats(dev::HIPDevice = AMDGPU.device())
    Base.lock(MEMORY_STATS) do ms
        get!(() -> MemoryStats(), ms, HIP.device_id(dev))
    end
end

function account!(stats::MemoryStats, bytes::Integer)
    Base.@atomic stats.live += bytes
end

function maybe_collect(; blocking::Bool = false)
    stats = memory_stats()
    current_time = time()

    if current_time - stats.last_updated > 10
        # Use hard memory limit if set.
        max_size = hard_memory_limit()
        # Otherwise estimate from current usage.
        if max_size == typemax(UInt64)
            dev = device()
            pool = Mem.pool_create(dev)
            max_size = free() + stats.live +
                (HIP.reserved_memory(pool) - HIP.used_memory(pool))
        end

        Base.@atomic stats.size = max_size
        Base.@atomic stats.last_updated = current_time
    end

    # Check if we are under memory pressure.
    pressure = stats.live / stats.size
    min_pressure = blocking ? 0.5 : 0.75
    pressure < min_pressure && return

    # Check that we don't collect too often.
    gc_rate = stats.last_gc_time / (current_time - stats.last_time)
    # Tolerate 5% GC time.
    max_gc_rate = 0.05
    # If freed a lot of memory last time, double max GC rate.
    (stats.last_freed > 0.1 * stats.size) && (max_gc_rate *= 2;)
    # Be more aggressive if we are going to block.
    blocking && (max_gc_rate *= 2;)

    # And even more if we are at a limit.
    pressure > 0.9 && (max_gc_rate *= 2;)
    pressure > 0.95 && (max_gc_rate *= 2;)
    gc_rate > max_gc_rate && return

    # Call the GC.
    Base.@atomic stats.last_time = current_time
    pre_gc_live = stats.live
    gc_time = Base.@elapsed GC.gc(false)
    post_gc_live = stats.live

    # Update stats.
    freed = pre_gc_live - post_gc_live
    Base.@atomic stats.last_freed = freed
    # Smooth out GC times.
    Base.@atomic stats.last_gc_time = 0.75 * stats.last_gc_time + 0.25 * gc_time
    return
end
