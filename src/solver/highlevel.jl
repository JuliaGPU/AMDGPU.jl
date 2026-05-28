for (fname, elty) in (
    (:rocsolver_spotrf, :Float32),
    (:rocsolver_dpotrf, :Float64),
    (:rocsolver_cpotrf, :ComplexF32),
    (:rocsolver_zpotrf, :ComplexF64),
)
    @eval begin
        function potrf!(uplo::Char, A::StridedROCMatrix{$elty})
            chkuplo(uplo)
            n = checksquare(A)
            lda = max(1, stride(A, 2))

            devinfo = ROCVector{Cint}(undef, 1)
            $fname(rocBLAS.handle(), uplo, n, A, lda, devinfo)

            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))

            A, info
        end
    end
end

for (fname, elty) in (
    (:rocsolver_spotrs, :Float32),
    (:rocsolver_dpotrs, :Float64),
    (:rocsolver_cpotrs, :ComplexF32),
    (:rocsolver_zpotrs, :ComplexF64),
)
    @eval begin
        function potrs!(uplo::Char, A::ROCMatrix{$elty}, B::ROCVecOrMat{$elty})
            chkuplo(uplo)
            n = checksquare(A)
            m, nrhs = size(B)
            (m == n) || throw(DimensionMismatch("first dimension of B, $m, must match second dimension of A, $n"))
            lda  = max(1, stride(A, 2))
            ldb  = max(1, stride(B, 2))
            $fname(rocBLAS.handle(), uplo, n, nrhs, A, lda, B, ldb)

            B
        end
    end
end

