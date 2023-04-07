rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

const ROCBLASArray{T<:ROCBLASFloat} = ROCArray{T}

###########
#
# BLAS 1
#
###########

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Real) =
  scal!(length(x), convert(real(eltype(x)), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

# Work around ambiguity with GPUArrays wrapper
LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Real) =
  invoke(rmul!, Tuple{typeof(x), Number}, x, k)

function LinearAlgebra.BLAS.dot(DX::ROCArray{T}, DY::ROCArray{T}) where T <: Union{Float16, Float32, Float64}
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dot(n, DX, 1, DY, 1)
end

function LinearAlgebra.BLAS.dotc(DX::ROCArray{T}, DY::ROCArray{T}) where T <: ROCBLASComplex
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotc(n, DX, 1, DY, 1)
end

function LinearAlgebra.BLAS.dot(DX::ROCArray{T}, DY::ROCArray{T}) where T <: ROCBLASComplex
    dotc(DX, DY)
end

function LinearAlgebra.BLAS.dotu(DX::ROCArray{T}, DY::ROCArray{T}) where T <: ROCBLASComplex
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotu(n, DX, 1, DY, 1)
end

LinearAlgebra.norm(x::ROCArray{T}) where T <: ROCBLASFloat = nrm2(length(x), x, 1)
LinearAlgebra.BLAS.asum(x::ROCBLASArray) = asum(length(x), x, 1)

function LinearAlgebra.axpy!(
    alpha::Number, x::ROCArray{T}, y::ROCArray{T},
) where T <: ROCBLASFloatWithHalf
    length(x)==length(y) || throw(DimensionMismatch(""))
    axpy!(length(x), convert(T,alpha), x, 1, y, 1)
end

#= FIXME
Base.argmin(xs::ROCBLASArray{<:ROCBLASReal}) = iamin(xs)
Base.argmax(xs::ROCBLASArray{<:ROCBLASReal}) = iamax(xs)
=#

############
#
# BLAS 2
#
############

for (t, uploc, isunitc) in (
    (:LowerTriangular, 'L', 'N'),
    (:UnitLowerTriangular, 'L', 'U'),
    (:UpperTriangular, 'U', 'N'),
    (:UnitUpperTriangular, 'U', 'U'),
)
    @eval begin
    LinearAlgebra.lmul!(A::$t{T, ROCMatrix{T}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trmv!($uploc, 'N', $isunitc, parent(A), B)
    LinearAlgebra.ldiv!(A::$t{T, ROCMatrix{T}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trsv!($uploc, 'N', $isunitc, parent(A), B)
    end
end

# Adjoint/transpose - reversed uploc.
for (t, uploc, isunitc) in (
    (:LowerTriangular, 'U', 'N'),
    (:UnitLowerTriangular, 'U', 'U'),
    (:UpperTriangular, 'L', 'N'),
    (:UnitUpperTriangular, 'L', 'U'),
)
    @eval begin
    LinearAlgebra.lmul!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trmv!($uploc, 'T', $isunitc, parent(parent(A)), B)
    LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trmv!($uploc, 'T', $isunitc, parent(parent(A)), B)
    LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASComplex =
        trmv!($uploc, 'C', $isunitc, parent(parent(A)), B)

    LinearAlgebra.ldiv!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trsv!($uploc, 'T', $isunitc, parent(parent(A)), B)
    LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASFloat =
        trsv!($uploc, 'T', $isunitc, parent(parent(A)), B)
    LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCVector{T}) where T <: ROCBLASComplex =
        trsv!($uploc, 'C', $isunitc, parent(parent(A)), B)
    end
end

#########
# GEMV
##########

function gemv_wrapper!(
    y::ROCVector{T}, tA::Char, A::ROCMatrix{T}, x::ROCVector{T},
    alpha = one(T), beta = zero(T),
) where T <: ROCBLASFloat
    mA, nA = rocblas_size(tA, A)
    if nA != length(x)
        throw(DimensionMismatch("second dimension of A, $nA, does not match length of x, $(length(x))"))
    end
    if mA != length(y)
        throw(DimensionMismatch("first dimension of A, $mA, does not match length of y, $(length(y))"))
    end
    mA == 0 && return y
    nA == 0 && return rmul!(y, 0)
    gemv!(tA, alpha, A, x, beta, y)
end

LinearAlgebra.mul!(Y::ROCVector{T}, A::ROCMatrix{T}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'N', A,  B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Transpose{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'T', A.parent, B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'T', A.parent, B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASComplex = gemv_wrapper!(Y, 'C', A.parent, B)

############
#
# BLAS 3
#
############

########
# GEMM
########
function gemm_wrapper!(
    C::ROCVecOrMat{T}, tA::Char, tB::Char,
    A::ROCVecOrMat{T}, B::ROCVecOrMat{T},
    alpha = one(T), beta = zero(T),
) where T <: ROCBLASFloatWithHalf
    mA, nA = rocblas_size(tA, A)
    mB, nB = rocblas_size(tB, B)

    nA != mB && throw(DimensionMismatch(
        "A has dimensions ($mA,$nA) but B has dimensions ($mB,$nB)"))
    (C === A || B === C) && throw(ArgumentError(
        "output matrix must not be aliased with input matrix"))

    if mA == 0 || nA == 0 || nB == 0
        size(C) != (mA, nB) && throw(DimensionMismatch(
            "C has dimensions $(size(C)), should have ($mA,$nB)"))
        return LinearAlgebra.rmul!(C, 0)
    end
    gemm!(tA, tB, alpha, A, B, beta, C)
end

# Mutating
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCVecOrMat{T}, B::ROCVecOrMat{T}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'N', A, B)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'N', parent(trA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'T', A, parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'N', parent(adjA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'N', parent(adjA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'N', 'T', A, parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'C', A, parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'C', parent(adjA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'C', parent(trA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T <: ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'T', parent(adjA), parent(trB))


########
# TRSM
########

for (t, uploc, isunitc) in (
    (:LowerTriangular, 'L', 'N'),
    (:UnitLowerTriangular, 'L', 'U'),
    (:UpperTriangular, 'U', 'N'),
    (:UnitUpperTriangular, 'U', 'U'),
)
    @eval begin
    LinearAlgebra.lmul!(A::$t{T, ROCMatrix{T}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trmm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B)
    LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{T, ROCMatrix{T}}) where T <: ROCBLASFloat =
        trmm!('R', $uploc, 'N', $isunitc, one(T), parent(B), A)

    LinearAlgebra.ldiv!(A::$t{T, ROCMatrix{T}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trsm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B)
    LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{T, ROCMatrix{T}}) where T <: ROCBLASFloat =
        trsm!('R', $uploc, 'N', $isunitc, one(T), parent(B), A)
    end
end

# Adjoint/transpose - reversed uploc.
for (t, uploc, isunitc) in (
    (:LowerTriangular, 'U', 'N'),
    (:UnitLowerTriangular, 'U', 'U'),
    (:UpperTriangular, 'L', 'N'),
    (:UnitUpperTriangular, 'L', 'U'),
)
    @eval begin
    # Multiplication.
    LinearAlgebra.lmul!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
    LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
    LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASComplex =
        trmm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B)

    LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}) where T <: ROCBLASFloat =
        trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
    LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}) where T <: ROCBLASFloat =
        trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
    LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}) where T <: ROCBLASComplex =
        trmm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A)

    # Left division.
    LinearAlgebra.ldiv!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
    LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
        trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
    LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}, B::ROCMatrix{T}) where T <: ROCBLASComplex =
        trsm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B)

    # Right division.
    LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Transpose{T, <: ROCMatrix{T}}}) where T <: ROCBLASFloat =
        trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
    LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}) where T <: ROCBLASFloat =
        trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
    LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix{T}}}) where T <: ROCBLASComplex =
        trsm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A)
    end
end
