mutable struct TaskLocalState
    device::HIPDevice
    context::HIPContext
    streams::Vector{Union{HIPStream,Nothing}}
end

function TaskLocalState(
    dev::HIPDevice = something(HIP.DEFAULT_DEVICE[], HIPDevice(1)),
    ctx::HIPContext = HIPContext(dev),
)
    streams = Union{Nothing, HIPStream}[nothing for _ in 1:HIP.ndevices()]
    TaskLocalState(dev, ctx, streams)
end

function Base.getproperty(state::TaskLocalState, field::Symbol)
    if field == :stream # Helpers to return active stream.
        return stream(state)
    else
        return getfield(state, field)
    end
end

task_local_state()::Union{Nothing, TaskLocalState} =
    get(task_local_storage(), :AMDGPU, nothing)

task_local_state!(args...)::TaskLocalState =
    get!(() -> TaskLocalState(args...), task_local_storage(), :AMDGPU)

Base.copy(state::TaskLocalState) = TaskLocalState(
    state.device, state.context, copy(state.streams))

function Base.show(io::IO, state::TaskLocalState)
    println(io, "TaskLocalState:")
    println(io, "  Device: $(state.device)")
    println(io, "  HIP Context: $(state.context)")
    println(io, "  HIP Stream: $(state.stream)")
end

"""
    device()::HIPDevice

Get currently active device.
This device is used when launching kernels via `@roc`.
"""
device() = task_local_state!().device

"""
    device!(device::HIPDevice)

Switch current device being used.
This switches only for a task inside which it is called.
"""
function device!(dev::HIPDevice)
    # Set the new default device.
    HIP.DEFAULT_DEVICE[] = dev

    ctx = HIPContext(dev)
    state = task_local_state()
    if state ≡ nothing
        task_local_state!(dev, ctx)
    else
        state.device = dev
        state.context = ctx
    end
    HIP.context!(ctx)
    return dev
end

device!(f::Function, dev::HIPDevice) = context!(f, HIPContext(dev))

function stream(state::TaskLocalState)::HIPStream
    i = device_id(state.device)
    if state.streams[i] ≡ nothing
        state.streams[i] = HIPStream(:normal)
    else
        state.streams[i]
    end
end

"""
    stream()::HIPStream

Get the HIP stream that should be used as the default one
for the currently executing task.
"""
stream()::HIPStream = stream(task_local_state!())

"""
    stream!(s::HIPStream)

Change the default stream to be used **within the same Julia task**.
"""
function stream!(s::HIPStream)
    state = task_local_state!()
    state.streams[device_id(state.device)] = s
    return s
end

"""
    stream!(f::Base.Callable, stream::HIPStream)

Change the default stream to be used **within the same Julia task**,
execute `f` and revert to the original stream.

# Returns:

Return value of the function `f`.
"""
function stream!(f::Function, s::HIPStream)
    old_s = stream()
    return try
        f()
    finally
        stream!(old_s)
    end
end

context() = task_local_state!().context

function context!(ctx::HIPContext)
    state = task_local_state()
    if state ≡ nothing
        old_ctx = nothing
        HIP.context!(ctx)
        task_local_state!(HIP.device(), ctx)
    else
        old_ctx = state.context
        if old_ctx != ctx
            HIP.context!(ctx)
            state.device = HIP.device()
            state.context = ctx
        end
    end
    return old_ctx
end

function context!(f::Function, ctx::HIPContext)
    if ctx.valid
        old_ctx = context!(ctx)
        return try
            f()
        finally
            old_ctx ≢ nothing && old_ctx != ctx && context!(old_ctx)
        end
    else
        @warn "CTX not valid"
    end
end

priority() = task_local_state!().stream.priority

"""
    priority!(p::Symbol)

Change the priority of the default stream.
Accepted values are `:normal` (the default), `:low` and `:high`.
"""
function priority!(p::Symbol)
    state = task_local_state!()
    state.stream.priority == p && return p

    state.streams[device_id(state.device)] = HIPStream(p)
    return p
end

"""
    priority!(f::Base.Callable, priority::Symbol)

Chnage the priority of default stream, execute `f` and
revert to the original priority.
Accepted values are `:normal` (the default), `:low` and `:high`.

# Returns:

Return value of the function `f`.
"""
function priority!(f::Function, p::Symbol)
    state = task_local_state!()
    idx = device_id(state.device)

    old_s = state.stream
    swap = p != old_s.priority
    swap && (state.streams[idx] = HIPStream(p);)

    return try
        f()
    finally
        swap && (state.streams[idx] = old_s;)
    end
end

@inline function prepare_state(state = task_local_state!())
    hip_ctx = Ref{HIP.hipCtx_t}()
    HIP.hipCtxGetCurrent(hip_ctx)
    state.context.context != hip_ctx[] &&
        HIP.context!(state.context)
    return
end
