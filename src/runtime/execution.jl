## Abstract kernels for host-side and device-side launch

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
    sig = Tuple{F, TT.parameters...} # Base.signature_type with a function type
    args = (:(kernel.f), (:( args[$i] ) for i in 1:length(args))...)

    # filter out ghost arguments that shouldn't be passed
    predicate = dt -> GPUCompiler.isghosttype(dt) || Core.Compiler.isconstType(dt)
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

    # add the kernel state
    pushfirst!(call_t, AMDGPU.KernelState)
    pushfirst!(call_args, :(kernel.state))

    # finalize types
    call_tt = Base.to_tuple_type(call_t)

    quote
        Base.@_inline_meta

        roccall(kernel, $call_tt, $(call_args...); call_kwargs...)
    end
end


## host-side kernels

struct HostKernel{F,TT} <: AbstractKernel{F,TT}
    f::F
    mod::ROCModule
    fun::ROCFunction
    state::AMDGPU.KernelState
end

@doc (@doc AbstractKernel) HostKernel

@inline function roccall(kernel::HostKernel, tt, args...; signal::ROCKernelSignal, groupsize=1, kwargs...)
    if groupsize == :auto
        config = AMDGPU.launch_configuration(kernel; dynamic_localmem=localmem)
        roccall(signal, tt, args...; config..., kwargs...)
    else
        roccall(signal, tt, args...; kwargs..., groupsize)
    end
end


## host-side API


# https://github.com/JuliaLang/julia/issues/14919
(kernel::HostKernel)(args...; kwargs...) = call(kernel, args...; kwargs...)

export roccall

"""
    roccall(signal::ROCKernelSignal, types, values...; groupsize::ROCDim, gridsize::ROCDim)

`ccall`-like interface for launching a ROC function `f` on a GPU.

For example:

    vadd = ROCFunction(md, "vadd")
    a = rand(Float32, 10)
    b = rand(Float32, 10)
    ad = Mem.upload(a)
    bd = Mem.upload(b)
    c = zeros(Float32, 10)
    cd = Mem.alloc(c)

    roccall(vadd, (Ptr{Cfloat},Ptr{Cfloat},Ptr{Cfloat}), ad, bd, cd;
             gridsize=10)
    Mem.download!(c, cd)

The `groupsize` and `gridsize` arguments control the launch configuration, and should both
consist of either an integer, or a tuple of 1 to 3 integers (omitted dimensions default to
1). The `types` argument can contain both a tuple of types, and a tuple type, the latter
being slightly faster.
"""
roccall

# we need a generated function to get a tuple of converted arguments (using unsafe_convert),
# without having to inspect the types at runtime
@generated function roccall(
    signal::ROCKernelSignal, tt::Type, args::Vararg{Any,N};
    groupsize::ROCDim=1, gridsize::ROCDim=groupsize,
) where N

    # the type of `tt` is Type{Tuple{<:DataType...}}
    types = tt.parameters[1].parameters

    ex = Expr(:block)
    push!(ex.args, :(Base.@_inline_meta))

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
            launch_kernel!(signal, groupsize, gridsize, ($(arg_ptrs...),))
        #end
    end).args)

    return ex
end

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
                                     queue=default_queue())
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
