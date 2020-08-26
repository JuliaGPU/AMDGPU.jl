rocblas_size(t::Char, M::ROCVecOrMat) = (size(M, t=='N' ? 1 : 2), size(M, t=='N' ? 2 : 1))

const ROCBLASArray{T<:ROCBLASFloat} = ROCArray{T}

###########
#
# BLAS 1
#
###########

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Real) =
  scal!(length(x), convert(real(eltype(x)), k), x, 1)

LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASComplex}, k::Number) =
  scal!(length(x), convert(eltype(x), k), x, 1)

# Work around ambiguity with GPUArrays wrapper
LinearAlgebra.rmul!(x::ROCArray{<:ROCBLASFloat}, k::Real) =
  invoke(rmul!, Tuple{typeof(x), Number}, x, k)

function LinearAlgebra.BLAS.dot(DX::ROCArray{T}, DY::ROCArray{T}) where T<:Union{Float32,Float64}
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dot(n, DX, 1, DY, 1)
end

function LinearAlgebra.BLAS.dotc(DX::ROCArray{T}, DY::ROCArray{T}) where T<:Union{ComplexF32,ComplexF64}
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotc(n, DX, 1, DY, 1)
end

function LinearAlgebra.BLAS.dot(DX::ROCArray{T}, DY::ROCArray{T}) where T<:Union{ComplexF32,ComplexF64}
    dotc(DX, DY)
end

function LinearAlgebra.BLAS.dotu(DX::ROCArray{T}, DY::ROCArray{T}) where T<:Union{ComplexF32,ComplexF64}
    n = length(DX)
    n==length(DY) || throw(DimensionMismatch("dot product arguments have lengths $(length(DX)) and $(length(DY))"))
    dotu(n, DX, 1, DY, 1)
end

# FIXME: LinearAlgebra.norm(x::ROCBLASArray) = nrm2(x)
LinearAlgebra.BLAS.asum(x::ROCBLASArray) = asum(length(x), x, 1)

function LinearAlgebra.axpy!(alpha::Number, x::ROCArray{T}, y::ROCArray{T}) where T<:ROCBLASFloat
    length(x)==length(y) || throw(DimensionMismatch(""))
    axpy!(length(x), convert(T,alpha), x, 1, y, 1)
end

#= FIXME
Base.argmin(xs::ROCBLASArray{<:ROCBLASReal}) = iamin(xs)
Base.argmax(xs::ROCBLASArray{<:ROCBLASReal}) = iamax(xs)
=#



############
#
# BLAS 2
#
############

#########
# GEMV
##########
function gemv_wrapper!(y::ROCVector{T}, tA::Char, A::ROCMatrix{T}, x::ROCVector{T},
                       alpha = one(T), beta = zero(T)) where T<:ROCBLASFloat
    mA, nA = rocblas_size(tA, A)
    if nA != length(x)
        throw(DimensionMismatch("second dimension of A, $nA, does not match length of x, $(length(x))"))
    end
    if mA != length(y)
        throw(DimensionMismatch("first dimension of A, $mA, does not match length of y, $(length(y))"))
    end
    if mA == 0
        return y
    end
    if nA == 0
        return rmul!(y, 0)
    end
    gemv!(tA, alpha, A, x, beta, y)
end

