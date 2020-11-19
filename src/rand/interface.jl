# random functions that dispatch either to rocRAND or GPUArrays' generic RNG

using Random

export rand_logn!, rand_poisson!


# rocRAND in-place
Random.rand!(A::rocRAND.UniformArray) = Random.rand!(rocrand_rng(), A)
Random.randn!(A::rocRAND.NormalArray; kwargs...) = Random.randn!(rocrand_rng(), A; kwargs...)
rand_logn!(A::rocRAND.LognormalArray; kwargs...) = rocRAND.rand_logn!(rocrand_rng(), A; kwargs...)
rand_poisson!(A::rocRAND.PoissonArray; kwargs...) = rocRAND.rand_poisson!(rocrand_rng(), A; kwargs...)

# rocRAND out-of-place
rand(T::rocRAND.UniformType, dims::Dims) = Random.rand(rocrand_rng(), T, dims)
randn(T::rocRAND.NormalType, dims::Dims; kwargs...) = Random.randn(rocrand_rng(), T, dims; kwargs...)
rand_logn(T::rocRAND.LognormalType, dims::Dims; kwargs...) = rocRAND.rand_logn(rocrand_rng(), T, dims; kwargs...)
rand_poisson(T::rocRAND.PoissonType, dims::Dims; kwargs...) = rocRAND.rand_poisson(rocrand_rng(), T, dims; kwargs...)

# support all dimension specifications
rand(T::rocRAND.UniformType, dim1::Integer, dims::Integer...) =
    Random.rand(rocrand_rng(), T, Dims((dim1, dims...)))
randn(T::rocRAND.NormalType, dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn(rocrand_rng(), T, Dims((dim1, dims...)); kwargs...)
rand_logn(T::rocRAND.LognormalType, dim1::Integer, dims::Integer...; kwargs...) =
    rocRAND.rand_logn(rocrand_rng(), T, Dims((dim1, dims...)); kwargs...)
rand_poisson(T::rocRAND.PoissonType, dim1::Integer, dims::Integer...; kwargs...) =
    rocRAND.rand_poisson(rocrand_rng(), T, Dims((dim1, dims...)); kwargs...)

# support all dimension specifications
rand(T::Type, dim1::Integer, dims::Integer...) =
    Random.rand!(ROCArray{T}(undef, dim1, dims...))
randn(T::Type, dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn!(ROCArray{T}(undef, dim1, dims...); kwargs...)
rand_logn(T::Type, dim1::Integer, dims::Integer...; kwargs...) =
    rand_logn!(ROCArray{T}(undef, dim1, dims...); kwargs...)
rand_poisson(T::Type, dim1::Integer, dims::Integer...; kwargs...) =
    rand_poisson!(ROCArray{T}(undef, dim1, dims...); kwargs...)

# untyped out-of-place
rand(dim1::Integer, dims::Integer...) =
    Random.rand(rocrand_rng(), Dims((dim1, dims...)))
randn(dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn(rocrand_rng(), Dims((dim1, dims...)); kwargs...)
rand_logn(dim1::Integer, dims::Integer...; kwargs...) =
    rocRAND.rand_logn(rocrand_rng(), Dims((dim1, dims...)); kwargs...)
rand_poisson(dim1::Integer, dims::Integer...; kwargs...) =
    rocRAND.rand_poisson(rocrand_rng(), Dims((dim1, dims...)); kwargs...)
