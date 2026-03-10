## data types

@enum hiptensorComputeDescriptorEnum begin
    COMPUTE_DESC_32F = 4
    COMPUTE_DESC_64F = 16
    COMPUTE_DESC_16F = 1
    COMPUTE_DESC_16BF = 1024
    COMPUTE_DESC_C32F = 2048
    COMPUTE_DESC_C64F = 4096
    COMPUTE_DESC_NONE = 0
    COMPUTE_DESC_8U = 64
    COMPUTE_DESC_8I = 256
    COMPUTE_DESC_32U = 128
    COMPUTE_DESC_32I = 512
end

const contraction_compute_types = Dict(
    # typeA,     typeB,      typeC       => typeCompute
    (Float16,    Float16,    Float16)    => Float32,
    (Float32,    Float32,    Float32)    => Float32,
    (Float64,    Float64,    Float64)    => Float64,
    (ComplexF32, ComplexF32, ComplexF32) => Float32,
    (ComplexF64, ComplexF64, ComplexF64) => Float64,
    (Float64,    ComplexF64, ComplexF64) => Float64,
    (ComplexF64, Float64,    ComplexF64) => Float64)

const elementwise_trinary_compute_types = Dict(
    # typeA,     typeB,      typeC       => typeCompute
    (Float16,    Float16,    Float16)    => Float16,
    (Float32,    Float32,    Float32)    => Float32,
    (Float64,    Float64,    Float64)    => Float64,
    (ComplexF32, ComplexF32, ComplexF32) => Float32,
    (ComplexF64, ComplexF64, ComplexF64) => Float64,
    (Float32,    Float32,    Float16)    => Float32,
  # (Float64,    Float64,    Float32)    => Float32,
    (ComplexF64, ComplexF64, ComplexF32) => Float64)

const elementwise_binary_compute_types = Dict(
    # typeA,     typeC       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float32,    Float32)    => Float32,
    (Float64,    Float64)    => Float64,
    (ComplexF32, ComplexF32) => Float32,
    (ComplexF64, ComplexF64) => Float64,
    (ComplexF64, ComplexF32) => Float64,
    (Float32,    Float16)    => Float32,
    (Float64,    Float32)    => Float64)

const permutation_compute_types = Dict(
    # typeA,     typeB       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float16,    Float32)    => Float32,
  # (Float32,    Float16)    => Float32,
    (Float32,    Float32)    => Float32,
    (Float64,    Float64)    => Float64,
    (Float32,    Float64)    => Float64,
  # (Float64,    Float32)    => Float64,
    (ComplexF32, ComplexF32) => Float32,
    (ComplexF64, ComplexF64) => Float64,
    (ComplexF32, ComplexF64) => Float64,
  # (ComplexF64, ComplexF32) => Float64
    )

const reduction_compute_types = Dict(
    # typeA,     typeC       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float32,    Float32)    => Float32,
    (Float64,    Float64)    => Float64,
    (ComplexF32, ComplexF32) => Float32,
    (ComplexF64, ComplexF64) => Float64)

# we have our own enum to represent hiptensorComputeDescriptor_t values
function Base.convert(::Type{hiptensorComputeDescriptorEnum}, T::DataType)
    if T == Float16
        return COMPUTE_DESC_16F
    elseif T == Float32
        return COMPUTE_DESC_32F
    elseif T == ComplexF32
        return COMPUTE_DESC_C32F
    elseif T == Float64
        return COMPUTE_DESC_64F
    elseif T == ComplexF64
        return COMPUTE_DESC_C64F
    elseif T == Int8 
        return COMPUTE_DESC_8I
    elseif T == UInt8 
        return COMPUTE_DESC_8U
    elseif T == Int32 
        return COMPUTE_DESC_32I
    elseif T == UInt32 
        return COMPUTE_DESC_32U
    else
        throw(ArgumentError("hiptensorComputeDescriptor equivalent for input type $T does not exist!"))
    end
end
Base.cconvert(::Type{hiptensorComputeDescriptor_t}, T::DataType) =
    Base.cconvert(hiptensorComputeDescriptor_t, convert(hiptensorComputeDescriptorEnum, T))

