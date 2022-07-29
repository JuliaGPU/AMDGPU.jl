# High-level APIs

import AMDGPU: Runtime, Compiler
import .Runtime: ROCDevice, ROCQueue, ROCExecutable, ROCKernel, ROCSignal, ROCKernelSignal, HSAError
import .Runtime: ROCDim, ROCDim3
import .Runtime: getinfo, wait!, mark!
import .Compiler: rocfunction

export @roc, rocconvert, rocfunction

## Devices

default_device() = Runtime.get_default_device()
default_device!(device::ROCDevice) = Runtime.set_default_device!(device)

devices(kind::Symbol=:gpu) = filter(device->device_type(device)==kind,
                                    copy(Runtime.ALL_DEVICES))

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

# Queues

default_queue() = default_queue(default_device())
default_queue(device::ROCDevice) = Runtime.get_default_queue(device)
device(queue::ROCQueue) = queue.device

default_isa(device::ROCDevice) = first(Runtime.isas(device))
default_isa_architecture(device::ROCDevice) =
    Runtime.architecture(first(Runtime.isas(device)))
default_isa_features(device::ROCDevice) =
    Runtime.features(first(Runtime.isas(device)))

## Executable creation

function create_executable(device, entry, obj; globals=())
    # link with ld.lld
    @assert ld_lld_path != "" "ld.lld was not found; cannot link kernel"
    path_exe = mktemp() do path_o, io_o
        write(io_o, obj)
        flush(io_o)
        path_exe = path_o*".exe"
        if lld_artifact
            LLD_jll.lld() do lld
                run(`$lld -flavor gnu -shared -o $path_exe $path_o`)
            end
        else
            run(`$ld_lld_path -shared -o $path_exe $path_o`)
        end
        path_exe
    end
    data = read(path_exe)
    rm(path_exe)

    return ROCExecutable(device, data, entry; globals=globals)
end

## Event creation
function create_event(kernel::ROCKernel; queue::ROCQueue=default_queue(), signal::Union{ROCKernelSignal,ROCSignal}=ROCSignal(), kwargs...)
    if signal isa ROCKernelSignal
        return signal
    end
    return ROCKernelSignal(signal, queue, kernel; kwargs...)
end

## Kernel creation
create_kernel(kernel::Runtime.HostKernel, f, args) = ROCKernel(kernel, f, args)

## Kernel launch and barriers

barrier_and!(signals::Vector) = barrier_and!(default_queue(), signals)
barrier_or!(signals::Vector) = barrier_or!(default_queue(), signals)
barrier_and!(queue::ROCQueue, signals::Vector{ROCKernelSignal}) =
    barrier_and!(queue, map(x->x.signal,signals))
barrier_or!(queue::ROCQueue, signals::Vector{ROCKernelSignal}) =
    barrier_or!(queue, map(x->x.signal,signals))
barrier_and!(queue::ROCQueue, signals::Vector{HSA.Signal}) = barrier_and!(queue, map(ROCSignal, signals))
barrier_or!(queue::ROCQueue, signals::Vector{HSA.Signal}) = barrier_or!(queue, map(ROCSignal, signals))
barrier_and!(queue::ROCQueue, signals::Vector{ROCSignal}) =
    Runtime.launch_barrier!(HSA.BarrierAndPacket, queue, signals)
barrier_or!(queue::ROCQueue, signals::Vector{ROCSignal}) =
    Runtime.launch_barrier!(HSA.BarrierOrPacket, queue, signals)

"""
    active_kernels(queue) -> Vector{ROCKernelSignal}

Returns the set of actively-executing kernels on `queue`.
"""
function active_kernels(queue::ROCQueue=default_queue())
    lock(Runtime.RT_LOCK) do
        copy(Runtime._active_kernels[queue])
    end
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

### @roc helper functions

