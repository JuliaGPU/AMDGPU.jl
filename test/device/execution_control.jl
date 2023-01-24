@testset "Execution Control Intrinsics" begin

@testset "Completion Signal" begin
    function completion_signal_kernel(X)
        X[1] = AMDGPU.Device._completion_signal()
        nothing
    end

    RA = ROCArray(rand(UInt64, 1))

    ev = @roc completion_signal_kernel(RA)
    wait(ev)
    @test Array(RA)[1] == ev.signal.signal[].handle
end

@testset "sendmsg/sendmsghalt/endpgm" begin
    function exec_ctl_kernel()
        Device.sendmsg(5)
        Device.sendmsghalt(6)
        Device.endpgm()
    end

    iob = IOBuffer()
    AMDGPU.code_native(iob, exec_ctl_kernel, Tuple{})
    str = String(take!(iob))
    @test occursin("s_sendmsg ", str)
    @test occursin("s_sendmsghalt ", str)
    # TODO: Can't easily count these, since they're automatically inserted
    @test occursin("s_endpgm", str)
end

@testset "device_sleep/memtime/memrealtime" begin
    function time_kernel(X)
        t1 = AMDGPU.Device.memtime()
        tr1 = AMDGPU.Device.memrealtime()
        AMDGPU.Device.device_sleep(Int32(1))
        t2 = AMDGPU.Device.memtime()
        tr2 = AMDGPU.Device.memrealtime()
        X[1] = t2 > t1
        X[2] = tr2 > tr1
        return
    end
    RX = ROCArray(zeros(Bool, 2))
    wait(@roc time_kernel(RX))
    @test all(Array(RX))
end

@testset "readfirstlane" begin
    function readfirstlane_kernel(B, A)
        idx = workitemIdx().x
        if idx > 1
            B[idx] = AMDGPU.Device.readfirstlane(A[idx])
        else
            B[idx] = A[idx]
        end
        return
    end
    RB = ROCArray(zeros(Int32, 8))
    RA = ROCArray(Int32(1):Int32(8))
    wait(@roc groupsize=8 readfirstlane_kernel(RB, RA))
    B = Array(RB)
    @test B[1] == Int32(1)
    @test all(B[2:8] .== Int32(2))
end

end