function Base.cconvert(::Type{hiptensorComputeDescriptor_t}, T::hiptensorComputeDescriptorEnum)
    if T == COMPUTE_DESC_16F
        return HIPTENSOR_COMPUTE_DESC_16F
    elseif T == COMPUTE_DESC_32F
        return HIPTENSOR_COMPUTE_DESC_32F
    elseif T == COMPUTE_DESC_64F
        return HIPTENSOR_COMPUTE_DESC_64F
    elseif T == COMPUTE_DESC_16BF
        return HIPTENSOR_COMPUTE_DESC_16BF
    elseif T == COMPUTE_DESC_C32F
        return HIPTENSOR_COMPUTE_DESC_C32F
    elseif T == COMPUTE_DESC_C64F
        return HIPTENSOR_COMPUTE_DESC_C64F
    elseif T == COMPUTE_DESC_8U
        return HIPTENSOR_COMPUTE_DESC_8U
    elseif T == COMPUTE_DESC_8I
        return HIPTENSOR_COMPUTE_DESC_8I
    elseif T == COMPUTE_DESC_32U
        return HIPTENSOR_COMPUTE_DESC_32U
    elseif T == COMPUTE_DESC_32I
        return HIPTENSOR_COMPUTE_DESC_32I
    else
        throw(ArgumentError("hiptensorComputeDescriptor equivalent for input enum value $T does not exist!"))
    end
end


function Base.convert(::Type{hiptensorDataType_t}, T::DataType)
    if T == Float16
        return HIPTENSOR_R_16F
    elseif T == ComplexF16
        return HIPTENSOR_C_16F
    elseif T == Float32
        return HIPTENSOR_R_32F
    elseif T == ComplexF32
        return HIPTENSOR_C_32F
    elseif T == Float64
        return HIPTENSOR_R_64F
    elseif T == ComplexF64
        return HIPTENSOR_C_64F
    elseif T == Int8
        return HIPTENSOR_R_8I
    elseif T == Int32
        return HIPTENSOR_R_32I
    elseif T == UInt8
        return HIPTENSOR_R_8U
    elseif T == UInt32
        return HIPTENSOR_R_32U
    else
        throw(ArgumentError("hiptensorDataType equivalent for input type $T does not exist!"))
    end
end

function Base.convert(::DataType, T::hiptensorDataType_t)
    if T == HIPTENSOR_R_16F
        return Float16
    elseif T == HIPTENSOR_R_32F
        return Float32
    elseif T == HIPTENSOR_C_32F
        return ComplexF32
    elseif T == HIPTENSOR_R_64F
        return Float64
    elseif T == HIPTENSOR_C_64F
        return ComplexF64
    else
        throw(ArgumentError("Data type equivalent for hiptensorDataType type $T does not exist!"))
    end
end


## plan

mutable struct hipTensorPlan
    handle::hiptensorPlan_t
    workspace::ROCVector{UInt8,Mem.HIPBuffer}
    scalar_type::DataType

    function hipTensorPlan(desc, pref; workspacePref=HIPTENSOR_WORKSPACE_DEFAULT)
        # estimate the workspace size
        workspaceSizeEstimate = Ref{UInt64}(0)
        hiptensorEstimateWorkspaceSize(handle(), desc, pref, workspacePref, workspaceSizeEstimate)

        # determine the scalar type
        required_scalar_type = Ref{hiptensorDataType_t}()
        hiptensorOperationDescriptorGetAttribute(handle(), desc, HIPTENSOR_OPERATION_DESCRIPTOR_SCALAR_TYPE, required_scalar_type, sizeof(required_scalar_type))
        @show convert(Int64, UInt32(required_scalar_type[]))

        # create the plan
        plan_ref = Ref{hiptensorPlan_t}()
        hiptensorCreatePlan(handle(), plan_ref, desc, pref, workspaceSizeEstimate[])

        # allocate the actual workspace
        actualWorkspaceSize = Ref{UInt64}(0)
        hiptensorPlanGetAttribute(handle(), plan_ref[], HIPTENSOR_PLAN_REQUIRED_WORKSPACE, actualWorkspaceSize, sizeof(actualWorkspaceSize))
        workspace = ROCVector{UInt8}(undef, actualWorkspaceSize[])

        obj = new(plan_ref[], workspace, required_scalar_type[])
        finalizer(AMDGPU.unsafe_free!, obj)
        return obj
    end
