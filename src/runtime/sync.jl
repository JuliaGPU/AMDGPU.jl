import ..AMDGPU: hip_configured

"Tracks HSA signals and HIP streams to sync against."
mutable struct SyncState
    signals::Vector{ROCKernelSignal}
    events::Vector{HIP.HIPEvent}
    lock::Threads.ReentrantLock

    same_queue::Bool
    same_stream::Bool
end
SyncState() = SyncState(
    ROCKernelSignal[], HIP.HIPEvent[], Threads.ReentrantLock(), true, true)

struct WaitAdaptor end
struct HIPWaitAdaptor end
struct HSAWaitAdaptor end
struct MarkAdaptor{S}
    s::S
end

function wait!(ss::SyncState; hip::Bool = true, hsa::Bool = true)
    lock(ss.lock) do
        # Force HSA wait if there are streams or if there are different queues.
        hsa = hsa || !isempty(ss.events) || !ss.same_queue
        # Force HIP wait if there are signals or if there are different streams.
        hip = hip || !isempty(ss.signals) || !ss.same_stream

        if hsa
            foreach(wait, ss.signals)
            empty!(ss.signals)
        else
            # If not waiting on HSA, keep last signal if any.
            # This will force a syncronization if HSA kernel is still running,
            # but HIP stream was added to syncstate.
            isempty(ss.signals) || (ss.signals = [last(ss.signals)];)
        end
        ss.same_queue = true

        if hip
            foreach(AMDGPU.HIP.synchronize, ss.events)
            empty!(ss.events)
        else
            # If not waiting on HIP, keep last stream if any.
            # This will force a syncronization if HIP kernel is still running,
            # but HSA signal was added to syncstate.
            isempty(ss.events) || (ss.events = [last(ss.events)];)
        end
        ss.same_stream = true
    end
    return
end

function mark!(ss::SyncState, signal::ROCKernelSignal)
    lock(ss.lock) do
        if isempty(ss.signals)
            push!(ss.signals, signal)
        else
            last_signal = last(ss.signals)
            # Add new signal only if it is not the same as the last one.
            if last_signal.signal != signal.signal
                ss.same_queue &= last_signal.queue == signal.queue
                push!(ss.signals, signal)
            end
        end
    end
end

function mark!(ss::SyncState, event::HIP.HIPEvent)
    lock(ss.lock) do
        if !isempty(ss.events)
            last_event = last(ss.events)
            last_event.stream != event.stream && (ss.same_stream &= false;)
        end
        push!(ss.events, event)
    end
end

wait!(x) = Adapt.adapt(WaitAdaptor(), x)
mark!(x, s) = Adapt.adapt(MarkAdaptor(s), x) # TODO constrain type of `s`

"""
Wait on HIP streams in syncstate if any.
Otherwise, rely on HSA queue serialization.
"""
hip_wait!(x) = Adapt.adapt(HIPWaitAdaptor(), x)
"""
Wait in HSA signals in syncstate if any.
Otherwise, rely on HIP stream serialization.
"""
hsa_wait!(x) = Adapt.adapt(HSAWaitAdaptor(), x)
