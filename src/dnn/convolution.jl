# TODO free workspace once used

const CONV_ALGOS = Union{
    Type{miopenConvFwdAlgorithm_t},
    Type{miopenConvBwdWeightsAlgorithm_t},
    Type{miopenConvBwdDataAlgorithm_t},
}

# Struct for hashing convolution arguments.
struct ConvolutionArgs
    handle::miopenHandle_t
    dtype::miopenDataType_t
    x_size::NTuple{MIOPEN_DIM_MAX, Int64}
    w_size::NTuple{MIOPEN_DIM_MAX, Int64}
    padding::NTuple{3, Int64}
    stride::NTuple{3, Int64}
    dilation::NTuple{3, Int64}
    groups::Int64
end

function ConvolutionArgs(
    x::ROCArray{T, N}, w::ROCArray{T, N};
    handle, padding, stride, dilation, groups,
) where {T, N}
    expand(v, ndims) = ntuple(
        i -> (i ≤ length(v)) ? Int64(v[i]) : 0, Val{ndims}())
    dtype = miopen_data_type(T)
    x_size = expand(size(x), MIOPEN_DIM_MAX)
    w_size = expand(size(w), MIOPEN_DIM_MAX)
    ConvolutionArgs(
        handle, dtype, x_size, w_size, expand(padding, 3),
        expand(stride, 3), expand(dilation, 3), groups)
end

const CONV_FWD_BENCHMARK_CACHE = LockedObject(Dict{ConvolutionArgs, miopenConvAlgoPerf_t}())
const CONV_BWD_WEIGHT_BENCHMARK_CACHE = LockedObject(Dict{ConvolutionArgs, miopenConvAlgoPerf_t}())
const CONV_BWD_DATA_BENCHMARK_CACHE = LockedObject(Dict{ConvolutionArgs, miopenConvAlgoPerf_t}())

get_conv_cache_type(::Type{miopenConvFwdAlgorithm_t}) = CONV_FWD_BENCHMARK_CACHE
get_conv_cache_type(::Type{miopenConvBwdDataAlgorithm_t}) = CONV_BWD_DATA_BENCHMARK_CACHE
get_conv_cache_type(::Type{miopenConvBwdWeightsAlgorithm_t}) = CONV_BWD_WEIGHT_BENCHMARK_CACHE

function get_benchmark_cache(conv_type::C, conv_args, dev) where C <: CONV_ALGOS
    perf_results = lock(get_conv_cache_type(conv_type)) do cache
        get(cache, conv_args, nothing)
    end
    isnothing(perf_results) && return nothing
    workspace = Workspace(dev, perf_results.memory)
    perf_results, workspace
end

function set_benchmark_cache!(conv_type::C, conv_args, perf_results) where C <: CONV_ALGOS
    lock(get_conv_cache_type(conv_type)) do cache
        cache[conv_args] = perf_results
    end
    nothing
end

get_workspace_size_func(::Type{miopenConvFwdAlgorithm_t}) = miopenConvolutionForwardGetWorkSpaceSize
get_workspace_size_func(::Type{miopenConvBwdWeightsAlgorithm_t}) = miopenConvolutionBackwardWeightsGetWorkSpaceSize
get_workspace_size_func(::Type{miopenConvBwdDataAlgorithm_t}) = miopenConvolutionBackwardDataGetWorkSpaceSize

function get_workspace_size(
    conv_type::C; handle, a_desc, b_desc, conv_desc, c_desc,
) where C <: CONV_ALGOS
    wsize_ref = Ref{Csize_t}(0)
    get_workspace_size_func(conv_type)(
        handle, a_desc.handle, b_desc.handle,
        conv_desc.handle, c_desc.handle, wsize_ref) |> check
    wsize_ref[]
end

get_conv_algo_finder(::Type{miopenConvFwdAlgorithm_t}) = miopenFindConvolutionForwardAlgorithm
get_conv_algo_finder(::Type{miopenConvBwdWeightsAlgorithm_t}) = miopenFindConvolutionBackwardWeightsAlgorithm
get_conv_algo_finder(::Type{miopenConvBwdDataAlgorithm_t}) = miopenFindConvolutionBackwardDataAlgorithm