end

Base.show(io::IO, plan::hipTensorPlan) = @printf(io, "hipTensorPlan(%p)", plan.handle)

Base.unsafe_convert(::Type{hiptensorPlan_t}, plan::hipTensorPlan) = plan.handle

Base.:(==)(a::hipTensorPlan, b::hipTensorPlan) = a.handle == b.handle
Base.hash(plan::hipTensorPlan, h::UInt) = hash(plan.handle, h)

# destroying the plan
unsafe_destroy!(plan::hipTensorPlan) = hiptensorDestroyPlan(plan)

# freeing the plan and associated workspace
function AMDGPU.unsafe_free!(plan::hipTensorPlan)
    if plan.workspace != C_NULL
        AMDGPU.unsafe_free!(plan.workspace)
    end
    if plan.handle != C_NULL
        unsafe_destroy!(plan)
        plan.handle = C_NULL
    end
end


const HIPTENSOR_ALIGNMENT = UInt32(1)

## descriptor

mutable struct hipTensorDescriptor
    handle::hiptensorTensorDescriptor_t
    # inner constructor handles creation and finalizer of the descriptor
    function hipTensorDescriptor(sz::Vector{Int64}, st::Vector{Int64}, eltype::DataType,
                                alignmentRequirement::UInt32=HIPTENSOR_ALIGNMENT)
        desc = Ref{hiptensorTensorDescriptor_t}(C_NULL)
        length(st) == (N = length(sz)) || throw(ArgumentError("size and stride vectors must have the same length"))
        T = convert(hiptensorDataType_t, eltype)
        hiptensorCreateTensorDescriptor(handle(), desc, UInt32(N), sz, st, T, alignmentRequirement)
        obj = new(desc[])
        finalizer(unsafe_destroy!, obj)
        return obj
    end
end

# outer constructor restricted to DenseROCArray, but could be extended
function hipTensorDescriptor(a::DenseROCArray; size=size(a), strides=strides(a), eltype=eltype(a))
    sz = collect(Int64, size)
    st = collect(Int64, strides)
    return hipTensorDescriptor(sz, st, eltype)
end

Base.show(io::IO, desc::hipTensorDescriptor) = @printf(io, "hipTensorDescriptor(%p)", desc.handle)

Base.unsafe_convert(::Type{hiptensorTensorDescriptor_t}, obj::hipTensorDescriptor) = obj.handle

unsafe_destroy!(obj::hipTensorDescriptor) = hiptensorDestroyTensorDescriptor(obj)


## tensor

export hipTensor

mutable struct hipTensor{T, N}
    data::ROCArray{T, N}
    inds::Vector{Int32}

    function hipTensor{T, N}(data::ROCArray{T,N}, inds::Vector) where {T<:Number, N}
        if length(inds) != N
            throw(ArgumentError("The number of indices must match the number of dimensions of the data."))
        end
        if !iszero(UInt(pointer(data)) % HIPTENSOR_ALIGNMENT)
            @warn "The data for this hipTensor does not obey the hipTENSOR alignment requirement of $HIPTENSOR_ALIGNMENT. An explicit copy will be made to ensure the requirement is met."
            return new(copy(data), inds)
        else
            return new(data, inds)
        end
    end
end

hipTensor(data::ROCArray{T,N}, inds::Vector) where {T<:Number, N} =
    hipTensor{T,N}(data, inds)

# array interface
Base.size(T::hipTensor) = size(T.data)
Base.size(T::hipTensor, i) = size(T.data, i)
Base.length(T::hipTensor) = length(T.data)
Base.ndims(T::hipTensor) = length(T.inds)
Base.strides(T::hipTensor) = strides(T.data)
Base.eltype(T::hipTensor) = eltype(T.data)
Base.similar(T::hipTensor{Tv, N}) where {Tv, N} = hipTensor{Tv, N}(similar(T.data), copy(T.inds))
Base.copy(T::hipTensor{Tv, N}) where {Tv, N} = hipTensor{Tv, N}(copy(T.data), copy(T.inds))
Base.collect(T::hipTensor) = (collect(T.data), T.inds)
