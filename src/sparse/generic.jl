# generic APIs

## API functions

function sparsetodense(A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, index::SparseChar,
                       algo::rocsparse_sparse_to_dense_alg=rocsparse_sparse_to_dense_alg_default) where {T}
    m,n = size(A)
    B = ROCMatrix{T}(undef, m, n)
    desc_sparse = ROCSparseMatrixDescriptor(A, index)
    desc_dense = ROCDenseMatrixDescriptor(B)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_sparse_to_dense(handle(), desc_sparse, desc_dense, algo, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        rocsparse_sparse_to_dense(handle(), desc_sparse, desc_dense, algo, buffer_size, buffer)
    end
    return B
end

function densetosparse(A::ROCMatrix{T}, fmt::Symbol, index::SparseChar,
                       algo::rocsparse_dense_to_sparse_alg=rocsparse_dense_to_sparse_alg_default) where {T}
    m,n = size(A)
    local rowPtr, colPtr, desc_sparse, B
    if fmt == :coo
        desc_sparse = ROCSparseMatrixDescriptor(ROCSparseMatrixCOO, T, Cint, m, n, index)
    elseif fmt == :csr
        rowPtr = ROCVector{Cint}(undef, m+1)
        desc_sparse = ROCSparseMatrixDescriptor(ROCSparseMatrixCSR, rowPtr, T, Cint, m, n, index)
    elseif fmt == :csc
        colPtr = ROCVector{Cint}(undef, n+1)
        desc_sparse = ROCSparseMatrixDescriptor(ROCSparseMatrixCSC, colPtr, T, Cint, m, n, index)
    else
        error("Format :$fmt not available, use :csc, :csr or :coo.")
    end
    desc_dense = ROCDenseMatrixDescriptor(A)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        # Analysis
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, C_NULL, buffer)
        nnzB = Ref{Int64}()
        rocsparse_spmat_get_size(desc_sparse, Ref{Int64}(), Ref{Int64}(), nnzB)
        if fmt == :coo
            rowInd = ROCVector{Cint}(undef, nnzB[])
            colInd = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCOO{T, Cint}(rowInd, colInd, nzVal, (m,n))
            rocsparse_coo_set_pointers(desc_sparse, B.rowInd, B.colInd, B.nzVal)
        elseif fmt == :csr
            colVal = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCSR{T, Cint}(rowPtr, colVal, nzVal, (m,n))
            rocsparse_csr_set_pointers(desc_sparse, B.rowPtr, B.colVal, B.nzVal)
        elseif fmt == :csc
            rowVal = ROCVector{Cint}(undef, nnzB[])
            nzVal = ROCVector{T}(undef, nnzB[])
            B = ROCSparseMatrixCSC{T, Cint}(colPtr, rowVal, nzVal, (m,n))
            rocsparse_csc_set_pointers(desc_sparse, B.colPtr, B.rowVal, B.nzVal)
        else
            error("Format :$fmt not available, use :csc, :csr or :coo.")
        end
        rocsparse_dense_to_sparse(handle(), desc_dense, desc_sparse, algo, buffer_size, buffer)
    end
    return B
end

function gather!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_gather(handle(), descY, descX)
    X
end

function scatter!(Y::ROCVector, X::ROCSparseVector, index::SparseChar)
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_scatter(handle(), descX, descY)
    return Y
end

function axpby!(alpha::Number, X::ROCSparseVector{T}, beta::Number, Y::ROCVector{T}, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_axpby(handle(), Ref{T}(alpha), descX, Ref{T}(beta), descY)
    return Y
end

function rot!(X::ROCSparseVector{T}, Y::ROCVector{T}, c::Number, s::Number, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    rocsparse_rot(handle(), Ref{T}(c), Ref{T}(s), descX, descY)
    return X, Y
end

function vv!(transx::SparseChar, X::ROCSparseVector{T}, Y::DenseROCVector{T}, index::SparseChar) where {T}
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)
    result = Ref{T}()

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spvv(handle(), transx, descX, descY, result, T, out, C_NULL)
        return out[]
    end

    buffer_size = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        buffer_size[] = sizeof(buffer)
        rocsparse_spvv(handle(), transx, descX, descY, result, T, buffer_size, buffer)
    end
    return result[]
end

function mv!(
    transa::SparseChar, alpha::Number, A::Union{ROCSparseMatrixCSR{T}, ROCSparseMatrixCSC{T}, ROCSparseMatrixCOO{T}},
    X::DenseROCVector{T}, beta::Number, Y::DenseROCVector{T}, index::SparseChar,
    algo::rocsparse_spmv_alg = rocsparse_spmv_alg_default,
) where T

    # Support transa = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa

    descA = ROCSparseMatrixDescriptor(A, index)
    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)

    m,n = size(A)
    if transa == 'N'
        chkmvdims(X,n,Y,m)
    elseif transa == 'T' || transa == 'C'
        chkmvdims(X,m,Y,n)
    end

    function bufferSize()
        out = Ref{Csize_t}()
        if HIP.runtime_version() ≥ v"6-"
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo,
                rocsparse_spmv_stage_buffer_size, out, C_NULL)
        else
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo, out, C_NULL)
        end
        return out[]
    end

    size_ref = Ref{Csize_t}()
    with_workspace(bufferSize) do buffer
        size_ref[] = sizeof(buffer)
        if HIP.runtime_version() ≥ v"6-"
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo,
                rocsparse_spmv_stage_preprocess, size_ref, buffer)
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo,
                rocsparse_spmv_stage_compute, size_ref, buffer)
        else
            rocsparse_spmv(
                handle(), transa, Ref{T}(alpha), descA, descX,
                Ref{T}(beta), descY, T, algo, size_ref, buffer)
        end
    end
    Y
