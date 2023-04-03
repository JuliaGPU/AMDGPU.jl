@testset "Queues" begin
    @testset "Priorities" begin
        # Test that priorities can be set
        for priority in (:low, :normal, :high)
            ROCQueue(; priority)
        end
        @test_throws ArgumentError ROCQueue(; priority=:fake)
    end
end
