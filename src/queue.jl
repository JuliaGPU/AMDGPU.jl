# Utilities for working with HSA queues

"""
An HSA queue.
Each queue is uniquely associated with an device.
"""
mutable struct ROCQueue
    device::ROCDevice
    @atomic queue::Ptr{HSA.Queue}
    status::HSA.Status
    cond::Base.AsyncCondition
    @atomic active::Bool
end
const QUEUES = Dict{Ptr{HSA.Queue},WeakRef}()
const DEFAULT_QUEUES = IdDict{ROCDevice,ROCQueue}()

async_send(data::Ptr{Cvoid}) = ccall(:uv_async_send, Cint, (Ptr{Cvoid},), data)

function queue_error_handler(status::HSA.Status, _queue::Ptr{HSA.Queue}, queue_obj_ptr::Ptr{Cvoid})::Nothing
    if status != HSA.STATUS_SUCCESS
        queue = unsafe_pointer_to_objref(queue_obj_ptr)::ROCQueue
        queue.status = status
        async_send(queue.cond.handle)
    end

    return nothing
end

function ROCQueue(device::ROCDevice; priority::Symbol=:normal)
    queue_size = Ref{UInt32}(0)
    getinfo(device.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, queue_size) |> check
    @assert queue_size[] > 0
    queue_type = Ref{HSA.QueueType}()
    getinfo(device.agent, HSA.AGENT_INFO_QUEUE_TYPE, queue_type) |> check
    @assert queue_type[] == HSA.QUEUE_TYPE_MULTI

    r_queue = Ref{Ptr{HSA.Queue}}()
    async_cond = Base.AsyncCondition()
    queue = ROCQueue(device, Ptr{HSA.Queue}(0), HSA.STATUS_SUCCESS, async_cond, true)
    HSA.queue_create(device.agent, queue_size[], HSA.QUEUE_TYPE_MULTI,
                     @cfunction(queue_error_handler, Cvoid, (HSA.Status, Ptr{HSA.Queue}, Ptr{Cvoid})), pointer_from_objref(queue),
                     typemax(UInt32), typemax(UInt32), r_queue) |> check
    @atomic queue.queue = r_queue[]

    lock(RT_LOCK) do
        @assert !haskey(QUEUES, queue.queue)
        QUEUES[queue.queue] = WeakRef(queue)
        _active_kernels[queue] = Vector{AMDGPU.ROCKernelSignal}()
    end

    # Monitor queue for async errors
    queue_ptr = queue.queue
    errormonitor(Threads.@spawn begin
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
                @debug "Queue: Async error on $queue"
                kill_queue!(queue)
            end
        end
    end)

    # Set queue priority
    if !in(priority, (:normal, :low, :high))
        throw(ArgumentError("Invalid queue priority: $priority\nOptions are :low, :normal, :high"))
    end
    if priority != :normal
        hsa_prio = if priority == :normal
            HSA.AMD_QUEUE_PRIORITY_NORMAL
        elseif priority == :low
            HSA.AMD_QUEUE_PRIORITY_LOW
        elseif priority == :high
            HSA.AMD_QUEUE_PRIORITY_HIGH
        end
        HSA.amd_queue_set_priority(queue_ptr, hsa_prio) |> check
    end

    AMDGPU.hsaref!()
    finalizer(queue) do queue
        kill_queue!(queue)
        while !trylock(RT_LOCK)
        end
        try
            delete!(QUEUES, queue_ptr)
            delete!(_active_kernels, queue)
        finally
            unlock(RT_LOCK)
        end
        AMDGPU.hsaunref!()
    end
    return queue
end
ROCQueue() = ROCQueue(get_default_device())

struct QueueError <: Exception
    queue::Ptr{HSA.Queue}
    err::HSAError
end
Base.showerror(io::IO, err::QueueError) =
    (println(io, "QueueError(Queue at $(err.queue)) due to:"); Base.showerror(io, err.err))

get_default_queue() = get_default_queue(get_default_device())

"Gets the default queue for an device, creating it if necessary"
function get_default_queue(device::ROCDevice)
    lock(RT_LOCK) do
        get!(DEFAULT_QUEUES, device) do
            ROCQueue(device)
        end
    end
end

"""
    kill_queue!(queue::ROCQueue; force=false)

Kills all kernels executing on the given queue, destroys the queue,
and performs internal clean up. Returns true upon success.

If `force` is `true`, this will attempt to kill a queue even if a previous
attempt has already been made. Since queue pointers may be reused by the device,
this may cause unpredictable behaviour by destroying an active queue.
"""
function kill_queue!(queue::ROCQueue; force=false)
    if !force && !replacefield!(queue, :active, true, false, :acquire_release, :acquire).success
        # The queue was already marked as inactive and we are not forcing it.
        return false
    end
    @atomic queue.active = false

    lock(RT_LOCK) do
        # Clean up global queue lists
        if get(DEFAULT_QUEUES, queue.device, nothing) == queue
            delete!(DEFAULT_QUEUES, queue.device)
        end
        delete!(QUEUES, queue.queue)

        close(queue.cond)

        # Send exception to all waiter signals
        if queue.status != HSA.STATUS_SUCCESS
            err = QueueError(queue.queue, HSAError(queue.status))
            for signal in _active_kernels[queue]
                signal.exception = err
                notify(signal)
            end
        end
    end
    HSA.queue_destroy(queue.queue) |> check

    return true
end
