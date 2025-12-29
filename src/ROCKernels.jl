module ROCKernels

export ROCBackend

import AMDGPU
import AMDGPU: rocconvert, hipfunction
import AMDGPU.Device: @device_override
using AMDGPU: GPUArrays, rocSPARSE, HIP

import Adapt
import KernelAbstractions as KA
import KernelAbstractions.KernelIntrinsics as KI
import LLVM

using StaticArraysCore: MArray

struct ROCBackend <: KA.GPU end

KA.ndevices(::ROCBackend) = AMDGPU.HIP.ndevices()
KA.device(::ROCBackend) = AMDGPU.device_id()
function KA.device!(kab::ROCBackend, id::Int)
    (0 < id <= KA.ndevices(kab)) || throw(ArgumentError("Device id $id out of bounds."))
    AMDGPU.device_id!(id)
    return
end

Adapt.adapt_storage(::ROCBackend, a::Array) = Adapt.adapt(AMDGPU.ROCArray, a)
Adapt.adapt_storage(::ROCBackend, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) = a
Adapt.adapt_storage(::KA.CPU, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) =
    Adapt.adapt(Array, a)
function Adapt.adapt_storage(::KA.ConstAdaptor, a::AMDGPU.ROCDeviceArray{T}) where T
    ptr = LLVM.Interop.addrspacecast(Core.LLVMPtr{T,AMDGPU.Device.AS.Constant}, a.ptr)
    AMDGPU.ROCDeviceArray(a.dims, ptr)
end

KA.get_backend(::AMDGPU.ROCArray) = ROCBackend()
KA.get_backend(::AMDGPU.rocSPARSE.ROCSparseVector) = ROCBackend()
KA.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSC) = ROCBackend()
KA.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSR) = ROCBackend()

KA.argconvert(::KA.Kernel{ROCBackend}, arg) = AMDGPU.rocconvert(arg)
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

function KA.pagelock!(::ROCBackend, x::Array)
    AMDGPU.Mem.pin(pointer(x), sizeof(x))
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

KI.argconvert(::ROCBackend, arg) = rocconvert(arg)

function KI.kernel_function(::ROCBackend, f::F, tt::TT=Tuple{}; name=nothing, kwargs...) where {F,TT}
    kern = hipfunction(f, tt; name, kwargs...)
    KI.Kernel{ROCBackend, typeof(kern)}(ROCBackend(), kern)
end

function (obj::KI.Kernel{ROCBackend})(args...; numworkgroups = 1, workgroupsize = 1)
    KI.check_launch_args(numworkgroups, workgroupsize)

    obj.kern(args...; groupsize = workgroupsize, gridsize = numworkgroups)
    return nothing
end


function KI.kernel_max_work_group_size(kikern::KI.Kernel{<:ROCBackend}; max_work_items::Int=Int(typemax(Int32)))::Int
    (; groupsize) = AMDGPU.launch_configuration(kikern.kern; max_block_size = max_work_items)

    return Int(min(max_work_items, groupsize))
end
function KI.max_work_group_size(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.HIP.device(), AMDGPU.HIP.hipDeviceAttributeMaxThreadsPerBlock))
end
function KI.multiprocessor_count(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.HIP.device(), AMDGPU.HIP.hipDeviceAttributeMultiprocessorCount))
end

# Indexing.
## COV_EXCL_START
@device_override @inline function KI.get_local_id()
    return (; x = Int(AMDGPU.Device.workitemIdx().x), y = Int(AMDGPU.Device.workitemIdx().y), z = Int(AMDGPU.Device.workitemIdx().z))
end

@device_override @inline function KI.get_group_id()
    return (; x = Int(AMDGPU.Device.workgroupIdx().x), y = Int(AMDGPU.Device.workgroupIdx().y), z = Int(AMDGPU.Device.workgroupIdx().z))
end

@device_override @inline function KI.get_global_id()
    return (; x = Int((AMDGPU.Device.workgroupIdx().x-1)*AMDGPU.Device.blockDim().x + AMDGPU.Device.workitemIdx().x), y = Int((AMDGPU.Device.workgroupIdx().y-1)*AMDGPU.Device.blockDim().y + AMDGPU.Device.workitemIdx().y), z = Int((AMDGPU.Device.workgroupIdx().z-1)*AMDGPU.Device.blockDim().z + AMDGPU.Device.workitemIdx().z))
end

@device_override @inline function KI.get_local_size()
    return (; x = Int(AMDGPU.Device.workgroupDim().x), y = Int(AMDGPU.Device.workgroupDim().y), z = Int(AMDGPU.Device.workgroupDim().z))
end

@device_override @inline function KI.get_num_groups()
    return (; x = Int(AMDGPU.Device.gridGroupDim().x), y = Int(AMDGPU.Device.gridGroupDim().y), z = Int(AMDGPU.Device.gridGroupDim().z))
end

@device_override @inline function KI.get_global_size()
    return (; x = Int(AMDGPU.Device.gridItemDim().x), y = Int(AMDGPU.Device.gridItemDim().y), z = Int(AMDGPU.Device.gridItemDim().z))
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

@device_override @inline function KI.localmemory(::Type{T}, ::Val{Dims}) where {T, Dims}
    ptr = AMDGPU.Device.alloc_special(Val(:shmem), T, Val(AMDGPU.AS.Local), Val(prod(Dims)))
    AMDGPU.ROCDeviceArray(Dims, ptr)
end

@device_override @inline function KA.Scratchpad(ctx, ::Type{T}, ::Val{Dims}) where {T, Dims}
    MArray{KA.__size(Dims), T}(undef)
end

# Other.

@device_override @inline function KI.barrier()
    AMDGPU.Device.sync_workgroup()
end

@device_override @inline function KI._print(args...)
    # TODO
end
## COV_EXCL_STOP

end