for (fname, elty) in (
    (:rocsolver_ssytrf, :Float32),
    (:rocsolver_dsytrf, :Float64),
    (:rocsolver_csytrf, :ComplexF32),
    (:rocsolver_zsytrf, :ComplexF64),
)
    @eval begin
        function sytrf!(uplo::Char, A::ROCMatrix{$elty})
            m, n = size(A)
            ipiv = ROCVector{Cint}(undef, n)
            sytrf!(uplo, A, ipiv)
        end

        function sytrf!(uplo::Char, A::ROCMatrix{$elty}, ipiv::ROCVector{Cint})
            chkuplo(uplo)
            n = checksquare(A)
            lda = max(1, stride(A, 2))

            devinfo = ROCVector{Cint}(undef, 1)
            $fname(rocBLAS.handle(), uplo, n, A, lda, ipiv, devinfo)

            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))

            A, ipiv, info
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgeqrf, :Float32),
    (:rocsolver_dgeqrf, :Float64),
    (:rocsolver_cgeqrf, :ComplexF32),
    (:rocsolver_zgeqrf, :ComplexF64),
)
    @eval begin
        function geqrf!(A::ROCMatrix{$elty})
            m, n = size(A)
            tau = ROCVector{$elty}(undef, min(m, n))
            geqrf!(A, tau)
        end

        function geqrf!(A::ROCMatrix{$elty}, tau::ROCVector{$elty})
            m, n = size(A)
            lda = max(1, stride(A, 2))
            $fname(rocBLAS.handle(), m, n, A, lda, tau)
            A, tau
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sormqr, :Float32),
    (:rocsolver_dormqr, :Float64),
    (:rocsolver_cunmqr, :ComplexF32),
    (:rocsolver_zunmqr, :ComplexF64),
)
    @eval begin
        function ormqr!(
            side::Char, trans::Char, A::ROCMatrix{$elty},
            τ::ROCVector{$elty}, C::ROCVecOrMat{$elty},
        )
            $elty <: Complex && trans == 'T' && throw(ArgumentError(
                "rocSOLVER.ormqr! supports only 'N' or 'C' for Complex types, " *
                "but `$trans` was passed."))

            trans = ($elty <: Real && trans == 'C') ? 'T' : trans

            chkside(side)
            chktrans(trans)

            m, n = (ndims(C) == 2) ? size(C) : (length(C), 1)
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
            $fname(rocBLAS.handle(), side, trans, m, n, k, A, lda, τ, C, ldc)
            return C
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sorgqr, :Float32),
    (:rocsolver_dorgqr, :Float64),
    (:rocsolver_cungqr, :ComplexF32),
    (:rocsolver_zungqr, :ComplexF64),
)
    @eval begin
        function orgqr!(A::ROCMatrix{$elty}, tau::ROCVector{$elty})
            m, n = size(A)
            lda = max(1, stride(A, 2))
            k = length(tau)
            $fname(rocBLAS.handle(), m, n, k, A, lda, tau)
            A
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgetrf, :Float32),
    (:rocsolver_dgetrf, :Float64),
    (:rocsolver_cgetrf, :ComplexF32),
    (:rocsolver_zgetrf, :ComplexF64),
)
    @eval begin
        function getrf!(A::ROCMatrix{$elty})
            m, n = size(A)
            ipiv = ROCArray{Cint}(undef, min(m, n))
            getrf!(A, ipiv)
        end

        function getrf!(A::ROCMatrix{$elty}, ipiv::ROCVector{Cint})
            m, n = size(A)
            lda = max(1, stride(A, 2))

            devinfo = ROCArray{Cint}(undef, 1)
            $fname(rocBLAS.handle(), m, n, A, lda, ipiv, devinfo)

            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))

            A, ipiv, info
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgetrs, :Float32),
    (:rocsolver_dgetrs, :Float64),
    (:rocsolver_cgetrs, :ComplexF32),
    (:rocsolver_zgetrs, :ComplexF64),
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

            $fname(rocBLAS.handle(), trans, n, nrhs, A, lda, ipiv, B, ldb)
            B
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgeblttrf_npvt, :Float32),
    (:rocsolver_dgeblttrf_npvt, :Float64),
    (:rocsolver_cgeblttrf_npvt, :ComplexF32),
    (:rocsolver_zgeblttrf_npvt, :ComplexF64),
)
    @eval begin
        function geblttrf!(A::ROCArray{$elty,3}, B::ROCArray{$elty,3}, C::ROCArray{$elty,3})
            mA, nA, nblocksA = size(A)
            mB, nB, nblocksB = size(B)
            mC, nC, nblocksC = size(C)
            (mA == nA == mB == nB == mC == nC) || throw(DimensionMismatch("The first two dimensions of A, B and C must match"))
            (nblocksA == nblocksB - 1 == nblocksC) || throw(DimensionMismatch("Inconsistency for the last dimension of A, B and C"))

            lda = max(1, stride(A, 2))
            ldb = max(1, stride(B, 2))
            ldc = max(1, stride(C, 2))

            devinfo = ROCArray{Cint}(undef, 1)
            $fname(rocBLAS.handle(), mB, nblocksB, A, lda, B, ldb, C, ldc, devinfo)
            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))
            B, C
        end
    end
end

for (fname, elty) in (
    (:rocsolver_sgeblttrs_npvt, :Float32),
    (:rocsolver_dgeblttrs_npvt, :Float64),
    (:rocsolver_cgeblttrs_npvt, :ComplexF32),
    (:rocsolver_zgeblttrs_npvt, :ComplexF64),
)
    @eval begin
        function geblttrs!(A::ROCArray{$elty,3}, B::ROCArray{$elty,3}, C::ROCArray{$elty,3}, X::ROCArray{$elty,3})
            mA, nA, nblocksA = size(A)
            mB, nB, nblocksB = size(B)
            mC, nC, nblocksC = size(C)
            mX, nblocksX, nrhs = size(X)
            (mA == nA == mB == nB == mC == nC) || throw(DimensionMismatch("The first two dimensions of A, B and C must match"))
            (mX == mA) || throw(DimensionMismatch("The first dimension of X is inconsistent with first two dimensions of A, B and C"))
            (nblocksA == nblocksB - 1 == nblocksX - 1 == nblocksC) || throw(DimensionMismatch("Inconsistency for the number of blocks in A, B, C and X"))

            lda = max(1, stride(A, 2))
            ldb = max(1, stride(B, 2))
            ldc = max(1, stride(C, 2))
            ldx = max(1, stride(X, 2))

            $fname(rocBLAS.handle(), mB, nblocksB, nrhs, A, lda, B, ldb, C, ldc, X, ldx)
            X
        end
    end
