module ROCKernels

import AMDGPU
import AMDGPU.Device: @device_override
import KernelAbstractions
import KernelAbstractions: Adapt, StaticArrays
import LLVM
import UnsafeAtomicsLLVM

import .StaticArrays: MArray

export ROCBackend

struct ROCBackend <: KernelAbstractions.GPU end

Adapt.adapt_storage(::ROCBackend, a::Array) = Adapt.adapt(AMDGPU.ROCArray, a)
Adapt.adapt_storage(::ROCBackend, a::AMDGPU.ROCArray) = a
Adapt.adapt_storage(::KernelAbstractions.CPU, a::AMDGPU.ROCArray) = convert(Array, a)

KernelAbstractions.get_backend(::AMDGPU.ROCArray) = ROCBackend()
KernelAbstractions.synchronize(::ROCBackend) = AMDGPU.synchronize()

KernelAbstractions.unsafe_free!(x::AMDGPU.ROCArray) = AMDGPU.unsafe_free!(x)
KernelAbstractions.allocate(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ROCArray{T}(undef, dims)
KernelAbstractions.zeros(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.zeros(T, dims)
KernelAbstractions.ones(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ones(T, dims)

function KernelAbstractions.priority!(::ROCBackend, priority::Symbol)
    priority ∉ (:high, :normal, :low) && error(
        "Priority `$priority` must be one of `:high`, `:normal`, `:low`.")
    AMDGPU.priority!(priority)
end

##
# copyto!
##

function KernelAbstractions.copyto!(::ROCBackend, A, B)
    GC.@preserve A B begin
        # TODO: async copy
        copyto!(A, 1, B, 1, length(A))
    end
    return nothing
end

import KernelAbstractions: Kernel, StaticSize, DynamicSize, partition, blocks, workitems, launch_config

###
# Kernel launch
###
function launch_config(kernel::Kernel{ROCBackend}, ndrange, workgroupsize)
    if ndrange isa Integer
        ndrange = (ndrange,)
    end
    if workgroupsize isa Integer
        workgroupsize = (workgroupsize, )
    end

    # partition checked that the ndrange's agreed
    if KernelAbstractions.ndrange(kernel) <: StaticSize
        ndrange = nothing
    end

    iterspace, dynamic = if KernelAbstractions.workgroupsize(kernel) <: DynamicSize && workgroupsize === nothing
        workgroupsize = ntuple(i->i == 1 ? min(prod(ndrange), AMDGPU.Device._max_group_size) : 1, length(ndrange))
        partition(kernel, ndrange, workgroupsize)
    else
        partition(kernel, ndrange, workgroupsize)
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

function (obj::Kernel{ROCBackend})(args...; ndrange=nothing, workgroupsize=nothing)
    ndrange, new_workgroupsize, iterspace, dynamic = launch_config(obj, ndrange, workgroupsize)
    ctx = mkcontext(obj, ndrange, iterspace)
    kernel = AMDGPU.@roc launch=false obj.f(ctx, args...)

    # If dynamic, figure out the optimal groupsize automatically.
    is_dynamic =
        KernelAbstractions.workgroupsize(obj) <: DynamicSize &&
        isnothing(workgroupsize)
    if is_dynamic
        (; groupsize) = AMDGPU.launch_configuration(kernel)
        new_workgroupsize = threads_to_workgroupsize(groupsize, ndrange)
        iterspace, dynamic = partition(obj, ndrange, new_workgroupsize)
        ctx = mkcontext(obj, ndrange, iterspace)
    end

    nblocks = length(blocks(iterspace))
    nthreads = length(workitems(iterspace))
    nblocks == 0 && return nothing

    AMDGPU.@roc groupsize=nthreads gridsize=nblocks obj.f(ctx, args...)
    return nothing
end

import KernelAbstractions: CompilerMetadata, DynamicCheck, LinearIndices
import KernelAbstractions: __index_Local_Linear, __index_Group_Linear, __index_Global_Linear, __index_Local_Cartesian, __index_Group_Cartesian, __index_Global_Cartesian, __validindex, __print
import KernelAbstractions: mkcontext, expand, __iterspace, __ndrange, __dynamic_checkbounds

function mkcontext(kernel::Kernel{ROCBackend}, _ndrange, iterspace)
    metadata = CompilerMetadata{KernelAbstractions.ndrange(kernel), DynamicCheck}(_ndrange, iterspace)
end
function mkcontext(kernel::Kernel{ROCBackend}, I, _ndrange, iterspace, ::Dynamic) where Dynamic
    metadata = CompilerMetadata{KernelAbstractions.ndrange(kernel), Dynamic}(I, _ndrange, iterspace)
end

@device_override @inline function __index_Local_Linear(ctx)
    return AMDGPU.Device.threadIdx().x
end

@device_override @inline function __index_Group_Linear(ctx)
    return AMDGPU.Device.blockIdx().x
end

@device_override @inline function __index_Global_Linear(ctx)
    I =  @inbounds expand(__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
    # TODO: This is unfortunate, can we get the linear index cheaper
    @inbounds LinearIndices(__ndrange(ctx))[I]
end

@device_override @inline function __index_Local_Cartesian(ctx)
    @inbounds workitems(__iterspace(ctx))[AMDGPU.Device.threadIdx().x]
end

@device_override @inline function __index_Group_Cartesian(ctx)
    @inbounds blocks(__iterspace(ctx))[AMDGPU.Device.blockIdx().x]
end

@device_override @inline function __index_Global_Cartesian(ctx)
    return @inbounds expand(__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
end

@device_override @inline function __validindex(ctx)
    if __dynamic_checkbounds(ctx)
        I = @inbounds expand(__iterspace(ctx), AMDGPU.Device.blockIdx().x, AMDGPU.Device.threadIdx().x)
        return I in __ndrange(ctx)
    else
        return true
    end
end

import KernelAbstractions: groupsize, __groupsize, __workitems_iterspace
import KernelAbstractions: ConstAdaptor, SharedMemory, Scratchpad, __synchronize, __size

###
# GPU implementation of shared memory
# - shared memory for each workgroup
###
@device_override @inline function SharedMemory(::Type{T}, ::Val{Dims}, ::Val{Id}) where {T, Dims, Id}
    ptr = AMDGPU.Device.alloc_special(Val(Id), T, Val(AMDGPU.AS.Local), Val(prod(Dims)))
    AMDGPU.ROCDeviceArray(Dims, ptr)
end

###
# GPU implementation of scratch memory
# - private memory for each workitem
###

@device_override @inline function Scratchpad(ctx, ::Type{T}, ::Val{Dims}) where {T, Dims}
    MArray{__size(Dims), T}(undef)
end

@device_override @inline function __synchronize()
    AMDGPU.Device.sync_workgroup()
end

@device_override @inline function __print(args...)
    for arg in args
        AMDGPU.Device.@rocprintf("%s", arg)
    end
end

###
# GPU implementation of constant memory
# - access to constant (unchanging) memory
###

Adapt.adapt_storage(to::ConstAdaptor, a::AMDGPU.ROCDeviceArray{T,N,A}) where {T,N,A} =
    AMDGPU.ROCDeviceArray(a.shape, LLVM.Interop.addrspacecast(Core.LLVMPtr{T,AMDGPU.Device.AS.Constant}, a.ptr))

# Argument conversion

KernelAbstractions.argconvert(::Kernel{ROCBackend}, arg) = AMDGPU.rocconvert(arg)

end
