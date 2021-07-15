using Test

@testset "rocSPARSE" begin

using AMDGPU.ROCSPARSE

handle = ROCSPARSE.handle()

@testset "Build Information" begin
	ver = ROCSPARSE.version()
    @test ver isa VersionNumber
end

end # testset rocSPARSE
