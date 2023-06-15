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
import NNlib

# Import TestSuite from KernelAbstractions.
import KernelAbstractions
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

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
import AMDGPU.Device: HostCall, hostcall!
allowscalar(false)

CI = parse(Bool, get(ENV, "CI", "false"))

if CI
    # Exit on memory fault to prevent wasting CI time
    AMDGPU.Runtime.EXIT_ON_MEMORY_FAULT[] = true
end

Device.DEFAULT_HOSTCALL_TIMEOUT[] = 5.0

const IS_NAVI_2 = AMDGPU.default_device().name in ("gfx1030", "gfx1031", "gfx1032")
