function meta_fn(config, fn, args::Vararg{Any, N}) where N
    EnzymeCore.autodiff_deferred(
        EnzymeCore.set_runtime_activity(Forward, config),
        Const(fn), Const, args...)
    return
end

function meta_augf(
    config, f, tape::ROCDeviceArray{TapeType}, args::Vararg{Any, N},
) where {N, TapeType}
    ModifiedBetween = EnzymeRules.overwritten(config)
    forward, _ = EnzymeCore.autodiff_deferred_thunk(
        ReverseSplitModified(
            EnzymeCore.set_runtime_activity(ReverseSplitWithPrimal, config),
            Val(ModifiedBetween)),
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

function meta_revf(
    config, f, tape::ROCDeviceArray{TapeType}, args::Vararg{Any, N},
) where {N, TapeType}
    ModifiedBetween = EnzymeRules.overwritten(config)
    _, reverse = EnzymeCore.autodiff_deferred_thunk(
        ReverseSplitModified(
            EnzymeCore.set_runtime_activity(ReverseSplitWithPrimal, config),
            Val(ModifiedBetween)),
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

    reverse(Const(f), args..., @inbounds tape[idx])
    return
end
