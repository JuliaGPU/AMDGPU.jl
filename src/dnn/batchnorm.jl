"""
    batchnorm_training(
        x::ROCArray{T},
        γ::ROCArray{T}, β::ROCArray{T},
        μ::ROCArray{T}, ν::ROCArray{T}; iteration::Int, ϵ::Float64 = 1e-5,
    ) where T <: MIOPENFloat

# Arguments:

- `γ`: Scaling.
- `β`: Bias.
- `μ`: Running mean for inference.
- `ν`: Running variance for inference.

If `x` has `N` dims, then `N - 1` is considered as 'feature' dimension.
Meaning, γ, β, μ, ν must have `size(x, N - 1)` shape.
"""
function batchnorm_training(
    x::ROCArray{T},
    γ::ROCArray{T}, β::ROCArray{T},
    μ::ROCArray{T}, ν::ROCArray{T}; iteration::Int, ϵ::Float64 = 1e-5,
) where T <: MIOPENFloat
    y = similar(x)

    nd = ndims(x)
    n_features = size(x, nd - 1)
    mode = nd == 2 ? miopenBNPerActivation : miopenBNSpatial
    xdesc, ydesc = TensorDescriptor4D.((x, y))

    bndesc = derive_beta_gamma_descriptors(xdesc, mode)
    factor = 1.0 / (1.0 + Float64(iteration))
    # For backward pass.
    μ_saved, ν_saved = similar(x, n_features), similar(x, n_features)

    (; handle, stream) = lib_state()
    miopenBatchNormalizationForwardTraining(
        handle, mode, Ref{Float32}(1f0), Ref{Float32}(0f0),
        xdesc.handle, x, ydesc.handle, y, bndesc.handle, γ, β, factor,
        μ, ν, ϵ, μ_saved, ν_saved) |> check
    y, μ_saved, ν_saved
end

"""
    batchnorm_inference(
        x::ROCArray{T},
        γ::ROCArray{T}, β::ROCArray{T},
        μ::ROCArray{T}, ν::ROCArray{T}; ϵ::Float64 = 1e-5,
    ) where T <: MIOPENFloat

# Arguments:

- `γ`: Scaling.
- `β`: Bias.
- `μ`: Running mean for inference.
- `ν`: Running variance for inference.

If `x` has `N` dims, then `N - 1` is considered as 'feature' dimension.
Meaning, γ, β, μ, ν must have `size(x, N - 1)` shape.
"""
function batchnorm_inference(
    x::ROCArray{T},
    γ::ROCArray{T}, β::ROCArray{T},
    μ::ROCArray{T}, ν::ROCArray{T}; ϵ::Float64 = 1e-5,
) where T <: MIOPENFloat
    y = similar(x)

    nd = ndims(x)
    mode = nd == 2 ? miopenBNPerActivation : miopenBNSpatial
    xdesc, ydesc = TensorDescriptor4D.((x, y))
    bndesc = derive_beta_gamma_descriptors(xdesc, mode)

    (; handle, stream) = lib_state()
    miopenBatchNormalizationForwardInference(
        handle, mode, Ref{Float32}(1f0), Ref{Float32}(0f0),
        xdesc.handle, x, ydesc.handle, y, bndesc.handle,
        γ, β, μ, ν, ϵ) |> check
    y
end

function ∇batchnorm(
    dy::ROCArray{T, N}, x::ROCArray{T, N},
    γ::ROCArray{T}, β::ROCArray{T},
    μ_saved::ROCArray{T}, ν_saved::ROCArray{T}; ϵ::Float64 = 1e-5,
) where {T <: MIOPENFloat, N}
    dx, dγ, dβ = similar(x), similar(γ), similar(β)

    nd = ndims(x)
    mode = nd == 2 ? miopenBNPerActivation : miopenBNSpatial
    xdesc, dxdesc, dydesc = TensorDescriptor4D.((x, dx, dy))
    bndesc = derive_beta_gamma_descriptors(xdesc, mode)

    (; handle, stream) = lib_state()
    miopenBatchNormalizationBackward(
        handle, mode,
        Ref{Float32}(1f0), Ref{Float32}(0f0),
        Ref{Float32}(1f0), Ref{Float32}(0f0),
        xdesc.handle, x, dydesc.handle, dy, dxdesc.handle, dx,
        bndesc.handle, γ, dγ, dβ, ϵ, μ_saved, ν_saved) |> check
    dx, dγ, dβ
end

function derive_beta_gamma_descriptors(
    xdesc::TensorDescriptor, mode::miopenBatchNormMode_t,
)
    handle_ref = Ref{miopenTensorDescriptor_t}()
    miopenCreateTensorDescriptor(handle_ref) |> check
    handle = handle_ref[]

    miopenDeriveBNTensorDescriptor(handle, xdesc.handle, mode) |> check
    dtype, dims, stride = unpack(handle, ndims(handle))

    bndesc = TensorDescriptor(handle, dtype)
    finalizer(bndesc) do d_
        miopenDestroyTensorDescriptor(d_.handle) |> check
    end
    bndesc
end

# Unsqueeze dimensions at the beginning:
# _bn_expand_dims((3, 2), 4) -> (1, 1, 3, 2)
function _bn_expand_dims(v, ndims)
    reverse(ntuple(
        i -> (i ≤ length(v)) ? Int64(v[end - i + 1]) : 1,
        Val{ndims}()))
end

function TensorDescriptor4D(x)
    nd = ndims(x)
    TensorDescriptor(reshape(x, _bn_expand_dims(size(x), max(4, nd))))
end
