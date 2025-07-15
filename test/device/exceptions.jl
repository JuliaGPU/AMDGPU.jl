@testset "Exceptions" begin
    function oob_kernel(X)
        X[0] = 1
        return
    end

    RA = ROCArray(zeros(Int, 1))
    @roc oob_kernel(RA)
    try
        AMDGPU.synchronize()
    catch err
        @test err isa ErrorException
    end
    # TODO check exception message
    # TODO check specific exception type
end
