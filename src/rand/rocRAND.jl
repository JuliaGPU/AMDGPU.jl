module rocRAND

import ..AMDGPU
import .AMDGPU: ROCArray, HandleCache, librocrand, library_state
import ..HIP
import .HIP: HIPContext, HIPStream, hipStream_t

using CEnum
using GPUArrays
using Random

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

const IDLE_RNGS = HandleCache{HIPContext, RNG}()

lib_state() = library_state(
    :rocRAND, RNG, IDLE_RNGS,
    () -> RNG(), r -> return, # RNG destroys itself in finalizer.
    (nh, s) -> begin
        Random.seed!(nh)
        rocrand_set_stream(nh.handle, s)
    end)

handle() = lib_state().handle
stream() = lib_state().stream

end
