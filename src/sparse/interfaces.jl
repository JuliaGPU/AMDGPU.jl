# interfacing with other packages

# Materialize transpose/adjoint of a sparse ROC matrix.
function GPUArrays._sptranspose(A::ROCSparseMatrixCSR)
    ROCSparseMatrixCSR(ROCSparseMatrixCSC(A.rowPtr, A.colVal, A.nzVal, reverse(size(A))))
end
function GPUArrays._spadjoint(A::ROCSparseMatrixCSR)
    ROCSparseMatrixCSR(ROCSparseMatrixCSC(A.rowPtr, A.colVal, conj(A.nzVal), reverse(size(A))))
end

function GPUArrays._sptranspose(A::ROCSparseMatrixCSC)
    ROCSparseMatrixCSC(ROCSparseMatrixCSR(A.colPtr, A.rowVal, A.nzVal, reverse(size(A))))
end
function GPUArrays._spadjoint(A::ROCSparseMatrixCSC)
    ROCSparseMatrixCSC(ROCSparseMatrixCSR(A.colPtr, A.rowVal, conj(A.nzVal), reverse(size(A))))
end

function GPUArrays._sptranspose(A::ROCSparseMatrixCOO)
    # swap row/col indices and re-sort so the result is sorted by row
    sparse(A.colInd, A.rowInd, A.nzVal, reverse(size(A))..., fmt=:coo)
end
function GPUArrays._spadjoint(A::ROCSparseMatrixCOO)
    sparse(A.colInd, A.rowInd, conj(A.nzVal), reverse(size(A))..., fmt=:coo)
end

# (type_wrapper, value_unwrapper) pairs for generating methods over plain, transposed, and adjoint arguments.
const adjtrans_wrappers = (
    (identity,                   identity),
    (M -> :(Transpose{T, <:$M}), M -> :(_sptranspose(parent($M)))),
    (M -> :(Adjoint{T, <:$M}),   M -> :(_spadjoint(parent($M)))),
)

function mv_wrapper(
    transa::SparseChar, alpha::Number, A::ROCSparseMatrix, X::DenseROCVector{T},
    beta::Number, Y::ROCVector{T},
) where T
    mv!(transa, alpha, A, X, beta, Y, 'O')
end

function mm_wrapper(
    transa::SparseChar, transb::SparseChar, alpha::Number,
    A::ROCSparseMatrix{T}, B::ROCMatrix{T}, beta::Number, C::ROCMatrix{T},
) where T
    n_A, m_A = (transa != 'N') ? reverse(size(A)) : size(A)
    n_B, m_B = (transb != 'N') ? reverse(size(B)) : size(B)
    n_C, m_C = size(C)
    m_A == n_B || throw(DimensionMismatch())
    n_A == n_C || throw(DimensionMismatch())
    m_B == m_C || throw(DimensionMismatch())
    isempty(B) && return AMDGPU.zeros(eltype(B), size(A, 1), 0)

    mm!(transa, transb, alpha, A, B, beta, C, 'O')
end

LinearAlgebra.dot(x::ROCSparseVector{T}, y::DenseROCVector{T}) where {T <: BlasReal} = vv!('N', x, y, 'O')
LinearAlgebra.dot(x::DenseROCVector{T}, y::ROCSparseVector{T}) where {T <: BlasReal} = dot(y, x)

LinearAlgebra.dot(x::ROCSparseVector{T}, y::DenseROCVector{T}) where {T <: BlasComplex} = vv!('C', x, y, 'O')
LinearAlgebra.dot(x::DenseROCVector{T}, y::ROCSparseVector{T}) where {T <: BlasComplex} = conj(dot(y,x))

