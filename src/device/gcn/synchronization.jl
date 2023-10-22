"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call.
"""
@inline sync_workgroup() =
    ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())

"""
    sync_workgroup_count(predicate::Cint)::Cint

Identical to `sync_workgroup`, with the additional feature
that it evaluates the predicate for all workitems in the workgroup
and returns the number of workitems for which predicate evaluates to non-zero.
"""
@inline function sync_workgroup_count(predicate::Cint)::Cint
    ccall(
        "extern __ockl_wgred_add_i32", llvmcall, Cint, (Cint,),
        __not(__not(predicate)))
end

"""
    sync_workgroup_and(predicate::Cint)::Cint

Identical to `sync_workgroup`, with the additional feature
that it evaluates the predicate for all workitems in the workgroup
and returns non-zero if and only if predicate evaluates to non-zero for all of them.
"""
@inline function sync_workgroup_and(predicate::Cint)::Cint
    ccall(
        "extern __ockl_wgred_and_i32", llvmcall, Cint, (Cint,),
        __not(__not(predicate)))
end

"""
    sync_workgroup_or(predicate::Cint)::Cint

Identical to `sync_workgroup`, with the additional feature
that it evaluates the predicate for all workitems in the workgroup
and returns non-zero if and only if predicate evaluates to non-zero for any of them.
"""
@inline function sync_workgroup_or(predicate::Cint)::Cint
    ccall(
        "extern __ockl_wgred_or_i32", llvmcall, Cint, (Cint,),
        __not(__not(predicate)))
end

@inline __not(x::Cint)::Cint = ifelse(iszero(x), one(x), zero(x))
