struct QueueError <: Exception
    queue::Ptr{HSA.Queue}
    err::HSAError
end

function Base.showerror(io::IO, err::QueueError)
    println(io, "QueueError(Queue at $(err.queue)) due to:")
    Base.showerror(io, err.err)
end

mutable struct ROCQueue
    device::ROCDevice
    @atomic queue::Ptr{HSA.Queue}
    status::HSA.Status
    @atomic active::Bool
end
get_handle(queue::ROCQueue) = reinterpret(Ptr{Cvoid}, queue.queue)

const QUEUES = Dict{Ptr{HSA.Queue}, WeakRef}()

const DEFAULT_QUEUES = IdDict{ROCDevice, ROCQueue}()

function queue_error_handler(
    status::HSA.Status, _queue::Ptr{HSA.Queue}, queue_obj_ptr::Ptr{Cvoid},
)::Nothing
    if status != HSA.STATUS_SUCCESS
        queue::ROCQueue = unsafe_pointer_to_objref(queue_obj_ptr)
        queue.status = status
    end
    nothing
end

function ROCQueue(device::ROCDevice; priority::Symbol = :normal)
    alloc_id = rand(UInt64)
    @log_start(:alloc_queue, (;alloc_id), (;device=get_handle(device), priority))

    queue_size = Ref{UInt32}(0)
    getinfo(device.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, queue_size) |> check
    @assert queue_size[] > 0

    queue_type = Ref{HSA.QueueType}()
    getinfo(device.agent, HSA.AGENT_INFO_QUEUE_TYPE, queue_type) |> check
    @assert queue_type[] == HSA.QUEUE_TYPE_MULTI

    r_queue = Ref{Ptr{HSA.Queue}}()
    queue = ROCQueue(device, Ptr{HSA.Queue}(0), HSA.STATUS_SUCCESS, true)
    c_queue_error_handler = @cfunction(
        queue_error_handler, Cvoid, (HSA.Status, Ptr{HSA.Queue}, Ptr{Cvoid}))

    HSA.queue_create(
        device.agent, queue_size[], HSA.QUEUE_TYPE_MULTI,
        c_queue_error_handler, pointer_from_objref(queue),
        typemax(UInt32), typemax(UInt32), r_queue) |> check
    @atomic queue.queue = r_queue[]

    lock(RT_LOCK) do
        @assert !haskey(QUEUES, queue.queue)
        QUEUES[queue.queue] = WeakRef(queue)
        _active_kernels[queue] = AMDGPU.ROCKernelSignal[]
    end

    if !in(priority, (:normal, :low, :high))
        throw(ArgumentError(
            "Invalid queue priority: $priority\n" *
            "Options are :low, :normal, :high"))
    end

    if priority != :normal
        hsa_priority = if priority == :normal
            HSA.AMD_QUEUE_PRIORITY_NORMAL
        elseif priority == :low
            HSA.AMD_QUEUE_PRIORITY_LOW
        elseif priority == :high
            HSA.AMD_QUEUE_PRIORITY_HIGH
        end
        HSA.amd_queue_set_priority(queue.queue, hsa_priority) |> check
    end
    @log_finish(:alloc_queue, (;alloc_id), (;queue=reinterpret(UInt64, queue.queue)))

    AMDGPU.hsaref!()
    finalizer(queue) do q
        kill_queue!(q)
        AMDGPU.hsaunref!()
    end
    queue
end

ROCQueue() = ROCQueue(get_default_device())

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
Determine if there are active kernels for the queue.
If not, we can re-use it.
"""
function has_active_kernels(q::ROCQueue)
    lock(RT_LOCK) do
        active_kernels = get(_active_kernels, q, nothing)
        isnothing(active_kernels) && return false
        return !isempty(active_kernels)
    end
end

function kill_queue!(queue::ROCQueue)
    _, succ = @atomicreplace queue.active true => false
    succ || return

    @log_start(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)

    lock(RT_LOCK) do
        if get(DEFAULT_QUEUES, queue.device, nothing) == queue
            delete!(DEFAULT_QUEUES, queue.device)
        end
        delete!(QUEUES, queue.queue)

        # Send exception to all waiter signals.
        if queue.status != HSA.STATUS_SUCCESS
            err = QueueError(queue.queue, HSAError(queue.status))
            for kersig in _active_kernels[queue]
                kersig.exception = err
                notify(kersig)
            end
        end
        # Clear active kernel set.
        delete!(_active_kernels, queue)
    end

    HSA.queue_destroy(queue.queue) |> check

    @log_finish(:kill_queue!, (;queue=reinterpret(UInt64, queue.queue)), nothing)

    return
end
