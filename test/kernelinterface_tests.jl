using Test
using AMDGPU

import KernelInterface
include(joinpath(pkgdir(KernelInterface), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

@testset "kernelinterface" begin

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray)
end
