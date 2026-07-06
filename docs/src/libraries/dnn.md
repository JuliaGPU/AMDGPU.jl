# Deep Learning (MIOpen)

AMDGPU.jl exposes AMD's [MIOpen](https://github.com/ROCm/MIOpen) deep-learning primitives through the `AMDGPU.MIOpen` submodule: convolutions, pooling, softmax, batch normalization, and activation functions, all operating on `ROCArray`.

In practice you rarely call these directly. They back the GPU implementations used by [NNlib.jl](https://github.com/FluxML/NNlib.jl) and [Flux.jl](https://github.com/FluxML/Flux.jl), so building and training a model on an AMD GPU with Flux uses MIOpen automatically once your data and parameters are `ROCArray`s.

Check that MIOpen is available with:

```julia
using AMDGPU
AMDGPU.functional(:MIOpen)
```

If it reports `false`, install the MIOpen ROCm package for your platform (see [Installation Info](@ref)).
```
