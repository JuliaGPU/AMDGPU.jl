for (fname, elty) in (
    (:rocsolver_sgeqrf, :Float32),
    (:rocsolver_dgeqrf, :Float64),
    (:rocsolver_cgeqrf, :ComplexF32),
    (:rocsolver_zgeqrf, :ComplexF64),
)
    @eval begin
        function geqrf!(A::ROCMatrix{$elty})
            m, n = size(A)
            lda = max(1, stride(A, 2))

            ipiv = ROCVector{$elty}(undef, min(m, n))
            $fname(rocBLAS.handle(), m, n, A, lda, ipiv) |> check
            A, ipiv
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sormqr, Float32),
    (:rocsolver_dormqr, Float64),
    (:rocsolver_cunmqr, ComplexF32),
    (:rocsolver_zunmqr, ComplexF64),
)
    @eval begin
        function ormqr!(
            side::Char, trans::Char, A::ROCMatrix{$elty},
            τ::ROCVector{$elty}, C::ROCVecOrMat{$elty},
        )
            trans = ($elty <: Real && trans == 'C') ? 'T' : trans
            chkside(side)
            chktrans(trans)

            m, n = (ndims(C) == 2) ? size(C) : (size(C, 1), 1)
            k = length(τ)
            mA  = size(A, 1)

            side == 'L' && m != mA && throw(DimensionMismatch(
                "for a left-sided multiplication, the first dimension of C, $m, must equal the second dimension of A, $mA"))
            side == 'R' && n != mA && throw(DimensionMismatch(
                "for a right-sided multiplication, the second dimension of C, $m, must equal the second dimension of A, $mA"))
            side == 'L' && k > m && throw(DimensionMismatch(
                "invalid number of reflectors: k = $k should be <= m = $m"))
            side == 'R' && k > n && throw(DimensionMismatch(
                "invalid number of reflectors: k = $k should be <= n = $n"))

            lda = max(1, stride(A, 2))
            ldc = max(1, stride(C, 2))
            $fname(
                rocBLAS.handle(), rocBLAS.rocblasside(side), rocBLAS.rocblasop(trans),
                m, n, k, A, lda, τ, C, ldc) |> check
            C
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgetrf, Float32),
    (:rocsolver_dgetrf, Float64),
    (:rocsolver_cgetrf, ComplexF32),
    (:rocsolver_zgetrf, ComplexF64),
)
    @eval begin
        function getrf!(A::ROCMatrix{$elty})
            m, n = size(A)
            lda = max(1, stride(A, 2))

            ipiv = ROCArray{Cint}(undef, min(m, n))
            devinfo = ROCArray{Cint}(undef, 1)
            $fname(rocBLAS.handle(), m, n, A, lda, ipiv, devinfo) |> check

            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))

            A, ipiv, info
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgetrs, Float32),
    (:rocsolver_dgetrs, Float64),
    (:rocsolver_cgetrs, ComplexF32),
    (:rocsolver_zgetrs, ComplexF64),
)
    @eval begin
        function getrs!(
            trans::Char, A::ROCMatrix{$elty}, ipiv::ROCVector{Cint},
            B::ROCVecOrMat{$elty}
        )
            trans = ($elty <: Real && trans == 'C') ? 'T' : trans
            chktrans(trans)
            n = checksquare(A)

            size(B, 1) != n && throw(DimensionMismatch(
                "first dimension of B, $(size(B,1)), must match dimension of A, $n"))
            length(ipiv) != n && throw(DimensionMismatch(
                "length of ipiv, $(length(ipiv)), must match dimension of A, $n"))

            nrhs = size(B, 2)
            lda = max(1, stride(A, 2))
            ldb = max(1, stride(B, 2))

            $fname(
                rocBLAS.handle(), rocBLAS.rocblasop(trans),
                n, nrhs, A, lda, ipiv, B, ldb) |> check
            B
        end
    end
end

# Conversions.

AMDGPU.ROCArray(Q::AbstractQ) = ROCMatrix(Q)
AMDGPU.ROCArray{T}(Q::AbstractQ) where T = ROCMatrix{T}(Q)

AMDGPU.ROCMatrix(Q::AbstractQ{T}) where T = ROCMatrix{T}(Q)
AMDGPU.ROCMatrix{T}(Q::QRPackedQ{S}) where {T, S} =
    ROCMatrix{T}(lmul!(Q, ROCMatrix{S}(I, size(Q, 1), min(size(Q.factors)...))))
