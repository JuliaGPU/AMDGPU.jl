using Test
using AMDGPU

import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

const BASE_TESTS = ["base", "constructors", "vectors", "random", "broadcasting", "statistics", "alloc cache"]

@testset "GPUArrays - Base" begin
    for (name, test) in TestSuite.tests
        if name in BASE_TESTS
            @testset "$name" begin
                test(AMDGPU.ROCArray)
            end
        end
    end
end
