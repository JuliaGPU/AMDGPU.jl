using Test
using AMDGPU
using AMDGPU: ROCArray, HIPDevice, HIPStream

@testset "Device" begin
    d1 = @inferred AMDGPU.device()
    @test d1 isa HIPDevice

    AMDGPU.device!(d1)

    d2 = AMDGPU.device()
    @test d1 ≡ d2
    @test AMDGPU.default_device() == d1
    @test fetch(@async AMDGPU.device()) == AMDGPU.default_device()

    x = AMDGPU.device!(() -> ROCArray{Int}(undef, 16), d1)
    @test AMDGPU.device(x) ≡ d1
end

@testset "GC finalizers leave task-local state alone" begin
    # GC runs finalizers on whichever task it interrupts. Freeing an array makes
    # HIP calls, which must not create state on that task.
    weak_array() = WeakRef(ROCArray{Float32}(undef, 16))
    w = weak_array()
    no_state, collected = fetch(@async begin
        GC.gc(true)
        (AMDGPU.task_local_state() ≡ nothing, w.value ≡ nothing)
    end)
    @test collected
    @test no_state
end

if length(AMDGPU.devices()) > 1
    @testset "Scoped switch in a GC finalizer" begin
        # Destructors use `context!(f, ctx)`. In a GC finalizer, it must switch
        # for the HIP calls in `f` without touching the interrupted task's state.
        default = fetch(@async AMDGPU.device())
        other = first(d for d in AMDGPU.devices() if d != default)
        ctx = AMDGPU.HIPContext(other)
        seen = Ref{Any}(nothing)
        function weak_switcher()
            obj = Ref(0)
            finalizer(obj) do _
                seen[] = AMDGPU.context!(ctx) do
                    AMDGPU.HIP.hipDeviceSynchronize() # a checked call
                    AMDGPU.HIP.device()
                end
            end
            return WeakRef(obj)
        end
        w = weak_switcher()
        no_state, collected = fetch(@async begin
            GC.gc(true)
            (AMDGPU.task_local_state() ≡ nothing, w.value ≡ nothing)
        end)
        @test collected
        @test seen[] == other
        @test no_state
    end
end

