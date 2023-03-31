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

function Base.wait(
    kersig::ROCKernelSignal; check_exceptions::Bool = true,
    cleanup::Bool = false, signal_kwargs...,
)
    @log_start(:wait, (;entry=kersig.kernel.sym, signal=get_handle(kersig.signal)), nothing)
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
        @log_finish(:wait, (;entry=kersig.kernel.sym, signal=get_handle(kersig.signal)), nothing)
    end

    if cleanup
        cleanup!(kersig; finished, check_exceptions)
    elseif check_exceptions
        # Ensure we check for and propagate errors
        ex = get_exception(kersig; finished, cleanup=false)
        if ex !== nothing
            kersig.exception = ex
        end
    end

    if check_exceptions
        # Report any kernel-specific exceptions
        if kersig.exception !== nothing
            throw(kersig.exception)
        end
        # Report any queue-specific exceptions
        ensure_active(kersig.queue)
    end

    return finished
end

function cleanup!(
    kersig::ROCKernelSignal; finished::Bool, check_exceptions::Bool = true,
)
    _, succ = @atomicreplace kersig.active true => false
    succ || return

    unpreserve!(kersig)

    if finished
        ex = get_exception(kersig; finished, cleanup=true)
        isnothing(ex) || (kersig.exception = ex;)
    end

    exe = kersig.kernel.exe::ROCExecutable
    lock(RT_LOCK) do
        mod = EXE_TO_MODULE_MAP[exe].value::ROCModule
        signal_handle = get_handle(kersig.signal)::UInt64
        delete_metadata!(mod; signal_handle)
    end

    return
end
function get_exception(kersig::ROCKernelSignal; finished::Bool, cleanup::Bool)
    exe = kersig.kernel.exe::ROCExecutable
    signal_handle::UInt64 = get_handle(kersig.signal)
    return get_exception(exe; signal_handle, cleanup)
end

function Base.show(io::IO, kersig::ROCKernelSignal)
    ex = kersig.exception
    print(io, "ROCKernelSignal(signal=$(kersig.signal)$(ex !== nothing ? ", exception=$ex" : ""))")
end

Base.notify(kersig::ROCKernelSignal) = notify(kersig.signal)
