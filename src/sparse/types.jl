# ROCSPARSE types

function Base.convert(::Type{rocsparse_datatype}, T::DataType)
    if T == Float32
        return rocsparse_datatype_f32_r
    elseif T == ComplexF32
        return rocsparse_datatype_f32_c
    elseif T == Float64
        return rocsparse_datatype_f64_r
    elseif T == ComplexF64
        return rocsparse_datatype_f64_c
    else
        throw(ArgumentError("ROCSPARSE type equivalent for data type $T does not exist!"))
    end
end

function Base.convert(::Type{rocsparse_double_complex}, x::ComplexF64)
    return rocsparse_double_complex(x.re, x.im)
end

function Base.convert(::Type{rocsparse_float_complex}, x::ComplexF32)
    return rocsparse_single_complex(x.re, x.im)
end

# rocsparse_float_complex and rocsparse_double_complex are defined as classes and their arrays need explicit conversion
function Base.unsafe_convert(::Type{Ptr{rocsparse_float_complex}}, x::Base.RefValue{ComplexF32})
    return Base.unsafe_convert(Ptr{rocsparse_float_complex}, Base.unsafe_convert(Ptr{ComplexF32}, x))
end

function Base.unsafe_convert(::Type{Ptr{rocsparse_double_complex}}, x::Base.RefValue{ComplexF64})
    return Base.unsafe_convert(Ptr{rocsparse_double_complex}, Base.unsafe_convert(Ptr{ComplexF64}, x))
end


## index type

function Base.convert(::Type{rocsparse_indextype}, T::DataType)
    if T == Int16
        return rocsparse_indextype_u16
    elseif T == Int32
        return rocsparse_indextype_i32
    elseif T == Int64
        return rocsparse_indextype_i64
    else
        throw(ArgumentError("ROCSPARSE type equivalent for index type $T does not exist!"))
    end
end

function Base.convert(::Type{Type}, T::rocsparse_indextype)
    if T == rocsparse_indextype_u16
        return Int16
    elseif T == rocsparse_indextype_i32
        return Int32
    elseif T == rocsparse_indextype_i64
        return Int64
    else
        throw(ArgumentError("Julia type equivalent for index type $T does not exist!"))
    end
end


## index base

function Base.convert(::Type{rocsparse_index_base}, base::Integer)
    if base == 0
        return rocsparse_index_base_zero
    elseif base == 1
        return rocsparse_index_base_one
    else
        throw(ArgumentError("ROCSPARSE does not support index base $base!"))
    end
end

function Base.convert(T::Type{<:Integer}, base::rocsparse_index_base)
    if base == rocsparse_index_base_zero
        return T(0)
    elseif base == rocsparse_index_base_one
        return T(1)
    else
        throw(ArgumentError("Unknown index base $base!"))
    end
end


## SparseChar conversions

function Base.convert(::Type{rocsparse_operation}, trans::SparseChar)
    if trans == 'N'
        rocsparse_operation_none
    elseif trans == 'T'
        rocsparse_operation_transpose
    elseif trans == 'C'
        rocsparse_operation_conjugate_transpose
    else
        throw(ArgumentError("Unknown operation $trans"))
    end
end

function Base.convert(::Type{rocsparse_matrix_type}, mattype::SparseChar)
    if mattype == 'G'
        rocsparse_matrix_type_general
    elseif mattype == 'T'
        rocsparse_matrix_type_triangular
    elseif mattype == 'S'
        rocsparse_matrix_type_symmetric
    elseif mattype == 'H'
        rocsparse_matrix_type_hermitian
    else
        throw(ArgumentError("Unknown matrix type $mattype"))
    end
end

function Base.convert(::Type{rocsparse_spmat_attribute}, attribute::SparseChar)
    if attribute == 'F'
        rocsparse_spmat_fill_mode
    elseif attribute == 'D'
        rocsparse_spmat_diag_type
    elseif attribute == 'M'
        rocsparse_spmat_matrix_type
    elseif attribute == 'S'
        rocsparse_spmat_storage_mode
    else
        throw(ArgumentError("Unknown attribute $attribute"))
    end
end

function Base.convert(::Type{rocsparse_fill_mode}, uplo::SparseChar)
    if uplo == 'U'
        rocsparse_fill_mode_upper
    elseif uplo == 'L'
        rocsparse_fill_mode_lower
    else
        throw(ArgumentError("Unknown fill mode $uplo"))
    end
end

function Base.convert(::Type{rocsparse_diag_type}, diag::SparseChar)
    if diag == 'U'
        rocsparse_diag_type_unit
    elseif diag == 'N'
        rocsparse_diag_type_non_unit
    else
        throw(ArgumentError("Unknown diag mode $diag"))
    end
end

function Base.convert(::Type{rocsparse_index_base}, index::SparseChar)
    if index == 'Z'
        rocsparse_index_base_zero
    elseif index == 'O'
        rocsparse_index_base_one
    else
        throw(ArgumentError("Unknown index base"))
    end
end

function Base.convert(::Type{rocsparse_direction}, dir::SparseChar)
    if dir == 'R'
        rocsparse_direction_row
    elseif dir == 'C'
        rocsparse_direction_column
    else
        throw(ArgumentError("Unknown direction $dir"))
    end
end

function Base.convert(::Type{rocsparse_order}, order::SparseChar)
    if order == 'R'
        rocsparse_order_row
    elseif order == 'C'
        rocsparse_order_column
    else
        throw(ArgumentError("Unknown order $order"))
    end
end
