@testitem "hip" begin

using Test
using LinearAlgebra
using Random

using AMDGPU: HIP, Runtime, Device, Mem
import AMDGPU: @allowscalar

Random.seed!(1)
AMDGPU.allowscalar(false)

include("rocarray/blas.jl")
include("rocarray/solver.jl")
include("rocsparse/rocsparse.jl")
include("rocarray/random.jl")
include("rocarray/fft.jl")
include("dnn/miopen.jl")

@testset "AMDGPU.@elapsed" begin
    xgpu = AMDGPU.rand(Float32, 100)
    t = AMDGPU.@elapsed xgpu .+= 1
    @test t isa AbstractFloat
    @test t >= 0

    x = rand(Float32, 100)
    t = AMDGPU.@elapsed begin
        copyto!(xgpu, x)
        copyto!(x, xgpu)
    end
    @test t isa AbstractFloat
    @test t >= 0
end

if length(AMDGPU.devices()) > 1
    @testset "HIP Peer Access" begin
        dev1, dev2, _ = AMDGPU.devices()
        @test AMDGPU.HIP.can_access_peer(dev1, dev2) isa Bool
    end
end

end
