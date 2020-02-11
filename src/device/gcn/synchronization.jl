export sync_workgroup

"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call.
"""
@inline sync_workgroup() = ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())
