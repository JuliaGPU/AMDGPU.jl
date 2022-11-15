@testset "Launch Options" begin
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
        eval(:(wait(@roc groupsize=$groupsize $kernel())))
        eval(:(wait(@roc groupsize=$groupsize gridsize=$gridsize $kernel())))
        eval(:(wait(@roc gridsize=$gridsize $kernel())))

        threads = groupsize
        blocks = gridsize .÷ groupsize
        eval(:(wait(@roc threads=$threads $kernel())))
        eval(:(wait(@roc blocks=$blocks $kernel())))
        eval(:(wait(@roc threads=$threads blocks=$blocks $kernel())))
    end

    # Device/queue selection and aliases
    # FIXME: Test that device/queue are used!
    eval(:(wait(@roc device=$device $kernel())))
    eval(:(wait(@roc device=$device queue=$queue $kernel())))
    eval(:(wait(@roc queue=$queue $kernel())))
    eval(:(wait(@roc stream=$queue $kernel())))

    # Non-default queue
    queue2 = ROCQueue()
    sig = @roc queue=queue2 kernel()
    @test sig.queue === queue2

    # Group size validity
    @test_throws ArgumentError eval(:(wait(@roc groupsize=0 $kernel())))
    eval(:(wait(@roc groupsize=1024 $kernel())))
    @test_throws ArgumentError eval(:(wait(@roc groupsize=1025 $kernel())))
    @test_throws ArgumentError eval(:(wait(@roc groupsize=(1024,2) $kernel())))
    @test_throws ArgumentError eval(:(wait(@roc groupsize=(512,2,2) $kernel())))

    # No-launch
    kersig = eval(:(@roc launch=true $kernel()))
    @test isa(kersig, AMDGPU.ROCKernelSignal)
    wait(kersig)

    host_kernel = eval(:(@roc launch=false $kernel()))
    @test isa(host_kernel, Runtime.HostKernel)

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

@testset "Launch Configuration" begin
    kern = @roc launch=false identity(nothing)
    occ = AMDGPU.launch_configuration(kern)
    @test occ isa NamedTuple
    @test haskey(occ, :groupsize)
    # This kernel has no occupancy constraints
    @test occ.groupsize == AMDGPU.Device._max_group_size

    @testset "Automatic groupsize selection" begin
        function groupsize_kernel(A)
            A[1] = workgroupDim().x
            nothing
        end
        A = AMDGPU.ones(Int, 1)
        kern = @roc launch=false groupsize_kernel(A)
        # Verify first that there are no occupancy constraints
        @test AMDGPU.launch_configuration(kern).groupsize == AMDGPU.Device._max_group_size
        # Then check that this value was used
        wait(@roc groupsize=:auto identity(nothing))
        @test Array(A)[1] == AMDGPU.Device._max_group_size
    end
end
