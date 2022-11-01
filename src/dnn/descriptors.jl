const MIOPEN_DIM_MAX = 5

function check_ndims(x)
    if ndims(x) > MIOPEN_DIM_MAX
        error(
            "MIOpen supports only up to `$MIOPEN_DIM_MAX` dimensions.\n" *
            "Tensor has `$(ndims(x))` dimensions.")
    end
end

mutable struct TensorDescriptor
    handle::miopenTensorDescriptor_t
    dtype::miopenDataType_t
end

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
    dtype = get_miopen_data_type(T)
    sizes = Int32[size(x)...]
    # NOTE strides are in reversed order.
    strides_ = Int32[strides(x)[end:-1:1]...]
    TensorDescriptor(dtype, ndims(x), sizes, strides_)
end

mutable struct ConvolutionDescriptor
    handle::miopenConvolutionDescriptor_t
end

function ConvolutionDescriptor(
    dims::Int64,
    padding::Vector{Int32}, stride::Vector{Int32},
    dilation::Vector{Int32}, groups::Int64,
)
    handle_ref = Ref{miopenConvolutionDescriptor_t}()
    miopenCreateConvolutionDescriptor(handle_ref) |> check

    handle = handle_ref[]
    miopenInitConvolutionNdDescriptor(
        handle,
        dims, padding, stride, dilation,
        miopenConvolution) |> check
    miopenSetConvolutionGroupCount(handle, groups) |> check
    d = ConvolutionDescriptor(handle)

    finalizer(d) do d_
        miopenDestroyConvolutionDescriptor(d_.handle) |> check
    end
    d
end
