## data types

# note that, unlike cuTENSOR, hipTENSOR wants a *complex* compute descriptor for complex
# operands: pairing e.g. ComplexF32 tensors with HIPTENSOR_COMPUTE_DESC_32F makes
# `hiptensorCreatePlan` fail with HIPTENSOR_STATUS_EXECUTION_FAILED
const contraction_compute_types = Dict(
    # typeA,     typeB,      typeC       => typeCompute
    (Float16,    Float16,    Float16)    => Float32,
    (Float32,    Float32,    Float32)    => Float32,
    (Float64,    Float64,    Float64)    => Float64,
    (ComplexF32, ComplexF32, ComplexF32) => ComplexF32,
    (ComplexF64, ComplexF64, ComplexF64) => ComplexF64)

# hipTENSOR 2.2 implements the elementwise, permutation and reduction operations for real,
# uniformly typed operands only; every other combination (mixed precision, or any complex
# operand) is rejected with HIPTENSOR_STATUS_NOT_SUPPORTED when the plan is created
const elementwise_trinary_compute_types = Dict(
    # typeA,     typeB,      typeC       => typeCompute
    (Float16,    Float16,    Float16)    => Float16,
    (Float32,    Float32,    Float32)    => Float32,
    (Float64,    Float64,    Float64)    => Float64)

const elementwise_binary_compute_types = Dict(
    # typeA,     typeC       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float32,    Float32)    => Float32,
    (Float64,    Float64)    => Float64)

