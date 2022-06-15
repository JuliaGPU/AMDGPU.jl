@testset "HSA Status Error" begin
    errorcode = AMDGPU.HSAError(HSA.STATUS_SUCCESS)
    @test Runtime.description(errorcode) == "HSA_STATUS_SUCCESS: The function has been executed successfully."
end

@testset "HSA Async Queue Error" begin
    kernel() = (AMDGPU.trap(); nothing)
    @test_throws Runtime.QueueError wait(@roc kernel())
end
