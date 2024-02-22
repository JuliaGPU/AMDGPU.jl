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