end

for (fname, elty, relty) in ((:rocsolver_sgebrd, :Float32   , :Float32),
                             (:rocsolver_dgebrd, :Float64   , :Float64),
                             (:rocsolver_cgebrd, :ComplexF32, :Float32),
                             (:rocsolver_zgebrd, :ComplexF64, :Float64))
    @eval begin
        function gebrd!(A:: ROCMatrix{$elty})
            m, n = size(A)
            lda  = max(1, stride(A, 2))
            k    = min(m, n)
            D    = ROCVector{$relty}(undef, k)
            E    = ROCVector{$relty}(undef, k-1)
            tauq = ROCVector{$elty}(undef, k)
            taup = ROCVector{$elty}(undef, k)

            $fname(rocBLAS.handle(), m, n, A, lda, D, E, tauq, taup)
            A, D, E, tauq, taup
        end
    end
end

for (fname, elty, relty) in ((:rocsolver_sgesvd, :Float32, :Float32),
                             (:rocsolver_dgesvd, :Float64, :Float64),
                             (:rocsolver_cgesvd, :ComplexF32, :Float32),
                             (:rocsolver_zgesvd, :ComplexF64, :Float64))
    @eval begin
        function gesvd!(jobu::Char,
                        jobvt::Char,
                        A::ROCMatrix{$elty})
            m, n = size(A)
            k = min(m, n)
            lda = max(1, stride(A, 2))

            U = if jobu === 'A'
                ROCMatrix{$elty}(undef, m, m)
            elseif jobu === 'S'
                ROCMatrix{$elty}(undef, m, k)
            elseif jobu === 'N' || jobu === 'O'
                C_NULL
            else
                error("jobu must be one of 'A', 'S', 'O', or 'N'")
            end
            ldu = U == C_NULL ? 1 : max(1, stride(U, 2))

            S = ROCVector{$relty}(undef, k)

            Vt = if jobvt === 'A'
                ROCMatrix{$elty}(undef, n, n)
            elseif jobvt === 'S'
                ROCMatrix{$elty}(undef, k, n)
            elseif jobvt === 'N' || jobvt === 'O'
                C_NULL
            else
                error("jobvt must be one of 'A', 'S', 'O', or 'N'")
            end
            ldvt = Vt == C_NULL ? 1 : max(1, stride(Vt, 2))

            E = ROCVector{$relty}(undef, k-1)
            devinfo = ROCArray{Cint}(undef, 1)
            $fname(rocBLAS.handle(), jobu, jobvt, m, n, A, lda, S, U, ldu, Vt, ldvt, E, 'I', devinfo)

            info = AMDGPU.@allowscalar devinfo[1]
            AMDGPU.unsafe_free!(devinfo)
            chkargsok(BlasInt(info))

            return U, S, Vt
        end
    end
end

for (jname, fname, elty, relty) in (
    (:syevd!, :rocsolver_dsyevd, :Float64   , :Float64),
    (:syevd!, :rocsolver_ssyevd, :Float32   , :Float32),
    (:heevd!, :rocsolver_zheevd, :ComplexF64, :Float64),
    (:heevd!, :rocsolver_cheevd, :ComplexF32, :Float32),
)
    @eval begin
        function $jname(uplo::Char, A::ROCMatrix{$elty})
            chkuplo(uplo)

            n = size(A, 2)
            lda = max(1, stride(A, 2))

            D = ROCVector{$relty}(undef, n)
            E = ROCVector{$relty}(undef, n)

            dev_info = ROCVector{Cint}(undef, 1)

            $fname(
                rocBLAS.handle(),
                rocblas_evect_original,
                uplo,
                n, A, lda,
                D, E,
                dev_info
            )

            info = AMDGPU.@allowscalar dev_info[1]
            AMDGPU.unsafe_free!(dev_info)

            AMDGPU.unsafe_free!(E)

            D, A
        end
    end
end

