rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

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
GPUArrays.blas_syrk!(
    uplo::AbstractChar, trans::AbstractChar, α::Union{Bool,T}, A::StridedROCMatrix{T},
    β::Union{Bool,T}, C::StridedROCMatrix{T},
) where T <: ROCBLASFloat = syrk!(uplo, trans, T(α), A, T(β), C)
GPUArrays.blas_herk!(
    uplo::AbstractChar, trans::AbstractChar, α::Real, A::ROCMatrix{T}, β::Real, C::ROCMatrix{T},
) where T <: ROCBLASComplex = herk!(uplo, trans, real(T)(α), A, real(T)(β), C)
GPUArrays.blas_geam!(
    tA::AbstractChar, tB::AbstractChar, α::Union{Bool,T}, A::ROCMatrix{T},
    β::Union{Bool,T}, B::ROCMatrix{T}, C::ROCMatrix{T},
) where T <: ROCBLASFloat = geam!(tA, tB, T(α), A, T(β), B, C)
GPUArrays.blas_dgmm!(
    side::AbstractChar, A::StridedROCMatrix{T}, x::StridedROCVector{T}, C::StridedROCMatrix{T},
) where T <: ROCBLASFloat = dgmm!(side, A, x, C)

# the level 1 wrappers take dense arrays and an increment
GPUArrays.blas_scal!(α::Number, x::ROCArray{T}) where T <: ROCBLASFloat =
    scal!(length(x), convert(T, α), x, 1)
GPUArrays.blas_scal!(α::Real, x::ROCArray{T}) where T <: ROCBLASComplex =
    scal!(length(x), convert(real(T), α), x, 1)
GPUArrays.blas_dot(x::ROCArray{T}, y::ROCArray{T}) where T <: Union{Float16, ROCBLASReal} =
    dot(length(x), x, 1, y, 1)
GPUArrays.blas_dot(x::ROCArray{T}, y::ROCArray{T}) where T <: ROCBLASComplex =
    dotc(length(x), x, 1, y, 1)
GPUArrays.blas_dotu(x::ROCArray{T}, y::ROCArray{T}) where T <: ROCBLASComplex =
    dotu(length(x), x, 1, y, 1)
GPUArrays.blas_asum(x::ROCArray{<:ROCBLASFloat}) = asum(length(x), x, 1)
GPUArrays.blas_axpy!(α::Number, x::ROCArray{T}, y::ROCArray{T}) where T <: ROCBLASFloatWithHalf =
    axpy!(length(x), convert(T, α), x, 1, y, 1)
function GPUArrays.blas_axpby!(α::Number, x::ROCArray{T}, β::Number, y::ROCArray{T}) where T <: ROCBLASFloat
    GPUArrays.blas_scal!(β, y)
    axpy!(length(x), convert(T, α), x, 1, y, 1)
end
GPUArrays.blas_rot!(x::ROCArray{T}, y::ROCArray{T}, c::Real, s::Number) where T <: ROCBLASFloat =
    rot!(length(x), x, 1, y, 1, convert(real(T), c), s isa Real ? convert(real(T), s) : convert(T, s))

# Diagonal matrix.

AMDGPU.ROCArray(D::Diagonal{T, <: Vector{T}}) where T = Diagonal(ROCArray(D.diag))

if VERSION ≥ v"1.12-"
    # Otherwise, dispatches to:
    # https://github.com/JuliaLang/LinearAlgebra.jl/blob/4e7c3f40316a956119ac419a97c4b8aad7a17e6c/src/generic.jl#L2092
    LinearAlgebra.copytrito!(B::Matrix{T}, A::ROCMatrix{T}, uplo::AbstractChar) where {T <: ROCBLASFloat} =
        invoke(LinearAlgebra.copytrito!, Tuple{AbstractMatrix, AbstractMatrix, AbstractChar}, B, A, uplo)
end
