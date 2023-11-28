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
# TODO rocFFT tests crash Windows due to access violation
if Sys.islinux() && AMDGPU.functional(:rocfft)
    include("rocarray/fft.jl")
end

end
