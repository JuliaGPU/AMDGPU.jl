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

### Checking solver results

rocSOLVER writes the status of a routine (LAPACK's `info`) to device memory. `gesvd!`, `gesvdj!`, `syevd!`/`heevd!`, `sygvd!`/`hegvd!` and `geblttrf!` read it after the call, which synchronizes the stream, and throw as LinearAlgebra's LAPACK wrappers do: an `ArgumentError` for an invalid argument, a `LAPACKException` when the routine did not converge, a `PosDefException` when the `B` of a generalized eigenproblem is not positive definite.

With `check = false` the status is not read: the wrapper does not synchronize, a failure goes unreported, and the results are then garbage (`gesvdj!` returns `residual`, `n_sweeps` and `info` as device arrays). rocSOLVER routines also synchronize internally (in ROCm 7.2.3 `gesvd` and `syevd` always, `gesvdj` beyond a few dozen rows), so only small Jacobi SVDs actually run ahead of the host. The wrappers that return `info` (`potrf!`, `getrf!`, `sytrf!`, the batched factorizations) always read it.

```@docs
AMDGPU.rocSOLVER.check_info
AMDGPU.rocSOLVER.gesvd!
AMDGPU.rocSOLVER.gesvdj!
```

### Device-side scalars

The scalar arguments of the `rocBLAS` wrappers (e.g. `alpha` and `beta`) can reside on the device, so that they don't need to be known on the host when an operation is enqueued — for example because a previous operation computed them. Pass an [`AMDGPU.ROCRef`](@ref), or a one-element `ROCArray`; scalars on the host can still be passed as numbers, and the two can be mixed (host-side scalars are then written to the device, which is ordered on the stream without synchronizing). Routines that return a scalar (`dot`, `dotc`, `dotu`, `nrm2`, `asum`) accept an extra argument to write the result into, which avoids synchronizing with the host when it is a device-side scalar:

```julia
x, y = AMDGPU.rand(Float32, 1024), AMDGPU.rand(Float32, 1024)

d = ROCRef{Float32}()
rocBLAS.dot(length(x), x, 1, y, 1, d)  # d = x ⋅ y, without synchronizing
rocBLAS.scal!(length(x), d, x, 1)      # x .*= d
d[]                                    # copy to the host
```

`ROCRef(A, i)` refers to element `i` of the array `A`, without copying it.

The Givens rotation routines `rotg!` and `rotmg!` overwrite their scalar arguments, so these can't be copied between the host and the device: either pass them all as host `Ref`s, or all on the device. That makes it possible to construct a rotation on the device and apply it with `rot!` or `rotm!` without synchronizing. `rotg(a, b)` and `rotmg(d1, d2, x1, y1)` compute a rotation from host values instead.

```@docs
AMDGPU.ROCRef
```
