@testset "Launch Configuration" begin
    kernel(x) = nothing

    device = AMDGPU.default_device()
    queue = AMDGPU.default_queue(device)

    # Group/grid size selection and aliases
    eval(:(@roc groupsize=2 $kernel(1)))
    eval(:(@roc groupsize=2 gridsize=4 $kernel(1)))
    eval(:(@roc gridsize=2 $kernel(1)))
    eval(:(@roc threads=2 $kernel(1)))
    eval(:(@roc blocks=4 $kernel(1)))
    eval(:(@roc threads=2 gridsize=4 $kernel(1)))

    # Device/queue selection and aliases
    eval(:(@roc device=$device $kernel(1)))
    eval(:(@roc device=$device queue=$queue $kernel(1)))
    eval(:(@roc queue=$queue $kernel(1)))
    eval(:(@roc agent=$device $kernel(1)))
    eval(:(@roc stream=$queue $kernel(1)))
    eval(:(@roc agent=$device queue=$queue $kernel(1)))
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
