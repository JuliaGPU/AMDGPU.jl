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
