# conversion routines between different sparse and dense storage formats

"""
    sparse(x::DenseROCMatrix; fmt=:csc)
    sparse(I::ROCVector, J::ROCVector, V::ROCVector, [m, n]; fmt=:csc)

Return a sparse rocm matrix, with type determined by `fmt`.
Possible formats are :csc, :csr, :bsr, and :coo.
"""
function SparseArrays.sparse(x::DenseROCMatrix; fmt=:csc)
    if fmt == :csc
        return ROCSparseMatrixCSC(x)
    elseif fmt == :csr
        return ROCSparseMatrixCSR(x)
    elseif fmt == :bsr
        return ROCSparseMatrixBSR(x)
    elseif fmt == :coo
        return ROCSparseMatrixCOO(x)
    else
        error("Format :$fmt not available, use :csc, :csr, :bsr or :coo.")
    end
end

SparseArrays.sparse(I::ROCVector, J::ROCVector, V::ROCVector; kws...) =
    sparse(I, J, V, maximum(I), maximum(J); kws...)

SparseArrays.sparse(I::ROCVector, J::ROCVector, V::ROCVector, m, n; kws...) =
    sparse(Cint.(I), Cint.(J), V, m, n; kws...)

function SparseArrays.sparse(I::ROCVector{Cint}, J::ROCVector{Cint}, V::ROCVector{Tv}, m, n;
                             fmt=:csc, sorted::Bool=false) where Tv
    coo = ROCSparseMatrixCOO{Tv}(I, J, V, (m, n))

    # The COO format is assumed to be sorted by row.
    if !sorted
        coo = sort_rows(coo)
    end

    if fmt == :csc
        return ROCSparseMatrixCSC(coo)
    elseif fmt == :csr
        return ROCSparseMatrixCSR(coo)
    elseif fmt == :coo
        return coo
    else
        error("Format :$fmt not available, use :csc, :csr, or :coo.")
    end
end

function sort_rows(coo::ROCSparseMatrixCOO{Tv,Ti}) where {Tv <: BlasFloat,Ti}
    m,n = size(coo)

    perm = ROCArray{Ti}(undef, nnz(coo))
    rocsparse_create_identity_permutation(handle(), nnz(coo), perm)

    sorted_rowInd = copy(coo.rowInd)
    sorted_colInd = copy(coo.colInd)
    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_coosort_buffer_size(handle(), m, n, nnz(coo), coo.rowInd,
            coo.colInd, out)
        return out[]
    end
    with_workspace(bufferSize) do buffer
        rocsparse_coosort_by_row(handle(), m, n, nnz(coo), sorted_rowInd, sorted_colInd, perm, buffer)
    end

    sorted_nzVal = similar(coo.nzVal)
    let spvec = ROCSparseVector(perm, sorted_nzVal, nnz(coo))
        gthr!(spvec, nonzeros(coo), 'Z')
    end

    AMDGPU.unsafe_free!(perm)
    ROCSparseMatrixCOO{Tv}(sorted_rowInd, sorted_colInd, sorted_nzVal, size(coo))
end
function sort_rows(coo::ROCSparseMatrixCOO{Tv,Ti}) where {Tv,Ti}
    # TODO: Use GPU-based sortperm for this
    perm = @allowscalar sortperm(coo.rowInd)
    sorted_rowInd = coo.rowInd[perm]
    sorted_colInd = coo.colInd[perm]
    sorted_nzVal = coo.nzVal[perm]
    # AMDGPU.unsafe_free!(perm)

    ROCSparseMatrixCOO{Tv}(sorted_rowInd, sorted_colInd, sorted_nzVal, size(coo))
end


## CSR to CSC

function ROCSparseMatrixCSC{T}(S::Transpose{T, <:ROCSparseMatrixCSR{T}}) where T
    csr = parent(S)
    return ROCSparseMatrixCSC{T}(csr.rowPtr, csr.colVal, csr.nzVal, size(csr))
end

function ROCSparseMatrixCSR{T}(S::Transpose{T, <:ROCSparseMatrixCSC{T}}) where T
    csc = parent(S)
    return ROCSparseMatrixCSR{T}(csc.colPtr, csc.rowVal, csc.nzVal, size(csc))
end

function ROCSparseMatrixCSC{T}(S::Adjoint{T, <:ROCSparseMatrixCSR{T}}) where {T <: Real}
    csr = parent(S)
    return ROCSparseMatrixCSC{T}(csr.rowPtr, csr.colVal, csr.nzVal, size(csr))
end

