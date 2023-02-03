# Regular softmax.

softmax(x::T; dims) where T <: ROCArray = softmax!(similar(x), x; dims)

softmax!(y::T, x::T; dims) where T <: ROCArray =
    _softmax!(MIOPEN_SOFTMAX_FAST, y, x; dims)

function ∇softmax(dy::T, y::T; dims) where T <: ROCArray
    ∇softmax!(similar(y), dy, y; dims)
end

function ∇softmax!(dx::T, dy::T, y::T; dims) where T <: ROCArray
    _∇softmax!(MIOPEN_SOFTMAX_FAST, dx, dy, y; dims)
end

# Log-softmax.

logsoftmax(x::T; dims) where T <: ROCArray = logsoftmax!(similar(x), x; dims)

logsoftmax!(y::T, x::T; dims) where T <: ROCArray =
    _softmax!(MIOPEN_SOFTMAX_LOG, y, x; dims)

∇logsoftmax(dy::T, y::T; dims) where T <: ROCArray =
    ∇logsoftmax!(similar(y), dy, y; dims)

∇logsoftmax!(dx::T, dy::T, y::T; dims) where T <: ROCArray =
    _∇softmax!(MIOPEN_SOFTMAX_LOG, dx, dy, y; dims)

# Fallbacks for non-contiguous dims.

function _softmax!(y::T, x::T; dims) where T <: ROCArray
    y .= exp.(x .- maximum(x; dims))
    y ./= sum(y; dims)
end

function _∇softmax!(dx::T, dy::T, y::T; dims) where T <: ROCArray
    dx .= y .* (dy .- sum(dy .* y; dims))
end

function _logsoftmax!(y::T, x::T; dims) where T <: ROCArray
    y .= x .- maximum(x; dims)
    y .-= log.(sum(exp.(y); dims))
end

function _∇logsoftmax!(dx::T, dy::T, y::T; dims) where T <: ROCArray
    dx .= dy .- sum(dy; dims) .* exp.(y)
end

# Generic MIOpen calls.

function _softmax!(
    algo::miopenSoftmaxAlgorithm_t, y::T, x::T; dims,
) where T <: ROCArray
    sdims = _softmax_dims(x; dims)
    if isnothing(sdims)
        return (algo == MIOPEN_SOFTMAX_FAST) ?
            _softmax!(y, x; dims) : _logsoftmax!(y, x; dims)
    end

    AMDGPU.wait!((x, y))
    xdesc, ydesc = TensorDescriptor.((reshape(x, sdims), reshape(y, sdims)))
    miopenSoftmaxForward_V2(
        handle(), Ref{Float32}(1f0), xdesc.handle, x, Ref{Float32}(0f0),
        ydesc.handle, y, algo, MIOPEN_SOFTMAX_MODE_CHANNEL) |> check
    AMDGPU.mark!(y, C_NULL)
    y
end

function _∇softmax!(
    algo::miopenSoftmaxAlgorithm_t, dx::T, dy::T, y::T; dims,
) where T <: ROCArray
    sdims = _softmax_dims(y; dims)
    if isnothing(sdims)
        return (algo == MIOPEN_SOFTMAX_FAST) ?
            _∇softmax!(dx, dy, y; dims) : _∇logsoftmax!(dx, dy, y; dims)
    end

    AMDGPU.wait!((dx, dy, y))
    ydesc, dydesc, dxdesc = TensorDescriptor.((reshape(y, sdims), reshape(dy, sdims), reshape(dx, sdims)))
    miopenSoftmaxBackward_V2(
        handle(), Ref{Float32}(1f0), ydesc.handle, y, dydesc.handle, dy,
        Ref{Float32}(0f0), dxdesc.handle, dx,
        algo, MIOPEN_SOFTMAX_MODE_CHANNEL) |> check
    AMDGPU.mark!(dx, C_NULL)
    dx
end

function _softmax_dims(x; dims)
    dims === Colon() && return (1, 1, length(x), 1)
    mind, maxd = minimum(dims), maximum(dims)
    all(i in dims for i in mind:maxd) || return nothing # cannot handle if not contiguous

    stride = dimsize = 1
    for i in 1:(mind - 1)
        stride *= size(x,i) # Using size(x,i) assumes trailing dims = 1, robust to maxd > ndims(x)
    end
    for i in mind:maxd
        dimsize *= size(x,i)
    end
    batchsize = length(x) ÷ (stride * dimsize)
    # Here is a region where miopen is slower, so we go with the backup:
    # batchsize == 1 && 64 <= stride <= 4096 && 64 <= dimsize <= 4096 && return nothing
    return (1, stride, dimsize, batchsize)
end
