module rocRAND

using ..AMDGPU
using ..AMDGPU: librocrand

using CEnum


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
const _generator = Ref{Union{Nothing,RNG}}(nothing)

function default_rng()
    if _generator[] == nothing
        _generator[] = RNG()
    end
    return _generator[]::RNG
end

function GPUArrays.default_rng()
    if _generator[] == nothing
        _generator[] = RNG()
    end
    return _generator[]::RNG
end

end
