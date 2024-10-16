module ROCKernels

export ROCBackend

import AMDGPU
import AMDGPU.Device: @device_override

import Adapt
import KernelAbstractions as KA
import LLVM
import UnsafeAtomicsLLVM

using StaticArraysCore: MArray

struct ROCBackend <: KA.GPU end

Adapt.adapt_storage(::ROCBackend, a::Array) = Adapt.adapt(AMDGPU.ROCArray, a)
Adapt.adapt_storage(::ROCBackend, a::AMDGPU.ROCArray) = a
Adapt.adapt_storage(::KA.CPU, a::AMDGPU.ROCArray) = convert(Array, a)
Adapt.adapt_storage(::KA.ConstAdaptor, a::AMDGPU.ROCDeviceArray{T}) where T =
    AMDGPU.ROCDeviceArray(a.shape, LLVM.Interop.addrspacecast(Core.LLVMPtr{T,AMDGPU.Device.AS.Constant}, a.ptr))

KA.argconvert(::KA.Kernel{ROCBackend}, arg) = AMDGPU.rocconvert(arg)
KA.get_backend(::AMDGPU.ROCArray) = ROCBackend()
KA.synchronize(::ROCBackend) = AMDGPU.synchronize()

KA.unsafe_free!(x::AMDGPU.ROCArray) = AMDGPU.unsafe_free!(x)
KA.allocate(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ROCArray{T}(undef, dims)
KA.zeros(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.zeros(T, dims)
KA.ones(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ones(T, dims)

function KA.priority!(::ROCBackend, priority::Symbol)
    priority ∉ (:high, :normal, :low) && error(
        "Priority `$priority` must be one of `:high`, `:normal`, `:low`.")
    AMDGPU.priority!(priority)
end

function KA.copyto!(::ROCBackend, A, B)
    GC.@preserve A B begin
        copyto!(A, 1, B, 1, length(A))
    end
    return
end

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
    kernel = AMDGPU.@roc launch=false obj.f(ctx, args...)

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

# Indexing.

@device_override @inline function KA.__index_Local_Linear(ctx)
    return AMDGPU.Device.threadIdx().x
end

@device_override @inline function KA.__index_Group_Linear(ctx)
    return AMDGPU.Device.blockIdx().x
end

@device_override @inline function KA.__index_Global_Linear(ctx)
    I =  @inbounds KA.expand(KA.__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
    # TODO: This is unfortunate, can we get the linear index cheaper
    @inbounds LinearIndices(KA.__ndrange(ctx))[I]
end

@device_override @inline function KA.__index_Local_Cartesian(ctx)
    @inbounds KA.workitems(KA.__iterspace(ctx))[AMDGPU.Device.threadIdx().x]
end

@device_override @inline function KA.__index_Group_Cartesian(ctx)
    @inbounds KA.blocks(KA.__iterspace(ctx))[AMDGPU.Device.blockIdx().x]
end

@device_override @inline function KA.__index_Global_Cartesian(ctx)
    return @inbounds KA.expand(KA.__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
end

@device_override @inline function KA.__validindex(ctx)
    if KA.__dynamic_checkbounds(ctx)
        I = @inbounds KA.expand(KA.__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
        return I in KA.__ndrange(ctx)
    else
        return true
    end
end

# Shared memory.

@device_override @inline function KA.SharedMemory(::Type{T}, ::Val{Dims}, ::Val{Id}) where {T, Dims, Id}
    ptr = AMDGPU.Device.alloc_special(Val(Id), T, Val(AMDGPU.AS.Local), Val(prod(Dims)))
    AMDGPU.ROCDeviceArray(Dims, ptr)
end

@device_override @inline function KA.Scratchpad(ctx, ::Type{T}, ::Val{Dims}) where {T, Dims}
    MArray{KA.__size(Dims), T}(undef)
end

# Other.

@device_override @inline function KA.__synchronize()
    AMDGPU.Device.sync_workgroup()
end

@device_override @inline function KA.__print(args...)
    # TODO
end

end
