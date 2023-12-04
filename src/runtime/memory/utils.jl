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

function parse_memory_limit(limit_str::String)
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

    limit
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

function alloc_or_retry!(f, isfailed; stream::HIP.HIPStream)
    res = f()
    isfailed(res) || return res

    phase = 1
    while true
        if phase == 1
            HIP.synchronize(stream)
        elseif phase == 2
            HIP.device_synchronize()
        elseif phase == 3
            GC.gc(false)
            HIP.device_synchronize()
        elseif phase == 4
            GC.gc(true)
            HIP.device_synchronize()
        elseif phase == 5
            HIP.trim(HIP.memory_pool(stream.device))
        else
            break
        end
        phase += 1

        res = f()
        isfailed(res) || break
    end

    if isfailed(res)
        pool = HIP.memory_pool(stream.device)
        error("""
        Failed to successfully execute function and free resources for it.
        Reporting current memory usage:
        - HIP pool used: $(Base.format_bytes(HIP.used_memory(pool))).
        - HIP pool reserved: $(Base.format_bytes(HIP.reserved_memory(pool))).
        - Hard memory limit: $(Base.format_bytes(hard_memory_limit())).
        """)
    end
    return res
end
