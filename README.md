# AMDGPU.jl

*AMD GPU (ROCm) programming in Julia*

[![][doi-img]][doi-url] [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] [![][buildkite-img]][buildkite-url] [![][codecov-img]][codecov-url]

[doi-img]: https://zenodo.org/badge/DOI/10.5281/zenodo.10040461.svg
[doi-url]: https://doi.org/10.5281/zenodo.10040461

[buildkite-img]: https://badge.buildkite.com/b1b3b0e3d13add4aa5a64c866937fde364ad777813725ef887.svg?branch=master
[buildkite-url]: https://buildkite.com/julialang/amdgpu-dot-jl

[codecov-img]: https://codecov.io/gh/JuliaGPU/AMDGPU.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/JuliaGPU/AMDGPU.jl

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://amdgpu.juliagpu.org/stable

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://amdgpu.juliagpu.org/dev

## Requirements

The AMDGPU.jl package requires **Julia 1.9+**, **ROCm 5.3-5.7**, which means only GPUs that are supported by these versions will work.\
**64-bit Linux and Windows** are supported, see [requirements](https://amdgpu.juliagpu.org/dev/#Installation).
**Navi 3** GPUs require Julia 1.10 or higher.

## Quick start

AMDGPU.jl can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add AMDGPU
```

Or, equivalently, via the `Pkg` API:

```julia
julia> import Pkg; Pkg.add("AMDGPU")
```

## Questions and Contributions

Usage questions can be posted on the [Julia Discourse
forum](https://discourse.julialang.org/c/domain/gpu) under the GPU domain and/or in the #gpu
channel of the [Julia Slack](https://julialang.org/community/).

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue](https://github.com/JuliaGPU/AMDGPU.jl/issues) if you encounter any problems.

## Acknowledgment

AMDGPU would not have been possible without the work by Tim Besard and
contributors to [CUDA.jl](https://github.com/JuliaGPU/CUDA.jl) and
[LLVM.jl](https://github.com/maleadt/LLVM.jl).

## License

AMDGPU.jl is licensed under the [MIT License](LICENSE.md).
