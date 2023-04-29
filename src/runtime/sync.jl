import ..AMDGPU: hip_configured

"Tracks HSA signals and HIP streams to sync against."
mutable struct SyncState
    signals::Vector{ROCKernelSignal}
    streams::Vector{Ptr{Cvoid}}
    lock::Threads.ReentrantLock

    same_queue::Bool
    same_stream::Bool
end
SyncState() = SyncState(
    ROCKernelSignal[], Ptr{Cvoid}[], Threads.ReentrantLock(), true, true)

struct WaitAdaptor end
struct HIPWaitAdaptor end
struct HSAWaitAdaptor end
struct MarkAdaptor{S}
    s::S
end

function wait!(ss::SyncState; hip::Bool = true, hsa::Bool = true)
    lock(ss.lock) do
        @info "Old $hsa, $hip"
        # Force HSA wait if there are streams or if there are different queues.
        hsa = hsa || !isempty(ss.streams) || !ss.same_queue
        # Force HIP wait if there are signals or if there are different streams.
        hip = hip || !isempty(ss.signals) || !ss.same_stream
        @assert hsa || hip
        @info "New $hsa, $hip: $(length(ss.signals)), $(length(ss.streams))"

        if hsa
            @info "[!] HSA wait: $(length(ss.signals))"
            foreach(wait, ss.signals)
            empty!(ss.signals)
        else
            @warn "NO HSA"
            # If not waiting on HSA, keep last signal if any.
            # This will force a syncronization if HSA kernel is still running,
            # but HIP stream was added to syncstate.
            if !isempty(ss.signals)
                @warn "Pruning HSA"
                ss.signals = [ss.signals[end]]
            end
        end
        ss.same_queue = true

        if hip
            @info "[!] HIP wait: $(length(ss.streams))"
            for s in ss.streams
                AMDGPU.HIP.@check AMDGPU.HIP.hipStreamSynchronize(s)
            end
            # FIXME!!!!!!!!!!!!!
            AMDGPU.HIP.@check AMDGPU.HIP.hipStreamSynchronize(C_NULL)
            empty!(ss.streams)
        else
            @warn "NO HIP"
            # If not waiting on HIP, keep last stream if any.
            # This will force a syncronization if HIP kernel is still running,
            # but HSA signal was added to syncstate.
            if !isempty(ss.streams)
                @warn "Pruning HIP"
                ss.streams = [ss.streams[end]]
            end
        end
        ss.same_stream = true
    end
    return
end

function mark!(ss::SyncState, signal::ROCKernelSignal)
    lock(ss.lock) do
        ss.same_queue &= isempty(ss.signals) ?
            true : (ss.signals[end].queue == signal.queue)
        push!(ss.signals, signal)
    end
end
# TODO remove, every HIP-based library should use TLS state
# and pass concrete streams instead of C_NULL.
function mark!(ss::SyncState, stream::Ptr{Cvoid})
    lock(ss.lock) do
        ss.same_stream &= isempty(ss.streams) ?
            true : (ss.streams[end] == stream)
        push!(ss.streams, stream)
    end
end
mark!(ss::SyncState, stream::HIP.HIPStream) =
    mark!(ss, stream.stream)

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
