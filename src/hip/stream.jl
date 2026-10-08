const use_nonblocking_synchronize = Preferences.@load_preference(
    "nonblocking_synchronization", true)

mutable struct HIPStream
    stream::hipStream_t
    priority::Symbol
    device::HIPDevice
    ctx::HIPContext

    Base.@atomic valid::Bool

    # bumped when the stream is handed to another task (see `task_stream`), which only
    # happens when it is idle, so work submitted during earlier generations has finished.
    Base.@atomic generation::Int
end

"""
    HIPStream(priority::Symbol = :normal)

# Arguments:

- `priority::Symbol`: Priority of the stream: `:normal`, `:high` or `:low`.

Create HIPStream with given priority.
Device is the default device that's currently in use.
"""
function HIPStream(priority::Symbol = :normal)
    priority_int = symbol_to_priority(priority)

    stream_ref = Ref{hipStream_t}()
    hipStreamCreateWithPriority(stream_ref, 0, priority_int)
    d = device()
    stream = HIPStream(stream_ref[], priority, d, HIPContext(d), true, 0)
    return finalizer(stream) do s
        Base.@atomic s.valid = false
        AMDGPU.context!(s.ctx) do
            hipStreamDestroy(s.stream)
        end
    end
end

# Every task gets its own default stream, but HIP streams are expensive: creating one
# takes milliseconds and pins ~8 MiB of host memory. Since the GC is in no hurry to
# collect finished tasks (and with them, their streams), code that spawns many
# short-lived tasks would pile up thousands of streams. Instead, recycle the streams of
# tasks that have finished, keeping up to `STREAM_POOL_IDLE` unused ones per device and
# priority.
const STREAM_POOL_IDLE = 32
struct PooledStream
    stream::HIPStream
    owner::WeakRef
end
const STREAM_POOLS = Dict{Tuple{Int,Symbol}, Vector{PooledStream}}()
const STREAM_POOL_LOCK = ReentrantLock()

function task_stream(priority::Symbol = :normal)
    # finalizers can't wait for the pool's lock, so give them a stream of their own
    GC.in_finalizer() && return HIPStream(priority)

    key = (device_id(device()), priority)
    task = current_task()
    stream = Base.@lock STREAM_POOL_LOCK begin
        claim_stream!(get!(Vector{PooledStream}, STREAM_POOLS, key), task)
    end
    stream === nothing || return stream

    # creating a stream can be slow, so don't make other tasks wait for it
    stream = HIPStream(priority)
    Base.@lock STREAM_POOL_LOCK begin
        push!(STREAM_POOLS[key], PooledStream(stream, WeakRef(task)))
    end
    return stream
end

function claim_stream!(pool::Vector{PooledStream}, task::Task)
    candidate = nothing
    idle = 0
    i = 1
    while i <= length(pool)
        entry = pool[i]
        owner = entry.owner.value
        keep = if owner === task
            # a task that switches back and forth between priorities keeps its streams
            isvalid(entry.stream) && return entry.stream
            false
        elseif owner !== nothing && !istaskdone(owner::Task)
            true
        elseif !isvalid(entry.stream)
            false
        else
            status = query(entry.stream)
            if status == hipErrorNotReady
                # don't make a new task wait for work that the previous owner left behind
                true
            elseif status != hipSuccess
                # the stream is in an error state
                false
            elseif candidate === nothing
                candidate = entry
                true
            else
                (idle += 1) <= STREAM_POOL_IDLE
            end
        end
        keep ? (i += 1) : deleteat!(pool, i)
    end
    candidate === nothing && return nothing

    candidate.owner.value = task
    generation = Base.@atomic :monotonic candidate.stream.generation
    Base.@atomic :release candidate.stream.generation = generation + 1
    return candidate.stream
end

# some API calls, like querying a stream, are prohibited while another stream is being
# captured in global mode, even when they don't interfere with the capture. `f` must not
# yield, because the capture mode is a property of the thread.
function relaxed_capture_mode(f)
    mode = Ref(hipStreamCaptureModeRelaxed)
    hipThreadExchangeStreamCaptureMode(mode)
    try
        return f()
    finally
        hipThreadExchangeStreamCaptureMode(mode)
    end
