rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

#
# BLAS 1
#

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Real) =
  scal!(length(x), convert(real(eltype(x)), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

# Work around ambiguity with GPUArrays wrapper
LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Real) =
  invoke(rmul!, Tuple{typeof(x), Number}, x, k)

function LinearAlgebra.dot(
    DX::StridedROCArray{T}, DY::StridedROCArray{T},
) where T <: Union{Float16, Float32, Float64}
    n = length(DX)
    n == length(DY) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dot(n, DX, stride(DX, 1), DY, stride(DY, 1))
end

function LinearAlgebra.dot(
    DX::StridedROCArray{T}, DY::StridedROCArray{T},
) where T <: ROCBLASComplex
    n = length(DX)
    n == length(DY) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotc(n, DX, stride(DX, 1), DY, stride(DY, 1))
end

function LinearAlgebra.:(*)(
    transx::Transpose{<:Any, <:StridedROCVector{T}}, y::StridedROCVector{T},
) where T <: Union{ComplexF16, ROCBLASComplex}
    x = transx.parent
    n = length(x)
    n == length(y) || throw(DimensionMismatch(
        "dot product arguments have lengths $(length(x)) and $(length(y))"))
    dotu(n, x, stride(x, 1), y, stride(y, 1))
end

LinearAlgebra.norm(x::Diagonal{T, <:StridedROCVector{T}}, p::Real=2) where {T<:Union{Float16, ComplexF16, ROCBLASFloat}} = norm(x.diag, p)
LinearAlgebra.norm(x::ROCArray{T}) where T <: ROCBLASFloat = nrm2(length(x), x, stride(x, 1))
LinearAlgebra.BLAS.asum(x::ROCArray{T}) where T <: ROCBLASFloat = asum(length(x), x, stride(x, 1))

function LinearAlgebra.axpy!(
    alpha::Number, x::ROCArray{T}, y::ROCArray{T},
) where T <: ROCBLASFloatWithHalf
    length(x) == length(y) || throw(DimensionMismatch(""))
    axpy!(length(x), convert(T,alpha), x, 1, y, 1)
end

function LinearAlgebra.axpby!(
    alpha::Number, x::ROCArray{T}, beta::Number, y::ROCArray{T},
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(""))
    beta = isa(beta, Real) ? convert(real(T), beta) : convert(T, beta)
    scal!(ly, beta, y, 1)
    axpy!(lx, convert(T,alpha), x, 1, y, 1)
end

function LinearAlgebra.rotate!(
    x::ROCArray{T}, y::ROCArray{T}, c::Number, s::Number,
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(
        "rotate arguments have lengths $lx and $ly"))
    rot!(lx, x, 1, y, 1, c, s)
    x, y
end

function LinearAlgebra.reflect!(
    x::ROCArray{T}, y::ROCArray{T}, c::Number, s::Number,
) where T <: Union{ROCBLASFloat, ROCBLASComplex}
    lx, ly = length(x), length(y)
    lx == ly || throw(DimensionMismatch(
        "reflect arguments have lengths $lx and $ly"))
    rot!(lx, x, 1, y, 1, c, s)
    scal!(ly, -real(one(T)), y, 1)
    x, y
end

#
# BLAS 2
#

# work around upstream breakage from JuliaLang/julia#55547
@static if VERSION >= v"1.11.2"
const ROCUpperOrUnitUpperTriangular = LinearAlgebra.UpperOrUnitUpperTriangular{
    <:Any,<:Union{<:ROCArray, Adjoint{<:Any, <:ROCArray}, Transpose{<:Any, <:ROCArray}}}
const ROCLowerOrUnitLowerTriangular = LinearAlgebra.LowerOrUnitLowerTriangular{
    <:Any,<:Union{<:ROCArray, Adjoint{<:Any, <:ROCArray}, Transpose{<:Any, <:ROCArray}}}

LinearAlgebra.istriu(::ROCUpperOrUnitUpperTriangular) = true
LinearAlgebra.istril(::ROCUpperOrUnitUpperTriangular) = false
LinearAlgebra.istriu(::ROCLowerOrUnitLowerTriangular) = false
LinearAlgebra.istril(::ROCLowerOrUnitLowerTriangular) = true
end

const AdjOrTransOrROCMatrix{T} = Union{
    StridedROCMatrix{T},
    AdjOrTrans{<: T, <: StridedROCMatrix}}

function LinearAlgebra.generic_trimatmul!(
    C::StridedROCMatrix{T}, uplocA, isunitcA,
    tfunA::Function, A::StridedROCMatrix{T},
    triB::UpperOrLowerTriangular{T, <: AdjOrTransOrROCMatrix{T}},
) where T <: ROCBLASFloat
    uplocB = LinearAlgebra.uplo_char(triB)
    isunitcB = LinearAlgebra.isunit_char(triB)
    B = parent(triB)
    tfunB = LinearAlgebra.wrapperop(B)
    transa = tfunA === identity ? 'N' : tfunA === transpose ? 'T' : 'C'
    transb = tfunB === identity ? 'N' : tfunB === transpose ? 'T' : 'C'
    # one operand gets its other triangle zeroed so rocBLAS can treat it as a full matrix;
    # do so on a copy, as both are the caller's
    if uplocA == 'L' && tfunA === identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N' # lower * upper
        trmm!('L', uplocA, transa, isunitcA, one(T), A, triu!(copy(B)), C)
    elseif uplocA == 'U' && tfunA === identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N' # upper * lower
        trmm!('L', uplocA, transa, isunitcA, one(T), A, tril!(copy(B)), C)
    elseif uplocA == 'U' && tfunA === identity && tfunB !== identity && uplocB == 'U' && isunitcA == 'N'
        # operation is reversed to avoid executing the transpose
        trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), triu!(copy(A)), C)
    elseif uplocA == 'L' && tfunA !== identity && tfunB === identity && uplocB == 'L' && isunitcB == 'N'
        trmm!('L', uplocA, transa, isunitcA, one(T), A, tril!(copy(B)), C)
    elseif uplocA == 'U' && tfunA !== identity && tfunB === identity && uplocB == 'U' && isunitcB == 'N'
        trmm!('L', uplocA, transa, isunitcA, one(T), A, triu!(copy(B)), C)
    elseif uplocA == 'L' && tfunA === identity && tfunB !== identity && uplocB == 'L' && isunitcA == 'N'
        trmm!('R', uplocB, transb, isunitcB, one(T), parent(B), tril!(copy(A)), C)
    else
        throw("mixed triangular-triangular multiplication") # TODO: rethink
    end
    return C
