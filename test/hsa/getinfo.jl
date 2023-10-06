@testset "getinfo queries" begin
    @testset "ROCDevice" begin
        device = AMDGPU.device()
        hsa_dev = Runtime.hsa_device(device)
        @test Runtime.name(hsa_dev) isa String
        @test Runtime.device_type(hsa_dev) isa AMDGPU.HSA.DeviceType
        @test Runtime.device_wavefront_size(hsa_dev) isa UInt32
    end

    @testset "HSA.ISA" begin
        device = AMDGPU.device()
        device_isa = AMDGPU.default_isa(device).hsa_isa
        @test Runtime.isa_workgroup_max_size(device_isa) isa UInt32
    end
end
