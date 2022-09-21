@testset "Utils" begin
    @testset "versioninfo" begin
        _, msg = @grab_output AMDGPU.versioninfo()
        # Just test that versioninfo() prints something.
        @test length(msg) > 0
    end

    @testset "has_rocm_gpu" begin
        @test AMDGPU.has_rocm_gpu()
    end

    @testset "functional" begin
        @test AMDGPU.functional()
        # TODO: Test each sub-query
    end
end
