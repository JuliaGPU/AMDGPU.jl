module rocRAND

using ..HSA
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
const ROCRAND_RNG = Ref{Union{Nothing,RNG}}(nothing)
const GPUARRAY_RNG = Ref{Union{Nothing,GPUArrays.RNG}}(nothing)

function default_rng()
    if ROCRAND_RNG[] == nothing
        ROCRAND_RNG[] = RNG()
    end
    return ROCRAND_RNG[]::RNG
end

function GPUArrays.default_rng(::Type{<:ROCArray})
    if GPUARRAY_RNG[] == nothing
        agent = AMDGPU.default_device().device.agent
        p = Ref{UInt32}()
        AMDGPU.getinfo(agent, HSA.AGENT_INFO_WORKGROUP_MAX_SIZE, p) |> AMDGPU.check
        N = Int(p[])
        state = ROCArray{NTuple{4, UInt32}}(undef, N)
        GPUARRAY_RNG[] = GPUArrays.RNG(state)
    end
    return GPUARRAY_RNG[]::GPUArrays.RNG
end

end
