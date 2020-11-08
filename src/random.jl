# random functions that dispatch either to rocRAND or GPUArrays' generic RNG

using Random

export rand_logn!, rand_poisson!

# the interface is split in two levels:
# - functions that extend the Random standard library, and take an RNG as first argument,
#   will only ever dispatch to rocRAND and as a result are limited in the types they support.
# - functions that take an array will dispatch to either rocRAND or GPUArrays
# - non-exported functions are provided for constructing GPU arrays from only an eltype

const rocrand_rng = rocRAND.default_rng
gpuarrays_rng() = GPUArrays.default_rng(ROCArray)

function seed!(seed=Base.rand(UInt64))
    Random.seed!(rocrand_rng(), seed)
    Random.seed!(gpuarrays_rng(), seed)
end

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

# GPUArrays in-place
Random.rand!(A::ROCArray) = Random.rand!(gpuarrays_rng(), A)
Random.randn!(A::ROCArray; kwargs...) =
    error("AMDGPU.jl does not support generating normally-distributed random numbers of type $(eltype(A))")
# FIXME: GPUArrays.jl has a randn! nowadays, but it doesn't work with e.g. Cuint
rand_logn!(A::ROCArray; kwargs...) =
    error("AMDGPU.jl does not support generating lognormally-distributed random numbers of type $(eltype(A))")
rand_poisson!(A::ROCArray; kwargs...) =
    error("AMDGPU.jl does not support generating Poisson-distributed random numbers of type $(eltype(A))")

# GPUArrays out-of-place
rand(T::Type, dims::Dims) = Random.rand!(ROCArray{T}(undef, dims...))
randn(T::Type, dims::Dims; kwargs...) = Random.randn!(ROCArray{T}(undef, dims...); kwargs...)
rand_logn(T::Type, dims::Dims; kwargs...) = rand_logn!(ROCArray{T}(undef, dims...); kwargs...)
rand_poisson(T::Type, dims::Dims; kwargs...) = rand_poisson!(ROCArray{T}(undef, dims...); kwargs...)

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