# legacy methods with final MulAddMul argument
LinearAlgebra.generic_matvecmul!(C::ROCVector{T}, tA::AbstractChar, A::ROCSparseMatrix{T}, B::DenseROCVector{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matvecmul!(C, tA, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matvecmul!(C::ROCVector{T}, tA::AbstractChar, A::ROCSparseMatrix{T}, B::ROCSparseVector{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matvecmul!(C, tA, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::ROCSparseMatrix{T}, B::DenseROCMatrix{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)

function LinearAlgebra.generic_matvecmul!(C::ROCVector{T}, tA::AbstractChar, A::ROCSparseMatrix{T}, B::DenseROCVector{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    mv_wrapper(tA, alpha, A, B, beta, C)
end

function LinearAlgebra.generic_matvecmul!(C::ROCVector{T}, tA::AbstractChar, A::ROCSparseMatrix{T}, B::ROCSparseVector{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    mv_wrapper(tA, alpha, A, ROCVector{T}(B), beta, C)
end

function LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::ROCSparseMatrix{T}, B::DenseROCMatrix{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    mm_wrapper(tA, tB, alpha, A, B, beta, C)
end

# legacy methods with final MulAddMul argument
LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCSC{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCSR{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCOO{T}, _add::MulAddMul) where T <: BlasFloat =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)

function LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCSC{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    mm!(tA, tB, alpha, A, B, beta, C, 'O')
end
function LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCSR{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    mm!(tA, tB, alpha, A, B, beta, C, 'O')
end
function LinearAlgebra.generic_matmatmul!(C::ROCMatrix{T}, tA, tB, A::DenseROCMatrix{T}, B::ROCSparseMatrixCOO{T}, alpha::Number, beta::Number) where T <: BlasFloat
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    mm!(tA, tB, alpha, A, B, beta, C, 'O')
end

# +/- for all combinations of plain/transposed/adjoint CSR and CSC, generated via adjtrans_wrappers.
for op in (:(+), :(-))
    for (wrapa, unwrapa) in adjtrans_wrappers, (wrapb, unwrapb) in adjtrans_wrappers
        for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}))
            TypeA = wrapa(SparseMatrixType)
            TypeB = wrapb(SparseMatrixType)
            @eval Base.$op(A::$TypeA, B::$TypeB) where {T <: BlasFloat} =
                geam(one(T), $(unwrapa(:A)), $(op)(one(T)), $(unwrapb(:B)), 'O')
        end
    end
    # COO: materialise both sides as CSR, run geam, convert back
    @eval Base.$op(
        A::Union{ROCSparseMatrixCOO{T}, Transpose{T,<:ROCSparseMatrixCOO}, Adjoint{T,<:ROCSparseMatrixCOO}},
        B::Union{ROCSparseMatrixCOO{T}, Transpose{T,<:ROCSparseMatrixCOO}, Adjoint{T,<:ROCSparseMatrixCOO}},
    ) where {T <: BlasFloat} =
        ROCSparseMatrixCOO(Base.$op(ROCSparseMatrixCSR(A), ROCSparseMatrixCSR(B)))
end

# Cross-format +/- for CSR/CSC/BSR mixtures: normalise both operands to CSR, then geam
for op in (:(+), :(-))
    @eval begin
        Base.$op(A::ROCSparseMatrixCSR{T}, B::ROCSparseMatrixCSC{T}) where {T <: BlasFloat} =
            geam(one(T), A, $(op)(one(T)), ROCSparseMatrixCSR(B), 'O')
        Base.$op(A::ROCSparseMatrixCSC{T}, B::ROCSparseMatrixCSR{T}) where {T <: BlasFloat} =
            geam(one(T), ROCSparseMatrixCSR(A), $(op)(one(T)), B, 'O')
        Base.$op(A::ROCSparseMatrixCSR{T}, B::ROCSparseMatrixBSR{T}) where {T <: BlasFloat} =
            geam(one(T), A, $(op)(one(T)), ROCSparseMatrixCSR(B), 'O')
        Base.$op(A::ROCSparseMatrixBSR{T}, B::ROCSparseMatrixCSR{T}) where {T <: BlasFloat} =
            geam(one(T), ROCSparseMatrixCSR(A), $(op)(one(T)), B, 'O')
    end
end

# vector +/-
Base.:(+)(A::ROCSparseVector{T}, B::ROCSparseVector{T}) where {T <: BlasFloat} = axpby(one(T), A, one(T), B, 'O')
Base.:(-)(A::ROCSparseVector{T}, B::ROCSparseVector{T}) where {T <: BlasFloat} = axpby(one(T), A, -one(T), B, 'O')

# triangular

for SparseMatrixType in (:ROCSparseMatrixBSR,)
    @eval begin
        LinearAlgebra.generic_trimatdiv!(C::DenseROCVector{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::DenseROCVector{T}) where T <: BlasFloat =
            sv2!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', uploc, isunitc, one(T), A, C === B ? C : copyto!(C, B), 'O')

        LinearAlgebra.generic_trimatdiv!(C::DenseROCMatrix{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::DenseROCMatrix{T}) where T <: BlasFloat =
            sm2!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'N', uploc, isunitc, one(T), A, C === B ? C : copyto!(C, B), 'O')

        function LinearAlgebra.generic_trimatdiv!(C::DenseROCMatrix{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::AdjOrTrans{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            transb = LinearAlgebra.wrapper_char(B)
            C !== parent(B) && copyto!(C, B)
            sm2!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'N', uploc, isunitc, one(T), A, C, 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::Transpose{T,<:DenseROCMatrix{T}}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::Transpose{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            B === C || throw(ErrorException("This operation is only supported if B and C are identical."))
            sm2!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'T', uploc, isunitc, one(T), A, parent(B), 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::Adjoint{T,<:DenseROCMatrix{T}}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::Adjoint{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            B === C || throw(ErrorException("This operation is only supported if B and C are identical."))
            sm2!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'C', uploc, isunitc, one(T), A, parent(B), 'O')
        end
    end
end # SparseMatrixType loop

for SparseMatrixType in (:ROCSparseMatrixCOO, :ROCSparseMatrixCSR, :ROCSparseMatrixCSC)
    @eval begin
        function LinearAlgebra.generic_trimatdiv!(C::DenseROCVector{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::DenseROCVector{T}) where T <: BlasFloat
            sv!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', uploc, isunitc, one(T), A, B, C, 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::DenseROCMatrix{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::DenseROCMatrix{T}) where T <: BlasFloat
            sm!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'N', uploc, isunitc, one(T), A, B, C, 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::DenseROCMatrix{T}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::AdjOrTrans{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            transb = LinearAlgebra.wrapper_char(B)
            sm!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', transb, uploc, isunitc, one(T), A, parent(B), C, 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::Transpose{T,<:DenseROCMatrix{T}}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::Transpose{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            sm!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'T', uploc, isunitc, one(T), A, parent(B), parent(C), 'O')
        end

        function LinearAlgebra.generic_trimatdiv!(C::Adjoint{T,<:DenseROCMatrix{T}}, uploc, isunitc, tfun::Function, A::$SparseMatrixType{T}, B::Adjoint{T,<:DenseROCMatrix{T}}) where T <: BlasFloat
            sm!(tfun === identity ? 'N' : tfun === transpose ? 'T' : 'C', 'C', uploc, isunitc, one(T), A, parent(B), parent(C), 'O')
        end
    end
end

## uniform scaling

# TODO: use a broadcast singleton for I instead of materialising the full sparse identity.
function _sparse_identity(
    ::Type{<:ROCSparseMatrixCSR{<:Any,Ti}}, I::UniformScaling{Tv}, dims::Dims,
) where {Tv, Ti}
    len = min(dims[1], dims[2])
    rowPtr = ROCVector{Ti}(vcat(1:len, fill(len+1, dims[1]-len+1)))
    colVal = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCSR{Tv,Ti}(rowPtr, colVal, nzVal, dims)
end

function _sparse_identity(
    ::Type{<:ROCSparseMatrixCSC{<:Any,Ti}}, I::UniformScaling{Tv}, dims::Dims,
) where {Tv, Ti}
    len = min(dims[1], dims[2])
    colPtr = ROCVector{Ti}(vcat(1:len, fill(len+1, dims[2]-len+1)))
    rowVal = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCSC{Tv,Ti}(colPtr, rowVal, nzVal, dims)
end

function _sparse_identity(
    ::Type{<:ROCSparseMatrixCOO{<:Any,Ti}}, I::UniformScaling{Tv}, dims::Dims,
) where {Tv, Ti}
    len = min(dims[1], dims[2])
    rowInd = ROCVector{Ti}(1:len)
    colInd = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCOO{Tv,Ti}(rowInd, colInd, nzVal, dims)
end

# Scale all nzVals of a COO matrix by scalar λ.
_coo_scale(A::ROCSparseMatrixCOO{T}, λ) where {T} =
    ROCSparseMatrixCOO(A.rowInd, A.colInd, A.nzVal .* λ, size(A), nnz(A))

# UniformScaling +/-/* for all formats/wrappers; typeof(A′) passes a concrete type to _sparse_identity
# (SparseMatrixType is a UnionAll with Ti unbound at runtime and won't match its signatures).
for (wrapa, unwrapa) in adjtrans_wrappers
    for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}), :(ROCSparseMatrixCOO{T}))
        TypeA = wrapa(SparseMatrixType)
        if SparseMatrixType != :(ROCSparseMatrixCOO{T})
            # CSR/CSC: identity is the same format; broadcasting works for .*
            @eval begin
                Base.:(+)(A::$TypeA, J::UniformScaling) where {T} =
                    let A′ = $(unwrapa(:A)); A′ + _sparse_identity(typeof(A′), J, size(A)) end
                Base.:(+)(J::UniformScaling, A::$TypeA) where {T} =
                    let A′ = $(unwrapa(:A)); _sparse_identity(typeof(A′), J, size(A)) + A′ end
                Base.:(-)(A::$TypeA, J::UniformScaling) where {T} =
                    let A′ = $(unwrapa(:A)); A′ - _sparse_identity(typeof(A′), J, size(A)) end
                Base.:(-)(J::UniformScaling, A::$TypeA) where {T} =
                    let A′ = $(unwrapa(:A)); _sparse_identity(typeof(A′), J, size(A)) - A′ end
                Base.:(*)(A::$TypeA, J::UniformScaling) where {T} = $(unwrapa(:A)) .* J.λ
                Base.:(*)(J::UniformScaling, A::$TypeA) where {T} = J.λ .* $(unwrapa(:A))
            end
        else
            # COO: broadcast not supported → route +/- through CSR, scale nzVal for *
            @eval begin
                Base.:(+)(A::$TypeA, J::UniformScaling) where {T} =
                    let A′ = $(unwrapa(:A)); csr = ROCSparseMatrixCSR(A′)
                        ROCSparseMatrixCOO(csr + _sparse_identity(typeof(csr), J, size(A))) end
                Base.:(+)(J::UniformScaling, A::$TypeA) where {T} =
                    let A′ = $(unwrapa(:A)); csr = ROCSparseMatrixCSR(A′)
                        ROCSparseMatrixCOO(_sparse_identity(typeof(csr), J, size(A)) + csr) end
                Base.:(-)(A::$TypeA, J::UniformScaling) where {T} =
                    let A′ = $(unwrapa(:A)); csr = ROCSparseMatrixCSR(A′)
                        ROCSparseMatrixCOO(csr - _sparse_identity(typeof(csr), J, size(A))) end
                Base.:(-)(J::UniformScaling, A::$TypeA) where {T} =
                    let A′ = $(unwrapa(:A)); csr = ROCSparseMatrixCSR(A′)
                        ROCSparseMatrixCOO(_sparse_identity(typeof(csr), J, size(A)) - csr) end
                Base.:(*)(A::$TypeA, J::UniformScaling) where {T} = _coo_scale($(unwrapa(:A)), J.λ)
                Base.:(*)(J::UniformScaling, A::$TypeA) where {T} = _coo_scale($(unwrapa(:A)), J.λ)
            end
        end
    end
end

# TODO: let Broadcast handle this automatically (a la SparseArrays.PromoteToSparse)
# +/- with Diagonal: convert it to the same sparse format, then geam.
for (wrapa, unwrapa) in adjtrans_wrappers, op in (:(+), :(-))
    for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}), :(ROCSparseMatrixCOO{T}))
        TypeA = wrapa(SparseMatrixType)
        @eval begin
            function Base.$op(lhs::Diagonal, rhs::$TypeA) where {T}
                return $op($SparseMatrixType(lhs), $(unwrapa(:rhs)))
            end
            function Base.$op(lhs::$TypeA, rhs::Diagonal) where {T}
                return $op($(unwrapa(:lhs)), $SparseMatrixType(rhs))
            end
        end
    end
end

# * with Diagonal for CSR/CSC: convert to COO, scale nzVal by d[colInd] or d[rowInd], convert back.
for (wrapa, unwrapa) in adjtrans_wrappers
    for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}))
        FmtCtor = SparseMatrixType == :(ROCSparseMatrixCSR{T}) ? :ROCSparseMatrixCSR : :ROCSparseMatrixCSC
        TypeA = wrapa(SparseMatrixType)
        @eval begin
            function Base.:(*)(lhs::$TypeA, rhs::Diagonal) where {T}
                A = $(unwrapa(:lhs))
                d = rhs isa Diagonal{<:Any, <:ROCArray} ? T.(rhs.diag) : ROCArray(T.(rhs.diag))
                coo = ROCSparseMatrixCOO(A)
                $FmtCtor(ROCSparseMatrixCOO(coo.rowInd, coo.colInd, coo.nzVal .* d[coo.colInd], size(coo), nnz(coo)))
            end
            function Base.:(*)(lhs::Diagonal, rhs::$TypeA) where {T}
                A = $(unwrapa(:rhs))
                d = lhs isa Diagonal{<:Any, <:ROCArray} ? T.(lhs.diag) : ROCArray(T.(lhs.diag))
                coo = ROCSparseMatrixCOO(A)
                $FmtCtor(ROCSparseMatrixCOO(coo.rowInd, coo.colInd, d[coo.rowInd] .* coo.nzVal, size(coo), nnz(coo)))
            end
        end
    end
end

# * with Diagonal for COO: scale nzVal by d[colInd] or d[rowInd].
for (wrapa, unwrapa) in adjtrans_wrappers
    TypeA = wrapa(:(ROCSparseMatrixCOO{T}))
    @eval begin
        function Base.:(*)(lhs::$TypeA, rhs::Diagonal) where {T}
            A = $(unwrapa(:lhs))
            d = rhs isa Diagonal{<:Any, <:ROCArray} ? T.(rhs.diag) : ROCArray(T.(rhs.diag))
            ROCSparseMatrixCOO(A.rowInd, A.colInd, A.nzVal .* d[A.colInd], size(A), nnz(A))
        end
        function Base.:(*)(lhs::Diagonal, rhs::$TypeA) where {T}
            A = $(unwrapa(:rhs))
            d = lhs isa Diagonal{<:Any, <:ROCArray} ? T.(lhs.diag) : ROCArray(T.(lhs.diag))
            ROCSparseMatrixCOO(A.rowInd, A.colInd, d[A.rowInd] .* A.nzVal, size(A), nnz(A))
        end
    end
end
