const ALL_ALLOCS = Threads.Atomic{Int64}(0)

"""
Set a limit for total GPU memory allocations.

Remove setting from `LocalPreference.toml` to disable allocation limit.
"""
set_memory_alloc_limit!(limit::Integer) =
    @set_preferences!("memory_alloc_limit" => limit)

const MEMORY_ALLOC_LIMIT =
    @load_preference("memory_alloc_limit", typemax(Int))

function ensure_enough_memory!(bytesize::Int)
    MEMORY_ALLOC_LIMIT == typemax(Int) && return

    ALL_ALLOCS[] + bytesize ≤ MEMORY_ALLOC_LIMIT && return

    GC.gc(false)
    ALL_ALLOCS[] + bytesize ≤ MEMORY_ALLOC_LIMIT && return

    GC.gc(true)
    ALL_ALLOCS[] + bytesize ≤ MEMORY_ALLOC_LIMIT || error(
    """
    Not enough GPU memory.
    Requested: $(Base.format_bytes(bytesize)).
    Currently allocated: $(Base.format_bytes(ALL_ALLOCS[])).
    Current allocation limit: $(Base.format_bytes(MEMORY_ALLOC_LIMIT)).

    Use `set_memory_alloc_limit!` to change or disable allocation limit.
    """)
end

function alloc_or_retry!(f)
    for phase in 1:3
        if phase == 2
            GC.gc(false)
            yield()
        elseif phase == 3
            GC.gc(true)
            yield()
        end

        status = f()
        @debug "Allocation phase $phase: $status"

        if status == HSA.STATUS_SUCCESS
            break
        elseif status == HSA.STATUS_ERROR_OUT_OF_RESOURCES || status == HSA.STATUS_ERROR_INVALID_ALLOCATION
            phase == 3 && check(status)
        else
            check(status)
        end
    end
end

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
used() = total()-free()

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
