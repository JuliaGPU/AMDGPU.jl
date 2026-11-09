# Random Numbers

AMDGPU.jl generates random numbers on the device through AMD's [rocRAND](https://github.com/ROCm/rocRAND). The quickest way to get a random `ROCArray` is the package-level `rand`/`randn`, which mirror `Base`:

```julia
using AMDGPU

AMDGPU.rand(Float32, 1024)        # uniform in [0, 1)
AMDGPU.randn(Float32, 8, 8)       # standard normal
AMDGPU.rand(Int32, 100)           # uniform integers
```

The standard `Random` in-place interface works on existing `ROCArray`s and fills them on the GPU:

```julia
using Random

a = ROCArray{Float32}(undef, 1024)
Random.rand!(a)
Random.randn!(a)
```

rocRAND handles `rand!` for `UInt8`, `UInt16`, `UInt32`, `Float16`, `Float32` and `Float64`, and `randn!` for the three float types. Every other element type goes to the kernel-based GPUArrays generator instead: `rand!` accepts any `isbits` type `Random` can sample, such as `Int32`, tuples, or structs with a custom sampler, and `randn!` accepts any float or complex float type, such as `ComplexF32`. The `mean` and `stddev` keywords of `randn!` work on both paths.

## Seeding

Seed the device generators for reproducible results with `AMDGPU.seed!`:

```julia
AMDGPU.seed!(1234)
```

This seeds both the rocRAND generator (used by `AMDGPU.rand`/`randn`) and the GPUArrays fallback generator, so results are reproducible regardless of which path a given operation takes.
