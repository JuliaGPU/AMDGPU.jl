@testset "Exceptions" begin
    function oob_kernel(X)
        X[0] = 1
        nothing
    end

    RA = ROCArray(ones(Float32, 4))
    @roc oob_kernel(RA)
    try
        AMDGPU.synchronize()
    catch err
        @test err isa ErrorException
    finally
        AMDGPU.reset_exception_holder!(AMDGPU.device())
    end
    # TODO check exception message
    # TODO check specific exception type
end
