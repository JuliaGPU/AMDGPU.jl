module rocRAND

import ..AMDGPU
import .AMDGPU: ROCArray, HandleCache, library_state
import AMDGPU: librocrand
import ..HIP
import .HIP: HIPContext, HIPStream, hipStream_t

using CEnum
using GPUArrays
using Random

export rand_logn!, rand_poisson!, rand_logn, rand_poisson

const half = Float16
include("error.jl")
include("librocrand.jl")

function version()
    # Query the loaded library at runtime rather than reporting the compile-time
    # `ROCRAND_VERSION` constant, so `versioninfo` shows the installed version.
    v = Ref{Cint}()
    rocrand_get_version(v)
    ver = Int(v[])
    VersionNumber(ver ÷ 100_000, (ver ÷ 100) % 1000, ver % 100)
end

# stdlib Random integration
include("random.jl")

const IDLE_RNGS = HandleCache{HIPContext, RNG}()

lib_state() = library_state(
    :rocRAND, RNG, IDLE_RNGS,
    () -> RNG(), r -> return, # RNG destroys itself in finalizer.
    (nh, s) -> begin
        rocrand_set_stream(nh.handle, s)
        Random.seed!(nh)
    end)

handle() = lib_state().handle
stream() = lib_state().stream

end
