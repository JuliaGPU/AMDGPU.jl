@testset "Devices" begin
    @testset "Device IDs" begin
        for kind in (:cpu, :gpu)
            devices = AMDGPU.devices()
            for (idx,device) in enumerate(devices)
                @test AMDGPU.device_id(device) == idx
            end
        end
    end

    @testset "Default selection" begin
        agent = AMDGPU.default_device()
        @test agent !== nothing
        @test AMDGPU.device_type(agent) == :gpu

        agent_name = Runtime.name(agent)
        @test length(agent_name) > 0
        @test !occursin('\0', agent_name)

        if length(AMDGPU.devices()) > 1
            @testset "Multi-GPU" begin
                init_agent = AMDGPU.default_device()
                init_dev = AMDGPU.default_device_id()
                @test init_dev == 1
                AMDGPU.default_device_id!(2)
                @test AMDGPU.default_device_id() == 2
                @test AMDGPU.default_device() != init_agent
                AMDGPU.default_device_id!(1)
                @test AMDGPU.default_device_id() == 1
                @test AMDGPU.default_device() == init_agent

                @test_throws BoundsError AMDGPU.default_device_id!(0)
                @test_throws BoundsError AMDGPU.default_device_id!(length(AMDGPU.devices())+1)
            end
        else
            @test_skip "Multi-GPU"
        end
    end

    @testset "ISAs" begin
        agent = AMDGPU.default_device()
        agent_isa = string(AMDGPU.default_isa_architecture(agent))
        @test length(agent_isa) > 0
        @test occursin("gfx", agent_isa)
    end
end
