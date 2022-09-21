using AMDGPU
using AMDGPU: Runtime, Mem, Device, HSA, AS
if AMDGPU.functional(:hip)
    using AMDGPU: HIP
end
using GPUCompiler
using LinearAlgebra
using LLVM, LLVM.Interop
using InteractiveUtils
using SpecialFunctions
using Test

using Random
Random.seed!(1)

include("util.jl")

# GPUArrays has a testsuite that isn't part of the main package.
# Include it directly.
import GPUArrays
gpuarrays = pathof(GPUArrays)
gpuarrays_root = dirname(dirname(gpuarrays))
include(joinpath(gpuarrays_root, "test", "testsuite.jl"))
testf(f, xs...; kwargs...) = TestSuite.compare(f, ROCArray, xs...; kwargs...)
if isdefined(TestSuite, :WrapArray)
    Base.hash(a::TestSuite.WrapArray{T1,N1,ROCDeviceArray{T2,N2,A}}, h::UInt) where {T1,N1,T2,N2,A} =
        hash(a.data, hash(typeof(a), h))
end

import AMDGPU: allowscalar, @allowscalar
allowscalar(false)

CI = parse(Bool, get(ENV, "CI", "false"))

if CI
    # Disable fault handler (signal timeout will catch hangs)
    # FIXME: Instead kill all associated queues
    fault_handler(ev, data) = HSA.STATUS_SUCCESS
    function setup_fault_handler()
        fault_handler_cb = @cfunction(fault_handler, HSA.Status, (Ptr{HSA.AMDEvent}, Ptr{Cvoid}))
        @assert AMDGPU.HSA.amd_register_system_event_handler(fault_handler_cb, C_NULL) == HSA.STATUS_SUCCESS
    end
    setup_fault_handler()
end

Runtime.DEFAULT_SIGNAL_TIMEOUT[] = 15.0
Device.DEFAULT_HOSTCALL_TIMEOUT[] = 15.0

@testset "AMDGPU" begin

@testset "Core" begin
include("pointer.jl")
end

@testset "HSA" begin
    include("hsa/error.jl")
    include("hsa/utils.jl")

    @test length(AMDGPU.devices()) > 0
    @info "Testing using device $(AMDGPU.default_device())"

    include("hsa/device.jl")
    include("hsa/queue.jl")
    include("hsa/memory.jl")
end
@testset "Codegen" begin
    include("codegen/synchronization.jl")
    include("codegen/trap.jl")
end
@testset "Device Functions" begin
    include("device/launch.jl")
    include("device/array.jl")
    include("device/vadd.jl")
    include("device/memory.jl")
    include("device/indexing.jl")
    include("device/hostcall.jl")
    include("device/output.jl")
    include("device/globals.jl")
    include("device/math.jl")
    include("device/wavefront.jl")
    include("device/execution_control.jl")
    include("device/exceptions.jl")
    include("device/deps.jl")
    include("device/queries.jl")
end
@testset "ROCArray" begin
    include("rocarray/base.jl")
    include("rocarray/broadcast.jl")
    @testset "ROCm External Libraries" begin
        if CI
            @test AMDGPU.functional(:rocblas)
            @test AMDGPU.functional(:rocrand)
            if !AMDGPU.use_artifacts
                # We don't have artifacts for these
                @test AMDGPU.functional(:rocfft)
            end
        end
        if AMDGPU.functional(:rocblas)
            include("rocarray/blas.jl")
        else
            @test_skip "rocBLAS"
        end
        if AMDGPU.functional(:rocrand)
            include("rocarray/random.jl")
        else
            @test_skip "rocRAND"
        end
        if AMDGPU.functional(:rocfft)
            include("rocarray/fft.jl")
        else
            @test_skip "rocFFT"
        end
        if AMDGPU.functional(:rocblas)
            include("rocarray/nmf.jl")
        else
            @test_skip "NMF"
        end
    end
    @testset "GPUArrays test suite" begin
        TestSuite.test(ROCArray)
    end
end
@testset "External Packages" begin
    include("external/forwarddiff.jl")
end

end
