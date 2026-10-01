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
    # keep the GPU busy until the host opens a gate. this keeps the tests below independent
    # of timing: a synchronization can only return after the task that opens the gate has
    # run. if that does not happen (e.g., because the thread it runs on is blocked), the
    # kernel gives up after `limit` sleeps, and records that it timed out, instead of hanging.
    function gate_kernel(gate::Ptr{UInt32}, limit)
        for _ in 1:limit
            unsafe_load(gate, :acquire) != 0 && return
            AMDGPU.Device.device_sleep(Int32(127))
        end
        unsafe_store!(gate, UInt32(1), 2)
        return
    end
    gate_buf = Mem.HostBuffer(2 * sizeof(UInt32), HIP.hipHostMallocCoherent)
    gate = unsafe_wrap(Array, Ptr{UInt32}(gate_buf.ptr), 2)     # (is open, timed out)
    gate_ptr = Ptr{UInt32}(gate_buf.dev_ptr)
    # a sleep takes 127 * 64 cycles, so this takes at least 20 s at current clock rates
    timeout = 7_500_000
    open_gate() = unsafe_store!(pointer(gate), UInt32(1), :release)
    gate_is_open() = unsafe_load(pointer(gate), :acquire) != 0

    # run `f` while a kernel on `stream` keeps the GPU busy until the gate is opened,
    # returning what `f` returned and whether the kernel timed out.
    function gated(f, stream; limit = timeout)
        # while the gate is closed, nothing on the host may wait for the GPU to become idle,
        # as e.g. freeing memory does. so avoid running finalizers, by collecting beforehand
        # and not collecting while the gate is closed.
        GC.gc(true)
        gc_enabled = GC.enable(false)
        ret = try
            gate .= 0
            @roc stream=stream gate_kernel(gate_ptr, limit)
            f()
        finally
            open_gate()
            GC.enable(gc_enabled)
            # also when `f` failed, as the gate is reused
            AMDGPU.synchronize(stream)
        end
        return ret, gate[2] != 0
    end

    # run `f` while another task on the same thread opens the gate, but only after it got
    # to run many more times than the polling at the start of a synchronization yields.
    # returns whether `f` only returned after the gate had been opened.
    function open_gate_during(f)
        t = @async begin
            for _ in 1:10_000
                yield()
            end
            open_gate()
        end
        try
            f()
            gate_is_open()
        finally
            wait(t)
        end
    end

    # set up everything beforehand: compiling and loading the kernel, or creating the
    # queue backing a stream (which HIP does when first using it), may wait for the GPU.
    streams = [HIPStream() for _ in 1:5]
    event = HIP.HIPEvent(streams[3]; do_record=false)
    open_gate()
    for s in (streams..., HIP.default_stream(), AMDGPU.stream())
        @roc stream=s gate_kernel(gate_ptr, 1)
        AMDGPU.synchronize(s)
    end

    let s = streams[1]
        @test gated(s) do
            open_gate_during(() -> AMDGPU.synchronize(s)) && HIP.isdone(s)
        end == (true, false)
    end

    let s = streams[2]
        @test gated(s) do
            open_gate_during(() -> HIP.synchronize(s; spin=false)) && HIP.isdone(s)
        end == (true, false)
    end

    let s = streams[3]
        @test gated(s) do
            HIP.record(event)
            open_gate_during(() -> HIP.synchronize(event)) && HIP.isdone(event)
        end == (true, false)
    end

    let s = streams[4]
        @test gated(s) do
            open_gate_during(HIP.device_synchronize) && HIP.isdone(s)
        end == (true, false)
    end

    # the null stream belongs to the current device, which the worker has to select
    let s = HIP.default_stream()
        @test gated(s) do
            open_gate_during(() -> AMDGPU.synchronize(s)) && HIP.isdone(s)
        end == (true, false)
    end

    # opting out blocks the thread, so the gate can only open once the kernel gave up
    let s = streams[5]
        @test gated(s; limit = 10_000) do
            open_gate_during(() -> AMDGPU.synchronize(s; blocking=true))
        end == (false, true)
    end

    Mem.free(gate_buf)

    noop_kernel() = return
    if length(AMDGPU.devices()) > 1
        # waiting for another device doesn't change the one this task uses
        dev = AMDGPU.device()
        other = first(d for d in AMDGPU.devices() if d != dev)
        s = AMDGPU.device!(() -> HIPStream(), other)
        AMDGPU.device!(() -> (@roc stream=s noop_kernel()), other)
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
