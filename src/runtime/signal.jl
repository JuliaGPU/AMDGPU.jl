const DEFAULT_SIGNAL_TIMEOUT = Ref{Float64}(-1)

const SIGNAL_TIMEOUT_KILL_QUEUE = Ref{Bool}(true)

mutable struct ROCSignal
    signal::Ref{HSA.Signal}
end

struct SignalTimeoutException <: Exception
    signal::ROCSignal
end

Adapt.adapt_structure(::Adaptor, sig::ROCSignal) = sig.signal[]

"""
- `ipc::Bool`: If `true` signal may be used for interprocess communication.
    IPC signals can be read, written, and waited on from any process.
"""
function ROCSignal(init::Integer = 1; interrupt::Bool = true, ipc::Bool = true)
    signal = ROCSignal(Ref{HSA.Signal}())
    if interrupt || ipc
        attrs = UInt32(0)
        ipc && (attrs |= HSA.AMD_SIGNAL_IPC;)

        HSA.amd_signal_create(
            Int64(init), 0, C_NULL, attrs, signal.signal) |> check
    else
        HSA.signal_create(Int64(init), 0, C_NULL, signal.signal) |> check
    end

    AMDGPU.hsaref!()
    finalizer(signal) do s
        HSA.signal_destroy(s.signal[]) |> check
        AMDGPU.hsaunref!()
    end
    signal
end

ROCSignal(signal::HSA.Signal) = ROCSignal(Ref(signal))

get_handle(signal::ROCSignal) = signal.signal[].handle

function is_done(signal::ROCSignal)
    value = HSA.signal_load_scacquire(signal.signal[])
    value < 1
end

function get_value(signal::ROCSignal)
    HSA.signal_load_scacquire(signal.signal[])
end

Base.show(io::IO, signal::ROCSignal) =
    print(io, "ROCSignal($(signal.signal[]))")

function Base.wait(signal::ROCSignal; timeout::Real = DEFAULT_SIGNAL_TIMEOUT[])
    has_timeout = sign(timeout) == 1
    min_latency = 1_000 # 1 micro-second.

    start_time = time_ns()
    finished = false

    while !finished
        v = HSA.signal_wait_scacquire(
            signal.signal[], HSA.SIGNAL_CONDITION_LT, 1,
            min_latency, HSA.WAIT_STATE_BLOCKED)
        finished = v == 0

        if has_timeout && !finished
            diff_time = (time_ns() - start_time) / 1e9
            (diff_time > timeout) && throw(SignalTimeoutException(signal))
        end

        # Allow another scheduled task to run.
        # This is especially needed in the case
        # when kernels need to perform HostCalls.
        yield()
    end
    nothing
end

function Base.wait(signal::HSA.Signal; timeout = DEFAULT_SIGNAL_TIMEOUT[])
    wait(ROCSignal(signal); timeout)
end

Base.notify(signal::ROCSignal) = HSA.signal_store_screlease(signal.signal[], 0)
