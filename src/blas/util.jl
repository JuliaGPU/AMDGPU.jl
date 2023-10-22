const ROCBLASReal = Union{Float32, Float64}
const ROCBLASComplex = Union{ComplexF32, ComplexF64}
const ROCBLASFloat = Union{ROCBLASReal, ROCBLASComplex}
const ROCBLASFloatWithHalf = Union{Float16, ROCBLASFloat}

# Utility functions

# convert Char {N,T,C} to rocblas_operation
function rocblasop(trans::Char)
    trans == 'N' && return rocblas_operation_none
    trans == 'T' && return rocblas_operation_transpose
    trans == 'C' && return rocblas_operation_conjugate_transpose
    throw(ArgumentError("unknown rocblas operation $trans"))
end

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

# convert Char {U,L} to rocblas_fill
function rocblasfill(uplo::Char)
    uplo == 'U' && return rocblas_fill_upper
    uplo == 'L' && return rocblas_fill_lower
    throw(ArgumentError("unknown rocblas fill mode $uplo"))
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

# convert Char {U,N} to rocblas_diagonal
function rocblasdiag(diag::Char)
    diag == 'U' && return rocblas_diagonal_unit
    diag == 'N' && return rocblas_diagonal_non_unit
    throw(ArgumentError("unknown rocblas diag mode $diag"))
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

# convert Char {L,R} to rocblas_side
function rocblasside(side::Char)
    side == 'L' && return rocblas_side_left
    side == 'R' && return rocblas_side_right
    throw(ArgumentError("unknown rocblas side mode $side"))
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
