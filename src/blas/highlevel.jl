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
    length(x) == length(y) || throw(DimensionMismatch(""))
    axpy!(length(x), convert(T,alpha), x, 1, y, 1)
end

function LinearAlgebra.axpby!(
    alpha::Number, x::ROCArray{T}, beta::Number, y::ROCArray{T},
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(""))
    beta = isa(beta, Real) ? convert(real(T), beta) : convert(T, beta)
    scal!(ly, beta, y, 1)
    axpy!(lx, convert(T,alpha), x, 1, y, 1)
end

function LinearAlgebra.rotate!(
    x::ROCArray{T}, y::ROCArray{T}, c::Number, s::Number,
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(
        "rotate arguments have lengths $lx and $ly"))
    rot!(lx, x, 1, y, 1, c, s)
    x, y
end

function LinearAlgebra.reflect!(
    x::ROCArray{T}, y::ROCArray{T}, c::Number, s::Number,
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(
        "reflect arguments have lengths $lx and $ly"))
    rot!(lx, x, 1, y, 1, c, s)
    scal!(ly, -real(one(T)), y, 1)
    x, y
end

############
#
# BLAS 2
#
############

if VERSION ≥ v"1.10-"
    # multiplication
    LinearAlgebra.generic_trimatmul!(
        c::ROCVector{T}, uploc, isunitc, tfun::Function,
        A::ROCMatrix{T}, b::AbstractVector{T},
    ) where T <: ROCBLASFloat = trmv!(
        uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
        isunitc, A, c === b ? c : copyto!(c, b))
    # division
    LinearAlgebra.generic_trimatdiv!(
        C::ROCVector{T}, uploc, isunitc, tfun::Function,
        A::ROCMatrix{T}, B::AbstractVector{T},
    ) where T <: ROCBLASFloat = trsv!(
        uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
        isunitc, A, C === B ? C : copyto!(C, B))
