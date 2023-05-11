mutable struct ROCQueue
    device::ROCDevice
    queue::Ptr{HSA.Queue}
    priority::Symbol
    status::HSA.Status
    @atomic active::Bool
    active_kernels::LinkedList # TODO: Concrete type
    running::Base.Event
    lock::Threads.ReentrantLock
end

"""
    ROCQueue(; priority::Symbol=:normal, pooled::Bool=false)

Create an HSA queue on the currently active device.

!!! note
    Users are encouraged to use this method,
    instead of manually providing device since this one
    correctly handles device changes.
"""
function ROCQueue(; priority::Symbol=:normal, pooled::Bool=false)
    ROCQueue(AMDGPU.device(); priority, pooled)
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
    queue::ROCQueue
    exception::Union{Exception,Nothing}
end
function QueueError(queue::ROCQueue)
    err = if queue.status != HSA.STATUS_SUCCESS
        HSAError(queue.status)
    else
        nothing
    end
    return QueueError(queue, err)
end
function Base.showerror(io::IO, err::QueueError)
    queue = err.queue
    println(io, "QueueError(Queue $(repr(reinterpret(UInt64, queue.queue))) on $(queue.device)) due to:")
    if err.exception !== nothing
        Base.showerror(io, err.exception)
    else
        print(io, "Queue was killed")
    end
    println(io); print(io, "You can select a new queue with `AMDGPU.reset_dead_queue!()`")
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

"""
    set_queue_pool_size!(nums::NTuple{3, Int})

Set HSA queue pool max size for each priority.
Restart Julia session for the changes to take effect.

# Arguments:

- `nums::NTuple{3, Int}`: Maximum number of queues for `:normal`,
    `:low` and `:high` priority.
    Providing `0` for specific priority, disables pool for it.
"""
function set_queue_pool_size!(nums::NTuple{3, Int})
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

"""
    ROCQueue(device::ROCDevice; priority::Symbol=:normal, pooled::Bool=false)

Create an HSA queue which will be used to
instruct GPU hardware which kernels to launch.

Each queue, spawns an error monitoring thread that's responsible
for actually waiting on kernels and performing a cleanup after
kernel finished its execution.

!!! note "Oversubscribed Command Queues in GPUs"
    Be careful, with the number of HSA queues in use.
    When the number of allocated HSA queues is greater than
    the number of hardware queues, the GPU wastes significant time
    rotating between all allocated queues in search of ready tasks.

# Arguments:

- `device::ROCDevice`: Device on which to create queue.
- `priority::Symbol`: Queue's priority. Can be `:normal`, `:low`, `:high`.
- `pooled::Bool`: Whether to use pool when creating queues.
    When `true`, queues are drawn from it on creation
    and returned to pool instead of destroyed.
"""
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
        LinkedList{ROCKernelSignal}(), Base.Event(), Threads.ReentrantLock())

    # Create HSA queue.
    r_queue = Ref{Ptr{HSA.Queue}}()
    HSA.queue_create(
        device.agent, queue_size, queue_type,
        c_queue_error_handler, pointer_from_objref(queue),
        typemax(UInt32), typemax(UInt32), r_queue) |> check

    AMDGPU.hsaref!()
    queue.queue = r_queue[]

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
    kerns = queue.active_kernels::LinkedList{ROCKernelSignal}
    while queue.active || !isempty(kerns)
        # Fetch oldest signal, if any
        sig = lock(queue.lock) do
            if isempty(kerns)
                # Reset event
                reset(queue.running)
                return nothing
            else
                # Notify waiters that queue is running
                notify(queue.running)
                return first(kerns)
            end
        end

        # Wait for signal completion or new launches
        if sig !== nothing
            try
                wait(sig; check_exceptions=true, cleanup=true)
            catch err
                @debug "Kernel exception" exception=(err,catch_backtrace())
            end
            # Move to the next kernel.
            Base.@lock queue.lock begin
                next!(kerns)
            end
        else
            wait(queue.running)
        end
    end
end

function ensure_active(queue::ROCQueue)
    @label check
    if !queue.active
        throw(QueueError(queue))
    elseif queue.status != HSA.STATUS_SUCCESS
        pool = HIP.memory_pool(HIP.device())
        @warn """
        Queue status: $(queue.status).
        - HSA allocations: $(Base.format_bytes(Mem.ALL_ALLOCS[])).
        - Total Pooled allocations: $(Base.format_bytes(Mem.POOLED_ALLOCS[])).
        - HIP pool used: $(Base.format_bytes(HIP.used_memory(pool))).
        - HIP pool reserved: $(Base.format_bytes(HIP.reserved_memory(pool))).
        - Hard memory limit: $(Base.format_bytes(Mem.HARD_MEMORY_LIMIT)).
        """

        # We track status updates from the queue callback
        kill_queue!(queue)
        @goto check
    end
end

"""
Determine if there are active kernels for the queue.
If not, we can re-use it.
"""
function has_active_kernels(q::ROCQueue)
    lock(q.lock) do
        return !isempty(q.active_kernels)
    end
end

"""
    kill_queue!(queue::ROCQueue)

Kill `queue` and propagate queue error to
all waiter signals in case if there is one.

If queue is in the pool, it will be removed from it.

!!! note
    No need to manually call this function during regular use,
    it will be called automatically from [`ROCQueue`](@ref) finalizer.
"""
function kill_queue!(queue::ROCQueue)
    _, succ = @atomicreplace queue.active true => false
    succ || return

    # TODO: Eliminate race from active=false to setting exception

    @log_start(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)
    remove_pooled_queue!(queue)

    lock(RT_LOCK) do
        delete!(QUEUES, queue.queue)
    end
    lock(queue.lock) do
        # Send exception to all waiter signals
        if queue.status != HSA.STATUS_SUCCESS
            err = QueueError(queue)
            for kersig in queue.active_kernels::LinkedList{ROCKernelSignal}
                kersig::ROCKernelSignal
                kersig.exception = err
                notify(kersig)
            end
        end
    end

    HSA.queue_destroy(queue.queue) |> check
    @log_finish(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)
    return
end
