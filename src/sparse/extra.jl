export geam

"""
    geam(
        alpha::Number, A::ROCSparseMatrix, beta::Number,
        B::ROCSparseMatrix, index::SparseChar)

Performs `C = alpha * A + beta * B`. `A` and `B` are sparse matrix
defined in CSR storage format.
"""
geam(
    alpha::Number, A::ROCSparseMatrixCSR, beta::Number,
    B::ROCSparseMatrixCSR, index::SparseChar)

"""
    axpby(alpha::Number, x::ROCSparseVector, beta::Number, y::ROCSparseVector, index::SparseChar)

Performs `z = alpha * x + beta * y`. `x` and `y` are sparse vectors.
"""
axpby(alpha::Number, x::ROCSparseVector, beta::Number, y::ROCSparseVector, index::SparseChar)

for (fname, elty) in (
    (:rocsparse_scsrgeam, :Float32),
    (:rocsparse_dcsrgeam, :Float64),
    (:rocsparse_ccsrgeam, :ComplexF32),
    (:rocsparse_zcsrgeam, :ComplexF64),
)
    @eval begin
        function geam(
            alpha::Number, A₀::ROCSparseMatrixCSR{$elty}, beta::Number,
            B₀::ROCSparseMatrixCSR{$elty}, index::SparseChar)
            # (the legacy routine takes 32-bit indices)
            A, B = cint_view(A₀), cint_view(B₀)

            m, n = size(A)
            (m, n) == size(B) && DimensionMismatch("dimensions must match: a has dims $(axes(A)), b has dims $(axes(B))")
            descrA = ROCMatrixDescriptor('G', 'L', 'N', index)
            descrB = ROCMatrixDescriptor('G', 'L', 'N', index)
            descrC = ROCMatrixDescriptor('G', 'L', 'N', index)

            rowPtrC = ROCVector{Int32}(undef, m + 1)

            nnzcount_C = Ref{Cint}()
            rocsparse_csrgeam_nnz(
                handle(), m, n, descrA, nnz(A), A.rowPtr, A.colVal,
                descrB, nnz(B), B.rowPtr, B.colVal,
                descrC, rowPtrC, nnzcount_C)

            nnz_C = ROCArray{$elty}(undef, nnzcount_C[])
            colValC = ROCArray{Int32}(undef, nnzcount_C[])

            $fname(handle(), m, n,
                Ref(alpha), descrA, nnz(A), nonzeros(A), A.rowPtr, A.colVal,
                Ref(beta), descrB, nnz(B), nonzeros(B), B.rowPtr, B.colVal,
                descrC, pointer(nnz_C), rowPtrC, colValC)
            return ROCSparseMatrixCSR(rowPtrC, colValC, nnz_C, (m, n))
        end

        function geam(alpha::Number, A::ROCSparseMatrixCSC{$elty}, beta::Number, B::ROCSparseMatrixCSC{$elty}, index::SparseChar)

            m, n = size(A)
            (m, n) == size(B) || throw(DimensionMismatch("dimensions must match: A has dims $(size(A)), B has dims $(size(B))"))
            Aᵀ = ROCSparseMatrixCSR(A.colPtr, A.rowVal, A.nzVal, (n, m))
            Bᵀ = ROCSparseMatrixCSR(B.colPtr, B.rowVal, B.nzVal, (n, m))
            Cᵀ = geam(alpha, Aᵀ, beta, Bᵀ, index)

            C = ROCSparseMatrixCSC(Cᵀ.rowPtr, Cᵀ.colVal, Cᵀ.nzVal, (m, n))
            return C
        end

        function axpby(alpha::Number, x::ROCSparseVector{$elty,Ti}, beta::Number, y::ROCSparseVector{$elty,Ti}, index::SparseChar) where {Ti}
            n = length(x)
            n == length(y) || throw(DimensionMismatch("dimensions must match: x has length $(length(x)), y has length $(length(y))"))

             # we model x as a ROCSparseMatrixCSR with one row.
            rowPtrA = ROCVector{Ti}([1; nnz(x)+1])
            A = ROCSparseMatrixCSR(rowPtrA, nonzeroinds(x), nonzeros(x), (1,n))

            # we model y as a ROCSparseMatrixCSR with one row.
            rowPtrB = ROCVector{Ti}([1; nnz(y)+1])
            B = ROCSparseMatrixCSR(rowPtrB, nonzeroinds(y), nonzeros(y), (1,n))

            C = geam(alpha, A, beta, B, index)
            z = ROCSparseVector{$elty,Ti}(C.colVal, C.nzVal, n)
            return z
        end
    end
end
