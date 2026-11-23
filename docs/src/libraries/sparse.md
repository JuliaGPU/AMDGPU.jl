# Sparse Arrays

AMDGPU.jl wraps AMD's [rocSPARSE](https://github.com/ROCm/rocSPARSE) and stores sparse matrices on the device with the `AMDGPU.rocSPARSE` array types:

- `ROCSparseMatrixCSR` — compressed sparse row (the usual default for GPU work).
- `ROCSparseMatrixCSC` — compressed sparse column.
- `ROCSparseMatrixCOO` — coordinate format.
- `ROCSparseVector` — sparse vector.

Construct them by converting a host `SparseMatrixCSC`, and convert back the same way:

```julia
using AMDGPU, SparseArrays
using AMDGPU.rocSPARSE

S  = sprand(Float32, 1000, 1000, 0.01)
dS = ROCSparseMatrixCSR(S)        # upload to the GPU

SparseMatrixCSC(dS)               # download back to the host
```

## Operations

Sparse matrix–vector (SpMV) and matrix–matrix (SpMM) products use the standard `*` operator:

```julia
x = AMDGPU.rand(Float32, 1000)
y = dS * x                        # SpMV

B = AMDGPU.rand(Float32, 1000, 8)
Y = dS * B                        # SpMM
```

rocSPARSE has no symmetric or Hermitian products, so a product with a `Symmetric` or `Hermitian` wrapper first materializes the full matrix on the device. That copy is made on every product; code that multiplies by the same wrapped matrix repeatedly should build it once with `sparse(Symmetric(dS))` and reuse the result.

The first product with a CSR, CSC or COO matrix analyzes its sparsity pattern, and the matrix keeps the result, so later products with the same matrix skip that step. Assigning to a field of the matrix or calling `copyto!` on it discards the stored analyses. Code that writes new indices into the existing index arrays, such as `dS.colVal .= ...`, has to call `rocSPARSE.reset_analysis_cache!(dS)` afterwards; changing only the values in `nonzeros(dS)` needs nothing.

Incomplete-factorization preconditioners (`ic0`, `ilu0`) and further sparse routines (conversions between formats, triangular solves, gather/scatter) are available in the `AMDGPU.rocSPARSE` submodule for building iterative solvers on the GPU.
