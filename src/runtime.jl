struct RuntimeDevice{D}
    device::D
end
default_device() = RuntimeDevice(default_device(RUNTIME[]))
default_device(::typeof(HSA_rt)) = get_default_agent()

struct RuntimeQueue{Q}
    queue::Q
end
default_queue() = default_queue(default_device())
default_queue(device::RuntimeDevice) = RuntimeQueue(default_queue(RUNTIME[], device))
default_queue(::typeof(HSA_rt), device::RuntimeDevice) =
    get_default_queue(device.device)
get_device(queue::RuntimeQueue{HSAQueue}) = RuntimeDevice(queue.queue.agent)

default_isa(device::RuntimeDevice{HSAAgent}) =
    get_first_isa(device.device)

struct RuntimeEvent{E}
    event::E
end
create_event(exe) = RuntimeEvent(create_event(RUNTIME[], exe))
Base.wait(event::RuntimeEvent, exe) = wait(event.event, exe)

"Tracks the completion and status of a kernel's execution."
struct HSAStatusSignal
    signal::HSASignal
    exe::HSAExecutable
end
create_event(::typeof(HSA_rt), exe) = HSAStatusSignal(HSASignal(), exe.exe)
function Base.wait(event::RuntimeEvent{HSAStatusSignal}; check_exceptions=true, cleanup=true, kwargs...)
    wait(event.event.signal; kwargs...) # wait for completion signal
    unpreserve!(event) # allow kernel-associated objects to be freed
    exe = event.event.exe::HSAExecutable{Mem.Buffer}
    mod = EXE_TO_MODULE_MAP[exe].value
    agent = exe.agent
    ex = nothing
    signal_handle = (event.event.signal.signal[]::HSA.Signal).handle
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
            ex = KernelException(RuntimeDevice(agent), isempty(ex_strings) ? nothing : join(ex_strings, '\n'))
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
    ex !== nothing && throw(ex)
end


struct RuntimeExecutable{E}
    exe::E
end
create_executable(device, entry, obj; globals=()) =
    RuntimeExecutable(create_executable(RUNTIME[], device, entry, obj; globals=globals))
function create_executable(::typeof(HSA_rt), device, entry, obj; globals=())
    global exe_cache

    # link with ld.lld
    @assert ld_lld_path != "" "ld.lld was not found; cannot link kernel"
    path_exe = mktemp(exe_cache) do path_o, io_o
        write(io_o, obj)
        flush(io_o)
        path_exe = path_o*".exe"
        run(`$ld_lld_path -shared -o $path_exe $path_o`)
        path_exe
    end
    if Base.JLOptions().debug_level > 1
        @debug "Emitted binary for $entry to $path_exe"
        return HSAExecutable(device.device, path_exe, entry; globals=globals)
    else
        data = read(path_exe)
        rm(path_exe)
        return HSAExecutable(device.device, data, entry; globals=globals)
    end
end
get_global(exe::RuntimeExecutable, sym::Symbol) =
    get_global(exe.exe, sym)

struct RuntimeKernel{K}
    kernel::K
end
create_kernel(device, exe, entry, args) =
    RuntimeKernel(create_kernel(RUNTIME[], device, exe, entry, args))
create_kernel(::typeof(HSA_rt), device, exe, entry, args) =
    HSAKernelInstance(device.device, exe.exe, entry, args)
launch_kernel(queue, kern, event; kwargs...) =
    launch_kernel(RUNTIME[], queue, kern, event; kwargs...)
function launch_kernel(::typeof(HSA_rt), queue, kern, event;
                       groupsize=nothing, gridsize=nothing)
    signal = event.event isa HSAStatusSignal ? event.event.signal : event.event
    launch!(queue.queue, kern.kernel, signal;
                       workgroup_size=groupsize, grid_size=gridsize)
end
barrier_and!(queue, events::Vector{<:RuntimeEvent}) = barrier_and!(queue, map(x->x.event,events))
barrier_and!(queue, signals::Vector{HSAStatusSignal}) = barrier_and!(queue, map(x->x.signal,signals))
barrier_or!(queue, events::Vector{<:RuntimeEvent}) = barrier_or!(queue, map(x->x.event,events))
barrier_or!(queue, signals::Vector{HSAStatusSignal}) = barrier_or!(queue, map(x->x.signal,signals))
