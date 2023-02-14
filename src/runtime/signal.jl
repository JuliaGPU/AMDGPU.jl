const DEFAULT_SIGNAL_TIMEOUT = Ref{Union{Float64, Nothing}}(nothing)

const SIGNAL_TIMEOUT_KILL_QUEUE = Ref{Bool}(true)

mutable struct ROCSignal
    signal::HSA.Signal
end

struct SignalTimeoutException <: Exception
    signal::ROCSignal
end

Adapt.adapt_structure(::Adaptor, sig::ROCSignal) = sig.signal

const ALLOC_SIGNAL_LOCK = Threads.ReentrantLock()
const ALLOC_SIGNAL_POOL = Set{HSA.Signal}()
set_alloc_signal_pool_max!(num::Integer) =
    @set_preferences!("alloc_signal_pool_max"=>num)
const ALLOC_SIGNAL_POOL_MAX = let
    if haskey(ENV, "JULIA_AMDGPU_ALLOC_SIGNAL_POOL_MAX")
        num = ENV["JULIA_AMDGPU_ALLOC_SIGNAL_POOL_MAX"]
        set_alloc_signal_pool_max!(num)
        num
    else
        @load_preference("alloc_signal_pool_max", 128)
    end
end

"""
    ROCSignal(init::Integer = 1; pooled::Bool=true, ipc::Bool=false) -> ROCSignal

Acquires an HSA signal object which can be used to communicate values between
the host and device.

- `pooled::Bool`: If `true`, the signal may be taken from an existing pool of
    signals; if `false`, or if the pool is empty, the signal is allocated from HSA.
- `ipc::Bool`: If `true`, signal may be used for interprocess communication.
    IPC signals can be read, written, and waited on from any process.
"""
function ROCSignal(init::Integer = 1; pooled::Bool=true, ipc::Bool=false)
    if ipc
        pooled = false
    end
    if !pooled
        @goto alloc_signal
    end

    # Try to fetch a signal from the pool
    signal_ref = lock(ALLOC_SIGNAL_LOCK) do
        if length(ALLOC_SIGNAL_POOL) > 0
            return Ref(pop!(ALLOC_SIGNAL_POOL))
        end
        return nothing
    end
    if signal_ref !== nothing
        HSA.signal_store_relaxed(signal_ref[], Int64(init))
        @goto return_signal
    end

    # Allocate a new signal from HSA
    @label alloc_signal
    alloc_id = rand(UInt64)
    @log_start(:alloc_signal, (;alloc_id), nothing)
    signal_ref = Ref{HSA.Signal}()
    if ipc
        attrs = UInt32(0)
        ipc && (attrs |= HSA.AMD_SIGNAL_IPC;)
        HSA.amd_signal_create(Int64(init), 0, C_NULL, attrs, signal_ref) |> check
    else
        HSA.signal_create(Int64(init), 0, C_NULL, signal_ref) |> check
    end
    @log_finish(:alloc_signal, (;alloc_id), (;signal=signal_ref[].handle))
    AMDGPU.hsaref!()

    @label return_signal
    signal = ROCSignal(signal_ref[])
    finalizer(signal) do s
        @log_start(:free_signal, (;signal=get_handle(s)), nothing)
        # TODO: Not finalizer safe
        lock(ALLOC_SIGNAL_LOCK) do
            if pooled && length(ALLOC_SIGNAL_POOL) < ALLOC_SIGNAL_POOL_MAX
                push!(ALLOC_SIGNAL_POOL, s.signal)
            else
                HSA.signal_destroy(s.signal) |> check
                AMDGPU.hsaunref!()
            end
        end
        @log_finish(:free_signal, (;signal=get_handle(s)), nothing)
    end
    return signal
end

get_handle(signal::ROCSignal) = signal.signal.handle

load_acquire(signal::ROCSignal) = HSA.signal_load_scacquire(signal.signal)

Base.isdone(signal::ROCSignal) = load_acquire(signal) < 1

Base.show(io::IO, signal::ROCSignal) =
    print(io, "ROCSignal($(repr(get_handle(signal))))")

function Base.wait(
    signal::ROCSignal; timeout::Union{Real, Nothing} = DEFAULT_SIGNAL_TIMEOUT[],
    min_latency::Int64 = 1_000, # 1 micro-second
    queue = nothing,
)
    has_timeout = !isnothing(timeout)
    has_timeout && (timeout < 0) && error(
        "Timeout `$timeout` must be a positive real value or `nothing`.")

    start_time = time_ns()
    finished = false

    GC.@preserve signal while !finished
        @assert AMDGPU.HSA_REFCOUNT[] > 0
        v = HSA.signal_wait_scacquire(
            signal.signal, HSA.SIGNAL_CONDITION_LT, 1,
            min_latency, HSA.WAIT_STATE_BLOCKED)
        finished = v == 0

        while !finished
            finished = 0 == HSA.signal_wait_scacquire(
                signal.signal, HSA.SIGNAL_CONDITION_LT, 1,
                min_latency, HSA.WAIT_STATE_BLOCKED)

            if has_timeout && !finished
                diff_time = (time_ns() - start_time) / 1e9
                (diff_time > timeout) && throw(SignalTimeoutException(signal))
            end

            if queue !== nothing && queue.status !== HSA.STATUS_SUCCESS
                throw(QueueError(queue))
            end

            # Allow another scheduled task to run.
            # This is especially needed in the case
            # when kernels need to perform HostCalls.
            yield()
        end
    end

    return
end

function Base.wait(signal::HSA.Signal; timeout = DEFAULT_SIGNAL_TIMEOUT[])
    wait(ROCSignal(signal); timeout)
end

Base.notify(signal::ROCSignal) = HSA.signal_store_screlease(signal.signal, 0)