const permutation_compute_types = Dict(
    # typeA,     typeB       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float32,    Float32)    => Float32)

const reduction_compute_types = Dict(
    # typeA,     typeC       => typeCompute
    (Float16,    Float16)    => Float16,
    (Float32,    Float32)    => Float32,
    (Float64,    Float64)    => Float64)

# report an unsupported combination of element types up front, rather than letting the
# lookup fail with a bare KeyError
function default_compute_type(table, operation, eltypes)
    haskey(table, eltypes) || throw(ArgumentError(
        "hipTENSOR $(version()) does not support a tensor $operation with element types " *
        join(eltypes, ", ") * ". Supported combinations are: " *
        join(map(k -> join(k, ", "), sort!(collect(keys(table)); by=string)), "; ") * "."))
    return table[eltypes]
end

# unlike cuTENSOR, where the compute descriptor is an opaque pointer, hipTENSOR's is a
# plain enum, so a Julia type maps directly onto a `hiptensorComputeDescriptor_t` value
function Base.convert(::Type{hiptensorComputeDescriptor_t}, T::DataType)
    if T == Float16
        return HIPTENSOR_COMPUTE_DESC_16F
    elseif T == BFloat16
        return HIPTENSOR_COMPUTE_DESC_16BF
    elseif T == Float32
        return HIPTENSOR_COMPUTE_DESC_32F
    elseif T == ComplexF32
        return HIPTENSOR_COMPUTE_DESC_C32F
    elseif T == Float64
        return HIPTENSOR_COMPUTE_DESC_64F
    elseif T == ComplexF64
        return HIPTENSOR_COMPUTE_DESC_C64F
    elseif T == Int8
        return HIPTENSOR_COMPUTE_DESC_8I
    elseif T == UInt8
        return HIPTENSOR_COMPUTE_DESC_8U
    elseif T == Int32
        return HIPTENSOR_COMPUTE_DESC_32I
    elseif T == UInt32
        return HIPTENSOR_COMPUTE_DESC_32U
    else
        throw(ArgumentError("hiptensorComputeDescriptor equivalent for input type $T does not exist!"))
    end
end

# the Julia type a compute descriptor stands for
function julia_type(desc::hiptensorComputeDescriptor_t)
    if desc == HIPTENSOR_COMPUTE_DESC_16F
        return Float16
    elseif desc == HIPTENSOR_COMPUTE_DESC_16BF
        return BFloat16
    elseif desc == HIPTENSOR_COMPUTE_DESC_32F
        return Float32
    elseif desc == HIPTENSOR_COMPUTE_DESC_C32F
        return ComplexF32
    elseif desc == HIPTENSOR_COMPUTE_DESC_64F
        return Float64
    elseif desc == HIPTENSOR_COMPUTE_DESC_C64F
        return ComplexF64
    elseif desc == HIPTENSOR_COMPUTE_DESC_8I
        return Int8
    elseif desc == HIPTENSOR_COMPUTE_DESC_8U
        return UInt8
    elseif desc == HIPTENSOR_COMPUTE_DESC_32I
        return Int32
    elseif desc == HIPTENSOR_COMPUTE_DESC_32U
        return UInt32
    else
        throw(ArgumentError("Julia type equivalent for compute descriptor $desc does not exist!"))
    end
end

compute_descriptor(T::DataType) = convert(hiptensorComputeDescriptor_t, T)
compute_descriptor(desc::hiptensorComputeDescriptor_t) = desc

# hipTENSOR 2.2 does not implement `hiptensorOperationDescriptorGetAttribute` for
# `HIPTENSOR_OPERATION_DESCRIPTOR_SCALAR_TYPE`: it reports success without ever writing to
# the output buffer. Determine the type of the α/β/γ scalars ourselves instead. They are
# passed in the compute type (as documented for e.g. `hiptensorContract`), widened to
# complex whenever one of the operands is complex.
function scalar_type(desc::hiptensorComputeDescriptor_t, eltypes::DataType...)
    T = julia_type(desc)
    return any(T′ -> T′ <: Complex, eltypes) ? complex(T) : T
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

function julia_type(T::hiptensorDataType_t)
    if T == HIPTENSOR_R_16F
        return Float16
    elseif T == HIPTENSOR_R_16BF
        return BFloat16
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

# unlike cuTENSOR, hipTENSOR 2.2 does not copy the objects a plan is built from: the plan
# only stores pointers to the operation descriptor, the plan preference, the tensor
# descriptors and even the mode arrays, and dereferences them again on every execution.
# Destroying or garbage collecting any of those before the plan is done with them results
# in anything from a HIPTENSOR_STATUS_NOT_SUPPORTED to a segfault, so the plan takes
# ownership of all of them and only releases them when it is freed itself.
mutable struct hipTensorPlan
    handle::hiptensorPlan_t
    workspace::ROCVector{UInt8,Mem.HIPBuffer}
    scalar_type::DataType
    desc::hiptensorOperationDescriptor_t
    pref::hiptensorPlanPreference_t
    # tensor descriptors and mode arrays `desc` points into
    refs::Vector{Any}

    function hipTensorPlan(desc, pref, scalar_type::DataType, refs::Vector{Any};
                           workspacePref=HIPTENSOR_WORKSPACE_DEFAULT)
        # estimate the workspace size
        workspaceSizeEstimate = Ref{UInt64}(0)
        hiptensorEstimateWorkspaceSize(handle(), desc, pref, workspacePref, workspaceSizeEstimate)

        # create the plan
        plan_ref = Ref{hiptensorPlan_t}()
        hiptensorCreatePlan(handle(), plan_ref, desc, pref, workspaceSizeEstimate[])

        # allocate the actual workspace
        actualWorkspaceSize = Ref{UInt64}(0)
        hiptensorPlanGetAttribute(handle(), plan_ref[], HIPTENSOR_PLAN_REQUIRED_WORKSPACE, actualWorkspaceSize, sizeof(actualWorkspaceSize))
        workspace = ROCVector{UInt8}(undef, actualWorkspaceSize[])

        obj = new(plan_ref[], workspace, scalar_type, desc, pref, refs)
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

# freeing the plan, the objects it was built from, and the associated workspace.
# the order matters: the plan dereferences all of them, so it has to go first.
function AMDGPU.unsafe_free!(plan::hipTensorPlan)
    AMDGPU.unsafe_free!(plan.workspace)
    if plan.handle != C_NULL
        unsafe_destroy!(plan)
        plan.handle = C_NULL
    end
    if plan.desc != C_NULL
        hiptensorDestroyOperationDescriptor(plan.desc)
        plan.desc = hiptensorOperationDescriptor_t(C_NULL)
    end
    if plan.pref != C_NULL
        hiptensorDestroyPlanPreference(plan.pref)
        plan.pref = hiptensorPlanPreference_t(C_NULL)
    end
    for ref in plan.refs
        ref isa hipTensorDescriptor && unsafe_destroy!(ref)
    end
    empty!(plan.refs)
    return
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

# a descriptor owned by a plan is destroyed by that plan, so this has to be idempotent:
# the finalizer will still run afterwards
function unsafe_destroy!(obj::hipTensorDescriptor)
    if obj.handle != C_NULL
        hiptensorDestroyTensorDescriptor(obj.handle)
        obj.handle = hiptensorTensorDescriptor_t(C_NULL)
    end
    return
end


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
