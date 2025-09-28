rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

#
# BLAS 1
#

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Real) =
  scal!(length(x), convert(real(eltype(x)), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

# Work around ambiguity with GPUArrays wrapper
LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Real) =
  invoke(rmul!, Tuple{typeof(x), Number}, x, k)

function LinearAlgebra.dot(
    DX::StridedROCArray{T}, DY::StridedROCArray{T},
) where T <: Union{Float16, Float32, Float64}
    n = length(DX)
    n == length(DY) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dot(n, DX, stride(DX, 1), DY, stride(DY, 1))
end

function LinearAlgebra.dot(
    DX::StridedROCArray{T}, DY::StridedROCArray{T},
) where T <: ROCBLASComplex
    n = length(DX)
    n == length(DY) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotc(n, DX, stride(DX, 1), DY, stride(DY, 1))
end

function LinearAlgebra.:(*)(
    transx::Transpose{<:Any, <:StridedROCVector{T}}, y::StridedROCVector{T},
) where T <: Union{ComplexF16, ROCBLASComplex}
    x = transx.parent
    n = length(x)
    n == length(y) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(x)) and $(length(y))"))
    dotu(n, x, stride(x, 1), y, stride(y, 1))
end

LinearAlgebra.norm(x::ROCArray{T}) where T <: ROCBLASFloat = nrm2(length(x), x, stride(x, 1))
LinearAlgebra.BLAS.asum(x::ROCArray{T}) where T <: ROCBLASFloat = asum(length(x), x, stride(x, 1))

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

#
# BLAS 2
#

# work around upstream breakage from JuliaLang/julia#55547
@static if VERSION >= v"1.11.2"
const ROCUpperOrUnitUpperTriangular = LinearAlgebra.UpperOrUnitUpperTriangular{
    <:Any,<:Union{<:ROCArray, Adjoint{<:Any, <:ROCArray}, Transpose{<:Any, <:ROCArray}}}
const ROCLowerOrUnitLowerTriangular = LinearAlgebra.LowerOrUnitLowerTriangular{
    <:Any,<:Union{<:ROCArray, Adjoint{<:Any, <:ROCArray}, Transpose{<:Any, <:ROCArray}}}

LinearAlgebra.istriu(::ROCUpperOrUnitUpperTriangular) = true
LinearAlgebra.istril(::ROCUpperOrUnitUpperTriangular) = false
LinearAlgebra.istriu(::ROCLowerOrUnitLowerTriangular) = false
LinearAlgebra.istril(::ROCLowerOrUnitLowerTriangular) = true
end

# multiplication
LinearAlgebra.generic_trimatmul!(
    c::StridedROCVector{T}, uploc, isunitc, tfun::Function,
    A::StridedROCMatrix{T}, b::StridedROCVector{T},
) where T <: ROCBLASFloat = trmv!(
    uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, A, c === b ? c : copyto!(c, b))
# division
LinearAlgebra.generic_trimatdiv!(
    C::StridedROCVector{T}, uploc, isunitc, tfun::Function,
    A::StridedROCMatrix{T}, B::StridedROCVector{T},
) where T <: ROCBLASFloat = trsv!(
    uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, A, C === B ? C : copyto!(C, B))

# GEMV
# legacy method
LinearAlgebra.generic_matvecmul!(
    Y::ROCVector, tA::AbstractChar, A::StridedROCMatrix, B::StridedROCVector,
    _add::MulAddMul
) = LinearAlgebra.generic_matvecmul!(Y, tA, A, B, _add.alpha, _add.beta)
function LinearAlgebra.generic_matvecmul!(
    Y::ROCVector, tA::AbstractChar, A::StridedROCMatrix, B::StridedROCVector,
    alpha::Number, beta::Number,
)
    mA, nA = tA == 'N' ? size(A) : reverse(size(A))

    nA != length(B) && throw(DimensionMismatch(
        "second dimension of A, $nA, does not match length of B, $(length(B))"))
    mA != length(Y) && throw(DimensionMismatch(
        "first dimension of A, $mA, does not match length of Y, $(length(Y))"))

    mA == 0 && return Y
    nA == 0 && return rmul!(Y, 0)

    T = eltype(Y)
    if alpha isa Union{Bool,T} && beta isa Union{Bool,T}
        α, β = T(alpha), T(beta)
        if T <: ROCBLASFloat && eltype(A) == eltype(B) == T
            if tA in ('N', 'T', 'C')
                return gemv!(tA, α, A, B, β, Y)
            elseif tA in ('S', 's')
                return symv!(tA == 'S' ? 'U' : 'L', α, A, B, β, Y)
            elseif tA in ('H', 'h')
                return hemv!(tA == 'H' ? 'U' : 'L', α, A, B, β, Y)
            end
        end
    end
    LinearAlgebra.generic_matmatmul!(Y, tA, 'N', A, B, alpha, beta)
end

#
# BLAS 3
#

