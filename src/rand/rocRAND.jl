module rocRAND

import ..AMDGPU
import .AMDGPU: ROCArray, HandleCache, librocrand, mark!, wait!
import ..HSA
import ..HIP
import .HIP: HIPContext, HIPStream, hipStream_t

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

# Copied from CUDA.jl/lib/curand/CURAND.jl

# cache for created, but unused handles
const idle_rngs = HandleCache{HIPContext,RNG}()

function default_rng()
    tls = AMDGPU.task_local_state()

    # every task maintains library state per device
    LibraryState = @NamedTuple{rng::RNG}
    states = get!(task_local_storage(), :rocRAND) do
        Dict{HIPContext,LibraryState}()
    end::Dict{HIPContext,LibraryState}

    # get library state
    @noinline function new_state(tls)
        new_rng = pop!(idle_rngs, tls.context) do
            RNG()
        end

        finalizer(current_task()) do task
            push!(idle_rngs, tls.context, new_rng) do
                # no need to do anything, as the RNG is collected by its finalizer
            end
        end

        Random.seed!(new_rng)

        rocrand_set_stream(new_rng.handle, tls.stream)

        (; rng=new_rng)
    end
    state = get!(states, tls.context) do
        new_state(tls)
    end

    return state.rng
end

end
