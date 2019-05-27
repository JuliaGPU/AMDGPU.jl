export @roc, rocconvert, rocfunction

struct Kernel{F,TT}
    agent::HSAAgent
    mod::ROCModule
    fun::ROCFunction
end

# split keyword arguments to `@roc` into ones affecting the compiler,
# the execution, or both
function split_kwargs(kwargs)
    compiler_kws = [:agent, :queue]
    call_kws     = [:groupsize, :gridsize, :agent, :queue]
    compiler_kwargs = []
    call_kwargs = []
    for kwarg in kwargs
        if Meta.isexpr(kwarg, :(=))
            key,val = kwarg.args
            if isa(key, Symbol)
                if !(key in compiler_kws) && !(key in call_kws)
                    throw(ArgumentError("unknown keyword argument '$key'"))
                end
                if key in compiler_kws
                    push!(compiler_kwargs, kwarg)
                end
                if key in call_kws
                    push!(call_kwargs, kwarg)
                end
            else
                throw(ArgumentError("non-symbolic keyword '$key'"))
            end
        else
            throw(ArgumentError("non-keyword argument like option '$kwarg'"))
        end
    end

    return compiler_kwargs, call_kwargs
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
        push!(code.args, :($var = $(esc(arg))))
    end

    # convert the arguments, compile the function and call the kernel
    # while keeping the original arguments alive
    var_exprs = map(vars, args, splats) do var, arg, splat
         splat ? Expr(:(...), var) : var
    end

    return vars, var_exprs
end

# fast lookup of global world age
world_age() = ccall(:jl_get_tls_world_age, UInt, ())

# slow lookup of local method age
function method_age(f, tt)::UInt
    for m in Base._methods(f, tt, 1, typemax(UInt))
        @static if VERSION >= v"1.2.0-DEV.573"
            return m[3].primary_world
        else
            return m[3].min_world
        end
    end
    throw(MethodError(f, tt))
end

macro roc(ex...)
    @assert length(ex) >= 1 "Not enough arguments provided"
    call = last(ex)
    kwargs = ex[1:end-1]
    @assert call.head == :call "Invalid kernel specification"
    f = call.args[1]
    args = call.args[2:end]
    code = quote end
    compiler_kwargs, call_kwargs = split_kwargs(kwargs)
    vars, var_exprs = assign_args!(code, args)
    push!(code.args,
        quote
            GC.@preserve $(vars...) begin
                local kernel_args = rocconvert.(($(var_exprs...),))
                local kernel_tt = Tuple{Core.Typeof.(kernel_args)...}
                local agent = get_default_agent()
                local kernel = rocfunction(agent, $(esc(f)), kernel_tt;
                                           $(map(esc, compiler_kwargs)...))
                local queue = get_default_queue(agent)
                local signal = HSASignal()
                kernel(queue, signal, kernel_args...; $(map(esc, call_kwargs)...))
                wait(signal)
            end
        end)
    return code
end

## adaptors

struct Adaptor end

# Base.RefValue isn't GPU compatible, so provide a compatible alternative
mutable struct ROCRefValue{T} <: Ref{T}
    x::T
end
Base.getindex(r::ROCRefValue) = r.x
Base.setindex!(r::ROCRefValue{T}, value::T) where T = (r.x = value;)
Adapt.adapt_structure(to::Adaptor, r::Base.RefValue) = ROCRefValue(adapt(to, r[]))

## interop with HSAArray

function Base.convert(::Type{ROCDeviceArray{T,N,AS.Global}}, a::HSAArray{T,N}) where {T,N}
    ROCDeviceArray{T,N,AS.Global}(a.size, DevicePtr{T,AS.Global}(a.handle))
end

Adapt.adapt_storage(::Adaptor, xs::HSAArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, xs)

# convenience function
"""
    rocconvert(x)

This function is called for every argument to be passed to a kernel, allowing
it to be converted to a GPU-friendly format. By default, the function does
nothing and returns the input object `x` as-is.

Do not add methods to this function, but instead extend the underlying
Adapt.jl package and register methods for the the `AMDGPUnative.Adaptor` type.
"""
rocconvert(arg) = adapt(Adaptor(), arg)

## APIs for manual compilation

const agecache = Dict{UInt, UInt}()
const compilecache = Dict{UInt, Kernel}()

"""
    rocfunction(f, tt=Tuple{}; kwargs...)

Low-level interface to compile a function invocation for the currently-active
GPU, returning a callable kernel object. For a higher-level interface, use
[`@roc`](@ref).

Currently, no keyword arguments are implemented.

The output of this function is automatically cached, i.e. you can simply call
`rocfunction` in a hot path without degrading performance. New code will be
generated automatically, when the function changes, or when different types or
keyword arguments are provided.
"""
@generated function rocfunction(agent::HSAAgent, f::Core.Function, tt::Type=Tuple{}; kwargs...)
    tt = Base.to_tuple_type(tt.parameters[1])
    sig = Base.signature_type(f, tt)
    t = Tuple(tt.parameters)

    precomp_key = hash(sig)  # precomputable part of the keys
    quote
        Base.@_inline_meta

        # look-up the method age
        key = hash(world_age(), $precomp_key)
        if haskey(agecache, key)
            age = agecache[key]
        else
            age = method_age(f, $t)
            agecache[key] = age
        end
        key = hash(age, key)

        # compile the function
        key = hash(kwargs, key)
        for nf in 1:nfields(f)
            # mix in the values of any captured variable
            key = hash(getfield(f, nf), key)
        end
        if !haskey(compilecache, key)
            mod, fun = compile(agent, f, tt; kwargs...)
            kernel = Kernel{f,tt}(agent, mod, fun)
            compilecache[key] = kernel
        end

        return compilecache[key]::Kernel{f,tt}
    end
end
rocfunction(f::Core.Function, tt::Type=Tuple{}; kwargs...) =
    rocfunction(get_default_agent(), f, tt; kwargs...)

@generated function (kernel::Kernel{F,TT})(queue::HSAQueue, signal::HSASignal, args...; call_kwargs...) where {F,TT}
    sig = Base.signature_type(F, TT)
    args = (:F, (:( args[$i] ) for i in 1:length(args))...)

    # filter out ghost arguments that shouldn't be passed
    to_pass = map(!isghosttype, sig.parameters)
    call_t =                  Type[x[1] for x in zip(sig.parameters,  to_pass) if x[2]]
    call_args = Union{Expr,Symbol}[x[1] for x in zip(args, to_pass)            if x[2]]

    # replace non-isbits arguments (they should be unused, or compilation would have failed)
    # alternatively, make HSARuntime allow `launch` with non-isbits arguments.
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

        roccall(queue, signal, kernel.fun, $call_tt, $(call_args...); call_kwargs...)
    end
end

# There doesn't seem to be a way to access the documentation for the
# call-syntax, so attach it to the type
"""
    (::Kernel)(args...; kwargs...)

Low-level interface to call a compiled kernel, passing GPU-compatible
arguments in `args`.  For a higher-level interface, use [`@roc`](@ref).

The following keyword arguments are supported:
- groupsize (defaults to 1)
- gridsize (defaults to 1)
"""
Kernel
