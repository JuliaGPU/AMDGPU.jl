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
            m, n = (ndims(C) == 2) ? size(C) : (size(C, 1), 1)
            k = length(τ)
            lda = max(1, stride(A, 2))
            ldc = max(1, stride(C, 2))
            $fname(
                rocBLAS.handle(), rocBLAS.rocblasside(side),
                rocBLAS.rocblasop(trans), m, n, k, A, lda, τ, C, ldc) |> check
            C
        end
    end
end

ROCMatrix{T}(Q::QRPackedQ{S}) where {T, S} =
    ROCMatrix{T}(lmul!(Q, ROCMatrix{S}(I, size(Q, 1), min(size(Q.factors)...))))
ROCMatrix{T, B}(Q::QRPackedQ{S}) where {T, B, S} = ROCMatrix{T}(Q)

Matrix{T}(Q::QRPackedQ{S ,<:ROCArray, <:ROCArray}) where {T, S} = Array(ROCMatrix{T}(Q))
Matrix{T}(Q::QRCompactWYQ{S, <:ROCArray, <:ROCArray}) where {T, S} = Array(ROCMatrix{T}(Q))

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

function Base.getindex(Q::QRPackedQ{<:Any, <:ROCArray}, ::Colon, j::Int)
    y = AMDGPU.zeros(eltype(Q), size(Q, 2))
    y[j] = 1
    lmul!(Q, y)
end

# TODO
# - ldiv

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
