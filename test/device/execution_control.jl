@testset "Execution Control Intrinsics" begin

function completion_signal_kernel(X)
    X[1] = AMDGPU._completion_signal()
    nothing
end

RA = ROCArray(rand(UInt64, 1))

ev = @roc completion_signal_kernel(RA)
wait(ev)
@test collect(RA)[1] == ev.event.signal.signal[].handle

function exec_ctl_kernel(X)
    AMDGPU.sendmsg(5)
    AMDGPU.sendmsghalt(6)
    AMDGPU.endpgm()
end

iob = IOBuffer()
AMDGPU.code_native(iob, exec_ctl_kernel, Tuple{Int64}; kernel=true)
str = String(take!(iob))
@test occursin("s_sendmsg ", str)
@test occursin("s_sendmsghalt ", str)
@test occursin("s_endpgm", str) # TODO: Test for multiple occurences

end
