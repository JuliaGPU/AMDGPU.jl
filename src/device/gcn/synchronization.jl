
for ord in UnsafeAtomics.Internal.orderings
    for sync in (AMDGPU.syncscope_agent, AMDGPU.syncscope_workgroup)
        @eval function UnsafeAtomics.fence(::$(typeof(ord)), ::$(typeof(sync)))
            Base.llvmcall(
                    $("""
                    define void @fence() #0 {
                    entry:
                        fence $sync $ord
                        ret void
                    }
                    attributes #0 = { alwaysinline }
                    """, "fence"), Nothing, Tuple{})
        end
    end
end

"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call and that their memory accesses are visible to other threads in the workgroup.
"""
@inline function sync_workgroup()
    # This needs a fence as well since the barrier has no memory semantics.
    # It's unclear which fence/how many fences are needed. To be safest we follow HIP's
    # https://github.com/ROCm/llvm-project/blob/69549e0c2a54a526f90783f43b969871d9d3e41c/amd/device-libs/opencl/src/workgroup/wgbarrier.cl#L8-L38
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_workgroup)
    ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_workgroup)
end

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
