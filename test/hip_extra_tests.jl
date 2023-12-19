@testitem "hip - extra" begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

if AMDGPU.functional(:rocsolver)
    include("rocarray/solver.jl")
end

if AMDGPU.functional(:rocsparse)
    include("rocsparse/rocsparse.jl")
end

# TODO rocFFT needs an update to work with ROCm 6.0+.
if HIP.runtime_version() ≥ v"6-"
    @test_skip "rocFFT"
else
    include("rocarray/fft.jl")
end

end
