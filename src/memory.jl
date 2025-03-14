"""
    info()

Returns a tuple of two integers, indicating respectively the free and total
amount of memory (in bytes) available for allocation on the device.
"""
function info()
    free_ref = Ref{Csize_t}()
    total_ref = Ref{Csize_t}()
    HIP.hipMemGetInfo(free_ref, total_ref)
    return convert(Int, free_ref[]), convert(Int, total_ref[])
end

"""
    free()

Returns the free amount of memory (in bytes),
available for allocation on the device.
"""
free() = info()[1]

"""
    total()

Returns the total amount of memory (in bytes),
available for allocation on the device.
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
hard_memory_limit!(limit::String) =
    @set_preferences!("hard_memory_limit" => limit)

soft_memory_limit!(limit::String) =
    @set_preferences!("soft_memory_limit" => limit)

const HARD_MEMORY_LIMIT = Ref{Union{Nothing, UInt64}}(nothing)
function hard_memory_limit()
    hard_limit = HARD_MEMORY_LIMIT[]
    hard_limit ≢ nothing && return hard_limit

    hard_limit = parse_memory_limit(
        @load_preference("hard_memory_limit", "none"))

    @debug "Setting hard memory limit: $(Base.format_bytes(hard_limit))"
    HARD_MEMORY_LIMIT[] = hard_limit
end

const SOFT_MEMORY_LIMIT = Ref{Union{Nothing, UInt64}}(nothing)
function soft_memory_limit()
    soft_limit = SOFT_MEMORY_LIMIT[]
    soft_limit ≢ nothing && return soft_limit

    soft_limit = parse_memory_limit(
        @load_preference("soft_memory_limit", "none"))

    @debug "Setting soft memory limit: $(Base.format_bytes(soft_limit))"
    SOFT_MEMORY_LIMIT[] = soft_limit
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
    ms = MEMORY_STATS.payload
    did = HIP.device_id(dev)

    stats = get(ms, did, nothing)
    stats ≡ nothing || return stats

    Base.@lock MEMORY_STATS.lock begin
        get!(() -> MemoryStats(), ms, did)
    end
end

function account!(stats::MemoryStats, bytes::Integer)
    Base.@atomic stats.live += bytes
end

const EAGER_GC::Ref{Bool} = Ref{Bool}(@load_preference("eager_gc", true))

function eager_gc!(flag::Bool)
    global EAGER_GC[] = flag
    @set_preferences!("eager_gc" => flag)
end

function maybe_collect(; blocking::Bool = false)
    EAGER_GC[] || return

    stats = memory_stats()
    current_time = time()

    if current_time - stats.last_updated > 10
        # Use hard memory limit if set.
        max_size = hard_memory_limit()
        # Otherwise estimate from current usage.
        if max_size == typemax(UInt64)
            dev = device()
            pool = Mem.pool_create(dev)
            free_mem = try
                free()
            catch e
                if e isa HIPError
                    @warn "Failed to query amount of `free()` memory. Disabling eager GC."
                    EAGER_GC[] = false
                    return
                else
                    rethrow(e)
                end
            end
            max_size = free_mem + stats.live +
                (HIP.reserved_memory(pool) - HIP.used_memory(pool))
        end

        Base.@atomic stats.size = max_size
        Base.@atomic stats.last_updated = current_time
    end

    # Check if we are under memory pressure.
    pressure = stats.live / stats.size
    min_pressure = blocking ? 0.5 : 0.75
    pressure < min_pressure && return

    # TODO take allocations into account
    #   if pressure is high but we didn't allocate - don't collect
    #   otherwise try hard

    # Check that we don't collect too often.
    gc_rate = stats.last_gc_time / (current_time - stats.last_time)
    # Tolerate 5% GC time.
    max_gc_rate = 0.05
    # If freed a lot of memory last time, double max GC rate.
    (stats.last_freed > 0.1 * stats.size) && (max_gc_rate *= 2;)
    # Be more aggressive if we are going to block.
    blocking && (max_gc_rate *= 2;)

    # And even more if the pressure is high.
    pressure > 0.9 && (max_gc_rate *= 2;)
    pressure > 0.95 && (max_gc_rate *= 2;)
    gc_rate > max_gc_rate && return

    Base.@atomic stats.last_time = current_time

    # Call the GC.
    pre_gc_live = stats.live
    gc_time = Base.@elapsed GC.gc(false)
    post_gc_live = stats.live

    # Update stats.
    freed = pre_gc_live - post_gc_live
    Base.@atomic stats.last_freed = freed
    Base.@atomic stats.last_gc_time = 0.75 * stats.last_gc_time + 0.25 * gc_time
    return
end

# TODO handle stream capturing when we support HIP graphs
mutable struct Managed{M}
    const mem::M
    stream::HIPStream
    dirty::Bool

    function Managed(mem; stream=AMDGPU.stream(), dirty=true)
        new{typeof(mem)}(mem, stream, dirty)
    end
end

function synchronize(m::Managed)
    m.dirty || return
    synchronize(m.stream)
    m.dirty = false
    return
end

Base.sizeof(m::Managed) = sizeof(m.mem)

function Base.convert(::Type{Ptr{T}}, managed::Managed{M}) where {T, M}
    strm = AMDGPU.stream()

    # TODO handle stream capture

    # TODO handle access on another device
    # if M == Mem.HIPBuffer && managed.mem.ctx != tls.ctx
    #     # Enable peer-to-peer access.
    # end

    if managed.stream != strm
        synchronize(managed)
        managed.stream = strm
    end

    managed.dirty = true
    # TODO introduce HIPPtr to differentiate
    if M <: Mem.HIPBuffer
        convert(Ptr{T}, managed.mem)
    else
        convert(Ptr{T}, managed.mem.dev_ptr)
    end
end

# TODO workaround until we have HIPPtr
function Base.convert(::Type{Mem.AbstractAMDBuffer}, managed::Managed{M}) where M
    strm = AMDGPU.stream()

    # TODO handle stream capture

    # TODO handle access on another device
    # if M == Mem.HIPBuffer && managed.mem.ctx != tls.ctx
    #     # Enable peer-to-peer access.
    # end

    if managed.stream != strm
        synchronize(managed)
        managed.stream = strm
    end

    managed.dirty = true
    return managed.mem
end

function pool_alloc(::Type{B}, bytesize) where B
    s = AMDGPU.stream()
    # @info "[pool_alloc] $(Base.format_bytes(bytesize))"
    # display(stacktrace()); println()
    # println()
    # println()
    Managed(B(bytesize; stream=s); stream=s)
end

function pool_free(managed::Managed{M}) where M
    _pool_free(managed.mem, managed.stream)
end

function _pool_free(buf, stream::HIPStream)
    if !HIP.isvalid(stream)
        stream = AMDGPU.default_stream()
    end
    context!(() -> Mem.free(buf; stream), buf.ctx)
end
