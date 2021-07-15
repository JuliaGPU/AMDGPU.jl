using Test

@testset "rocSPARSE" begin

using AMDGPU.rocSPARSE

handle = rocSPARSE.handle()

@testset "Build Information" begin
	ver = rocSPARSE.version()
    @test ver isa VersionNumber
end

end # testset rocSPARSE
