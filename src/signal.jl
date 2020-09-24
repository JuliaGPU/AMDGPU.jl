# Utilities for working with HSA signals

mutable struct HSASignal
    signal::Ref{Signal}
end

function HSASignal()
    signal = HSASignal(Ref{Signal}())
    HSA.signal_create(1, 0, C_NULL, signal.signal)
    hsaref!()
    finalizer(signal) do signal
        HSA.signal_destroy(signal.signal[]) |> check
        hsaunref!()
    end
    return signal
end

"""
    Base.wait(signal::HSASignal; soft=true, minlat=0.01)

Waits on an `HSASignal` to decrease below 1. If `soft=true` (default), uses
tasks to poll the signal, otherwise uses HSA's signal waiter. `minlat` sets
the minimum latency for the software waiter; lower values can decrease latency
at the cost of increased polling load.
"""
function Base.wait(signal::HSASignal; soft=true, minlat=0.01)
    if soft
        while true
            value = HSA.signal_load_scacquire(signal.signal[])
            if value < 1
                return
            end
            sleep(minlat)
        end
    else
        # Wait on the dispatch completion signal until the kernel is finished
        HSA.signal_wait_acquire(signal.signal[],
                                HSA.SIGNAL_CONDITION_LT, 1, typemax(UInt64),
                                HSA.WAIT_STATE_BLOCKED)
    end
end