end

# GPUArrays implements LinearAlgebra's matrix products and triangular operations, and
# calls these hooks for the operations that BLAS supports.

GPUArrays.blas_gemv!(
    tA::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T}, x::StridedROCVector{T},
    β::Union{Bool,T}, y::StridedROCVector{T},
) where T <: ROCBLASFloat = gemv!(tA, T(α), A, x, T(β), y)
GPUArrays.blas_symv!(
    uplo::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T}, x::StridedROCVector{T},
    β::Union{Bool,T}, y::StridedROCVector{T},
) where T <: ROCBLASFloat = symv!(uplo, T(α), A, x, T(β), y)
GPUArrays.blas_hemv!(
    uplo::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T}, x::StridedROCVector{T},
    β::Union{Bool,T}, y::StridedROCVector{T},
) where T <: ROCBLASComplex = hemv!(uplo, T(α), A, x, T(β), y)
GPUArrays.blas_trmv!(
    uplo::AbstractChar, trans::AbstractChar, diag::AbstractChar,
    A::StridedROCMatrix{T}, x::StridedROCVector{T},
) where T <: ROCBLASFloat = trmv!(uplo, trans, diag, A, x)
GPUArrays.blas_trsv!(
    uplo::AbstractChar, trans::AbstractChar, diag::AbstractChar,
    A::StridedROCMatrix{T}, x::StridedROCVector{T},
) where T <: ROCBLASFloat = trsv!(uplo, trans, diag, A, x)

GPUArrays.blas_gemm!(
    tA::AbstractChar, tB::AbstractChar, α::Union{Bool,T}, A::StridedROCVecOrMat{T},
    B::StridedROCVecOrMat{T}, β::Union{Bool,T}, C::StridedROCVecOrMat{T},
) where T <: ROCBLASFloat = gemm!(tA, tB, T(α), A, B, T(β), C)
# the non gemm_ex version is slower than the gemm_ex for 16 bit floats
GPUArrays.blas_gemm!(
    tA::AbstractChar, tB::AbstractChar, α::Real, A::StridedROCVecOrMat{T},
    B::StridedROCVecOrMat{T}, β::Real, C::StridedROCVecOrMat{T},
) where T <: Union{Float16, BFloat16} = gemm_ex!(tA, tB, α, A, B, β, C)
GPUArrays.blas_symm!(
    side::AbstractChar, uplo::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T},
    B::StridedROCMatrix{T}, β::Union{Bool,T}, C::StridedROCMatrix{T},
) where T <: ROCBLASFloat = symm!(side, uplo, T(α), A, B, T(β), C)
GPUArrays.blas_hemm!(
    side::AbstractChar, uplo::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T},
    B::StridedROCMatrix{T}, β::Union{Bool,T}, C::StridedROCMatrix{T},
) where T <: ROCBLASComplex = hemm!(side, uplo, T(α), A, B, T(β), C)
GPUArrays.blas_trmm!(
    side::AbstractChar, uplo::AbstractChar, trans::AbstractChar, diag::AbstractChar,
    α::Union{Bool,T}, A::StridedROCMatrix{T}, B::StridedROCMatrix{T}, C::StridedROCMatrix{T},
) where T <: ROCBLASFloat = trmm!(side, uplo, trans, diag, T(α), A, B, C)
GPUArrays.blas_trsm!(
    side::AbstractChar, uplo::AbstractChar, trans::AbstractChar, diag::AbstractChar,
    α::Union{Bool,T}, A::StridedROCMatrix{T}, B::StridedROCMatrix{T},
) where T <: ROCBLASFloat = trsm!(side, uplo, trans, diag, T(α), A, B)