end

function mm!(
    transa::SparseChar, transb::SparseChar, alpha::Number, A::Union{ROCSparseMatrixCSR{T}, ROCSparseMatrixCSC{T}, ROCSparseMatrixCOO{T}},
    B::DenseROCMatrix{T}, beta::Number, C::DenseROCMatrix{T}, index::SparseChar,
    algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default,
) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Matrix-matrix multiplication with the adjoint of a CSC matrix" *
                            " is not supported. Use a CSR or COO matrix instead."))
    end

    if isa(A, ROCSparseMatrixCSC)
        descA = ROCSparseMatrixDescriptor(A, index, transposed=true)
        k,m = size(A)
        transa = transa == 'N' ? 'T' : 'N'
    else
        descA = ROCSparseMatrixDescriptor(A, index)
        m,k = size(A)
    end
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

    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCDenseMatrixDescriptor(C)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spmm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spmm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

function mm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::DenseROCMatrix{T},
             B::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}},
             beta::Number, C::DenseROCMatrix{T}, index::SparseChar, algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(B, ROCSparseMatrixCSR) && transb == 'C' && T <: Complex
        throw(ArgumentError("Matrix-matrix multiplication with the adjoint of a complex CSR matrix" *
                            " is not supported by the current CUDA version. Use a CSC or COO matrix instead."))
    end

    if isa(B, ROCSparseMatrixCSR)
        descB = ROCSparseMatrixDescriptor(B, index)
        transb = transb == 'N' ? 'T' : 'N'
    else
        descB = ROCSparseMatrixDescriptor(B, index, transposed=true)
    end
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

    descA = ROCDenseMatrixDescriptor(A, transposed=true)
    descC = ROCDenseMatrixDescriptor(C, transposed=true)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmm(
            handle(), transb, transa, Ref{T}(alpha), descB, descA, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spmm(
            handle(), transb, transa, Ref{T}(alpha), descB, descA, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spmm(
            handle(), transb, transa, Ref{T}(alpha), descB, descA, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

function gemm!(
    transa::SparseChar, transb::SparseChar, α::Number, A::ROCSparseMatrixCSR{T},
    B::ROCSparseMatrixCSR{T}, β::Number, C::ROCSparseMatrixCSR{T},
    index::SparseChar,
) where T
    m, k = size(A)
    n = size(C)[2]
    alpha = convert(T, α)
    beta = convert(T, β)

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    else
        throw(ArgumentError("Sparse mm! only supports transa ($transa) = 'N' and transb ($transb) = 'N'"))
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCSparseMatrixDescriptor(B, index)
    descC = ROCSparseMatrixDescriptor(C, index)

    function bufferSize()
        out = Ref{Csize_t}(0)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_buffer_size, out, C_NULL)
        return out[]
    end
    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_nnz, buffer_len_ref, buffer)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default,
            rocsparse_spgemm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

function sv!(transa::SparseChar, uplo::SparseChar, diag::SparseChar,
             alpha::Number, A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, X::DenseROCVector{T},
             Y::DenseROCVector{T}, index::SparseChar, algo::rocsparse_spsv_alg=rocsparse_spsv_alg_default) where T

    # Support transa = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Backward and forward sweeps with the adjoint of a complex CSC matrix is not supported. Use a CSR or COO matrix instead."))
    end

    mA,nA = size(A)
    mX = length(X)
    mY = length(Y)

    (mA != nA) && throw(DimensionMismatch("A must be square, but has dimensions ($mA,$nA)!"))
    (mX != mA) && throw(DimensionMismatch("X must have length $mA, but has length $mX"))
    (mY != mA) && throw(DimensionMismatch("Y must have length $mA, but has length $mY"))

    if isa(A, ROCSparseMatrixCSC)
        descA = ROCSparseMatrixDescriptor(A, index, transposed=true)
        transa = transa == 'N' ? 'T' : 'N'
        uplo = uplo == 'U' ? 'L' : 'U'
    else
        descA = ROCSparseMatrixDescriptor(A, index)
    end

    rocsparse_uplo = Ref{rocsparse_fill_mode}(uplo)
    rocsparse_diag = Ref{rocsparse_diag_type}(diag)

    rocsparse_spmat_set_attribute(descA, 'F', rocsparse_uplo, Csize_t(sizeof(rocsparse_uplo)))
    rocsparse_spmat_set_attribute(descA, 'D', rocsparse_diag, Csize_t(sizeof(rocsparse_diag)))

    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spsv(
            handle(), transa, Ref{T}(alpha), descA, descX, descY, T,
            algo, rocsparse_spsv_stage_compute, buffer_len_ref, buffer)
    end
    return Y
end

function sm!(transa::SparseChar, transb::SparseChar, uplo::SparseChar, diag::SparseChar,
             alpha::Number, A::Union{ROCSparseMatrixCSC{T},ROCSparseMatrixCSR{T},ROCSparseMatrixCOO{T}}, B::DenseROCMatrix{T},
             C::DenseROCMatrix{T}, index::SparseChar, algo::rocsparse_spsm_alg=rocsparse_spsm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

    if isa(A, ROCSparseMatrixCSC) && transa == 'C' && T <: Complex
        throw(ArgumentError("Backward and forward sweeps with the adjoint of a complex CSC matrix is not supported. Use a CSR or COO matrix instead."))
    end

    mA,nA = size(A)
    mB,nB = size(B)
    mC,nC = size(C)

    (mA != nA) && throw(DimensionMismatch("A must be square, but has dimensions ($mA,$nA)!"))
    (mC != mA) && throw(DimensionMismatch("C must have $mA rows, but has $mC rows"))
    (mB != mA) && (transb == 'N') && throw(DimensionMismatch("B must have $mA rows, but has $mB rows"))
    (nB != mA) && (transb != 'N') && throw(DimensionMismatch("B must have $mA columns, but has $nB columns"))
    (nB != nC) && (transb == 'N') && throw(DimensionMismatch("B and C must have the same number of columns, but B has $nB columns and C has $nC columns"))
    (mB != nC) && (transb != 'N') && throw(DimensionMismatch("B must have the same the number of rows that C has as columns, but B has $mB rows and C has $nC columns"))

    if isa(A, ROCSparseMatrixCSC)
        descA = ROCSparseMatrixDescriptor(A, index, transposed=true)
        transa = transa == 'N' ? 'T' : 'N'
        uplo = uplo == 'U' ? 'L' : 'U'
    else
        descA = ROCSparseMatrixDescriptor(A, index)
    end

    rocsparse_uplo = Ref{rocsparse_fill_mode}(uplo)
    rocsparse_diag = Ref{rocsparse_diag_type}(diag)

    rocsparse_spmat_set_attribute(descA, 'F', rocsparse_uplo, Csize_t(sizeof(rocsparse_uplo)))
    rocsparse_spmat_set_attribute(descA, 'D', rocsparse_diag, Csize_t(sizeof(rocsparse_diag)))

    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCDenseMatrixDescriptor(C)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_buffer_size, out, C_NULL)
        return out[]
    end

    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spsm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, descC, T,
            algo, rocsparse_spsm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

function sddmm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::DenseROCMatrix{T}, B::DenseROCMatrix{T},
                beta::Number, C::ROCSparseMatrixCSR{T}, index::SparseChar, algo::rocsparse_sddmm_alg=rocsparse_sddmm_alg_default) where T

    # Support transa = 'C' and `transb = 'C' for real matrices
    transa = T <: Real && transa == 'C' ? 'T' : transa
    transb = T <: Real && transb == 'C' ? 'T' : transb

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

    descA = ROCDenseMatrixDescriptor(A)
    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCSparseMatrixDescriptor(C, index)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_sddmm_buffer_size(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, out)
        return out[]
    end
    with_workspace(bufferSize) do buffer
        rocsparse_sddmm_preprocess(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, buffer)
        rocsparse_sddmm(handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta), descC, T, algo, buffer)
    end
    return C
end
