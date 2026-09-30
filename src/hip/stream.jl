const use_nonblocking_synchronize = Preferences.@load_preference(
    "nonblocking_synchronization", true)

mutable struct HIPStream
    stream::hipStream_t
    priority::Symbol
    device::HIPDevice
    ctx::HIPContext

    Base.@atomic valid::Bool
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
    hipStreamCreateWithPriority(stream_ref, 0, priority_int)
    d = device()
    stream = HIPStream(stream_ref[], priority, d, HIPContext(d), true)
    return finalizer(stream) do s
        Base.@atomic s.valid = false
        AMDGPU.context!(s.ctx) do
            hipStreamDestroy(s.stream)
        end
    end
end

isvalid(s::HIPStream) = s.valid

default_stream() = HIPStream(C_NULL, :normal, device(), HIPContext(), true)

"""
    HIPStream(stream::hipStream_t)

Create HIPStream from `hipStream_t` handle.
Device is the default device that's currently in use.
"""
function HIPStream(stream::hipStream_t)
    d = device()
    HIPStream(stream, priority(stream), d, HIPContext(d), true)
end

function isdone(stream::HIPStream)
    isvalid(stream) || return true
    query = hipStreamQuery(stream)
    if query == hipSuccess
        return true
    elseif query == hipErrorNotReady
        return false
    else
        throw(HIPError(query))
    end
end

wait(stream::HIPStream) = hipStreamSynchronize(stream)

# same, but callable from any thread. this bypasses the task-local state, so select the
# caller's device ourselves: the null stream refers to the current device's.
function worker_synchronize(stream::HIPStream, dev::HIPDevice)
    isvalid(stream) || return hipSuccess
    res = unchecked_hipSetDevice(device_id(dev))
    res == hipSuccess || return res
    @gcsafe_ccall(libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t)
end

function synchronize(stream::HIPStream; blocking::Bool = false, spin::Bool = true)
    if GC.in_finalizer()
        # we can't switch tasks here, and the finalizer selected the context to use
        wait(stream)
    elseif use_nonblocking_synchronize && !blocking
        # wait on a worker thread, so that other tasks (e.g. hostcalls) can run on this one
        dev = AMDGPU.device()
        res = cooperative_wait(s -> worker_synchronize(s, dev), stream; isdone, spin)
        if res === nothing
            # polling found the stream done. synchronize anyway, which reports errors and
            # lets HIP release resources.
            wait(stream)
        else
            check(something(res))
            AMDGPU.maybe_collect(; blocking=true)
        end
    else
        AMDGPU.maybe_collect(; blocking=true)
        wait(stream)
    end
    return
end

Base.unsafe_convert(::Type{hipStream_t}, stream::HIPStream) = stream.stream
Base.unsafe_convert(::Type{Ptr{Cvoid}}, stream::HIPStream) = Ptr{Cvoid}(stream.stream)
Base.:(==)(a::HIPStream, b::HIPStream) = a.stream == b.stream
Base.hash(s::HIPStream, h::UInt) = hash(s.stream, h)

function Base.show(io::IO, stream::HIPStream)
    print(io, "HIPStream(device=$(stream.device), ptr=$(repr(UInt64(stream.stream))), priority=$(stream.priority))")
end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, stream::HIPStream)
    data = reshape([
        "$(repr(UInt64(stream.stream)))",
        "$(stream.priority)",
        "$(stream.device)",
    ], 1, :)
    PrettyTables.pretty_table(io, data; column_labels=["Ptr", "Priority", "Device"])
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
    hipStreamGetPriority(stream, priority)
    priority_to_symbol(priority[])
end
