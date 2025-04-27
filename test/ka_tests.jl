@testitem "kernelabstractions" begin

import KernelAbstractions
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

# TODO fix Printing
skip_tests = ["Printing", "sparse"]
if Sys.iswindows()
    # TODO
    # We do not support hostcalls on Windows yet.
    push!(skip_tests, "Convert")
    # Also launches malloc hostcall for some reason...
    push!(skip_tests, "Private")
end
# TODO same issue as with device/synchronization.jl tests - LLVM 19 intrinsics in devlibs.
if !(VERSION < v"1.12-")
    push!(skip_tests, "Convert")
end

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
    skip_tests=Set(skip_tests))

if Sys.islinux()
    # Disable global malloc hostcall started by conversion tests.
    AMDGPU.synchronize(; stop_hostcalls=true)
end

end
