@testset "Launch Configuration" begin
    kernel() = nothing

    device = AMDGPU.default_device()
    queue = AMDGPU.default_queue(device)

    # Group/grid size selection and aliases
    eval(:(@roc groupsize=2 $kernel()))
    eval(:(@roc groupsize=2 gridsize=4 $kernel()))
    eval(:(@roc gridsize=2 $kernel()))
    #eval(:(@roc threads=2 $kernel(1)))
    #eval(:(@roc blocks=4 $kernel(1)))
    #eval(:(@roc threads=2 gridsize=4 $kernel(1)))

    # Device/queue selection and aliases
    # FIXME: Test that device/queue are used!
    eval(:(@roc device=$device $kernel()))
    eval(:(@roc device=$device queue=$queue $kernel()))
    eval(:(@roc queue=$queue $kernel()))
    eval(:(@roc agent=$device $kernel()))
    eval(:(@roc stream=$queue $kernel()))
    eval(:(@roc agent=$device queue=$queue $kernel()))

    # Group size validity
    @test_throws ArgumentError eval(:(@roc groupsize=0 $kernel()))
    eval(:(@roc groupsize=1024 $kernel()))
    @test_throws ArgumentError eval(:(@roc groupsize=1025 $kernel()))

    # No-launch
    @test eval(:(@roc launch=true $kernel())) isa HSASignal
    @test eval(:(@roc launch=false $kernel())) isa AMDGPU.HostKernel
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
