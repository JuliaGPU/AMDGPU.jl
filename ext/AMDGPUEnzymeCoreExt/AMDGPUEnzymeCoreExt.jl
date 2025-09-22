module AMDGPUEnzymeCoreExt

using AMDGPU
using EnzymeCore
using EnzymeCore: EnzymeRules
using GPUCompiler

include("meta_kernels.jl")

function EnzymeCore.compiler_job_from_backend(
    ::ROCBackend, @nospecialize(F::Type), @nospecialize(TT::Type),
)
    mi = GPUCompiler.methodinstance(F, TT)
    return GPUCompiler.CompilerJob(mi, AMDGPU.compiler_config(AMDGPU.device()))
end

function EnzymeRules.forward(
    config, fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: Const},
    f::Const{F}, tt::Const{TT}; kwargs...,
) where {F, TT}
    res = fn.val(f.val, tt.val; kwargs...)
    return res
end

function EnzymeRules.forward(
    config, fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: Duplicated},
    f::Const{F}, tt::Const{TT}; kwargs...,
) where {F, TT}
    res = fn.val(f.val, tt.val; kwargs...)
    return Duplicated(res, res)
end

function EnzymeRules.forward(
    config, fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: BatchDuplicated{T, N}},
    f::Const{F}, tt::Const{TT}; kwargs...,
) where {F, TT, T, N}
    res = fn.val(f.val, tt.val; kwargs...)
    return BatchDuplicated(res, ntuple(_ -> res, Val(N)))
end

function EnzymeRules.reverse(
    config, fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{RT},
    subtape, f, tt; kwargs...,
) where RT
    return (nothing, nothing)
end

