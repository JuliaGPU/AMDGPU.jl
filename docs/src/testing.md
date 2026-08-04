# Testing

To ensure that everything is working you can run tests for the package with:

```julia
pkg> test AMDGPU
```

## Advanced testing options

AMDGPU tests use [ParallelTestRunner.jl](https://juliatesting.github.io/ParallelTestRunner.jl) which allow for [running tests with various (command line) options](https://juliatesting.github.io/ParallelTestRunner.jl/dev/#Running-Tests) and on multiple runners in parallel.

To, e.g., launch a subset of tests `core` and `kernelabstractions` on 4 runners in parallel:

```julia
julia> using Pkg

julia> Pkg.test("AMDGPU"; test_args=`--jobs=4 core kernelabstractions`)
```

The full list of tests to run can be obtained with `--list` argument:

```julia
julia> Pkg.test("AMDGPU"; test_args=`--list`)
```

## Testing categories

Although tests can be run in a custom fashion upon exploring the output of listing (using the `--list` test argument), tests are organised such that grouping by relevant categories is possible:

```
core device hip external gpuarrays kernelabstractions wmma enzyme
```

which allows to, e.g., run all `gpuarrays` related tests as:

```julia
julia> Pkg.test("AMDGPU"; test_args=`gpuarrays`)
```

!!! warning "Large memory tests"
    Some tests such as HIP and GPUArrays tests may use > 20GB of host RAM. It is recommended to use fewer workers (<= 4) on machines that have < 32Gb of host RAM in case running tests would result in out of memory errors.

## Building the documentation

The documentation is built with [Documenter.jl](https://documenter.juliadocs.org) and [DocumenterVitepress.jl](https://github.com/LuxDL/DocumenterVitepress.jl). To build it locally:

```
julia --project=docs -e 'using Pkg; Pkg.instantiate()'
julia --project=docs docs/make.jl
julia --project=docs -e 'using LiveServer; serve(dir="docs/build/1")'
```

The last command serves the built site locally; open the printed URL in a browser.

!!! note "Doctests need a GPU"
    `make.jl` runs with `doctest=true`, so every block opening with

    ````
    ```jldoctest
    ````

    is executed on a real device. Building the docs therefore requires a functional AMD GPU, and a clean build means all examples still produce their documented output. When writing examples, prefer showing `Array(x)` rather than a raw `ROCArray` so the output does not depend on internal buffer types.
