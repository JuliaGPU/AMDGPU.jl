mutable struct HIPEvent
    handle::hipEvent_t
    stream::hipStream_t
end

Base.:(==)(a::HIPEvent, b::HIPEvent) = a.handle == b.handle

Base.unsafe_convert(::Type{Ptr{T}}, event::HIPEvent) where T =
    reinterpret(Ptr{T}, event.handle)

function record(event::HIPEvent)
    hipEventRecord(event.handle, event.stream) |> check
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

function non_blocking_synchronize(event::HIPEvent)
    isdone(event) && return true

    # spin (initially without yielding to minimize latency)
    spins = 0
    while spins < 256
        if spins < 32
            ccall(:jl_cpu_pause, Cvoid, ())
            # Temporary solution before we have gc transition support in codegen.
            ccall(:jl_gc_safepoint, Cvoid, ())
        else
            yield()
        end
        isdone(event) && return true
        spins += 1
    end
    return false
end

wait(event::HIPEvent) = hipEventSynchronize(event) |> check

function synchronize(event::HIPEvent)
    non_blocking_synchronize(event) || wait(event)
    return
end

function HIPEvent(stream::hipStream_t; do_record::Bool = true, timing=false)
    event_ref = Ref{hipEvent_t}()
    if !timing
        hipEventCreateWithFlags(event_ref, hipEventDisableTiming) |> check
    else
        hipEventCreate(event_ref) |> check
    end
    event = HIPEvent(event_ref[], stream)
    do_record && record(event)

    finalizer(event) do e
        hipEventDestroy(e) |> check
    end
    event
end
HIPEvent(stream::HIPStream; kwargs...) = HIPEvent(stream.stream; kwargs...)

"""
    elapsed(start::HIPEvent, stop::HIPEvent)

Computes the elapsed time between two events (in seconds).

See also [`@elapsed`](@ref).
"""
function elapsed(start::HIPEvent, stop::HIPEvent)
    time_ref = Ref{Cfloat}()
    hipEventElapsedTime(time_ref, start, stop) |> check
    return time_ref[]/1000
end
