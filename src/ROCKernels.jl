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
    ROCBackend <: KernelAbstractions.GPU

KernelAbstractions backend that executes kernels on an AMD GPU via AMDGPU.jl.
Pass `ROCBackend()` to a KernelAbstractions kernel to run it on the GPU, or
obtain it from an array with `KernelAbstractions.get_backend(::ROCArray)`.
"""
struct ROCBackend <: KI.GPU end

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

KI.unsafe_free!(x::AMDGPU.ROCArray) = AMDGPU.unsafe_free!(x)
KI.allocate(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ROCArray{T}(undef, dims)
KI.zeros(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.zeros(T, dims)
KI.ones(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ones(T, dims)

function KI.priority!(::ROCBackend, priority::Symbol)
    priority ∉ (:high, :normal, :low) && error(
        "Priority `$priority` must be one of `:high`, `:normal`, `:low`.")
    AMDGPU.priority!(priority)
end

function KI.copyto!(::ROCBackend, A, B)
    GC.@preserve A B begin
        copyto!(A, 1, B, 1, length(A))
    end
    return
end

function KI.pagelock!(::ROCBackend, x::Array)
    AMDGPU.Mem.pin(pointer(x), sizeof(x))
    return
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
function KI.sub_group_size(::ROCBackend)::Int
    HIP.wavefrontsize(HIP.device())
end
function KI.multiprocessor_count(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.HIP.device(), AMDGPU.HIP.hipDeviceAttributeMultiprocessorCount))
end

KI.shfl_down_types(::ROCBackend) = DataType[Bool,
                                             UInt8, UInt16, UInt32, UInt64, UInt128,
                                             Int8, Int16, Int32, Int64, Int128,
                                             Float16, Float32, Float64,
                                             ComplexF16, ComplexF32, ComplexF64]

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

@device_override KI.get_sub_group_size() = UInt32(Device.wavefrontsize())

@device_override KI.get_max_sub_group_size() = UInt32(Device.wavefrontsize())

@device_override KI.get_num_sub_groups() = UInt32(prod(Device.blockDim()) ÷ Device.wavefrontsize())

@device_override KI.get_sub_group_id() = UInt32(((Device.threadIdx().x - 1) + Device.blockDim().x * (Device.threadIdx().y - 1) + Device.blockDim().x * Device.blockDim().y * (Device.threadIdx().z - 1)) ÷ Device.wavefrontsize()) + 0x1

@device_override KI.get_sub_group_local_id() = UInt32(Device.activelane() + 0x1)

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
    @inline AMDGPU.Device.shfl_down(val, Cint(offset))
end

@device_override @inline function KI._print(args...)
    # TODO
end
## COV_EXCL_STOP

end
