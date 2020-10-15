@testset "Kernel Dependencies" begin
    function kernel(sig, waitval, A, val)
        i = workitemIdx().x
        AMDGPU.device_signal_wait(sig, waitval)
        A[i] = val
        return nothing
    end

    @testset "Barrier And" begin
        RA = ROCArray(zeros(Float64, 1))
        sig = AMDGPU.HSASignal(0)

        ret1 = @roc kernel(sig, 5, RA, 1.0)

        queue = AMDGPU.default_queue().queue
        retb = barrier_and!(queue, [ret1])
        ret2 = @roc kernel(sig, 0, RA, 2.0)

        sleep(0.5)
        @test Array(RA)[1] == 0.0
        HSA.signal_store_relaxed(sig.signal[], 5)
        wait(ret1)
        @test Array(RA)[1] == 1.0
        HSA.signal_store_relaxed(sig.signal[], 0)
        sleep(0.5)
        @test Array(RA)[1] == 2.0
        wait(ret2)
        wait(retb)
    end
end
