@testitem "hip - rocSPARSE" begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocsparse)
    include("rocsparse/rocsparse.jl")
else
    @test_skip "rocSPARSE"
end

end
