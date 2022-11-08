@testset "Execution Control Intrinsics" begin

function completion_signal_kernel(X)
    X[1] = Device._completion_signal()
    nothing
end

RA = ROCArray(rand(UInt64, 1))

ev = @roc completion_signal_kernel(RA)
wait(ev)
@test collect(RA)[1] == ev.signal.signal[].handle

function exec_ctl_kernel(X)
    Device.sendmsg(5)
    Device.sendmsghalt(6)
    Device.endpgm()
end

iob = IOBuffer()
AMDGPU.code_native(iob, exec_ctl_kernel, Tuple{Int64}; kernel=true)
str = String(take!(iob))
@test occursin("s_sendmsg ", str)
@test occursin("s_sendmsghalt ", str)
@test occursin("s_endpgm", str) # TODO: Test for multiple occurences

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

end
