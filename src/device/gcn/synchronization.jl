
"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call and that their memory accesses are visible to other threads in the workgroup.
"""
@device_function @inline function sync_workgroup()
    # This needs a fence as well since the barrier has no memory semantics.
    # It's unclear which fence/how many fences are needed. To be safest we follow HIP's
    # https://github.com/ROCm/llvm-project/blob/69549e0c2a54a526f90783f43b969871d9d3e41c/amd/device-libs/opencl/src/workgroup/wgbarrier.cl#L8-L38
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_workgroup)
    ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_workgroup)
end

# A workgroup-scope fence that only orders the accesses to one kind of memory, which a
# memory model relaxation annotation on the fence selects, like Clang's
# `__builtin_amdgcn_fence`. LLVM 23 renamed the annotation from `amdgpu-as` to
# `amdgpu-synchronize-as`. A back-end ignores the name it doesn't know, and one that knows
# neither orders all memory, so the fence carries both.
for as in (:local, :global), ord in (:release, :acquire)
    @eval @device_function @inline function workgroup_fence(::Val{$(QuoteNode(as))},
                                                            ::Val{$(QuoteNode(ord))})
        Base.llvmcall(
            ($("""
            define void @entry() #0 {
                fence syncscope("workgroup") $ord, !mmra !0
                ret void
            }
            attributes #0 = { alwaysinline }
            !0 = !{!1, !2}
            !1 = !{!"amdgpu-as", !"$as"}
            !2 = !{!"amdgpu-synchronize-as", !"$as"}
            """), "entry"), Cvoid, Tuple{})
    end
end

"""
    sync_workgroup(::Val{:local})
    sync_workgroup(::Val{:global})

Like [`sync_workgroup()`](@ref sync_workgroup), but only the accesses to local (LDS) or
to global memory are made visible to the other threads in the workgroup, which can be
cheaper.
"""
@device_function @inline function sync_workgroup(as::Union{Val{:local}, Val{:global}})
    # the fences ROCm's device library uses for a barrier with a single flag, see the link
    # above
    workgroup_fence(as, Val(:release))
    ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())
    workgroup_fence(as, Val(:acquire))
end

"""
    sync_wavefront()

Waits until all lanes of the wavefront have reached this call, and makes their memory
accesses before it visible to the other lanes of the wavefront.
"""
@device_function @inline function sync_wavefront()
    # the lanes of a wavefront execute in lockstep, so the barrier doesn't generate any
    # code (https://github.com/llvm/llvm-project/blob/88b77d5eaa66747538a12c9876eeffdce31ddb71/openmp/device/src/Synchronization.cpp#L136-L140),
    # but it keeps the compiler from moving code across it. like `sync_workgroup`, it needs
    # fences to order memory.
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_wavefront)
    ccall("llvm.amdgcn.wave.barrier", llvmcall, Cvoid, ())
    UnsafeAtomics.fence(UnsafeAtomics.seq_cst, AMDGPU.syncscope_wavefront)
end

"""
    sync_workgroup_count(predicate::Cint)::Cint

Identical to `sync_workgroup`, with the additional feature
that it evaluates the predicate for all workitems in the workgroup
and returns the number of workitems for which predicate evaluates to non-zero.
"""
@device_function @inline function sync_workgroup_count(predicate::Cint)
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
@device_function @inline function sync_workgroup_and(predicate::Cint)
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
@device_function @inline function sync_workgroup_or(predicate::Cint)
    ccall(
        "extern __ockl_wgred_or_i32", llvmcall, Cint, (Cint,),
        __not(__not(predicate)))
end

@inline __not(x::Cint)::Cint = ifelse(iszero(x), one(x), zero(x))

@device_function @inline function sync_grid()
    ccall("extern __ockl_grid_sync", llvmcall, Cvoid, ())
end
