# sparse linear algebra functions that perform operations between sparse matrices and dense
# vectors

export sv!, sv, mv!

"""
    mv!(transa::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, beta::BlasFloat, Y::ROCVector, index::SparseChar)

Performs `Y = alpha * op(A) * X + beta * Y`, where `op` can be nothing (`transa = N`),
tranpose (`transa = T`) or conjugate transpose (`transa = C`). `X` is a sparse vector, and
`Y` is dense.
"""
mv!(transa::rocsparse_operation, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, beta::BlasFloat, Y::ROCVector, index::rocsparse_index_base)

for (fname,elty) in ((:rocsparse_sbsrmv, :Float32),
                     (:rocsparse_dbsrmv, :Float64),
                     (:rocsparse_cbsrmv, :ComplexF32),
                     (:rocsparse_zbsrmv, :ComplexF64))
    @eval begin
        function mv!(transa::rocsparse_operation,
                     alpha::Number,
                     A::ROCSparseMatrixBSR{$elty},
                     X::ROCVector{$elty},
                     beta::Number,
                     Y::ROCVector{$elty},
                     index::SparseChar)
            desc = ROCMatrixDescriptor(rocsparse_matrix_type_general, rocsparse_fill_mode_lower, rocsparse_diag_type_non_unit, index)
            m,n = A.dims
            mb = div(m,A.blockDim)
            nb = div(n,A.blockDim)
            if transa == rocsparse_operation_none
                chkmvdims(X,n,Y,m)
            end
            if transa == rocsparse_operation_transpose || transa == rocsparse_operation_conjugate_transpose
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
    sv!(transa::SparseChar, uplo::SparseChar, diag::SparseChar, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, index::SparseChar)

