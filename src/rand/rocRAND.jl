module rocRAND

using ..HSA
using ..AMDGPU
using ..AMDGPU: librocrand, mark!, wait!

using CEnum

export rand_logn!, rand_poisson!, rand_logn, rand_poisson

include("librocrand_common.jl")
include("error.jl")
include("librocrand.jl")
function version()
    s = string(ROCRAND_VERSION)
    VersionNumber(join([string(s[1]), s[2:4], s[5:end]], '.'))
end

# stdlib Random integration
include("random.jl")

# TODO: implement thread local RNG like CUDA.jl
const ROCRAND_RNG = Ref{Union{Nothing,RNG}}(nothing)

function default_rng()
    if ROCRAND_RNG[] == nothing
        ROCRAND_RNG[] = RNG()
        Random.seed!(ROCRAND_RNG[])
    end
    return ROCRAND_RNG[]::RNG
end


end
