@testset "Queues" begin
    @testset "Priorities" begin
        device = AMDGPU.default_device()
        # Test that priorities can be set
        for priority in (:low, :normal, :high)
            ROCQueue(device; priority)
        end
        @test_throws ArgumentError ROCQueue(device; priority=:fake)
    end
end