# split keyword arguments to `@roc` into ones affecting the macro itself, the compiler and
# the code it generates, or the execution
function split_kwargs(kwargs)
    alias_kws    = Dict(:stream=>:queue)
    macro_kws    = [:dynamic, :launch, :wait, :mark]
    compiler_kws = [:name, :device, :queue, :global_hooks]
    call_kws     = [:gridsize, :groupsize, :config, :device, :queue]
    signal_kws   = [:signal, :soft, :minlat, :timeout]
    computed_kws = [:threads, :blocks]

    macro_kwargs = []
    compiler_kwargs = []
    call_kwargs = []
    signal_kwargs = []
    for kwarg in kwargs
        if Meta.isexpr(kwarg, :(=))
            key,val = kwarg.args
            oldkey = key
            if key in keys(alias_kws)
                key = alias_kws[key]
                kwarg = :($key=$val)
            end
            if isa(key, Symbol)
                if key in macro_kws
                    push!(macro_kwargs, kwarg)
                elseif key in compiler_kws
                    push!(compiler_kwargs, kwarg)
                    # Ensure we pass :device to call as well
                    if key in call_kws
                        push!(call_kwargs, kwarg)
                    end
                elseif key in call_kws
                    push!(call_kwargs, kwarg)
                elseif key in signal_kws
                    push!(signal_kwargs, kwarg)
                elseif key in computed_kws
                    push!(call_kwargs, kwarg)
                else
                    throw(ArgumentError("unknown keyword argument '$oldkey'"))
                end
            else
                throw(ArgumentError("non-symbolic keyword '$oldkey'"))
            end
        else
            throw(ArgumentError("non-keyword argument like option '$kwarg'"))
        end
    end

    return macro_kwargs, compiler_kwargs, call_kwargs, signal_kwargs
end
function simplify_call_kwargs!(call_kwargs)
    call_kwargs_keys = map(x->x.args[1], call_kwargs)
    has_threads = :threads in call_kwargs_keys
    has_blocks = :blocks in call_kwargs_keys
    has_threads || has_blocks || return
    if :groupsize in call_kwargs_keys
        throw(ArgumentError("cannot combine :threads/:blocks with :groupsize"))
    elseif :gridsize in call_kwargs_keys
        throw(ArgumentError("cannot combine :threads/:blocks with :gridsize"))
    end
    if has_threads
        threads_idx = findfirst(x->x.args[1]==:threads, call_kwargs)
        groupsize = call_kwargs[threads_idx].args[2]
        deleteat!(call_kwargs, threads_idx)
    else
        groupsize = 1
    end
    if has_blocks
        blocks_idx = findfirst(x->x.args[1]==:blocks, call_kwargs)
        blocks = call_kwargs[blocks_idx].args[2]
        deleteat!(call_kwargs, blocks_idx)
    else
        blocks = 1
    end
    push!(call_kwargs, :(groupsize=$groupsize))
    push!(call_kwargs, :(gridsize=$groupsize .* $blocks))
end

# assign arguments to variables, handle splatting
function assign_args!(code, args)
    # handle splatting
    splats = map(arg -> Meta.isexpr(arg, :(...)), args)
    args = map(args, splats) do arg, splat
        splat ? arg.args[1] : arg
    end

    # assign arguments to variables
    vars = Tuple(gensym() for arg in args)
    map(vars, args) do var,arg
        push!(code.args, :($var = $arg))
    end

    # convert the arguments, compile the function and call the kernel
    # while keeping the original arguments alive
    var_exprs = map(vars, args, splats) do var, arg, splat
         splat ? Expr(:(...), var) : var
    end

    return vars, var_exprs
end

### @roc macro

