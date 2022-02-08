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
    first(isas(device.device))

struct RuntimeEvent{E}
    event::E
end
create_event(exe; kwargs...) = RuntimeEvent(create_event(RUNTIME[], exe; kwargs...))
Base.wait(event::RuntimeEvent; kwargs...) = wait(event.event; kwargs...)

struct RuntimeExecutable{E}
    exe::E
end
create_executable(device, entry, obj; globals=()) =
    RuntimeExecutable(create_executable(RUNTIME[], device, entry, obj; globals=globals))
function create_executable(::typeof(HSA_rt), device, entry, obj; globals=())
    # link with ld.lld
    @assert ld_lld_path != "" "ld.lld was not found; cannot link kernel"
    path_exe = mktemp() do path_o, io_o
        write(io_o, obj)
        flush(io_o)
        path_exe = path_o*".exe"
        run(`$ld_lld_path -shared -o $path_exe $path_o`)
        path_exe
    end
    data = read(path_exe)
    rm(path_exe)

    return HSAExecutable(device.device, data, entry; globals=globals)
end
get_global(exe::RuntimeExecutable, sym::Symbol) =
    get_global(exe.exe, sym)

create_event(::typeof(HSA_rt), exe::RuntimeExecutable{<:HSAExecutable}; queue=default_queue(), kwargs...) =
    create_event(HSA_rt, exe, queue; kwargs...)
create_event(::typeof(HSA_rt), exe::RuntimeExecutable{<:HSAExecutable}, queue::RuntimeQueue; kwargs...) =
    HSAStatusSignal(HSASignal(), exe.exe, queue.queue)
create_event(::typeof(HSA_rt), exe::RuntimeExecutable{<:HSAExecutable}, queue::HSAQueue; kwargs...) =
    HSAStatusSignal(HSASignal(), exe.exe, queue)

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
barrier_or!(queue, events::Vector{<:RuntimeEvent}) = barrier_or!(queue, map(x->x.event,events))
