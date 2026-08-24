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
    kernel::HIPKernel{F, TT}, args...;
    stream::HIP.HIPStream, call_kwargs...,
) where {F, TT}
    sig = Tuple{F, TT.parameters...} # Base.signature_type with a function type
    args = (:(kernel.f), (:( args[$i] ) for i in 1:length(args))...)

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
        roccall(kernel.fun, $call_tt, $(call_args...); stream, call_kwargs...)
    end
end

function (ker::HIPKernel{F, TT})(
    args::Vararg{Any, N}; stream::HIP.HIPStream = AMDGPU.stream(), call_kwargs...,
) where {F, TT, N}
    # Check if previous kernels threw an exception.
    AMDGPU.throw_if_exception(stream.device)
    GC.@preserve args begin
        # ownership transfer happens inline during conversion
        converted = map(arg -> AMDGPU.rocconvert(arg, stream), args)
        call(ker, converted...; stream, call_kwargs...)
    end
end

@inline @generated function convert_arguments(f::Function, ::Type{tt}, args...) where tt
    types = tt.parameters

    ex = quote end

    converted_args = Vector{Symbol}(undef, length(args))
    arg_ptrs = Vector{Symbol}(undef, length(args))
    for i in 1:length(args)
        converted_args[i] = gensym()
        arg_ptrs[i] = gensym()
        push!(ex.args, :($(converted_args[i]) = Base.cconvert($(types[i]), args[$i])))
        push!(ex.args, :($(arg_ptrs[i]) = Base.unsafe_convert($(types[i]), $(converted_args[i]))))
    end

    append!(ex.args, (quote
        GC.@preserve $(converted_args...) begin
            f($(arg_ptrs...))
        end
    end).args)
    return ex
end

function roccall(fun::F, tt::Type{T}, args::Vararg{Any, N}; kwargs...) where {F, T, N}
    cvt_fn = ((pointers::Vararg{Any, N},) where N) -> launch(fun, pointers...; kwargs...)
    convert_arguments(cvt_fn, tt, args...)
end

@inline function pack_arguments(f::F, args...) where F
    boxes = map(ArgBox, args)
    GC.@preserve args boxes begin
        pointers = map(box -> Base.unsafe_convert(Ptr{Cvoid}, box), boxes)
        f(Ref(pointers))
    end
end

function launch(
    fun::HIP.HIPFunction, args::Vararg{Any, N};
    gridsize = 1, groupsize = 1,
    shmem::Integer = 0, stream::HIP.HIPStream,
    cooperative = false,
) where N
    gd = gridsize isa ROCDim3 ? gridsize : ROCDim3(gridsize)
    bd = groupsize isa ROCDim3 ? groupsize : ROCDim3(groupsize)
    # TODO guard with try/catch & diagnose a failure
    pack_arguments(args...) do kernel_params
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
