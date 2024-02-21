@testitem "hip - rocSOLVER" begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocsolver)
    include("rocarray/solver.jl")
else
    @test_skip "rocSOLVER"
end

end
