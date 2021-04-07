# Utilities for working with HSA signals

mutable struct HSASignal
    signal::Ref{Signal}
end

function HSASignal(init::Integer=1)
    signal = HSASignal(Ref{Signal}())
    HSA.signal_create(Int64(init), 0, C_NULL, signal.signal)
    hsaref!()
    finalizer(signal) do signal
        HSA.signal_destroy(signal.signal[]) |> check
        hsaunref!()
    end
    return signal
end
HSASignal(signal::HSA.Signal) = HSASignal(Ref(signal))

Adapt.adapt_structure(::Adaptor, sig::HSASignal) = sig.signal[]

"""
    Base.wait(signal::HSASignal; soft=true, minlat=0.001)

Waits on an `HSASignal` to decrease below 1.

Options:
- `soft::Bool`: Whether to use tasks to poll the signal, or to use HSA's
  (blocking) signal waiter. Note that the HSA waiter can block forward progress.
- `minlat::Real`: Minimum initial latency for the software waiter; lower values
  can decrease latency at the cost of increased polling load
- `timeout::Union{Real,Nothing}`: If not `nothing`, sets the timeout for the
  signal, after which the call will error.
- `backoff::Function`: Selects the backoff algorithm to use (default is clamped exponential)
"""
function Base.wait(signal::HSASignal; soft=true, minlat=0.001, timeout=nothing, backoff=WaitExpClamped(0.1,1))
    if soft
        ctr = 1
        waitlat = minlat
        start_time = time_ns()
        while true
            value = HSA.signal_load_scacquire(signal.signal[])
            if value < 1
                return
            end
            if timeout !== nothing
                now_time = time_ns()
                diff_time = (now_time - start_time) / 10^9
                if diff_time > timeout
                    error("Timeout while waiting on signal")
                end
            end
            ctr += 1
            waitlat = backoff(ctr, minlat)
            sleep(minlat)
        end
    else
        # Wait on the dispatch completion signal until the kernel is finished
        HSA.signal_wait_acquire(signal.signal[],
                                HSA.SIGNAL_CONDITION_LT, 1, typemax(UInt64),
                                HSA.WAIT_STATE_BLOCKED)
    end
end
Base.wait(signal::HSA.Signal; kwargs...) = wait(HSASignal(signal); kwargs...)

struct WaitLinear end
(::WaitLinear)(ctr, minlat) = minlat*x
struct WaitExpClamped
    scale::Float64
    ceil::Float64
end
(w::WaitExpClamped)(ctr, minlat) = Base.min(Base.exp(ctr*w.scale)*minlat,w.ceil)
# TODO: WaitSigmoidal
