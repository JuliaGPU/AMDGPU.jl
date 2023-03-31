mutable struct ROCQueue{S}
    device::ROCDevice
    @atomic queue::Ptr{HSA.Queue}
    priority::Symbol
    status::HSA.Status
    @atomic active::Bool
    active_kernels::Vector{S} # always Vector{ROCKernelSignal}
    running::Base.Event
    lock::Threads.ReentrantLock
end
get_handle(queue::ROCQueue) = reinterpret(Ptr{Cvoid}, queue.queue)

function Base.show(io::IO, queue::ROCQueue)
    print(io, "ROCQueue(device=$(queue.device), ptr=$(repr(UInt(queue.queue))), priority=$(queue.priority), status=$(queue.status), active=$(queue.active), running=$(queue.running.set))")
end

const QUEUES = Dict{Ptr{HSA.Queue}, WeakRef}()

function queue_error_handler(
    status::HSA.Status, _queue::Ptr{HSA.Queue}, queue_obj_ptr::Ptr{Cvoid},
)::Nothing
    if status != HSA.STATUS_SUCCESS
        queue::ROCQueue = unsafe_pointer_to_objref(queue_obj_ptr)
        queue.status = status
    end
    nothing
end

struct QueueError <: Exception
    queue::Ptr{HSA.Queue}
    err::HSAError
end
QueueError(queue::ROCQueue) = QueueError(queue.queue, HSAError(queue.status))

function Base.showerror(io::IO, err::QueueError)
    println(io, "QueueError(Queue at $(err.queue)) due to:")
    Base.showerror(io, err.err)
end

mutable struct QueuePool
    pool::Dict{ROCDevice,Dict{Symbol,Vector{ROCQueue}}}
    max_size::NTuple{3, Int}
    idx::Int
end
QueuePool() = QueuePool(
    Dict{ROCDevice,Dict{Symbol,Vector{ROCQueue}}}(),
    (@load_preference("queue_pool_max_size", [12, 1, 1])...,),
    0)

const QUEUE_POOL = LockedObject(QueuePool())

function set_alloc_queue_pool_max!(nums::NTuple{3, Int})
    @set_preferences!("queue_pool_max_size" => [nums...])
    @info """Successfully set queue pool max size to `$nums` (:normal, :low, :high).
    Reset your Julia session for the changes to take effect."""
end

function get_pool_queue!(device::ROCDevice, priority::Symbol)
    prio_idx = priority == :normal ? 1 : (priority == :low ? 2 : 3)

    lock(QUEUE_POOL) do pool
        device_pool = get!(() -> Dict{Symbol, Vector{ROCQueue}}(), pool.pool, device)
        queues = get!(() -> ROCQueue[], device_pool, priority)
        length(queues) < pool.max_size[prio_idx] && return nothing

        # If all queues are allocated, pick next one.
        idx = pool.idx % length(queues) + 1
        pool.idx += 1

        queue = queues[idx]
        queue.active && return queue

        @debug "Removing dead queue from pool"
        deleteat!(queues, idx)
        return nothing
    end
end

function pool_queue!(queue::ROCQueue)
    prio_idx = queue.priority == :normal ? 1 : (queue.priority == :low ? 2 : 3)
    QUEUE_POOL.payload.max_size[prio_idx] == 0 && return false

    lock(QUEUE_POOL) do pool
        queues = pool.pool[queue.device][queue.priority]
        length(queues) < pool.max_size[prio_idx] ?
            (push!(queues, queue); true) :
            false
    end
end

function remove_pooled_queue!(queue::ROCQueue)
    lock(QUEUE_POOL) do pool
        device_pool = get(pool.pool, queue.device, nothing)
        isnothing(device_pool) && return

        queues = get(device_pool, queue.priority, nothing)
        isnothing(queues) && return

        idx = findfirst(q -> q === queue, queues)
        isnothing(idx) || deleteat!(queues, idx)
    end
end

device_queue_max_size(device::AnyROCDevice) =
    getinfo(UInt32, device, HSA.AGENT_INFO_QUEUE_MAX_SIZE)

