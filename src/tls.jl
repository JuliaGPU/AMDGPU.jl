struct TaskLocalState
    device::ROCDevice
    context::HIPContext
    queues::Vector{Union{ROCQueue,Nothing}}
    streams::Vector{Union{HIPStream,Nothing}}
    priority::Symbol
end
function TaskLocalState(device::Union{ROCDevice,Nothing},
                        context::Union{HIPContext,Nothing},
                        queue::Union{ROCQueue,Nothing},
                        stream::Union{HIPStream,Nothing},
                        priority::Symbol)
    if device === nothing
        if queue === nothing
            device = Runtime.get_default_device()
            queue = ROCQueue(device; priority, pooled=true)
        else
            device = AMDGPU.device(queue)
        end
    else
        if queue === nothing
            queue = ROCQueue(device; priority, pooled=true)
        else
            queue.device == device || throw(ArgumentError("""
            Provided ROCQueue is on a differen device `$(queue.device)`
            from the default one `$device`.
            """))
            @assert queue.priority == priority
        end
    end
    if context === nothing
        context = HIPContext(device_id(device))
    end
    HIP.context!(context) # Switches HIP active device as well.
    if stream === nothing
        stream = HIPStream(priority)
    else
        stream.device == device || throw(ArgumentError("""
        Provided HIPStream is on a differen device `$(stream.device)`
        from the default one `$device`.
        """))
        @assert stream.priority == priority
    end
    queues = Union{ROCQueue,Nothing}[nothing for _ in 1:length(devices())]
    streams = Union{HIPStream,Nothing}[nothing for _ in 1:length(devices())]
    queues[device_id(device)] = queue
    streams[device_id(device)] = stream
    return TaskLocalState(device, context, queues, streams, priority)
end
TaskLocalState() = TaskLocalState(nothing, nothing, nothing, nothing, :normal)

function Base.getproperty(state::TaskLocalState, field::Symbol)
    # Helpers to return active queue or stream
    if field == :queue
        return state.queues[device_id(state.device)]::ROCQueue
    elseif field == :stream
        return state.streams[device_id(state.device)]::HIPStream
    else
        return getfield(state, field)
    end
end
Base.copy(state::TaskLocalState) =
    TaskLocalState(state.device,
                   state.context,
                   copy(state.queues),
                   copy(state.streams),
                   state.priority)

function reset_dead_queue!()
    state = task_local_state()
    queue = state.queue
    if !queue.active
        queue = state.queues[device_id(state.device)] = ROCQueue(state.device; priority=state.priority)
    end
    return queue
end

function Base.show(io::IO, state::TaskLocalState)
    println(io, "TaskLocalState:")
    println(io, "  Device: $(state.device)")
    println(io, "  HIP Context: $(state.context)")
    println(io, "  HSA Queue: $(state.queue)")
    println(io, "  HIP Stream: $(state.stream)")
    print(io, "  Priority: $(state.priority)")
end

"""
    task_local_state() -> TaskLocalState

Returns the task-local state in the form of a `TaskLocalState`. Automatically
picks a device, context, queue, and stream if they haven't already been selected.
"""
task_local_state() =
    get!(()->TaskLocalState(), task_local_storage(), :AMDGPU)

"""
    task_local_state!(; device=nothing, context=nothing, queue=nothing, stream=nothing, priority::Symbol=:normal)

Sets the task-local device, queue (with the specified priority), and HIP stream. If
`device`, `queue`, or `stream` is `nothing` and an existing task-local state has been
configured, then those values are retrived from the existing state (unless the
`priority` has changed, in which case a new queue is selected); if no
task-local state has been configured, then defaults are used when `nothing` is
supplied.

Note that these are only task-local defaults; when a device, queue or stream is
manually passed to an AMDGPU operation (such as `@roc`), then the task-local
value is ignored in favor of the passed argument.
"""
function task_local_state!(; device=nothing, queue=nothing, stream=nothing, priority::Symbol=:normal)
    if haskey(task_local_storage(), :AMDGPU)
        old_state = task_local_state()
        if device === nothing
            device = old_state.device
            context = old_state.context
        else
            context = HIPContext(device_id(device))
        end
        HIP.context!(context)
        if queue === nothing
            if priority == old_state.priority && old_state.queues[device_id(device)] !== nothing
                queue = old_state.queues[device_id(device)]
            else
                queue = ROCQueue(device; priority, pooled=true)
            end
        end
        if stream === nothing
            if priority == old_state.priority && old_state.streams[device_id(device)] !== nothing
                stream = old_state.streams[device_id(device)]
            else
                stream = HIPStream(priority)
            end
        end
        queues = copy(old_state.queues)
        streams = copy(old_state.streams)
    else # TODO Use default constructor?
        if device === nothing
            device = Runtime.get_default_device()
        end
        context = HIPContext(device_id(device))
        HIP.context!(context)
        if queue === nothing
            queue = ROCQueue(device; priority)
        end
        if stream === nothing
            stream = HIPStream(priority)
        end
        queues = Union{ROCQueue,Nothing}[nothing for _ in 1:length(devices())]
        streams = Union{HIPStream,Nothing}[nothing for _ in 1:length(devices())]
    end
    queues[device_id(device)] = queue
    streams[device_id(device)] = stream
    new_state = TaskLocalState(device, context, queues, streams, priority)

    task_local_storage(:AMDGPU, new_state)
end

task_local_state!(state::TaskLocalState) = task_local_storage(:AMDGPU, state)

"""
    task_local_state!(f::Base.Callable; device=nothing, queue=nothing, stream=nothing, priority::Symbol=:normal)

Executes `f` with the given task-local state, and when finished, resets the
state back to previous values and returns the result of `f()`.
"""
function task_local_state!(f::Base.Callable;
                           device=nothing, queue=nothing, stream=nothing,
                           priority::Symbol=:normal)
    restore = haskey(task_local_storage(), :AMDGPU)
    if restore
        old_state = task_local_state()
    end
    task_local_state!(; device, queue, stream, priority)

    return try
        f()
    finally
        if restore
            task_local_state!(old_state)
        else
            # We want a fresh state with pooled queues and default priority
            delete!(task_local_storage(), :AMDGPU)
            task_local_state!()
        end
    end
end
