@testset "Active kernels" begin
    function kernel(sig)
        AMDGPU.Device.hostcall!(sig)
        nothing
    end

    wait_ev = Base.Event()
    hc = AMDGPU.Device.HostCall(Nothing, Tuple{}) do
        wait(wait_ev)
    end

    sig = @roc kernel(hc)
    @test sig in AMDGPU.active_kernels()
    @test !sig.done.set
    notify(wait_ev)
    wait(sig)
    @test !(sig in AMDGPU.active_kernels())
end
