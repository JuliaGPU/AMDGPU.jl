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
    device_id() -> Int
    device_id(device::HIPDevice) -> Int

Returns the numerical device ID for `device` or for the current `AMDGPU.device()`.
"""
device_id() = device().device_id
device_id(device::HIPDevice) = device.device_id

"""
    device_id!(idx::Integer)

Sets the current device to `AMDGPU.devices()[idx]`. See
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

"""
    stream()

Get the HIP stream that should be used as the default one for the currently executing task.
"""
stream() = task_local_state().stream::HIPStream

"""
    stream!(stream::HIPStream)

Change the default stream to be used **within the same Julia task**.
"""
stream!(stream::HIPStream) = task_local_state!(;stream)

"""
    stream!(f::Base.Callable, stream::HIPStream)

Change the default stream to be used **within the same Julia task**,
execute `f` and revert to the original stream.

# Returns

Return value of the function `f`.
"""
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
    synchronize(stream::HIPStream = stream(); blocking::Bool = true)

Blocks until all kernels currently executing on `stream` have completed.

If there are running HostCalls, then it non-blocking synchronization is required
which can be done with `blocking=false` keyword.
Additionally, it stops any running global hostcall afterwards.
Note, that non-blocking synchronization is slower than blocking.
"""
function synchronize(stm::HIPStream = stream(); blocking::Bool = true)
    throw_if_exception(stm.device)
    HIP.synchronize(stm; blocking)
    throw_if_exception(stm.device)

    blocking && return

    # Stop any running global hostcall.
    global_hostcall_names = (
        :malloc_hostcall, :free_hostcall, :print_hostcall, :printf_hostcall)
    for gbl in global_hostcall_names
        hc = AMDGPU.Device.get_named_perdevice_hostcall(stm.device, gbl)
        isnothing(hc) && continue
        hc[1].finish[] && continue

        # Signal HostCall to exit.
        AMDGPU.Device.finish!(hc[1])
        # Remove it from global hostcalls, so that new one is created.
        AMDGPU.Device.remove_perdevice_hostcall!(stm.device, gbl)
    end
    return
end
# TODO
#   allow non blocking sync of several HIPStreams
#   and only then disable global hostcall

"""
    @sync ex

Run expression `ex` on currently active stream
and synchronize the GPU on that stream afterwards.

See also: [`synchronize`](@ref).
"""
macro sync(ex)
    quote
        local ret = $(esc(ex))
        AMDGPU.synchronize()
        ret
    end
end

"""
Blocks until all kernels on all streams have completed.
Uses currently active device.
"""
device_synchronize() = HIP.device_synchronize()

"""
    rocconvert(x)

This function is called for every argument to be passed to a kernel, allowing it to be
converted to a GPU-friendly format. By default, the function does nothing and returns the
input object `x` as-is.

Do not add methods to this function, but instead extend the underlying Adapt.jl package and
register methods for the the `AMDGPU.Adaptor` type.
"""
rocconvert(arg) = adapt(Runtime.Adaptor(), arg)

const MACRO_KWARGS = [:launch]
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

    launch = true
    for kwarg in macro_kwargs
        key, val = kwarg.args
        if key == :launch
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

"""
    @elapsed ex

A macro to evaluate an expression, discarding the resulting value, instead returning the
number of seconds it took to execute on the GPU, as a floating-point number.
"""
macro elapsed(ex)
    quote
        current_stream = stream()
        t0 = HIP.HIPEvent(current_stream; do_record=false, timing=true)
        t1 = HIP.HIPEvent(current_stream; do_record=false, timing=true)
        HIP.record(t0)
        $(esc(ex))
        HIP.record(t1)
        HIP.synchronize(t1)
        HIP.elapsed(t0, t1)
    end
end
