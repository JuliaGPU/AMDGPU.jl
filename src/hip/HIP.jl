module HIP

import ..AMDGPU
import ..AMDGPU.libhip
using CEnum

include("libhip_common.jl")
include("error.jl")
include("libhip.jl")

struct HIPDevice
    device::hipDevice_t
    device_id::Cint
end
function HIPDevice(device_id::Integer)
    device_ref = Ref{hipDevice_t}()
    hipDeviceGet(device_ref, Cint(device_id-1)) |> check
    return HIPDevice(device_ref[], device_id)
end
Base.unsafe_convert(::Type{Ptr{T}}, device::HIPDevice) where T =
    reinterpret(Ptr{T}, device.device)
function name(device::HIPDevice)
    name_vec = zeros(Cuchar, 64)
    hipDeviceGetName(pointer(name_vec), Cint(64), device.device) |> check
    return String(name_vec)
end
function Base.show(io::IO, device::HIPDevice)
    print(io, "HIPDevice(name=\"$(name(device))\", id=$(device.device_id))")
end

function device()
    device_id_ref = Ref{Cint}()
    hipGetDevice(device_id_ref) |> check
    return HIPDevice(device_id_ref[]+1)
end
device!(device::HIPDevice) = hipSetDevice(device.device_id-Int32(1)) |> check
device!(device_id::Integer) = hipSetDevice(Cint(device_id-1)) |> check
function device!(f::Base.Callable, device::HIPDevice)
    old_device_id_ref = Ref{Cint}()
    hipGetDevice(old_device_id_ref) |> check
    device!(device)
    try
        f()
    finally
        device!(old_device_id_ref[]+1)
    end
end

mutable struct HIPContext
    context::hipContext_t
end
const CONTEXTS = AMDGPU.LockedObject(Dict{HIPDevice,HIPContext}())
function HIPContext(device::HIPDevice)
    lock(CONTEXTS) do contexts
        get!(contexts, device) do
            context_ref = Ref{hipContext_t}()
            hipCtxCreate(context_ref, Cuint(0), device.device) |> check
            context = HIPContext(context_ref[])
            device!(device)
            finalizer(context) do c
                hipCtxDestroy(c.context) |> check
            end
            return context
        end
    end
end
HIPContext(device_id::Integer) = HIPContext(HIPDevice(device_id))
Base.unsafe_convert(::Type{Ptr{T}}, context::HIPContext) where T =
    reinterpret(Ptr{T}, context.context)
function Base.show(io::IO, context::HIPContext)
    print(io, "HIPContext(ptr=$(repr(UInt64(context.context))))")
end

context!(context::HIPContext) = context!(context.context)
context!(context::hipContext_t) = hipCtxSetCurrent(context) |> check
function context!(f::Base.Callable, context::HIPContext)
    old_context_ref = Ref{hipContext_t}()
    hipCtxGetCurrent(old_context_ref) |> check
    context!(context)
    try
        f()
    finally
        context!(old_context_ref[])
    end
end

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
        hipStreamSynchronize(s.stream) |> check
        hipStreamDestroy(s.stream) |> check
    end
    return stream
end

"""
    HIPStream(stream::hipStream_t)

Create HIPStream from `hipStream_t` handle.
Device is the default device that's currently in use.
"""
HIPStream(stream::hipStream_t) = HIPStream(stream, priority(stream), device())

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

end
