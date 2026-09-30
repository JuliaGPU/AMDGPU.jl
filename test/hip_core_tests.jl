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
        progress_during(() -> AMDGPU.synchronize(s; blocking=true))
    end

    # find a kernel that takes at least 200 ms
    n = 1000
    while true
        s = HIPStream()
        t = @elapsed (busy(n; stream=s); AMDGPU.synchronize(s; blocking=true))
        t >= 0.2 && break
        n *= 2
    end

    let s = HIPStream()
        busy(n; stream=s)
        @test !HIP.isdone(s)
        @test progress_during(() -> AMDGPU.synchronize(s)) > 1000
        @test HIP.isdone(s)
    end

    let s = HIPStream()
        busy(n; stream=s)
        @test !HIP.isdone(s)
        @test progress_during(() -> HIP.synchronize(s; spin=false)) > 1000
    end

    let s = HIPStream()
        busy(n; stream=s)
        e = HIP.HIPEvent(s)
        @test !HIP.isdone(e)
        @test progress_during(() -> HIP.synchronize(e)) > 1000
        @test HIP.isdone(e)
    end

    # the null stream belongs to the current device, which the worker has to select
    let s = HIP.default_stream()
        busy(n; stream=s)
        @test !HIP.isdone(s)
        @test progress_during(() -> AMDGPU.synchronize(s)) > 1000
        @test HIP.isdone(s)
    end

    # opting out
    let s = HIPStream()
        busy(n; stream=s)
        @test !HIP.isdone(s)
        @test progress_during(() -> AMDGPU.synchronize(s; blocking=true)) < 1000
    end

    if length(AMDGPU.devices()) > 1
        # waiting for another device doesn't change the one this task uses
        dev = AMDGPU.device()
        other = first(d for d in AMDGPU.devices() if d != dev)
        s = AMDGPU.device!(() -> HIPStream(), other)
        AMDGPU.device!(() -> busy(1; stream=s), other)
        HIP.synchronize(s; spin=false)
        @test HIP.isdone(s)
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