device_queue_type(device::AnyROCDevice) =
    getinfo(HSA.QueueType, device, HSA.AGENT_INFO_QUEUE_TYPE)

function ROCQueue(device::ROCDevice; priority::Symbol=:normal, pooled::Bool=false)
    if !in(priority, (:normal, :low, :high))
        throw(ArgumentError(
            "Invalid queue priority: $priority\n" *
            "Options are :low, :normal, :high"))
    end

    queue = pooled ? get_pool_queue!(device, priority) : nothing
    isnothing(queue) || return queue

    alloc_id = rand(UInt64)
    @log_start(:alloc_queue, (;alloc_id), (;device=get_handle(device), priority))

    # Allocate a new queue from HSA.
    c_queue_error_handler = @cfunction(queue_error_handler,
        Cvoid, (HSA.Status, Ptr{HSA.Queue}, Ptr{Cvoid}))

    queue_size = device_queue_max_size(device)
    queue_type = device_queue_type(device)
    @assert queue_size > 0
    @assert queue_type == HSA.QUEUE_TYPE_MULTI

    # Create ROCQueue before HSA queue to be able to pass it to error handler.
    queue = ROCQueue(
        device, Ptr{HSA.Queue}(0), priority, HSA.STATUS_SUCCESS, true,
        ROCKernelSignal[], Base.Event(), Threads.ReentrantLock())

    # Create HSA queue.
    r_queue = Ref{Ptr{HSA.Queue}}()
    HSA.queue_create(
        device.agent, queue_size, queue_type,
        c_queue_error_handler, pointer_from_objref(queue),
        typemax(UInt32), typemax(UInt32), r_queue) |> check

    AMDGPU.hsaref!()
    @atomic queue.queue = r_queue[]

    lock(RT_LOCK) do
        @assert !haskey(QUEUES, queue.queue)
        QUEUES[queue.queue] = WeakRef(queue)
    end

    HSA.amd_queue_set_priority(queue.queue, hsa_priority(priority)) |> check
    errormonitor(Threads.@spawn monitor_queue(queue))

    finalizer(queue) do q
        kill_queue!(q)
        AMDGPU.hsaunref!()
    end

    pooled && pool_queue!(queue)
    @log_finish(:alloc_queue, (;alloc_id), (;queue=reinterpret(UInt64, queue.queue)))
    return queue
end

function hsa_priority(priority::Symbol)
    if priority == :normal
        HSA.AMD_QUEUE_PRIORITY_NORMAL
    elseif priority == :low
        HSA.AMD_QUEUE_PRIORITY_LOW
    elseif priority == :high
        HSA.AMD_QUEUE_PRIORITY_HIGH
    end
end

function monitor_queue(queue::ROCQueue)
    while queue.active
        # Fetch oldest signal, if any
        sig = lock(queue.lock) do
            kerns = queue.active_kernels
            if length(kerns) > 0
                # Notify waiters that queue is running
                notify(queue.running)
                return first(kerns)
            else
                # Reset event
                reset(queue.running)
                return nothing
            end
        end

        # Wait for signal completion or new launches
        if sig !== nothing
            wait(sig)
        else
            wait(queue.running)
        end
    end
end

ROCQueue(; kwargs...) = ROCQueue(AMDGPU.device(); kwargs...)

"""
Determine if there are active kernels for the queue.
If not, we can re-use it.
"""
function has_active_kernels(q::ROCQueue)
    lock(q.lock) do
        return !isempty(q.active_kernels)
    end
end

function kill_queue!(queue::ROCQueue)
    _, succ = @atomicreplace queue.active true => false
    succ || return

    @log_start(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)
    remove_pooled_queue!(queue)

    lock(RT_LOCK) do
        delete!(QUEUES, queue.queue)
    end
    lock(queue.lock) do
        # Send exception to all waiter signals
        if queue.status != HSA.STATUS_SUCCESS
            err = QueueError(queue.queue, HSAError(queue.status))
            for kersig in queue.active_kernels
                kersig.exception = err
                notify(kersig)
            end
        end
        # Clear active kernel set
        empty!(queue.active_kernels)
    end

    HSA.queue_destroy(queue.queue) |> check
    @log_finish(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)
    return
end
