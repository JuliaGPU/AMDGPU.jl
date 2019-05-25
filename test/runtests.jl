using AMDGPUnative
const AS = AMDGPUnative.AS
using LLVM, LLVM.Interop
using HSARuntime
using InteractiveUtils
using Test

const DEBUG = get(ENV, "AMDGPUNATIVE_DEBUG", false) == "1"

agent_name = HSARuntime.get_name(get_default_agent())
agent_isa = get_first_isa(get_default_agent())
@info "Testing using device $agent_name with ISA $agent_isa"

@testset "AMDGPUnative" begin

include("util.jl")

include("base.jl")
include("pointer.jl")
# TODO: include("codegen.jl")

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

            if DEBUG
                @show d_a.handle
                @show d_b.handle
                @show d_c.handle

                aspace = AMDGPUnative.AS.Global
                arrdims = ndims(a)
                arrT = ROCDeviceArray{Float32,arrdims,aspace}
                @info "LLVM IR"
                AMDGPUnative.code_llvm(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
                @info "GCN Device Code"
                AMDGPUnative.code_gcn(vadd, Tuple{arrT,arrT,arrT}; kernel=true)
            end

            @roc groupsize=len gridsize=len vadd(d_a, d_b, d_c)
            if DEBUG
                @show d_a
                @show d_b
                @show d_c
            end
            c = Array(d_c)
            @test a+b ≈ c
        end

        include("device/synchronization.jl")
        #include("device/codegen.jl")
        #include("device/execution.jl")
        #include("device/pointer.jl")
        #include("device/array.jl")
        #include("device/intrinsics.jl")
    end
else
    @warn("AMDGPUnative.jl has not been configured; skipping on-device tests.")
end

end
