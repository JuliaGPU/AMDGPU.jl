# High-level APIs

import AMDGPU: Runtime, Compiler
import .Runtime: ROCDim, ROCDim3
import .Compiler: hipfunction

export @roc, rocconvert

## Devices

"""
    default_device()::HIPDevice

Default device which will be used by default in tasks.
Meaning when a task is created, it selects this device as default.

All subsequent uses rely on [`device()`](@ref) for device selection.
"""
default_device() = Runtime.get_default_device()

"""
    default_device!(device::HIPDevice)

Set default device that will be used when creating new tasks.

!!! note
    This does not change current device being used.
    Refer to [`device!`](@ref) for that.
"""
default_device!(device::HIPDevice) = Runtime.set_default_device!(device)

"""
    default_device_id() -> Int

Returns the numeric ID of the current default device,
which is in the range of `1:length(AMDGPU.devices())`.
This number should be stable for all processes on the same node,
The [`default_device_id!`](@ref) function accepts the same
numeric ID that is produced by this function.
"""
default_device_id() = default_device().device_id

"""
    default_device_id!(idx::Integer, kind::Symbol=:gpu)

Sets the default device to `AMDGPU.devices(kind)[idx]`. See
[`default_device_id`](@ref) for details on the numbering semantics.
"""
default_device_id!(idx::Integer) = default_device!(devices()[idx])

"""
    device()::HIPDevice

Get currently active device.
This device is used when launching kernels via `@roc`.
"""
device() = task_local_state().device

"""
    device!(device::HIPDevice)

Switch current device being used.
This switches only for a task inside which it is called.

!!! note
    To select default device that will be used when creating new tasks,
    refer to [`default_device!`](@ref) for that.
"""
function device!(device::HIPDevice)
    task_local_state!(; device)
    return device
end
device!(f::Base.Callable, device::HIPDevice) = task_local_state!(f; device)

"""
    devices()

Get list of all devices.
"""
devices() = Runtime.fetch_devices()

"""
    device_id(device::HIPDevice) -> Int

Returns the numerical device ID for `device`. See [`default_device_id`](@ref)
for details on the numbering semantics.
"""
device_id(device::HIPDevice) = device.device_id

"""
    device_id!(idx::Integer, kind::Symbol=:gpu)

Sets the current device to `AMDGPU.devices(kind)[idx]`. See
[`device_id`](@ref) for details on the numbering semantics.
"""
device_id!(idx::Integer) = device!(devices()[idx])

# Contexts

context() = task_local_state().context
function device(context::HIPContext)
    return HIP.context!(context) do
        HIP.device()
    end
end

# Streams.

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

Change the priority of the default stream.
Accepted values are `:normal` (the default), `:low` and `:high`.
"""
function priority!(priority::Symbol)
    task_local_state!(;priority)
    return priority
end

"""
    priority!(f::Base.Callable, priority::Symbol)

Chnage the priority of default stream, execute `f` and
revert to the original priority.
Accepted values are `:normal` (the default), `:low` and `:high`.

# Returns

Return value of the function `f`.
"""
priority!(f::Base.Callable, priority::Symbol) = task_local_state!(f; priority)

# Device ISAs

default_isa(device::HIPDevice) = Runtime.default_isa(Runtime.hsa_device(device))

"""
    synchronize(stream::HIPStream = stream())

Blocks until all kernels currently executing on `stream` have completed.
"""
function synchronize(stm::HIPStream = stream())
    has_exception(stm) && error(get_exception_string(stm))

    HIP.synchronize(stm)

    has_exception(stm) && error(get_exception_string(stm))
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
const LAUNCH_KWARGS = [:gridsize, :groupsize, :shmem, :stream]

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
            @assert false "`dynamic` kernel launch is not yet implemented"
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

function launch_configuration(
    kern::Runtime.HIPKernel; shmem::Integer = 0, max_block_size::Integer = 0,
)
    HIP.launch_configuration(kern.fun; shmem, max_block_size)
end
