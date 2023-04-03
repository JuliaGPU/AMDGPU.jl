@testset "Active kernels" begin
    AMDGPU.reset_dead_queue!() # Reset queue in case of signal timeout.

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
