@testitem "hip - rocBLAS" setup=[TSCore] begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocblas)
    include("rocarray/blas.jl")
else
    @test_skip "rocBLAS"
end

end
