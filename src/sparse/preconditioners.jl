# routines that implement different preconditioners

export ic0!, ic0, ilu0!, ilu0

"""
    ic0!(A::ROCSparseMatrix, index::SparseChar)

Incomplete Cholesky factorization with no pivoting.
Preserves the sparse layout of matrix `A`.
"""
ic0!(A::ROCSparseMatrix, index::SparseChar)
for (bname,aname,sname,elty) in ((:rocsparse_scsric0_buffer_size, :rocsparse_scsric0_analysis, :rocsparse_scsric0, :Float32),
                                 (:rocsparse_dcsric0_buffer_size, :rocsparse_dcsric0_analysis, :rocsparse_dcsric0, :Float64),
                                 (:rocsparse_ccsric0_buffer_size, :rocsparse_ccsric0_analysis, :rocsparse_ccsric0, :ComplexF32),
                                 (:rocsparse_zcsric0_buffer_size, :rocsparse_zcsric0_analysis, :rocsparse_zcsric0, :ComplexF64))
    @eval begin
        function ic0!(A::ROCSparseMatrixCSR{$elty},
                       index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), m, nnz(A), desc, nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), m, nnz(A), desc,
                        nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csric0_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), m, nnz(A),
                        desc, nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

# cscic02
for (bname,aname,sname,elty) in ((:rocsparse_scsric0_buffer_size, :rocsparseScsric02_analysis, :rocsparseScsric02, :Float32),
                                 (:rocsparse_dcsric0_buffer_size, :rocsparseDcsric02_analysis, :rocsparseDcsric02, :Float64),
                                 (:rocsparse_ccsric0_buffer_size, :rocsparseCcsric02_analysis, :rocsparseCcsric02, :ComplexF32),
                                 (:rocsparse_zcsric0_buffer_size, :rocsparseZcsric02_analysis, :rocsparseZcsric02, :ComplexF64))
    @eval begin
        function ic0!(A::ROCSparseMatrixCSC{$elty},
                       index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), m, nnz(A), desc, nonzeros(A), A.colPtr, rowvals(A),
                       info_ref[], out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), m, nnz(A), desc,
                        nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csric0_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), m, nnz(A),
                        desc, nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

"""
    ilu0!(A::ROCSparseMatrix, index::SparseChar)

Incomplete LU factorization with no pivoting.
Preserves the sparse layout of matrix `A`.
"""
ilu0!(A::ROCSparseMatrix, index::SparseChar)
for (bname,aname,sname,elty) in ((:rocsparse_scsrilu0_buffer_size, :rocsparse_scsrilu0_analysis, :rocsparse_scsrilu0, :Float32),
                                 (:rocsparse_dcsrilu0_buffer_size, :rocsparse_dcsrilu0_analysis, :rocsparse_dcsrilu0, :Float64),
                                 (:rocsparse_ccsrilu0_buffer_size, :rocsparse_ccsrilu0_analysis, :rocsparse_ccsrilu0, :ComplexF32),
                                 (:rocsparse_zcsrilu0_buffer_size, :rocsparse_zcsrilu0_analysis, :rocsparse_zcsrilu0, :ComplexF64))
    @eval begin
        function ilu0!(A::ROCSparseMatrixCSR{$elty},
                        index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), m, nnz(A), desc,
                       nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), m, nnz(A), desc,
                        nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csrilu0_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), m, nnz(A),
                        desc, nonzeros(A), A.rowPtr, A.colVal, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

# cscilu02
for (bname,aname,sname,elty) in ((:rocsparse_scsrilu0_buffer_size, :rocsparse_scsrilu0_analysis, :rocsparse_scsrilu0, :Float32),
                                 (:rocsparse_dcsrilu0_buffer_size, :rocsparse_dcsrilu0_analysis, :rocsparse_dcsrilu0, :Float64),
                                 (:rocsparse_ccsrilu0_buffer_size, :rocsparse_ccsrilu0_analysis, :rocsparse_ccsrilu0, :ComplexF32),
                                 (:rocsparse_zcsrilu0_buffer_Size, :rocsparse_zcsrilu0_analysis, :rocsparse_zcsrilu0, :ComplexF64))
    @eval begin
        function ilu0!(A::ROCSparseMatrixCSC{$elty},
                        index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'L', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), m, nnz(A), desc,
                       nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), m, nnz(A), desc,
                        nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_csrilu0_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), m, nnz(A),
                        desc, nonzeros(A), A.colPtr, rowvals(A), info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

