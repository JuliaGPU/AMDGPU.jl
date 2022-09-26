using AMDGPU.rocSparse, SparseArrays

m,n = 2,3
p = 0.5

for elty in [Int32,]
    for typ in [ROCSparseMatrixCSC,]
        @eval begin 
        x = sprand($elty, m, n, p)
        dx = $typ(x)

        # zero-preserving
        y = x .* $elty(1)
        dy = dx .* $elty(1)
        @assert dy isa $typ{$elty}
        @assert y == SparseMatrixCSC(dy)

        # not zero-preserving
        y = x .+ $elty(1)
        dy = dx .+ $elty(1)
        @assert dy isa ROCArray{$elty}
        @assert y == Array(dy)

        # involving something dense
        y = x .* ones($elty, m, n)
        dy = dx .* AMDGPU.ones($elty, m, n)
        @assert dy isa ROCArray{$elty}
        @assert y == Array(dy)

        # multiple inputs
        y = sprand($elty, m, n, p)
        dy = ROCSparseMatrixCSR(y)
        z = x .* y .* $elty(2)
        dz = dx .* dy .* $elty(2)
        @assert dz isa typ{$elty}
        @assert z == SparseMatrixCSC(dz)
        end
    end
end


x = ROCSparseMatrixCSR(sparse([1, 2], [2, 1], [5.0, 5.0]))
y = Int.(x)
@assert eltype(y) == Int