# Diagonal matrix.

Base.Array(D::Diagonal{T, <: ROCArray{T}}) where T = Diagonal(Array(D.diag))

AMDGPU.ROCArray(D::Diagonal{T, <: Vector{T}}) where T = Diagonal(ROCArray(D.diag))

function LinearAlgebra.inv(D::Diagonal{T, <: ROCArray{T}}) where T
    Di = map(inv, D.diag)
    any(isinf, Di) && error("Singular Exception $Di")
    Diagonal(Di)
end

function Base.:/(A::ROCArray, D::Diagonal)
    B = similar(A, typeof(oneunit(eltype(A)) / oneunit(eltype(D))))
    _rdiv!(B, A, D)
end

function LinearAlgebra._rdiv!(B::ROCArray, A::ROCArray, D::Diagonal)
    m, n = size(A, 1), size(A, 2)
    (k = length(D.diag)) != n && throw(DimensionMismatch(
        "left hand side has $n columns but D is $k by $k"))

    B .= A * inv(D)
    return B
end

if VERSION ≥ v"1.12-"
    # Otherwise, dispatches to:
    # https://github.com/JuliaLang/LinearAlgebra.jl/blob/4e7c3f40316a956119ac419a97c4b8aad7a17e6c/src/generic.jl#L2092
    LinearAlgebra.copytrito!(B::Matrix{T}, A::ROCMatrix{T}, uplo::AbstractChar) where {T <: ROCBLASFloat} =
        invoke(LinearAlgebra.copytrito!, Tuple{AbstractMatrix, AbstractMatrix, AbstractChar}, B, A, uplo)
end

function LinearAlgebra.lmul!(A::Diagonal{T,<:ROCVector{T}}, B::ROCMatrix{T}) where {T<:ROCBLASFloat}
    return dgmm!('L', B, A.diag, B)
end

function LinearAlgebra.rmul!(A::ROCMatrix{T}, B::Diagonal{T,<:ROCVector{T}}) where {T<:ROCBLASFloat}
    return dgmm!('R', A, B.diag, A)
end

function LinearAlgebra.mul!(C::Diagonal{T, <:ROCVector}, A::Union{<:ROCMatrix{T}, Adjoint{T, <:ROCMatrix}, Transpose{T, <:ROCMatrix}}, B::Union{<:ROCMatrix{T}, Adjoint{T, <:ROCMatrix}, Transpose{T, <:ROCMatrix}}) where {T<:ROCBLASFloat}
    Cfull   = A*B
    C.diag .= diag(Cfull)
    return C
end

# eltypes do not match
function LinearAlgebra.lmul!(A::Diagonal{T,<:ROCVector{T}}, B::ROCMatrix) where {T<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
function LinearAlgebra.lmul!(A::Diagonal{Td,<:ROCVector{Td}}, B::Transpose{Tt, <:ROCMatrix{Tt}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
function LinearAlgebra.lmul!(A::Diagonal{Td,<:ROCVector{Td}}, B::Adjoint{Tt, <:ROCMatrix{Tt}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    @. B = A.diag * B
    return B
end
# eltypes do not match
function LinearAlgebra.rmul!(A::ROCMatrix, B::Diagonal{T,<:ROCVector{T}}) where {T<:ROCBLASFloat}
    At = transpose(A)
    @. At = B.diag * At
    return A
end
function LinearAlgebra.rmul!(A::Transpose{Tt, <:ROCMatrix{Tt}}, B::Diagonal{Td,<:ROCVector{Td}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    At = parent(A)
    @. At = B.diag * At
    return transpose(At)
end
function LinearAlgebra.rmul!(A::Adjoint{Tt, <:ROCMatrix{Tt}}, B::Diagonal{Td,<:ROCVector{Td}}) where {Td<:ROCBLASFloat, Tt<:ROCBLASFloat}
    At = parent(A)
    @. At = adjoint(B.diag) * At
    return adjoint(At)
end
