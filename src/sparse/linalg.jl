using LinearAlgebra

function sum_dim1(A::ROCSparseMatrixCSR)
    function kernel(Tnorm, out, dA)
        idx = Int32((blockIdx().x-1) * blockDim().x + threadIdx().x)
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
    threads = n
    blocks = cld(n, threads)
    @roc threads=threads blocks=blocks kernel(Tnorm, rowsum, A)
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
