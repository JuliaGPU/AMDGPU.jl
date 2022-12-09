struct KernelException <: Exception
    device::ROCDevice
    exstr::Union{String, Nothing}
end

function Base.showerror(io::IO, err::KernelException)
    print(io, "KernelException: exception(s) thrown during kernel execution on device $(err.device)")
    if err.exstr !== nothing
        println(io, ":")
        print(io, err.exstr)
    end
end

mutable struct ROCKernelSignal
    signal::ROCSignal
    queue::ROCQueue
    kernel::ROCKernel
    exception::Union{Exception, Nothing}
    @atomic active::Bool

    function ROCKernelSignal(
        signal::ROCSignal, queue::ROCQueue, kernel::ROCKernel;
    )
        kersig = new(signal, queue, kernel, nothing, true)
        finalizer(kersig) do k
            cleanup!(k; finished=true)
        end
        kersig
    end
end

const _active_kernels = WeakKeyDict{ROCQueue, Vector{ROCKernelSignal}}()

function Base.wait(
    kersig::ROCKernelSignal; check_exceptions::Bool = true, signal_kwargs...,
)
    @log_start(:wait, (;f=typeof(kersig.kernel.f), tt=typeof(kersig.kernel.args), signal=get_handle(kersig.signal)), nothing)
    finished = try
        wait(kersig.signal; queue=kersig.queue, signal_kwargs...)
        true
    catch err
        if isa(err, SignalTimeoutException) && SIGNAL_TIMEOUT_KILL_QUEUE[]
            kill_queue!(kersig.queue)
        end
        isnothing(kersig.exception) && (kersig.exception = err;)
        false
    finally
        @log_finish(:wait, (;f=typeof(kersig.kernel.f), tt=typeof(kersig.kernel.args), signal=get_handle(kersig.signal)), nothing)
        queue_error = kersig.queue.status != HSA.STATUS_SUCCESS
        # If it is QueueError, `kill_queue!` will fill `exception` field.
        queue_error && kill_queue!(kersig.queue)
    end

    cleanup!(kersig; finished, check_exceptions)
    return finished
end

function cleanup!(
    kersig::ROCKernelSignal; finished::Bool, check_exceptions::Bool = true,
)
    _, succ = @atomicreplace kersig.active true => false
    succ || return

    @atomic :monotonic kersig.queue.running -= 1

    unpreserve!(kersig)

    exe::ROCExecutable = kersig.kernel.exe
    mod::ROCModule = EXE_TO_MODULE_MAP[exe].value
    signal_handle::UInt64 = get_handle(kersig.signal)
    if finished
        ex = get_exception(exe; signal_handle, check_exceptions)
        isnothing(ex) || (kersig.exception = ex;)
    end

    lock(RT_LOCK) do
        delete_metadata!(mod; signal_handle)
        if haskey(_active_kernels, kersig.queue) # The queue might be dead
            q_kernels = _active_kernels[kersig.queue]
            deleteat!(q_kernels, findall(x -> x == kersig, q_kernels))
        end
    end

    isnothing(kersig.exception) || throw(kersig.exception)
    nothing
end

function Base.show(io::IO, kersig::ROCKernelSignal)
    ex = kersig.exception
    print(io, "ROCKernelSignal(signal=$(kersig.signal), $(ex !== nothing ? ", exception=$ex" : ""))")
end

Base.notify(kersig::ROCKernelSignal) = notify(kersig.signal)
