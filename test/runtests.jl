using AMDGPUnative
const AS = AMDGPUnative.AS
using LLVM, LLVM.Interop
using HSARuntime
using InteractiveUtils
using SpecialFunctions
using Test

agent_name = HSARuntime.get_name(get_default_agent())
agent_isa = get_first_isa(get_default_agent())
@info "Testing using device $agent_name with ISA $agent_isa"

@testset "AMDGPUnative" begin

include("util.jl")

@testset "Core" begin
include("base.jl")
include("pointer.jl")
# TODO: include("codegen.jl")
end

if AMDGPUnative.configured
    @test length(get_agents()) > 0
    if length(get_agents()) > 0
        # The original test :)
        @testset "Vector Addition Kernel" begin
            function vadd(a,b,c)
                i = threadIdx().x
                c[i] = a[i] + b[i]
                sync_workgroup()
                return nothing
            end

            dims = (8,)
            a = round.(rand(Float32, dims) * 100)
            b = round.(rand(Float32, dims) * 100)

            d_a = HSAArray(a)
            d_b = HSAArray(b)
            d_c = similar(d_a)
            len = prod(dims)

            @debug begin
                @show d_a.handle
                @show d_b.handle
                @show d_c.handle

                aspace = AMDGPUnative.AS.Global
                arrdims = ndims(a)
                arrT = ROCDeviceArray{Float32,arrdims,aspace}
                @debug "LLVM IR"
                AMDGPUnative.code_llvm(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
                @debug "GCN Device Code"
                AMDGPUnative.code_gcn(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
                ""
            end

            @roc groupsize=len gridsize=len vadd(d_a, d_b, d_c)
            @debug begin
                @show d_a
                @show d_b
                @show d_c
                ""
            end
            c = Array(d_c)
            @test a+b ≈ c
        end

        @testset "Device" begin
            include("device/synchronization.jl")
            include("device/memory.jl")
            include("device/indexing.jl")
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
