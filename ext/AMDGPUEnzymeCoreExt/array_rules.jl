# Rules for the ROCArray constructors, ported from CUDA.jl's EnzymeCoreExt.
#
# Without these, Enzyme differentiates through `pool_alloc`, whose allocation
# statistics use `Base.@atomic` on a global (`julia.atomicmodify`, a variadic
# intrinsic), and aborts with "number of arg operands != function parameters"
# in `CreateAugmentedPrimal`. Allocation is inactive: the shadow is a fresh,
# zeroed array of the same shape.

using GPUArrays: DataRef

function EnzymeRules.forward(config, ofn::Const{Type{CT}},
        ::Type{RT}, uval::EnzymeCore.Annotation{UndefInitializer}, args...) where {CT <: ROCArray, RT}
    primargs = ntuple(Val(length(args))) do i
        Base.@_inline_meta
        args[i].val
    end

    if EnzymeRules.needs_primal(config) && EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            shadow = ofn.val(uval.val, primargs...)::CT
            fill!(shadow, zero(eltype(shadow)))
            Duplicated(ofn.val(uval.val, primargs...), shadow)
        else
            tup = ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                shadow = ofn.val(uval.val, primargs...)::CT
                fill!(shadow, zero(eltype(shadow)))
                shadow::CT
            end
            BatchDuplicated(ofn.val(uval.val, primargs...), tup)
        end
    elseif EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            shadow = ofn.val(uval.val, primargs...)::CT
            fill!(shadow, zero(eltype(shadow)))
            shadow::EnzymeRules.shadow_type(config, RT)
        else
            tup = ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                shadow = ofn.val(uval.val, primargs...)::CT
                fill!(shadow, zero(eltype(shadow)))
                shadow::CT
            end
            tup::EnzymeRules.shadow_type(config, RT)
        end
    elseif EnzymeRules.needs_primal(config)
        ofn.val(uval.val, primargs...)
    else
        nothing
    end
end

function EnzymeRules.forward(config, ofn::Const{Type{CT}},
        ::Type{RT}, uval::EnzymeCore.Annotation{DR}, args...; kwargs...) where {CT <: ROCArray, DR <: DataRef, RT}
    primargs = ntuple(Val(length(args))) do i
        Base.@_inline_meta
        args[i].val
    end

    if EnzymeRules.needs_primal(config) && EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            shadow = ofn.val(uval.val, primargs...; kwargs...)
            Duplicated(ofn.val(uval.val, primargs...; kwargs...), shadow)
        else
            tup = ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                ofn.val(uval.val, primargs...; kwargs...)
            end
            BatchDuplicated(ofn.val(uval.val, primargs...; kwargs...), tup)
        end
    elseif EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            ofn.val(uval.val, primargs...; kwargs...)
        else
            ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                ofn.val(uval.val, primargs...; kwargs...)
            end
        end
    elseif EnzymeRules.needs_primal(config)
        ofn.val(uval.val, primargs...; kwargs...)
    else
        nothing
    end
end

function EnzymeRules.augmented_primal(config, ofn::Const{Type{CT}}, ::Type{RT},
        uval::EnzymeCore.Annotation{UndefInitializer}, args...) where {CT <: ROCArray, RT}
    primargs = ntuple(Val(length(args))) do i
        Base.@_inline_meta
        args[i].val
    end

    primal = if EnzymeRules.needs_primal(config)
        ofn.val(uval.val, primargs...)::CT
    else
        nothing
    end

    shadow = if EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            subshadow = ofn.val(uval.val, primargs...)::CT
            fill!(subshadow, zero(eltype(subshadow)))
            subshadow
        else
            ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                subshadow = ofn.val(uval.val, primargs...)::CT
                fill!(subshadow, zero(eltype(subshadow)))
                subshadow
            end
        end
    else
        nothing
    end
    return EnzymeRules.AugmentedReturn{EnzymeRules.primal_type(config, RT), EnzymeRules.shadow_type(config, RT), Nothing}(primal, shadow, nothing)
end

function EnzymeRules.reverse(config, ofn::Const{Type{CT}}, ::Type{RT}, tape,
        A::EnzymeCore.Annotation{UndefInitializer}, args::Vararg{EnzymeCore.Annotation, N}) where {CT <: ROCArray, RT, N}
    ntuple(Val(N+1)) do i
        Base.@_inline_meta
        nothing
    end
end

function EnzymeRules.augmented_primal(config, ofn::Const{Type{CT}}, ::Type{RT},
        uval::EnzymeCore.Annotation{DR}, args...; kwargs...) where {CT <: ROCArray, DR <: DataRef, RT}
    primargs = ntuple(Val(length(args))) do i
        Base.@_inline_meta
        args[i].val
    end

    primal = if EnzymeRules.needs_primal(config)
        ofn.val(uval.val, primargs...; kwargs...)
    else
        nothing
    end

    shadow = if EnzymeRules.needs_shadow(config)
        if EnzymeRules.width(config) == 1
            ofn.val(uval.dval, primargs...; kwargs...)
        else
            ntuple(Val(EnzymeRules.width(config))) do i
                Base.@_inline_meta
                ofn.val(uval.dval[i], primargs...; kwargs...)
            end
        end
    else
        nothing
    end
    return EnzymeRules.AugmentedReturn{EnzymeRules.primal_type(config, RT), EnzymeRules.shadow_type(config, RT), Nothing}(primal, shadow, nothing)
end

function EnzymeRules.reverse(config, ofn::Const{Type{CT}}, ::Type{RT}, tape,
        A::EnzymeCore.Annotation{DR}, args::Vararg{EnzymeCore.Annotation, N}; kwargs...) where {CT <: ROCArray, DR <: DataRef, RT, N}
    ntuple(Val(N+1)) do i
        Base.@_inline_meta
        nothing
    end
end

function EnzymeRules.noalias(::Type{CT}, ::UndefInitializer, args...) where {CT <: ROCArray}
    return nothing
end
