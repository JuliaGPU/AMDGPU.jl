# interfacing with other packages
#
# GPUArrays implements LinearAlgebra and SparseArrays for the canonical sparse formats
# with portable kernels. The methods here override the products and triangular solves
# where rocSPARSE applies: BLAS element types, 32- or 64-bit indices, and contiguous dense
# operands. Other cases fall through to GPUArrays' generic implementations
# (`GPUArrays.generic_spmv!` etc.).

# index types of rocSPARSE's generic API
const SpIndex = Union{Int32, Int64}

# the canonical formats rocSPARSE's generic API takes
const ROCVendorMatrix{Tv} = Union{ROCSparseMatrixCSR{Tv,<:SpIndex},ROCSparseMatrixCSC{Tv,<:SpIndex},
                                  ROCSparseMatrixCOO{Tv,<:SpIndex}}

# convert the element type of a sparse matrix (mixed-eltype products), sharing the index
# buffers
sparse_with_eltype(A::GPUArrays.GPUSparseArray, ::Type{T}) where {T} =
    GPUArrays.with_eltypes(A, T, SparseArrays.indtype(A))
sparse_with_eltype(A::ROCSparseMatrixBSR{<:Any, Ti}, ::Type{T}) where {T, Ti} =
    ROCSparseMatrixBSR{T, Ti}(A.rowPtr, A.colVal, convert(ROCVector{T}, nonzeros(A)), size(A),
                              A.blockDim, A.dir, A.nnzb)

# LinearAlgebra's storage-level `mul!` passes a `Symmetric` or `Hermitian` operand as its
# parent plus 'S'/'s'/'H'/'h'. rocSPARSE has no symmetric or Hermitian products, so
# materialize the full matrix that the wrapper represents. (issue #1168)
function unwrap_symmherm(t::AbstractChar, A)
    uppercase(t) in ('S', 'H') || return t, A
    A isa ROCSparseMatrixBSR && (A = ROCSparseMatrixCSR(A))
    return 'N', materialize_symmherm(LinearAlgebra.wrap(A, t))
end
materialize_symmherm(A::HermOrSym{<:Any,<:GPUArrays.GPUSparseMatrix}) = GPUArrays.materialize(A)
function materialize_symmherm(A::HermOrSym{<:Any,<:DenseROCMatrix})
    # `ROCMatrix(A)` would go through the CPU
    B = LinearAlgebra.copytri!(copy(parent(A)), A.uplo, A isa Hermitian)
    if A isa Hermitian
        d = view(B, diagind(B))
        d .= real.(d)
    end
    return B
end

# SpGEMM only multiplies untransposed operands
vendor_operand(t::AbstractChar, A) = t == 'N' ? A : GPUArrays.materialize(LinearAlgebra.wrap(A, t))


## products

check_dot_dims(x, y) = length(x) == length(y) ||
    throw(DimensionMismatch("x has length $(length(x)), y has length $(length(y))"))
LinearAlgebra.dot(x::ROCSparseVector{T,<:SpIndex}, y::DenseROCVector{T}) where {T <: BlasReal} =
    (check_dot_dims(x, y); vv!('N', x, y, 'O'))
LinearAlgebra.dot(x::DenseROCVector{T}, y::ROCSparseVector{T,<:SpIndex}) where {T <: BlasReal} = dot(y, x)

LinearAlgebra.dot(x::ROCSparseVector{T,<:SpIndex}, y::DenseROCVector{T}) where {T <: BlasComplex} =
    (check_dot_dims(x, y); vv!('C', x, y, 'O'))
LinearAlgebra.dot(x::DenseROCVector{T}, y::ROCSparseVector{T,<:SpIndex}) where {T <: BlasComplex} = conj(dot(y,x))

# The products below accept inputs of any numeric eltype, converting them to the eltype of
# the output, which rocSPARSE requires.

function sparse_mv!(C::ROCVector{Tc}, tA::AbstractChar, A, B::DenseROCVector, alpha::Number, beta::Number) where {Tc}
    tA, A = unwrap_symmherm(tA, A)
    A′ = eltype(A) === Tc ? A : sparse_with_eltype(A, Tc)
    B′ = eltype(B) === Tc ? B : convert(ROCVector{Tc}, B)
    mv!(tA, alpha, A′, B′, beta, C, 'O')
