@testset "Devices" begin
    @testset "Device IDs" begin
        devices = AMDGPU.devices()
        for (idx,device) in enumerate(devices)
            @test AMDGPU.device_id(device) == idx
        end
    end

    @testset "Default selection" begin
        device = AMDGPU.device()
        @test device !== nothing

        device_name = HIP.name(device)
        @test length(device_name) > 0
        @test !occursin('\0', device_name)
    end

    @testset "ISAs" begin
        device = AMDGPU.device()
        device_isa, features = AMDGPU.default_isa(device).arch_features
        @test length(device_isa) > 0
        @test occursin("gfx", device_isa)
    end
end
