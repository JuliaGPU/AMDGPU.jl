# sparse linear algebra functions that perform operations between sparse and (usually tall)
# dense matrices

export mm!, mm2!, sm2!, sm2

"""
    mm!(transa::SparseChar, transb::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, B::ROCMatrix, beta::BlasFloat, C::ROCMatrix, index::SparseChar)

Performs `C = alpha * op(A) * op(B) + beta * C`, where `op` can be nothing (`transa = N`),
tranpose (`transa = T`) or conjugate transpose (`transa = C`).
`A` is a sparse matrix defined in BSR storage format. `B` and `C` are dense matrices.
"""
mm!(transa::SparseChar, transb::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, B::ROCMatrix, beta::BlasFloat, C::ROCMatrix, index::SparseChar)

# bsrmm
for (fname,elty) in ((:rocsparse_sbsrmm, :Float32),
                     (:rocsparse_dbsrmm, :Float64),
                     (:rocsparse_cbsrmm, :ComplexF32),
                     (:rocsparse_zbsrmm, :ComplexF64))
    @eval begin
        function mm!(transa::SparseChar,
                     transb::SparseChar,
                     alpha::Number,
                     A::ROCSparseMatrixBSR{$elty},
                     B::StridedROCMatrix{$elty},
                     beta::Number,
                     C::StridedROCMatrix{$elty},
                     index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,k = size(A)
            mb = cld(m, A.blockDim)
            kb = cld(k, A.blockDim)
            n = size(C)[2]
            if transa == 'N' && transb == 'N'
                chkmmdims(B,C,k,n,m,n)
            elseif transa == 'N' && transb != 'N'
                chkmmdims(B,C,n,k,m,n)
            elseif transa != 'N' && transb == 'N'
                chkmmdims(B,C,m,n,k,n)
            elseif transa != 'N' && transb != 'N'
                chkmmdims(B,C,n,m,k,n)
            end
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            $fname(handle(), A.dir,
                   transa, transb, mb, n, kb, A.nnzb,
                   alpha, desc, nonzeros(A),A.rowPtr, A.colVal,
                   A.blockDim, B, ldb, beta, C, ldc)
            C
        end
    end
end

for (fname,elty) in ((:rocsparse_scsrmm, :Float32),
                     (:rocsparse_dcsrmm, :Float64),
                     (:rocsparse_ccsrmm, :ComplexF32),
                     (:rocsparse_zcsrmm, :ComplexF64))
    @eval begin
        function mm2!(transa::SparseChar,
                      transb::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSR{$elty},
                      B::StridedROCMatrix{$elty},
                      beta::Number,
                      C::StridedROCMatrix{$elty},
                      index::SparseChar)
            if transb == 'C'
                throw(ArgumentError("B^H is not supported"))
            elseif transb == 'T' && transa != 'N'
                throw(ArgumentError("When using B^T, A can be neither transposed nor adjointed"))
            end
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,k = size(A)
            n = size(C)[2]
            if transa == 'N' && transb == 'N'
                chkmmdims(B,C,k,n,m,n)
            elseif transa == 'N' && transb != 'N'
                chkmmdims(B,C,n,k,m,n)
            elseif transa != 'N' && transb == 'N'
                chkmmdims(B,C,m,n,k,n)
            elseif transa != 'N' && transb != 'N'
                chkmmdims(B,C,n,m,k,n)
            end
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            $fname(handle(),
                   transa, transb, m, n, k, nnz(A), alpha, desc,
                   nonzeros(A), A.rowPtr, A.colVal, B, ldb, beta, C, ldc)
            C
        end
        function mm2!(transa::SparseChar,
                      transb::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSC{$elty},
                      B::StridedROCMatrix{$elty},
                      beta::Number,
                      C::StridedROCMatrix{$elty},
                      index::SparseChar)
            if transb == 'C'
                throw(ArgumentError("B^H is not supported"))
            elseif transb == 'T' && transa != 'N'
                throw(ArgumentError("When using B^T, A can be neither transposed nor adjointed"))
            end
            ctransa = 'N'
            if transa == 'N'
                ctransa = 'T'
            end
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            k,m = size(A)
            n = size(C)[2]
            if ctransa == 'N' && transb == 'N'
                chkmmdims(B,C,k,n,m,n)
            elseif ctransa == 'N' && transb != 'N'
                chkmmdims(B,C,n,k,m,n)
            elseif ctransa != 'N' && transb == 'N'
                chkmmdims(B,C,m,n,k,n)
            elseif ctransa != 'N' && transb != 'N'
                chkmmdims(B,C,n,m,k,n)
            end
            ldb = max(1,stride(B,2))
            ldc = max(1,stride(C,2))
            $fname(handle(),
                   ctransa, transb, m, n, k, nnz(A), alpha, desc,
                   nonzeros(A), A.colPtr, rowvals(A), B, ldb, beta, C, ldc)
            C
        end
    end
end

"""
    sm2!(transa::SparseChar, transxy::SparseChar, uplo::SparseChar, diag::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCMatrix, index::SparseChar)

Performs `X = alpha * op(A) \\ op(X)`, where `op` can be nothing (`transa = N`), tranpose
(`transa = T`) or conjugate transpose (`transa = C`). `X` is a dense matrix, and `uplo`
tells `sm2!` which triangle of the block sparse matrix `A` to reference.
If the triangle has unit diagonal, set `diag` to 'U'.
"""
sm2!(transa::SparseChar, transxy::SparseChar, diag::SparseChar, alpha::Number, A::ROCSparseMatrix, X::ROCMatrix, index::SparseChar)

# bsrsm2
for (bname,aname,sname,elty) in ((:rocsparse_sbsrsm_buffer_size, :rocsparse_sbsrsm_analysis, :rocsparse_sbsrsm_solve, :Float32),
                                 (:rocsparse_dbsrsm_buffer_size, :rocsparse_dbsrsm_analysis, :rocsparse_dbsrsm_solve, :Float64),
                                 (:rocsparse_cbsrsm_buffer_size, :rocsparse_cbsrsm_analysis, :rocsparse_cbsrsm_solve, :ComplexF32),
                                 (:rocsparse_zbsrsm_buffer_size, :rocsparse_zbsrsm_analysis, :rocsparse_zbsrsm_solve, :ComplexF64))
    @eval begin
        function sm2!(transa::SparseChar,
                      transxy::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixBSR{$elty},
                      X::StridedROCMatrix{$elty},
                      index::SparseChar)
            desc = ROCMatrixDescriptor('G', uplo, diag, index)
            m,n = size(A)
            if m != n
                 throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mb = cld(m, A.blockDim)
            mX,nX = size(X)
            if transxy == 'N' && (mX != m)
                throw(DimensionMismatch(""))
            end
            if transxy != 'N' && (nX != m)
                throw(DimensionMismatch(""))
            end
            ldx = max(1,stride(X,2))
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), A.dir, transa, transxy,
                       mb, nX, A.nnzb, desc, nonzeros(A), A.rowPtr,
                       A.colVal, A.blockDim, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), A.dir, transa, transxy,
                        mb, nX, A.nnzb, desc, nonzeros(A), A.rowPtr,
                        A.colVal, A.blockDim, info_ref[],
                        CUSPARSE_SOLVE_POLICY_USE_LEVEL, buffer)
                posit = Ref{Cint}(1)
                rocsparse_bsrsm_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), A.dir, transa, transxy, mb,
                        nX, A.nnzb, alpha, desc, nonzeros(A), A.rowPtr,
                        A.colVal, A.blockDim, info_ref[], X, ldx, X, ldx,
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

