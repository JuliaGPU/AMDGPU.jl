# `map(f, t)`, without `Base.Any32`'s limit, see `launch_tuple(::HIPFunction, ...)`
@inline @generated _tmap(f, t::Tuple) = :(($((:(f(t[$i])) for i in 1:fieldcount(t))...),))

# `Tuple{map(Core.Typeof, args)...}`, without mapping or splatting
@inline @generated function argument_types(args::Tuple)
    :(Tuple{$((:(Core.Typeof(args[$i])) for i in 1:fieldcount(args))...)})
end

# In contrast to `Base.RefValue` we just need a container for both pass-by-ref (Symbol),
# and pass-by-value (immutable structs).
mutable struct ArgBox{T}
    const val::T
end

@inline function Base.unsafe_convert(P::Union{Type{Ptr{T}}, Type{Ptr{Cvoid}}}, box::ArgBox{T})::P where {T}
    return pointer_from_objref(box)
end

"""
    (ker::HIPKernel)(args::Vararg{Any, N}; kwargs...)

Launch compiled HIPKernel by passing arguments to it.

The following kwargs are supported:
- `gridsize::ROCDim = 1`: Size of the grid.
- `groupsize::ROCDim = 1`:  Size of the workgroup.
- `shmem::Integer = 0`: Amount of dynamically-allocated shared memory in bytes.
- `stream::HIP.HIPStream = AMDGPU.stream()`: Stream on which to launch the kernel.
"""
struct HIPKernel{F, TT} <: AbstractKernel{F, TT}
    f::F
    fun::HIP.HIPFunction
end

@inline @generated function call(
    kernel::HIPKernel{F, TT}, args::Tuple;
    stream::HIP.HIPStream, call_kwargs...,
) where {F, TT}
    sig = Tuple{F, TT.parameters...} # Base.signature_type with a function type
    args = (:(kernel.f), (:( args[$i] ) for i in 1:length(args.parameters))...)

    # filter out ghost arguments that shouldn't be passed.
    predicate = dt -> GPUCompiler.isghosttype(dt) || Core.Compiler.isconstType(dt)
    # Note: Define a single LLVM context, otherwise it is created per every param.
    to_pass = LLVM.Context() do _
        map(!predicate, sig.parameters)
    end
    call_t = Type[x[1] for x in zip(sig.parameters, to_pass) if x[2]]
    call_args = Union{Expr,Symbol}[x[1] for x in zip(args, to_pass) if x[2]]

    # add the kernel state
    pushfirst!(call_t, AMDGPU.KernelState)
    pushfirst!(call_args, :(AMDGPU.KernelState(stream.device, kernel.fun.global_hostcalls)))

    # finalize types
    call_tt = Base.to_tuple_type(call_t)
    quote
        roccall_tuple(kernel.fun, $call_tt, ($(call_args...),); stream, call_kwargs...)
    end
end

# forwards the arguments as a tuple, see `launch_tuple(::HIPFunction, ...)`
(ker::HIPKernel)(args::Vararg{Any, N}) where N = launch_tuple(ker, args)
Core.kwcall(kwargs::NamedTuple, ker::HIPKernel, args::Vararg{Any, N}) where N =
    launch_tuple(ker, args; kwargs...)

function launch_tuple(
    ker::HIPKernel, args::Tuple; stream::HIP.HIPStream = AMDGPU.stream(), call_kwargs...,
)
    # Check if previous kernels threw an exception.
    AMDGPU.throw_if_exception(stream.device)
    GC.@preserve args begin
        converted = _tmap(arg -> AMDGPU.rocconvert(arg, stream), args)
        call(ker, converted; stream, call_kwargs...)
    end
end

@inline @generated function convert_arguments(f::Function, ::Type{tt}, args::Tuple) where tt
    types = tt.parameters
    n = fieldcount(args)

    ex = quote end

    converted_args = Vector{Symbol}(undef, n)
    arg_ptrs = Vector{Symbol}(undef, n)
    for i in 1:n
        converted_args[i] = gensym()
        arg_ptrs[i] = gensym()
        push!(ex.args, :($(converted_args[i]) = Base.cconvert($(types[i]), args[$i])))
        push!(ex.args, :($(arg_ptrs[i]) = Base.unsafe_convert($(types[i]), $(converted_args[i]))))
    end

    append!(ex.args, (quote
        GC.@preserve $(converted_args...) begin
            f(($(arg_ptrs...),))
        end
    end).args)
    return ex
end

# forwards the arguments as a tuple, see `launch_tuple(::HIPFunction, ...)`
roccall(fun::F, tt::Type{T}, args::Vararg{Any, N}) where {F, T, N} = roccall_tuple(fun, tt, args)
Core.kwcall(kwargs::NamedTuple, ::typeof(roccall), fun::F, tt::Type{T},
    args::Vararg{Any, N}) where {F, T, N} = roccall_tuple(fun, tt, args; kwargs...)

function roccall_tuple(fun::F, tt::Type{T}, args::Tuple; kwargs...) where {F, T}
    convert_arguments(tt, args) do pointers
        launch_tuple(fun, pointers; kwargs...)
    end
end

# pack arguments in a buffer that HIP expects
@inline @generated function pack_arguments(f::F, args::Tuple) where {F}
    n = fieldcount(args)
    quote
        boxes = ($((:(ArgBox(args[$i])) for i in 1:n)...),)
        GC.@preserve args boxes begin
            pointers = ($((:(Base.unsafe_convert(Ptr{Cvoid}, boxes[$i])) for i in 1:n)...),)
            f(Ref(pointers))
        end
    end
end

launch(fun::HIP.HIPFunction, args::Vararg{Any, N}) where N = launch_tuple(fun, args)
Core.kwcall(kwargs::NamedTuple, ::typeof(launch), fun::HIP.HIPFunction, args::Vararg{Any, N}) where N =
    launch_tuple(fun, args; kwargs...)

function launch_tuple(
    fun::HIP.HIPFunction, args::Tuple;
    gridsize = 1, groupsize = 1,
    shmem::Integer = 0, stream::HIP.HIPStream,
    cooperative = false,
)
    gd = gridsize isa ROCDim3 ? gridsize : ROCDim3(gridsize)
    bd = groupsize isa ROCDim3 ? groupsize : ROCDim3(groupsize)
    # the device side assumes workgroup indices fit in Int32 (see Device._max_groups)
    (gd.x <= typemax(Int32) && gd.y <= typemax(Int32) && gd.z <= typemax(Int32)) ||
        throw(ArgumentError("gridsize exceeds $(typemax(Int32)) workgroups in a dimension"))
    # TODO guard with try/catch & diagnose a failure
    pack_arguments(args) do kernel_params
        # Inline into `pack_arguments`, so that `kernel_params` does not escape into a
        # call and can be promoted to an `alloca` instead of being heap-allocated.
        @inline
        if cooperative
            HIP.hipModuleLaunchCooperativeKernel(
                fun, gd.x, gd.y, gd.z, bd.x, bd.y, bd.z,
                shmem, stream, kernel_params)
        else
            HIP.hipModuleLaunchKernel(
                fun, gd.x, gd.y, gd.z, bd.x, bd.y, bd.z,
                shmem, stream, kernel_params, C_NULL)
        end
    end

    AMDGPU.LAUNCH_BLOCKING[] && AMDGPU.synchronize(stream)
    return
end
