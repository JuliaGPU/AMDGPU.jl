# interfacing with other packages

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

Base.:(+)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, one(eltype(A)), B, 'O')
Base.:(-)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, -one(eltype(A)), B, 'O')

Base.:(+)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T = A + Transpose(conj(B.parent))
Base.:(-)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T = A - Transpose(conj(B.parent))
Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T = Transpose(conj(A.parent)) + B
Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T = Transpose(conj(A.parent)) - B
Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T =
    Transpose(conj(A.parent)) + B
Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T =
    Transpose(conj(A.parent)) - B

function Base.:(+)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
    cscB = ROCSparseMatrixCSC(B.parent)
    transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
    return geam(one(T), A, one(T), transB, 'O')
end

function Base.:(-)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
    cscB = ROCSparseMatrixCSC(B.parent)
    transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
    return geam(one(T), A, -one(T), transB, 'O')
end

function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T
    cscA = ROCSparseMatrixCSC(A.parent)
    transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
    geam(one(T), transA, one(T), B, 'O')
end

function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T
    cscA = ROCSparseMatrixCSC(A.parent)
    transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
    geam(one(T), transA, -one(T), B, 'O')
end

function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
    C = geam(one(T), A.parent, one(T), B.parent, 'O')
    cscC = ROCSparseMatrixCSC(C)
    return ROCSparseMatrixCSR(cscC.colPtr, cscC.rowVal, cscC.nzVal, size(cscC))
end

function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
    C = geam(one(T), A.parent, -one(T), B.parent, 'O')
    cscC = ROCSparseMatrixCSC(C)
    return ROCSparseMatrixCSR(cscC.colPtr, cscC.rowVal, cscC.nzVal, size(cscC))
end

function Base.:(+)(A::ROCSparseMatrixCSR, B::ROCSparseMatrix)
    csrB = ROCSparseMatrixCSR(B)
    return geam(one(eltype(A)), A, one(eltype(A)), csrB, 'O')
end

function Base.:(-)(A::ROCSparseMatrixCSR, B::ROCSparseMatrix)
    csrB = ROCSparseMatrixCSR(B)
    return geam(one(eltype(A)), A, -one(eltype(A)), csrB, 'O')
end

function Base.:(+)(A::ROCSparseMatrix, B::ROCSparseMatrixCSR)
    csrA = ROCSparseMatrixCSR(A)
    return geam(one(eltype(A)), csrA, one(eltype(A)), B, 'O')
end

function Base.:(-)(A::ROCSparseMatrix, B::ROCSparseMatrixCSR)
    csrA = ROCSparseMatrixCSR(A)
    return geam(one(eltype(A)), csrA, -one(eltype(A)), B, 'O')
end

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

# these operations materialize the identity matrix and re-use broadcast
# TODO: can we do without this, and just use the broadcast implementation
#       with a singleton argument it knows how to index?

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

# TODO COO

Base.:(+)(A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}, J::UniformScaling) =
    A .+ _sparse_identity(typeof(A), J, size(A))

Base.:(-)(J::UniformScaling, A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}) =
    _sparse_identity(typeof(A), J, size(A)) .- A

# TODO: let Broadcast handle this automatically (a la SparseArrays.PromoteToSparse)
for SparseMatrixType in [:ROCSparseMatrixCSC, :ROCSparseMatrixCSR], op in [:(+), :(-)]
    @eval begin
        function Base.$op(lhs::Diagonal{T,<:ROCArray}, rhs::$SparseMatrixType{T}) where T
            return $op($SparseMatrixType(lhs), rhs)
        end
        function Base.$op(lhs::$SparseMatrixType{T}, rhs::Diagonal{T,<:ROCArray}) where T
            return $op(lhs, $SparseMatrixType(rhs))
        end
    end
end
