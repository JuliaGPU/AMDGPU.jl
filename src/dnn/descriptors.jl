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

function get(desc::TensorDescriptor)
    nd = ndims(desc)
    dtype = Ref{miopenDataType_t}()
    dims, stride = Vector{Int32}(undef, nd), Vector{Int32}(undef, nd)
    miopenGetTensorDescriptor(
        desc.handle, dtype, dims, stride) |> check
    dtype[], dims, stride
end

mutable struct ConvolutionDescriptor
    handle::miopenConvolutionDescriptor_t
end

function ConvolutionDescriptor(
    n_dims::Int64,
    padding::Vector{Int32}, stride::Vector{Int32},
    dilation::Vector{Int32}, groups::Int64,
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

function get_output_size(
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
