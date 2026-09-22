using Test
using AMDGPU
using AMDGPU: ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim

if length(AMDGPU.devices()) <= 1
    @info "Skipping Multi-GPU tests (requires more than 1 GPU)"
else

@testset "Multi-GPU" begin
    @testset "Device switching" begin
        d1 = AMDGPU.device()
        s1 = AMDGPU.stream()
        id1 = AMDGPU.device_id()
        @test id1 == 1
        @test s1.device == d1

        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()
        s2 = AMDGPU.stream()
        id2 = AMDGPU.device_id()
        @test s2.device == d2

        @test d1 != d2
        @test s1 != s2
        @test id1 != id2

        AMDGPU.device_id!(1)
        @test d1 == AMDGPU.device()
    end

    @testset "Arrays" begin
        d1 = AMDGPU.device()

        x1 = AMDGPU.ones(Int, 16)
        @test AMDGPU.device(x1) == d1

        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        x2 = AMDGPU.ones(Int, 16)
        @test AMDGPU.device(x2) != d1
        @test AMDGPU.device(x2) == d2

        @test sum(x2) == 16

        AMDGPU.device_id!(1)
        @test sum(x1) == 16
    end

    @testset "Copying" begin
        AMDGPU.device_id!(1)
        d1 = AMDGPU.device()
        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        # Copy from d1 to host, then from host to d2 and compare with host.
        h = zeros(Int32, 16)

        AMDGPU.device!(d1)
        x1 = AMDGPU.rand(Int32, 16)
        copyto!(h, x1)

        AMDGPU.device!(d2)
        x2 = AMDGPU.zeros(Int32, 16)
        copyto!(x2, h)

        @test Array(x2) == h
    end

    @testset "Kernel" begin
        function add_one!(x)
            i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
            x[i] += 1
            return
        end

        AMDGPU.device_id!(1)
        d1 = AMDGPU.device()
        AMDGPU.device_id!(2)
        d2 = AMDGPU.device()

        AMDGPU.device!(d1)
        x1 = AMDGPU.zeros(Int32, 16)
        @roc groupsize=length(x1) add_one!(x1)

        AMDGPU.device!(d2)
        x2 = AMDGPU.zeros(Int32, 16)
        @roc groupsize=length(x2) add_one!(x2)
        @test sum(x2) == 16

        AMDGPU.device!(d1)
        @test sum(x1) == 16
    end

    @testset "Correctly switching HIP context" begin
        f() = return

        AMDGPU.device_id!(1)
        @test AMDGPU.device() == AMDGPU.HIP.device()
        @test AMDGPU.stream().device == AMDGPU.HIP.device()

        # This will create task, but HIP uses thread local storage.
        # So this will change HIP global state outside of task.
        wait(Threads.@spawn begin
            AMDGPU.device_id!(2)
            @test AMDGPU.stream().device == AMDGPU.HIP.device()
            @roc f()
            AMDGPU.synchronize()
        end)

        @test AMDGPU.device() == AMDGPU.device(1)

        # Here we test that we correctly switch back to the TLS context.
        @roc f()

        @test AMDGPU.stream().device == AMDGPU.HIP.device()
        @test AMDGPU.device() == AMDGPU.device(1)
        @test AMDGPU.HIP.device() == AMDGPU.device(1)
    end

    if AMDGPU.functional(:rocblas)
        @testset "Library handle cache keys on the creation context (#1094)" begin
            IH = AMDGPU.rocBLAS.IDLE_HANDLES
            total_idle() = Base.@lock IH.lock AMDGPU.total_idle(IH)

            idle_before = total_idle()
            # Take a handle on device 1, then switch before the task dies.
            for _ in 1:8
                fetch(Threads.@spawn begin
                    AMDGPU.device_id!(1)
                    AMDGPU.rocBLAS.handle()
                    AMDGPU.device_id!(2)
                end)
            end
            GC.gc(true); GC.gc(true)

            # Task finalization is not deterministic; on the buggy path the
            # count could only shrink, so growth is the signal.
            @test total_idle() > idle_before

            AMDGPU.device_id!(1)
        end
    end
end
end
