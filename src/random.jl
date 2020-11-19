# random interface, that does not use rocrand

using Random

export rand_logn!, rand_poisson!

# TODO: implement thread local RNG like CUDA.jl
const GPUARRAY_RNG = Ref{Union{Nothing,GPUArrays.RNG}}(nothing)

function GPUArrays.default_rng(::Type{<:ROCArray})
    if GPUARRAY_RNG[] == nothing
        agent = default_device().device.agent
        p = Ref{UInt32}()
        GC.@preserve p begin
            getinfo(agent, HSA.AGENT_INFO_WORKGROUP_MAX_SIZE, p) |> check
            N = Int(p[])
        end
        state = ROCArray{NTuple{4, UInt32}}(undef, N)
        GPUARRAY_RNG[] = GPUArrays.RNG(state)
        Random.seed!(GPUARRAY_RNG[])
    end
    return GPUARRAY_RNG[]::GPUArrays.RNG
end

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
