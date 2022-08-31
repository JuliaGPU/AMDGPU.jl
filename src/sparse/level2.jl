# sparse linear algebra functions that perform operations between sparse matrices and dense
# vectors

export sv2!, sv2, mv!

"""
    mv!(transa::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, beta::BlasFloat, Y::ROCVector, index::SparseChar)

Performs `Y = alpha * op(A) * X + beta * Y`, where `op` can be nothing (`transa = N`),
tranpose (`transa = T`) or conjugate transpose (`transa = C`). `X` is a sparse vector, and
`Y` is dense.
"""
mv!(transa::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, beta::BlasFloat, Y::ROCVector, index::SparseChar)

for (fname,elty) in ((:rocsparse_sbsrmv, :Float32),
                     (:rocsparse_dbsrmv, :Float64),
                     (:rocsparse_cbsrmv, :ComplexF32),
                     (:rocsparse_zbsrmv, :ComplexF64))
    @eval begin
        function mv!(transa::SparseChar,
                     alpha::Number,
                     A::ROCSparseMatrixBSR{$elty},
                     X::ROCVector{$elty},
                     beta::Number,
                     Y::ROCVector{$elty},
                     index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,n = size(A)
            mb = div(m,A.blockDim)
            nb = div(n,A.blockDim)
            if transa == 'N'
                chkmvdims(X,n,Y,m)
            end
            if transa == 'T' || transa == 'C'
                chkmvdims(X,m,Y,n)
            end
            $fname(handle(), A.dir, transa, mb, nb,
                   nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                   A.colVal, A.blockDim, X, beta, Y)
            Y
        end
    end
end

"""
    sv2!(transa::SparseChar, uplo::SparseChar, diag::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, index::SparseChar)

Performs `X = alpha * op(A) \\ X`, where `op` can be nothing (`transa = N`), tranpose
(`transa = T`) or conjugate transpose (`transa = C`). `X` is a dense vector, and `uplo`
tells `sv2!` which triangle of the block sparse matrix `A` to reference.
If the triangle has unit diagonal, set `diag` to 'U'.
"""
sv2!(transa::SparseChar, uplo::SparseChar, diag::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, index::SparseChar)

# bsrsv2
for (bname,aname,sname,elty) in ((:rocsparse_sbsrsv_buffer_size, :rocsparse_sbsrsv_analysis, :rocsparse_sbsrsv_solve, :Float32),
                                 (:rocsparse_dbsrsv_buffer_size, :rocsparse_dbsrsv_analysis, :rocsparse_dbsrsv_solve, :Float64),
                                 (:rocsparse_cbsrsv_buffer_size, :rocsparse_cbsrsv_analysis, :rocsparse_cbsrsv_solve, :ComplexF32),
                                 (:rocsparse_zbsrsv_buffer_size, :rocsparse_zbsrsv_analysis, :rocsparse_zbsrsv_solve, :ComplexF64))
    @eval begin
        function sv2!(transa::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixBSR{$elty},
                      X::ROCVector{$elty},
                      index::SparseChar)
            desc = ROCMatrixDescriptor('G', uplo, diag, index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mb = cld(m, A.blockDim)
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("X must have length $m, but has length $mX"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), A.dir, transa, mb, A.nnzb,
                       desc, nonzeros(A), A.rowPtr, A.colVal, A.blockDim,
                       info_ref[], out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), A.dir, transa, mb, A.nnzb,
                        desc, nonzeros(A), A.rowPtr, A.colVal, A.blockDim,
                        info_ref[], CUSPARSE_SOLVE_POLICY_USE_LEVEL, buffer)
                posit = Ref{Cint}(1)
                rocsparse_bsrsv_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), A.dir, transa, mb, A.nnzb,
                        alpha, desc, nonzeros(A), A.rowPtr, A.colVal,
                        A.blockDim, info_ref[], X, X,
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

# csrsv2
for (bname,aname,sname,elty) in ((:rocsparse_scsrsv_buffer_size, :rocsparse_scsrsv_analysis, :rocsparse_scsrsv_solve, :Float32),
                                 (:rocsparse_dcsrsv_buffer_size, :rocsparse_dcsrsv_analysis, :rocsparse_dcsrsv_solve, :Float64),
                                 (:rocsparse_ccsrsv_buffer_size, :rocsparse_ccsrsv_analysis, :rocsparse_ccsrsv_solve, :ComplexF32),
                                 (:rocsparse_zcsrsv_buffer_size, :rocsparse_zcsrsv_analysis, :rocsparse_zcsrsv_solve, :ComplexF64))
    @eval begin
        function sv2!(transa::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSR{$elty},
                      X::ROCVector{$elty},
                      index::SparseChar)
            desc = ROCMatrixDescriptor('G', uplo, diag, index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("First dimension of A, $m, and of X, $(size(X)[1]) must match"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), transa, m, nnz(A),
                       desc, nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), transa, m, nnz(A),
                        desc, nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csrsv_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), transa, m,
                        nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                        A.colVal, info_ref[], X, X,
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

# cscsv2
for (bname,aname,sname,elty) in ((:rocsparse_scsrsv_buffer_size, :rocsparse_scsrsv_analysis, :rocsparse_scsrsv_solve, :Float32),
                                 (:rocsparse_dcsrsv_buffer_size, :rocsparse_dcsrsv_analysis, :rocsparse_dcsrsv_solve, :Float64),
                                 (:rocsparse_ccsrsv_buffer_size, :rocsparse_ccsrsv_analysis, :rocsparse_ccsrsv_solve, :ComplexF32),
                                 (:rocsparse_ccsrsv_buffer_size, :rocsparse_zcsrsv_analysis, :rocsparse_zcsrsv_solve, :ComplexF64))
    @eval begin
        function sv2!(transa::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSC{$elty},
                      X::ROCVector{$elty},
                      index::SparseChar)
            ctransa = 'N'
            cuplo = 'U'
            if transa == 'N'
                ctransa = 'T'
            end
            if uplo == 'U'
                cuplo = 'L'
            end
            desc = ROCMatrixDescriptor('G', cuplo, diag, index)
            n,m = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("First dimension of A, $m, and of X, $(size(X)[1]) must match"))
            end

            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), ctransa, m, nnz(A),
                       desc, nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), ctransa, m, nnz(A),
                        desc, nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csrsv_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), ctransa, m,
                        nnz(A), alpha, desc, nonzeros(A), A.colPtr,
                        rowvals(A), info[1], X, X,
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

for elty in (:Float32, :Float64, :ComplexF32, :ComplexF64)
    @eval begin
        function sv2(transa::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     alpha::Number,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv2!(transa,uplo,diag,alpha,A,copy(X),index)
        end
        function sv2(transa::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv2!(transa,uplo,diag,one($elty),A,copy(X),index)
        end
        function sv2(transa::SparseChar,
                     uplo::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv2!(transa,uplo,'N',one($elty),A,copy(X),index)
        end
    end
end
