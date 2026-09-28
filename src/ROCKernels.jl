module ROCInterface

export ROCBackend

import AMDGPU
import AMDGPU: rocconvert, hipfunction
import AMDGPU.Device: @device_override
using AMDGPU: GPUArrays, rocSPARSE, HIP, Device

import Adapt
import KernelInterface as KI
import LLVM

using StaticArraysCore: MArray

"""
    ROCBackend <: KernelInterface.Backend

KernelInterface backend that executes kernels on an AMD GPU via AMDGPU.jl.
Obtain it from an array with `KernelInterface.get_backend(::ROCArray)`.

Printing from a kernel (`KernelInterface._print`) is not supported: it does nothing.
"""
struct ROCBackend <: KI.Backend end

KI.versioninfo(io::IO, ::ROCBackend) = AMDGPU.versioninfo(io)

KI.functional(::ROCBackend) = AMDGPU.functional()
KI.ndevices(::ROCBackend) = AMDGPU.HIP.ndevices()
KI.device(::ROCBackend) = AMDGPU.device_id()
function KI.device!(kab::ROCBackend, id::Int)
    (0 < id <= KI.ndevices(kab)) || throw(ArgumentError("Device id $id out of bounds."))
    AMDGPU.device_id!(id)
    return
end

Adapt.adapt_storage(::ROCBackend, a::AbstractArray) = Adapt.adapt(AMDGPU.ROCArray, a)
Adapt.adapt_storage(::ROCBackend, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) = a

KI.get_backend(::AMDGPU.ROCArray) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseVector) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSC) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSR) = ROCBackend()

KI.synchronize(::ROCBackend) = AMDGPU.synchronize()

function KI.record_event(::ROCBackend)
    return HIP.HIPEvent(AMDGPU.stream())
end

function KI.wait_event(::ROCBackend, ev::HIP.HIPEvent)
    HIP.hipStreamWaitEvent(AMDGPU.stream(), ev, 0)
    return
end

KI.unsafe_free!(x::AMDGPU.ROCArray) = AMDGPU.unsafe_free!(x)
KI.allocate(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ROCArray{T}(undef, dims)

function KI.priority!(::ROCBackend, priority::Symbol)
    priority ∉ (:high, :normal, :low) && error(
        "Priority `$priority` must be one of `:high`, `:normal`, `:low`.")
    AMDGPU.priority!(priority)
end

function KI.copyto!(::ROCBackend, A, B)
    length(A) == length(B) ||
        throw(ArgumentError("Arrays must have the same length, got $(length(A)) and $(length(B))"))
    GC.@preserve A B begin
        copyto!(A, 1, B, 1, length(A))
    end
    return A
end

function KI.pagelock!(::ROCBackend, x::Array)
    AMDGPU.Mem.pin(pointer(x), sizeof(x))
    return
end

KI.device(::ROCBackend, A::AMDGPU.ROCArray) = AMDGPU.device_id(AMDGPU.device(A))

KI.supports_float64(::ROCBackend) = true
KI.supports_atomics(::ROCBackend) = true

KI.argconvert(::ROCBackend, arg) = rocconvert(arg)

function KI.kernel_function(backend::ROCBackend, f::F, tt::TT=Tuple{}; name=nothing, kwargs...) where {F,TT}
    kern = hipfunction(f, tt; name, kwargs...)
    KI.Kernel{ROCBackend, typeof(kern)}(backend, kern)
end

function KI.launch(obj::KI.Kernel{ROCBackend}, groups::Dims{3}, items::Dims{3}, args...; kwargs...)
    obj.kern(args...; groupsize = items, gridsize = groups, kwargs...)
    return
end

function KI.max_work_group_size(kernel::KI.Kernel{ROCBackend})::Int
    max_items = Ref{Cint}()
    HIP.hipFuncGetAttribute(max_items, HIP.HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, kernel.kern.fun)
    return Int(max_items[])
end
function KI.launch_configuration(kernel::KI.Kernel{ROCBackend}; max_work_group_size::Integer=typemax(Int))
    max_items = min(max_work_group_size, KI.max_work_group_size(kernel))
    (; groupsize) = AMDGPU.launch_configuration(kernel.kern; max_block_size = max_items)
    return (; workgroupsize = Int(min(groupsize, max_items)))
end
function KI.max_work_group_size(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.device(), HIP.hipDeviceAttributeMaxThreadsPerBlock))
end
# queried on every automatically-sized launch, so use the limits cached in the device
KI.max_work_group_dims(::ROCBackend)::NTuple{3, Int} = HIP.max_workgroup_dims(AMDGPU.device())
# HIP takes the grid size in workgroups, but the dispatch packet holds it in work-items
# (as a UInt32 per dimension, which HIP checks), and the device code assumes workgroup
# indices fit in an Int32 (see `Device._max_groups`). Report the number of workgroups
# that can be launched with any valid workgroup size. HIP's `maxGridSize` isn't usable:
# depending on the ROCm version it holds CUDA's block limits or the work-item limits.
function KI.max_num_groups(backend::ROCBackend)::NTuple{3, Int}
    dims = KI.max_work_group_dims(backend)
    return ntuple(Val(3)) do d
        Int(min(Device._max_groups[d], Device._max_grid_size[d] ÷ dims[d]))
    end