end
LinearAlgebra.mul!(C::ROCVector{Tc}, tA::AbstractChar, A::ROCVendorMatrix{<:Number}, B::DenseROCVector{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat} =
    sparse_mv!(C, tA, A, B, alpha, beta)
LinearAlgebra.mul!(C::ROCVector{Tc}, tA::AbstractChar, A::ROCSparseMatrixBSR{<:Number}, B::DenseROCVector{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat} =
    sparse_mv!(C, tA, A, B, alpha, beta)

function sparse_mm!(C::ROCMatrix{Tc}, tA, tB, A, B::DenseROCMatrix, alpha::Number, beta::Number) where {Tc}
    tA, A = unwrap_symmherm(tA, A)
    tB, B = unwrap_symmherm(tB, B)
    A′ = eltype(A) === Tc ? A : sparse_with_eltype(A, Tc)
    B′ = eltype(B) === Tc ? B : convert(ROCMatrix{Tc}, B)
    mm!(tA, tB, alpha, A′, B′, beta, C, 'O')
end
for TA in (:(ROCVendorMatrix{<:Number}), :(ROCSparseMatrixBSR{<:Number}))
    @eval function LinearAlgebra.mul!(C::ROCMatrix{Tc}, tA::AbstractChar, tB::AbstractChar, A::$TA, B::DenseROCMatrix{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat}
        # (rocSPARSE rejects empty dense operands)
        if isempty(B) || isempty(C)
            A isa ROCSparseMatrixBSR && (A = ROCSparseMatrixCSR(A))
            return GPUArrays.generic_spmm!(C, tA, tB, A, B, alpha, beta)
        end
        sparse_mm!(C, tA, tB, A, B, alpha, beta)
    end
end
function LinearAlgebra.mul!(C::ROCMatrix{Tc}, tA::AbstractChar, tB::AbstractChar, A::DenseROCMatrix{<:Number}, B::ROCVendorMatrix{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat}
    (isempty(A) || isempty(C)) && return GPUArrays.generic_spmm!(C, tA, tB, A, B, alpha, beta)
    tA, A = unwrap_symmherm(tA, A)
    tB, B = unwrap_symmherm(tB, B)
    A′ = eltype(A) === Tc ? A : convert(ROCMatrix{Tc}, A)
    B′ = eltype(B) === Tc ? B : sparse_with_eltype(B, Tc)
    mm!(tA, tB, alpha, A′, B′, beta, C, 'O')
end

# SpGEMM, which works on CSR matrices
spgemm_csr(alpha, A::ROCSparseMatrixCSR, B::ROCSparseMatrixCSR) = gemm('N', 'N', alpha, A, B, 'O')
function spgemm_csr(alpha, A::ROCSparseMatrixCSC, B::ROCSparseMatrixCSC)
    # C = AB <---> Cᵀ = BᵀAᵀ, with the CSC buffers of A and B being CSR ones of Aᵀ and Bᵀ
    Aᵀ = ROCSparseMatrixCSR(A.colPtr, A.rowVal, A.nzVal, reverse(size(A)))
    Bᵀ = ROCSparseMatrixCSR(B.colPtr, B.rowVal, B.nzVal, reverse(size(B)))
    Cᵀ = gemm('N', 'N', alpha, Bᵀ, Aᵀ, 'O')
    ROCSparseMatrixCSC(Cᵀ.rowPtr, Cᵀ.colVal, Cᵀ.nzVal, reverse(size(Cᵀ)))
end
for S in (:ROCSparseMatrixCSR, :ROCSparseMatrixCSC)
    @eval begin
        Base.:(*)(A::$S{T,Ti}, B::$S{T,Ti}) where {T <: BlasFloat, Ti <: SpIndex} = spgemm_csr(one(T), A, B)
        function LinearAlgebra.mul!(C::$S{Tc}, tA::AbstractChar, tB::AbstractChar, A::$S{<:Number,Ti}, B::$S{<:Number,Ti}, alpha::Number, beta::Number) where {Tc <: BlasFloat, Ti <: SpIndex}
            A = vendor_operand(tA, A)
            B = vendor_operand(tB, B)
            A′ = eltype(A) === Tc ? A : sparse_with_eltype(A, Tc)
            B′ = eltype(B) === Tc ? B : sparse_with_eltype(B, Tc)
            P = spgemm_csr(alpha, A′, B′)
            size(P) == size(C) ||
                throw(DimensionMismatch("C has dimensions $(size(C)), the product has $(size(P))"))
            copyto!(C, iszero(beta) ? P : P .+ beta .* C)
        end
    end
end
Base.:(*)(A::ROCSparseMatrixCOO{T,Ti}, B::ROCSparseMatrixCOO{T,Ti}) where {T <: BlasFloat, Ti <: SpIndex} =
    ROCSparseMatrixCOO(ROCSparseMatrixCSR(A) * ROCSparseMatrixCSR(B))

# Julia < 1.13 dispatches on the non-public `generic_matvecmul!` and `generic_matmatmul!`.
# GPUArrays forwards those to `mul!` for the canonical formats; do the same for BSR
# matrices.
@static if VERSION < v"1.13.0-rc4"
    LinearAlgebra.generic_matvecmul!(C::ROCVector{Tc}, tA::AbstractChar, A::ROCSparseMatrixBSR{<:Number}, B::DenseROCVector{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat} =
        LinearAlgebra.mul!(C, tA, A, B, alpha, beta)
    LinearAlgebra.generic_matvecmul!(C::ROCVector{Tc}, tA::AbstractChar, A::ROCSparseMatrixBSR{<:Number}, B::DenseROCVector{<:Number}, _add::MulAddMul) where {Tc <: BlasFloat} =
        LinearAlgebra.mul!(C, tA, A, B, _add.alpha, _add.beta)
    LinearAlgebra.generic_matmatmul!(C::ROCMatrix{Tc}, tA, tB, A::ROCSparseMatrixBSR{<:Number}, B::DenseROCMatrix{<:Number}, alpha::Number, beta::Number) where {Tc <: BlasFloat} =
        LinearAlgebra.mul!(C, tA, tB, A, B, alpha, beta)
    LinearAlgebra.generic_matmatmul!(C::ROCMatrix{Tc}, tA, tB, A::ROCSparseMatrixBSR{<:Number}, B::DenseROCMatrix{<:Number}, _add::MulAddMul) where {Tc <: BlasFloat} =
        LinearAlgebra.mul!(C, tA, tB, A, B, _add.alpha, _add.beta)
end


## BSR matrices

# arithmetic converts to CSR, which GPUArrays implements
for op in (:+, :-)
    @eval begin
        Base.$op(A::ROCSparseMatrixBSR, B::GPUArrays.GPUSparseMatrix) = $op(ROCSparseMatrixCSR(A), B)
        Base.$op(A::GPUArrays.GPUSparseMatrix, B::ROCSparseMatrixBSR) = $op(A, ROCSparseMatrixCSR(B))
        Base.$op(A::ROCSparseMatrixBSR, B::ROCSparseMatrixBSR) = $op(ROCSparseMatrixCSR(A), ROCSparseMatrixCSR(B))
    end
end


LinearAlgebra.istriu(A::ROCSparseMatrixBSR, k::Integer=0) = istriu(ROCSparseMatrixCSR(A), k)
LinearAlgebra.istril(A::ROCSparseMatrixBSR, k::Integer=0) = istril(ROCSparseMatrixCSR(A), k)

# Triangular wrappers answer by their structure, so that LinearAlgebra's triangular solves
# reach the methods below (the generic ones would index the parent).
const ROCSparseBSROperand = Union{ROCSparseMatrixBSR,Transpose{<:Any,<:ROCSparseMatrixBSR},
                                  Adjoint{<:Any,<:ROCSparseMatrixBSR}}
LinearAlgebra.istriu(::Union{UpperTriangular{<:Any,<:ROCSparseBSROperand},
                             UnitUpperTriangular{<:Any,<:ROCSparseBSROperand}}) = true
LinearAlgebra.istril(::Union{UpperTriangular{<:Any,<:ROCSparseBSROperand},
                             UnitUpperTriangular{<:Any,<:ROCSparseBSROperand}}) = false
LinearAlgebra.istril(::Union{LowerTriangular{<:Any,<:ROCSparseBSROperand},
                             UnitLowerTriangular{<:Any,<:ROCSparseBSROperand}}) = true
LinearAlgebra.istriu(::Union{LowerTriangular{<:Any,<:ROCSparseBSROperand},
                             UnitLowerTriangular{<:Any,<:ROCSparseBSROperand}}) = false


## triangular solves


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

