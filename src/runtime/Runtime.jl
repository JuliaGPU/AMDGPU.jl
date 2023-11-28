module Runtime

using ..CEnum
using ..GPUCompiler

import ..Adapt
import Preferences: @load_preference, @set_preferences!

import ..HSA
import ..HIP
import ..AMDGPU
import ..AMDGPU: getinfo, LockedObject
import .HIP: HIPDevice

struct Adaptor end

const RT_LOCK = Threads.ReentrantLock()
const RT_EXITING = Ref{Bool}(false)

include("error.jl")
include("dims.jl")

module Mem
    using Preferences

    import AMDGPU
    import AMDGPU: HIP, HSA, Runtime
    import .HIP: HIPDevice, HIPContext
    import .Runtime: ROCDim, ROCDim3

    abstract type AbstractAMDBuffer end

    include(joinpath("memory", "utils.jl"))
    include(joinpath("memory", "hip.jl"))
end

include("execution.jl")
include("hip-execution.jl")

end
