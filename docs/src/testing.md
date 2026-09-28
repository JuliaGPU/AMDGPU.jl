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

## Continuous integration

Pull requests are tested on [Buildkite](https://buildkite.com/julialang/amdgpu-dot-jl), and by external CI providers. The step selection below applies to Buildkite only.

### Draft pull requests

To save CI time, draft pull requests are only tested on the newest Julia release and on nightly. The other steps (older Julia releases, Enzyme, the GPU-less environment, the documentation and the benchmarks) run once the pull request is marked ready for review.

!!! warning "Marking a pull request ready does not start a build"
    Buildkite does not start a new build when a draft is marked ready for review. Push a new commit afterwards to run the remaining steps, otherwise the pull request can show a green status with only the newest release and nightly tested. An empty commit is enough:

    ```
    git commit --allow-empty -m "Run full CI"
    git push
    ```

### Selecting steps

Tags in the message of the most recently pushed commit select which steps run: `[only X]` runs only the listed steps, and `[skip X]` skips them, where `X` is a comma-separated list of:

| Tag          | Steps                                                      |
|:-------------|:-----------------------------------------------------------|
| `tests`      | all tests, i.e. `julia`, `nightly`, `enzyme` and `special` |
| `julia`      | tests on released Julia versions                           |
| `nightly`    | tests on Julia nightly                                     |
| `enzyme`     | Enzyme tests                                               |
| `special`    | tests in a GPU-less environment                            |
| `docs`       | documentation build                                        |
| `benchmarks` | benchmarks                                                 |

For example, `[only nightly]` runs only the nightly tests, and `[skip enzyme, docs]` runs everything but Enzyme and the documentation. Selecting steps with `[only X]` also lifts the draft restriction, so `[only tests, docs]` tests a draft pull request like a ready one, minus the benchmarks.

Tags are matched anywhere in the message, so quoting one, e.g. when describing a CI change, applies it too. Squash and merge commits on `main` carry the pull request title, so a tag in the title also applies to the build on `main`. [GPUCompiler.jl](https://github.com/JuliaGPU/GPUCompiler.jl) uses the same tags.
