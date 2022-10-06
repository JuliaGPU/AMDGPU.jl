@testset "Active kernels" begin
    function kernel(sig)
        hostcall!(sig)
        nothing
    end

    wait_ev = Base.Event()
    hc = HostCall(Nothing, Tuple{}) do
        wait(wait_ev)
    end

    sig = @roc kernel(hc)
    @test sig in AMDGPU.active_kernels()
    @test (@atomic sig.active)

    notify(wait_ev)
    wait(sig)
    @test !(sig in AMDGPU.active_kernels())
end
