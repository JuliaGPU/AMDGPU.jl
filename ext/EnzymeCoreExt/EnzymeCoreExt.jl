module EnzymeCoreExt

using AMDGPU
using EnzymeCore
using EnzymeCore: EnzymeRules
using GPUCompiler

function EnzymeCore.compiler_job_from_backend(
    ::ROCBackend, @nospecialize(F::Type), @nospecialize(TT::Type),
)
    mi = GPUCompiler.methodinstance(F, TT)
    return GPUCompiler.CompilerJob(mi, AMDGPU.compiler_config(AMDGPU.device()))
end

function EnzymeRules.forward(
    fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: Duplicated},
    f::Const{F}, tt::Const{TT}; kwargs...
) where {F, TT}
    res = fn.val(f.val, tt.val; kwargs...)
    return Duplicated(res, res)
end

function EnzymeRules.forward(
    fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: BatchDuplicated{T, N}},
    f::Const{F}, tt::Const{TT}; kwargs...
) where {F, TT, T, N}
    res = fn.val(f.val, tt.val; kwargs...)
    return BatchDuplicated(res, ntuple(_ -> res, Val(N)))
end

function EnzymeRules.reverse(
    config, fn::Const{typeof(AMDGPU.hipfunction)},
    ::Type{RT}, subtape, f, tt; kwargs...,
) where RT
    return (nothing, nothing)
end

function EnzymeRules.forward(
    fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    if RT <: Duplicated
        Duplicated(fn.val(x.val), fn.val(x.dval))
    elseif RT <: Const
        fn.val(x.val)::eltype(RT)
    elseif RT <: DuplicatedNoNeed
        fn.val(x.val)::eltype(RT)
    else
        tup = ntuple(Val(EnzymeCore.batch_size(RT))) do i
            Base.@_inline_meta
            fn.val(x.dval[i])::eltype(RT)
        end
        if RT <: BatchDuplicated
            BatchDuplicated(ofv.val(x.val), tup)
        else
            tup
        end
    end
end

function EnzymeRules.reverse(
    config, fn::Const{typeof(AMDGPU.rocconvert)},
    ::Type{RT}, tape, x::IT,
) where {RT, IT}
    return (nothing,)
end

function meta_fn(fn, args::Vararg{Any, N}) where N
    EnzymeCore.autodiff_deferred(Forward, fn, Const, args...)
    return
end

function EnzymeRules.forward(
    fn::EnzymeCore.Annotation{AMDGPU.Runtime.HIPKernel{F, TT}},
    ::Type{Const{Nothing}}, args...; kwargs...,
) where {F, TT}
    GC.@preserve args begin
        kernel_args = ((rocconvert(a) for a in args)...,)
        kernel_tt = Tuple{(F, (typeof(a) for a in kernel_args)...)...}
        kernel = AMDGPU.hipfunction(meta_fn, kernel_tt)
        kernel(fn.val.f, args...; kwargs...)
    end
    return
end

function EnzymeRules.augmented_primal(
    config, fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    primal = EnzymeRules.needs_primal(config) ?
        fn.val(x.val) : nothing
    primal_T = EnzymeRules.needs_primal(config) ? eltype(RT) : Nothing

    shadow = if EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            fn.val(x.dval)
        else
            ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                fn.val(x.dval[i])
            end
        end
    else
        nothing
    end
    shadow_T = EnzymeRules.needs_shadow(config) ?
        (EnzymeRules.width(config) == 1 ?
            eltype(RT) : NTuple{EnzymeRules.width(config), eltype(RT)}) :
        Nothing

    return EnzymeRules.AugmentedReturn{primal_T, shadow_T, Nothing}(
        primal, shadow, nothing)
end

function EnzymeRules.augmented_primal(
    config, fn::Const{typeof(AMDGPU.hipfunction)},
    ::Type{RT}, f::Const{F},
    tt::Const{TT}; kwargs...
) where {F, CT, RT <: EnzymeCore.Annotation{CT}, TT}
    res = fn.val(f.val, tt.val; kwargs...)

    primal = EnzymeRules.needs_primal(config) ? res : nothing
    primal_T = EnzymeRules.needs_primal(config) ? CT : Nothing

    shadow = if EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            res
        else
          ntuple(Val(EnzymeRules.width(config))) do i
              Base.@_inline_meta
              res
          end
        end
    else
        nothing
    end
    shadow_T = EnzymeRules.needs_shadow(config) ?
        (EnzymeRules.width(config) == 1 ?
            CT : NTuple{EnzymeRules.width(config), CT}) :
        Nothing

    return EnzymeRules.AugmentedReturn{primal_T, shadow_T, Nothing}(
        primal, shadow, nothing)
end

function meta_augf(
    f, tape::ROCDeviceArray{TapeType}, ::Val{ModifiedBetween}, args::Vararg{Any, N},
) where {N, ModifiedBetween, TapeType}
    forward, _ = EnzymeCore.autodiff_deferred_thunk(
        ReverseSplitModified(ReverseSplitWithPrimal, Val(ModifiedBetween)),
        TapeType,
        Const{Core.Typeof(f)},
        Const{Nothing},
        map(typeof, args)...,
    )

    idx = 0
    # idx *= gridDim().x
    idx += workgroupIdx().x - 1

    idx *= gridGroupDim().y
    idx += workgroupIdx().y - 1

    idx *= gridGroupDim().z
    idx += workgroupIdx().z - 1

    idx *= workgroupDim().x
    idx += workitemIdx().x - 1

    idx *= workgroupDim().y
    idx += workitemIdx().y - 1

    idx *= workgroupDim().z
    idx += workitemIdx().z - 1
    idx += 1

    @inbounds tape[idx] = forward(Const(f), args...)[1]
    return
end

function EnzymeRules.augmented_primal(
    config, fn::EnzymeCore.Annotation{AMDGPU.Runtime.HIPKernel{F,TT}},
    ::Type{Const{Nothing}}, args...;
    groupsize::AMDGPU.Runtime.ROCDim = 1,
    gridsize::AMDGPU.Runtime.ROCDim = 1, kwargs...,
) where {F,TT}
    kernel_args = ((rocconvert(a) for a in args)...,)
    kernel_tt = map(typeof, kernel_args)

    ModifiedBetween = overwritten(config)
    compiler_job = EnzymeCore.compiler_job_from_backend(
        ROCBackend(), typeof(Base.identity), Tuple{Float64})
    TapeType = EnzymeCore.tape_type(
        compiler_job,
        ReverseSplitModified(ReverseSplitWithPrimal, Val(ModifiedBetween)),
        Const{F}, Const{Nothing},
        kernel_tt...,
    )
    threads = AMDGPU.Runtime.ROCDim3(groupsize)
    blocks = AMDGPU.Runtime.ROCDim3(gridsize)
    subtape = ROCArray{TapeType}(
        undef, blocks.x * blocks.y * blocks.z * threads.x * threads.y * threads.z)

    GC.@preserve args subtape begin
        subtape_cc = rocconvert(subtape)
        kernel_tt2 = Tuple{(
            F, typeof(subtape_cc), Val{ModifiedBetween}, kernel_tt...,
        )...}
        kernel = AMDGPU.hipfunction(meta_augf, kernel_tt2)
        kernel(fn.val.f, subtape_cc, Val(ModifiedBetween), args...;
            groupsize=(groupsize.x, groupsize.y, groupsize.z),
            gridsize=(gridsize.x, gridsize.y, gridsize.z),
            kwargs...)
    end
    return AugmentedReturn{Nothing, Nothing, ROCArray}(nothing, nothing, subtape)
end

end