if VERSION >= v"1.12-"
    # Otherwise dispatches onto:
    # https://github.com/JuliaLang/LinearAlgebra.jl/blob/4e7c3f40316a956119ac419a97c4b8aad7a17e6c/src/matmul.jl#L490
    for blas_flag in (LinearAlgebra.BlasFlag.SyrkHerkGemm, LinearAlgebra.BlasFlag.SymmHemmGeneric)
        @eval LinearAlgebra.generic_matmatmul_wrapper!(
            C::StridedROCMatrix, tA::AbstractChar, tB::AbstractChar, A::StridedROCVecOrMat, B::StridedROCVecOrMat,
            alpha::Number, beta::Number, ::$blas_flag) =
            LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, alpha, beta)
    end
end

# legacy method
LinearAlgebra.generic_matmatmul!(
    C::StridedROCVecOrMat, tA, tB, A::StridedROCVecOrMat,
    B::StridedROCVecOrMat, _add::MulAddMul,
) = LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)

function LinearAlgebra.generic_matmatmul!(
    C::StridedROCVecOrMat, tA, tB, A::StridedROCVecOrMat,
    B::StridedROCVecOrMat, alpha::Number, beta::Number,
)
    mA, nA = size(A, tA == 'N' ? 1 : 2), size(A, tA == 'N' ? 2 : 1)
    mB, nB = size(B, tB == 'N' ? 1 : 2), size(B, tB == 'N' ? 2 : 1)

    nA != mB && throw(DimensionMismatch(
        "A has dimensions ($mA,$nA) but B has dimensions ($mB,$nB)"))
    (C === A || B === C) && throw(ArgumentError(
        "output matrix must not be aliased with input matrix"))

    if mA == 0 || nA == 0 || nB == 0
        size(C) != (mA, nB) && throw(DimensionMismatch(
            "C has dimensions $(size(C)), should have ($mA,$nB)"))
        return LinearAlgebra.rmul!(C, 0)
    end

    T = eltype(C)
    if alpha isa Union{Bool, T} && beta isa Union{Bool, T}
        α, β = T(alpha), T(beta)

        if (
            all(in(('N', 'T', 'C')), (tA, tB)) && T <: ROCBLASFloat &&
            A isa StridedROCArray{T} && B isa StridedROCArray{T}
        )
            return gemm!(tA, tB, α, A, B, β, C)
        elseif (tA == 'S' || tA == 's') && tB == 'N'
            return symm!('L', tA == 'S' ? 'U' : 'L', α, A, B, β, C)
        elseif (tB == 'S' || tB == 's') && tA == 'N'
            return symm!('R', tB == 'S' ? 'U' : 'L', α, B, A, β, C)
        elseif (tA == 'H' || tA == 'h') && tB == 'N'
            return hemm!('L', tA == 'H' ? 'U' : 'L', α, A, B, β, C)
        elseif (tB == 'H' || tB == 'h') && tA == 'N'
            return hemm!('R', tB == 'H' ? 'U' : 'L', α, B, A, β, C)
        end
    end

    GPUArrays.generic_matmatmul!(C, wrap(A, tA), wrap(B, tB), alpha, beta)
end

LinearAlgebra.generic_trimatmul!(
    C::StridedROCMatrix{T}, uploc, isunitc, tfun::Function,
    A::StridedROCMatrix{T}, B::StridedROCMatrix{T},
) where T <: ROCBLASFloat = trmm!(
    'L', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, one(T), A, B, C)

LinearAlgebra.generic_mattrimul!(
    C::StridedROCMatrix{T}, uploc, isunitc, tfun::Function,
    A::StridedROCMatrix{T}, B::StridedROCMatrix{T},
) where T <: ROCBLASFloat = trmm!(
    'R', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, one(T), B, A, C)

const AdjOrTransOrROCMatrix{T} = Union{
    StridedROCMatrix{T},
    AdjOrTrans{<: T, <: StridedROCMatrix}}

function LinearAlgebra.generic_trimatmul!(
    C::StridedROCMatrix{T}, uplocA, isunitcA,
    tfunA::Function, A::StridedROCMatrix{T},
    triB::UpperOrLowerTriangular{T, <: AdjOrTransOrROCMatrix{T}},
) where T <: ROCBLASFloat
    uplocB = LinearAlgebra.uplo_char(triB)
    isunitcB = LinearAlgebra.isunit_char(triB)
    B = parent(triB)
    tfunB = LinearAlgebra.wrapperop(B)
    transa = tfunA === identity ? 'N' : tfunA === transpose ? 'T' : 'C'
    transb = tfunB === identity ? 'N' : tfunB === transpose ? 'T' : 'C'
    if uplocA == 'L' && tfunA === identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N' # lower * upper
        triu!(B)
        trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
    elseif uplocA == 'U' && tfunA === identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N' # upper * lower
        tril!(B)
        trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
    elseif uplocA == 'U' && tfunA === identity && tfunB !== identity && uplocB == 'U' && isunitcA == 'N'
        # operation is reversed to avoid executing the tranpose
        triu!(A)
        trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), A, C)
    elseif uplocA == 'L' && tfunA !== identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N'
        tril!(B)
        trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
    elseif uplocA == 'U' && tfunA !== identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N'
        triu!(B)
        trmm!('L', uplocA, transa, isunitcA, one(T), A, B, C)
    elseif uplocA == 'L' && tfunA === identity && tfunB !== identity && uplocB == 'L' && isunitcA == 'N'
        tril!(A)
        trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), A, C)
    else
        throw("mixed triangular-triangular multiplication") # TODO: rethink
    end
    return C
