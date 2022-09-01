# interfacing with other packages

using LinearAlgebra
using LinearAlgebra: BlasComplex, BlasFloat, BlasReal

function mv_wrapper(transa::SparseChar, alpha::Number, A::ROCSparseMatrix, X::DenseROCVector{T},
                    beta::Number, Y::ROCVector{T}) where {T}
    mv!(transa, alpha, A, X, beta, Y, 'O')
end

function mm_wrapper(transa::SparseChar, transb::SparseChar, alpha::Number,
                    A::ROCSparseMatrix{T}, B::ROCMatrix{T}, beta::Number, C::ROCMatrix{T}) where {T}
    n_A, m_A = (transa != 'N') ? reverse(size(A)) : size(A)
    n_B, m_B = (transb != 'N') ? reverse(size(B)) : size(B)
    n_C, m_C = size(C)
    m_A == n_B || throw(DimensionMismatch())
    n_A == n_C || throw(DimensionMismatch())
    m_B == m_C || throw(DimensionMismatch())
    isempty(B) && return AMDGPU.zeros(eltype(B), size(A, 1), 0)

    mm!(transa, transb, alpha, A, B, beta, C, 'O')
end

tag_wrappers = ((identity, identity),
                (T -> :(HermOrSym{T, <:$T}), A -> :(parent($A))))
op_wrappers = (
    (identity, T -> 'N', identity),
    (T -> :(Transpose{<:T, <:$T}), T -> 'T', A -> :(parent($A))),
    (T -> :(Adjoint{<:T, <:$T}), T -> T <: Real ? 'T' : 'C', A -> :(parent($A)))
)
for (taga, untaga) in tag_wrappers, (wrapa, transa, unwrapa) in op_wrappers
    TypeA = wrapa(taga(:(ROCSparseMatrix{T})))

    @eval begin
        function LinearAlgebra.mul!(C::ROCVector{T}, A::$TypeA, B::DenseROCVector{T},
                                    alpha::Number, beta::Number) where {T <: Union{Float16, ComplexF16, BlasFloat}}
            mv_wrapper($transa(T), alpha, $(untaga(unwrapa(:A))), B, beta, C)
        end

        function LinearAlgebra.mul!(C::ROCVector{Complex{T}}, A::$TypeA, B::DenseROCVector{Complex{T}},
                                    alpha::Number, beta::Number) where {T <: Union{Float16, BlasFloat}}
            mv_wrapper($transa(T), alpha, $(untaga(unwrapa(:A))), B, beta, C)
        end
    end

    for (tagb, untagb) in tag_wrappers, (wrapb, transb, unwrapb) in op_wrappers
        TypeB = wrapb(tagb(:(DenseROCMatrix{T})))

        @eval begin
            function LinearAlgebra.mul!(C::ROCMatrix{T}, A::$TypeA, B::$TypeB,
                                        alpha::Number, beta::Number) where {T <: Union{Float16, ComplexF16, BlasFloat}}
                mm_wrapper($transa(T), $transb(T), alpha, $(untaga(unwrapa(:A))), $(untagb(unwrapb(:B))), beta, C)
            end
        end
    end
end

Base.:(+)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, one(eltype(A)), B, 'O')
Base.:(-)(A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = geam(one(eltype(A)), A, -one(eltype(A)), B, 'O')

Base.:(+)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where {T} = A + Transpose(conj(B.parent))
Base.:(-)(A::ROCSparseMatrixCSR, B::Adjoint{T,<:ROCSparseMatrixCSR}) where {T} = A - Transpose(conj(B.parent))
Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where {T} = Transpose(conj(A.parent)) + B
Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where {T} = Transpose(conj(A.parent)) - B
Base.:(+)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where {T} =
    Transpose(conj(A.parent)) + B
Base.:(-)(A::Adjoint{T,<:ROCSparseMatrixCSR}, B::Adjoint{T,<:ROCSparseMatrixCSR}) where {T} =
    Transpose(conj(A.parent)) - B

function Base.:(+)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where {T}
    cscB = ROCSparseMatrixCSC(B.parent)
    transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
    return geam(one(T), A, one(T), transB, 'O')
end

function Base.:(-)(A::ROCSparseMatrixCSR, B::Transpose{T,<:ROCSparseMatrixCSR}) where {T}
    cscB = ROCSparseMatrixCSC(B.parent)
    transB = ROCSparseMatrixCSR(cscB.colPtr, cscB.rowVal, cscB.nzVal, size(cscB))
    return geam(one(T), A, -one(T), transB, 'O')
end

function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where {T}
    cscA = ROCSparseMatrixCSC(A.parent)
    transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
    geam(one(T), transA, one(T), B, 'O')
end

function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::ROCSparseMatrixCSR) where {T}
    cscA = ROCSparseMatrixCSC(A.parent)
    transA = ROCSparseMatrixCSR(cscA.colPtr, cscA.rowVal, cscA.nzVal, size(cscA))
    geam(one(T), transA, -one(T), B, 'O')
end

