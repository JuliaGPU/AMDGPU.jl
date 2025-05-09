# rocSPARSE helper functions

## matrix descriptor

mutable struct ROCMatrixDescriptor
    handle::rocsparse_mat_descr

    function ROCMatrixDescriptor()
        descr_ref = Ref{rocsparse_mat_descr}()
        rocsparse_create_mat_descr(descr_ref)
        obj = new(descr_ref[])
        return finalizer(rocsparse_destroy_mat_descr, obj)
    end
end

Base.unsafe_convert(::Type{rocsparse_mat_descr}, desc::ROCMatrixDescriptor) = desc.handle

function ROCMatrixDescriptor(
    MatrixType::Char, FillMode::Char, DiagType::Char, IndexBase::Char,
)
    desc = ROCMatrixDescriptor()
    if MatrixType != 'G'
        rocsparse_set_mat_type(desc, MatrixType)
    end
    rocsparse_set_mat_fill_mode(desc, FillMode)
    rocsparse_set_mat_diag_type(desc, DiagType)
    if IndexBase != 'Z'
        rocsparse_set_mat_index_base(desc, IndexBase)
    end
    return desc
end

## dense vector descriptor

mutable struct ROCDenseVectorDescriptor
    handle::rocsparse_dnvec_descr

    function ROCDenseVectorDescriptor(T::DataType, n::Integer)
        desc_ref = Ref{rocsparse_dnvec_descr}()
        rocsparse_create_dnvec_descr(desc_ref, n, T[], T)
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_dnvec_descr, obj)
    end

    function ROCDenseVectorDescriptor(x::DenseROCVector)
        desc_ref = Ref{rocsparse_dnvec_descr}()
        rocsparse_create_dnvec_descr(desc_ref, length(x), x, eltype(x))
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_dnvec_descr, obj)
    end
end

Base.unsafe_convert(::Type{rocsparse_dnvec_descr}, desc::ROCDenseVectorDescriptor) = desc.handle

## sparse vector descriptor

mutable struct ROCSparseVectorDescriptor
    handle::rocsparse_spvec_descr

    function ROCSparseVectorDescriptor(x::ROCSparseVector, IndexBase::Char)
        desc_ref = Ref{rocsparse_spvec_descr}()
        rocsparse_create_spvec_descr(
            desc_ref, length(x), nnz(x), nonzeroinds(x), nonzeros(x),
            eltype(nonzeroinds(x)), IndexBase, eltype(x))
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_spvec_descr, obj)
    end
end

Base.unsafe_convert(::Type{rocsparse_spvec_descr}, desc::ROCSparseVectorDescriptor) = desc.handle

## dense matrix descriptor

mutable struct ROCDenseMatrixDescriptor
    handle::rocsparse_dnmat_descr

    function ROCDenseMatrixDescriptor(T::DataType, m::Integer, n::Integer; transposed::Bool=false)
        desc_ref = Ref{rocsparse_dnmat_descr}()
        if transposed
            rocsparse_create_dnmat_descr(desc_ref, n, m, m, T[], T, 'R')
        else
            rocsparse_create_dnmat_descr(desc_ref, m, n, m, T[], T, 'C')
        end
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_dnmat_descr, obj)
    end

    function ROCDenseMatrixDescriptor(x::DenseROCMatrix; transposed::Bool=false)
        desc_ref = Ref{rocsparse_dnmat_descr}()
        if transposed
            rocsparse_create_dnmat_descr(desc_ref, size(x)..., stride(x,2), x, eltype(x), 'R')
        else
            rocsparse_create_dnmat_descr(desc_ref, size(x)..., stride(x,2), x, eltype(x), 'C')
        end
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_dnmat_descr, obj)
    end
end

Base.unsafe_convert(::Type{rocsparse_dnmat_descr}, desc::ROCDenseMatrixDescriptor) = desc.handle

## sparse matrix descriptor

