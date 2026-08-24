module Runtime

using ..CEnum
using ..GPUCompiler
import ..LLVM

import ..Adapt
import Preferences: @load_preference, @set_preferences!

import ..HSA
import ..HIP
import ..AMDGPU
import ..AMDGPU: LockedObject
import .HIP: HIPDevice

# Carries the launching stream so that argument conversion can transfer
# buffer ownership inline (`take_ownership_fast!`); `nothing` skips ownership
# handling (bare `rocconvert` for reflection/type computation).
struct Adaptor{S}
    stream::S
end

const RT_LOCK = Threads.ReentrantLock()
const RT_EXITING = Ref{Bool}(false)

include("error.jl")
include("dims.jl")

module Mem
    using Preferences

    import AMDGPU
    import AMDGPU: HIP, Runtime
    import .HIP: HIPDevice, HIPContext
    import .Runtime: ROCDim, ROCDim3

    abstract type AbstractAMDBuffer end

    include(joinpath("memory", "utils.jl"))
    include(joinpath("memory", "hip.jl"))
end

include("execution.jl")
include("hip-execution.jl")

end
