module HSARuntime

# copied from CUDAdrv/src/CUDAdrv.jl
const ext = joinpath(dirname(@__DIR__), "deps", "ext.jl")
isfile(ext) || error("HSARuntime.jl has not been built, please run Pkg.build(\"HSARuntime\").")
include(ext)
if !configured
    # default (non-functional) values for critical variables,
    # making it possible to _load_ the package at all times.
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end

atexit() do
    configured && HSA.shut_down()
end

### Imports ###

using CEnum
using Setfield
using Libdl

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, profile, get_first_isa, launch!
export get_default_agent, get_default_queue

### HSA Runtime Wrapper ###

include(joinpath(@__DIR__, "HSA", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

include("extras.jl")
include("error.jl")
include("agent.jl")
include("queue.jl")
include("signal.jl")
include("executable.jl")
include("kernel.jl")
include("memory.jl")
include("array.jl")

function __init__()
    # We want to always be able to load the package, regardless of
    # whether HSA libraries are found
    configured || return

    # Make sure we load the library found by the last `] build`
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
    # TODO: Do the same (if possible) for the debug library

    HSA.init() |> check

    agents = get_agents(:gpu)
    if length(agents) > 0
        DEFAULT_AGENT[] = first(agents)
    end
end

end
