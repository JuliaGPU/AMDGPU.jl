# random functions that dispatch either to rocRAND or GPUArrays' generic RNG

using Random

const GPUARRAY_RNG = Ref{Union{Nothing,GPUArrays.RNG}}(nothing)

function GPUArrays.default_rng(::Type{<:ROCArray})
    if GPUARRAY_RNG[] == nothing
        device = AMDGPU.device()
        N = Int(Runtime.device_workgroup_max_size(device))
        state = ROCArray{NTuple{4, UInt32}}(undef, N)
        GPUARRAY_RNG[] = GPUArrays.RNG(state)
        Random.seed!(GPUARRAY_RNG[])
    end
    return GPUARRAY_RNG[]::GPUArrays.RNG
end

gpuarrays_rng() = GPUArrays.default_rng(ROCArray)
const rocrand_rng = librocrand !== nothing ? rocRAND.handle : gpuarrays_rng

# the interface is split in two levels:
# - functions that extend the Random standard library, and take an RNG as first argument,
#   will only ever dispatch to rocRAND and as a result are limited in the types they support.
# - functions that take an array will dispatch to either rocRAND or GPUArrays
# - non-exported functions are provided for constructing GPU arrays from only an eltype

# these types are supported by rocrand and we use rocrand whenever possible
const rocRANDUniformType = Union{Type{UInt32}, Type{Cuchar}, Type{UInt16}, Type{Float16}, Type{Float32}, Type{Float64}}
const rocRANDUniformArray = ROCArray{<:Union{UInt32, Cuchar, UInt16, Float16, Float32,Float64}}
const rocRANDNormalType = Union{Type{Float16}, Type{Float32}, Type{Float64}}
const rocRANDNormalArray = ROCArray{<:Union{Float16, Float32,Float64}}

function seed!(seed=Base.rand(UInt64))
    Random.seed!(rocrand_rng(), seed)
    Random.seed!(gpuarrays_rng(), seed)
end

# rocRAND in-place
Random.rand!(A::rocRANDUniformArray) = Random.rand!(rocrand_rng(), A)
Random.randn!(A::rocRANDNormalArray; kwargs...) = Random.randn!(rocrand_rng(), A; kwargs...)

# rocRAND out-of-place
rand(T::rocRANDUniformType, dims::Dims) = Random.rand(rocrand_rng(), T, dims)
randn(T::rocRANDNormalType, dims::Dims; kwargs...) = Random.randn(rocrand_rng(), T, dims; kwargs...)

# support all dimension specifications
rand(T::rocRANDUniformType, dim1::Integer, dims::Integer...) =
    Random.rand(rocrand_rng(), T, Dims((dim1, dims...)))
randn(T::rocRANDNormalType, dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn(rocrand_rng(), T, Dims((dim1, dims...)); kwargs...)

# GPUArrays in-place
Random.rand!(A::ROCArray) = Random.rand!(gpuarrays_rng(), A)
Random.randn!(A::ROCArray; kwargs...) =
    error("AMDGPU.jl does not support generating normally-distributed random numbers of type $(eltype(A))")

# GPUArrays out-of-place
rand(T::Type, dims::Dims) = Random.rand!(ROCArray{T}(undef, dims...))
randn(T::Type, dims::Dims; kwargs...) = Random.randn!(ROCArray{T}(undef, dims...); kwargs...)

# support all dimension specifications
rand(T::Type, dim1::Integer, dims::Integer...) =
    Random.rand!(ROCArray{T}(undef, dim1, dims...))
randn(T::Type, dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn!(ROCArray{T}(undef, dim1, dims...); kwargs...)

# untyped out-of-place
rand(dim1::Integer, dims::Integer...) =
    #Random.rand(rocrand_rng(), Dims((dim1, dims...)))
    Random.rand!(ROCArray{Float32}(undef, dim1, dims...))
randn(dim1::Integer, dims::Integer...; kwargs...) =
    #Random.randn(rocrand_rng(), Dims((dim1, dims...)); kwargs...)
    Random.randn!(ROCArray{Float32}(undef, dim1, dims...))

# rand_logn, rand_poisson
const rand_logn = librocrand !== nothing ? rocRAND.rand_logn : (x...;kwargs...) -> error("Not supported without rocRAND.")
const rand_poisson = librocrand !== nothing ? rocRAND.rand_poisson : (x...;kwargs...) -> error("Not supported without rocRAND.")
