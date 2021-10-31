"Tracks the completion and status of a kernel's execution."
mutable struct HSAStatusSignal
    signal::HSASignal
    exe::HSAExecutable
    queue::HSAQueue
    done::Base.Event
    exception::Union{Exception,Nothing}
    function HSAStatusSignal(signal::HSASignal, exe::HSAExecutable, queue::HSAQueue; kwargs...)
        signal = new(signal, exe, queue, Base.Event(), nothing)
        @async try
            _wait(signal; kwargs...) # the real waiter
        catch err
            signal.exception = err
            notify(signal.done)
        end
        signal
    end
end

function Base.show(io::IO, signal::HSAStatusSignal)
    ex = signal.exception
    print(io, "HSAStatusSignal(signal=$(signal.signal), done=$(signal.done.set)$(ex !== nothing ? ", exception=$ex" : ""))")
end

function Base.wait(signal::HSAStatusSignal)
    wait(signal.done)
    ex = signal.exception
    if ex !== nothing
        throw(ex)
    end
end
function _wait(signal::HSAStatusSignal; check_exceptions=true, cleanup=true, kwargs...)
    wait(signal.signal; kwargs...) # wait for completion signal
    unpreserve!(signal) # allow kernel-associated objects to be freed
    exe = signal.exe::HSAExecutable{Mem.Buffer}
    mod = EXE_TO_MODULE_MAP[exe].value
    agent = exe.agent
    ex = nothing
    signal_handle = (signal.signal.signal[]::HSA.Signal).handle
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
                ex_ring_ptr_ptr = Base.unsafe_convert(Ptr{Ptr{ExceptionEntry}}, ex_ring)
                ex_ring_ptr = unsafe_load(ex_ring_ptr_ptr)
                while (ex_ring_value = unsafe_load(ex_ring_ptr)).kern != 1
                    if ex_ring_value.kern == signal_handle
                        push!(ex_strings, unsafe_string(reinterpret(Ptr{UInt8}, ex_ring_value.ptr)))
                        # FIXME: Write rest of entry first, then CAS 0 to kern field
                        unsafe_store!(ex_ring_ptr, ExceptionEntry(UInt64(0), LLVMPtr{UInt8,1}(0)))
                    end
                    ex_ring_ptr += sizeof(ExceptionEntry)
                end
            end
            unique!(ex_strings)
            ex = KernelException(agent, isempty(ex_strings) ? nothing : join(ex_strings, '\n'))
        end
    end
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
    if ex !== nothing
        signal.exception = ex
    end
    lock(RT_LOCK) do
        if haskey(_active_kernels, signal.queue) # The queue might be dead
            deleteat!(_active_kernels[signal.queue], findall(x->x==signal, _active_kernels[signal.queue]))
        end
    end
    notify(signal.done)
end
Base.notify(signal::HSAStatusSignal) = notify(signal.signal)
barrier_and!(queue, signals::Vector{HSAStatusSignal}) = barrier_and!(queue, map(x->x.signal,signals))
barrier_or!(queue, signals::Vector{HSAStatusSignal}) = barrier_or!(queue, map(x->x.signal,signals))
