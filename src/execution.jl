# Native execution support

export @roc, rocconvert, rocfunction, nextwarp, prevwarp

## host to device value conversion

# Base.RefValue isn't GPU compatible, so provide a compatible alternative
struct ROCRefValue{T} <: Ref{T}
    x::T
end
Base.getindex(r::ROCRefValue) = r.x
Base.setindex!(r::ROCRefValue{T}, value::T) where T = (r.x = value;)
Adapt.adapt_structure(to::Adaptor, r::Base.RefValue) = ROCRefValue(adapt(to, r[]))

# broadcast sometimes passes a ref(type), resulting in a GPU-incompatible DataType box.
# avoid that by using a special kind of ref that knows about the boxed type.
struct ROCRefType{T} <: Ref{DataType} end
Base.getindex(r::ROCRefType{T}) where T = T
Adapt.adapt_structure(to::Adaptor, r::Base.RefValue{<:Union{DataType,Type}}) = ROCRefType{r[]}()

"""
    rocconvert(x)

This function is called for every argument to be passed to a kernel, allowing it to be
converted to a GPU-friendly format. By default, the function does nothing and returns the
input object `x` as-is.

Do not add methods to this function, but instead extend the underlying Adapt.jl package and
register methods for the the `AMDGPU.Adaptor` type.
"""
rocconvert(arg) = adapt(Adaptor(), arg)


## helper functions

# split keyword arguments to `@roc` into ones affecting the macro itself, the compiler and
# the code it generates, or the execution
function split_kwargs(kwargs)
    alias_kws    = Dict(:agent=>:device, :stream=>:queue)
    macro_kws    = [:dynamic, :launch]
    compiler_kws = [:name, :device, :queue, :global_hooks]
    call_kws     = [:gridsize, :groupsize, :config, :device, :queue, :signal]
    computed_kws = [:threads, :blocks]

    macro_kwargs = []
    compiler_kwargs = []
    call_kwargs = []
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

    return macro_kwargs, compiler_kwargs, call_kwargs
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


## high-level @roc interface

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
- arguments that influence kernel compilation: see [`rocfunction`](@ref) and
  [`dynamic_rocfunction`](@ref)
- arguments that influence kernel launch: see [`AMDGPU.HostKernel`](@ref) and
  [`AMDGPU.DeviceKernel`](@ref)

The underlying operations (argument conversion, kernel compilation, kernel call) can be
performed explicitly when more control is needed, e.g. to reflect on the resource usage of a
kernel to determine the launch configuration. A host-side kernel launch is done as follows:

    args = ...
    GC.@preserve args begin
        kernel_args = rocconvert.(args)
        kernel_tt = Tuple{Core.Typeof.(kernel_args)...}
        kernel = rocfunction(f, kernel_tt; compilation_kwargs)
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
    macro_kwargs, compiler_kwargs, call_kwargs = split_kwargs(kwargs)
    simplify_call_kwargs!(call_kwargs)
    vars, var_exprs = assign_args!(code, args)

    # handle keyword arguments that influence the macro's behavior
    dynamic = false
    launch = true
    for kwarg in macro_kwargs
        key,val = kwarg.args
        if key == :dynamic
            isa(val, Bool) || throw(ArgumentError("`dynamic` keyword argument to @roc should be a constant Bool"))
            dynamic = val::Bool
        elseif key == :launch
            isa(val, Bool) || throw(ArgumentError("`launch` keyword argument to @roc should be a constant Bool"))
            launch = val::Bool
        else
            throw(ArgumentError("Unsupported keyword argument '$key'"))
        end
    end

    # FIXME: macro hygiene wrt. escaping kwarg values (this broke with 1.5)
    #        we esc() the whole thing now, necessitating gensyms...
    @gensym kernel_args kernel_tt device kernel queue signal
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
        # convert the arguments, call the compiler and launch the kernel
        # while keeping the original arguments alive

        push!(code.args,
            quote
                GC.@preserve $(vars...) begin
                    local $kernel_args = map($rocconvert, ($(var_exprs...),))
                    local $kernel_tt = Tuple{map(Core.Typeof, $kernel_args)...}
                    local $kernel = $rocfunction($f, $kernel_tt; $(compiler_kwargs...))
                    foreach($wait!, ($(var_exprs...),))
                    if $launch
                        local $signal = $create_event($kernel.mod.exe; $(call_kwargs...))
                        $kernel($kernel_args...; signal=$signal, $(filter(x->x.args[1] != :signal, call_kwargs)...))
                        foreach(x->$mark!(x, $signal), ($(var_exprs...),))
                        $signal
                    else
                        $kernel
                    end
                end
            end)
        end
    return esc(code)
