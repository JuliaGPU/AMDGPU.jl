@testset "Kernel Dependencies" begin
    function kernel(sig, waitval, A, val)
        i = workitemIdx().x
        Device.hostcall_device_signal_wait(sig, waitval)
        A[i] = val
        return nothing
    end

    @testset "Barrier AND" begin
        for i in (0, 1, 5, 7)
            @testset "$i inputs" begin
                RA = ROCArray(zeros(Float64, 1))
                sig = AMDGPU.ROCSignal(0)

                ret1 = [@roc(kernel(sig, 3, RA, 1.0)) for _ in 1:i]

                retb = AMDGPU.barrier_and!(ret1)
                ret2 = @roc kernel(sig, 0, RA, 2.0)

                if i > 0
                    sleep(0.5)
                    @test Array(RA)[1] == 0.0
                    HSA.signal_store_screlease(sig.signal[], 3)
                    wait.(ret1)
                    @test Array(RA)[1] == 1.0
                end
                HSA.signal_store_screlease(sig.signal[], 0)
                # FIXME: wait(retb)
                wait(ret2)
                @test Array(RA)[1] == 2.0
            end
        end
    end

    #= FIXME
    @testset "Barrier OR" begin
        for i in (0, 1, 5, 7)
            @testset "$i inputs" begin
                RA = ROCArray(zeros(Float64, 1))
                sig = AMDGPU.ROCSignal(0)

                ret1 = [@roc(kernel(sig, 7, RA, 5.0)) for _ in 1:i]
                pushfirst!(ret1, @roc(kernel(sig, 3, RA, 1.0)))

                retb = AMDGPU.barrier_or!(ret1)
                ret2 = @roc kernel(sig, 0, RA, 2.0)

                if i > 0
                    sleep(0.5)
                    @test Array(RA)[1] == 0.0
                    HSA.signal_store_release(sig.signal[], 3)

                    wait(ret1[1])
                    @test Array(RA)[1] == 1.0
                end
                HSA.signal_store_screlease(sig.signal[], 0)
                sleep(0.5)
                @test Array(RA)[1] == 2.0
                wait(ret2)
                # FIXME: wait(retb)
                # clear waiting kernels
                HSA.signal_store_screlease(sig.signal[], 7)
            end
        end
    end
    =#
end
