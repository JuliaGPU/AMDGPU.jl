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

function ConvolutionArgs(x, w; handle, padding, stride, dilation, groups)
    expand(v, ndims) = ntuple(i -> (i ≤ length(v)) ? v[i] : 0, Val{ndims}())
    dtype = get_miopen_data_type(eltype(x))

    x_size = expand(size(x), MIOPEN_DIM_MAX)
    w_size = expand(size(w), MIOPEN_DIM_MAX)
    ConvolutionArgs(
        handle, dtype, x_size, w_size, expand(padding, 3),
        expand(stride, 3), expand(dilation, 3), groups)
end

const CONV_FWD_BENCHMARK_CACHE = Dict{ConvolutionArgs, miopenConvAlgoPerf_t}()
const CONV_BWD_WEIGHT_BENCHMARK_CACHE = Dict{ConvolutionArgs, miopenConvAlgoPerf_t}()
const CONV_BWD_DATA_BENCHMARK_CACHE = Dict{ConvolutionArgs, miopenConvAlgoPerf_t}()

get_conv_cache_type(::Type{miopenConvFwdAlgorithm_t}) = CONV_FWD_BENCHMARK_CACHE
get_conv_cache_type(::Type{miopenConvBwdDataAlgorithm_t}) = CONV_BWD_DATA_BENCHMARK_CACHE
get_conv_cache_type(::Type{miopenConvBwdWeightsAlgorithm_t}) = CONV_BWD_WEIGHT_BENCHMARK_CACHE

function get_benchmark_cache(conv_type::C, conv_args, dev) where C <: CONV_ALGOS
    # TODO lock
    cache = get_conv_cache_type(conv_type)
    conv_args in keys(cache) || return nothing

    perf_results = cache[conv_args]
    workspace = Workspace(dev, perf_results.memory)
    perf_results, workspace
end

function set_benchmark_cache!(conv_type::C, conv_args, perf_results) where C <: CONV_ALGOS
    # TODO lock
    cache = get_conv_cache_type(conv_type)
    cache[conv_args] = perf_results
    nothing
end

mutable struct Workspace
    data::Mem.Buffer
    function Workspace(device::ROCDevice, bytesize)
        w = new(Mem.alloc(device, bytesize))
        finalizer(w_ -> Mem.free(w_.data), w)
        w
    end
end

get_workspace_size_func(::Type{miopenConvFwdAlgorithm_t}) = miopenConvolutionForwardGetWorkSpaceSize
get_workspace_size_func(::Type{miopenConvBwdWeightsAlgorithm_t}) = miopenConvolutionBackwardWeightsGetWorkSpaceSize
get_workspace_size_func(::Type{miopenConvBwdDataAlgorithm_t}) = miopenConvolutionBackwardDataGetWorkSpaceSize

function get_workspace_size(
    conv_type; handle, a_desc, b_desc, conv_desc, c_desc,
)
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
    n_algos = 1, do_exhaustive_search::Bool = false
) where C <: CONV_ALGOS
    perf_count_ref = Ref{Int32}(0)
    perf_results_ref = Ref{miopenConvAlgoPerf_t}()
    get_conv_algo_finder(conv_type)(
        handle, a_desc.handle, a, b_desc.handle, b,
        conv_desc.handle, c_desc.handle, c, n_algos,
        perf_count_ref, perf_results_ref,
        workspace.data.ptr, workspace.data.bytesize,
        do_exhaustive_search) |> check
    perf_results_ref[]
end

function find_algorithm(
    conv_type::C, handle::miopenHandle_t, conv_args::ConvolutionArgs,
    a, a_desc, b, b_desc, conv_desc, c, c_desc,
) where C <: CONV_ALGOS
    @show conv_type, typeof(conv_type)

    dev = GPUArrays.device(a)
    cache = get_benchmark_cache(conv_type, conv_args, dev)
    isnothing(cache) || return cache

    is_fwd = conv_type == Type{miopenConvFwdAlgorithm_t}
    workspace_size = get_workspace_size(conv_type;
        handle, a_desc=(is_fwd ? b_desc : a_desc),
        b_desc=(is_fwd ? a_desc : b_desc), conv_desc, c_desc)

    workspace = Workspace(dev, workspace_size)
    perf_results = find_conv_algo(conv_type;
        handle, workspace, a, a_desc, b, b_desc, conv_desc, c, c_desc)
    set_benchmark_cache!(conv_type, conv_args, perf_results)

    perf_results, workspace
end