end



## abstract kernel functionality

abstract type AbstractKernel{F,TT} end

# FIXME: there doesn't seem to be a way to access the documentation for the call-syntax,
#        so attach it to the type -- https://github.com/JuliaDocs/Documenter.jl/issues/558

"""
    (::HostKernel)(args...; kwargs...)
    (::DeviceKernel)(args...; kwargs...)

Low-level interface to call a compiled kernel, passing GPU-compatible arguments in `args`.
For a higher-level interface, use [`AMDGPU.@roc`](@ref).

The following keyword arguments are supported:
- `groupsize` (defaults to `1`) or `threads` (CUDA.jl compatibility shim)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `gridsize` (defaults to `1`)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `blocks` (CUDA.jl compatibility shim)
  Can be either an `Int` or an `NTuple{N,Int}` (where `1 <= N <= 3`)
- `config`: callback function to dynamically compute the launch configuration.
  should accept a `HostKernel` and return a name tuple with any of the above as fields.
- `queue` (defaults to the default queue)
"""
AbstractKernel

@generated function call(kernel::AbstractKernel{F,TT}, args...; call_kwargs...) where {F,TT}
    sig = Base.signature_type(F, TT)
    args = (:F, (:( args[$i] ) for i in 1:length(args))...)

    # filter out ghost arguments that shouldn't be passed
    predicate = dt -> isghosttype(dt) || Core.Compiler.isconstType(dt)
    to_pass = map(!predicate, sig.parameters)
    call_t =                  Type[x[1] for x in zip(sig.parameters,  to_pass) if x[2]]
    call_args = Union{Expr,Symbol}[x[1] for x in zip(args, to_pass)            if x[2]]

    # replace non-isbits arguments (they should be unused, or compilation would have failed)
    # alternatively, allow `launch` with non-isbits arguments.
    for (i,dt) in enumerate(call_t)
        if !isbitstype(dt)
            call_t[i] = Ptr{Any}
            call_args[i] = :C_NULL
        end
    end

    # finalize types
    call_tt = Base.to_tuple_type(call_t)

    quote
        Base.@_inline_meta

        roccall(kernel, $call_tt, $(call_args...); call_kwargs...)
    end
end


## host-side kernels

struct HostKernel{F,TT} <: AbstractKernel{F,TT}
    mod::ROCModule
    fun::ROCFunction
end

@doc (@doc AbstractKernel) HostKernel

@inline function roccall(kernel::HostKernel, tt, args...; config=nothing, signal, device=nothing, kwargs...)
    device = something(device, default_device())
    queue = get(kwargs, :queue, default_queue(device))
    if queue isa HSAQueue
        queue = RuntimeQueue(queue)
    end
    if config !== nothing
        roccall(kernel.fun, tt, args...; kwargs..., config(kernel)..., queue=queue, signal=signal)
    else
        roccall(kernel.fun, tt, args...; kwargs..., queue=queue, signal=signal)
    end
end


## host-side API

"""
    rocfunction(f, tt=Tuple{}; kwargs...)

Low-level interface to compile a function invocation for the currently-active GPU, returning
a callable kernel object. For a higher-level interface, use [`@roc`](@ref).

The following keyword arguments are supported:
- `name`: overrides the name that the kernel will have in the generated code
- `device`: chooses which device to compile the kernel for
- `global_hooks`: specifies maps from global variable name to initializer hook

The output of this function is automatically cached, i.e. you can simply call `rocfunction`
in a hot path without degrading performance. New code will be generated automatically, when
function definitions change, or when different types or keyword arguments are provided.
"""
function rocfunction(f::Core.Function, tt::Type=Tuple{}; name=nothing, device=default_device(), global_hooks=NamedTuple(), kwargs...)
    source = FunctionSpec(f, tt, true, name)
    cache = get!(()->Dict{UInt,Any}(), rocfunction_cache, device)
    agent = device.device
    isa = default_isa(device)
    arch = architecture(isa)
    feat = features(isa)
    target = GCNCompilerTarget(; dev_isa=arch, features=feat)
    params = ROCCompilerParams(device, global_hooks)
    job = CompilerJob(target, source, params)
    GPUCompiler.cached_compilation(cache, job, rocfunction_compile, rocfunction_link)::HostKernel{f,tt}
