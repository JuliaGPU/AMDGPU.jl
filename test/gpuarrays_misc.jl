using Test
using AMDGPU

import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

# Tests that don't fit in other categories
const KNOWN_CATEGORIES = ["indexing", "reductions", "linalg", "math"]
const BASE_TESTS = ["base", "constructors", "vectors", "random", "broadcasting", "statistics", "alloc cache"]

@testset "GPUArrays - Misc" begin
    for (name, test) in TestSuite.tests
        # Skip tests covered by other files
        any(startswith(name, cat) for cat in KNOWN_CATEGORIES) && continue
        name in BASE_TESTS && continue

        @testset "$name" begin
            test(AMDGPU.ROCArray)
        end
    end
end
