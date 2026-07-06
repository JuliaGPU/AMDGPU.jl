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

Incomplete-factorization preconditioners (`ic0`, `ilu0`) and further sparse routines (conversions between formats, triangular solves, gather/scatter) are available in the `AMDGPU.rocSPARSE` submodule for building iterative solvers on the GPU.
