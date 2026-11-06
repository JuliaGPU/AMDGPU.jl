# conversions involving rocSPARSE-specific functionality
#
# Conversions between the canonical formats, and between dense and sparse arrays, are
# GPUArrays' portable implementations. What remains here are the rocSPARSE routines for
# the BSR format.

"""
    sparse(x::ROCMatrix; fmt=:csc)

Return a sparse ROC matrix with `Cint` indices, with type determined by `fmt`: `:csc`,
`:csr`, `:coo` or `:bsr`.
"""
function SparseArrays.sparse(A::ROCMatrix; fmt::Symbol=:csc)
    # (with `Cint` indices, like the constructors)
    fmt === :csc && return ROCSparseMatrixCSC(A)
    fmt === :csr && return ROCSparseMatrixCSR(A)
    fmt === :coo && return ROCSparseMatrixCOO(A)
    fmt === :bsr && return ROCSparseMatrixBSR(A)
    throw(ArgumentError("Format :$fmt not available, use :csc, :csr, :bsr or :coo."))
end

# The BSR conversions of rocSPARSE only support 32-bit indices. Matrices with other index
# types are narrowed to `Cint` around these calls.
function check_cint_indices(op, sizes::Integer...)
    for sz in sizes
        sz <= typemax(Cint) || throw(ArgumentError(
            "$op uses 32-bit indices in rocSPARSE, which cannot represent a size of $sz"))
    end
    return
end
cint_indices(x::ROCVector) = convert(ROCVector{Cint}, x)

## CSR to BSR and vice-versa

