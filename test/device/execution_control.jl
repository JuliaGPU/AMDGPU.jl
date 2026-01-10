using Test
using AMDGPU
using AMDGPU: Device, ROCArray, @roc
using AMDGPU.Device: workitemIdx

@testset "Execution Control Intrinsics" begin
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

    # FIXME after an update to 6.2 kernel, this test started to fail randomly
    # @testset "device_sleep/memtime/memrealtime" begin
    #     function time_kernel(X)
    #         t1 = AMDGPU.Device.memtime()
    #         tr1 = AMDGPU.Device.memrealtime()
    #         AMDGPU.Device.device_sleep(Int32(2))
    #         t2 = AMDGPU.Device.memtime()
    #         tr2 = AMDGPU.Device.memrealtime()
    #         X[1] = t2 > t1
    #         X[2] = tr2 > tr1
    #         return
    #     end
    #     RX = ROCArray(zeros(Bool, 2))
    #     @roc time_kernel(RX)
    #     @test all(Array(RX))
    # end

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
        @roc groupsize=8 readfirstlane_kernel(RB, RA)
        B = Array(RB)
        @test B[1] == Int32(1)
        @test all(B[2:8] .== Int32(2))
    end
end