function ROCSparseMatrixCSR{T}(S::Adjoint{T, <:ROCSparseMatrixCSC{T}}) where {T <: Real}
    csc = parent(S)
    return ROCSparseMatrixCSR{T}(csc.colPtr, csc.rowVal, csc.nzVal, size(csc))
end

function ROCSparseMatrixCSC{T}(S::Adjoint{T, <:ROCSparseMatrixCSR{T}}) where {T <: Complex}
    csr = parent(S)
    return ROCSparseMatrixCSC{T}(csr.rowPtr, csr.colVal, conj.(csr.nzVal), size(csr))
end

function ROCSparseMatrixCSR{T}(S::Adjoint{T, <:ROCSparseMatrixCSC{T}}) where {T <: Complex}
    csc = parent(S)
    return ROCSparseMatrixCSR{T}(csc.colPtr, csc.rowVal, conj.(csc.nzVal), size(csc))
end

for SparseMatrixType in [:ROCSparseMatrixCSC, :ROCSparseMatrixCSR]
    @eval begin
        $SparseMatrixType(S::Diagonal) = $SparseMatrixType(roc(S))
        $SparseMatrixType(S::Diagonal{T, <:ROCArray}) where T = $SparseMatrixType{T}(S)
        $SparseMatrixType{Tv}(S::Diagonal{T, <:ROCArray}) where {Tv, T} = $SparseMatrixType{Tv, Cint}(S)
        function $SparseMatrixType{Tv, Ti}(S::Diagonal{T, <:ROCArray}) where {Tv, Ti, T}
            m = size(S, 1)
            return $SparseMatrixType{Tv, Ti}(ROCVector(1:(m+1)), ROCVector(1:m), Tv.(S.diag), (m, m))
        end
    end
end