AMDGPU.ROCMatrix{T, B}(Q::QRPackedQ{S}) where {T, B, S} = ROCMatrix{T}(Q)
AMDGPU.ROCMatrix{T}(Q::QRCompactWYQ) where T = error("QRCompactWY format is not supported.")

Matrix{T}(Q::QRPackedQ{S ,<:ROCArray, <:ROCArray}) where {T, S} = Array(ROCMatrix{T}(Q))
Matrix{T}(Q::QRCompactWYQ{S, <:ROCArray, <:ROCArray}) where {T, S} = Array(ROCMatrix{T}(Q))

if VERSION < v"1.10-"
    function Base.collect(src::Union{
        QRPackedQ{<:Any, <:ROCArray, <:ROCArray},
        QRCompactWYQ{<:Any, <:ROCArray, <:ROCArray}}
    )
        dest = similar(src)
        copyto!(dest, I)
        lmul!(src, dest)
        collect(dest)
    end

    function Base.similar(
        src::Union{
            QRPackedQ{<:Any, <:ROCArray, <:ROCArray},
            QRCompactWYQ{<:Any, <:ROCArray, <:ROCArray}},
        ::Type{T}, dims::Dims{N},
    ) where {T, N}
        ROCArray{T, N}(undef, dims)
    end
end

function Base.getindex(Q::QRPackedQ{<:Any, <:ROCArray}, ::Colon, j::Int)
    y = AMDGPU.zeros(eltype(Q), size(Q, 2))
    y[j] = 1
    lmul!(Q, y)
end

const ROCMatOrAdj{T} = Union{
    ROCMatrix{T},
    LinearAlgebra.Adjoint{T, <:ROCMatrix{T}},
    LinearAlgebra.Transpose{T, <:ROCMatrix{T}}}

const ROCOrAdj{T} = Union{
    ROCVecOrMat{T},
    LinearAlgebra.Adjoint{T, <:ROCVecOrMat{T}},
    LinearAlgebra.Transpose{T, <:ROCVecOrMat{T}}}

function copy_rocblasfloat(As...)
    eltypes = eltype.(As)
    promoted_eltype = reduce(promote_type, eltypes)
    rocblasfloat = promote_type(Float32, promoted_eltype)
    rocblasfloat <: rocBLAS.ROCBLASFloat ||
        throw(ArgumentError("Cannot promote eltypes `$eltypes` to a ROCBLAS float type `$(rocBLAS.ROCBLASFloat)`."))

    out = _copywitheltype(rocblasfloat, As...)
    length(out) == 1 && return first(out)
    return out
end

_copywitheltype(::Type{T}, As...) where T = map(A -> copyto!(similar(A, T), A), As)