function find_conv_algo(
    conv_type::C;
    handle, workspace, a, a_desc, b, b_desc, conv_desc, c, c_desc,
    n_algos = 1, exhaustive_search::Bool = false,
) where C <: CONV_ALGOS
    perf_count_ref = Ref{Int32}(0)
    perf_results_ref = Ref{miopenConvAlgoPerf_t}()
    get_conv_algo_finder(conv_type)(
        handle, a_desc.handle, a, b_desc.handle, b,
        conv_desc.handle, c_desc.handle, c, n_algos,
        perf_count_ref, perf_results_ref,
        workspace.data.ptr, workspace.data.bytesize,
        exhaustive_search) |> check
    perf_results_ref[]
end

function find_algorithm(
    conv_type::C, handle::miopenHandle_t, conv_args::ConvolutionArgs,
    a, a_desc, b, b_desc, conv_desc, c, c_desc,
) where C <: CONV_ALGOS
    dev = GPUArrays.device(a)
    cache = get_benchmark_cache(conv_type, conv_args, dev)
    isnothing(cache) || return cache

    workspace = Workspace(dev, 0)
    perf_results = find_conv_algo(conv_type;
        handle, workspace, a, a_desc, b, b_desc, conv_desc, c, c_desc)
    set_benchmark_cache!(conv_type, conv_args, perf_results)
    workspace = Workspace(dev, perf_results.memory)

    perf_results, workspace
end

function _check_conv_args_dims(K, N)
    K == N - 2 && return nothing
    throw(ArgumentError(
        "Convolution arguments (`padding`, `stride`, `dilation`) must have " *
        "K = N - 2 dimensions, instead:\n" *
        "- N=$N (input ndims)\n" *
        "- K=$K (conv args ndims)\n"))
end

function convolution!(
    y::ROCArray{T, N}, ydesc::TensorDescriptor,
    x::ROCArray{T, N}, xdesc::TensorDescriptor,
    w::ROCArray{T, N}, wdesc::TensorDescriptor,
    cdesc::ConvolutionDescriptor, conv_args::ConvolutionArgs,
) where {T <: MIOPENFloat, N}
    hdl = handle()
    perf_results, workspace = find_algorithm(
        miopenConvFwdAlgorithm_t, hdl, conv_args,
        x, xdesc, w, wdesc, cdesc, y, ydesc)

    AMDGPU.wait!((x, y, w))
    miopenConvolutionForward(
        hdl, Ref{Float32}(1f0), xdesc.handle, x, wdesc.handle, w, cdesc.handle,
        perf_results.fwd_algo, Ref{Float32}(0f0), ydesc.handle, y,
        workspace.data.ptr, perf_results.memory) |> check
    AMDGPU.mark!(y, C_NULL)
    y
end

