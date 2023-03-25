import KernelAbstractions
using Test

include(joinpath(dirname(pathof(KernelAbstractions)), "..", "test", "testsuite.jl"))

using AMDGPU
using AMDGPU.ROCKernels

if AMDGPU.has_rocm_gpu()
    AMDGPU.allowscalar(false)
    Testsuite.testsuite(ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray; skip_tests=Set(["const", "sparse"]))
end