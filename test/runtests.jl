using AMDGPUnative
const AS = AMDGPUnative.AS
using GPUCompiler
using LLVM, LLVM.Interop
using HSARuntime
using InteractiveUtils
using SpecialFunctions
using Test

agent_name = HSARuntime.get_name(get_default_agent())
agent_isa = get_first_isa(get_default_agent())
@info "Testing using device $agent_name with ISA $agent_isa"

@testset "AMDGPUnative" begin

@testset "Core" begin
include("pointer.jl")
end

if AMDGPUnative.configured
    @test length(get_agents()) > 0
    if length(get_agents()) > 0
        include("synchronization.jl")
        include("trap.jl")
        @testset "Device" begin
            include("device/launch.jl")
            include("device/vadd.jl")
            include("device/memory.jl")
            include("device/indexing.jl")
            include("device/hostcall.jl")
            include("device/output.jl")
            include("device/globals.jl")
            if Base.libllvm_version >= v"7.0"
                include("device/math.jl")
            else
                @warn "Testing with LLVM 6; some tests will be disabled!"
                @test_skip "Math Intrinsics"
            end
        end
    end
else
    @warn("AMDGPUnative.jl has not been configured; skipping on-device tests.")
end

end
