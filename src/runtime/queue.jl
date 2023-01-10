mutable struct ROCQueue
    device::ROCDevice
    @atomic queue::Ptr{HSA.Queue}
    priority::Symbol
    status::HSA.Status
    @atomic active::Bool
    active_kernels::Vector # TODO: Concrete type
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

const ALLOC_QUEUE_LOCK = Threads.ReentrantLock()
# Device -> Priority -> Queues
const ALLOC_QUEUE_POOL = Dict{ROCDevice,Dict{Symbol,Vector{ROCQueue}}}()
set_alloc_queue_pool_max!(nums::Vector{Int}) =
    @set_preferences!("alloc_queue_pool_max"=>nums)
const ALLOC_QUEUE_POOL_MAX = let
    Tuple(if haskey(ENV, "JULIA_AMDGPU_ALLOC_QUEUE_POOL_MAX")
        nums = ENV["JULIA_AMDGPU_ALLOC_QUEUE_POOL_MAX"]
        nums = parse.(Int, split(nums, ':'))
        set_alloc_queue_pool_max!(nums)
        nums
    else
        @load_preference("alloc_queue_pool_max", [12,1,1])
    end)
end
const ALLOC_QUEUE_INDEX = Ref(1)

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

    alloc_id = rand(UInt64)
    @log_start(:alloc_queue, (;alloc_id), (;device=get_handle(device), priority))

    if !pooled
        @goto alloc_queue
    end
    prio_idx = priority == :normal ? 1 : (priority == :low ? 2 : 3)
    if ALLOC_QUEUE_POOL_MAX[prio_idx] == 0
        @goto alloc_queue
    end

    # Try to select a queue from the pool
    queue = lock(ALLOC_QUEUE_LOCK) do
        prios_pool = get!(ALLOC_QUEUE_POOL, device) do
            Dict{Symbol,Vector{ROCQueue}}()
        end
        pool = get!(prios_pool, priority) do
            ROCQueue[]
        end

        # If all queues are allocated, pick one randomly
        if length(pool) >= ALLOC_QUEUE_POOL_MAX[prio_idx]
            idx = ((ALLOC_QUEUE_INDEX[] - 1) % length(pool)) + 1
            ALLOC_QUEUE_INDEX[] += 1
            q = pool[idx]
            if q.active
                return q
            else
                @debug "Removing dead queue from pool"
                deleteat!(pool, idx)
            end
        end

        # Otherwise, we want to allocate a new queue for the pool
        return nothing
    end
    if queue !== nothing
        @goto return_queue
    end

    # Allocate a new queue from HSA
    @label alloc_queue
    queue_size = device_queue_max_size(device)
    @assert queue_size > 0

    queue_type = device_queue_type(device)
    @assert queue_type == HSA.QUEUE_TYPE_MULTI

    r_queue = Ref{Ptr{HSA.Queue}}()
    queue = ROCQueue(device, Ptr{HSA.Queue}(0), priority,
                     HSA.STATUS_SUCCESS, true,
                     ROCKernelSignal[], Base.Event(),
                     Threads.ReentrantLock())
    c_queue_error_handler = @cfunction(
        queue_error_handler, Cvoid, (HSA.Status, Ptr{HSA.Queue}, Ptr{Cvoid}))

    AMDGPU.hsaref!()
    HSA.queue_create(
        device.agent, queue_size[], HSA.QUEUE_TYPE_MULTI,
        c_queue_error_handler, pointer_from_objref(queue),
        typemax(UInt32), typemax(UInt32), r_queue) |> check
    @atomic queue.queue = r_queue[]

    lock(RT_LOCK) do
        @assert !haskey(QUEUES, queue.queue)
        QUEUES[queue.queue] = WeakRef(queue)
    end

    hsa_priority = if priority == :normal
        HSA.AMD_QUEUE_PRIORITY_NORMAL
    elseif priority == :low
        HSA.AMD_QUEUE_PRIORITY_LOW
    elseif priority == :high
        HSA.AMD_QUEUE_PRIORITY_HIGH
    end
    HSA.amd_queue_set_priority(queue.queue, hsa_priority) |> check

    errormonitor(Threads.@spawn monitor_queue(queue))

    finalizer(queue) do q
        kill_queue!(q)
        AMDGPU.hsaunref!()
    end

    if pooled && ALLOC_QUEUE_POOL_MAX[prio_idx] > 0
        lock(ALLOC_QUEUE_LOCK) do
            pool = ALLOC_QUEUE_POOL[device][priority]
            if length(pool) < ALLOC_QUEUE_POOL_MAX[prio_idx]
                push!(pool, queue)
            end
        end
    end

    @label return_queue
    @log_finish(:alloc_queue, (;alloc_id), (;queue=reinterpret(UInt64, queue.queue)))
    @assert queue.active
    return queue
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

ROCQueue(; kwargs...) = ROCQueue(get_default_device(); kwargs...)

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

    lock(ALLOC_QUEUE_LOCK) do
        device_pools = get(ALLOC_QUEUE_POOL, queue.device, nothing)
        device_pools === nothing && return
        pool = get(device_pools, queue.priority, nothing)
        pool === nothing && return
        queue_idx = findfirst(q -> q === queue, pool)
        queue_idx === nothing && return
        deleteat!(pool, queue_idx)
    end

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