end

query(s::HIPStream) = relaxed_capture_mode(() -> unchecked_hipStreamQuery(s))

# only bumped while holding `STREAM_POOL_LOCK`, but read without it
generation(s::HIPStream) = Base.@atomic :acquire s.generation

isvalid(s::HIPStream) = s.valid

default_stream() = HIPStream(C_NULL, :normal, device(), HIPContext(), true, 0)

"""
    HIPStream(stream::hipStream_t)

Create HIPStream from `hipStream_t` handle.
Device is the default device that's currently in use.
"""
function HIPStream(stream::hipStream_t)
    # the streams of tasks get recycled, which only the pool's objects keep track of
    if !GC.in_finalizer()
        Base.@lock STREAM_POOL_LOCK begin
            for pool in values(STREAM_POOLS), entry in pool
                s = entry.stream
                s.stream == stream && isvalid(s) && return s
            end
        end
    end

    d = device()
    HIPStream(stream, priority(stream), d, HIPContext(d), true, 0)
end

function isdone(stream::HIPStream)
    isvalid(stream) || return true
    query = hipStreamQuery(stream)
    if query == hipSuccess
        return true
    elseif query == hipErrorNotReady
        return false
    else
        throw(HIPError(query))
    end
end

wait(stream::HIPStream) = hipStreamSynchronize(stream)

# same, but callable from any thread. this bypasses the task-local state, so select the
# caller's device ourselves: the null stream refers to the current device's.
function worker_synchronize(stream::HIPStream, dev::HIPDevice)
    isvalid(stream) || return hipSuccess
    res = unchecked_hipSetDevice(device_id(dev))
    res == hipSuccess || return res
    @gcsafe_ccall(libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t)
end

function synchronize(stream::HIPStream; blocking::Bool = false, spin::Bool = true)
    if GC.in_finalizer()
        # we can't switch tasks here, and the finalizer selected the context to use
        wait(stream)
    elseif use_nonblocking_synchronize && !blocking
        # wait on a worker thread, so that other tasks (e.g. hostcalls) can run on this one
        dev = AMDGPU.device()
        res = cooperative_wait(s -> worker_synchronize(s, dev), stream; isdone, spin)
        if res === nothing
            # polling found the stream done. synchronize anyway, which reports errors and
            # lets HIP release resources.
            wait(stream)
        else
            check(something(res))
            AMDGPU.maybe_collect(; blocking=true)
        end
    else
        AMDGPU.maybe_collect(; blocking=true)
        wait(stream)
    end
    return
end

Base.unsafe_convert(::Type{hipStream_t}, stream::HIPStream) = stream.stream
Base.unsafe_convert(::Type{Ptr{Cvoid}}, stream::HIPStream) = Ptr{Cvoid}(stream.stream)
Base.:(==)(a::HIPStream, b::HIPStream) = a.stream == b.stream
Base.hash(s::HIPStream, h::UInt) = hash(s.stream, h)

function Base.show(io::IO, stream::HIPStream)
    print(io, "HIPStream(device=$(stream.device), ptr=$(repr(UInt64(stream.stream))), priority=$(stream.priority))")
end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, stream::HIPStream)
    data = reshape([
        "$(repr(UInt64(stream.stream)))",
        "$(stream.priority)",
        "$(stream.device)",
    ], 1, :)
    PrettyTables.pretty_table(io, data; column_labels=["Ptr", "Priority", "Device"])
end

function priority_to_symbol(priority)
    priority ==  0 && return :normal
    priority == -1 && return :high
    priority ==  1 && return :low
    throw(ArgumentError("""
    Invalid HIP priority: $priority.
    Valid values are: 0, -1, 1.
    """))
end

function symbol_to_priority(priority::Symbol)
    priority == :normal && return Cint(0)
    priority == :high && return Cint(-1)
    priority == :low && return Cint(1)
    throw(ArgumentError("""
    Invalid HIP priority symbol: $priority.
    Valid values are: `:normal`, `:low`, `:high`.
    """))
end

function priority(stream::hipStream_t)
    priority = Ref{Cint}()
    hipStreamGetPriority(stream, priority)
    priority_to_symbol(priority[])
end
