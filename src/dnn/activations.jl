# ReLU family.

function relu(x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationRELU, 0.0, 0.0, 0.0)
    _activation(x, desc)
end

function ∇relu(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationRELU, 0.0, 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function leakyrelu(x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationLEAKYRELU, Float64(α), 0.0, 0.0)
    _activation(x, desc)
end

function ∇leakyrelu(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationLEAKYRELU, Float64(α), 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function softrelu(x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationSOFTRELU, 0.0, 0.0, 0.0)
    _activation(x, desc)
end

function ∇softrelu(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationSOFTRELU, 0.0, 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function clippedrelu(x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationCLIPPEDRELU, Float64(α), 0.0, 0.0)
    _activation(x, desc)
end

function ∇clippedrelu(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationCLIPPEDRELU, Float64(α), 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function elu(x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationELU, Float64(α), 0.0, 0.0)
    _activation(x, desc)
end

function ∇elu(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}, α) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationELU, Float64(α), 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

# Others.

function abs(x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationABS, 0.0, 0.0, 0.0)
    _activation(x, desc)
end

function ∇abs(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationABS, 0.0, 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function sigmoid(x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationLOGISTIC, 0.0, 0.0, 0.0)
    _activation(x, desc)
end

function ∇sigmoid(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationLOGISTIC, 0.0, 0.0, 0.0)
    _∇activation(dy, y, x, desc)
end

function tanh(x::ROCArray{T}; α = 1.0, β = 1.0) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationTANH, Float64(α), Float64(β), 0.0)
    _activation(x, desc)
end

function ∇tanh(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}; α = 1.0, β = 1.0) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationTANH, Float64(α), Float64(β), 0.0)
    _∇activation(dy, y, x, desc)
end

function power(x::ROCArray{T}, γ; α = 0.0, β = 1.0) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationPOWER, Float64(α), Float64(β), Float64(γ))
    _activation(x, desc)
end

function ∇power(dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}, γ; α = 0.0, β = 1.0) where T <: MIOPENFloat
    desc = ActivationDescriptor()
    set!(desc, miopenActivationPOWER, Float64(α), Float64(β), Float64(γ))
    _∇activation(dy, y, x, desc)
end

# Generic MIOpen interface.

function _activation(
    x::ROCArray{T}, desc::ActivationDescriptor,
) where T <: MIOPENFloat
    y = similar(x)
    xdesc, ydesc = TensorDescriptor.((x, y))
    (; handle, stream) = lib_state()
    miopenActivationForward(
        handle, desc.handle, Ref{Float32}(1f0), xdesc.handle, x,
        Ref{Float32}(0f0), ydesc.handle, y) |> check
    y
end

function _∇activation(
    dy::ROCArray{T}, y::ROCArray{T}, x::ROCArray{T}, desc::ActivationDescriptor,
) where T <: MIOPENFloat
    dx = similar(x)
    xdesc, ydesc, dydesc, dxdesc = TensorDescriptor.((x, y, dy, dx))
    (; handle, stream) = lib_state()
    miopenActivationBackward(
        handle, desc, Ref{Float32}(1f0), ydesc.handle, y,
        dydesc.handle, dy, xdesc.handle, x, Ref{Float32}(0f0),
        dxdesc.handle, dx) |> check
    dx
end
