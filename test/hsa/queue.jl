@testset "Queues" begin
    @testset "Priorities" begin
        device = AMDGPU.default_device()
        # Test that priorities can be set
        for priority in (:low, :normal, :high)
            ROCQueue(device; priority)
        end
        @test_throws ArgumentError ROCQueue(device; priority=:fake)
    end

    @testset "kill_queue! cleanup" begin
        queue = AMDGPU.default_queue()
        AMDGPU.Runtime.kill_queue!(queue)

        @test queue.active == false
        @test haskey(AMDGPU.Runtime.QUEUES, queue.queue) == false
        @test get(AMDGPU.Runtime.DEFAULT_QUEUES, queue.device, nothing) != queue
    end
end