function Base.:(+)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where {T}
    C = geam(one(T), A.parent, one(T), B.parent, 'O')
    cscC = ROCSparseMatrixCSC(C)
    return ROCSparseMatrixCSR(cscC.colPtr, cscC.rowVal, cscC.nzVal, size(cscC))
end

function Base.:(-)(A::Transpose{T,<:ROCSparseMatrixCSR}, B::Transpose{T,<:ROCSparseMatrixCSR}) where {T}
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

## direct
for (t, uploc, isunitc) in ((:LowerTriangular, 'L', 'N'),
                            (:UnitLowerTriangular, 'L', 'U'),
                            (:UpperTriangular, 'U', 'N'),
                            (:UnitUpperTriangular, 'U', 'U'))
    @eval begin
        # Left division
        LinearAlgebra.ldiv!(A::$t{T,<:AbstractROCSparseMatrix},
                            B::DenseROCVector{T}) where {T<:BlasFloat} =
            sv2!('N', $uploc, $isunitc, one(T), parent(A), B, 'O')

        LinearAlgebra.ldiv!(A::$t{T,<:AbstractROCSparseMatrix},
                            B::DenseROCMatrix{T}) where {T<:BlasFloat} =
            sm2!('N', 'N', $uploc, $isunitc, one(T), parent(A), B, 'O')
    end
end

## adjoint/transpose ('uploc' reversed)
for (t, uploc, isunitc) in ((:LowerTriangular, 'U', 'N'),
                            (:UnitLowerTriangular, 'U', 'U'),
                            (:UpperTriangular, 'L', 'N'),
                            (:UnitUpperTriangular, 'L', 'U'))
    @eval begin
        # Left division with vectors
        LinearAlgebra.ldiv!(A::$t{<:Any,<:Transpose{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCVector{T}) where {T<:BlasFloat} =
            sv2!('T', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')

        LinearAlgebra.ldiv!(A::$t{<:Any,<:Adjoint{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCVector{T}) where {T<:BlasReal} =
            sv2!('T', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')

        LinearAlgebra.ldiv!(A::$t{<:Any,<:Adjoint{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCVector{T}) where {T<:BlasComplex} =
            sv2!('C', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')

        # Left division with matrices
        LinearAlgebra.ldiv!(A::$t{<:Any,<:Transpose{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCMatrix{T}) where {T<:BlasFloat} =
            sm2!('T', 'N', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')

        LinearAlgebra.ldiv!(A::$t{<:Any,<:Adjoint{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCMatrix{T}) where {T<:BlasReal} =
            sm2!('T', 'N', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')

        LinearAlgebra.ldiv!(A::$t{<:Any,<:Adjoint{T,<:AbstractROCSparseMatrix}},
                            B::DenseROCMatrix{T}) where {T<:BlasComplex} =
            sm2!('C', 'N', $uploc, $isunitc, one(T), parent(parent(A)), B, 'O')
    end
end


## uniform scaling

# these operations materialize the identity matrix and re-use broadcast
# TODO: can we do without this, and just use the broadcast implementation
#       with a singleton argument it knows how to index?

function _sparse_identity(::Type{<:ROCSparseMatrixCSR{<:Any,Ti}},
                          I::UniformScaling{Tv}, dims::Dims) where {Tv,Ti}
    len = min(dims[1], dims[2])
    rowPtr = ROCVector{Ti}(vcat(1:len, fill(len+1, dims[1]-len+1)))
    colVal = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCSR{Tv,Ti}(rowPtr, colVal, nzVal, dims)
end

function _sparse_identity(::Type{<:ROCSparseMatrixCSC{<:Any,Ti}},
                          I::UniformScaling{Tv}, dims::Dims) where {Tv,Ti}
    len = min(dims[1], dims[2])
    colPtr = ROCVector{Ti}(vcat(1:len, fill(len+1, dims[2]-len+1)))
    rowVal = ROCVector{Ti}(1:len)
    nzVal = AMDGPU.fill(I.λ, len)
    ROCSparseMatrixCSC{Tv,Ti}(colPtr, rowVal, nzVal, dims)
end

Base.:(+)(A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}, J::UniformScaling) =
    A .+ _sparse_identity(typeof(A), J, size(A))

Base.:(-)(J::UniformScaling, A::Union{ROCSparseMatrixCSR,ROCSparseMatrixCSC}) =
    _sparse_identity(typeof(A), J, size(A)) .- A

# TODO: let Broadcast handle this automatically (a la SparseArrays.PromoteToSparse)
for SparseMatrixType in [:ROCSparseMatrixCSC, :ROCSparseMatrixCSR], op in [:(+), :(-)]
    @eval begin
        function Base.$op(lhs::Diagonal{T,<:ROCArray}, rhs::$SparseMatrixType{T}) where {T}
            return $op($SparseMatrixType(lhs), rhs)
        end
        function Base.$op(lhs::$SparseMatrixType{T}, rhs::Diagonal{T,<:ROCArray}) where {T}
            return $op(lhs, $SparseMatrixType(rhs))
        end
    end
end
