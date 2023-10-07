@testitem "kernelabstractions" begin

import KernelAbstractions
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
    skip_tests=Set(["Printing", "sparse"])) # TODO fix KA printing

# Disable global malloc hostcall started by conversion tests.
AMDGPU.synchronize(; stop_hostcalls=true)

end
