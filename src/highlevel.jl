# High-level APIs

import AMDGPU: Runtime, Compiler
import .Runtime: ROCDevice, ROCQueue, ROCExecutable, ROCKernel, ROCSignal, ROCKernelSignal, HSAError
import .Runtime: ROCDim, ROCDim3
import .Compiler: hipfunction

export @roc, rocconvert

## Devices

"""
    default_device()::ROCDevice

Default device which will be used by default in tasks.
Meaning when a task is created, it selects this device as default.

All subsequent uses rely on [`device()`](@ref) for device selection.
"""
default_device() = Runtime.get_default_device()

"""
    default_device!(device::ROCDevice)

Set default device that will be used when creating new tasks.

!!! note
    This does not change current device being used.
    Refer to [`device!`](@ref) for that.
"""
default_device!(device::ROCDevice) = Runtime.set_default_device!(device)

"""
    device()::ROCDevice

Get currently active device.
This device is used when launching kernels via `@roc`.
"""
device() = task_local_state().device

"""
    device!(device::ROCDevice)

Switch current device being used.
This switches only for a task inside which it is called.

!!! note
    To select default device that will be used when creating new tasks,
    refer to [`default_device!`](@ref) for that.
"""
function device!(device::ROCDevice)
    task_local_state!(; device)
    return device
end
device!(f::Base.Callable, device::ROCDevice) = task_local_state!(f; device)

"""
    devices(kind::Symbol = :gpu)

Get list of all devices of the given `kind`.
`kind` can be `:cpu`, `:gpu` or `:dsp`, although AMDGPU.jl supports
execution only on `:gpu` devices.
"""
devices(kind::Symbol = :gpu) =
    filter!(d -> device_type(d) == kind, copy(Runtime.ALL_DEVICES))

"""
    default_device_id(kind::Symbol=:gpu) -> Int

Returns the numeric ID of the current default device, which is in the range of
`1:length(AMDGPU.devices(kind))`. This number should be stable for all
processes on the same node, so long as any device filtering is consistently
applied (such as `ROCR_VISIBLE_DEVICES`). The [`default_device_id!`](@ref)
function accepts the same numeric ID that is produced by this function.
"""
default_device_id(kind::Symbol=:gpu) =
    something(findfirst(a->a==default_device(), devices(kind)))

"""
    default_device_id!(idx::Integer, kind::Symbol=:gpu)

Sets the default device to `AMDGPU.devices(kind)[idx]`. See
[`default_device_id`](@ref) for details on the numbering semantics.
"""
default_device_id!(idx::Integer, kind::Symbol=:gpu) =
    default_device!(devices(kind)[idx])

"""
    device_id(device::ROCDevice, kind::Symbol=:gpu) -> Int

Returns the numerical device ID for `device`. See [`default_device_id`](@ref)
for details on the numbering semantics.
"""
device_id(device::ROCDevice, kind::Symbol=:gpu) =
    something(findfirst(dev->dev === device, devices(kind)))

"""
    device_id!(idx::Integer, kind::Symbol=:gpu)

Sets the current device to `AMDGPU.devices(kind)[idx]`. See
[`device_id`](@ref) for details on the numbering semantics.
"""
device_id!(idx::Integer, kind::Symbol=:gpu) =
    device!(devices(kind)[idx])

"""
    device_type(device::ROCDevice) -> Symbol

Return the kind of `device` as a `Symbol`. CPU devices return `:cpu`, GPU
devices return `:gpu`, DSP devices return `:dsp`, and all others return
`:unknown`.
"""
function device_type(device::ROCDevice)
    devtype = Runtime.device_type(device)
    if devtype == HSA.DEVICE_TYPE_CPU
        return :cpu
    elseif devtype == HSA.DEVICE_TYPE_GPU
        return :gpu
    elseif devtype[] == HSA.DEVICE_TYPE_DSP
        return :dsp
    else
        return :unknown
    end
end

wavefrontsize(device::ROCDevice) = Runtime.device_wavefront_size(device)

# Contexts

context() = task_local_state().context
function device(context::HIPContext)
    return HIP.context!(context) do
        HIP.device()
    end
end

device_id(device::HIPDevice) = device.device_id
HIPDevice(device::ROCDevice) = HIPDevice(device_id(device))
HIPContext(device::ROCDevice) = HIPContext(HIPDevice(device))

# Queues/Streams

"""
    queue()::ROCQueue

Get task-local default queue for the currently active device.
"""
queue() = task_local_state().queue::ROCQueue
@deprecate default_queue() queue()
function queue(device::ROCDevice)
    tls = task_local_state()
    q = tls.queues[device_id(device)]
    isnothing(q) || return q

    tls.queues[device_id(device)] = ROCQueue(device)
    return q