# csrsm2
for (bname,aname,sname,elty) in ((:rocsparse_scsrsm_buffer_size, :rocsparse_scsrsm_analysis, :rocsparse_scsrsm_solve, :Float32),
                                 (:rocsparse_dcsrsm_buffer_size, :rocsparse_dcsrsm_analysis, :rocsparse_dcsrsm_solve, :Float64),
                                 (:rocsparse_ccsrsm_buffer_size, :rocsparse_ccsrsm_analysis, :rocsparse_ccsrsm_solve, :ComplexF32),
                                 (:rocsparse_zcsrsm_buffer_Size, :rocsparse_zcsrsm_analysis, :rocsparse_zcsrsm_solve, :ComplexF64))
    @eval begin
        function sm2!(transa::SparseChar,
                      transxy::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSR{$elty},
                      X::StridedROCMatrix{$elty},
                      index::SparseChar)
            desc = ROCMatrixDescriptor('G', uplo, diag, index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mX,nX = size(X)
            if transxy == 'N' && (mX != m)
                throw(DimensionMismatch(""))
            end
            if transxy != 'N' && (nX != m)
                throw(DimensionMismatch(""))
            end
            ldx = max(1,stride(X,2))
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)
            # use non block algo (0) for now...

            function bufferSize()
                out = Ref{UInt64}(1)
                $bname(handle(), 0, transa, transxy,
                        m, nX, nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                        A.colVal, X, ldx, info_ref[], rocsparse_solve_policy_auto,
                        out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), 0, transa, transxy,
                        m, nX, nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                        A.colVal, X, ldx, info[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csrsm_zero_pivot(handle(), info[1], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), 0, transa, transxy, m,
                        nX, nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                        A.colVal, X, ldx, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

# cscsm2
for (bname,aname,sname,elty) in ((:rocsparse_scsrsm_buffer_size, :rocsparse_scsrsm_analysis, :rocsparse_scsrsm_solve, :Float32),
                                 (:rocsparse_dcsrsm_buffer_size, :rocsparse_dcsrsm_analysis, :rocsparse_dcsrsm_solve, :Float64),
                                 (:rocsparse_ccsrsm_buffer_size, :rocsparse_ccsrsm_analysis, :rocsparse_ccsrsm_solve, :ComplexF32),
                                 (:rocsparse_zcsrsm_buffer_size, :rocsparse_zcsrsm_analysis, :rocsparse_zcsrsm_solve, :ComplexF64))
    @eval begin
        function sm2!(transa::SparseChar,
                      transxy::SparseChar,
                      uplo::SparseChar,
                      diag::SparseChar,
                      alpha::Number,
                      A::ROCSparseMatrixCSC{$elty},
                      X::StridedROCMatrix{$elty},
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
                throw(DimensionMismatch("A must be square, but has dimensions ($n,$m)!"))
            end
            mX,nX = size(X)
            if transxy == 'N' && (mX != m)
                throw(DimensionMismatch(""))
            end
            if transxy != 'N' && (nX != m)
                throw(DimensionMismatch(""))
            end
            ldx = max(1,stride(X,2))
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)
            # use non block algo (0) for now...

            function bufferSize()
                out = Ref{UInt64}(1)
                $bname(handle(), 0, ctransa, transxy,
                       m, nX, nnz(A), alpha, desc, nonzeros(A), A.colPtr,
                       rowvals(A), X, ldx, info_ref[], rocsparse_solve_policy_auto,
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), 0, ctransa, transxy,
                        m, nX, nnz(A), alpha, desc, nonzeros(A), A.colPtr,
                        rowvals(A), X, ldx, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_xcsrsm_zero_pivot(handle(), info[1], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), 0, ctransa, transxy, m,
                        nX, nnz(A), alpha, desc, nonzeros(A), A.colPtr,
                        rowvals(A), X, ldx, info_ref[],
                        CUSPARSE_SOLVE_POLICY_USE_LEVEL, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            X
        end
    end
end

for elty in (:Float32, :Float64, :ComplexF32, :ComplexF64)
    @eval begin
        function sm2(transa::SparseChar,
                     transxy::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     alpha::Number,
                     A::ROCSparseMatrix{$elty},
                     X::StridedROCMatrix{$elty},
                     index::SparseChar)
            sm2!(transa,transxy,uplo,diag,alpha,A,copy(X),index)
        end
        function sm2(transa::SparseChar,
                     transxy::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::StridedROCMatrix{$elty},
                     index::SparseChar)
            sm2!(transa,transxy,uplo,diag,one($elty),A,copy(X),index)
        end
        function sm2(transa::SparseChar,
                     transxy::SparseChar,
                     uplo::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::StridedROCMatrix{$elty},
                     index::SparseChar)
            sm2!(transa,transxy,uplo,'N',one($elty),A,copy(X),index)
        end
    end
end
