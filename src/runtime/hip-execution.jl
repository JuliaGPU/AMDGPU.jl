struct HIPKernel{F, TT} <: AbstractKernel{F, TT}
    f::F
    fun::HIP.HIPFunction
    state::AMDGPU.KernelState
end

@inline @generated function call(kernel::HIPKernel{F, TT}, args...; call_kwargs...) where {F, TT}
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
        roccall(kernel.fun, $call_tt, $(call_args...); call_kwargs...)
    end
end

function (ker::HIPKernel)(args...; call_kwargs...)
    call(ker, map(AMDGPU.rocconvert, args)...; call_kwargs...)
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

function roccall(fun::HIP.HIPFunction, tt::Type, args...; kwargs...)
    convert_arguments(tt, args...) do pointers...
        launch(fun, pointers...; kwargs...)
    end
end

@inline @generated function pack_arguments(f::Function, args...)
    for arg in args
        isbitstype(arg) || throw(ArgumentError(
            "Arguments to kernel should be bitstype, instead `$(arg)` was given."))
    end

    ex = quote end

    arg_refs = Vector{Symbol}(undef, length(args))
    for i in 1:length(args)
        arg_refs[i] = gensym()
        push!(ex.args, :($(arg_refs[i]) = Base.RefValue(args[$i])))
    end

    arg_ptrs = [
        :(Base.unsafe_convert(Ptr{Cvoid}, $(arg_refs[i])))
        for i in 1:length(args)]

    append!(ex.args, (quote
        GC.@preserve $(arg_refs...) begin
            kernel_params = [$(arg_ptrs...)]
            f(kernel_params)
        end
    end).args)
    return ex
end

function launch(
    fun::HIP.HIPFunction, args::Vararg{Any, N};
    grid_dim::ROCDim = 1, block_dim::ROCDim = 1,
    shmem::Integer = 0, stream::HIP.HIPStream,
) where N
    gd, bd = ROCDim3(grid_dim), ROCDim3(block_dim)
    pack_arguments(args...) do kernel_params
        HIP.hipModuleLaunchKernel(
            fun, gd.x, gd.y, gd.z, bd.x, bd.y, bd.z,
            shmem, stream, kernel_params, C_NULL) |> HIP.check
    end
end
