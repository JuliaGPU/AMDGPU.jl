struct RuntimeDevice{D}
    device::D
end
default_device() = RuntimeDevice(default_device(RUNTIME[]))
default_device(::typeof(HSA)) = HSARuntime.get_default_agent()

struct RuntimeQueue{Q}
    queue::Q
end
default_queue(device) = RuntimeQueue(default_queue(RUNTIME[], device))
default_queue(::typeof(HSA), device) =
    HSARuntime.get_default_queue(device.device)
get_device(queue::RuntimeQueue{HSAQueue}) = RuntimeDevice(queue.queue.agent)

default_isa(device::RuntimeDevice{HSAAgent}) =
    HSARuntime.get_first_isa(device.device)

struct RuntimeEvent{E}
    event::E
end
create_event() = RuntimeEvent(create_event(RUNTIME[]))
create_event(::typeof(HSA)) = HSASignal()
Base.wait(event::RuntimeEvent; kwargs...) = wait(event.event; kwargs...)

struct RuntimeExecutable{E}
    exe::E
end
create_executable(device, func) =
    RuntimeExecutable(create_executable(RUNTIME[], device, func))
function create_executable(::typeof(HSA), device, func)
    # link with ld.lld
    ld_path = HSARuntime.ld_lld_path
    @assert ld_path != "" "ld.lld was not found; cannot link kernel"
    # TODO: Do this more idiomatically
    io = open("/tmp/amdgpu-dump.o", "w")
    write(io, func.mod.data)
    close(io)
    run(`$ld_path -shared -o /tmp/amdgpu.exe /tmp/amdgpu-dump.o`)
    io = open("/tmp/amdgpu.exe", "r")
    data = read(io)
    close(io)

    return HSAExecutable(device.device, data, func.entry)
end

struct RuntimeKernel{K}
    kernel::K
end
create_kernel(device, exe, entry, args) =
    RuntimeKernel(create_kernel(RUNTIME[], device, exe, entry, args))
create_kernel(::typeof(HSA), device, exe, entry, args) =
    HSAKernelInstance(device.device, exe.exe, entry, args)
launch_kernel(queue, kern, event; kwargs...) =
    launch_kernel(RUNTIME[], queue, kern, event; kwargs...)
launch_kernel(::typeof(HSA), queue, kern, event;
              groupsize=nothing, gridsize=nothing) =
    HSARuntime.launch!(queue.queue, kern.kernel, event.event;
                       workgroup_size=groupsize, grid_size=gridsize)
