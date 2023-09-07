mutable struct TaskLocalState
    device::HIPDevice
    context::HIPContext
    streams::Vector{Union{HIPStream,Nothing}}
end

function TaskLocalState(
    dev::HIPDevice = something(Runtime.DEFAULT_DEVICE[], HIPDevice(1)),
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

device() = task_local_state!().device

function device!(dev::HIPDevice)
    # Set the new default device.
    Runtime.DEFAULT_DEVICE[] = dev

    ctx = HIPContext(dev)
    state = task_local_state()
    if state ≡ nothing
        task_local_state!(dev, ctx)
    else
        state.device = dev
        state.context = ctx
    end
    HIP.context!(ctx)
    return
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

stream()::HIPStream = stream(task_local_state!())

function stream!(s::HIPStream)
    state = task_local_state!()
    state.streams[device_id(state.device)] = s
    return
end

function stream!(f::Function, s::HIPStream)
    old_s = stream()
    try
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
        old_ctx = state.ctx
        if old_ctx != ctx
            HIP.context!(state.ctx)
            state.device = HIP.device()
            state.context = ctx
        end
    end
    return old_ctx
end

function context!(f::Function, ctx::HIPContext)
    old_ctx = context!(ctx)
    try
        f()
    finally
        old_ctx ≢ nothing && old_ctx != ctx && context!(old_ctx)
    end
end

priority() = task_local_state!().stream.priority

function priority!(p::Symbol)
    state = task_local_state!()
    state.stream.priority == p && return

    state.streams[device_id(state.device)] = HIPStream(p)
    return
end

function priority!(f::Function, p::Symbol)
    state = task_local_state!()
    idx = device_id(state.device)

    old_s = state.stream
    swap = p != old_s.priority
    swap && (state.streams[idx] = HIPStream(p);)

    try
        f()
    finally
        swap && (state.streams[idx] = old_s;)
    end
end

Base.copy(state::TaskLocalState) = TaskLocalState(
    state.device, state.context, copy(state.streams))

function Base.show(io::IO, state::TaskLocalState)
    println(io, "TaskLocalState:")
    println(io, "  Device: $(state.device)")
    println(io, "  HIP Context: $(state.context)")
    println(io, "  HIP Stream: $(state.stream)")
end

@inline function prepare_state(state = task_local_state!())
    state.context != HIP.HIPContext() && HIP.context!(state.context)
    return
end
