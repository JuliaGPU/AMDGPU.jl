"""
    sync_workgroup()

Waits until all wavefronts in a workgroup have reached this call.
This function is meant to be used inside kernels.
"""
@inline sync_workgroup() = ccall("llvm.amdgcn.s.barrier", llvmcall, Cvoid, ())
