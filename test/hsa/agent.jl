@testset "Agent" begin
    @testset "Default selection" begin
        agent = get_default_agent()
        @test agent !== nothing
        @test AMDGPU.device_type(agent) == :gpu

        agent_name = AMDGPU.get_name(agent)
        @test length(agent_name) > 0
        @test !occursin('\0', agent_name)

        if length(AMDGPU.get_agents(:gpu)) > 1
            @testset "Multi-GPU" begin
                init_agent = AMDGPU.get_default_agent()
                init_dev = AMDGPU.device()
                @test init_dev == 1
                AMDGPU.device!(2)
                @test AMDGPU.device() == 2
                @test AMDGPU.get_default_agent() != init_agent
                AMDGPU.device!(1)
                @test AMDGPU.device() == 1
                @test AMDGPU.get_default_agent() == init_agent

                @test_throws BoundsError AMDGPU.device!(0)
                @test_throws BoundsError AMDGPU.device!(length(AMDGPU.get_agents())+1)
            end
        else
            @test_skip "Multi-GPU"
        end
    end

    @testset "ISAs" begin
        agent = get_default_agent()
        agent_isa = get_first_isa_string(agent)
        @test length(agent_isa) > 0
    end
end
