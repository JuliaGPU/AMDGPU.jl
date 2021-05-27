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
    Base.wait(signal::HSASignal; soft=true, minlat=0.01)

Waits on an `HSASignal` to decrease below 1. If `soft=true` (default), uses
tasks to poll the signal, otherwise uses HSA's signal waiter. `minlat` sets
the minimum latency for the software waiter; lower values can decrease latency
at the cost of increased polling load. `timeout`, if not `nothing`, sets the
timeout for the signal, after which the call will error.
"""
function Base.wait(signal::HSASignal; soft=true, minlat=0.01, timeout=nothing)
    if soft
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
            # sleep(minlat)
	    yield()
        end
    else
        # Wait on the dispatch completion signal until the kernel is finished
        HSA.signal_wait_acquire(signal.signal[],
                                HSA.SIGNAL_CONDITION_LT, 1, typemax(UInt64),
                                HSA.WAIT_STATE_BLOCKED)
    end
end

Base.wait(signal::HSA.Signal; kwargs...) = wait(HSASignal(signal); kwargs...)
