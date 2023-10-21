"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call.
"""
@inline sync_workgroup() =
    ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())

"""
    sync_workgroup_count(predicate::Cint)::Cint

Identical to [sync_workgroup](@ref), with the additional feature
that it evaluates the predicate for all workitems in the workgroup
and returns the number of workitems for which predicate evaluates to non-zero.
"""
@inline sync_workgroup_count(predicate::Cint)::Cint = ccall(
    "extern __ockl_wgred_add_i32", llvmcall, Cint, (Cint,),
    __not(__not(predicate)))

@inline __not(x::Cint)::Cint = ifelse(iszero(x), one(x), zero(x))