function EnzymeRules.forward(
    config, fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    if EnzymeRules.needs_primal(config) && EnzymeRules.needs_shadow(config)
        config_width = EnzymeRules.width(config)
        if config_width == 1
            Duplicated(fn.val(x.val), fn.val(x.dval))
        else
            tup = ntuple(Val(config_width)) do i
                Base.@_inline_meta
                fn.val(x.dval[i])::eltype(RT)
            end
            BatchDuplicated(fn.val(x.val), tup)
        end

    elseif EnzymeRules.needs_shadow(config)
        config_width = EnzymeRules.width(config)
        ST = EnzymeCore.shadow_type(config, RT)
        if config_width == 1
            fn.val(x.dval)::ST
        else
            (ntuple(Val(config_width)) do i
                Base.@_inline_meta
                fn.val(x.dval[i])::eltype(RT)
            end)::ST
        end

    elseif EnzymeRules.needs_primal(config)
        fn.val(x.val)::eltype(RT)
    else
        nothing
    end
end

function EnzymeRules.augmented_primal(
    config, fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    primal = EnzymeRules.needs_primal(config) ?
        fn.val(x.val) : nothing

    shadow = if EnzymeRules.needs_shadow(config)
        config_width = EnzymeRules.width(config)
        if config_width == 1
            fn.val(x.dval)
        else
            ntuple(Val(config_width)) do i
                Base.@_inline_meta
                fn.val(x.dval[i])
            end
        end
    else
        nothing
    end

    return EnzymeRules.AugmentedReturn{
        EnzymeRules.primal_type(config, RT),
        EnzymeRules.shadow_type(config, RT), Nothing
    }(primal, shadow, nothing)
end

function EnzymeRules.reverse(
    config, fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, tape, x::IT,
) where {RT, IT}
    return (nothing,)
end

function EnzymeRules.forward(
    config, fn::EnzymeCore.Annotation{AMDGPU.Runtime.HIPKernel{F, TT}},
    ::Type{Const{Nothing}}, args...; kwargs...,
) where {F, TT}
    GC.@preserve args begin
        kernel_args = ((rocconvert(a) for a in args)...,)
        kernel_tt = Tuple{(typeof(config), F, (typeof(a) for a in kernel_args)...)...}
        kernel = AMDGPU.hipfunction(meta_fn, kernel_tt)
        kernel(config, fn.val.f, kernel_args...; kwargs...)
    end
    return
end

function EnzymeRules.reverse(
    config, ofn::EnzymeCore.Annotation{AMDGPU.Runtime.HIPKernel{F, TT}},
    ::Type{Const{Nothing}}, subtape, args...;
    groupsize::AMDGPU.Runtime.ROCDim = 1,
    gridsize::AMDGPU.Runtime.ROCDim = 1,
    kwargs...,
) where {F, TT}
    kernel_args = ((rocconvert(a) for a in args)...,)
    kernel_tt = map(typeof, kernel_args)

    ModifiedBetween = EnzymeRules.overwritten(config)
    TapeType = EnzymeCore.tape_type(
        ReverseSplitModified(
            EnzymeCore.set_runtime_activity(ReverseSplitWithPrimal, config),
            Val(ModifiedBetween)),
        Const{F},
        Const{Nothing},
        kernel_tt...,
    )
    groupsize = AMDGPU.Runtime.ROCDim3(groupsize)
    gridsize = AMDGPU.Runtime.ROCDim3(gridsize)

    GC.@preserve args subtape begin
        subtape_cc = rocconvert(subtape)
        kernel_tt2 = Tuple{
            (typeof(config), F, typeof(subtape_cc), kernel_tt...)...}
        kernel = AMDGPU.hipfunction(meta_revf, kernel_tt2)
        kernel(config, ofn.val.f, subtape_cc, kernel_args...;
            groupsize, gridsize, kwargs...)
    end

    return ntuple(Val(length(kernel_args))) do i
        Base.@_inline_meta
        nothing
    end
end

function EnzymeRules.augmented_primal(
    config, fn::Const{typeof(AMDGPU.hipfunction)},
    ::Type{RT}, f::Const{F}, tt::Const{TT}; kwargs...
) where {F, CT, RT <: EnzymeCore.Annotation{CT}, TT}
    res = fn.val(f.val, tt.val; kwargs...)
    primal = EnzymeRules.needs_primal(config) ? res : nothing

    shadow = if EnzymeRules.needs_shadow(config)
        config_width = EnzymeRules.width(config)
        config_width == 1 ?
            res :
            ntuple(Val(config_width)) do i
                Base.@_inline_meta
                res
            end
    else
        nothing
    end

    return EnzymeRules.AugmentedReturn{
        EnzymeRules.primal_type(config, RT),
        EnzymeRules.shadow_type(config, RT), Nothing,
    }(primal, shadow, nothing)
end

function EnzymeRules.augmented_primal(
    config, fn::EnzymeCore.Annotation{AMDGPU.Runtime.HIPKernel{F,TT}},
    ::Type{Const{Nothing}}, args...;
    groupsize::AMDGPU.Runtime.ROCDim = 1,
    gridsize::AMDGPU.Runtime.ROCDim = 1, kwargs...,
) where {F,TT}
    kernel_args = ((rocconvert(a) for a in args)...,)
    kernel_tt = map(typeof, kernel_args)

    ModifiedBetween = EnzymeRules.overwritten(config)
    compiler_job = EnzymeCore.compiler_job_from_backend(
        ROCBackend(), typeof(Base.identity), Tuple{Float64})
    TapeType = EnzymeCore.tape_type(
        compiler_job,
        ReverseSplitModified(
            EnzymeCore.set_runtime_activity(ReverseSplitWithPrimal, config),
            Val(ModifiedBetween)),
        Const{F}, Const{Nothing},
        kernel_tt...,
    )
    groupsize = AMDGPU.Runtime.ROCDim3(groupsize)
    gridsize = AMDGPU.Runtime.ROCDim3(gridsize)
    subtape = ROCArray{TapeType}(undef,
        gridsize.x * gridsize.y * gridsize.z *
        groupsize.x * groupsize.y * groupsize.z)

    GC.@preserve args subtape begin
        subtape_cc = rocconvert(subtape)
        kernel_tt2 = Tuple{
            (typeof(config), F, typeof(subtape_cc), kernel_tt...)...}
        kernel = AMDGPU.hipfunction(meta_augf, kernel_tt2)
        kernel(config, fn.val.f, subtape_cc, kernel_args...;
            groupsize, gridsize, kwargs...)
    end
    return EnzymeRules.AugmentedReturn{Nothing, Nothing, ROCArray}(nothing, nothing, subtape)
end

end
