"""

- `γ`: Scaling.
- `β`: Bias.
- `μ`: Running mean for inference.
- `ν`: Running variance for inference.
"""
function batchnorm_training(
    x::ROCArray{T},
    γ::ROCArray{T}, β::ROCArray{T},
    μ::ROCArray{T}, ν::ROCArray{T};
    n_features::Int, iteration::Int, ϵ::Float64 = 1e-10,
) where T <: MIOPENFloat
    y = similar(x)
    xdesc, ydesc = TensorDescriptor.((x, y))
    (; bndesc, dims) = derive_betta_gamma_descriptors(xdesc, miopenBNSpatial)
    @show dims
    factor = 1.0 / (1.0 + Float64(iteration))

    μ_saved, ν_saved = similar(x, n_features), similar(x, n_features)

    AMDGPU.wait!((x, γ, β))
    miopenBatchNormalizationForwardTraining(
        handle(), miopenBNSpatial, Ref{Float32}(1f0), Ref{Float32}(0f0),
        xdesc.handle, x, ydesc.handle, y, bndesc.handle, γ, β, factor,
        μ, ν, ϵ, μ_saved, ν_saved) |> check
    AMDGPU.mark!(y, C_NULL)
    AMDGPU.wait!(y)
    y, μ_saved, ν_saved
end

function derive_betta_gamma_descriptors(
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
    (; bndesc, dims)
end
