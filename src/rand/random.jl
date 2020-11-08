# interfacing with Random standard library

using Random

using GPUArrays


mutable struct RNG <: Random.AbstractRNG
    handle::rocrand_generator
    typ::rocrand_rng_type

    function RNG(typ=ROCRAND_RNG_PSEUDO_DEFAULT)
        handle = Ref{rocrand_generator}()
        rocrand_create_generator(handle, typ)
        obj = new(handle[], typ)
        finalizer(unsafe_destroy!, obj)
        return obj
    end
end

function unsafe_destroy!(rng::RNG)
    rocrand_destroy_generator(rng.handle)
end

Base.unsafe_convert(::Type{rocrand_generator}, rng::RNG) = rng.handle


## seeding
function Random.seed!(rng::RNG, seed=Base.rand(UInt64), offset=0)
    rocrand_set_seed(rng, seed)
    rocrand_set_offset(rng, seed)
    rocrand_initialize_generator(rng)
    return
end

Random.seed!(rng::RNG, ::Nothing) = Random.seed!(rng)


## in-place

# uniform
const UniformType = Union{Type{UInt32}, Type{Cuchar}, Type{UInt16}, Type{Float16}, Type{Float32}, Type{Float64}}
const UniformArray = ROCArray{<:Union{UInt32, Cuchar, UInt16, Float16, Float32,Float64}}
for (f,T) in ((:rocrand_generate, :UInt32), (:rocrand_generate_char,:Cuchar),
              (:rocrand_generate_short, :UInt16), (:rocrand_generate_uniform, :Float32),
              (:rocrand_generate_uniform_double, :Float64), (:rocrand_generate_uniform_half, :Float16))
    @eval begin
        function Random.rand!(rng::RNG, A::ROCArray{$(T)})
            $(f)(rng, A, length(A))
            return A
        end
    end
end

# some functions need pow2 lengths: use a padded array and copy back to the original one
function inplace_pow2(A, f)
    len = length(A)
    if len > 1 && ispow2(len)
        f(A)
    else
        padlen = max(2, nextpow(2, len))
        B = similar(A, padlen)
        f(B)
        copyto!(A, 1, B, 1, len)
        # TODO: why is unsafe_free used in CUDA?
        # here it causes "Release of dead AMDGPU.Mem.Buffer" error
        #AMDGPU.unsafe_free!(B)
    end
    A
end

# normal
const NormalType = Union{Type{Float16}, Type{Float32}, Type{Float64}}
const NormalArray = ROCArray{<:Union{Float16, Float32,Float64}}
function Random.randn!(rng::RNG, A::ROCArray{Float32}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_normal(rng, B, length(B), mean, stddev))
    return A
end
function Random.randn!(rng::RNG, A::ROCArray{Float64}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_normal_double(rng, B, length(B), mean, stddev))
    return A
end
function Random.randn!(rng::RNG, A::ROCArray{Float16}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_normal_half(rng, B, length(B), mean, stddev))
    return A
end

# log-normal
const LognormalType = Union{Type{Float16}, Type{Float32},Type{Float64}}
const LognormalArray = ROCArray{<:Union{Float16, Float32, Float64}}
function rand_logn!(rng::RNG, A::ROCArray{Float32}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_log_normal(rng, B, length(B), mean, stddev))
    return A
end
function rand_logn!(rng::RNG, A::ROCArray{Float64}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_log_normal_double(rng, B, length(B), mean, stddev))
    return A
end
function rand_logn!(rng::RNG, A::ROCArray{Float16}; mean=0, stddev=1)
    inplace_pow2(A, B->rocrand_generate_log_normal_half(rng, B, length(B), mean, stddev))
    return A
end

# poisson
const PoissonType = Union{Type{Cuint}}
const PoissonArray = ROCArray{Cuint}
function rand_poisson!(rng::RNG, A::ROCArray{Cuint}; lambda=1)
    rocrand_generate_poisson(rng, A, length(A), lambda)
    return A
end

## out of place

# some functions need pow2 lengths: construct a compatible array and return part of it
function outofplace_pow2(shape, ctor, f)
    len = prod(shape)
    if ispow2(len)
        A = ctor(shape)
        f(A)
    else
        padlen = max(2, nextpow(2, len))
        A = ctor(padlen)
        f(A)
        B = reshape(A[1:len], shape)
        return B
    end
end

# arrays
Random.rand(rng::RNG, T::UniformType, dims::Dims) =
    Random.rand!(rng, ROCArray{T}(undef, dims))
Random.randn(rng::RNG, T::NormalType, dims::Dims; kwargs...) =
    outofplace_pow2(dims, shape->ROCArray{T}(undef, dims), A->randn!(rng, A; kwargs...))
rand_logn(rng::RNG, T::LognormalType, dims::Dims; kwargs...) =
    outofplace_pow2(dims, shape->ROCArray{T}(undef, dims), A->rand_logn!(rng, A; kwargs...))
rand_poisson(rng::RNG, T::PoissonType, dims::Dims; kwargs...) =
    rand_poisson!(rng, ROCArray{T}(undef, dims); kwargs...)

# specify default types
Random.rand(rng::RNG, dims::Dims; kwargs...) = Random.rand(rng, Float32, dims; kwargs...)
Random.randn(rng::RNG, dims::Dims; kwargs...) = Random.randn(rng, Float32, dims; kwargs...)
rand_logn(rng::RNG, dims::Dims; kwargs...) = rand_logn(rng, Float32, dims; kwargs...)
rand_poisson(rng::RNG, dims::Dims; kwargs...) = rand_poisson(rng, Cuint, dims; kwargs...)

# support all dimension specifications
Random.rand(rng::RNG, T::UniformType, dim1::Integer, dims::Integer...) =
    Random.rand(rng, T, Dims((dim1, dims...)))
Random.randn(rng::RNG, T::NormalType, dim1::Integer, dims::Integer...; kwargs...) =
    Random.randn(rng, T, Dims((dim1, dims...)); kwargs...)
rand_logn(rng::RNG, T::LognormalType, dim1::Integer, dims::Integer...; kwargs...) =
    rand_logn(rng, T, Dims((dim1, dims...)); kwargs...)
rand_poisson(rng::RNG, T::PoissonType, dim1::Integer, dims::Integer...; kwargs...) =
    rand_poisson(rng, T, Dims((dim1, dims...)); kwargs...)
