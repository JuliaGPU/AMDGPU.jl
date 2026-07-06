```@meta
DocTestSetup = quote
    using AMDGPU
end
```

# Array Programming

The `ROCArray` type is the core of AMDGPU.jl. It is a dense, GPU-resident array that implements Julia's `AbstractArray` interface, so most array code written for `Array` works on the GPU with little or no change. This is the recommended, high-level way to use AMDGPU.jl — you rarely need to write kernels by hand.

## Construction

Copy an existing array to the device by wrapping it in a `ROCArray`, or build one directly on the device with the familiar constructors:

```jldoctest arrays
julia> ROCArray([1, 2, 3, 4]) |> Array   # move host array to device (shown via Array)
4-element Vector{Int64}:
 1
 2
 3
 4

julia> AMDGPU.ones(Float32, 2, 2) |> Array
2×2 Matrix{Float32}:
 1.0  1.0
 1.0  1.0
```

The device-side constructors mirror `Base`: `AMDGPU.zeros`, `AMDGPU.ones`, `AMDGPU.fill`, `AMDGPU.rand`, `AMDGPU.randn`, and `similar`. All take an optional element type and dimensions.

## Host ↔ device transfer

Wrapping a host array in `ROCArray` copies it to the GPU; calling `Array` on a `ROCArray` copies it back:

```jldoctest arrays
julia> a = ROCArray(Float32[1, 2, 3]);

julia> Array(a)
3-element Vector{Float32}:
 1.0
 2.0
 3.0
```

Transfers are relatively expensive — keep data on the device across as many operations as possible rather than copying back and forth.

## Broadcasting

Broadcasting works exactly as on the CPU and fuses into a single kernel, so chained element-wise operations do not allocate intermediate arrays:

```jldoctest arrays
julia> x = ROCArray(Float32[1, 2, 3]);

julia> y = ROCArray(Float32[10, 20, 30]);

julia> Array(@. 2x + y)
3-element Vector{Float32}:
 12.0
 24.0
 36.0
```

## Reductions, scans and sorting

Reductions (`sum`, `prod`, `maximum`, `mapreduce`, …), scans (`cumsum`, `accumulate`), `sort`/`sortperm`, and `reverse` all run on the GPU:

```jldoctest arrays
julia> sum(ROCArray(1:100))
5050

julia> mapreduce(x -> x^2, +, ROCArray(1:4))
30

julia> Array(cumsum(ROCArray([1, 2, 3, 4])))
4-element Vector{Int64}:
  1
  3
  6
 10

julia> Array(sort(ROCArray([3, 1, 2, 5, 4])))
5-element Vector{Int64}:
 1
 2
 3
 4
 5
```

## Scalar indexing

Reading or writing a single element from the host (`a[i]`) would require a separate GPU transfer per element, which is catastrophically slow. AMDGPU.jl therefore *disallows* scalar indexing by default and throws an error:

```julia
julia> a = ROCArray([1, 2, 3]);

julia> a[1]
ERROR: Scalar indexing is disallowed.
```

If you genuinely need it (e.g. in a one-off test), opt in explicitly:

```julia
AMDGPU.allowscalar(true)              # globally (discouraged)
AMDGPU.@allowscalar a[1]              # for a single expression (preferred)
```

Prefer vectorized operations, broadcasting, or a custom kernel instead. See [Kernel Programming](@ref) for writing your own kernels.

## Views and reshaping

`view`, `reshape`, `reinterpret`, and adjoint/transpose all work and return lazy wrappers that share the parent's memory — no copy is made:

```jldoctest arrays
julia> a = ROCArray(reshape(1:6, 2, 3));

julia> Array(view(a, :, 2))
2-element Vector{Int64}:
 3
 4
```

## Linear algebra

Matrix multiplication and factorizations dispatch to the vendor libraries (rocBLAS, rocSOLVER). Standard `LinearAlgebra` functions — `*`, `mul!`, `\`, `cholesky`, `lu`, `qr` — work directly on `ROCArray`. See [Linear Algebra](@ref) for the list of accelerated operations.
