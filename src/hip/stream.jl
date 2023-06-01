mutable struct HIPStream
    stream::hipStream_t
    priority::Symbol
    device::HIPDevice
end

"""
    HIPStream(priority::Symbol = :normal)

# Arguments:

- `priority::Symbol`: Priority of the stream: `:normal`, `:high` or `:low`.

Create HIPStream with given priority.
Device is the default device that's currently in use.
"""
function HIPStream(priority::Symbol = :normal)
    priority_int = symbol_to_priority(priority)

    stream_ref = Ref{hipStream_t}()
    hipStreamCreateWithPriority(stream_ref, Cuint(0), priority_int) |> check
    stream = HIPStream(stream_ref[], priority, device())
    finalizer(stream) do s
        res = hipStreamDestroy(s.stream)
        if res != hipSuccess
            Core.println("[!] Error in HIPStream finalizer: $res - $(status_message(res)).")
        end
        res |> check
    end
    return stream
end

default_stream() = HIPStream(convert(hipStream_t, C_NULL), :normal, device())

"""
    HIPStream(stream::hipStream_t)

Create HIPStream from `hipStream_t` handle.
Device is the default device that's currently in use.
"""
HIPStream(stream::hipStream_t) = HIPStream(stream, priority(stream), device())

function isdone(stream::HIPStream)
    query = hipStreamQuery(stream)
    if query == hipSuccess
        return true
    elseif query == hipErrorNotReady
        return false
    else
        throw(HIPError(query))
    end
end

function non_blocking_synchronize(stream::HIPStream)
    isdone(stream) && return true

    # spin (initially without yielding to minimize latency)
    spins = 0
    while true
        if spins < 32
            ccall(:jl_cpu_pause, Cvoid, ())
            # Temporary solution before we have gc transition support in codegen.
            ccall(:jl_gc_safepoint, Cvoid, ())
        else
            yield()
        end
        isdone(stream) && return true
        spins += 1
    end
    return false
end

wait(stream::HIPStream) = hipStreamSynchronize(stream) |> check

function synchronize(stream::HIPStream)
    non_blocking_synchronize(stream) # || wait(stream)
    return
end

Base.unsafe_convert(::Type{Ptr{T}}, stream::HIPStream) where T =
    reinterpret(Ptr{T}, stream.stream)

function Base.show(io::IO, stream::HIPStream)
    print(io, "HIPStream(device=$(stream.device), ptr=$(repr(UInt64(stream.stream))), priority=$(stream.priority))")
end

function priority_to_symbol(priority)
    priority ==  0 && return :normal
    priority == -1 && return :high
    priority ==  1 && return :low
    throw(ArgumentError("""
    Invalid HIP priority: $priority.
    Valid values are: 0, -1, 1.
    """))
end

function symbol_to_priority(priority::Symbol)
    priority == :normal && return Cint(0)
    priority == :high && return Cint(-1)
    priority == :low && return Cint(1)
    throw(ArgumentError("""
    Invalid HIP priority symbol: $priority.
    Valid values are: `:normal`, `:low`, `:high`.
    """))
end

function priority(stream::hipStream_t)
    priority = Ref{Cint}()
    hipStreamGetPriority(stream, priority) |> check
    priority_to_symbol(priority[])
end