end
"""
    queue!(f::Base.Callable, queue::ROCQueue)

Change default queue, execute given function `f`
and revert back to the original queue.

# Returns

Return value of the function `f`.
"""
queue!(f::Base.Callable, queue::ROCQueue) = task_local_state!(f; queue)
device(queue::ROCQueue) = queue.device

default_stream() = HIP.default_stream()
stream() = task_local_state().stream::HIPStream
function stream!(stream::HIPStream)
    task_local_state!(;stream)
    return stream
end
stream!(f::Base.Callable, stream::HIPStream) = task_local_state!(f; stream)
device(stream::HIPStream) = stream.device

priority() = task_local_state().priority

"""
    priority!(priority::Symbol)

Change the priority of the default queue.
Accepted values are `:normal` (the default), `:low` and `:high`.
"""
function priority!(priority::Symbol)
    task_local_state!(;priority)
    return priority
end

"""
    priority!(f::Base.Callable, priority::Symbol)

Chnage the priority of default queue, execute `f` and
revert to the original priority.
Accepted values are `:normal` (the default), `:low` and `:high`.

# Returns

Return value of the function `f`.
"""
priority!(f::Base.Callable, priority::Symbol) = task_local_state!(f; priority)

# Device ISAs

default_isa(device::ROCDevice) = Runtime.default_isa(device)
default_isa_architecture(device::ROCDevice) = Runtime.architecture(default_isa(device))
default_isa_features(device::ROCDevice) = Runtime.features(default_isa(device))

"""
    synchronize(stream::HIPStream = stream())

Blocks until all kernels currently executing on `stream` have completed.
"""
function synchronize(stream::HIPStream = stream())
    Compiler.check_exceptions()
    HIP.hipStreamSynchronize(stream.stream) |> check
    Compiler.check_exceptions()
    return
end

## @roc interface

"""
    rocconvert(x)

This function is called for every argument to be passed to a kernel, allowing it to be
converted to a GPU-friendly format. By default, the function does nothing and returns the
input object `x` as-is.

Do not add methods to this function, but instead extend the underlying Adapt.jl package and
register methods for the the `AMDGPU.Adaptor` type.
"""
rocconvert(arg) = adapt(Runtime.Adaptor(), arg)

const MACRO_KWARGS = [:dynamic, :launch]
const COMPILER_KWARGS = [:name]
const LAUNCH_KWARGS = [:griddim, :blockdim, :shmem, :stream]

macro roc(ex...)
    # destructure the `@roc` expression
    call = ex[end]
    kwargs = ex[1:end-1]

    # destructure the kernel call
    Meta.isexpr(call, :call) || throw(ArgumentError("second argument to @roc should be a function call"))
    f = call.args[1]
    args = call.args[2:end]

    code = quote end
    vars, var_exprs = assign_args!(code, args)

    macro_kwargs, compiler_kwargs, launch_kwargs, other_kwargs =
        split_kwargs(kwargs, MACRO_KWARGS, COMPILER_KWARGS, LAUNCH_KWARGS)
    if !isempty(other_kwargs)
        key, val = first(other_kwargs).args
        throw(ArgumentError("Unsupported keyword argument: `$key`."))
    end

    dynamic = false # TODO unsupported for now
    launch = true
    for kwarg in macro_kwargs
        key, val = kwarg.args
        if key == :dynamic
            isa(val, Bool) || throw(ArgumentError(
                "`dynamic` keyword argument to @roc should be a constant Bool"))
            dynamic = val::Bool
        elseif key == :launch
            isa(val, Bool) || throw(ArgumentError(
                "`launch` keyword argument to @roc should be a constant Bool"))
            launch = val::Bool
        else
            throw(ArgumentError("Unsupported keyword argument '$key'"))
        end
    end

    # FIXME: macro hygiene wrt. escaping kwarg values (this broke with 1.5)
    #        we esc() the whole thing now, necessitating gensyms...
    @gensym kernel_f kernel_args kernel_tt kernel
    push!(code.args,
        quote
            GC.@preserve $(vars...) begin
                local $kernel_f = $rocconvert($f)
                local $kernel_args = map($rocconvert, ($(var_exprs...),))
                local $kernel_tt = Tuple{map(Core.Typeof, $kernel_args)...}
                local $kernel = $hipfunction($kernel_f, $kernel_tt; $(compiler_kwargs...))

                if $launch
                    $kernel($(var_exprs...); $(launch_kwargs...))
                end
                $kernel
            end
        end)

    return esc(quote
        let
            $code
        end
    end)
end

# TODO
# launch config

launch_configuration(kern::Runtime.HostKernel; kwargs...) =
    launch_configuration(kern.fun)
function launch_configuration(fun::Runtime.ROCFunction; input_block_size=1, localmem=0)
    occ = Compiler.calculate_occupancy(fun; input_block_size, localmem)
    return (;groupsize=occ.best_block_size)
end
