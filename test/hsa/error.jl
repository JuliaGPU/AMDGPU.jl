@testset "HSA Status Error" begin
    errorcode = AMDGPU.HSAError(HSA.STATUS_SUCCESS)
    @test Runtime.description(errorcode) == "HSA_STATUS_SUCCESS: The function has been executed successfully."
end

if !IS_NAVI_2
    @testset "HSA Async Queue Error" begin
        kernel() = (Device.trap(); nothing)
        @test_throws Runtime.QueueError wait(@roc kernel())
    end
end
