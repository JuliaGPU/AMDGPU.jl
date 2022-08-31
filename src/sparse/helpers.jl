# rocSPARSE helper functions


## matrix descriptor

mutable struct ROCMatrixDescriptor
    handle::rocsparse_mat_descr

    function ROCMatrixDescriptor()
        descr_ref = Ref{rocsparse_mat_descr}()
        rocsparse_create_mat_descr(descr_ref)
        obj = new(descr_ref[])
        finalizer(rocsparse_destroy_mat_descr, obj)
        obj
    end
end

Base.unsafe_convert(::Type{rocsparse_mat_descr}, desc::ROCMatrixDescriptor) = desc.handle

function ROCMatrixDescriptor(MatrixType::Char, FillMode::Char, DiagType::Char, IndexBase::Char)
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
