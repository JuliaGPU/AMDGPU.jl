"""
    device_id() -> Int
    device_id(device::HIPDevice) -> Int

Returns the numerical device ID for `device` or for the current `AMDGPU.device()`.
"""
device_id()::Int = device().device_id
device_id(device::HIPDevice)::Int = device.device_id

"""
    device_id!(idx::Integer)

Sets the current device to `AMDGPU.devices()[idx]`. See
[`device_id`](@ref) for details on the numbering semantics.
"""
device_id!(idx::Integer) = device!(devices()[idx])

function device(context::HIPContext)
    return HIP.context!(context) do
        HIP.device()
    end
end

device(stream::HIPStream) = stream.device
device(idx::Integer) = devices()[idx]

"""
    synchronize(stream::HIPStream = stream(); blocking::Bool = false)

Wait until all kernels executing on `stream` have completed.

If there are running HostCalls, then `blocking` **must** be `false`.
Additionally, if you want to stop host calls afterwards,
then provide `stop_hostcalls=true` keyword argument.
"""
function synchronize(stm::HIPStream = stream();
    blocking::Bool = false, stop_hostcalls::Bool = false,
)
    HIP.synchronize(stm; blocking)
    throw_if_exception(stm.device)
    stop_hostcalls || return

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
        # Free buffers.
        AMDGPU.Device.free!(hc[1])

        @info "Stopped global hostcall: `$gbl`."
    end
    return
end
# TODO
# hostcalls are per-device right now, not per stream
# allow non blocking sync of several HIPStreams
# and only then disable global hostcall

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
    rocconvert(x)

This function is called for every argument to be passed to a kernel, allowing it to be
converted to a GPU-friendly format. By default, the function does nothing and returns the
input object `x` as-is.

Do not add methods to this function, but instead extend the underlying Adapt.jl package and
register methods for the the `AMDGPU.Adaptor` type.
"""
rocconvert(arg) = adapt(Runtime.Adaptor(), arg)

const MACRO_KWARGS = [:launch]
const COMPILER_KWARGS = [:name, :unsafe_fp_atomics]
const LAUNCH_KWARGS = [:gridsize, :groupsize, :shmem, :stream]

"""
    @roc [kwargs...] func(args...)

High-level interface for launching kernels on GPU.
Upon a first call it will be compiled, subsequent calls will re-use
the compiled object.

Several keyword arguments are supported:
- `launch::Bool = true`: whether to launch the kernel.
    If `false`, then returns a compiled kernel which can be launched by
    calling it and passing arguments.
- Arguments that influence kernel compilation, see
    [`AMDGPU.Compiler.hipfunction`](@ref).
- Arguments that influence kernel launch, see [`AMDGPU.Runtime.HIPKernel`](@ref).
"""
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

launch_configuration(kern::Runtime.HIPKernel; shmem::Integer = 0, max_block_size::Integer = 0) =
    HIP.launch_configuration(kern.fun; shmem, max_block_size)

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
