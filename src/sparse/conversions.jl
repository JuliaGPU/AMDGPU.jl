# conversion routines between different sparse and dense storage formats

SparseArrays.sparse(::DenseROCArray, args...) = error("CUSPARSE supports multiple sparse formats, use specific constructors instead (e.g. CuSparseMatrixCSC)")


## CSR to CSC

# by flipping rows and columns, we can use that to get CSC to CSR too

for (fname,elty) in ((:rocsparse_scsr2csc, :Float32),
                     (:rocsparse_dcsr2csc, :Float64),
                     (:rocsparse_ccsr2csc, :ComplexF32),
                     (:rocsparse_zcsr2csc, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSC{$elty}(csr::ROCSparseMatrixCSR{$elty})
            m,n = csr.dims
            colPtr = AMDGPU.zeros(Cint, n+1)
            rowVal = AMDGPU.zeros(Cint, nnz(csr))
            nzVal = AMDGPU.zeros($elty, nnz(csr))
            println("Second")
            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_csr2csc_buffer_size(handle(), m, n,
                    nnz(csr), csr.rowPtr, csr.colVal,
                    rocsparse_action_numeric, out)
                return out[]
            end
            status = $fname(handle(), m, n, nnz(csr), nonzeros(csr),
                csr.rowPtr, csr.colVal, nzVal, rowVal,
                colPtr, rocsparse_action_numeric, rocsparse_index_base_zero, ROCVector{$elty}(undef, Int(bufferSize())))
            @assert status == rocsparse_status_success
            @show status
            ROCSparseMatrixCSC(colPtr,rowVal,nzVal,csr.dims)
        end

        function ROCSparseMatrixCSR{$elty}(csc::ROCSparseMatrixCSC{$elty})
            m,n    = csc.dims
            rowPtr = AMDGPU.zeros(Cint,m+1)
            colVal = AMDGPU.zeros(Cint,nnz(csc))
            nzVal  = AMDGPU.zeros($elty,nnz(csc))
            println("First")
            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_csr2csc_buffer_size(handle(), m, n,
                    nnz(csc), csc.colPtr, csc.rowVal,
                    rocsparse_action_numeric, out)
                return out[]
            end
            @show Int(bufferSize())
            buffer = AMDGPU.zeros($elty, Int(bufferSize()))
            # buffer = AMDGPU.malloc(bufferSize())
            @show nnz(csc)
            nnzval = 1
            status = $fname(handle(), n, m, nnzval, csc.nzVal,
                csc.colPtr, csc.rowVal, nzVal, colVal,
                rowPtr, rocsparse_action_numeric, rocsparse_index_base_one, buffer.buf.ptr)
            @show status
            @assert status == rocsparse_status_success
            ROCSparseMatrixCSR(rowPtr,colVal,nzVal,csc.dims)
        end
    end
end