end

const rocfunction_cache = Dict{RuntimeDevice,Dict{UInt,Any}}()

# compile to GCN
function rocfunction_compile(@nospecialize(job::CompilerJob))
    # compile
    method_instance, mi_meta = GPUCompiler.emit_julia(job)
    JuliaContext() do ctx
        ir, ir_meta = GPUCompiler.emit_llvm(job, method_instance; ctx)
        kernel = ir_meta.entry

        obj, obj_meta = GPUCompiler.emit_asm(job, ir; format=LLVM.API.LLVMObjectFile)

        # find undefined globals and calculate sizes
        globals = map(gbl->Symbol(LLVM.name(gbl))=>llvmsize(eltype(llvmtype(gbl))),
                      filter(x->isextinit(x), collect(LLVM.globals(ir))))
        entry = LLVM.name(kernel)
        dispose(ir)

        return (;obj, entry, globals)
    end
end
function rocfunction_link(@nospecialize(job::CompilerJob), compiled)
    device = job.params.device
    global_hooks = job.params.global_hooks
    obj, entry, globals = compiled.obj, compiled.entry, compiled.globals

    # create executable and kernel
    obj = codeunits(obj)
    exe = create_executable(device, entry, obj; globals=globals)
    mod = ROCModule(exe)
    fun = ROCFunction(mod, entry)
    kernel = HostKernel{job.source.f,job.source.tt}(mod, fun)

    # initialize globals from hooks
    for gname in first.(globals)
        hook = nothing
        if haskey(default_global_hooks, gname)
            hook = default_global_hooks[gname]
        elseif haskey(global_hooks, gname)
            hook = global_hooks[gname]
        end
        if hook !== nothing
            @debug "Initializing global $gname"
            gbl = get_global(exe, gname)
            hook(gbl, mod, device)
        else
            @debug "Uninitialized global $gname"
            continue
        end
    end

    return kernel
end

const default_global_hooks = Dict{Symbol,Function}()

default_global_hooks[:__global_output_context] = (gbl, mod, device) -> begin
    # initialize global output context
    gbl_ptr = Base.unsafe_convert(Ptr{GLOBAL_OUTPUT_CONTEXT_TYPE}, gbl)
    oc = OutputContext(stdout)
    Base.unsafe_store!(gbl_ptr, oc)
end
default_global_hooks[:__global_printf_context] = (gbl, mod, device) -> begin
    # initialize global printf context
    # Return type of Int to force synchronizing behavior
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Int,Tuple{LLVMPtr{UInt8,AS.Global}}}}, gbl)
    hc = HostCall(Int, Tuple{LLVMPtr{UInt8,AS.Global}}; agent=device.device, continuous=true, buf_len=2^16) do _
        fmt, args = unsafe_load(reinterpret(LLVMPtr{ROCPrintfBuffer,AS.Global}, hc.buf_ptr))
        args = map(x->x isa Cstring ? unsafe_string(x) : x, args)
        @debug "@rocprintf with $fmt and $(args)"
        @eval @printf($fmt, $(args...))
        return 0
    end
    Base.unsafe_store!(gbl_ptr, hc)
end
default_global_hooks[:__global_exception_flag] = (gbl, mod, device) -> begin
    # initialize global exception flag
    gbl_ptr = Base.unsafe_convert(Ptr{Int64}, gbl)
    Base.unsafe_store!(gbl_ptr, 0)
end
default_global_hooks[:__global_exception_ring] = (gbl, mod, device) -> begin
    # initialize exception ring buffer
    gbl_ptr = Base.unsafe_convert(Ptr{Ptr{ExceptionEntry}}, gbl)
    ex_ptr = Base.unsafe_convert(Ptr{ExceptionEntry}, mod.exceptions)
    unsafe_store!(gbl_ptr, ex_ptr)
    # setup initial slots
    for i in 1:MAX_EXCEPTIONS-1
        unsafe_store!(ex_ptr, ExceptionEntry(0, LLVMPtr{UInt8,1}(0)))
        ex_ptr += sizeof(ExceptionEntry)
    end
    # setup tail slot
    unsafe_store!(ex_ptr, ExceptionEntry(1, LLVMPtr{UInt8,1}(0)))
