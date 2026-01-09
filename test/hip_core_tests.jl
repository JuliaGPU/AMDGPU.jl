using Test
using Random
using AMDGPU
using AMDGPU: HIP, Runtime, Device, Mem

Random.seed!(1)

@testset "hip - core" begin

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
