const DEFAULT_SIGNAL_TIMEOUT = Ref{Union{Float64, Nothing}}(nothing)

const SIGNAL_TIMEOUT_KILL_QUEUE = Ref{Bool}(true)

struct SignalPool
    pool::Set{HSA.Signal}
    max_size::Int
end
SignalPool() = SignalPool(Set{HSA.Signal}(), @load_preference("signal_pool_max_size", 128))

const SIGNAL_POOL = LockedObject(SignalPool())

function set_signal_pool_size!(num::Integer)
    @set_preferences!("signal_pool_max_size" => num)
    @info """Successfully set signal pool max size to `$num`.
    Reset your Julia session for changes to take effect."""
end

function get_pool_signal!()::Union{HSA.Signal, Nothing}
    lock(SIGNAL_POOL) do pool
        isempty(pool.pool) ? nothing : pop!(pool.pool)
    end
end

"""
Return `true` if destroyed a signal, otherwise `false`.
If `destroy=true` then destroy signal immediately.
"""
function free_pool_signal!(signal::HSA.Signal; destroy::Bool)::Bool
    destroy && (check(HSA.signal_destroy(signal)); return true)
    lock(SIGNAL_POOL) do pool
        destroy = length(pool.pool) < pool.max_size
        destroy ?
            check(HSA.signal_destroy(signal)) :
            push!(pool.pool, signal)
        destroy
    end
end

mutable struct ROCSignal
    signal::HSA.Signal
end
Adapt.adapt_structure(::Adaptor, sig::ROCSignal) = sig.signal

struct SignalTimeoutException <: Exception
    signal::ROCSignal
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
function ROCSignal(init::Int64 = 1; pooled::Bool = true, ipc::Bool = false)
    pooled = ipc ? false : pooled
    raw_signal = pooled ? get_pool_signal!() : nothing

    if isnothing(raw_signal)
        signal_ref = Ref{HSA.Signal}()
        check(ipc ?
            HSA.amd_signal_create(init, 0, C_NULL, HSA.AMD_SIGNAL_IPC, signal_ref) :
            HSA.signal_create(init, 0, C_NULL, signal_ref))
        raw_signal = signal_ref[]
    else
        HSA.signal_store_relaxed(raw_signal, init)
    end

    AMDGPU.hsaref!()
    signal = ROCSignal(raw_signal)
    finalizer(signal) do signal
        # Destroy if not using pool, otherwise return to pool.
        destroyed = free_pool_signal!(signal.signal; destroy=!pooled)
        destroyed && AMDGPU.hsaunref!()
    end
    signal
end

get_handle(signal::ROCSignal) = signal.signal.handle

load_acquire(signal::ROCSignal) = HSA.signal_load_scacquire(signal.signal)

Base.isdone(signal::ROCSignal) = load_acquire(signal) < 1

Base.show(io::IO, signal::ROCSignal) =
    print(io, "ROCSignal($(repr(get_handle(signal))))")

function Base.wait(
    signal::ROCSignal; timeout::Union{Real, Nothing} = DEFAULT_SIGNAL_TIMEOUT[],
    min_latency::Int64 = 1_000, #= 1 micro-second =#
    queue = nothing,
)
    has_timeout = !isnothing(timeout)
    has_timeout && (timeout < 0) && error(
        "Timeout `$timeout` must be a positive real value or `nothing`.")

    start_time = time_ns()
    finished = false

    GC.@preserve signal while !finished
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

function Base.wait(signal::HSA.Signal; timeout = DEFAULT_SIGNAL_TIMEOUT[])
    wait(ROCSignal(signal); timeout)
end

Base.notify(signal::ROCSignal) = HSA.signal_store_screlease(signal.signal, 0)