LinearAlgebra.mul!(Y::ROCVector{T}, A::ROCMatrix{T}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'N', A,  B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Transpose{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'T', A.parent, B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASFloat = gemv_wrapper!(Y, 'T', A.parent, B)
LinearAlgebra.lmul!(Y::ROCVector{T}, A::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCVector{T}) where T<:ROCBLASComplex = gemv_wrapper!(Y, 'C', A.parent, B)



############
#
# BLAS 3
#
############

########
# GEMM
########
function gemm_wrapper!(C::ROCVecOrMat{T}, tA::Char, tB::Char,
                   A::ROCVecOrMat{T},
                   B::ROCVecOrMat{T},
                   alpha = one(T),
                   beta = zero(T)) where T <: ROCBLASFloat
    mA, nA = rocblas_size(tA, A)
    mB, nB = rocblas_size(tB, B)

    if nA != mB
        throw(DimensionMismatch("A has dimensions ($mA,$nA) but B has dimensions ($mB,$nB)"))
    end

    if C === A || B === C
        throw(ArgumentError("output matrix must not be aliased with input matrix"))
    end

    if mA == 0 || nA == 0 || nB == 0
        if size(C) != (mA, nB)
            throw(DimensionMismatch("C has dimensions $(size(C)), should have ($mA,$nB)"))
        end
        return LinearAlgebra.rmul!(C, 0)
    end

    gemm!(tA, tB, alpha, A, B, beta, C)
end

# Mutating
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCVecOrMat{T}, B::ROCVecOrMat{T}) where T<:ROCBLASFloat = gemm_wrapper!(C, 'N', 'N', A, B)
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'T', 'N', parent(trA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'N', 'T', A, parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'N', parent(adjA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'C', 'N', parent(adjA), B)
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'N', 'T', A, parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, A::ROCMatrix{T}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'N', 'C', A, parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'C', 'C', parent(adjA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(trA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, trA::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}, adjB::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASFloat =
    gemm_wrapper!(C, 'T', 'C', parent(trA), parent(adjB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{T, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T<:ROCBLASReal =
    gemm_wrapper!(C, 'T', 'T', parent(adjA), parent(trB))
LinearAlgebra.mul!(C::ROCMatrix{T}, adjA::LinearAlgebra.Adjoint{<:Any, <:ROCMatrix{T}}, trB::LinearAlgebra.Transpose{<:Any, <:ROCMatrix{T}}) where T <: ROCBLASFloat =
    gemm_wrapper!(C, 'C', 'T', parent(adjA), parent(trB))


########
# TRSM
########

# ldiv!
## No transpose/adjoint
LinearAlgebra.ldiv!(A::UpperTriangular{T,ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'N', 'N', one(T), parent(A), B)
LinearAlgebra.ldiv!(A::UnitUpperTriangular{T,ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'N', 'U', one(T), parent(A), B)
LinearAlgebra.ldiv!(A::LowerTriangular{T,ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'N', 'N', one(T), parent(A), B)
LinearAlgebra.ldiv!(A::UnitLowerTriangular{T,ROCMatrix{T}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'N', 'U', one(T), parent(A), B)
## Adjoint
LinearAlgebra.ldiv!(A::Adjoint{T,UpperTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'C', 'N', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Adjoint{T,UnitUpperTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'C', 'U', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Adjoint{T,LowerTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'C', 'N', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Adjoint{T,UnitLowerTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'C', 'U', one(T), parent(parent(A)), B)
## Transpose
LinearAlgebra.ldiv!(A::Transpose{T,UpperTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'T', 'N', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Transpose{T,UnitUpperTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'U', 'T', 'U', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Transpose{T,LowerTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'T', 'N', one(T), parent(parent(A)), B)
LinearAlgebra.ldiv!(A::Transpose{T,UnitLowerTriangular{T,ROCMatrix{T}}}, B::ROCMatrix{T}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('L', 'L', 'T', 'U', one(T), parent(parent(A)), B)

# rdiv!
## No transpose/adjoint
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::UpperTriangular{T,ROCMatrix{T}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'N', 'N', one(T), parent(B), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::UnitUpperTriangular{T,ROCMatrix{T}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'N', 'U', one(T), parent(B), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::LowerTriangular{T,ROCMatrix{T}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'N', 'N', one(T), parent(B), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::UnitLowerTriangular{T,ROCMatrix{T}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'N', 'U', one(T), parent(B), A)
## Adjoint
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Adjoint{T,UpperTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'C', 'N', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Adjoint{T,UnitUpperTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'C', 'U', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Adjoint{T,LowerTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'C', 'N', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Adjoint{T,UnitLowerTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'C', 'U', one(T), parent(parent(B)), A)
## Transpose
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Transpose{T,UpperTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'T', 'N', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Transpose{T,UnitUpperTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'U', 'T', 'U', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Transpose{T,LowerTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'T', 'N', one(T), parent(parent(B)), A)
LinearAlgebra.rdiv!(A::ROCMatrix{T}, B::Transpose{T,UnitLowerTriangular{T,ROCMatrix{T}}}) where T<:ROCBLASFloat =
    rocBLAS.trsm!('R', 'L', 'T', 'U', one(T), parent(parent(B)), A)
