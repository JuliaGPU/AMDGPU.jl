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
function mark!(ss::SyncState, stream::Ptr{C}) where C
    lock(()->push!(ss.streams, stream), ss.lock)
end

wait!(x) = Adapt.adapt(WaitAdaptor(), x)

# TODO if `s` is not stream, nor signal, it will silently do nothing.
# As was the case, when `stream` was only `Ptr{Cvoid}`, but rocBLAS returned
# `Ptr{ihipStream_t}` thus failing to properly synchronize.
function mark!(x, s)
    @assert typeof(s) <: ROCKernelSignal || typeof(s) <: Ptr
    Adapt.adapt(MarkAdaptor(s), x)
end