for (fname,elty) in ((:rocsparse_scsr2bsr, :Float32),
                     (:rocsparse_dcsr2bsr, :Float64),
                     (:rocsparse_ccsr2bsr, :ComplexF32),
                     (:rocsparse_zcsr2bsr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixBSR{$elty}(
            csr::ROCSparseMatrixCSR{$elty,Ti}, blockDim::Integer;
            dir::SparseChar = 'R', inda::SparseChar = 'O', indc::SparseChar = 'O',
        ) where {Ti}
            m,n = size(csr)
            mb = cld(m, blockDim)
            nb = cld(n, blockDim)
            if iszero(m) || iszero(n)
                bsrRowPtr = fill!(ROCVector{Cint}(undef, mb + 1), indc == 'O' ? one(Cint) : zero(Cint))
                return ROCSparseMatrixBSR{$elty,Cint}(
                    bsrRowPtr, ROCVector{Cint}(undef, 0), ROCVector{$elty}(undef, 0), size(csr),
                    blockDim, dir, 0)
            end
            check_cint_indices("CSR to BSR conversion", m, n, nnz(csr) + 1)
            csrRowPtr = cint_indices(csr.rowPtr)
            csrColInd = cint_indices(csr.colVal)
            nnz_ref = Ref{Cint}()
            bsrRowPtr = AMDGPU.zeros(Cint,mb + 1)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)

            rocsparse_csr2bsr_nnz(
                handle(), dir, m, n, rocdesca, csrRowPtr,
                csrColInd, blockDim, rocdescc, bsrRowPtr, nnz_ref)

            bsrNzVal = AMDGPU.zeros($elty, nnz_ref[] * blockDim * blockDim )
            bsrColInd = AMDGPU.zeros(Cint, nnz_ref[])

            $fname(
                handle(), dir, m, n,
                rocdesca, nonzeros(csr), csrRowPtr, csrColInd,
                blockDim, rocdescc, bsrNzVal, bsrRowPtr, bsrColInd)

            # (with 32-bit indices, which all BSR routines take)
            ROCSparseMatrixBSR{$elty,Cint}(
                bsrRowPtr, bsrColInd, bsrNzVal, size(csr), blockDim, dir, nnz_ref[])
        end
    end
end

for (fname,elty) in ((:rocsparse_sbsr2csr, :Float32),
                     (:rocsparse_dbsr2csr, :Float64),
                     (:rocsparse_cbsr2csr, :ComplexF32),
                     (:rocsparse_zbsr2csr, :ComplexF64))
    @eval begin
        function ROCSparseMatrixCSR{$elty}(
            bsr::ROCSparseMatrixBSR{$elty,Ti};
            inda::SparseChar = 'O', indc::SparseChar = 'O',
        ) where {Ti}
            m,n = size(bsr)
            mb = cld(m, bsr.blockDim)
            nb = cld(n, bsr.blockDim)
            # the result covers whole blocks, which can extend past the matrix
            padded_m, padded_n = mb*Int(bsr.blockDim), nb*Int(bsr.blockDim)
            if iszero(bsr.nnzb) || iszero(mb) || iszero(nb)
                return ROCSparseMatrixCSR(fill!(ROCVector{Ti}(undef, m + 1), one(Ti)),
                                          ROCVector{Ti}(undef, 0), ROCVector{$elty}(undef, 0),
                                          (m, n))
            end
            check_cint_indices("BSR to CSR conversion", padded_m, padded_n, nnz(bsr) + 1)
            rocdesca = ROCMatrixDescriptor('G', 'L', 'N', inda)
            rocdescc = ROCMatrixDescriptor('G', 'L', 'N', indc)
            csrRowPtr = AMDGPU.zeros(Cint, padded_m + 1)
            csrColInd = AMDGPU.zeros(Cint, nnz(bsr))
            csrNzVal  = AMDGPU.zeros($elty, nnz(bsr))

            $fname(handle(), bsr.dir, mb, nb,
                   rocdesca, nonzeros(bsr), cint_indices(bsr.rowPtr), cint_indices(bsr.colVal),
                   bsr.blockDim, rocdescc, csrNzVal, csrRowPtr, csrColInd)
            csr = ROCSparseMatrixCSR{$elty,Ti}(csrRowPtr, csrColInd, csrNzVal, (padded_m, padded_n))
            (padded_m, padded_n) == (m, n) ? csr : csr[1:m, 1:n]
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

ROCSparseMatrixBSR(coo::ROCSparseMatrixCOO, blockdim) = ROCSparseMatrixBSR(ROCSparseMatrixCSR(coo), blockdim) # no direct conversion
ROCSparseMatrixBSR(csc::ROCSparseMatrixCSC, blockdim) = ROCSparseMatrixBSR(ROCSparseMatrixCSR(csc), blockdim) # no direct conversion
ROCSparseMatrixBSR(csr::ROCSparseMatrixCSR{T}, blockdim; kwargs...) where {T} =
    ROCSparseMatrixBSR{T}(csr, blockdim; kwargs...)
ROCSparseMatrixBSR{T,Ti}(A::ROCCanonicalMatrix, blockdim::Integer; kwargs...) where {T,Ti} =
    ROCSparseMatrixBSR{T,Ti}(ROCSparseMatrixBSR(ROCSparseMatrixCSR{T}(A), blockdim; kwargs...))

ROCSparseMatrixCSR(bsr::ROCSparseMatrixBSR{T}; kwargs...) where {T} = ROCSparseMatrixCSR{T}(bsr; kwargs...)
ROCSparseMatrixCSR{T,Ti}(bsr::ROCSparseMatrixBSR) where {T,Ti} =
    GPUSparseMatrixCSR{T,Ti}(ROCSparseMatrixCSR(bsr))
for S in (:ROCSparseMatrixCSC, :ROCSparseMatrixCOO)
    @eval begin
        $S(bsr::ROCSparseMatrixBSR) = $S(ROCSparseMatrixCSR(bsr)) # no direct conversion
        $S{T}(bsr::ROCSparseMatrixBSR) where {T} = $S{T}(ROCSparseMatrixCSR(bsr))
        $S{T,Ti}(bsr::ROCSparseMatrixBSR) where {T,Ti} = $S{T,Ti}(ROCSparseMatrixCSR(bsr))
    end
end

ROCSparseMatrixBSR(A::ROCMatrix, blockDim::Integer=max(gcd(size(A)...), 1)) =
    ROCSparseMatrixBSR(ROCSparseMatrixCSR{eltype(A),Cint}(A), blockDim)
AMDGPU.ROCMatrix{T}(bsr::ROCSparseMatrixBSR{T}) where {T} = ROCMatrix{T}(ROCSparseMatrixCSR(bsr))
