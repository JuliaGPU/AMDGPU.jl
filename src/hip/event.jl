mutable struct HIPEvent
    handle::hipEvent_t
    stream::hipStream_t
end

Base.:(==)(a::HIPEvent, b::HIPEvent) = a.handle == b.handle
Base.unsafe_convert(::Type{hipEvent_t}, event::HIPEvent) = event.handle

function record(event::HIPEvent)
    hipEventRecord(event.handle, event.stream)
    return event
end

function isdone(event::HIPEvent)
    query = hipEventQuery(event)
    if query == hipSuccess
        return true
    elseif query == hipErrorNotReady
        return false
    else
        throw(HIPError(query))
    end
end

wait(event::HIPEvent) = hipEventSynchronize(event)

# same, but callable from any thread (events know their device)
worker_synchronize(event::HIPEvent) =
    @gcsafe_ccall(libhip.hipEventSynchronize(event::hipEvent_t)::hipError_t)

function synchronize(event::HIPEvent; blocking::Bool = false, spin::Bool = true)
    if use_nonblocking_synchronize && !blocking
        res = cooperative_wait(worker_synchronize, event; isdone, spin)
        if res === nothing
            wait(event)
        else
            check(something(res))
            AMDGPU.maybe_collect(; blocking=true)
        end
    else
        AMDGPU.maybe_collect(; blocking=true)
        wait(event)
    end
    return
end

function HIPEvent(stream::hipStream_t; do_record::Bool = true, timing=false)
    event_ref = Ref{hipEvent_t}()
    timing ?
        hipEventCreate(event_ref) :
        hipEventCreateWithFlags(event_ref, hipEventDisableTiming)
    event = HIPEvent(event_ref[], stream)
    do_record && record(event)

    return finalizer(hipEventDestroy, event)
end
HIPEvent(stream::HIPStream; kwargs...) = HIPEvent(stream.stream; kwargs...)

"""
    elapsed(start::HIPEvent, stop::HIPEvent)

Computes the elapsed time between two events (in seconds).

See also [`@elapsed`](@ref).
"""
function elapsed(start::HIPEvent, stop::HIPEvent)
    time_ref = Ref{Cfloat}()
    hipEventElapsedTime(time_ref, start, stop)
    return time_ref[] / 1000
end
