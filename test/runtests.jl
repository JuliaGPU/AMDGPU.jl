using HSARuntime
using AMDGPUnative
using Test

if HSARuntime.configured
    agents = get_agents()
    if length(agents) > 0
        include("agent.jl")
        include("array.jl")
        include("memory.jl")

        if AMDGPUnative.configured
            include("vadd.jl")
        else
            @warn "AMDGPUnative.jl has not been configured; skipping on-device tests"
        end
    else
        @warn "No devices detected; skipping runtime tests"
    end
else
    error("HSARuntime.jl has not been configured; skipping all tests")
end