else
    for (t, uploc, isunitc) in (
        (:LowerTriangular, 'L', 'N'),
        (:UnitLowerTriangular, 'L', 'U'),
        (:UpperTriangular, 'U', 'N'),
        (:UnitUpperTriangular, 'U', 'U'),
    )
        @eval begin
        LinearAlgebra.lmul!(A::$t{T, <: ROCMatrix}, B::ROCVector{T}) where T <: ROCBLASFloat =
            trmv!($uploc, 'N', $isunitc, parent(A), B)
        LinearAlgebra.ldiv!(A::$t{T, <: ROCMatrix}, B::ROCVector{T}) where T <: ROCBLASFloat =
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
        LinearAlgebra.lmul!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASFloat =
            trmv!($uploc, 'T', $isunitc, parent(parent(A)), B)
        LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASFloat =
            trmv!($uploc, 'T', $isunitc, parent(parent(A)), B)
        LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASComplex =
            trmv!($uploc, 'C', $isunitc, parent(parent(A)), B)

        LinearAlgebra.ldiv!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASFloat =
            trsv!($uploc, 'T', $isunitc, parent(parent(A)), B)
        LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASFloat =
            trsv!($uploc, 'T', $isunitc, parent(parent(A)), B)
        LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCVector{T}) where T <: ROCBLASComplex =
            trsv!($uploc, 'C', $isunitc, parent(parent(A)), B)
        end
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
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCVecOrMat{T}, B::ROCVecOrMat{T}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'N', A, B, alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'N', parent(trA), B, alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'T', A, parent(trB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(trB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCMatrix{T}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'N', parent(adjA), B, alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'N', parent(adjA), B, alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'N', 'T', A, parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'N', 'C', A, parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'C', parent(adjA), parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'T', 'C', parent(trA), parent(adjB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(trB), alpha, beta)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, alpha::T = one(T), beta::T = zero(T)) where T <: ROCBLASFloatWithHalf =
    gemm_wrapper!(C, 'C', 'T', parent(adjA), parent(trB), alpha, beta)


########
# TRSM
########

# TODO requires ROCm 5.6 for out-of-place trmm:
# https://rocm.docs.amd.com/projects/rocBLAS/en/latest/API_Reference_Guide.html#announced-in-rocblas-3-0
#
# if VERSION ≥ v"1.10-"
#     LinearAlgebra.generic_trimatmul!(
#         C::ROCMatrix{T}, uploc, isunitc, tfun::Function,
#         A::ROCMatrix{T}, B::ROCMatrix{T},
#     ) where T <: ROCBLASFloat = trmm!(
#         'L', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
#         isunitc, one(T), A, B, C)

#     LinearAlgebra.generic_mattrimul!(
#         C::ROCMatrix{T}, uploc, isunitc, tfun::Function,
#         A::ROCMatrix{T}, B::ROCMatrix{T},
#     ) where T <: ROCBLASFloat = trmm!(
#         'R', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
#         isunitc, one(T), B, A, C)

#     # tri-tri-mul!
#     const AdjOrTransOrROCMatrix{T} = Union{ROCMatrix{T}, AdjOrTrans{<:T,<:ROCMatrix}}

#     function LinearAlgebra.generic_trimatmul!(
#         C::ROCMatrix{T}, uplocA, isunitcA, tfunA::Function,
#         A::ROCMatrix{T}, triB::UpperOrLowerTriangular{T,<:AdjOrTransOrROCMatrix{T}},
#     ) where T <: ROCBLASFloat
#         uplocB = LinearAlgebra.uplo_char(triB)
#         isunitcB = LinearAlgebra.isunit_char(triB)
#         B = parent(triB)
#         tfunB = LinearAlgebra.wrapperop(B)
#         transa = tfunA === identity ? 'N' : tfunA === transpose ? 'T' : 'C'
#         transb = tfunB === identity ? 'N' : tfunB === transpose ? 'T' : 'C'
#         if uplocA == 'L' && tfunA === identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N' # lower * upper
#             triu!(B)
#             trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
#         elseif uplocA == 'U' && tfunA === identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N' # upper * lower
#             tril!(B)
#             trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
#         elseif uplocA == 'U' && tfunA === identity && tfunB !== identity && uplocB == 'U' && isunitcA == 'N'
#             # operation is reversed to avoid executing the tranpose
#             triu!(A)
#             trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), A, C)
#         elseif uplocA == 'L' && tfunA !== identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N'
#             tril!(B)
#             trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
#         elseif uplocA == 'U' && tfunA !== identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N'
#             triu!(B)
#             trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
#         elseif uplocA == 'L' && tfunA === identity && tfunB !== identity && uplocB == 'L' && isunitcA == 'N'
#             tril!(A)
#             trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), A, C)
#         else
#             throw("mixed triangular-triangular multiplication") # TODO: rethink
#         end
#         return C
#     end

#     LinearAlgebra.generic_trimatdiv!(
#         C::ROCMatrix{T}, uploc, isunitc, tfun::Function,
#         A::ROCMatrix{T}, B::AbstractMatrix{T},
#     ) where T <: ROCBLASFloat = trsm!(
#         'L', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
#         isunitc, one(T), A, C === B ? C : copyto!(C, B))

#     LinearAlgebra.generic_mattridiv!(
#         C::ROCMatrix{T}, uploc, isunitc, tfun::Function,
#         A::AbstractMatrix{T}, B::ROCMatrix{T},
#     ) where T <: ROCBLASFloat = trsm!(
#         'R', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
#         isunitc, one(T), B, C === A ? C : copyto!(C, A))
# else
    for (t, uploc, isunitc) in (
        (:LowerTriangular, 'L', 'N'),
        (:UnitLowerTriangular, 'L', 'U'),
        (:UpperTriangular, 'U', 'N'),
        (:UnitUpperTriangular, 'U', 'U'),
    )
        @eval begin
        LinearAlgebra.lmul!(A::$t{T, <: ROCMatrix}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B, B)
        LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{T, <: ROCMatrix}) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'N', $isunitc, one(T), parent(B), A, A)

        LinearAlgebra.ldiv!(A::$t{T, <: ROCMatrix}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B)
        LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{T, <: ROCMatrix}) where T <: ROCBLASFloat =
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
        LinearAlgebra.lmul!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B, B)
        LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B, B)
        LinearAlgebra.lmul!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASComplex =
            trmm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B, B)

        LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Transpose{T, <: ROCMatrix}}) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A, A)
        LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A, A)
        LinearAlgebra.rmul!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}) where T <: ROCBLASComplex =
            trmm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A, A)

        # Left division.
        LinearAlgebra.ldiv!(A::$t{<: Any, <: Transpose{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
        LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
        LinearAlgebra.ldiv!(A::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}, B::ROCMatrix{T}) where T <: ROCBLASComplex =
            trsm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B)

        # Right division.
        LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Transpose{T, <: ROCMatrix}}) where T <: ROCBLASFloat =
            trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
        LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}) where T <: ROCBLASFloat =
            trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
        LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::$t{<: Any, <: Adjoint{T, <: ROCMatrix}}) where T <: ROCBLASComplex =
            trsm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A)
        end
    end
# end
