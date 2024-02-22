@testitem "hip - rocFFT" begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocfft)
    include("rocarray/fft.jl")
else
    @test_skip "rocFFT"
end

end
