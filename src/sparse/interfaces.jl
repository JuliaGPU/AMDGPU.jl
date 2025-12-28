# interfacing with other packages

function _spadjoint(A::ROCSparseMatrixCSR)
    Aᴴ = ROCSparseMatrixCSC(A.rowPtr, A.colVal, conj(A.nzVal), reverse(size(A)))
    ROCSparseMatrixCSR(Aᴴ)
end
function _sptranspose(A::ROCSparseMatrixCSR)
    Aᵀ = ROCSparseMatrixCSC(A.rowPtr, A.colVal, A.nzVal, reverse(size(A)))
    ROCSparseMatrixCSR(Aᵀ)
end
function _spadjoint(A::ROCSparseMatrixCSC)
    Aᴴ = ROCSparseMatrixCSR(A.colPtr, A.rowVal, conj(A.nzVal), reverse(size(A)))
    ROCSparseMatrixCSC(Aᴴ)
end
function _sptranspose(A::ROCSparseMatrixCSC)
    Aᵀ = ROCSparseMatrixCSR(A.colPtr, A.rowVal, A.nzVal, reverse(size(A)))
    ROCSparseMatrixCSC(Aᵀ)
end
function _spadjoint(A::ROCSparseMatrixCOO)
    # we use sparse instead of ROCSparseMatrixCOO because we want to sort the matrix.
    sparse(A.colInd, A.rowInd, conj(A.nzVal), reverse(size(A))..., fmt = :coo)
end
function _sptranspose(A::ROCSparseMatrixCOO)
    # we use sparse instead of ROCSparseMatrixCOO because we want to sort the matrix.
    sparse(A.colInd, A.rowInd, A.nzVal, reverse(size(A))..., fmt = :coo)
end

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

adjtrans_wrappers = ((identity, identity),
                     (M -> :(Transpose{T, <:$M}), M -> :(_sptranspose(parent($M)))),
                     (M -> :(Adjoint{T, <:$M}), M -> :(_spadjoint(parent($M)))))

op_wrappers = ((identity, T -> 'N', identity),
               (T -> :(Transpose{T, <:$T}), T -> 'T', A -> :(parent($A))),
               (T -> :(Adjoint{T, <:$T}), T -> T <: Real ? 'T' : 'C', A -> :(parent($A))),
               (T -> :(HermOrSym{T, <:$T}), T -> 'N', A -> :(parent($A))))

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

for (wrapa, transa, unwrapa) in op_wrappers
    TypeA = wrapa(:(ROCSparseMatrix{T}))

    @eval function LinearAlgebra.:(*)(A::$TypeA, x::ROCSparseVector{T}) where {T <: Union{Float16, ComplexF16, BlasFloat}}
        m, n = size(A)
        length(x) == n || throw(DimensionMismatch())
        y = ROCVector{T}(undef, m)
        mul!(y, A, x, true, false)
    end
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

for (wrapa, transa, unwrapa) in op_wrappers
    TypeA = wrapa(:(DenseROCMatrix{T}))

    @eval function Base.:(*)(A::$TypeA, x::ROCSparseVector{T}) where {T <: BlasFloat}
        m, n = size(A)
        length(x) == n || throw(DimensionMismatch())
        y = ROCVector{T}(undef, m)
        mul!(y, A, x, true, false)
    end

    for (wrapb, transb, unwrapb) in op_wrappers
        for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}), :(ROCSparseMatrixCOO{T}))
            TypeB = wrapb(SparseMatrixType)

            @eval function Base.:(*)(A::$TypeA, B::$TypeB) where {T <: Union{Float16, ComplexF16, BlasFloat}}
                m, n = size(A)
                k, p = size(B)
                n == k || throw(DimensionMismatch())
                C = ROCMatrix{T}(undef, m, p)
                mul!(C, A, B, true, false)
            end
        end
    end
end

# legacy methods with final MulAddMul argument
LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCSC{T}, tA, tB, A::ROCSparseMatrixCSC{T}, B::ROCSparseMatrixCSC{T}, _add::MulAddMul) where {T <: BlasFloat} =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCSR{T}, tA, tB, A::ROCSparseMatrixCSR{T}, B::ROCSparseMatrixCSR{T}, _add::MulAddMul) where {T <: BlasFloat} =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)
LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCOO{T}, tA, tB, A::ROCSparseMatrixCOO{T}, B::ROCSparseMatrixCOO{T}, _add::MulAddMul) where {T <: BlasFloat} =
    LinearAlgebra.generic_matmatmul!(C, tA, tB, A, B, _add.alpha, _add.beta)

function LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCSC{T}, tA, tB, A::ROCSparseMatrixCSC{T}, B::ROCSparseMatrixCSC{T}, alpha::Number, beta::Number) where {T <: BlasFloat}
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    gemm!(tA, tB, alpha, A, B, beta, C, 'O')
end
function LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCSR{T}, tA, tB, A::ROCSparseMatrixCSR{T}, B::ROCSparseMatrixCSR{T}, alpha::Number, beta::Number) where {T <: BlasFloat}
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    gemm!(tA, tB, alpha, A, B, beta, C, 'O')
end
function LinearAlgebra.generic_matmatmul!(C::ROCSparseMatrixCOO{T}, tA, tB, A::ROCSparseMatrixCOO{T}, B::ROCSparseMatrixCOO{T}, alpha::Number, beta::Number) where {T <: BlasFloat}
    tA = tA in ('S', 's', 'H', 'h') ? 'N' : tA
    tB = tB in ('S', 's', 'H', 'h') ? 'N' : tB
    A_csr = ROCSparseMatrixCSR(A)
    B_csr = ROCSparseMatrixCSR(B)
    C_csr = ROCSparseMatrixCSR(C)
    LinearAlgebra.generic_matmatmul!(C_csr, tA, tB, A_csr, B_csr, alpha, beta)
    copyto!(C, ROCSparseMatrixCOO(C_csr))
    return C
end

for SparseMatrixType in (:ROCSparseMatrixCSC, :ROCSparseMatrixCSR)
    @eval function LinearAlgebra.:(*)(A::$SparseMatrixType{T}, B::$SparseMatrixType{T}) where {T <: BlasFloat}
        gemm('N', 'N', one(T), A, B, 'O')
    end
end

function LinearAlgebra.:(*)(A::ROCSparseMatrixCOO{T}, B::ROCSparseMatrixCOO{T}) where {T <: BlasFloat}
    A_csr = ROCSparseMatrixCSR(A)
    B_csr = ROCSparseMatrixCSR(B)
    ROCSparseMatrixCOO(A_csr * B_csr)
end

for (wrapa, unwrapa) in adjtrans_wrappers, (wrapb, unwrapb) in adjtrans_wrappers
    for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}), :(ROCSparseMatrixCOO{T}))
        TypeA = wrapa(SparseMatrixType)
        TypeB = wrapb(SparseMatrixType)
        wrapa == identity && wrapb == identity && continue
        @eval Base.:(*)(A::$TypeA, B::$TypeB) where {T <: BlasFloat} = $(unwrapa(:A)) * $(unwrapb(:B))
    end
end

for op in (:(+), :(-))
    for (wrapa, unwrapa) in adjtrans_wrappers, (wrapb, unwrapb) in adjtrans_wrappers
        for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}))
            TypeA = wrapa(SparseMatrixType)
            TypeB = wrapb(SparseMatrixType)
            @eval Base.$op(A::$TypeA, B::$TypeB) where {T <: BlasFloat} = geam(one(T), $(unwrapa(:A)), $(op)(one(T)), $(unwrapb(:B)), 'O')
        end
    end

    @eval begin
        Base.$op(A::ROCSparseVector{T}, B::ROCSparseVector{T}) where {T <: BlasFloat} = axpby(one(T), A, $(op)(one(T)), B, 'O')
        Base.$op(A::Union{ROCSparseMatrixCOO{T}, Transpose{T,<:ROCSparseMatrixCOO}, Adjoint{T,<:ROCSparseMatrixCOO}},
                 B::Union{ROCSparseMatrixCOO{T}, Transpose{T,<:ROCSparseMatrixCOO}, Adjoint{T,<:ROCSparseMatrixCOO}}) where {T <: BlasFloat} =
            ROCSparseMatrixCOO($(op)(ROCSparseMatrixCSR(A), ROCSparseMatrixCSR(B)))
    end
end

# Base.:(+)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, one(eltype(A)), B, 'O')
# Base.:(-)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, -one(eltype(A)), B, 'O')

# Base.:(+)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T = A + Transpose(conj(B.parent))
# Base.:(-)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T = A - Transpose(conj(B.parent))
# Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T = Transpose(conj(A.parent)) + B
# Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T = Transpose(conj(A.parent)) - B
# Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T =
#     Transpose(conj(A.parent)) + B
# Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where T =
#     Transpose(conj(A.parent)) - B

# function Base.:(+)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
#     cscB = ROCSparseMatrixCSC(B.parent)
#     transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
#     return geam(one(T), A, one(T), transB, 'O')
# end

# function Base.:(-)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
#     cscB = ROCSparseMatrixCSC(B.parent)
#     transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
#     return geam(one(T), A, -one(T), transB, 'O')
# end

# function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T
#     cscA = ROCSparseMatrixCSC(A.parent)
#     transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
#     geam(one(T), transA, one(T), B, 'O')
# end

# function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where T
#     cscA = ROCSparseMatrixCSC(A.parent)
#     transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
#     geam(one(T), transA, -one(T), B, 'O')
# end

