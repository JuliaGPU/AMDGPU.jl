@testitem "hip - rocRAND" setup=[TSCore] begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocrand)
    include("rocarray/random.jl")
else
    @test_skip "rocRAND"
end

end
