# BSR vendor conversions; ordinary formats are constructed centrally in GPUArrays.
## CSR to BSR and vice-versa

for (fname,elty) in ((:rocsparse_scsr2bsr, :Float32),
                     (:rocsparse_dcsr2bsr, :Float64),
                     (:rocsparse_ccsr2bsr, :ComplexF32),
                     (:rocsparse_zcsr2bsr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixBSR{$elty}(
            csr::ROCSparseMatrixCSR{$elty}, blockDim::Integer;
            dir::SparseChar = 'R', inda::SparseChar = 'O', indc::SparseChar = 'O',
        )
            require_cint_storage(csr)
            inda == indc == 'O' || throw(ArgumentError("canonical arrays require one-based indices"))
            blockDim > 0 || throw(ArgumentError("block dimension must be positive"))
            m,n = size(csr)
            nnz_ref = Ref{Cint}()
            mb = cld(m, blockDim)
            nb = cld(n, blockDim)
            bsrRowPtr = AMDGPU.zeros(Cint,mb + 1)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)

            rocsparse_csr2bsr_nnz(
                handle(), dir, m, n, rocdesca, csr.rowPtr,
                csr.colVal, blockDim, rocdescc, bsrRowPtr, nnz_ref)

            bsrNzVal = AMDGPU.zeros($elty, nnz_ref[] * blockDim * blockDim )
            bsrColInd = AMDGPU.zeros(Cint, nnz_ref[])

            $fname(
                handle(), dir, m, n,
                rocdesca, nonzeros(csr), csr.rowPtr, csr.colVal,
                blockDim, rocdescc, bsrNzVal, bsrRowPtr, bsrColInd)

            ROCSparseMatrixBSR{$elty}(
                bsrRowPtr, bsrColInd, bsrNzVal, size(csr),
                blockDim, dir, nnz_ref[])
        end
    end
end

for (fname,elty) in ((:rocsparse_sbsr2csr, :Float32),
                     (:rocsparse_dbsr2csr, :Float64),
                     (:rocsparse_cbsr2csr, :ComplexF32),
                     (:rocsparse_zbsr2csr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR{$elty}(
            bsr::ROCSparseMatrixBSR{$elty};
            inda::SparseChar = 'O', indc::SparseChar = 'O',
        )
            require_cint_storage(bsr)
            inda == indc == 'O' || throw(ArgumentError("canonical arrays require one-based indices"))
            m,n = size(bsr)
            mb = cld(m, bsr.blockDim)
            nb = cld(n, bsr.blockDim)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)
            padded_m=Base.checked_mul(mb,Int(bsr.blockDim))
            padded_n=Base.checked_mul(nb,Int(bsr.blockDim))
            GPUArrays.check_sparse_dims(Cint,(padded_m,padded_n))
            GPUArrays.check_sparse_nnz(Cint,nnz(bsr))
            csrRowPtr = AMDGPU.zeros(Cint, Base.checked_add(padded_m,1))
            csrColInd = AMDGPU.zeros(Cint, nnz(bsr))
            csrNzVal  = AMDGPU.zeros($elty, nnz(bsr))

            $fname(handle(), bsr.dir, mb, nb,
                   rocdesca, nonzeros(bsr), bsr.rowPtr, bsr.colVal,
                   bsr.blockDim, rocdescc, csrNzVal, csrRowPtr, csrColInd)
            result=canonical_csr(csrRowPtr,csrColInd,csrNzVal,(padded_m,padded_n))
            size(result)==size(bsr) ? result : result[1:m,1:n]
        end
    end
end

# implement Int conversions using reinterpreted Float
for (elty, felty) in ((:Int16, :Float16),
                      (:Int32, :Float32),
                      (:Int64, :Float64),
                      (:Int128, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR{$elty}(bsr::ROCSparseMatrixBSR{$elty})
            bsr_compat = ROCSparseMatrixBSR(
                bsr.rowPtr, bsr.colVal,
                reinterpret($felty, bsr.nzVal),
                bsr.blockDim, bsr.dir, bsr.nnzb, size(bsr))
            csr_compat = ROCSparseMatrixCSR(bsr_compat)
            ROCSparseMatrixCSR(
                csr_compat.rowPtr, csr_compat.colVal,
                reinterpret($elty, csr_compat.nzVal), size(csr_compat))
        end

        function ROCSparseMatrixBSR{$elty}(csr::ROCSparseMatrixCSR{$elty}, blockDim)
            csr_compat = ROCSparseMatrixCSR(
                csr.rowPtr, csr.colVal,
                reinterpret($felty, csr.nzVal), size(csr))
            bsr_compat = ROCSparseMatrixBSR(csr_compat, blockDim)
            ROCSparseMatrixBSR(
                bsr_compat.rowPtr, bsr_compat.colVal,
                reinterpret($elty, bsr_compat.nzVal),
                bsr_compat.blockDim, bsr_compat.dir, bsr_compat.nnzb,
                size(bsr_compat))
        end
    end
end


function canonical_csr(ptr,ind,values,dims,::Type{Ti}=eltype(ind),::Type{Tp}=eltype(ptr)) where {Ti,Tp}
    rows=GPUArrays.expand_ptr(ptr,length(values),Ti)
    cols=GPUArrays.convert_index_buffer(Ti,ind)
    GPUArrays.assemble_matrix(rows,cols,values,dims...,GPUArrays.default_combine(eltype(values)),:csr;
                              pointer_type=Tp)
end

ROCSparseMatrixBSR(A::Union{ROCSparseMatrixCSC,ROCSparseMatrixCOO},b;kwargs...)=
    ROCSparseMatrixBSR(ROCSparseMatrixCSR{eltype(A),Cint}(A),b;kwargs...)
ROCSparseMatrixCSR(A::ROCSparseMatrixBSR{T};kwargs...) where {T}=ROCSparseMatrixCSR{T}(A;kwargs...)
ROCSparseMatrixBSR(A::ROCSparseMatrixCSR{T},b;kwargs...) where {T}=ROCSparseMatrixBSR{T}(A,b;kwargs...)
ROCSparseMatrixCSC(A::ROCSparseMatrixBSR)=ROCSparseMatrixCSC(ROCSparseMatrixCSR(A))
ROCSparseMatrixCOO(A::ROCSparseMatrixBSR)=ROCSparseMatrixCOO(ROCSparseMatrixCSR(A))
for S in (:ROCSparseMatrixCSR,:ROCSparseMatrixCSC,:ROCSparseMatrixCOO)
    @eval $S{T,Ti}(A::ROCSparseMatrixBSR) where {T,Ti}=GPUArrays.with_eltypes($S(A),T,Ti)
end
function ROCSparseMatrixBSR(A::ROCMatrix;ind::SparseChar='O')
    ROCSparseMatrixBSR(ROCSparseMatrixCSR(A),max(gcd(size(A)...),1);inda=ind)
end
function SparseArrays.sparse(A::DenseROCMatrix;fmt::Symbol=:csc)
    fmt===:bsr ? ROCSparseMatrixBSR(A) : GPUArrays.sparse_format(fmt){eltype(A),Cint}(A)
end
