using Test
using AMDGPU

import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

@testset "GPUArrays - Reductions" begin
    for (name, test) in TestSuite.tests
        if startswith(name, "reductions")
            @testset "$name" begin
                test(AMDGPU.ROCArray)
            end
        end
    end
end
