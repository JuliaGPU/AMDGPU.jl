using Test
using AMDGPU

import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

@testset "GPUArrays - Math" begin
    for (name, test) in TestSuite.tests
        if startswith(name, "math")
            @testset "$name" begin
                test(AMDGPU.ROCArray)
            end
        end
    end
end
