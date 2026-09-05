module AMDGPUKernelAbstractionsEst

import AMDGPU
import AMDGPU.Device: @device_override
using AMDGPU: GPUArrays, rocSPARSE

import Adapt
import KernelAbstractions as KA
import LLVM

using StaticArraysCore: MArray

Adapt.adapt_storage(::KA.CPU, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) =
    Adapt.adapt(Array, a)
function Adapt.adapt_storage(::KA.ConstAdaptor, a::AMDGPU.ROCDeviceArray{T}) where T
    ptr = LLVM.Interop.addrspacecast(Core.LLVMPtr{T,AMDGPU.Device.AS.Constant}, a.ptr)
    AMDGPU.ROCDeviceArray(a.dims, ptr)
end

KA.argconvert(::KA.Kernel{ROCBackend}, arg) = AMDGPU.rocconvert(arg)

function KA.launch_config(kernel::KA.Kernel{ROCBackend}, ndrange, workgroupsize)
    if ndrange isa Integer
        ndrange = (ndrange,)
    end
    if workgroupsize isa Integer
        workgroupsize = (workgroupsize, )
    end

    # partition checked that the ndrange's agreed
    if KA.ndrange(kernel) <: KA.StaticSize
        ndrange = nothing
    end

    iterspace, dynamic = if KA.workgroupsize(kernel) <: KA.DynamicSize && workgroupsize === nothing
        workgroupsize = ntuple(
            i -> i == 1 ? min(prod(ndrange), AMDGPU.Device._max_group_size) : 1,
            length(ndrange))
        KA.partition(kernel, ndrange, workgroupsize)
    else
        KA.partition(kernel, ndrange, workgroupsize)
    end

    return ndrange, workgroupsize, iterspace, dynamic
end

function threads_to_workgroupsize(threads, ndrange)
    total = 1
    return map(ndrange) do n
        x = min(div(threads, total), n)
        total *= x
        return x
    end
end

function (obj::KA.Kernel{ROCBackend})(args...; ndrange=nothing, workgroupsize=nothing)
    ndrange, new_workgroupsize, iterspace, dynamic = KA.launch_config(obj, ndrange, workgroupsize)
    ctx = KA.mkcontext(obj, ndrange, iterspace)
    if KA.workgroupsize(obj) <: KA.StaticSize
        maxthreads = prod(KA.get(KA.workgroupsize(obj)))
    else
        maxthreads = nothing
    end
    kernel = AMDGPU.@roc launch=false maxthreads=maxthreads obj.f(ctx, args...)

    # If dynamic, figure out the optimal groupsize automatically.
    is_dynamic =
        KA.workgroupsize(obj) <: KA.DynamicSize &&
        isnothing(workgroupsize)
    if is_dynamic
        (; groupsize) = AMDGPU.launch_configuration(kernel)
        new_workgroupsize = threads_to_workgroupsize(groupsize, ndrange)
        iterspace, dynamic = KA.partition(obj, ndrange, new_workgroupsize)
        ctx = KA.mkcontext(obj, ndrange, iterspace)
    end

    nblocks = length(KA.blocks(iterspace))
    nthreads = length(KA.workitems(iterspace))
    nblocks == 0 && return

    kernel(ctx, args...; groupsize=nthreads, gridsize=nblocks)
    return
end

function KA.mkcontext(kernel::KA.Kernel{ROCBackend}, _ndrange, iterspace)
    metadata = KA.CompilerMetadata{KA.ndrange(kernel), KA.DynamicCheck}(_ndrange, iterspace)
end
function KA.mkcontext(kernel::KA.Kernel{ROCBackend}, I, _ndrange, iterspace, ::Dynamic) where Dynamic
    metadata = KA.CompilerMetadata{KA.ndrange(kernel), Dynamic}(I, _ndrange, iterspace)
end

@device_override @inline function KA.__validindex(ctx)
    if KA.__dynamic_checkbounds(ctx)
        I = @inbounds KA.expand(KA.__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
        return I in KA.__ndrange(ctx)
    else
        return true
    end
end

@device_override @inline function KA.Scratchpad(ctx, ::Type{T}, ::Val{Dims}) where {T, Dims}
    MArray{KA.__size(Dims), T}(undef)
end

end
