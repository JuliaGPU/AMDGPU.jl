@testset "getinfo queries" begin
    @testset "ROCDevice" begin
        device = AMDGPU.default_device()
        hsa_dev = AMDGPU.Runtime.hsa_device(device)
        @test AMDGPU.Runtime.name(hsa_dev) isa String
        @test AMDGPU.Runtime.device_type(hsa_dev) isa AMDGPU.HSA.DeviceType
        @test AMDGPU.Runtime.device_wavefront_size(hsa_dev) isa UInt32
    end

    @testset "HSA.ISA" begin
        device = AMDGPU.default_device()
        device_isa = AMDGPU.default_isa(device).hsa_isa
        @test AMDGPU.Runtime.isa_workgroup_max_size(device_isa) isa UInt32
    end
end
