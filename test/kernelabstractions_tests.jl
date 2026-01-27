using Test
using AMDGPU

import KernelAbstractions
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

@testset "kernelabstractions" begin

# TODO fix Printing
skip_tests = ["Printing", "sparse"]
if Sys.iswindows()
    # TODO
    # We do not support hostcalls on Windows yet.
    push!(skip_tests, "Convert")
    # Also launches malloc hostcall for some reason...
    push!(skip_tests, "Private")
end

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
    skip_tests=Set(skip_tests))

if Sys.islinux()
    # Disable global malloc hostcall started by conversion tests.
    AMDGPU.synchronize(; stop_hostcalls=true)
end

end