function convolution!(
    y::ROCArray{T}, x::ROCArray{T}, w::ROCArray{T};
    padding, stride, dilation, groups,
) where T
    padding_i32 = Int32[padding...]
    stride_i32 = Int32[stride...]
    dilation_i32 = Int32[dilation...]

    # TODO check that it is in NCHW
    # TODO check that device is the same

    x_desc, w_desc, y_desc = TensorDescriptor.((x, w, y))
    conv_desc = ConvolutionDescriptor(
        ndims(x) - 2, padding_i32, stride_i32, dilation_i32, groups)

    handle = get_handle()
    conv_args = ConvolutionArgs(
        x, w; handle, groups, padding=padding_i32,
        stride=stride_i32, dilation=dilation_i32)
    perf_results, workspace = find_algorithm(
        miopenConvFwdAlgorithm_t, handle, conv_args,
        x, x_desc, w, w_desc, conv_desc, y, y_desc)

    alpha, beta = Ref{T}(one(T)), Ref{T}(zero(T))
    miopenConvolutionForward(
        handle, alpha, x_desc.handle, x, w_desc.handle, w, conv_desc.handle,
        perf_results.fwd_algo, beta, y_desc.handle, y,
        workspace.data.ptr, perf_results.memory) |> check
    y
end

function ∇convolution_weight!(
    ∇w::ROCArray{T}, Δ::ROCArray{T}, x::ROCArray{T};
    padding, stride, dilation, groups,
) where T
    padding_i32 = Int32[padding...]
    stride_i32 = Int32[stride...]
    dilation_i32 = Int32[dilation...]

    x_desc, ∇w_desc, Δ_desc = TensorDescriptor.((x, ∇w, Δ))
    conv_desc = ConvolutionDescriptor(
        ndims(x) - 2, padding_i32, stride_i32, dilation_i32, groups)

    handle = get_handle()
    conv_args = ConvolutionArgs(
        x, ∇w; handle, groups, padding=padding_i32,
        stride=stride_i32, dilation=dilation_i32)
    perf_algo, workspace = find_algorithm(
        miopenConvBwdWeightsAlgorithm_t, handle, conv_args,
        Δ, Δ_desc, x, x_desc, conv_desc, ∇w, ∇w_desc)

    alpha, beta = Ref{T}(one(T)), Ref{T}(zero(T))
    miopenConvolutionBackwardWeights(
        handle, alpha, Δ_desc.handle, Δ, x_desc.handle, x, conv_desc.handle,
        perf_algo.bwd_weights_algo, beta, ∇w_desc.handle, ∇w,
        workspace.data.ptr, perf_algo.memory) |> check
    ∇w
end

function ∇convolution_data!(
    ∇x::ROCArray{T}, Δ::ROCArray{T}, w::ROCArray{T};
    padding, stride, dilation, groups,
) where T
    padding_i32 = Int32[padding...]
    stride_i32 = Int32[stride...]
    dilation_i32 = Int32[dilation...]

    w_desc, ∇x_desc, Δ_desc = TensorDescriptor.((w, ∇x, Δ))
    conv_desc = ConvolutionDescriptor(
        ndims(∇x) - 2, padding_i32, stride_i32, dilation_i32, groups)

    handle = get_handle()
    conv_args = ConvolutionArgs(
        ∇x, w; handle, groups, padding=padding_i32,
        stride=stride_i32, dilation=dilation_i32)

    perf_algo, workspace = find_algorithm(
        miopenConvBwdDataAlgorithm_t, handle, conv_args,
        Δ, Δ_desc, w, w_desc, conv_desc, ∇x, ∇x_desc)

    alpha, beta = Ref{T}(one(T)), Ref{T}(zero(T))
    miopenConvolutionBackwardData(
        handle, alpha, Δ_desc.handle, Δ, w_desc.handle, w, conv_desc.handle,
        perf_algo.bwd_data_algo, beta, ∇x_desc.handle, ∇x,
        workspace.data.ptr, perf_algo.memory) |> check
    ∇x
end

# TODO test them
# TODO add format checks
# TODO figure out WHCN format (simply reshape?)

function main()
    @show get_version()

    x = AMDGPU.rand(Float32, 1, 3, 16, 16)
    w = AMDGPU.rand(Float32, 2, 3, 3, 3)
    y = AMDGPU.zeros(Float32, 1, 2, 14, 14)

    Δ = AMDGPU.rand(Float32, 1, 2, 14, 14)
    ∇w = AMDGPU.zeros(Float32, 2, 3, 3, 3)
    ∇x = AMDGPU.zeros(Float32, 1, 3, 16, 16)

    @time convolution!(y, x, w; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
    @time convolution!(y, x, w; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)

    @time ∇convolution_weight!(∇w, Δ, x; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
    @time ∇convolution_weight!(∇w, Δ, x; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)

    @time ∇convolution_data!(∇x, Δ, w; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
    @time ∇convolution_data!(∇x, Δ, w; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)

    nothing
end
