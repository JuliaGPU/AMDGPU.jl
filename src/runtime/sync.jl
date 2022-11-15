import ..AMDGPU: hip_configured

"Tracks HSA signals and HIP streams to sync against."
struct SyncState
    signals::Vector{ROCKernelSignal}
    streams::Vector{Ptr{Cvoid}}
end
SyncState() = SyncState(ROCKernelSignal[], Ptr{Cvoid}[])

struct WaitAdaptor end
struct MarkAdaptor{S}
    s::S
end

function wait!(ss::SyncState)
    # FIXME: Use barrier_and on dedicated queue
    foreach(wait, ss.signals)
    empty!(ss.signals)
    @static if hip_configured
        for s in ss.streams
            AMDGPU.HIP.@check AMDGPU.HIP.hipStreamSynchronize(s)
        end
        empty!(ss.streams)
        AMDGPU.HIP.@check AMDGPU.HIP.hipStreamSynchronize(C_NULL) # FIXME: This shouldn't be necessary
    end
    nothing
end
mark!(ss::SyncState, signal::ROCKernelSignal) = push!(ss.signals, signal)
mark!(ss::SyncState, stream::Ptr{Cvoid}) = push!(ss.streams, stream)

wait!(x) = Adapt.adapt(WaitAdaptor(), x)
mark!(x, s) = Adapt.adapt(MarkAdaptor(s), x)
