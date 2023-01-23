import ..AMDGPU: hip_configured

"Tracks HSA signals and HIP streams to sync against."
struct SyncState
    signals::Vector{ROCKernelSignal}
    streams::Vector{Ptr{Cvoid}}
    lock::Threads.ReentrantLock
end
SyncState() =
    SyncState(ROCKernelSignal[],
              Ptr{Cvoid}[],
              Threads.ReentrantLock())

struct WaitAdaptor end
struct MarkAdaptor{S}
    s::S
end

function wait!(ss::SyncState)
    lock(ss.lock) do
        # FIXME: Use barrier_and on dedicated queue
        foreach(wait, ss.signals)
        empty!(ss.signals)
        @static if hip_configured
            for s in ss.streams
                AMDGPU.HIP.@check AMDGPU.HIP.hipStreamSynchronize(s)
            end
            empty!(ss.streams)
        end
    end
    return
end
mark!(ss::SyncState, signal::ROCKernelSignal) =
    lock(()->push!(ss.signals, signal), ss.lock)
mark!(ss::SyncState, stream::Ptr{Cvoid}) =
    lock(()->push!(ss.streams, stream), ss.lock)

wait!(x) = Adapt.adapt(WaitAdaptor(), x)
mark!(x, s) = Adapt.adapt(MarkAdaptor(s), x)