Performs `X = alpha * op(A) \\ X`, where `op` can be nothing (`transa = N`), tranpose
(`transa = T`) or conjugate transpose (`transa = C`). `X` is a dense vector, and `uplo`
tells `sv2!` which triangle of the block sparse matrix `A` to reference.
If the triangle has unit diagonal, set `diag` to 'U'.
"""
sv!(transa::rocsparse_operation, uplo::rocsparse_fill_mode, diag::rocsparse_diag_type, alpha::BlasFloat, A::ROCSparseMatrix, X::ROCVector, index::rocsparse_index_base)

# bsrsv
for (bname,aname,sname,elty) in ((:rocsparse_sbsrsv_bufferSize, :rocsparse_sbsrsv_analysis, :rocsparse_sbsrsv_solve, :Float32),
                                 (:rocsparse_dbsrsv_bufferSize, :rocsparse_dbsrsv_analysis, :rocsparse_dbsrsv_solve, :Float64),
                                 (:rocsparse_cbsrsv_bufferSize, :rocsparse_cbsrsv_analysis, :rocsparse_cbsrsv_solve, :ComplexF32),
                                 (:rocsparse_zbsrsv_bufferSize, :rocsparse_zbsrsv_analysis, :rocsparse_zbsrsv_solve, :ComplexF64))
    @eval begin
        function sv!(transa::rocsparse_operation,
                uplo::rocsparse_fill_mode,
                diag::rocsparse_diag_type,
                alpha::Number,
                A::ROCSparseMatrixBSR{$elty},
                X::ROCVector{$elty},
                index::rocsparse_index_base)
            desc = ROCMatrixDescriptor(rocsparse_matrix_type_general, uplo, diag, index)
            m,n = A.dims
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mb = div(m,A.blockDim)
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("X must have length $m, but has length $mX"))
            end
            info = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), A.dir, transa, mb, nnz(A),
                       desc, nonzeros(A), A.rowPtr, A.colVal, A.blockDim,
                       info[1], out)
                return out[]
            end
            buffer = AMDGPU.zeros($elty, Int(bufferSize()))
            $aname(handle(), A.dir, transa, mb, nnz(A),
                    desc, nonzeros(A), A.rowPtr, A.colVal, A.blockDim,
                    info[1], rocsparse_solve_policy_auto, buffer)
            posit = Ref{Cint}(1)
            rocsparse_bsrsv_zero_pivot(handle(), info[1], posit)
            if posit[] >= 0
                error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
            end
            $sname(handle(), A.dir, transa, mb, nnz(A),
                    alpha, desc, nonzeros(A), A.rowPtr, A.colVal,
                    A.blockDim, info[1], X, X,
                    rocsparse_solve_policy_auto, buffer)
            rocsparse_destroy_mat_info(info[1])
            X
        end
    end
end

# csrsv
for (bname,aname,sname,elty) in ((:rocsparse_scsrsv_bufferSize, :rocsparse_scsrsv_analysis, :rocsparse_scsrsv_solve, :Float32),
                                 (:rocsparse_dcsrsv_bufferSize, :rocsparse_dcsrsv_analysis, :rocsparse_dcsrsv_solve, :Float64),
                                 (:rocsparse_ccsrsv_bufferSize, :rocsparse_ccsrsv_analysis, :rocsparse_ccsrsv_solve, :ComplexF32),
                                 (:rocsparse_zcsrsv_bufferSize, :rocsparse_zcsrsv_analysis, :rocsparse_zcsrsv_solve, :ComplexF64))
    @eval begin
        function sv!(transa::rocsparse_operation,
                uplo::rocsparse_fill_mode,
                diag::rocsparse_diag_type,
                alpha::Number,
                A::ROCSparseMatrixCSR{$elty},
                X::ROCVector{$elty},
                index::rocsparse_index_base)
            desc = ROCMatrixDescriptor(rocsparse_matrix_type_general, uplo, diag, index)
            m,n = A.dims
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("First dimension of A, $m, and of X, $(size(X)[1]) must match"))
            end
            info = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), transa, m, nnz(A),
                       desc, nonzeros(A), A.rowPtr, A.colVal, info[1],
                       out)
                return out[]
            end
            buffer = AMDGPU.zeros($elty, Int(bufferSize()))
            $aname(handle(), transa, m, nnz(A),
                    desc, nonzeros(A), A.rowPtr, A.colVal, info[1],
                    rocsparse_solve_policy_auto, buffer)
            posit = Ref{Cint}(1)
            rocsparse_bsrsv_zero_pivot(handle(), info[1], posit)
            if posit[] >= 0
                error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
            end
            $sname(handle(), transa, m,
                    nnz(A), alpha, desc, nonzeros(A), A.rowPtr,
                    A.colVal, info[1], X, X,
                    rocsparse_solve_policy_auto, buffer)
            rocsparse_destroy_mat_info(info[1])
            X
        end
    end
end

# cscsv
for (bname,aname,sname,elty) in ((:rocsparse_scsrsv_bufferSize, :rocsparse_scsrsv_analysis, :rocsparse_scsrsv_solve, :Float32),
                                 (:rocsparse_dcsrsv_bufferSize, :rocsparse_dcsrsv_analysis, :rocsparse_dcsrsv_solve, :Float64),
                                 (:rocsparse_ccsrsv_bufferSize, :rocsparse_ccsrsv_analysis, :rocsparse_ccsrsv_solve, :ComplexF32),
                                 (:rocsparse_zcsrsv_bufferSize, :rocsparse_zcsrsv_analysis, :rocsparse_zcsrsv_solve, :ComplexF64))
    @eval begin
        function sv!(transa::rocsparse_operation,
                uplo::rocsparse_fill_mode,
                diag::rocsparse_diag_type,
                alpha::Number,
                A::ROCSparseMatrixCSC{$elty},
                X::ROCVector{$elty},
                index::rocsparse_index_base)
            ctransa = rocsparse_operation_none
            rocplo = rocsparse_fill_mode_upper
            if transa == rocsparse_operation_none
                ctransa = rocsparse_operation_transpose
            end
            if uplo == rocsparse_fill_mode_upper
                rocplo = rocsparse_fill_mode_lower
            end
            desc = ROCMatrixDescriptor(rocsparse_matrix_type_general, rocplo, diag, index)
            n,m = A.dims
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mX = length(X)
            if mX != m
                throw(DimensionMismatch("First dimension of A, $m, and of X, $(size(X)[1]) must match"))
            end
            info = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), ctransa, m, nnz(A),
                       desc, nonzeros(A), A.colPtr, rowvals(A), info[1],
                       out)
                return out[]
            end
            buffer = AMDGPU.zeros($elty, Int(bufferSize()))
            $aname(handle(), ctransa, m, nnz(A),
                    desc, nonzeros(A), A.colPtr, rowvals(A), info[1],
                    rocsparse_solve_policy_auto, buffer)
            posit = Ref{Cint}(1)
            rocsparse_bsrsv_zero_pivot(handle(), info[1], posit)
            if posit[] >= 0
                error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
            end
            $sname(handle(), ctransa, m,
                    nnz(A), alpha, desc, nonzeros(A), A.colPtr,
                    rowvals(A), info[1], X, X,
                    rocsparse_solve_policy_use_auto, buffer)
            rocsparse_destroy_mat_info(info[1])
            X
        end
    end
end

for elty in (:Float32, :Float64, :ComplexF32, :ComplexF64)
    @eval begin
        function sv(transa::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     alpha::Number,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv!(transa,uplo,diag,alpha,A,copy(X),index)
        end
        function sv(transa::SparseChar,
                     uplo::SparseChar,
                     diag::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv!(transa,uplo,diag,one($elty),A,copy(X),index)
        end
        function sv(transa::SparseChar,
                     uplo::SparseChar,
                     A::ROCSparseMatrix{$elty},
                     X::ROCVector{$elty},
                     index::SparseChar)
            sv!(transa,uplo,rocsparse_operation_none,one($elty),A,copy(X),index)
        end
    end
end
