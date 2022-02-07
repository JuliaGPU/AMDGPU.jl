"Tracks HSA signals and HIP streams to sync against."
struct SyncState
    signals::Vector{HSAStatusSignal}
    streams::Vector{Ptr{Cvoid}}
end
SyncState() = SyncState(HSAStatusSignal[], Ptr{Cvoid}[])

struct WaitAdaptor end
struct MarkAdaptor{S}
    s::S
end

function wait!(ss::SyncState)
    # FIXME: Use barrier_and on dedicated queue
    foreach(wait, ss.signals)
    empty!(ss.signals)
    if hip_configured
        foreach(HIP.hipStreamSynchronize, ss.streams)
        empty!(ss.streams)
        HIP.hipStreamSynchronize(C_NULL) # FIXME: This shouldn't be necessary
    end
    nothing
end
mark!(ss::SyncState, signal::HSAStatusSignal) = push!(ss.signals, signal)
mark!(ss::SyncState, stream::Ptr{Cvoid}) = push!(ss.streams, stream)

wait!(x) = adapt(WaitAdaptor(), x)
mark!(x, s) = adapt(MarkAdaptor(s), x)