# by flipping rows and columns, we can use that to get CSC to CSR too
for (elty, fname) in ((:Float32, :rocsparse_scsr2csc), (:Float64, :rocsparse_dcsr2csc),
                     (:ComplexF32, :rocsparse_ccsr2csc), (:ComplexF64, :rocsparse_zcsr2csc))
    @eval begin
        function ROCSparseMatrixCSC{$elty}(csr::ROCSparseMatrixCSR{$elty}; inda::SparseChar='O')
            m,n = size(csr)
            colPtr = AMDGPU.zeros(Cint, n+1)
            rowVal = AMDGPU.zeros(Cint, nnz(csr))
            nzVal = AMDGPU.zeros($elty, nnz(csr))
            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_csr2csc_buffer_size(handle(), m, n, nnz(csr),
                    csr.rowPtr, csr.colVal, rocsparse_action_numeric, out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $fname(handle(), m, n, nnz(csr), nonzeros(csr),
                    csr.rowPtr, csr.colVal, nzVal, rowVal, colPtr,
                    rocsparse_action_numeric, inda, buffer)
            end
            ROCSparseMatrixCSC(colPtr, rowVal, nzVal, size(csr))
        end

        function ROCSparseMatrixCSR{$elty}(csc::ROCSparseMatrixCSC{$elty}; inda::SparseChar='O')
            m,n    = size(csc)
            rowPtr = AMDGPU.zeros(Cint,m+1)
            colVal = AMDGPU.zeros(Cint,nnz(csc))
            nzVal  = AMDGPU.zeros($elty,nnz(csc))
            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_csr2csc_buffer_size(handle(), n, m, nnz(csc),
                    csc.colPtr, rowvals(csc),
                    rocsparse_action_numeric, out)
                return out[]
            end
            with_workspace(bufferSize) do buffer
                $fname(handle(), n, m, nnz(csc), nonzeros(csc),
                    csc.colPtr, rowvals(csc), nzVal, colVal, rowPtr,
                    rocsparse_action_numeric, inda, buffer)
            end
            ROCSparseMatrixCSR(rowPtr,colVal,nzVal,size(csc))
        end
    end
end

# implement Int conversions using reinterpreted Float
for (elty, felty) in ((:Int32, :Float32),
                      (:Int64, :Float64),
                      (:Int128, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR{$elty}(csc::ROCSparseMatrixCSC{$elty})
            csc_compat = ROCSparseMatrixCSC(
                csc.colPtr,
                csc.rowVal,
                reinterpret($felty, csc.nzVal),
                size(csc)
            )
            csr_compat = ROCSparseMatrixCSR(csc_compat)
            ROCSparseMatrixCSR(
                csr_compat.rowPtr,
                csr_compat.colVal,
                reinterpret($elty, csr_compat.nzVal),
                size(csr_compat)
            )
        end

        function ROCSparseMatrixCSC{$elty}(csr::ROCSparseMatrixCSR{$elty})
            csr_compat = ROCSparseMatrixCSR(
                csr.rowPtr,
                csr.colVal,
                reinterpret($felty, csr.nzVal),
                size(csr)
            )
            csc_compat = ROCSparseMatrixCSC(csr_compat)
            ROCSparseMatrixCSC(
                csc_compat.colPtr,
                csc_compat.rowVal,
                reinterpret($elty, csc_compat.nzVal),
                size(csc_compat)
            )
        end
    end
end

## CSR to BSR and vice-versa

for (fname,elty) in ((:rocsparse_scsr2bsr, :Float32),
                     (:rocsparse_dcsr2bsr, :Float64),
                     (:rocsparse_ccsr2bsr, :ComplexF32),
                     (:rocsparse_zcsr2bsr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixBSR{$elty}(csr::ROCSparseMatrixCSR{$elty}, blockDim::Integer;
                                          dir::SparseChar='R', inda::SparseChar='O',
                                          indc::SparseChar='O')
            m,n = size(csr)
            nnz_ref = Ref{Cint}(1)
            mb = cld(m, blockDim)
            nb = cld(n, blockDim)
            bsrRowPtr = AMDGPU.zeros(Cint,mb + 1)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)
            rocsparse_csr2bsr_nnz(handle(), dir, m, n, rocdesca, csr.rowPtr,
                                csr.colVal, blockDim, rocdescc, bsrRowPtr, nnz_ref)
            bsrNzVal = AMDGPU.zeros($elty, nnz_ref[] * blockDim * blockDim )
            bsrColInd = AMDGPU.zeros(Cint, nnz_ref[])
            $fname(handle(), dir, m, n,
                   rocdesca, nonzeros(csr), csr.rowPtr, csr.colVal,
                   blockDim, rocdescc, bsrNzVal, bsrRowPtr,
                   bsrColInd)
            ROCSparseMatrixBSR{$elty}(bsrRowPtr, bsrColInd, bsrNzVal, size(csr), blockDim, dir, nnz_ref[])
        end
    end
end

for (fname,elty) in ((:rocsparse_sbsr2csr, :Float32),
                     (:rocsparse_dbsr2csr, :Float64),
                     (:rocsparse_cbsr2csr, :ComplexF32),
                     (:rocsparse_zbsr2csr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR{$elty}(bsr::ROCSparseMatrixBSR{$elty};
                                          inda::SparseChar='O', indc::SparseChar='O')
            m,n = size(bsr)
            mb = cld(m, bsr.blockDim)
            nb = cld(n, bsr.blockDim)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)
            csrRowPtr = AMDGPU.zeros(Cint, m + 1)
            csrColInd = AMDGPU.zeros(Cint, nnz(bsr))
            csrNzVal  = AMDGPU.zeros($elty, nnz(bsr))
            $fname(handle(), bsr.dir, mb, nb,
                   rocdesca, nonzeros(bsr), bsr.rowPtr, bsr.colVal,
                   bsr.blockDim, rocdescc, csrNzVal, csrRowPtr,
                   csrColInd)
            # XXX: the size here may not match the expected size, when the matrix dimension
            #      is not a multiple of the block dimension!
            ROCSparseMatrixCSR(csrRowPtr, csrColInd, csrNzVal, (mb*bsr.blockDim, nb*bsr.blockDim))
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
                bsr.rowPtr,
                bsr.colVal,
                reinterpret($felty, bsr.nzVal),
                bsr.blockDim,
                bsr.dir,
                bsr.nnzb,
                size(bsr)
            )
            csr_compat = ROCSparseMatrixCSR(bsr_compat)
            ROCSparseMatrixCSR(
                csr_compat.rowPtr,
                csr_compat.colVal,
                reinterpret($elty, csr_compat.nzVal),
                size(csr_compat)
            )
        end

        function ROCSparseMatrixBSR{$elty}(csr::ROCSparseMatrixCSR{$elty}, blockDim)
            csr_compat = ROCSparseMatrixCSR(
                csr.rowPtr,
                csr.colVal,
                reinterpret($felty, csr.nzVal),
                size(csr)
            )
            bsr_compat = ROCSparseMatrixBSR(csr_compat, blockDim)
            ROCSparseMatrixBSR(
                bsr_compat.rowPtr,
                bsr_compat.colVal,
                reinterpret($elty, bsr_compat.nzVal),
                bsr_compat.blockDim,
                bsr_compat.dir,
                bsr_compat.nnzb,
                size(bsr_compat)
            )
        end
    end
end

## CSR to COO and vice-versa

# TODO: we can do similar for CSC conversions, but that requires the columns to be sorted

function ROCSparseMatrixCSR(coo::ROCSparseMatrixCOO{Tv}, ind::SparseChar='O') where {Tv}
    m,n = size(coo)
    csrRowPtr = ROCVector{Cint}(undef, m+1)
    rocsparse_coo2csr(handle(), coo.rowInd, nnz(coo), m, csrRowPtr, ind)
    ROCSparseMatrixCSR{Tv}(csrRowPtr, coo.colInd, nonzeros(coo), size(coo))
end

function ROCSparseMatrixCOO(csr::ROCSparseMatrixCSR{Tv}, ind::SparseChar='O') where {Tv}
    m,n = size(csr)
    cooRowInd = ROCVector{Cint}(undef, Int.(nnz(csr)))
    rocsparse_csr2coo(handle(), csr.rowPtr, nnz(csr), m, cooRowInd, ind)
    ROCSparseMatrixCOO{Tv}(cooRowInd, csr.colVal, nonzeros(csr), size(csr), nnz(csr))
end

### CSC/BSR to COO and viceversa

ROCSparseMatrixCSC(coo::ROCSparseMatrixCOO) = ROCSparseMatrixCSC(ROCSparseMatrixCSR(coo)) # no direct conversion
ROCSparseMatrixCOO(csc::ROCSparseMatrixCSC) = ROCSparseMatrixCOO(ROCSparseMatrixCSR(csc)) # no direct conversion
ROCSparseMatrixBSR(coo::ROCSparseMatrixCOO, blockdim) = ROCSparseMatrixBSR(ROCSparseMatrixCSR(coo), blockdim) # no direct conversion
ROCSparseMatrixCOO(bsr::ROCSparseMatrixBSR) = ROCSparseMatrixCOO(ROCSparseMatrixCSR(bsr)) # no direct conversion


## sparse to dense, and vice-versa

for (cname,rname,elty) in ((:rocsparse_scsc2dense, :rocsparse_scsr2dense, :Float32),
                           (:rocsparse_dcsc2dense, :rocsparse_dcsr2dense, :Float64),
                           (:rocsparse_ccsc2dense, :rocsparse_ccsr2dense, :ComplexF32),
                           (:rocsparse_zcsc2dense, :rocsparse_zcsr2dense, :ComplexF64))
    @eval begin
        function AMDGPU.ROCMatrix{$elty}(csr::ROCSparseMatrixCSR{$elty}; ind::SparseChar='O')
            m,n = size(csr)
            denseA = AMDGPU.zeros($elty,m,n)

            rocdesc = ROCMatrixDescriptor('G', 'L', 'N', ind)
            lda = max(1,stride(denseA,2))
            $rname(handle(), m, n, rocdesc, nonzeros(csr),
                   csr.rowPtr, csr.colVal, denseA, lda)
            return denseA
        end
        function AMDGPU.ROCMatrix{$elty}(csc::ROCSparseMatrixCSC{$elty}; ind::SparseChar='O')
            m,n = size(csc)
            denseA = AMDGPU.zeros($elty,m,n)
            lda = max(1,stride(denseA,2))
            rocdesc = ROCMatrixDescriptor('G', 'L', 'N', ind)
            $cname(handle(), m, n, rocdesc, nonzeros(csc),
                   rowvals(csc), csc.colPtr, denseA, lda)
            return denseA
        end
    end
end

for (elty, welty) in ((:Float16, :Float32),
                      (:ComplexF16, :ComplexF32))
    @eval begin
        function AMDGPU.ROCMatrix{$elty}(csr::ROCSparseMatrixCSR{$elty}; ind::SparseChar='O')
            m,n = size(csr)
            denseA = AMDGPU.zeros($elty,m,n)
            desc_csr   = ROCSparseMatrixDescriptor(csr, ind)
            desc_dense = ROCDenseMatrixDescriptor(denseA)

            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_sparse_to_dense(handle(), desc_csr, desc_dense,
                    rocsparse_sparse_to_dense_alg_default, out, Ptr{Cvoid}())
                return out[]
            end
            with_workspace(bufferSize) do buffer
                rocsparse_sparse_to_dense(handle(), desc_csr, desc_dense,
                    rocsparse_sparse_to_dense_alg_default, bufferSize, buffer)
            end
            return denseA
        end
        function AMDGPU.ROCMatrix{$elty}(csc::ROCSparseMatrixCSC{$elty}; ind::SparseChar='O')
            m,n = size(csc)
            denseA = AMDGPU.zeros($elty,m,n)
            desc_csc   = ROCSparseMatrixDescriptor(csc, ind; convert=false)
            desc_dense = ROCDenseMatrixDescriptor(denseA)

            function bufferSize()
                out = Ref{Csize_t}(1)
                rocsparse_sparse_to_dense(handle(), desc_csc, desc_dense,
                    rocsparse_sparse_to_dense_alg_default, out, Ptr{Cvoid}())
                return out[]
            end
            with_workspace(bufferSize) do buffer
                rocsparse_sparse_to_dense(handle(), desc_csc, desc_dense,
                    rocsparse_sparse_to_dense_alg_default, bufferSize, buffer)
            end
            return denseA
        end
    end
end

Base.copyto!(dest::Array{T, 2}, src::AbstractROCSparseMatrix{T}) where T = copyto!(dest, ROCMatrix{T}(src))

for (nname,cname,rname,elty) in ((:rocsparse_snnz, :rocsparse_sdense2csc, :rocsparse_sdense2csr, :Float32),
                                 (:rocsparse_dnnz, :rocsparse_ddense2csc, :rocsparse_ddense2csr, :Float64),
                                 (:rocsparse_cnnz, :rocsparse_cdense2csc, :rocsparse_cdense2csr, :ComplexF32),
                                 (:rocsparse_znnz, :rocsparse_zdense2csc, :rocsparse_zdense2csr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR(A::ROCMatrix{$elty}; ind::SparseChar='O')
            m,n = size(A)
            lda = max(1, stride(A,2))
            rocdesc = ROCMatrixDescriptor('G',
                                        'L',
                                        'N', ind)
            nnzRowCol = AMDGPU.zeros(Cint, m)
            nnzTotal = Ref{Cint}(1)
            $nname(handle(),
                   'R', m, n, rocdesc, A, lda, nnzRowCol,
                   nnzTotal)
            nzVal = AMDGPU.zeros($elty,nnzTotal[])

            rowPtr = AMDGPU.zeros(Cint,m+1)
            colInd = AMDGPU.zeros(Cint,nnzTotal[])
            $rname(handle(), m, n, rocdesc, A,
                    lda, nnzRowCol, nzVal, rowPtr, colInd)
            return ROCSparseMatrixCSR(rowPtr,colInd,nzVal,size(A))
        end

        function ROCSparseMatrixCSC(A::ROCMatrix{$elty}; ind::SparseChar='O')
            m,n = size(A)
            lda = max(1, stride(A,2))
            rocdesc = ROCMatrixDescriptor('G',
                                        'L',
                                        'N', ind)
            nnzRowCol = AMDGPU.zeros(Cint, n)
            nnzTotal = Ref{Cint}(1)
            $nname(handle(),
                   'C', m, n, rocdesc, A, lda, nnzRowCol,
                   nnzTotal)
            nzVal = AMDGPU.zeros($elty,nnzTotal[])

            colPtr = AMDGPU.zeros(Cint,n+1)
            rowInd = AMDGPU.zeros(Cint,nnzTotal[])
            $cname(handle(), m, n, rocdesc, A,
                    lda, nnzRowCol, nzVal, colPtr, rowInd)
            return ROCSparseMatrixCSC(colPtr,rowInd,nzVal,size(A))
        end
    end
end


for (elty, welty) in ((:Float16, :Float32),
                      (:ComplexF16, :ComplexF32))
    @eval begin
        function ROCSparseMatrixCSR(A::ROCMatrix{$elty}; ind::SparseChar='O')
            wide_csr = ROCSparseMatrixCSR(convert(ROCMatrix{$welty}, A))
            return ROCSparseMatrixCSR(wide_csr.rowPtr, wide_csr.colVal, convert(ROCVector{$elty}, nonzeros(wide_csr)), size(wide_csr))
        end
        function ROCSparseMatrixCSC(A::ROCMatrix{$elty}; ind::SparseChar='O')
            wide_csc = ROCSparseMatrixCSC(convert(ROCMatrix{$welty}, A))
            return ROCSparseMatrixCSC(wide_csc.colPtr, wide_csc.rowVal, convert(ROCVector{$elty}, nonzeros(wide_csc)), size(wide_csc))
        end
    end
end

function AMDGPU.ROCMatrix{T}(bsr::ROCSparseMatrixBSR{T}; inda::SparseChar='O',
                          indc::SparseChar='O') where {T}
    ROCMatrix{T}(ROCSparseMatrixCSR{T}(bsr; inda, indc))
end

function ROCSparseMatrixBSR(A::ROCMatrix; ind::SparseChar='O')
    m,n = size(A)   # TODO: always let the user choose, or provide defaults for other methods too
    ROCSparseMatrixBSR(ROCSparseMatrixCSR(A; ind), gcd(m,n))
end