end

LinearAlgebra.generic_trimatdiv!(
    C::StridedROCMatrix{T}, uploc, isunitc, tfun::Function,
    A::StridedROCMatrix{T}, B::AbstractMatrix{T},
) where T <: ROCBLASFloat = trsm!(
    'L', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, one(T), A, C === B ? C : copyto!(C, B))

LinearAlgebra.generic_mattridiv!(
    C::StridedROCMatrix{T}, uploc, isunitc, tfun::Function,
    A::AbstractMatrix{T}, B::StridedROCMatrix{T},
) where T <: ROCBLASFloat = trsm!(
    'R', uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
    isunitc, one(T), B, C === A ? C : copyto!(C, A))

# Matrix inversion.

for (t, uploc, isunitc) in (
    (:LowerTriangular, 'U', 'N'),
    (:UnitLowerTriangular, 'U', 'U'),
    (:UpperTriangular, 'L', 'N'),
    (:UnitUpperTriangular, 'L', 'U'),
)
    @eval function LinearAlgebra.inv(x::$t{T, <: ROCMatrix{T}}) where T <: ROCBLASFloat
        out = ROCArray{T}(I(size(x, 1)))
        $t(LinearAlgebra.ldiv!(x, out))
    end
end

# Diagonal matrix.

Base.Array(D::Diagonal{T, <: ROCArray{T}}) where T = Diagonal(Array(D.diag))

AMDGPU.ROCArray(D::Diagonal{T, <: Vector{T}}) where T = Diagonal(ROCArray(D.diag))

function LinearAlgebra.inv(D::Diagonal{T, <: ROCArray{T}}) where T
    Di = map(inv, D.diag)
    any(isinf, Di) && error("Singular Exception $Di")
    Diagonal(Di)
end

function Base.:/(A::ROCArray, D::Diagonal)
    B = similar(A, typeof(oneunit(eltype(A)) / oneunit(eltype(D))))
    _rdiv!(B, A, D)
end

function _rdiv!(B::ROCArray, A::ROCArray, D::Diagonal)
    m, n = size(A, 1), size(A, 2)
    (k = length(D.diag)) != n && throw(DimensionMismatch(
        "left hand side has $n columns but D is $k by $k"))

    B .= A * inv(D)
    return B
end

if VERSION ≥ v"1.12-"
    # Otherwise, dispatches to:
    # https://github.com/JuliaLang/LinearAlgebra.jl/blob/4e7c3f40316a956119ac419a97c4b8aad7a17e6c/src/generic.jl#L2092
    LinearAlgebra.copytrito!(B::Matrix{T}, A::ROCMatrix{T}, uplo::AbstractChar) where {T <: ROCBLASFloat} =
        invoke(LinearAlgebra.copytrito!, Tuple{AbstractMatrix, AbstractMatrix, AbstractChar}, B, A, uplo)
end

function LinearAlgebra.lmul!(A::Diagonal{T,<:ROCVector{T}}, B::ROCMatrix{T}) where {T<:ROCBLASFloat}
    return dgmm!('L', B, A.diag, B)
end

function LinearAlgebra.rmul!(A::ROCMatrix{T}, B::Diagonal{T,<:ROCVector{T}}) where {T<:ROCBLASFloat}
    return dgmm!('R', A, B.diag, A)
end

# eltypes do not match
function LinearAlgebra.lmul!(A::Diagonal{T,<:ROCVector{T}}, B::ROCMatrix) where {T<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
function LinearAlgebra.lmul!(A::Diagonal{Td,<:ROCVector{Td}}, B::Transpose{Tt, <:ROCMatrix{Tt}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
function LinearAlgebra.lmul!(A::Diagonal{Td,<:ROCVector{Td}}, B::Adjoint{Tt, <:ROCMatrix{Tt}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
# eltypes do not match
function LinearAlgebra.rmul!(A::ROCMatrix, B::Diagonal{T,<:ROCVector{T}}) where {T<:ROCBLASFloat}
    At = transpose(A)
    @. At = B.diag * At
    return A
end
function LinearAlgebra.rmul!(A::Transpose{Tt, <:ROCMatrix{Tt}}, B::Diagonal{Td,<:ROCVector{Td}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    At = parent(A)
    @. At = B.diag * At
    return transpose(At)
end
function LinearAlgebra.rmul!(A::Adjoint{Tt, <:ROCMatrix{Tt}}, B::Diagonal{Td,<:ROCVector{Td}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    At = parent(A)
    @. At = adjoint(B.diag) * At
    return adjoint(At)
end
