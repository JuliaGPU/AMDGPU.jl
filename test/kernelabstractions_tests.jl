using Test
using AMDGPU

import KernelAbstractions
include(joinpath(pkgdir(KernelAbstractions), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

@testset "kernelabstractions" begin

# TODO fix Printing
skip_tests = ["Printing", "sparse"]

Testsuite.testsuite(
    ROCBackend, "ROCM", AMDGPU, ROCArray, AMDGPU.ROCDeviceArray;
    skip_tests=Set(skip_tests))

@testset "Many arguments" begin
    # more arguments than Julia splats or maps over without falling back to dynamic calls
    params = [Symbol(:x, i) for i in 1:40]
    @eval KernelAbstractions.@kernel function many_args_kernel(out, $(params...))
        out[1] = $(foldl((a, b) -> :($a + $b), params))
    end
    @eval many_args_launch(kernel, out) = kernel(out, $(1:40...); ndrange=1)

    @eval KernelAbstractions.@kernel function few_args_kernel(out, x)
        out[1] = x
    end
    few_args_launch(kernel, out) = kernel(out, 1; ndrange=1)

    out = ROCArray([0])
    kernel = Base.invokelatest(many_args_kernel, ROCBackend())
    few_kernel = Base.invokelatest(few_args_kernel, ROCBackend())
    Base.invokelatest(many_args_launch, kernel, out)
    @test Array(out)[1] == sum(1:40)

    # launching should not be much more expensive than with few arguments
    # (Julia 1.11 and older allocate a little per argument)
    Base.invokelatest() do
        few_args_launch(few_kernel, out)
        @test @allocated(many_args_launch(kernel, out)) <=
              @allocated(few_args_launch(few_kernel, out)) + 40*32
    end
end

# Disable global malloc hostcall started by conversion tests.
AMDGPU.synchronize(; stop_hostcalls=true)

end
