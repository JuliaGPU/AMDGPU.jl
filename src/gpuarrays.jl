import KernelAbstractions

function GPUArrays.derive(
    ::Type{T}, x::ROCArray, dims::Dims{N}, offset::Int,
) where {N, T}
    ref = copy(x.buf)
    offset += (x.offset * Base.elsize(x)) ÷ sizeof(T)
    ROCArray{T, N}(ref, dims; offset)
end

# @roc conversion

function Base.convert(
    ::Type{ROCDeviceArray{T, N, AS.Global}}, a::ROCArray{T, N},
) where {T, N}
    # If HostBuffer, use device pointer.
    buf = convert(Mem.AbstractAMDBuffer, a.buf[])
    ptr = convert(Ptr{T}, typeof(buf) <: Mem.HIPBuffer ?
        buf : buf.dev_ptr)
    llvm_ptr = AMDGPU.LLVMPtr{T,AS.Global}(ptr + a.offset * sizeof(T))
    ROCDeviceArray{T, N, AS.Global}(a.dims, llvm_ptr)
end

Adapt.adapt_storage(::Runtime.Adaptor, x::ROCArray{T,N}) where {T,N} =
    convert(ROCDeviceArray{T,N,AS.Global}, x)
