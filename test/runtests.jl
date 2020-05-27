using HSARuntime
using HSARuntime.HSA
using AMDGPUnative
using Test

if HSARuntime.configured
    @testset "HSA Status Error" begin
        errorcode = HSARuntime.HSAError(HSA.STATUS_SUCCESS)
        @test HSARuntime.description(errorcode) == "HSA_STATUS_SUCCESS: The function has been executed successfully."
    end
    agents = get_agents()
    if length(agents) > 0
        include("agent.jl")
        include("array.jl")
        include("memory.jl")

        if AMDGPUnative.configured
            include("vadd.jl")
            include("global.jl")
        else
            @warn "AMDGPUnative.jl has not been configured; skipping on-device tests"
        end
    else
        @warn "No devices detected; skipping runtime tests"
    end
else
    error("HSARuntime.jl has not been configured; skipping all tests")
end
