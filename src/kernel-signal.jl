"Tracks the completion and status of a kernel's execution."
mutable struct ROCKernelSignal
    signal::ROCSignal
    queue::ROCQueue
    kernel::ROCKernel
    done::Base.Event
    exception::Union{Exception,Nothing}
    function ROCKernelSignal(signal::ROCSignal, queue::ROCQueue, kernel::ROCKernel; kwargs...)
        signal = new(signal, queue, kernel, Base.Event(), nothing)
        errormonitor(Threads.@spawn _wait(signal; kwargs...)) # the real waiter
        signal
    end
end

function Base.show(io::IO, signal::ROCKernelSignal)
    ex = signal.exception
    print(io, "ROCKernelSignal(signal=$(signal.signal), done=$(signal.done.set)$(ex !== nothing ? ", exception=$ex" : ""))")
end

## exception type

struct KernelException <: Exception
    device::ROCDevice
    exstr::Union{String,Nothing}
end
KernelException(device::ROCDevice, exstr=nothing) = KernelException(RuntimeDevice(device), exstr)

function Base.showerror(io::IO, err::KernelException)
    print(io, "KernelException: exception(s) thrown during kernel execution on device $(err.device)")
    if err.exstr !== nothing
        println(io, ":")
        print(io, err.exstr)
    end
end

"The set of active kernels signals for each queue"
const _active_kernels = WeakKeyDict{ROCQueue,Vector{ROCKernelSignal}}()

function Base.wait(signal::ROCKernelSignal)
    wait(signal.done)
    ex = signal.exception
    if ex !== nothing
        throw(ex)
    end
end
function _wait(signal::ROCKernelSignal; check_exceptions=true, cleanup=true, kwargs...)
    ex = nothing
    finished = try
        wait(signal.signal; kwargs...) # wait for completion signal
        true
    catch err
        if err isa SignalTimeoutException && SIGNAL_TIMEOUT_KILL_QUEUE[]
            kill_queue!(signal.queue)
        end
        ex = err
        false
    end
    unpreserve!(signal) # allow kernel-associated objects to be freed
    finalize(signal.kernel)
    exe = signal.kernel.exe::ROCExecutable{Mem.Buffer}
    mod = EXE_TO_MODULE_MAP[exe].value
    device = exe.device
    signal_handle = (signal.signal.signal[]::HSA.Signal).handle
    if finished
        if haskey(exe.globals, :__global_exception_flag)
            # Check if any wavefront for this kernel threw an exception
            ex_flag = get_global(exe, :__global_exception_flag)
            ex_flag_ptr = Base.unsafe_convert(Ptr{Int64}, ex_flag)
            ex_flag_value = Base.unsafe_load(ex_flag_ptr)
            if ex_flag_value != 0
                ex_strings = String[]
                if check_exceptions && haskey(exe.globals, :__global_exception_ring)
                    # Check for and collect any exceptions, and clear their slots
                    ex_ring = get_global(exe, :__global_exception_ring)
                    ex_ring_ptr_ptr = Base.unsafe_convert(Ptr{Ptr{AMDGPU.Device.ExceptionEntry}}, ex_ring)
                    ex_ring_ptr = unsafe_load(ex_ring_ptr_ptr)
                    while (ex_ring_value = unsafe_load(ex_ring_ptr)).kern != 1
                        if ex_ring_value.kern == signal_handle
                            push!(ex_strings, unsafe_string(reinterpret(Ptr{UInt8}, ex_ring_value.ptr)))
                            # FIXME: Write rest of entry first, then CAS 0 to kern field
                            unsafe_store!(ex_ring_ptr, AMDGPU.Device.ExceptionEntry(UInt64(0), Core.LLVMPtr{UInt8,1}(0)))
                        end
                        ex_ring_ptr += sizeof(AMDGPU.Device.ExceptionEntry)
                    end
                end
                unique!(ex_strings)
                ex = KernelException(device, isempty(ex_strings) ? nothing : join(ex_strings, '\n'))
            end
        end
    end
    if ex !== nothing
        signal.exception = ex
    end
    lock(RT_LOCK) do
        if cleanup
            # Clean-up malloc'd data
            for idx in length(mod.metadata):-1:1
                metadata_value = mod.metadata[idx]
                if metadata_value.kern == signal_handle
                    @debug "Cleaning up data: $metadata_value"
                    Mem.free(metadata_value.buf)
                    deleteat!(mod.metadata, idx)
                end
            end
        end
        if haskey(_active_kernels, signal.queue) # The queue might be dead
            deleteat!(_active_kernels[signal.queue], findall(x->x==signal, _active_kernels[signal.queue]))
        end
    end
    notify(signal.done)
end
Base.notify(signal::ROCKernelSignal) = notify(signal.signal)
