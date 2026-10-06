module ROCKernels

export ROCBackend

import AMDGPU
import AMDGPU.Device: @device_override
using AMDGPU: GPUArrays, rocSPARSE, HIP, Device, rocconvert, hipfunction

import Adapt
import KernelInterface as KI

"""
    ROCBackend <: KernelInterface.Backend

KernelInterface backend that executes kernels on an AMD GPU via AMDGPU.jl.
Pass `ROCBackend()` to a KernelAbstractions kernel to run it on the GPU, or
obtain it from an array with `KernelInterface.get_backend(::ROCArray)`.

Printing from a kernel (`KernelAbstractions.@print`) is not supported: it does nothing.
"""
struct ROCBackend <: KI.Backend end

KI.functional(::ROCBackend) = AMDGPU.functional()
KI.ndevices(::ROCBackend) = AMDGPU.HIP.ndevices()
KI.device(::ROCBackend) = AMDGPU.device_id()
function KI.device!(kab::ROCBackend, id::Int)
    (0 < id <= KI.ndevices(kab)) || throw(ArgumentError("Device id $id out of bounds."))
    AMDGPU.device_id!(id)
    return
end
KI.device(::ROCBackend, A::AMDGPU.ROCArray) = AMDGPU.device_id(AMDGPU.device(A))

Adapt.adapt_storage(::ROCBackend, a::AbstractArray) = Adapt.adapt(AMDGPU.ROCArray, a)
Adapt.adapt_storage(::ROCBackend, a::Union{AMDGPU.ROCArray, GPUArrays.AbstractGPUSparseArray}) = a

KI.get_backend(::AMDGPU.ROCArray) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseVector) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSC) = ROCBackend()
KI.get_backend(::AMDGPU.rocSPARSE.ROCSparseMatrixCSR) = ROCBackend()

KI.synchronize(::ROCBackend) = AMDGPU.synchronize()

KI.supports_float64(::ROCBackend) = true
KI.supports_atomics(::ROCBackend) = true

function KI.priority!(::ROCBackend, priority::Symbol)
    priority ∉ (:high, :normal, :low) && error(
        "Priority `$priority` must be one of `:high`, `:normal`, `:low`.")
    AMDGPU.priority!(priority)
    return
end

## memory operations

KI.unsafe_free!(x::AMDGPU.ROCArray) = AMDGPU.unsafe_free!(x)
KI.allocate(::ROCBackend, ::Type{T}, dims::Tuple) where T = AMDGPU.ROCArray{T}(undef, dims)

# dense arrays, and contiguous views of them
const ContiguousArray{T} = Union{DenseArray{T}, Base.FastContiguousSubArray{T, <:Any, <:DenseArray}}
on_device(A::ContiguousArray) = parent(A) isa AMDGPU.ROCArray

function KI.copyto!(::ROCBackend, A::ContiguousArray{T}, B::ContiguousArray{T}) where T
    length(A) == length(B) ||
        throw(ArgumentError("Arrays must have the same length, got $(length(A)) and $(length(B))"))
    if isbitstype(T) && (on_device(A) || on_device(B))
        # queued on the task's stream, after the work queued before it
        GC.@preserve A B begin
            AMDGPU.Mem.memcpy!(pointer(A), pointer(B), length(A) * AMDGPU.aligned_sizeof(T);
                               stream=AMDGPU.stream())
        end
    else
        # host-to-host copies, and bits unions, whose type tags are stored separately.
        # queued work may still access host arrays (e.g. a copy from the device), so wait
        # for it first.
        on_device(A) || on_device(B) || AMDGPU.synchronize()
        copyto!(A, B)
    end
    return A
end
KI.copyto!(::ROCBackend, A, B) =
    throw(ArgumentError("KernelInterface.copyto! only supports contiguous arrays of the same element type, got $(typeof(A)) and $(typeof(B))"))

function KI.pagelock!(::ROCBackend, x::Array)
    AMDGPU.Mem.pin(pointer(x), sizeof(x))
    return
end

## kernel launch

KI.argconvert(::ROCBackend, arg) = rocconvert(arg)

# a compiled kernel, and the callable it was compiled from. the kernel only holds pointers
# to the arrays the callable captures, so the callable has to be kept alive.
struct ROCKernel{F, K <: AMDGPU.Runtime.HIPKernel}
    f::F
    kernel::K
end

function KI.kernel_function(backend::ROCBackend, f::F, tt::TT=Tuple{}; name=nothing, kwargs...) where {F,TT}
    # kernels have to execute with the device's wavefront size, which is what `hipfunction`
    # compiles for by default
    ws = HIP.wavefrontsize(AMDGPU.device())
    if haskey(kwargs, :wavefrontsize64) && kwargs[:wavefrontsize64] != (ws == 64)
        throw(ArgumentError("`wavefrontsize64=$(kwargs[:wavefrontsize64])` conflicts with the wavefront size of the device, $ws"))
    end
    kernel = hipfunction(rocconvert(f), tt; name, kwargs...)
    return KI.Kernel(backend, ROCKernel(f, kernel))
end

function KI.launch(obj::KI.Kernel{ROCBackend}, groups::Dims{3}, items::Dims{3},
                   args::Tuple; kwargs...)
    # KernelInterface has validated the launch geometry
    if haskey(kwargs, :groupsize) || haskey(kwargs, :gridsize)
        throw(ArgumentError("KernelInterface kernels take `numgroups`, `workgroupsize` or `ndrange`, not `groupsize` or `gridsize`"))
    end
    f = obj.kern.f
    kernel = obj.kern.kernel
    stream = get(kwargs, :stream, AMDGPU.stream())
    GC.@preserve f begin
        # convert the callable again, like the arguments, which makes the arrays it captures
        # available to the stream
        kernel = typeof(kernel)(rocconvert(f, stream), kernel.fun)
        AMDGPU.Runtime.launch_tuple(kernel, args; groupsize=items, gridsize=groups, kwargs..., stream)
    end
    return
end

function KI.max_work_group_size(kernel::KI.Kernel{ROCBackend})::Int
    max_items = Ref{Cint}()
    HIP.hipFuncGetAttribute(max_items, HIP.HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK, kernel.kern.kernel.fun)
    return Int(max_items[])
end
function KI.launch_configuration(kernel::KI.Kernel{ROCBackend}; nitems::Union{Integer,Nothing}=nothing,
                                 max_work_group_size::Integer=typemax(Int))
    max_items = min(max_work_group_size, something(nitems, typemax(Int)),
                    KI.max_work_group_size(kernel))
    (; groupsize) = AMDGPU.launch_configuration(kernel.kern.kernel; max_block_size=max_items)
    return (; workgroupsize=Int(min(groupsize, max_items)))
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
function KI.multiprocessor_count(::ROCBackend)::Int
    Int(HIP.attribute(AMDGPU.device(), HIP.hipDeviceAttributeMultiprocessorCount))
end

## COV_EXCL_START

## indexing

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

## shared memory

@device_override @inline function KI.localmemory(::Type{T}, ::Val{Dims}) where {T, Dims}
    # every call site gets its own memory, see `alloc_special`
    ptr = Device.alloc_special(Val(:localmemory), T, Val(AMDGPU.AS.Local), Val(prod(Dims)))
    AMDGPU.ROCDeviceArray(Dims, ptr)
end

## synchronization and printing

@device_override @inline function KI.barrier()
    Device.sync_workgroup()
end

# not supported, see the `ROCBackend` docstring
@device_override @inline KI._print(args...) = nothing

## COV_EXCL_STOP

end
