struct ExceptionFrame
    idx::Cint
    func::String
    file::String
    line::Cint
end
struct WorkgroupException <: Exception
    str::Union{String, Nothing}
    workgroup::Int
    indices::Vector{Bool}
    frames::Vector{ExceptionFrame}
end
struct KernelException <: Exception
    device::ROCDevice
    exceptions::Vector{WorkgroupException}
    dropped::Bool
end

function Base.showerror(io::IO, err::KernelException)
    println(io, "KernelException: exception(s) thrown during kernel execution on device $(err.device):")
    if length(err.exceptions) == 0
        println(io, "... no details were recorded")
    else
        for wgerr in err.exceptions
            if wgerr.str !== nothing
                println(io, wgerr.str)
                for frame in wgerr.frames
                    println(io, ">  [$(frame.idx)] $(frame.func) at $(frame.file):$(frame.line)")
                end
                println(io, "at workgroup: ", wgerr.workgroup)
                println(io, "at workitems:")
                for (idx, status) in enumerate(wgerr.indices)
                    if status
                        printstyled(io, lpad("$idx", 5); color=:red)
                    else
                        print(io, "     ")
                    end
                    if idx % 8 == 0
                        println(io)
                    end
                    if idx % 64 == 0
                        println(io)
                    end
                end
                println(io)
            end
        end
    end
    if err.dropped
        println(io, "... some exceptions weren't recorded")
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
        ex = get_exception(exe, kersig.kernel.state; signal_handle, check_exceptions)
        isnothing(ex) || (kersig.exception = ex;)
    end

    lock(RT_LOCK) do
        delete_metadata!(mod; signal_handle)
        if haskey(_active_kernels, kersig.queue) # The queue might be dead
            q_kernels = _active_kernels[kersig.queue]
            deleteat!(q_kernels, findall(x -> x == kersig, q_kernels))
        end
    end

    # Free KernelState buffers
    Mem.free(Mem.Buffer(reinterpret(Ptr{Cvoid},
                                    kersig.kernel.state.exception_flag_ptr),
                        kersig.queue.device, sizeof(Ptr{Cvoid})))
    Mem.free(Mem.Buffer(reinterpret(Ptr{Cvoid},
                                    kersig.kernel.state.exception_dropped_ptr),
                        kersig.queue.device, sizeof(Ptr{Cvoid})))

    isnothing(kersig.exception) || throw(kersig.exception)
    nothing
end

function Base.show(io::IO, kersig::ROCKernelSignal)
    ex = kersig.exception
    print(io, "ROCKernelSignal(signal=$(kersig.signal), $(ex !== nothing ? ", exception=$ex" : ""))")
end

Base.notify(kersig::ROCKernelSignal) = notify(kersig.signal)