function Base.:\(_A::ROCMatOrAdj, _B::ROCOrAdj)
    A, B = copy_rocblasfloat(_A, _B)
    T = eltype(A)
    n, m = size(A)

    if n < m # LQ decomposition
        F, τ = geqrf!(ROCMatrix(A'))
        if B isa ROCVector{T}
            rocBLAS.trsv!('U', 'C', 'N', F[1:n, 1:n], B) # TODO use @view
            X = AMDGPU.zeros(T, m)
            view(X, 1:n) .= B
        else
            rocBLAS.trsm!('L', 'U', 'C', 'N', one(T), F[1:n, 1:n], B) # TODO use @view
            X = AMDGPU.zeros(T, m, size(B, 2))
            view(X, 1:n, :) .= B
        end
        ormqr!('L', 'N', F, τ, X)
    elseif n == m # LU decomposition with partial pivoting
        F, p, _ = getrf!(A)
        X = getrs!('N', F, p, B)
    else # QR decomposition
        F, τ = geqrf!(A)
        ormqr!('L', 'C', F, τ, B)
        if B isa ROCVector{T}
            X = B[1:m]
            rocBLAS.trsv!('U', 'N', 'N', F[1:m, 1:m], X) # TODO use @view
        else
            X = B[1:m, :]
            rocBLAS.trsm!('L', 'U', 'N', 'N', one(T), F[1:m, 1:m], X) # TODO use @view
        end
    end
    return X
end

LinearAlgebra.qr!(A::ROCMatrix{T}) where T = QR(geqrf!(A)...)

LinearAlgebra.lmul!(
    A::QRPackedQ{T,<:ROCArray,<:ROCArray}, B::ROCVecOrMat{T},
) where T =
    ormqr!('L', 'N', A.factors, A.τ, B)

LinearAlgebra.lmul!(
    adjA::Adjoint{T,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
    B::ROCVecOrMat{T},
) where T <: rocBLAS.ROCBLASReal =
    ormqr!('L', 'T', parent(adjA).factors, parent(adjA).τ, B)

LinearAlgebra.lmul!(
    adjA::Adjoint{T,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
    B::ROCVecOrMat{T},
) where T <: rocBLAS.ROCBLASComplex =
    ormqr!('L', 'C', parent(adjA).factors, parent(adjA).τ, B)

LinearAlgebra.lmul!(
    trA::Transpose{T,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
    B::ROCVecOrMat{T},
) where T <: rocBLAS.ROCBLASFloat =
    ormqr!('L', 'T', parent(trA).factors, parent(trA).τ, B)

LinearAlgebra.rmul!(
    A::ROCVecOrMat{T},
    B::QRPackedQ{T,<:ROCArray,<:ROCArray},
) where T <: rocBLAS.ROCBLASFloat =
    ormqr!('R', 'N', B.factors, B.τ, A)

LinearAlgebra.rmul!(
    A::ROCVecOrMat{T},
    adjB::Adjoint{<:Any,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
) where T <: rocBLAS.ROCBLASReal =
    ormqr!('R', 'T', parent(adjB).factors, parent(adjB).τ, A)

LinearAlgebra.rmul!(
    A::ROCVecOrMat{T},
    adjB::Adjoint{<:Any,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
) where T <: rocBLAS.ROCBLASComplex =
    ormqr!('R', 'C', parent(adjB).factors, parent(adjB).τ, A)

LinearAlgebra.rmul!(
    A::ROCVecOrMat{T},
    trA::Transpose{<:Any,<:QRPackedQ{T,<:ROCArray,<:ROCArray}},
) where T <: rocBLAS.ROCBLASFloat =
    ormqr!('R', 'T', parent(trA).factors, parent(adjB).τ, A)

function LinearAlgebra.ldiv!(_qr::QR, b::ROCVector)
    m, n = size(_qr)
    _x = UpperTriangular(_qr.R[1:min(m, n), 1:n]) \ ((_qr.Q' * b)[1:n])
    b[1:n] .= _x
    AMDGPU.unsafe_free!(_x)
    return b[1:n]
end

function LinearAlgebra.ldiv!(_qr::QR, B::ROCMatrix)
    m,n = size(_qr)
    _x = UpperTriangular(_qr.R[1:min(m,n), 1:n]) \ ((_qr.Q' * B)[1:n, 1:size(B, 2)])
    B[1:n, 1:size(B, 2)] .= _x
    AMDGPU.unsafe_free!(_x)
    return B[1:n, 1:size(B, 2)]
end

function LinearAlgebra.ldiv!(x::ROCArray, _qr::QR, b::ROCArray)
    _x = ldiv!(_qr, b)
    x .= vec(_x)
    AMDGPU.unsafe_free!(_x)
    return x
end

# LAPACK

for elty in (:Float32, :Float64, :ComplexF32, :ComplexF64)
    @eval begin
        LinearAlgebra.LAPACK.geqrf!(A::ROCMatrix{$elty}) = rocSOLVER.geqrf!(A)
        LinearAlgebra.LAPACK.getrf!(A::ROCMatrix{$elty}) = rocSOLVER.getrf!(A)
        LinearAlgebra.LAPACK.getrs!(
            trans::Char, A::ROCMatrix{$elty}, ipiv::ROCVector{Cint},
            B::ROCVecOrMat{$elty},
        ) = rocSOLVER.getrs!(trans, A, ipiv, B)
        LinearAlgebra.LAPACK.ormqr!(
            side::Char, trans::Char, A::ROCMatrix{$elty},
            tau::ROCVector{$elty}, C::ROCVecOrMat{$elty},
        ) = rocSOLVER.ormqr!(side, trans, A, tau, C)
    end
end