for (fname, matrix_elty, vector_elty) in (
    (:rocsolver_zgesvdj, :ComplexF64, :Float64),
    (:rocsolver_cgesvdj, :ComplexF32, :Float32),
    (:rocsolver_dgesvdj, :Float64, :Float64),
    (:rocsolver_sgesvdj, :Float32, :Float32),
)
    @eval begin
        function gesvdj!(A::ROCMatrix{$matrix_elty}, abstol::$vector_elty, max_sweeps::Cint; jobu::Char='A',
                        jobvt::Char='A')
            m, n = size(A)
            lda = max(1, stride(A, 2))
            dev_residual = ROCVector{$vector_elty}(undef, 1)
            dev_n_sweeps = ROCVector{Cint}(undef, 1)
            S = ROCArray{$vector_elty}(undef, min(m, n))
            dev_info = ROCVector{Cint}(undef, 1)
            ldv = min(m, n)
            k=ldv
            ldu = m
            
             V = if jobvt === 'A'
                ROCMatrix{$matrix_elty}(undef, (n, n))
            elseif jobvt === 'S'
                ROCMatrix{$matrix_elty}(undef, (n, k))
            elseif jobvt === 'N' || jobvt === 'O'
                C_NULL
            else
                error("jobvt must be one of 'A', 'S', 'O', or 'N'")
            end
             U = if jobu === 'A'
                ROCMatrix{$matrix_elty}(undef, (m, m))
            elseif jobu === 'S'
                ROCMatrix{$matrix_elty}(undef, (m, k))
            elseif jobu === 'N' || jobu === 'O'
                C_NULL
            else
                error("jobu must be one of 'A', 'S', 'O', or 'N'")
            end

            
            $fname(
                rocBLAS.handle(),
                jobu,
                jobvt,
                m, n, A, lda,
                abstol,
                dev_residual,
                max_sweeps,
                dev_n_sweeps,
                S,
                U, ldu,
                V, ldv,
                dev_info
            )
            residual = AMDGPU.@allowscalar dev_residual[1]
            AMDGPU.unsafe_free!(dev_residual)

            n_sweeps = AMDGPU.@allowscalar dev_n_sweeps[1]
            AMDGPU.unsafe_free!(dev_n_sweeps)

            info = AMDGPU.@allowscalar dev_info[1]
            AMDGPU.unsafe_free!(dev_info)

            U, S, (jobvt === 'N' || jobvt === 'O') ? V : V', residual, n_sweeps, info
        end
    end
end

for (fname, elty) in
        ((:rocsolver_dgetrf_batched,:Float64),
         (:rocsolver_sgetrf_batched,:Float32),
         (:rocsolver_zgetrf_batched,:ComplexF64),
         (:rocsolver_cgetrf_batched,:ComplexF32))
    @eval begin
        function getrf_batched!(A::Vector{<:ROCMatrix{$elty}})
            nb = length(A)
            m,n = size(A[1])
            ipiv = ROCVector{Cint}(undef, nb*n)
            getrf_batched!(A, ipiv)
        end

        function getrf_batched!(A::Vector{<:ROCMatrix{$elty}}, ipiv::ROCVector{Cint})
            m,n = size(A[1])
            lda = max(1, stride(A[1], 2))
            strideP = min(m,n)
            batch_count = length(A)
            info = ROCVector{Cint}(undef, batch_count)
            Aptrs = device_batch(A)
            $fname(rocBLAS.handle(), m, n, Aptrs, lda, ipiv, strideP, info, batch_count)

            flags = AMDGPU.@allowscalar collect(info)
            AMDGPU.unsafe_free!(info)
            return ipiv, flags, A
        end
    end
end

