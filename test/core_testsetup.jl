@testsetup module TSCore

export testf

import AMDGPU
import GPUArrays
include(joinpath(pkgdir(GPUArrays), "test", "testsuite.jl"))

testf(f, xs...; kwargs...) =
    TestSuite.compare(f, AMDGPU.ROCArray, xs...; kwargs...)

end
