function sum_dim1(A::ROCSparseMatrixCSR)
    function kernel(Tnorm, out, dA)
        idx::UInt32 = (blockIdx().x-1) * blockDim().x + threadIdx().x
        idx < length(dA.rowPtr) || return
        s = zero(Tnorm)
        for k in dA.rowPtr[idx]:dA.rowPtr[idx+1]-1
            s += abs(dA.nzVal[k])
        end
        out[idx] = s
        return
    end

    m, n = size(A)
    Tnorm = typeof(float(real(zero(eltype(A)))))
    Tsum = promote_type(Float64,Tnorm)
    rowsum = AMDGPU.ROCArray{Tsum}(undef, m)
    groupsize = n
    gridsize = cld(n, groupsize)
    @roc gridsize=gridsize groupsize=groupsize kernel(Tnorm, rowsum, A)
    return rowsum
end

function LinearAlgebra.opnorm(A::ROCSparseMatrixCSR, p::Real=2)
    if p == Inf
        return maximum(sum_dim1(A))
    else
        error("p=$p is not supported")
    end
end

LinearAlgebra.opnorm(A::ROCSparseMatrixCSC, p::Real=2) = opnorm(ROCSparseMatrixCSR(A), p)

# work around upstream breakage from JuliaLang/julia#55547
@static if VERSION >= v"1.11.2"
    const ROCSparseUpperOrUnitUpperTriangular = LinearAlgebra.UpperOrUnitUpperTriangular{
        <:Any,<:Union{<:AbstractROCSparseMatrix, Adjoint{<:Any, <:AbstractROCSparseMatrix}, Transpose{<:Any, <:AbstractROCSparseMatrix}}}
    const ROCSparseLowerOrUnitLowerTriangular = LinearAlgebra.LowerOrUnitLowerTriangular{
        <:Any,<:Union{<:AbstractROCSparseMatrix, Adjoint{<:Any, <:AbstractROCSparseMatrix}, Transpose{<:Any, <:AbstractROCSparseMatrix}}}
    LinearAlgebra.istriu(::ROCSparseUpperOrUnitUpperTriangular) = true
    LinearAlgebra.istril(::ROCSparseUpperOrUnitUpperTriangular) = false
    LinearAlgebra.istriu(::ROCSparseLowerOrUnitLowerTriangular) = false
    LinearAlgebra.istril(::ROCSparseLowerOrUnitLowerTriangular) = true
end
