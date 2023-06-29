@testset "Launch Options" begin
    kernel() = nothing

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
        @roc groupsize=groupsize kernel()
        @roc groupsize=groupsize gridsize=gridsize kernel()
        @roc gridsize=gridsize kernel()
    end

    stream = AMDGPU.stream()
    @roc stream=stream kernel()
    AMDGPU.synchronize()

    # Non-default stream
    stream2 = HIPStream()
    @roc stream=stream2 kernel()
    AMDGPU.synchronize(stream2)

    # Group size validity
    @test_throws AMDGPU.HIP.HIPError @roc groupsize=0 kernel()
    @test_throws AMDGPU.HIP.HIPError @roc groupsize=1025 kernel()
    @test_throws AMDGPU.HIP.HIPError @roc groupsize=(1024, 2) kernel()
    @test_throws AMDGPU.HIP.HIPError @roc groupsize=(512, 2, 2) kernel()

    # No-launch
    host_kernel = @roc launch=false kernel()
    @test isa(host_kernel, Runtime.HIPKernel)
    @test_throws Exception eval(:(@roc launch=1 $kernel())) # TODO: ArgumentError
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
    @roc kernel(x, y)
    AMDGPU.synchronize()
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

        a_dev = ROCArray([1.0])
        outer(a_dev, 2.0)
        @test Array(a_dev) == [2.0]
    end
end

if length(AMDGPU.devices()) > 1
    @testset "Multi-GPU" begin
        dev = AMDGPU.device()

        AMDGPU.device!(AMDGPU.devices()[2])
        @roc identity(nothing)

        AMDGPU.device!(dev)
        @roc identity(nothing)
    end
else
    @warn "Only 1 GPU detected; skipping multi-GPU tests"
    @test_skip "Multi-GPU"
end

@testset "Launch Configuration" begin
    function f(x)
        x[1] = 1
        return
    end
    x = ROCArray([1])
    kern = @roc launch=false f(x)
    occ = AMDGPU.launch_configuration(kern)
    @test occ isa NamedTuple
    @test haskey(occ, :groupsize) && haskey(occ, :gridsize)
    # This kernel has no occupancy constraints
    @test occ.groupsize == AMDGPU.Device._max_group_size

    # TODO
    # @testset "Automatic groupsize selection" begin
    #     function groupsize_kernel(A)
    #         A[1] = workgroupDim().x
    #         nothing
    #     end
    #     A = AMDGPU.ones(Int, 1)
    #     kern = @roc launch=false groupsize_kernel(A)
    #     # Verify first that there are no occupancy constraints
    #     @test AMDGPU.launch_configuration(kern).groupsize == AMDGPU.Device._max_group_size
    #     @roc groupsize=:auto groupsize_kernel(A)
    #     @test Array(A)[1] == AMDGPU.Device._max_group_size
    # end

    @testset "Local memory" begin
        function f(X)
            Y = @ROCStaticLocalArray(Float32, 16)
            # N.B. Use unsafe accesses to avoid bounds checks from `--check-bounds=yes`
            unsafe_store!(Y.ptr, unsafe_load(X.ptr))
            return
        end

        RX = ROCArray(rand(Float32, 1))
        # Test that localmem is properly accounted for
        occ1 = AMDGPU.launch_configuration(@roc launch=false f(RX))
        occ2 = AMDGPU.launch_configuration(@roc launch=false f(RX); shmem=65536 ÷ 2)
        @test occ1 != occ2
    end
end