end
function KI.sub_group_size(::ROCBackend)::Int
    Int(HIP.wavefrontsize(AMDGPU.device()))
end
function KI.multiprocessor_count(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.device(), HIP.hipDeviceAttributeMultiprocessorCount))
end

KI.supports_subgroups(::ROCBackend) = true
# `shfl_down` decomposes other types into 32-bit shuffles
KI.supports_shuffle(::ROCBackend, ::Type{T}) where {T} =
    T <: Union{Bool, Base.BitInteger, Base.IEEEFloat, Complex{<:Union{Base.BitInteger, Base.IEEEFloat}}}

# Indexing.
## COV_EXCL_START

# computed with `% T`, which unlike `T(x)` has no error path

@device_override @inline function KI.get_local_id(::Type{T}) where {T}
    return (; x = Device.workitemIdx().x % T, y = Device.workitemIdx().y % T, z = Device.workitemIdx().z % T)
end

@device_override @inline function KI.get_group_id(::Type{T}) where {T}
    return (; x = Device.workgroupIdx().x % T, y = Device.workgroupIdx().y % T, z = Device.workgroupIdx().z % T)
end

@device_override @inline function KI.get_local_size(::Type{T}) where {T}
    return (; x = Device.workgroupDim().x % T, y = Device.workgroupDim().y % T, z = Device.workgroupDim().z % T)
end

@device_override @inline function KI.get_num_groups(::Type{T}) where {T}
    return (; x = Device.gridGroupDim().x % T, y = Device.gridGroupDim().y % T, z = Device.gridGroupDim().z % T)
end

@device_override KI.get_sub_group_size(::Type{T}) where {T} = Device.wavefrontsize() % T

@device_override KI.get_max_sub_group_size(::Type{T}) where {T} = Device.wavefrontsize() % T

@device_override KI.get_num_sub_groups(::Type{T}) where {T} = (prod(Device.workgroupDim()) ÷ Device.wavefrontsize()) % T

@device_override KI.get_sub_group_id(::Type{T}) where {T} = (((Device.workitemIdx().x - 0x1) + Device.workgroupDim().x * (Device.workitemIdx().y - 0x1) + Device.workgroupDim().x * Device.workgroupDim().y * (Device.workitemIdx().z - 0x1)) ÷ Device.wavefrontsize() + 0x1) % T

@device_override KI.get_sub_group_local_id(::Type{T}) where {T} = (Device.activelane() + 0x1) % T

# Shared memory.

@device_override @inline function KI.localmemory(::Type{T}, ::Val{Dims}) where {T, Dims}
    ptr = AMDGPU.Device.alloc_special(Val(:shmem), T, Val(AMDGPU.AS.Local), Val(prod(Dims)))
    AMDGPU.ROCDeviceArray(Dims, ptr)
end

# Other.

@device_override @inline function KI.barrier()
    AMDGPU.Device.sync_workgroup()
end

@device_override @inline function KI.sub_group_barrier()
    AMDGPU.Device.sync_wavefront()
end

@device_override function KI.shfl_down(val::T, offset::Integer) where T
    @inline AMDGPU.Device.shfl_down(val, offset % Cint)
end

# not supported, see the `ROCBackend` docstring
@device_override @inline KI._print(args...) = nothing
## COV_EXCL_STOP

end
