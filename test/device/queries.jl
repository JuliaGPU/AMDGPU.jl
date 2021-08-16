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
    @test sig.event in AMDGPU.active_kernels()
    @test !sig.event.done.set
    notify(wait_ev)
    wait(sig)
    @test !(sig.event in AMDGPU.active_kernels())
end