"""
    @roc [kwargs...] func(args...)

High-level interface for executing code on a GPU. The `@roc` macro should prefix a call,
with `func` a callable function or object that should return nothing. It will be compiled to
a GCN function upon first use, and to a certain extent arguments will be converted and
managed automatically using `rocconvert`. Finally, a call to `roccall` is
performed, scheduling a kernel launch on the specified (or default) HSA queue.

Several keyword arguments are supported that influence the behavior of `@roc`.
- `dynamic`: use dynamic parallelism to launch device-side kernels
- `launch`: whether to launch the kernel
- `wait`: whether to wait on all arguments' dependencies
- `mark`: whether to mark this kernel as a dependency for all arguments
- arguments that influence kernel compilation: see [`rocfunction`](@ref) and
  [`dynamic_rocfunction`](@ref)
- arguments that influence kernel launch: see [`AMDGPU.HostKernel`](@ref) and
  [`AMDGPU.DeviceKernel`](@ref)

The underlying operations (argument conversion, kernel compilation, kernel call) can be
performed explicitly when more control is needed, e.g. to reflect on the resource usage of a
kernel to determine the launch configuration. A host-side kernel launch is done as follows:

    args = ...
    GC.@preserve args begin
        kernel_f = rocconvert(f)
        kernel_args = rocconvert.(args)
        kernel_tt = Tuple{Core.Typeof.(kernel_args)...}
        kernel = rocfunction(kernel_f, kernel_tt; compilation_kwargs)
        kernel(kernel_args...; launch_kwargs)
    end

A device-side launch, aka. dynamic parallelism, is similar but more restricted:

    args = ...
    # GC.@preserve is not supported
    # we're on the device already, so no need to rocconvert
    kernel_tt = Tuple{Core.Typeof(args[1]), ...}    # this needs to be fully inferred!
    kernel = dynamic_rocfunction(f, kernel_tt)       # no compiler kwargs supported
    kernel(args...; launch_kwargs)
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
    macro_kwargs, compiler_kwargs, call_kwargs, signal_kwargs = split_kwargs(kwargs)
    simplify_call_kwargs!(call_kwargs)
    vars, var_exprs = assign_args!(code, args)

    # handle keyword arguments that influence the macro's behavior
    dynamic = false
    launch = true
    wait = true
    mark = true
    for kwarg in macro_kwargs
        key,val = kwarg.args
        if key == :dynamic
            isa(val, Bool) || throw(ArgumentError("`dynamic` keyword argument to @roc should be a constant Bool"))
            dynamic = val::Bool
        elseif key == :launch
            isa(val, Bool) || throw(ArgumentError("`launch` keyword argument to @roc should be a constant Bool"))
            launch = val::Bool
        elseif key == :wait
            isa(val, Bool) || throw(ArgumentError("`wait` keyword argument to @roc should be a constant Bool"))
            wait = val::Bool
        elseif key == :mark
            isa(val, Bool) || throw(ArgumentError("`mark` keyword argument to @roc should be a constant Bool"))
            mark = val::Bool
        else
            throw(ArgumentError("Unsupported keyword argument '$key'"))
        end
    end

    # FIXME: macro hygiene wrt. escaping kwarg values (this broke with 1.5)
    #        we esc() the whole thing now, necessitating gensyms...
    @gensym kernel_f kernel_args kernel_tt kernel kernel_instance device queue signal
    if dynamic
        # FIXME: we could probably somehow support kwargs with constant values by either
        #        saving them in a global Dict here, or trying to pick them up from the Julia
        #        IR when processing the dynamic parallelism marker
        isempty(compiler_kwargs) || error("@roc dynamic parallelism does not support compiler keyword arguments")

        # dynamic, device-side kernel launch
        push!(code.args,
            quote
                # we're in kernel land already, so no need to rocconvert arguments
                local $kernel_tt = Tuple{$((:(Core.Typeof($var)) for var in var_exprs)...)}
                local $kernel = $dynamic_rocfunction($f, $kernel_tt)
                $kernel($(var_exprs...); $(call_kwargs...))
             end)
    else
        # regular, host-side kernel launch
        #
        # convert the function, its arguments, call the compiler and launch the kernel
        # while keeping the original arguments alive

        call_kwargs_signal = [filter(x->x.args[1] != :signal, call_kwargs)...,
                              Expr(:(=), :signal, signal)]
        push!(code.args,
            quote
                GC.@preserve $(vars...) begin
                    local $kernel_f = $rocconvert($f)
                    local $kernel_args = map($rocconvert, ($(var_exprs...),))
                    local $kernel_tt = Tuple{map(Core.Typeof, $kernel_args)...}
                    local $kernel = $rocfunction($kernel_f, $kernel_tt; $(compiler_kwargs...))
                    if $wait
                        foreach($wait!, ($(var_exprs...),))
                    end
                    if $launch
                        local $kernel_instance = $create_kernel($kernel, $kernel_f, $kernel_args)
                        local $signal = $create_event($kernel_instance; $(signal_kwargs...))
                        $kernel($kernel_args...; $(call_kwargs_signal...))
                        if $mark
                            foreach(x->$mark!(x, $signal), ($(var_exprs...),))
                        end
                        $signal
                    else
                        $kernel
                    end
                end
            end)
        end
    return esc(code)
end
