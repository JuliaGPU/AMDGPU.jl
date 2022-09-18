export geam

"""
    geam(alpha::Number, A::ROCSparseMatrix, beta::Number, B::ROCSparseMatrix, index::SparseChar)

Performs `C = alpha * A + beta * B`. `A` and `B` are sparse matrix defined in CSR storage format.
"""
geam(alpha::Number, A::ROCSparseMatrixCSR, beta::Number, B::ROCSparseMatrixCSR, index::SparseChar)

for (fname, elty) in ((:rocsparse_scsrgeam, :Float32),
                           (:rocsparse_dcsrgeam, :Float64),
                           (:rocsparse_ccsrgeam, :ComplexF32),
                           (:rocsparse_zcsrgeam, :ComplexF64))
    @eval begin
        function geam(alpha::Number, A::ROCSparseMatrixCSR{$elty}, beta::Number, B::ROCSparseMatrixCSR{$elty}, index::SparseChar)
            m, n = size(A)
            (m, n) == size(B) && DimensionMismatch("dimensions must match: a has dims $(axes(A)), b has dims $(axes(B))")
            descrA = ROCMatrixDescriptor('G', 'L', 'N', index)
            descrB = ROCMatrixDescriptor('G', 'L', 'N', index)
            descrC = ROCMatrixDescriptor('G', 'L', 'N', index)

            rowPtrC = ROCArray{Int32,1}(undef, m+1)

            nnzcount_C = Ref{Cint}()
            rocsparse_csrgeam_nnz(handle(), m, n, descrA, nnz(A), A.rowPtr, A.colVal,
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
    end
end
