module HIP

import ..AMDGPU
import ..AMDGPU.libhip
using CEnum

include("libhip_common.jl")
include("error.jl")
include("libhip.jl")
include("device.jl")

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

include("stream.jl")
include("event.jl")
include("pool.jl")

include("module.jl")

function device_synchronize()
    hipDeviceSynchronize() |> check
end

function reclaim(bytes_to_keep::Integer = 0)
    device_synchronize()
    trim(memory_pool(device()), bytes_to_keep)
end

end
