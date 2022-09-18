# generic APIs

## dense vector descriptor

mutable struct ROCDenseVectorDescriptor
    handle::rocsparse_dnvec_descr

    function ROCDenseVectorDescriptor(x::DenseROCVector)
        desc_ref = Ref{rocsparse_dnvec_descr}()
        rocsparse_create_dnvec_descr(desc_ref, length(x), x, eltype(x))
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_dnvec_descr, obj)
        obj
    end
end

Base.unsafe_convert(::Type{rocsparse_dnvec_descr}, desc::ROCDenseVectorDescriptor) = desc.handle


## sparse vector descriptor

mutable struct ROCSparseVectorDescriptor
    handle::rocsparse_spvec_descr

    function ROCSparseVectorDescriptor(x::ROCSparseVector, IndexBase::Char)
        desc_ref = Ref{rocsparse_spvec_descr}()
        rocsparse_create_spvec_descr(desc_ref, length(x), nnz(x), nonzeroinds(x), nonzeros(x),
                                     eltype(nonzeroinds(x)), IndexBase, eltype(x))
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spvec_descr, obj)
        obj
    end
end

Base.unsafe_convert(::Type{rocsparse_spvec_descr}, desc::ROCSparseVectorDescriptor) = desc.handle


## dense matrix descriptor

mutable struct ROCDenseMatrixDescriptor
    handle::rocsparse_dnmat_descr

    function ROCDenseMatrixDescriptor(x::DenseROCMatrix)
        desc_ref = Ref{rocsparse_dnmat_descr}()
        rocsparse_create_dnmat_descr(desc_ref, size(x)..., stride(x,2), x, eltype(x), rocsparse_order_column)
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_dnmat_descr, obj)
        obj
    end
end

Base.unsafe_convert(::Type{rocsparse_dnmat_descr}, desc::ROCDenseMatrixDescriptor) = desc.handle


## sparse matrix descriptor

mutable struct ROCSparseMatrixDescriptor
    handle::rocsparse_spmat_descr

    function ROCSparseMatrixDescriptor(A::ROCSparseMatrixCSR, IndexBase::Char)
        desc_ref = Ref{rocsparse_spmat_descr}()
        rocsparse_create_csr_descr(
            desc_ref,
            size(A)..., length(nonzeros(A)),
            A.rowPtr, A.colVal, nonzeros(A),
            eltype(A.rowPtr), eltype(A.colVal), IndexBase, eltype(nonzeros(A))
        )
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spmat_descr, obj)
        return obj
    end

    function ROCSparseMatrixDescriptor(A::ROCSparseMatrixCSC, IndexBase::Char; convert=true)
        desc_ref = Ref{rocsparse_spmat_descr}()
        if convert
            # many algorithms, e.g. mv! and mm!, do not support CSC sparse format
            # so we eagerly convert this to a CSR matrix.
            rocsparse_create_csr_descr(
                desc_ref,
                reverse(size(A))..., length(nonzeros(A)),
                A.colPtr, rowvals(A), nonzeros(A),
                eltype(A.colPtr), eltype(rowvals(A)), IndexBase, eltype(nonzeros(A))
            )
        else
            rocsparse_create_csc_descr(
                desc_ref,
                size(A)..., length(nonzeros(A)),
                A.colPtr, rowvals(A), nonzeros(A),
                eltype(A.colPtr), eltype(rowvals(A)), IndexBase, eltype(nonzeros(A))
            )
        end
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spmat_descr, obj)
        return obj
    end
end

Base.unsafe_convert(::Type{rocsparse_spmat_descr}, desc::ROCSparseMatrixDescriptor) = desc.handle


## API functions

function gather!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
    descX = ROCSparseVectorDescriptor(X, index)
    descY = ROCDenseVectorDescriptor(Y)

    rocsparse_gather(handle(), descY, descX)

    X
end

function mv!(transa::SparseChar, alpha::Number, A::Union{ROCSparseMatrixBSR{TA},ROCSparseMatrixCSR{TA}},
             X::DenseROCVector{T}, beta::Number, Y::DenseROCVector{T}, index::SparseChar, algo::rocsparse_spmv_alg=rocsparse_spmv_alg_default) where {TA, T}
    m,n = size(A)

    if transa == 'N'
        chkmvdims(X,n,Y,m)
    elseif transa == 'T' || transa == 'C'
        chkmvdims(X,m,Y,n)
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)

    # operations with 16-bit numbers always imply mixed-precision computation
    # TODO: we should better model the supported combinations here,
    #       and error if using an unsupported one (like with gemmEx!)
    compute_type = if T == Float16
        Float32
    elseif T == ComplexF16
        ComplexF32
    else
        T
    end

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmv(handle(), transa, Ref{compute_type}(alpha), descA, descX, Ref{compute_type}(beta),
                              descY, compute_type, algo, out, Ptr{Cvoid}(C_NULL))
        return out[]
    end
    with_workspace(bufferSize) do buffer
        rocsparse_spmv(handle(), transa, Ref{compute_type}(alpha), descA, descX, Ref{compute_type}(beta),
                     descY, compute_type, algo, Ref{Csize_t}(sizeof(buffer)), buffer)
    end
    Y