@testset "Stream" begin
    s1 = @inferred AMDGPU.stream()
    @test s1 isa AMDGPU.HIPStream

    AMDGPU.stream!(s1)

    s2 = AMDGPU.stream()
    @test s1 ≡ s2

    AMDGPU.stream!(() -> AMDGPU.ones(Float32, 16), s1)
    @test AMDGPU.stream() ≡ s1

    @testset "Priority" begin
        @test AMDGPU.priority() == :normal

        AMDGPU.priority!(:low)
        @test AMDGPU.priority() == :low

        AMDGPU.priority!(:high)
        @test AMDGPU.priority() == :high

        AMDGPU.priority!(:normal)
        s1 = AMDGPU.stream()

        AMDGPU.priority!(() -> AMDGPU.ones(Float32, 16), :low)
        s2 = AMDGPU.stream()
        @test s1 ≡ s2
    end

    @testset "Recycling" begin
        idle_limit = AMDGPU.HIP.STREAM_POOL_IDLE
        pool(priority=:normal) =
            AMDGPU.HIP.STREAM_POOLS[(AMDGPU.HIP.device_id(AMDGPU.device()), priority)]
        function finished(entry)
            owner = entry.owner.value
            return owner === nothing || istaskdone(owner)
        end

        # call `f` with the streams of `n` tasks that are alive at the same time
        function with_concurrent_streams(f, n)
            ready = Channel{HIPStream}(Inf)
            release = Base.Event()
            tasks = [Threads.@spawn begin
                         try
                             put!(ready, AMDGPU.stream())
                         catch err
                             # don't leave the caller waiting for our stream
                             close(ready, err)
                             rethrow()
                         end
                         wait(release)
                     end for _ in 1:n]
            try
                f([take!(ready) for _ in tasks])
            finally
                notify(release)
                foreach(wait, tasks)
            end
        end

        # s_sleep instead of a clock: gfx11+ lacks s_memrealtime
        function nap(n)
            for _ in 1:n
                AMDGPU.Device.device_sleep(Int32(127))
            end
            return
        end
        keep_busy() = @roc nap(300_000)  # for about a second
        set42!(a) = (a[1] = 42; nothing)

        # finished tasks hand their stream to new ones, without having to wait for the GC
        streams = [fetch(Threads.@spawn AMDGPU.stream()) for _ in 1:2idle_limit]
        @test length(unique(streams)) <= idle_limit
        @test all(s -> any(entry -> entry.stream === s, pool()), streams)

        # tasks running at the same time never share a stream, even beyond the pool's size,
        # but only a limited number of idle streams is kept around afterwards
        streams = with_concurrent_streams(identity, idle_limit + 8)
        @test allunique(streams)
        foreach(AMDGPU.synchronize, streams)
        @test fetch(Threads.@spawn AMDGPU.stream()) in streams
        @test count(finished, pool()) <= idle_limit + 1

        # tasks that keep their stream don't prevent others from being recycled
        with_concurrent_streams(idle_limit) do _
            streams = [fetch(Threads.@spawn AMDGPU.stream()) for _ in 1:8]
            @test length(unique(streams)) <= 2
        end

        # switching priorities doesn't make a task take more and more streams
        streams = fetch(Threads.@spawn begin
            [AMDGPU.priority!(AMDGPU.stream, :high) for _ in 1:2idle_limit]
        end)
        @test allequal(streams)
        @test fetch(Threads.@spawn begin
            s1 = AMDGPU.stream()
            AMDGPU.priority!(:high)
            s2 = AMDGPU.stream()
            AMDGPU.priority!(:normal)
            s3 = AMDGPU.stream()
            AMDGPU.priority!(:high)
            s4 = AMDGPU.stream()
            s1 === s3 && s2 === s4 && s1 !== s2
        end)

        # a stream that still has work queued isn't handed to another task
        busy = fetch(Threads.@spawn begin
            keep_busy()
            AMDGPU.stream()
        end)
        with_concurrent_streams(idle_limit) do streams
            if !AMDGPU.HIP.isdone(busy)
                @test !(busy in streams)
            end
        end
        AMDGPU.synchronize(busy)

        # streams that can't be used anymore are removed from the pool
        s = fetch(Threads.@spawn AMDGPU.stream())
        finalize(s)
        @test fetch(Threads.@spawn AMDGPU.stream()) !== s
        @test !any(entry -> entry.stream === s, pool())

        # memory knows that the work of a stream's previous owner has finished, so it
        # doesn't wait for the new owner, nor gets freed on its stream (which the new owner
        # may be capturing)
        a = fetch(Threads.@spawn begin
            a = ROCArray([42])
            AMDGPU.synchronize()
            a
        end)
        with_concurrent_streams(idle_limit) do streams
            @test a.buf[].stream in streams
            @test AMDGPU.recycled(a.buf[]) === true
            @test Array(a) == [42]
            @test AMDGPU.free_stream(a.buf[]) === AMDGPU.stream()
        end

        # wrapping the handle of a task's stream gives the pool's object, which keeps track
        # of recycling, and using memory through another object for the same stream doesn't
        # mistake it for a recycled stream
        a = fetch(Threads.@spawn begin
            s = AMDGPU.stream()
            @test HIPStream(s.stream) === s
            a = ROCArray([0])
            AMDGPU.synchronize()
            @test AMDGPU.HIP.generation(s) > 0
            AMDGPU.stream!(HIPStream(s.stream, s.priority, s.device, s.ctx, true, 0))
            @roc set42!(a)
            a
        end)
        @test AMDGPU.recycled(a.buf[]) === false
        @test Array(a) == [42]

        # looking for a stream to recycle doesn't break graph capture
        graph = AMDGPU.capture() do
            @test fetch(Threads.@spawn AMDGPU.stream()) !== AMDGPU.stream()
        end
    end

    @testset "Validity" begin
        s = HIPStream()
        @test AMDGPU.HIP.isvalid(s)

        finalize(s)
        @test !AMDGPU.HIP.isvalid(s)

        # Must return true without segfaulting on an already-finalized stream.
        @test AMDGPU.HIP.isdone(s) == true
    end

    if length(AMDGPU.devices()) > 1
        @testset "Stream finalizer keeps the running task's device" begin
            # Finalizers run on whichever task triggers GC. The stream finalizer
            # must not move that task onto the stream's device.
            default = fetch(@async AMDGPU.device())
            other = first(d for d in AMDGPU.devices() if d != default)
            s = AMDGPU.device!(() -> HIPStream(), other)
            @test s.device == other
            @test fetch(@async (finalize(s); AMDGPU.device())) == default
        end
    end
end
