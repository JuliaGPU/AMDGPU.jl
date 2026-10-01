using Test
using Random
using AMDGPU
using AMDGPU: HIP, Runtime, Device, Mem

Random.seed!(1)

@testset "hip - core" begin

@testset "AMDGPU.@elapsed" begin
    xgpu = AMDGPU.rand(Float32, 100)
    t = AMDGPU.@elapsed xgpu .+= 1
    @test t isa AbstractFloat
    @test t >= 0

    x = rand(Float32, 100)
    t = AMDGPU.@elapsed begin
        copyto!(xgpu, x)
        copyto!(x, xgpu)
    end
    @test t isa AbstractFloat
    @test t >= 0
end

@testset "cooperative synchronization" begin
    # keep the GPU busy for a while
    function sleep_kernel(n)
        for _ in 1:n
            AMDGPU.Device.device_sleep(Int32(127))
        end
        return
    end
    function busy(n; stream)
        @roc stream=stream sleep_kernel(n)
        return
    end

    # run `f` while counting how often another task on the same thread gets to run. polling
    # before waiting yields a couple of hundred times, so only much larger counts show that
    # the thread was not blocked while waiting.
    function progress_during(f)
        progress = Ref(0)
        done = Ref(false)
        t = @async while !done[]
            progress[] += 1
            yield()
        end
        try
            f()
        finally
            done[] = true
            wait(t)
        end
        return progress[]
    end

    # warm up everything that is measured below
    let s = HIPStream()
        busy(1; stream=s)
        progress_during(() -> AMDGPU.synchronize(s))
        progress_during(() -> HIP.synchronize(HIP.HIPEvent(s)))
        progress_during(HIP.device_synchronize)
        progress_during(() -> AMDGPU.synchronize(s; blocking=true))
    end

    # find a kernel that takes at least 200 ms. time it on the GPU, as this process getting
    # descheduled (as happens on loaded CI nodes) would make it seem to take longer.
    n = 1000
    while AMDGPU.@elapsed(busy(n; stream=AMDGPU.stream())) < 0.2
        n *= 2
    end

    # measure the progress made while `sync()` waits for a kernel on `s`. that only shows
    # whether the thread was blocked if the kernel kept running for a while after the wait
    # started, which isn't the case when this process gets descheduled for longer than the
    # kernel takes. `isdone` can't tell, as HIP may report a completed stream as busy for a
    # while, so check how long the wait took instead, and if it was too short, try again
    # with a longer kernel.
    function progress_while_busy(sync, s)
        m = n
        for _ in 1:5
            busy(m; stream=s)
            t = Ref(0.0)
            progress = progress_during(() -> t[] = @elapsed sync())
            t[] >= 0.05 && return progress
            m *= 2
        end
        error("the kernel kept completing before the wait started")
    end

    let s = HIPStream()
        @test progress_while_busy(() -> AMDGPU.synchronize(s), s) > 1000
        @test HIP.isdone(s)
    end

    let s = HIPStream()
        @test progress_while_busy(() -> HIP.synchronize(s; spin=false), s) > 1000
    end

    let s = HIPStream(), e = Ref{HIP.HIPEvent}()
        # record the event after the kernel
        sync = () -> begin
            e[] = HIP.HIPEvent(s)
            HIP.synchronize(e[])
        end
        @test progress_while_busy(sync, s) > 1000
        @test HIP.isdone(e[])
    end

    let s = HIPStream()
        @test progress_while_busy(HIP.device_synchronize, s) > 1000
        @test HIP.isdone(s)
    end

    # the null stream belongs to the current device, which the worker has to select
    let s = HIP.default_stream()
        @test progress_while_busy(() -> AMDGPU.synchronize(s), s) > 1000
        @test HIP.isdone(s)
    end

    # opting out
    let s = HIPStream()
        @test progress_while_busy(() -> AMDGPU.synchronize(s; blocking=true), s) < 1000
    end

    if length(AMDGPU.devices()) > 1
        # waiting for another device doesn't change the one this task uses
        dev = AMDGPU.device()
        other = first(d for d in AMDGPU.devices() if d != dev)
        s = AMDGPU.device!(() -> HIPStream(), other)
        AMDGPU.device!(() -> busy(1; stream=s), other)
        HIP.synchronize(s; spin=false)
        @test HIP.isdone(s)
        AMDGPU.device!(HIP.device_synchronize, other)
        @test AMDGPU.device() == dev
    end
end

if length(AMDGPU.devices()) > 1
    @testset "HIP Peer Access" begin
        dev1, dev2 = AMDGPU.devices()[1:2]
        @test AMDGPU.HIP.can_access_peer(dev1, dev2) isa Bool
    end
end

end