end

function mv!(transa::SparseChar, alpha::Number, A::ROCSparseMatrixCSC{TA}, X::DenseROCVector{T},
             beta::Number, Y::DenseROCVector{T}, index::SparseChar, algo::rocsparse_spmv_alg=rocsparse_spmv_alg_default) where {TA, T}
    ctransa = 'N'
    if transa == 'N'
        ctransa = 'T'
    elseif transa == 'C' && TA <: Complex
        throw(ArgumentError("Matrix-vector multiplication with the adjoint of a CSC matrix" *
                            " is not supported. Use a CSR matrix instead."))
    end

    n,m = size(A)

    if ctransa == 'N'
        chkmvdims(X,n,Y,m)
    elseif ctransa == 'T' || ctransa == 'C'
        chkmvdims(X,m,Y,n)
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descX = ROCDenseVectorDescriptor(X)
    descY = ROCDenseVectorDescriptor(Y)

    # operations with 16-bit numbers always imply mixed-precision computation
    # TODO: we should better model the supported combinations here,
    #       and error if using an unsupported one (like with gemmEx!)
    compute_type = if T == Float16
        Float32
    elseif T == ComplexF16
        ComplexF32
    else
        T
    end

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmv(handle(), ctransa, Ref{compute_type}(alpha), descA, descX, Ref{compute_type}(beta),
                                 descY, compute_type, algo, out, Ptr{Cvoid}(C_NULL))
        return out[]
    end
    with_workspace(bufferSize) do buffer
        rocsparse_spmv(handle(), ctransa, Ref{compute_type}(alpha), descA, descX, Ref{compute_type}(beta),
                      descY, compute_type, algo, Ref{Csize_t}(sizeof(buffer)), buffer)
    end

    return Y
end

function mm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::ROCSparseMatrixCSR{T},
             B::DenseROCMatrix{T}, beta::Number, C::DenseROCMatrix{T}, index::SparseChar, 
             algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default) where {T}
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

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCDenseMatrixDescriptor(C)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_buffer_size, out, Ptr{Cvoid}(C_NULL))
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

function mm!(transa::SparseChar, transb::SparseChar, alpha::Number, A::ROCSparseMatrixCSC{T},
             B::DenseROCMatrix{T}, beta::Number, C::DenseROCMatrix{T}, index::SparseChar, 
             algo::rocsparse_spmm_alg=rocsparse_spmm_alg_default) where {T}
    ctransa = 'N'
    if transa == 'N'
        ctransa = 'T'
    elseif transa == 'C' && T <: Complex
        throw(ArgumentError("Matrix-matrix multiplication with the adjoint of a CSC matrix" *
                            " is not supported. Use a CSR matrix instead."))
    end

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

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCDenseMatrixDescriptor(B)
    descC = ROCDenseMatrixDescriptor(C)

    function bufferSize()
        out = Ref{Csize_t}()
        rocsparse_spmm(
            handle(), ctransa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_buffer_size, out, Ptr{Cvoid}(C_NULL))
        return out[]
    end
    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spmm(
            handle(), ctransa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_preprocess, buffer_len_ref, buffer)
        rocsparse_spmm(
            handle(), ctransa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, T, algo, rocsparse_spmm_stage_compute, buffer_len_ref, buffer)
    end

    return C
end

function mm!(transa::SparseChar, transb::SparseChar, α::Number, A::ROCSparseMatrixCSR{T},
             B::ROCSparseMatrixCSR{T}, β::Number, C::ROCSparseMatrixCSR{T}, index::SparseChar) where {T}
    m,k = size(A)
    n = size(C)[2]
    alpha = convert(T, α)
    beta  = convert(T, β)

    if transa == 'N' && transb == 'N'
        chkmmdims(B,C,k,n,m,n)
    else
        throw(ArgumentError("Sparse mm! only supports transa ($transa) = 'N' and transb ($transb) = 'N'"))
    end

    descA = ROCSparseMatrixDescriptor(A, index)
    descB = ROCSparseMatrixDescriptor(B, index)
    descC = ROCSparseMatrixDescriptor(C, index)

    descD = ROCSparseMatrixDescriptor()

    function bufferSize()
        out = Ref{Csize_t}(0)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default, rocsparse_spgemm_stage_buffer_size, out,
            Ptr{Cvoid}(C_NULL))
        return out[]
    end
    with_workspace(bufferSize) do buffer
        buffer_len_ref = Ref{Csize_t}(sizeof(buffer))
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default, rocsparse_spgemm_stage_nnz, buffer_len_ref, buffer)
        rocsparse_spgemm(
            handle(), transa, transb, Ref{T}(alpha), descA, descB, Ref{T}(beta),
            descC, descC, T, rocsparse_spgemm_alg_default, rocsparse_spgemm_stage_compute, buffer_len_ref, buffer)
    end
    return C
end

