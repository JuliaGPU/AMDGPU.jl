# convert matrix to band storage
function band(A::AbstractMatrix,kl,ku)
    m, n = size(A)
    AB = zeros(eltype(A),kl+ku+1,n)
    for j = 1:n
        for i = max(1,j-ku):min(m,j+kl)
            AB[ku+1-j+i,j] = A[i,j]
        end
    end
    return AB
end

# convert band storage to general matrix
function unband(AB::AbstractMatrix,m,kl,ku)
    bm, n = size(AB)
    A = zeros(eltype(AB),m,n)
    for j = 1:n
        for i = max(1,j-ku):min(m,j+kl)
            A[i,j] = AB[ku+1-j+i,j]
        end
    end
    return A
end

# zero out elements not on matrix bands
function bandex(A::AbstractMatrix,kl,ku)
    m, n = size(A)
    AB = band(A,kl,ku)
    B = unband(AB,m,kl,ku)
    return B
end

const ROCBLASReal = Union{Float32, Float64}
const ROCBLASComplex = Union{ComplexF32, ComplexF64}
const ROCBLASFloat = Union{ROCBLASReal, ROCBLASComplex}
const ROCBLASFloatWithHalf = Union{Float16, ROCBLASFloat}

function Base.convert(::Type{rocblas_operation}, trans::Char)
    if trans == 'N'
        return rocblas_operation_none
    elseif trans == 'T'
        return rocblas_operation_transpose
    elseif trans == 'C'
        return rocblas_operation_conjugate_transpose
    else
        throw(ArgumentError("unknown rocblas operation $trans"))
    end
end

function Base.convert(::Type{rocblas_fill}, uplo::Char)
    if uplo == 'U'
        return rocblas_fill_upper
    elseif uplo == 'L'
        return rocblas_fill_lower
    else
        throw(ArgumentError("unknown rocblas fill mode $uplo"))
    end
end

function Base.convert(::Type{rocblas_diagonal}, diag::Char)
    if diag == 'U'
        return rocblas_diagonal_unit
    elseif diag == 'N'
        return rocblas_diagonal_non_unit
    else
        throw(ArgumentError("unknown rocblas diag mode $diag"))
    end
end

function Base.convert(::Type{rocblas_side}, side::Char)
    if side == 'L'
        return rocblas_side_left
    elseif side == 'R'
        return rocblas_side_right
    else
        throw(ArgumentError("unknown rocblas side mode $side"))
    end
end

## scalar arguments

# Scalar arguments (`alpha`, `beta`, ...) are host-side (a number or a `Ref`) or
# device-side (a `ROCRef` or a one-element array). If any of them is device-side, all
# are passed in the device pointer mode; otherwise, the host pointer mode avoids copies.
const Scalar{T} = Union{T, Ref{T}, StridedROCArray{T}}

on_device(x) = false
on_device(::Union{ROCRef, StridedROCArray}) = true

host_scalar(x::Number) = Ref(x)
host_scalar(x::Ref) = x

device_scalar(x::Number) = ROCRef(x)
device_scalar(x::ROCRef) = x
device_scalar(x::Ref) = ROCRef(x[])
function device_scalar(x::AbstractArray)
    length(x) == 1 || throw(DimensionMismatch(
        "a device-side scalar must have exactly one element, got $(length(x))"))
    return ROCRef(x)
end

# put `handle` in the device pointer mode while calling `f`, if `device` is set
@inline function with_pointer_mode(f::F, handle, device::Bool) where F
    device || return f()
    mode = Ref{rocblas_pointer_mode}()
    rocblas_get_pointer_mode(handle, mode)
    rocblas_set_pointer_mode(handle, rocblas_pointer_mode_device)
    try
        return f()
    finally
        rocblas_set_pointer_mode(handle, mode[])
    end
end

"""
    with_scalars(f, handle, scalars...)

Call `f` with the pointer arguments for `scalars`, after putting `handle` in the pointer
mode that matches where those scalars reside.
"""
@inline function with_scalars(f::F, handle, scalars::Vararg{Any, N}) where {F, N}
    if any(on_device, scalars)
        refs = map(device_scalar, scalars)
        return with_pointer_mode(() -> f(refs...), handle, true)
    else
        return f(map(host_scalar, scalars)...)
    end
end

# Arguments that are written to can't be copied to where the others reside, so they all
# need to reside on the host, or all on the device. Returns whether they're on the device.
function outputs_on_device(name, outputs...)
    device = any(on_device, outputs)
    device == all(on_device, outputs) || throw(ArgumentError(
        "the outputs of $name must either all reside on the host, or all on the device"))
    return device
end

check_scalar(x) = nothing
check_scalar(x::AbstractArray) = length(x) == 1 || throw(DimensionMismatch(
    "a scalar argument must have exactly one element, got $(length(x))"))

# the parameters of a modified Givens rotation: a flag and the matrix H
function check_rotm_param(param::AbstractVector)
    length(param) >= 5 || throw(DimensionMismatch(
        "param must have (at least) 5 elements, got $(length(param))"))
    stride(param, 1) == 1 || throw(ArgumentError("param must be contiguous"))
    return
end
