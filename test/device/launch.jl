@testset "Launch Configuration" begin
    kernel() = nothing

    device = AMDGPU.default_device()
    queue = AMDGPU.default_queue(device)

    # Group/grid size selection and aliases
    for (groupsize,gridsize) in (
        (1,1),
        (2,4),
        (1024,1024),

        ((1,1),(2,2)),
        ((1024,1),(1024,2)),

        ((1,1,1),(2,2,2)),
        ((1024,1,1),(1024,2,2)),

        ((1,1,1),2),
        (1,(1024,1,1)),
    )
        eval(:(@roc groupsize=$groupsize $kernel()))
        eval(:(@roc groupsize=$groupsize gridsize=$gridsize $kernel()))
        eval(:(@roc gridsize=$gridsize $kernel()))

        threads = groupsize
        blocks = gridsize .÷ groupsize
        eval(:(@roc threads=$threads $kernel()))
        eval(:(@roc blocks=$blocks $kernel()))
        eval(:(@roc threads=$threads blocks=$blocks $kernel()))
    end

    # Device/queue selection and aliases
    # FIXME: Test that device/queue are used!
    eval(:(@roc device=$device $kernel()))
    eval(:(@roc device=$device queue=$queue $kernel()))
    eval(:(@roc queue=$queue $kernel()))
    eval(:(@roc stream=$queue $kernel()))

    # Non-default queue
    queue2 = ROCQueue()
    sig = @roc queue=queue2 kernel()
    @test sig.queue === queue2

    # Group size validity
    @test_throws ArgumentError eval(:(@roc groupsize=0 $kernel()))
    eval(:(@roc groupsize=1024 $kernel()))
    @test_throws ArgumentError eval(:(@roc groupsize=1025 $kernel()))
    @test_throws ArgumentError eval(:(@roc groupsize=(1024,2) $kernel()))
    @test_throws ArgumentError eval(:(@roc groupsize=(512,2,2) $kernel()))

    # No-launch
    @test eval(:(@roc launch=true $kernel())) isa AMDGPU.ROCKernelSignal
    @test eval(:(@roc launch=false $kernel())) isa Runtime.HostKernel
    @test_throws Exception eval(:(@roc launch=1 $kernel())) # TODO: ArgumentError
end

@testset "No-argument kernel" begin
    kernel() = nothing

    wait(@roc kernel())
end

@testset "Kernel argument alignment" begin
    function kernel(x, y)
        if Int64(x) != y
            error("Fail!")
        end
        nothing
    end
    x = rand(UInt32)
    y = Int64(x)
    wait(@roc kernel(x, y))
end

@testset "Function/Argument Conversion" begin
    @testset "Closure as Argument" begin
        function kernel(closure)
            closure()
            nothing
        end
        function outer(a_dev, val)
            f() = a_dev[] = val
            @roc kernel(f)
        end

        a = [1.]
        a_dev = ROCArray(a)

        outer(a_dev, 2.)

        @test Array(a_dev) == [2.]
    end
end

@testset "Signal waiting" begin
    sig = @roc identity(nothing)
    wait(sig)
    wait(sig.signal)
    wait(sig.signal.signal[])
    @test sig.queue === AMDGPU.default_queue()
end

@testset "Custom signal" begin
    sig = ROCSignal()
    sig2 = @roc signal=sig identity(nothing)
    @test sig2.signal == sig
    wait(sig)
    wait(sig2)
end

if length(AMDGPU.devices()) > 1
    @testset "Multi-GPU" begin
        # HSA will throw if the compiler and launch use different devices
        a1, a2 = AMDGPU.devices()[1:2]
        wait(@roc device=a1 identity(nothing))
        wait(@roc device=a2 identity(nothing))
    end
else
    @warn "Only 1 GPU detected; skipping multi-GPU tests"
    @test_broken "Multi-GPU"
end
