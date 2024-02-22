@testitem "hip - MIOpen" setup=[TSCore] begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:MIOpen)
    include("dnn/miopen.jl")
else
    @test_skip "MIOpen"
end

end
