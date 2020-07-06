# AMDGPU.jl

*AMD GPU (ROCm) programming in Julia*

| **Documentation**                                                       | **Build Status**                                              |
|:---------------------------------------:|:-------------------------------------------------------------:|
| [![][docs-master-img]][docs-master-url] | [![][gitlab-img]][gitlab-url] [![][codecov-img]][codecov-url] |

[gitlab-img]: https://gitlab.com/JuliaGPU/AMDGPU.jl/badges/master/pipeline.svg
[gitlab-url]: https://gitlab.com/JuliaGPU/AMDGPU.jl/commits/master

[codecov-img]: https://codecov.io/gh/JuliaGPU/AMDGPU.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/JuliaGPU/AMDGPU.jl

[docs-master-img]: https://img.shields.io/badge/docs-master-blue.svg
[docs-master-url]: https://juliagpu.gitlab.io/AMDGPU.jl/



## Quick start

The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add AMDGPU
```

Or, equivalently, via the `Pkg` API:

```julia
julia> import Pkg; Pkg.add("AMDGPU")
```


## Project Status

The package is tested against, and being developed for, Julia `1.4` and above.
Only 64-bit Linux is supported and working at this time, until ROCm is ported
to other platforms. It is recommended to use a version of Julia with LLVM 9.0
or higher.  This package is under active maintenance and is reasonably
complete, however not all features (and especially performance) are up to par
with CUDA.jl.

### Supported Functionality

| Feature | Supported | Notes |
|:---|:---:|:---|
| Host-side kernel launches | :heavy_check_mark: | See #58 |
| Dynamic parallelism | :x: |
| Local (shared) memory | :heavy_check_mark: |
| Coarse-grained memory | :heavy_check_mark: |
| Page-locked (pinned) memory | :x: |

## Questions and Contributions

Usage questions can be posted on the [Julia Discourse
forum](https://discourse.julialang.org/c/domain/gpu) under the GPU domain and/or in the #gpu
channel of the [Julia Slack](https://julialang.org/community/).

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue](https://github.com/JuliaGPU/AMDGPU.jl/issues) if you encounter any problems.

## Acknowledgment

AMDGPU would not have been possible without the work by Tim Besard and
contributors to [CUDAnative.jl](https://github.com/JuliaGPU/CUDAnative.jl) and
[LLVM.jl](https://github.com/maleadt/LLVM.jl).

## License

AMDGPU.jl is licensed under the [MIT License](LICENSE.md).
