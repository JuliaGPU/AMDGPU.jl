@testset "Utils" begin
    @testset "versioninfo" begin
        AMDGPU.versioninfo()
        @test true  # Just test that versioninfo() prints something.
    end

    @testset "has_rocm_gpu" begin
        @test AMDGPU.has_rocm_gpu()
    end
end
