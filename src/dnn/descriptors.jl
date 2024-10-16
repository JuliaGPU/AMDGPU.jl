const MIOPEN_DIM_MAX = 5

function check_ndims(x)
    if ndims(x) > MIOPEN_DIM_MAX
        throw(DimensionMismatch(
            "MIOpen supports only up to `$MIOPEN_DIM_MAX` dimensions.\n" *
            "Tensor has `$(ndims(x))` dimensions."))
    end
end

mutable struct TensorDescriptor
    handle::miopenTensorDescriptor_t
    dtype::miopenDataType_t
end

"""
    TensorDescriptor(
        dtype::miopenDataType_t, dims::Int64,
        sizes::Vector{Int32}, strides::Vector{Int32})

# Arguments:

- `sizes::Vector{Int32}`: Dimensions of the tensor in reversed order,
    i.e. `reverse(size(x))`.
- `strides::Vector{Int32}`: Strides of the tensor in reversed order,
    i.e. `reverse(strides(x))`.
"""
function TensorDescriptor(
    dtype::miopenDataType_t, dims::Int64,
    sizes::Vector{Int32}, strides::Vector{Int32},
)
    handle_ref = Ref{miopenTensorDescriptor_t}()
    miopenCreateTensorDescriptor(handle_ref)

    handle = handle_ref[]
    miopenSetTensorDescriptor(handle, dtype, dims, sizes, strides)
    d = TensorDescriptor(handle, dtype)
    return finalizer(d) do d
        miopenDestroyTensorDescriptor(d.handle)
    end
end

function TensorDescriptor(x::ROCArray{T}) where T
    check_ndims(x)
    dtype = miopen_data_type(T)
    # NOTE: Dims and strides are reversed to support WHCN convolutions.
    sizes = Int32[reverse(size(x))...]
    strides_ = Int32[reverse(strides(x))...]
    TensorDescriptor(dtype, ndims(x), sizes, strides_)
end

Base.ndims(desc::TensorDescriptor) = Base.ndims(desc.handle)
function Base.ndims(handle::miopenTensorDescriptor_t)
    nd = Ref{Int32}(0)
    miopenGetTensorDescriptorSize(handle, nd)
    Int64(nd[])
end

unpack(desc::TensorDescriptor) = unpack(desc.handle, ndims(desc))
function unpack(handle::miopenTensorDescriptor_t, nd::Integer)
    dtype = Ref{miopenDataType_t}()
    dims, stride = Vector{Int32}(undef, nd), Vector{Int32}(undef, nd)
    miopenGetTensorDescriptor(handle, dtype, dims, stride)
    dtype[], dims, stride
end

mutable struct ConvolutionDescriptor
    handle::miopenConvolutionDescriptor_t
end

"""
    ConvolutionDescriptor(
        n_dims::Int64,
        padding::Vector{Int32}, stride::Vector{Int32},
        dilation::Vector{Int32}, groups::Int64)

Low-level constructor. Users should be using one with keyword arguments.

# Arguments:

- `padding::Vector{Int32}`: Convolution padding in reversed order.
- `stride::Vector{Int32}`: Convolution stride in reversed order.
- `dilation::Vector{Int32}`: Convolution dilation in reversed order.
"""
function ConvolutionDescriptor(
    n_dims::Int32, padding::Vector{Int32}, stride::Vector{Int32},
    dilation::Vector{Int32}, groups::Int32,
)
    handle_ref = Ref{miopenConvolutionDescriptor_t}()
    miopenCreateConvolutionDescriptor(handle_ref)

    handle = handle_ref[]
    miopenInitConvolutionNdDescriptor(
        handle, n_dims, padding, stride, dilation, miopenConvolution)
    miopenSetConvolutionGroupCount(handle, groups)
    d = ConvolutionDescriptor(handle)
    return finalizer(d) do d
        miopenDestroyConvolutionDescriptor(d.handle)
    end
end

"""
    ConvolutionDescriptor(
        n_dims::Integer; padding, stride, dilation, groups::Integer)

# Arguments:

- `padding`: Convolution padding (array or tuple).
- `stride`: Convolution stride (array or tuple).
- `dilation`: Convolution dilation (array or tuple).
"""
function ConvolutionDescriptor(
    n_dims::Integer; padding, stride, dilation, groups::Integer,
)
    ConvolutionDescriptor(
        Int32(n_dims), Int32[reverse(padding)...], Int32[reverse(stride)...],
        Int32[reverse(dilation)...], Int32(groups))
end

function output_size(
    cdesc::ConvolutionDescriptor,
    idesc::TensorDescriptor, wdesc::TensorDescriptor,
)
    nd = ndims(idesc)
    out_nd = Ref{Int32}()
    out_dims = Vector{Int32}(undef, nd)
    miopenGetConvolutionNdForwardOutputDim(
        cdesc.handle, idesc.handle, wdesc.handle, out_nd, out_dims)
    @assert nd == out_nd[]
    NTuple{nd, Int32}(reverse(out_dims[1:out_nd[]]))
end

mutable struct PoolingDescriptor
    handle::miopenPoolingDescriptor_t
end

function PoolingDescriptor(
    mode::miopenPoolingMode_t, n_dims::Int32,
    dims::Vector{Int32}, padding::Vector{Int32}, stride::Vector{Int32},
)
    handle_ref = Ref{miopenPoolingDescriptor_t}()
    miopenCreatePoolingDescriptor(handle_ref)

    handle = handle_ref[]
    miopenSetNdPoolingDescriptor(
        handle, mode, n_dims, dims, padding, stride)
    miopenSetPoolingIndexType(handle, miopenIndexUint32)
    d = PoolingDescriptor(handle)
    return finalizer(d) do d
        miopenDestroyPoolingDescriptor(d.handle)
    end
end

"""
    PoolingDescriptor(
        mode::miopenPoolingMode_t, n_dims::Integer; dims, padding, stride)

# Arguments:

- `dims`: Pooling window dimensions (array or tuple).
- `padding`: Pooling padding (array or tuple).
- `stride`: Pooling stride (array or tuple).
"""
function PoolingDescriptor(
    mode::miopenPoolingMode_t, n_dims::Integer; dims, padding, stride,
)
    PoolingDescriptor(
        mode, Int32(n_dims), Int32[reverse(dims)...],
        Int32[reverse(padding)...], Int32[reverse(stride)...])
end

function output_size(pdesc::PoolingDescriptor, idesc::TensorDescriptor)
    nd = ndims(idesc)
    out_dims = Vector{Int32}(undef, nd)
    miopenGetPoolingNdForwardOutputDim(
        pdesc.handle, idesc.handle, Int32(nd), out_dims)
    NTuple{nd, Int32}(reverse(out_dims))
end

mutable struct ActivationDescriptor
    handle::miopenActivationDescriptor_t
end

function ActivationDescriptor()
    handle_ref = Ref{miopenActivationDescriptor_t}()
    miopenCreateActivationDescriptor(handle_ref)
    handle = handle_ref[]
    d = ActivationDescriptor(handle)
    return finalizer(d) do d
        miopenDestroyActivationDescriptor(d.handle)
    end
end

function set!(
    d::ActivationDescriptor, mode::miopenActivationMode_t,
    α::Float64, β::Float64, γ::Float64,
)
    miopenSetActivationDescriptor(d.handle, mode, α, β, γ)
end