# function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
#     C = geam(one(T), A.parent, one(T), B.parent, 'O')
#     cscC = ROCSparseMatrixCSC(C)
#     return ROCSparseMatrixCSR(cscC.colPtr, cscC.rowVal, cscC.nzVal, size(cscC))
# end

# function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where T
#     C = geam(one(T), A.parent, -one(T), B.parent, 'O')
#     cscC = ROCSparseMatrixCSC(C)
#     return ROCSparseMatrixCSR(cscC.colPtr, cscC.rowVal, cscC.nzVal, size(cscC))
# end

# function Base.:(+)(A::ROCSparseMatrixCSR, B::ROCSparseMatrix)
#     csrB = ROCSparseMatrixCSR(B)
#     return geam(one(eltype(A)), A, one(eltype(A)), csrB, 'O')
# end

# function Base.:(-)(A::ROCSparseMatrixCSR, B::ROCSparseMatrix)
#     csrB = ROCSparseMatrixCSR(B)
#     return geam(one(eltype(A)), A, -one(eltype(A)), csrB, 'O')
# end

# function Base.:(+)(A::ROCSparseMatrix, B::ROCSparseMatrixCSR)
#     csrA = ROCSparseMatrixCSR(A)
#     return geam(one(eltype(A)), csrA, one(eltype(A)), B, 'O')
# end

# function Base.:(-)(A::ROCSparseMatrix, B::ROCSparseMatrixCSR)
#     csrA = ROCSparseMatrixCSR(A)
#     return geam(one(eltype(A)), csrA, -one(eltype(A)), B, 'O')
# end

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

function _sparse_identity(
    ::Type{<:ROCSparseMatrixCOO{Tv,Ti}}, I::UniformScaling, dims::Dims
) where {Tv,Ti}
    len = min(dims[1], dims[2])
    rowInd = ROCVector{Ti}(1:len)
    colInd = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCOO{Tv,Ti}(rowInd, colInd, nzVal, dims)
end

# Base.:(+)(A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}, J::UniformScaling) =
#     A .+ _sparse_identity(typeof(A), J, size(A))

# Base.:(-)(J::UniformScaling, A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}) =
#     _sparse_identity(typeof(A), J, size(A)) .- A

for (wrapa, unwrapa) in adjtrans_wrappers
    for SparseMatrixType in (:(ROCSparseMatrixCSC{T}), :(ROCSparseMatrixCSR{T}), :(ROCSparseMatrixCOO{T}))
        TypeA = wrapa(SparseMatrixType)
        @eval begin
            Base.:(+)(A::$TypeA, J::UniformScaling) where {T} = $(unwrapa(:A)) + _sparse_identity(typeof(A), J, size(A))
            Base.:(+)(J::UniformScaling, A::$TypeA) where {T} = _sparse_identity(typeof(A), J, size(A)) + $(unwrapa(:A))

            Base.:(-)(A::$TypeA, J::UniformScaling) where {T} = $(unwrapa(:A)) - _sparse_identity(typeof(A), J, size(A))
            Base.:(-)(J::UniformScaling, A::$TypeA) where {T} = _sparse_identity(typeof(A), J, size(A)) - $(unwrapa(:A))
        end

        # Broadcasting is not yet supported for COO matrices
        if SparseMatrixType != :(ROCSparseMatrixCOO{T})
            @eval begin
                Base.:(*)(A::$TypeA, J::UniformScaling) where {T} = $(unwrapa(:A)) * J.λ
                Base.:(*)(J::UniformScaling, A::$TypeA) where {T} = J.λ * $(unwrapa(:A))
            end
        else
            @eval begin
                Base.:(*)(A::$TypeA, J::UniformScaling) where {T} = $(unwrapa(:A)) * _sparse_identity(typeof(A), J, size(A))
                Base.:(*)(J::UniformScaling, A::$TypeA) where {T} = _sparse_identity(typeof(A), J, size(A)) * $(unwrapa(:A))
            end
        end
    end
end

# TODO: let Broadcast handle this automatically (a la SparseArrays.PromoteToSparse)
for (wrapa, unwrapa) in adjtrans_wrappers, op in (:(+), :(-), :(*))
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

# # TODO: let Broadcast handle this automatically (a la SparseArrays.PromoteToSparse)
# for SparseMatrixType in [:ROCSparseMatrixCSC, :ROCSparseMatrixCSR, :ROCSparseMatrixCOO], op in [:(+), :(-)]
#     @eval begin
#         function Base.$op(lhs::Diagonal{T,<:ROCArray}, rhs::$SparseMatrixType{T}) where T
#             return $op($SparseMatrixType(lhs), rhs)
#         end
#         function Base.$op(lhs::$SparseMatrixType{T}, rhs::Diagonal{T,<:ROCArray}) where T
#             return $op(lhs, $SparseMatrixType(rhs))
#         end
#     end
# end

# TODO _sptranspose / _spadjoint