end
default_global_hooks[:__global_malloc_hostcall] = (gbl, mod, device) -> begin
    # initialize malloc hostcall
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Ptr{Cvoid},Tuple{UInt64,Csize_t}}}, gbl)
    hc = HostCall(Ptr{Cvoid}, Tuple{UInt64,Csize_t}; agent=device.device, continuous=true) do kern, sz
        buf = Mem.alloc(device.device, sz; coherent=true)
        ptr = buf.ptr
        push!(mod.metadata, KernelMetadata(kern, buf))
        @debug "Allocated $ptr ($sz bytes) for kernel $kern on device $device"
        return ptr
    end
    Base.unsafe_store!(gbl_ptr, hc)
end
default_global_hooks[:__global_free_hostcall] = (gbl, mod, device) -> begin
    # initialize free hostcall
    gbl_ptr = Base.unsafe_convert(Ptr{HostCall{UInt64,Nothing,Tuple{UInt64,Ptr{Cvoid}}}}, gbl)
    hc = HostCall(Nothing, Tuple{UInt64,Ptr{Cvoid}}; agent=device.device, continuous=true) do kern, ptr
        for idx in length(mod.metadata):-1:1
            if mod.metadata[idx].kern == kern && mod.metadata[idx].buf.ptr == ptr
                sz = mod.metadata[idx].buf.bytesize
                Mem.free(mod.metadata[idx].buf)
                deleteat!(mod.metadata, idx)
                @debug "Freed $ptr ($sz bytes) for kernel $kern on device $device"
                break
            end
        end
        return nothing
    end
    Base.unsafe_store!(gbl_ptr, hc)
end

# https://github.com/JuliaLang/julia/issues/14919
(kernel::HostKernel)(args...; kwargs...) = call(kernel, args...; kwargs...)


## device-side kernels

struct DeviceKernel{F,TT} <: AbstractKernel{F,TT}
    fun::Ptr{Cvoid}
end

@doc (@doc AbstractKernel) DeviceKernel

@inline roccall(kernel::DeviceKernel, tt, args...; kwargs...) =
    dynamic_roccall(kernel.fun, tt, args...; kwargs...)

# FIXME: duplication with roccall
@generated function dynamic_roccall(f::Ptr{Cvoid}, tt::Type, args...;
                                     blocks=UInt32(1), threads=UInt32(1), shmem=UInt32(0),
                                     stream=CuDefaultStream())
    types = tt.parameters[1].parameters     # the type of `tt` is Type{Tuple{<:DataType...}}

    ex = quote
        Base.@_inline_meta
    end

    # convert the argument values to match the kernel's signature (specified by the user)
    # (this mimics `lower-ccall` in julia-syntax.scm)
    converted_args = Vector{Symbol}(undef, length(args))
    arg_ptrs = Vector{Symbol}(undef, length(args))
    for i in 1:length(args)
        converted_args[i] = gensym()
        arg_ptrs[i] = gensym()
        push!(ex.args, :($(converted_args[i]) = Base.cconvert($(types[i]), args[$i])))
        push!(ex.args, :($(arg_ptrs[i]) = Base.unsafe_convert($(types[i]), $(converted_args[i]))))
    end

    append!(ex.args, (quote
        #GC.@preserve $(converted_args...) begin
            launch(f, blocks, threads, shmem, stream, $(arg_ptrs...))
        #end
    end).args)

    return ex
end


## device-side API

"""
    dynamic_rocfunction(f, tt=Tuple{})

Low-level interface to compile a function invocation for the currently-active GPU, returning
a callable kernel object. Device-side equivalent of [`AMDGPU.rocfunction`](@ref).

No keyword arguments are supported.
"""
@inline function dynamic_rocfunction(f::Core.Function, tt::Type=Tuple{})
    fptr = GPUCompiler.deferred_codegen(Val(f), Val(tt))
    DeviceKernel{f,tt}(fptr)
end

# https://github.com/JuliaLang/julia/issues/14919
(kernel::DeviceKernel)(args...; kwargs...) = call(kernel, args...; kwargs...)
