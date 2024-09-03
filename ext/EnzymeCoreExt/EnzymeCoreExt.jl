module EnzymeCoreExt

using AMDGPU
using EnzymeCore
using GPUCompiler

function EnzymeCore.compiler_job_from_backend(
    ::ROCBackend, @nospecialize(F::Type), @nospecialize(TT::Type),
)
    Core.println("ENZ compiler job")
    mi = GPUCompiler.methodinstance(F, TT)
    return GPUCompiler.CompilerJob(mi, AMDGPU.compiler_config(AMDGPU.device()))
end

function EnzymeCore.EnzymeRules.forward(
    fn::Const{typeof(AMDGPU.hipfunction)}, ::Type{<: Duplicated},
    f::Const{F}, tt::Const{TT}; kwargs...
) where {F, TT}
    Core.println("ENZ hipfunction")
    res = fn.val(f.val, tt.val; kwargs...)
    return Duplicated(res, res)
end

function EnzymeCore.EnzymeRules.forward(
    fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    Core.println("ENZ rocconvert")
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

function EnzymeCore.EnzymeRules.augmented_primal(
    config, fn::Const{typeof(AMDGPU.rocconvert)}, ::Type{RT}, x::IT,
) where {RT, IT}
    Core.println("ENZ aug primal rocconvert")
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

end
