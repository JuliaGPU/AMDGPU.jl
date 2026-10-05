module AMDGPUKernelAbstractionsExt

import AMDGPU
import AMDGPU.Device: @device_override
using AMDGPU: GPUArrays, ROCBackend

import Adapt
import KernelAbstractions as KA
import LLVM


Adapt.adapt_storage(::KA.CPU, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) =
    Adapt.adapt(Array, a)

## kernel launch

# KernelAbstractions launches kernels through the KernelInterface back-end; tell the
# compiler about statically sized workgroups
function KA.compiler_options(obj::KA.Kernel{ROCBackend})
    if KA.workgroupsize(obj) <: KA.StaticSize
        return (; maxthreads = prod(KA.get(KA.workgroupsize(obj))))
    else
        return (;)
    end
end

## scratch memory

@device_override @inline function KA.Scratchpad(ctx, ::Type{T}, ::Val{Dims}) where {T, Dims}
    KA.PrivateArray{T}(undef, Val(Dims), Val(AMDGPU.AS.Private))
end

## other

# `@Const` arrays are read through the constant address space
function Adapt.adapt_storage(::KA.ConstAdaptor, a::AMDGPU.ROCDeviceArray{T}) where T
    ptr = LLVM.Interop.addrspacecast(Core.LLVMPtr{T,AMDGPU.Device.AS.Constant}, a.ptr)
    AMDGPU.ROCDeviceArray(a.dims, ptr)
end

end