# bsric02
for (bname,aname,sname,elty) in ((:rocsparse_sbsric0_buffer_size, :rocsparse_sbsric0_analysis, :rocsparse_sbsric0, :Float32),
                                 (:rocsparse_dbsric0_buffer_size, :rocsparse_dbsric0_analysis, :rocsparse_dbsric0, :Float64),
                                 (:rocsparse_cbsric0_buffer_size, :rocsparse_cbsric0_analysis, :rocsparse_cbsric0, :ComplexF32),
                                 (:rocsparse_zbsric0_buffer_size, :rocsparse_zbsric0_analysis, :rocsparse_zbsric0, :ComplexF64))
    @eval begin
        function ic0!(A::ROCSparseMatrixBSR{$elty},
                       index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'U', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mb = div(m,A.blockDim)
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), A.dir, mb, nnz(A), desc,
                       nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                    $aname(handle(), A.dir, mb, nnz(A), desc,
                           nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                           rocsparse_solve_policy_auto, buffer)
                    posit = Ref{Cint}(1)
                    rocsparse_bsric0_zero_pivot(handle(), info_ref[], posit)
                    if posit[] >= 0
                        rocsparse_destroy_mat_info(info_ref[])
                        error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                    end
                    $sname(handle(), A.dir, mb, nnz(A), desc,
                           nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                           rocsparse_solve_policy_auto, buffer)
                end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

# bsrilu02
for (bname,aname,sname,elty) in ((:rocsparse_sbsrilu0_buffer_size, :rocsparse_sbsrilu0_analysis, :rocsparse_sbsrilu0, :Float32),
                                 (:rocsparse_dbsrilu0_buffer_size, :rocsparse_dbsrilu0_analysis, :rocsparse_dbsrilu0, :Float64),
                                 (:rocsparse_cbsrilu0_buffer_size, :rocsparse_cbsrilu0_analysis, :rocsparse_cbsrilu0, :ComplexF32),
                                 (:rocsparse_zbsrilu0_buffer_size, :rocsparse_zbsrilu0_analysis, :rocsparse_zbsrilu0, :ComplexF64))
    @eval begin
        function ilu0!(A::ROCSparseMatrixBSR{$elty},
                        index::SparseChar)
            desc = ROCMatrixDescriptor('G', 'U', 'N', index)
            m,n = size(A)
            if m != n
                throw(DimensionMismatch("A must be square, but has dimensions ($m,$n)!"))
            end
            mb = div(m,A.blockDim)
            info_ref = Ref{rocsparse_mat_info}()
            rocsparse_create_mat_info(info_ref)

            function bufferSize()
                out = Ref{Cint}(1)
                $bname(handle(), A.dir, mb, nnz(A), desc,
                       nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                       out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $aname(handle(), A.dir, mb, nnz(A), desc,
                        nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
                posit = Ref{Cint}(1)
                rocsparse_bsrilu0_zero_pivot(handle(), info_ref[], posit)
                if posit[] >= 0
                    rocsparse_destroy_mat_info(info_ref[])
                    error("Structural/numerical zero in A at ($(posit[]),$(posit[])))")
                end
                $sname(handle(), A.dir, mb, nnz(A), desc,
                        nonzeros(A), A.rowPtr, A.colVal, A.blockDim, info_ref[],
                        rocsparse_solve_policy_auto, buffer)
            end
            rocsparse_destroy_mat_info(info_ref[])
            A
        end
    end
end

for elty in (:Float32, :Float64, :ComplexF32, :ComplexF64)
    @eval begin
        function ilu0(A::ROCSparseMatrix{$elty},
                       index::SparseChar)
            ilu0!(copy(A),index)
        end
        function ic0(A::ROCSparseMatrix{$elty},
                      index::SparseChar)
            ic0!(copy(A),index)
        end
        function ilu0(A::HermOrSym{$elty,ROCSparseMatrix{$elty}},
                       index::SparseChar)
            ilu0!(copy(A.data),index)
        end
        function ic0(A::HermOrSym{$elty,ROCSparseMatrix{$elty}},
                      index::SparseChar)
            ic0!(copy(A.data),index)
        end
    end
end
