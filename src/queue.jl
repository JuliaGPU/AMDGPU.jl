# Utilities for working with HSA queues

"""
An HSA queue.
Each queue is uniquely associated with an agent.
"""
mutable struct HSAQueue
    agent::HSAAgent
    queue::Ptr{HSA.Queue}
    status::HSA.Status
    cond::Base.AsyncCondition
    @atomic active::Bool
end
const QUEUES = Dict{Ptr{HSA.Queue},WeakRef}()
const DEFAULT_QUEUES = IdDict{HSAAgent,HSAQueue}()

async_send(data::Ptr{Cvoid}) = ccall(:uv_async_send, Cint, (Ptr{Cvoid},), data)

function queue_error_handler(status::HSA.Status, _queue::Ptr{HSA.Queue}, queue_obj_ptr::Ptr{Cvoid})::Nothing
    if status != HSA.STATUS_SUCCESS
        queue = unsafe_pointer_to_objref(queue_obj_ptr)::HSAQueue
        queue.status = status
        async_send(queue.cond.handle)
    end

    return nothing
end

function HSAQueue(agent::HSAAgent)
    queue_size = Ref{UInt32}(0)
    getinfo(agent.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, queue_size) |> check
    @assert queue_size[] > 0

    r_queue = Ref{Ptr{HSA.Queue}}()
    async_cond = Base.AsyncCondition()
    queue = HSAQueue(agent, Ptr{HSA.Queue}(0), HSA.STATUS_SUCCESS, async_cond, true)
    HSA.queue_create(agent.agent, queue_size[], HSA.QUEUE_TYPE_MULTI,
                     @cfunction(queue_error_handler, Cvoid, (HSA.Status, Ptr{HSA.Queue}, Ptr{Cvoid})), pointer_from_objref(queue),
                     typemax(UInt32), typemax(UInt32), r_queue) |> check
    queue.queue = r_queue[]

    lock(RT_LOCK) do
        @assert !haskey(QUEUES, queue.queue)
        QUEUES[queue.queue] = WeakRef(queue)
        _active_kernels[queue] = Vector{AMDGPU.RuntimeEvent{AMDGPU.HSAStatusSignal}}()
    end

    # Monitor queue for async errors
    # TODO: errormonitor
    queue_ptr = queue.queue
    Threads.@spawn begin
        try
            try
                wait(async_cond)
            catch err
                err isa EOFError || rethrow(err)
                return
            end
            lock(RT_LOCK) do
                if !haskey(QUEUES, queue_ptr) || QUEUES[queue_ptr].value === nothing
                    # Queue was destroyed
                    return
                end
                queue = QUEUES[queue_ptr].value
                if queue.status != HSA.STATUS_SUCCESS
                    # Queue encountered an async error, manually kill it
                    kill_queue!(queue)
                end
            end
        catch err
            @error "Queue monitor error" exception=(err,catch_backtrace())
        end
    end

    hsaref!()
    finalizer(queue) do queue
        kill_queue!(queue)
        hsaunref!()
    end
    return queue
end
HSAQueue() = HSAQueue(get_default_agent())

struct QueueError <: Exception
    queue::Ptr{HSA.Queue}
    err::HSAError
end
Base.showerror(io::IO, err::QueueError) =
    (println(io, "QueueError(Queue at $(err.queue)) due to:"); Base.showerror(io, err.err))

get_default_queue() = get_default_queue(get_default_agent())

"Gets the default queue for an agent, creating it if necessary"
function get_default_queue(agent::HSAAgent)
    lock(RT_LOCK) do
        get!(DEFAULT_QUEUES, agent) do
            HSAQueue(agent)
        end
    end
end

"Kills all kernels executing on the given queue, and destroys the queue."
function kill_queue!(queue::HSAQueue; force=false)
    if !force && !replacefield!(queue, :active, true, false, :acquire_release).success
        return false # We didn't destroy the queue
    end
    @atomic queue.active = false

    lock(RT_LOCK) do
        delete!(QUEUES, queue.queue)
        if get(DEFAULT_QUEUES, queue.agent, nothing) == queue
            delete!(DEFAULT_QUEUES, queue.agent)
        end
        close(queue.cond)

        # Send exception to all waiter signals
        if queue.status != HSA.STATUS_SUCCESS
            err = QueueError(queue.queue, HSAError(queue.status))
            for signal in _active_kernels[queue]
                signal.exception = err
                notify(signal)
            end
        end

        delete!(_active_kernels, queue)
    end
    HSA.queue_destroy(queue.queue) |> check

    return true # We actually destroyed the queue
end