mutable struct ROCSparseMatrixDescriptor
    handle::rocsparse_spmat_descr

    function ROCSparseMatrixDescriptor(A::ROCSparseMatrixCOO, IndexBase::Char; transposed::Bool=false)
        desc_ref = Ref{rocsparse_spmat_descr}()
        if transposed
            rocsparse_create_coo_descr(
                desc_ref, reverse(size(A))..., nnz(A),
                A.colInd, A.rowInd, nonzeros(A),
                eltype(A.colInd), IndexBase, eltype(nonzeros(A))
            )
        else
            rocsparse_create_coo_descr(
                desc_ref, size(A)..., nnz(A),
                A.rowInd, A.colInd, nonzeros(A),
                eltype(A.rowInd), IndexBase, eltype(nonzeros(A))
            )
        end
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_spmat_descr, obj)
    end

    function ROCSparseMatrixDescriptor(::Type{ROCSparseMatrixCOO}, Tv::DataType, Ti::DataType, m::Integer, n::Integer, IndexBase::Char)
        desc_ref = Ref{rocsparse_spmat_descr}()
        rocsparse_create_coo_descr(desc_ref, m, n, Ti(0), C_NULL, C_NULL, C_NULL, Ti, IndexBase, Tv)
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spmat_descr, obj)
        return obj
    end

    function ROCSparseMatrixDescriptor(A::ROCSparseMatrixCSR, IndexBase::Char; transposed::Bool=false)
        desc_ref = Ref{rocsparse_spmat_descr}()
        if transposed
            rocsparse_create_csc_descr(
                desc_ref, reverse(size(A))..., nnz(A),
                A.rowPtr, A.colVal, nonzeros(A),
                eltype(A.rowPtr), eltype(A.colVal), IndexBase, eltype(nonzeros(A)))
        else
            rocsparse_create_csr_descr(
                desc_ref, size(A)..., nnz(A),
                A.rowPtr, A.colVal, nonzeros(A),
                eltype(A.rowPtr), eltype(A.colVal), IndexBase, eltype(nonzeros(A)))
        end
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_spmat_descr, obj)
    end

    function ROCSparseMatrixDescriptor(::Type{ROCSparseMatrixCSR}, rowPtr::ROCVector, Tv::DataType, Ti::DataType, m::Integer, n::Integer, IndexBase::Char)
        desc_ref = Ref{rocsparse_spmat_descr}()
        rocsparse_create_csr_descr(desc_ref, m, n, Ti(0), rowPtr, C_NULL, C_NULL, Ti, Ti, IndexBase, Tv)
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spmat_descr, obj)
        return obj
    end

    function ROCSparseMatrixDescriptor(A::ROCSparseMatrixCSC, IndexBase::Char; transposed::Bool=false)
        desc_ref = Ref{rocsparse_spmat_descr}()
        if transposed
            rocsparse_create_csr_descr(
                desc_ref, reverse(size(A))..., nnz(A),
                A.colPtr, rowvals(A), nonzeros(A),
                eltype(A.colPtr), eltype(rowvals(A)), IndexBase, eltype(nonzeros(A)))
        else
            rocsparse_create_csc_descr(
                desc_ref, size(A)..., nnz(A),
                A.colPtr, rowvals(A), nonzeros(A),
                eltype(A.colPtr), eltype(rowvals(A)), IndexBase, eltype(nonzeros(A)))
        end
        obj = new(desc_ref[])
        return finalizer(rocsparse_destroy_spmat_descr, obj)
    end

    function ROCSparseMatrixDescriptor(::Type{ROCSparseMatrixCSC}, colPtr::ROCVector, Tv::DataType, Ti::DataType, m::Integer, n::Integer, IndexBase::Char)
        desc_ref = Ref{rocsparse_spmat_descr}()
        rocsparse_create_csc_descr(desc_ref, m, n, Ti(0), colPtr, C_NULL, C_NULL, Ti, Ti, IndexBase, Tv)
        obj = new(desc_ref[])
        finalizer(rocsparse_destroy_spmat_descr, obj)
        return obj
    end
end

Base.unsafe_convert(::Type{rocsparse_spmat_descr}, desc::ROCSparseMatrixDescriptor) = desc.handle

## Stucture for IC(0) and ILU(0) preconditioners

mutable struct MatInfo
    info::rocsparse_mat_info

    function MatInfo()
        info_ref = Ref{rocsparse_mat_info}()
        rocsparse_create_mat_info(info_ref)
        obj = new(info_ref[])
        return finalizer(rocsparse_destroy_mat_info, obj)
    end
end

Base.unsafe_convert(::Type{rocsparse_mat_info}, info::MatInfo) = info.info
