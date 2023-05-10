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

const ALL_ALLOCS = Threads.Atomic{Int64}(0)

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
        Must be in (0, 100] range.
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

const HARD_MEMORY_LIMIT = parse_memory_limit(
    @load_preference("hard_memory_limit", "none"))

function ensure_enough_memory!(bytesize::Int)
    HARD_MEMORY_LIMIT == typemax(Int) && return

    function is_compact()
        # Ensure allocations tracked on the Julia side stay within limit.
        compact_allocs = (ALL_ALLOCS[] + bytesize ≤ HARD_MEMORY_LIMIT)
        # Ensure memory pool stays within hard limit.
        compact_pool = free() - bytesize ≥ total() - HARD_MEMORY_LIMIT
        compact_allocs, compact_pool
    end

    compact_allocs, compact_pool = is_compact()
    status = (compact_allocs && compact_pool) ?
        HSA.STATUS_SUCCESS : HSA.STATUS_ERROR_OUT_OF_RESOURCES
    status == HSA.STATUS_SUCCESS && return

    stream = AMDGPU.stream()
    pool = HIP.memory_pool(stream.device)

    phase = 1
    while true
        if phase == 1
            if !compact_allocs
                AMDGPU.synchronize(; errors=false)
                GC.gc(false)
            end
            HIP.synchronize(stream)
            compact_pool || HIP.trim(pool, HARD_MEMORY_LIMIT - bytesize)
        elseif phase == 2
            compact_pool || HIP.trim(pool, max(0, HARD_MEMORY_LIMIT - bytesize * 2))
        elseif phase == 3
            compact_pool || HIP.trim(pool, HARD_MEMORY_LIMIT ÷ 2)
        elseif phase == 4
            AMDGPU.synchronize(; errors=false)
            GC.gc(true)
            HIP.synchronize(stream)
            compact_pool || HIP.trim(pool, max(0, HARD_MEMORY_LIMIT ÷ 2))
        elseif phase == 5 # Last attempt to stay within limits.
            HIP.reclaim()
        else
            break
        end
        phase += 1

        compact_allocs, compact_pool = is_compact()
        # TODO !compact_allocs && (1 < phase < 4) && (phase = 4;)
        status = (compact_allocs && compact_pool) ?
            HSA.STATUS_SUCCESS : HSA.STATUS_ERROR_OUT_OF_RESOURCES
        status == HSA.STATUS_SUCCESS && break
    end
    status |> check
    return
end

function alloc_or_retry!(f)
    status = f()
    status == HSA.STATUS_SUCCESS && return

    stream = AMDGPU.stream()

    phase = 1
    while true
        if phase == 1
            HIP.synchronize(stream)
        elseif phase == 2
            HIP.device_synchronize()
        elseif phase == 3
            @assert false
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

        status = f()
        status == HSA.STATUS_SUCCESS && break
    end
    check(status)
    return
end

"""
Allocate linear memory on the device and return a buffer to the allocated memory. The
allocated memory is suitably aligned for any kind of variable. The memory will not be freed
automatically, use [`free(::Buffer)`](@ref) for that.
"""
function alloc end

"""
Free device memory.
"""
function free end

"""
Initialize device memory with a repeating value.
"""
function set! end

"""
Upload memory from host to device.
Executed asynchronously on `queue` if `async` is true.
"""
function upload end
@doc (@doc upload) upload!

"""
Download memory from device to host.
Executed asynchronously on `queue` if `async` is true.
"""
function download end
@doc (@doc download) download!

"""
Transfer memory from device to device.
Executed asynchronously on `queue` if `async` is true.
"""
function transfer end
@doc (@doc transfer) transfer!
