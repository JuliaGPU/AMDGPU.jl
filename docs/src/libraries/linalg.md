```@meta
DocTestSetup = quote
    using AMDGPU
    using LinearAlgebra
end
```

# Linear Algebra

Standard `LinearAlgebra` functions work directly on `ROCArray`, dispatching to AMD's [rocBLAS](https://github.com/ROCm/rocBLAS) (dense BLAS) and [rocSOLVER](https://github.com/ROCm/rocSOLVER) (LAPACK-style factorizations). You write ordinary Julia linear algebra; the GPU libraries are used automatically.

Supported out of the box on `ROCArray`:

- Matrix–matrix and matrix–vector products (`*`, `mul!`), including mixed- and low-precision (`Float16`) matmul.
- BLAS level-1 operations: `dot`, `norm`, `axpy!`, `axpby!`, `rmul!`.
- Triangular solves and `\` (linear systems, LU-based).
- Factorizations: `cholesky`, `lu`, `qr`, `svd`.

```jldoctest linalg
julia> A = ROCArray(Float32[4 1; 1 3]);

julia> b = ROCArray(Float32[1, 2]);

julia> x = A \ b;                       # solve, LU via rocSOLVER

julia> Array(A * x) ≈ Array(b)
true

julia> C = cholesky(A);                 # Cholesky factorization

julia> Array(C.U' * C.U) ≈ Array(A)
true
```

Element types follow rocBLAS/rocSOLVER: `Float32`, `Float64`, `ComplexF32`, and `ComplexF64` (with `Float16` also supported for matmul).

## Singular value decomposition

`svd`, `svd!`, and `svdvals` run on `ROCMatrix` via rocSOLVER. The `alg` keyword selects the backend — `JacobiAlgorithm()` (the default, usually fastest on AMD GPUs) or `QRAlgorithm()`:

```julia
using AMDGPU.rocSOLVER: JacobiAlgorithm, QRAlgorithm

F = svd(A)                              # Jacobi by default; F.U, F.S, F.Vt
s = svdvals(A)                          # singular values only
Ff = svd(A; full = true, alg = QRAlgorithm())
```

Because `svdvals` is supported, so is `cond`. (`opnorm(A, 2)` is not yet available — it relies on scalar indexing internal to `LinearAlgebra`.)

## Direct library access

Lower-level routines are available in the `AMDGPU.rocBLAS` and `AMDGPU.rocSOLVER` submodules for cases the generic interface does not cover — for example batched factorizations, or the raw `gesvd!` (QR) and `gesvdj!` (Jacobi) SVD kernels.
