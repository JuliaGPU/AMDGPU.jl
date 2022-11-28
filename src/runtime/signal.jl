const DEFAULT_SIGNAL_TIMEOUT = Ref{Union{Float64, Nothing}}(nothing)

const SIGNAL_TIMEOUT_KILL_QUEUE = Ref{Bool}(true)

mutable struct ROCSignal
    signal::Ref{HSA.Signal}
end

struct SignalTimeoutException <: Exception
    signal::ROCSignal
end

Adapt.adapt_structure(::Adaptor, sig::ROCSignal) = sig.signal[]

"""
    ROCSignal(init::Integer = 1; ipc::Bool=true) -> ROCSignal

Allocates an HSA signal object which can be used to communicate values
between the host and device.

- `ipc::Bool`: If `true` signal may be used for interprocess communication.
    IPC signals can be read, written, and waited on from any process.
"""
function ROCSignal(init::Integer = 1; ipc::Bool = true)
    signal = ROCSignal(Ref{HSA.Signal}())
    alloc_id = rand(UInt64)
    @log_start(:alloc_signal, (;alloc_id), nothing)
    if ipc
        attrs = UInt32(0)
        ipc && (attrs |= HSA.AMD_SIGNAL_IPC;)

        HSA.amd_signal_create(
            Int64(init), 0, C_NULL, attrs, signal.signal) |> check
    else
        HSA.signal_create(Int64(init), 0, C_NULL, signal.signal) |> check
    end
    @log_finish(:alloc_signal, (;alloc_id), (;signal=get_handle(signal)))

    AMDGPU.hsaref!()
    finalizer(signal) do s
        @log_start(:free_signal, (;signal=get_handle(s)), nothing)
        HSA.signal_destroy(s.signal[]) |> check
        @log_finish(:free_signal, (;signal=get_handle(s)), nothing)
        AMDGPU.hsaunref!()
    end
    signal
end

ROCSignal(signal::HSA.Signal) = ROCSignal(Ref(signal))

get_handle(signal::ROCSignal) = signal.signal[].handle

load_acquire(signal::ROCSignal) = HSA.signal_load_scacquire(signal.signal[])

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

    GC.@preserve signal begin
        handle = signal.signal[]::HSA.Signal

        while !finished
            finished = 0 == HSA.signal_wait_scacquire(
                handle, HSA.SIGNAL_CONDITION_LT, 1,
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

Base.notify(signal::ROCSignal) = HSA.signal_store_screlease(signal.signal[], 0)