for (fname, elty) in
    ((:rocsolver_dgetri_batched, :Float64),
     (:rocsolver_sgetri_batched, :Float32),
     (:rocsolver_zgetri_batched, :ComplexF64),
     (:rocsolver_cgetri_batched, :ComplexF32))
    @eval begin
        function getri_batched!(A::Vector{<:ROCMatrix{$elty}}, ipiv::ROCVector{Cint})
            n = checksquare(A[1])
            lda = max(1, stride(A[1], 2))
            strideP = n
            batch_count = length(A)
            info = ROCVector{Cint}(undef, batch_count)
            Aptrs = device_batch(A)
            $fname(rocBLAS.handle(), n, Aptrs, lda, ipiv, strideP, info, batch_count)

            flags = AMDGPU.@allowscalar collect(info)
            AMDGPU.unsafe_free!(info)
            return ipiv, flags, A
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
        LinearAlgebra.LAPACK.potrf!(uplo::Char, A::StridedROCMatrix{$elty}) = rocSOLVER.potrf!(uplo, A)
        LinearAlgebra.LAPACK.potrs!(uplo::Char, A::ROCMatrix{$elty}, B::ROCVecOrMat{$elty}) = rocSOLVER.potrs!(uplo, A, B)
        LinearAlgebra.LAPACK.sytrf!(uplo::Char, A::ROCMatrix{$elty}) = rocSOLVER.sytrf!(uplo, A)
        LinearAlgebra.LAPACK.sytrf!(uplo::Char, A::ROCMatrix{$elty}, ipiv::ROCVector{Cint}) = rocSOLVER.sytrf!(uplo, A, ipiv)
        LinearAlgebra.LAPACK.geqrf!(A::ROCMatrix{$elty}) = rocSOLVER.geqrf!(A)
        LinearAlgebra.LAPACK.geqrf!(A::ROCMatrix{$elty}, tau::ROCVector{$elty}) = rocSOLVER.geqrf!(A, tau)
        LinearAlgebra.LAPACK.getrf!(A::ROCMatrix{$elty}) = rocSOLVER.getrf!(A)
        LinearAlgebra.LAPACK.getrf!(A::ROCMatrix{$elty}, ipiv::ROCVector{Cint}) = rocSOLVER.getrf!(A, ipiv)
        LinearAlgebra.LAPACK.getrs!(trans::Char, A::ROCMatrix{$elty}, ipiv::ROCVector{Cint}, B::ROCVecOrMat{$elty}) = rocSOLVER.getrs!(trans, A, ipiv, B)
        LinearAlgebra.LAPACK.ormqr!(side::Char, trans::Char, A::ROCMatrix{$elty}, tau::ROCVector{$elty}, C::ROCVecOrMat{$elty}) = rocSOLVER.ormqr!(side, trans, A, tau, C)
        LinearAlgebra.LAPACK.orgqr!(A::ROCMatrix{$elty}, tau::ROCVector{$elty}) = rocSOLVER.orgqr!(A, tau)
        LinearAlgebra.LAPACK.gebrd!(A::ROCMatrix{$elty}) = rocSOLVER.gebrd!(A)
        LinearAlgebra.LAPACK.gesvd!(jobu::Char, jobvt::Char, A::ROCMatrix{$elty}) = rocSOLVER.gesvd!(jobu, jobvt, A)
    end
end

function LinearAlgebra.eigen(A::Symmetric{T,<:ROCMatrix}) where {T<:BlasReal}
    A2 = copy(A.data)
    Eigen(syevd!('U', A2)...)
end

function LinearAlgebra.eigen(A::Hermitian{T,<:ROCMatrix}) where {T<:BlasComplex}
    A2 = copy(A.data)
    Eigen(heevd!('U', A2)...)
end

function LinearAlgebra.eigen(A::Hermitian{T,<:ROCMatrix}) where {T<:BlasReal}
    eigen(Symmetric(A))
end

function LinearAlgebra.eigen(A::ROCMatrix{T}) where {T<:BlasReal}
    A2 = copy(A)
    issymmetric(A) ? Eigen(syevd!('U', A2)...) : error("GPU eigensolver supports only Hermitian or Symmetric matrices.")
end

function LinearAlgebra.eigen(A::ROCMatrix{T}) where {T<:BlasComplex}
    A2 = copy(A)
    ishermitian(A) ? Eigen(heevd!('U', A2)...) : error("GPU eigensolver supports only Hermitian or Symmetric matrices.")
end
