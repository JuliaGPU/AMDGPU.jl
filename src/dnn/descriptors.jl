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
    miopenCreateTensorDescriptor(handle_ref) |> check

    handle = handle_ref[]
    miopenSetTensorDescriptor(handle, dtype, dims, sizes, strides) |> check
    d = TensorDescriptor(handle, dtype)

    finalizer(d) do d_
        miopenDestroyTensorDescriptor(d_.handle) |> check
    end
    d
end

function TensorDescriptor(x::ROCArray{T}) where T
    check_ndims(x)
    dtype = miopen_data_type(T)
    # NOTE: Dims and strides are reversed to support WHCN convolutions.
    sizes = Int32[reverse(size(x))...]
    strides_ = Int32[reverse(strides(x))...]
    TensorDescriptor(dtype, ndims(x), sizes, strides_)
end

function Base.ndims(desc::TensorDescriptor)
    nd = Ref{Int32}(0)
    miopenGetTensorDescriptorSize(desc.handle, nd) |> check
    Int64(nd[])
end

function unpack(desc::TensorDescriptor)
    nd = ndims(desc)
    dtype = Ref{miopenDataType_t}()
    dims, stride = Vector{Int32}(undef, nd), Vector{Int32}(undef, nd)
    miopenGetTensorDescriptor(desc.handle, dtype, dims, stride) |> check
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
    miopenCreateConvolutionDescriptor(handle_ref) |> check

    handle = handle_ref[]
    miopenInitConvolutionNdDescriptor(
        handle, n_dims, padding, stride, dilation, miopenConvolution) |> check
    miopenSetConvolutionGroupCount(handle, groups) |> check
    d = ConvolutionDescriptor(handle)

    finalizer(d) do d_
        miopenDestroyConvolutionDescriptor(d_.handle) |> check
    end
    d
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
        cdesc.handle, idesc.handle, wdesc.handle, out_nd, out_dims) |> check
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
    miopenCreatePoolingDescriptor(handle_ref) |> check

    handle = handle_ref[]
    miopenSetNdPoolingDescriptor(
        handle, mode, n_dims, dims, padding, stride) |> check
    miopenSetPoolingIndexType(handle, miopenIndexUint32) |> check
    d = PoolingDescriptor(handle)

    finalizer(d) do d_
        miopenDestroyPoolingDescriptor(d_.handle) |> check
    end
    d
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
        pdesc.handle, idesc.handle, Int32(nd), out_dims) |> check
    NTuple{nd, Int32}(reverse(out_dims))
end