function convolution!(
    y::ROCArray{T, N}, x::ROCArray{T, N}, w::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    xdesc, wdesc, ydesc = TensorDescriptor.((x, w, y))
    cdesc = ConvolutionDescriptor(ndims(xdesc) - 2; padding, stride, dilation, groups)
    conv_args = ConvolutionArgs(x, w; handle=handle(), groups, padding, stride, dilation)
    convolution!(y, ydesc, x, xdesc, w, wdesc, cdesc, conv_args)
end

function convolution(
    x::ROCArray{T, N}, w::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    xdesc, wdesc = TensorDescriptor.((x, w))
    cdesc = ConvolutionDescriptor(ndims(xdesc) - 2; padding, stride, dilation, groups)
    conv_args = ConvolutionArgs(x, w; handle=handle(), groups, padding, stride, dilation)
    y = similar(x, T, output_size(cdesc, xdesc, wdesc))
    convolution!(y, TensorDescriptor(y), x, xdesc, w, wdesc, cdesc, conv_args)
end

function ∇convolution_weight!(
    ∇w::ROCArray{T, N}, ∇wdesc::TensorDescriptor,
    dy::ROCArray{T, N}, dydesc::TensorDescriptor,
    x::ROCArray{T, N}, xdesc::TensorDescriptor,
    cdesc::ConvolutionDescriptor, conv_args::ConvolutionArgs,
) where {T <: MIOPENFloat, N}
    hdl = handle()
    perf_algo, workspace = find_algorithm(
        miopenConvBwdWeightsAlgorithm_t, hdl, conv_args,
        dy, dydesc, x, xdesc, cdesc, ∇w, ∇wdesc)
    AMDGPU.wait!((∇w, dy, x))
    miopenConvolutionBackwardWeights(
        hdl, Ref{Float32}(1f0), dydesc.handle, dy, xdesc.handle, x, cdesc.handle,
        perf_algo.bwd_weights_algo, Ref{Float32}(0f0), ∇wdesc.handle, ∇w,
        workspace.data.ptr, perf_algo.memory) |> check
    AMDGPU.mark!(∇w, C_NULL)
    ∇w
end

function ∇convolution_weight!(
    ∇w::ROCArray{T, N}, dy::ROCArray{T, N}, x::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    xdesc, ∇wdesc, dydesc = TensorDescriptor.((x, ∇w, dy))
    cdesc = ConvolutionDescriptor(ndims(xdesc) - 2; padding, stride, dilation, groups)
    conv_args = ConvolutionArgs(x, ∇w; handle=handle(), groups, padding, stride, dilation)
    ∇convolution_weight!(∇w, ∇wdesc, dy, dydesc, x, xdesc, cdesc, conv_args)
end

function ∇convolution_weight(
    dy::ROCArray{T, N}, x::ROCArray{T, N}, w::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    xdesc, dydesc = TensorDescriptor.((x, dy))
    cdesc = ConvolutionDescriptor(ndims(xdesc) - 2; padding, stride, dilation, groups)
    ∇w = similar(x, T, size(w))
    conv_args = ConvolutionArgs(x, ∇w; handle=handle(), groups, padding, stride, dilation)
    ∇convolution_weight!(∇w, TensorDescriptor(∇w), dy, dydesc, x, xdesc, cdesc, conv_args)
end

function ∇convolution_data!(
    ∇x::ROCArray{T, N}, ∇xdesc::TensorDescriptor,
    dy::ROCArray{T, N}, dydesc::TensorDescriptor,
    w::ROCArray{T, N}, wdesc::TensorDescriptor,
    cdesc::ConvolutionDescriptor, conv_args::ConvolutionArgs,
) where {T <: MIOPENFloat, N}
    hdl = handle()
    perf_algo, workspace = find_algorithm(
        miopenConvBwdDataAlgorithm_t, hdl, conv_args,
        dy, dydesc, w, wdesc, cdesc, ∇x, ∇xdesc)
    AMDGPU.wait!((∇x, dy, w))
    miopenConvolutionBackwardData(
        hdl, Ref{Float32}(1f0), dydesc.handle, dy, wdesc.handle, w, cdesc.handle,
        perf_algo.bwd_data_algo, Ref{Float32}(0f0), ∇xdesc.handle, ∇x,
        workspace.data.ptr, perf_algo.memory) |> check
    AMDGPU.mark!(∇x, C_NULL)
    ∇x
end

function ∇convolution_data!(
    ∇x::ROCArray{T, N}, dy::ROCArray{T, N}, w::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    wdesc, ∇xdesc, dydesc = TensorDescriptor.((w, ∇x, dy))
    cdesc = ConvolutionDescriptor(ndims(∇xdesc) - 2; padding, stride, dilation, groups)
    conv_args = ConvolutionArgs(∇x, w; handle=handle(), groups, padding, stride, dilation)
    ∇convolution_data!(∇x, ∇xdesc, dy, dydesc, w, wdesc, cdesc, conv_args)
end

function ∇convolution_data(
    dy::ROCArray{T, N}, x::ROCArray{T, N}, w::ROCArray{T, N};
    padding::NTuple{K, Int}, stride::NTuple{K, Int},
    dilation::NTuple{K, Int}, groups::Int,
) where {T <: MIOPENFloat, N, K}
    _check_conv_args_dims(K, N)
    wdesc, dydesc = TensorDescriptor.((w, dy))
    cdesc = ConvolutionDescriptor(ndims(dydesc) - 2; padding, stride, dilation, groups)
    ∇x = similar(x, T, size(x))
    conv_args = ConvolutionArgs(∇x, w; handle=handle(), groups, padding, stride, dilation)
    ∇convolution_data!(∇x, TensorDescriptor(∇x), dy, dydesc, w, wdesc, cdesc, conv_args)
end

# Non-unicode stubs.

convolution_bwd_weight!(args...; kwargs...) = ∇convolution_weight!(args...; kwargs...)
convolution_bwd_weight(args...; kwargs...) = ∇convolution_weight(args...; kwargs...)

convolution_bwd_data!(args...; kwargs...) = ∇convolution_data!(args...; kwargs...)
convolution_bwd_data(args...; kwargs...) = ∇convolution_data(args...; kwargs...)
