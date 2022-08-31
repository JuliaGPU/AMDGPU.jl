# sparse linear algebra functions that perform operations between dense and sparse vectors

export axpyi!, axpyi, sctr!, sctr, gthr!, gthr, gthrz!, roti!, roti

"""
    axpyi!(alpha::BlasFloat, X::ROCSparseVector, Y::ROCVector, index::SparseChar)

Computes `alpha * X + Y` for sparse `X` and dense `Y`.
"""
axpyi!(alpha::BlasFloat, X::ROCSparseVector, Y::ROCVector, index::SparseChar)

for (fname,elty) in ((:rocsparse_saxpyi, :Float32),
                     (:rocsparse_daxpyi, :Float64),
                     (:rocsparse_caxpyi, :ComplexF32),
                     (:rocsparse_zaxpyi, :ComplexF64))
    @eval begin
        function axpyi!(alpha::Number,
                        X::ROCSparseVector{$elty},
                        Y::ROCVector{$elty},
                        index::SparseChar)
            $fname(handle(), nnz(X), alpha, nonzeros(X), nonzeroinds(X), Y, index)
            Y
        end
        function axpyi(alpha::Number,
                       X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       index::SparseChar)
            axpyi!(alpha,X,copy(Y),index)
        end
        function axpyi(X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       index::SparseChar)
            axpyi!(one($elty),X,copy(Y),index)
        end
    end
end

"""
    gthr!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)

Sets the nonzero elements of `X` equal to the nonzero elements of `Y` at the same indices.
"""
gthr!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
for (fname,elty) in ((:rocsparse_sgthr, :Float32),
                     (:rocsparse_dgthr, :Float64),
                     (:rocsparse_cgthr, :ComplexF32),
                     (:rocsparse_zgthr, :ComplexF64))
    @eval begin
        function gthr!(X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       index::SparseChar)
            $fname(handle(), nnz(X), Y, nonzeros(X), nonzeroinds(X), index)
            X
        end
        function gthr(X::ROCSparseVector{$elty},
                      Y::ROCVector{$elty},
                      index::SparseChar)
            gthr!(copy(X),Y,index)
        end
    end
end

"""
    gthrz!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)

Sets the nonzero elements of `X` equal to the nonzero elements of `Y` at the same indices, and zeros out those elements of `Y`.
"""
gthrz!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
for (fname,elty) in ((:rocsparse_sgthrz, :Float32),
                     (:rocsparse_dgthrz, :Float64),
                     (:rocsparse_cgthrz, :ComplexF32),
                     (:rocsparse_zgthrz, :ComplexF64))
    @eval begin
        function gthrz!(X::ROCSparseVector{$elty},
                        Y::ROCVector{$elty},
                        index::SparseChar)
            $fname(handle(), nnz(X), Y, nonzeros(X), nonzeroinds(X), index)
            X,Y
        end
        function gthrz(X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       index::SparseChar)
            gthrz!(copy(X),copy(Y),index)
        end
    end
end

"""
    roti!(X::ROCSparseVector, Y::ROCVector, c::BlasFloat, s::BlasFloat, index::SparseChar)

Performs the Givens rotation specified by `c` and `s` to sparse `X` and dense `Y`.
"""
roti!(X::ROCSparseVector, Y::ROCVector, c::BlasFloat, s::BlasFloat, index::SparseChar)
for (fname,elty) in ((:rocsparse_sroti, :Float32),
                     (:rocsparse_droti, :Float64))
    @eval begin
        function roti!(X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       c::Number,
                       s::Number,
                       index::SparseChar)
            $fname(handle(), nnz(X), nonzeros(X), nonzeroinds(X), Y, c, s, index)
            X,Y
        end
        function roti(X::ROCSparseVector{$elty},
                      Y::ROCVector{$elty},
                      c::Number,
                      s::Number,
                      index::SparseChar)
            roti!(copy(X),copy(Y),c,s,index)
        end
    end
end

"""
    sctr!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)

Set `Y[:] = X[:]` for dense `Y` and sparse `X`.
"""
sctr!(X::ROCSparseVector, Y::ROCVector, index::SparseChar)
for (fname,elty) in ((:rocsparse_ssctr, :Float32),
                     (:rocsparse_dsctr, :Float64),
                     (:rocsparse_csctr, :ComplexF32),
                     (:rocsparse_zsctr, :ComplexF64))
    @eval begin
        function sctr!(X::ROCSparseVector{$elty},
                       Y::ROCVector{$elty},
                       index::SparseChar)
            $fname(handle(), nnz(X), nonzeros(X), nonzeroinds(X), Y, index)
            Y
        end
        function sctr(X::ROCSparseVector{$elty},
                      index::SparseChar)
            sctr!(X, AMDGPU.zeros($elty, size(X)[1]),index)
        end
    end
end
