struct ROCArrayBackend <: AbstractGPUBackend end

struct ROCKernelContext <: AbstractKernelContext end

@inline function GPUArrays.gpu_call(
    ::ROCArrayBackend, f, args, threads::Int, blocks::Int;
    name::Union{String, Nothing},
)
    @roc gridsize=blocks groupsize=threads name=name f(ROCKernelContext(), args...)
end

# indexing

for (f, froc) in (
    (:blockidx, :blockIdx),
    (:blockdim, :blockDim),
    (:threadidx, :threadIdx),
    (:griddim, :gridGroupDim)
)
    @eval @inline GPUArrays.$f(::ROCKernelContext) = AMDGPU.$froc().x
end

# math

@inline GPUArrays.cos(::ROCKernelContext, x) = cos(x)
@inline GPUArrays.sin(::ROCKernelContext, x) = sin(x)
@inline GPUArrays.sqrt(::ROCKernelContext, x) = sqrt(x)
@inline GPUArrays.log(::ROCKernelContext, x) = log(x)

# memory

@inline function GPUArrays.LocalMemory(::ROCKernelContext, ::Type{T}, ::Val{dims}, ::Val{id}) where {T,dims,id}
    ptr = AMDGPU.Device.alloc_special(Val{id}(), T, Val{AMDGPU.AS.Local}(), Val{prod(dims)}())
    ROCDeviceArray(dims, ptr)
end

# synchronization

@inline function GPUArrays.synchronize_threads(::ROCKernelContext)
    sync_workgroup()
    return
end

GPUArrays.device(x::ROCArray) = x.buf[].device

GPUArrays.backend(::Type{<:ROCArray}) = ROCArrayBackend()

function GPUArrays.derive(::Type{T}, N::Int, x::ROCArray, dims::Dims, offset::Int) where T
    ref = copy(x.buf)
    offset += (x.offset * Base.elsize(x)) ÷ sizeof(T)
    ROCArray{T, N}(ref, dims; offset)
end

# @roc conversion

function Base.convert(
    ::Type{ROCDeviceArray{T, N, AS.Global}}, a::ROCArray{T, N},
) where {T, N}
    # If HostBuffer, use device pointer.
    ptr = Base.unsafe_convert(Ptr{T},
        typeof(a.buf[]) <: Mem.HIPBuffer ? a.buf[] : a.buf[].dev_ptr)
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset * sizeof(T))
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr)
end

Adapt.adapt_storage(::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, x)
