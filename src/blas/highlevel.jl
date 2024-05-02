rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

const ROCBLASArray{T<:ROCBLASFloat} = ROCArray{T}

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

#
# BLAS 2
#

if VERSION ≥ v"1.10-"
    # multiplication
    LinearAlgebra.generic_trimatmul!(
        c::ROCVector{T}, uploc, isunitc, tfun::Function,
        A::ROCMatrix{T}, b::ROCVector{T},
    ) where T <: ROCBLASFloat = trmv!(
        uploc, tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C',
        isunitc, A, c === b ? c : copyto!(c, b))
    # division
    LinearAlgebra.generic_trimatdiv!(
        C::ROCVector{T}, uploc, isunitc, tfun::Function,
        A::ROCMatrix{T}, B::ROCVector{T},
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

# GEMV

function LinearAlgebra.generic_matvecmul!(
    Y::ROCVector, tA::AbstractChar, A::StridedROCMatrix, B::StridedROCVector,
    _add::MulAddMul,
)
    mA, nA = tA == 'N' ? size(A) : reverse(size(A))

    nA != length(B) && throw(DimensionMismatch(
        "second dimension of A, $nA, does not match length of B, $(length(B))"))
    mA != length(Y) && throw(DimensionMismatch(
        "first dimension of A, $mA, does not match length of Y, $(length(Y))"))

    mA == 0 && return Y
    nA == 0 && return rmul!(Y, 0)

    T = eltype(Y)
    alpha, beta = _add.alpha, _add.beta
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
    LinearAlgebra.generic_matmatmul!(Y, tA, 'N', A, B, MulAddMul(alpha, beta))
end

if VERSION < v"1.10.0-DEV.1365"
    @inline LinearAlgebra.gemv!(
        Y::ROCVector, tA::AbstractChar, A::StridedROCMatrix,
        B::StridedROCVector, a::Number, b::Number,
    ) = LinearAlgebra.generic_matvecmul!(Y, tA, A, B, MulAddMul(a, b))

    # disambiguation with LinearAlgebra.jl
    @inline LinearAlgebra.gemv!(
        Y::ROCVector{T}, tA::AbstractChar, A::StridedROCMatrix{T},
        B::StridedROCVector{T}, a::Number, b::Number,
    ) where T <: ROCBLASFloat =
        LinearAlgebra.generic_matvecmul!(Y, tA, A, B, MulAddMul(a, b))
end

#
# BLAS 3
#

function LinearAlgebra.generic_matmatmul!(
    C::StridedROCVecOrMat, tA, tB, A::StridedROCVecOrMat,
    B::StridedROCVecOrMat, _add::MulAddMul,
)
    T = eltype(C)
    alpha, beta = _add.alpha, _add.beta
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

if VERSION ≥ v"1.10-"
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
        StridedROCMatrix{T}, AdjOrTrans{<: T, <: StridedROCMatrix}}

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
else
    for (t, uploc, isunitc) in (
        (:LowerTriangular, 'L', 'N'),
        (:UnitLowerTriangular, 'L', 'U'),
        (:UpperTriangular, 'U', 'N'),
        (:UnitUpperTriangular, 'U', 'U'),
    )
        @eval begin
        LinearAlgebra.lmul!(
            A::$t{T, <: StridedROCMatrix},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B, B)
        LinearAlgebra.rmul!(
            A::StridedROCMatrix{T},
            B::$t{T, <: StridedROCMatrix},
        ) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'N', $isunitc, one(T), parent(B), A, A)

        LinearAlgebra.ldiv!(
            A::$t{T, <: StridedROCMatrix},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'N', $isunitc, one(T), parent(A), B)
        LinearAlgebra.rdiv!(
            A::StridedROCMatrix{T},
            B::$t{T, <: StridedROCMatrix},
        ) where T <: ROCBLASFloat =
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
        LinearAlgebra.lmul!(
            A::$t{<: Any, <: Transpose{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B, B)
        LinearAlgebra.lmul!(
            A::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trmm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B, B)
        LinearAlgebra.lmul!(
            A::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASComplex =
            trmm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B, B)

        LinearAlgebra.rmul!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Transpose{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A, A)
        LinearAlgebra.rmul!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASFloat =
            trmm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A, A)
        LinearAlgebra.rmul!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASComplex =
            trmm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A, A)

        # Left division.
        LinearAlgebra.ldiv!(
            A::$t{<: Any, <: Transpose{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
        LinearAlgebra.ldiv!(
            A::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASFloat =
            trsm!('L', $uploc, 'T', $isunitc, one(T), parent(parent(A)), B)
        LinearAlgebra.ldiv!(
            A::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
            B::StridedROCMatrix{T},
        ) where T <: ROCBLASComplex =
            trsm!('L', $uploc, 'C', $isunitc, one(T), parent(parent(A)), B)

        # Right division.
        LinearAlgebra.rdiv!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Transpose{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASFloat =
            trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
        LinearAlgebra.rdiv!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASFloat =
            trsm!('R', $uploc, 'T', $isunitc, one(T), parent(parent(B)), A)
        LinearAlgebra.rdiv!(
            A::StridedROCMatrix{T},
            B::$t{<: Any, <: Adjoint{T, <: StridedROCMatrix}},
        ) where T <: ROCBLASComplex =
            trsm!('R', $uploc, 'C', $isunitc, one(T), parent(parent(B)), A)
        end
    end
end
