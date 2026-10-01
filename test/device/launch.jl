using Test
using AMDGPU
using AMDGPU: Device, Runtime, ROCArray, @roc, @ROCStaticLocalArray, HIPStream
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim

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

@testset "Many arguments" begin
    # more arguments than Julia splats or maps over without falling back to dynamic calls
    params = [Symbol(:x, i) for i in 1:40]
    @eval function many_args_kernel(out, $(params...))
        out[1] = $(foldl((a, b) -> :($a + $b), params))
        return
    end
    @eval many_args_launch(out) = @roc many_args_kernel(out, $(1:40...))
    @eval many_args_call(kernel, out) = kernel(out, $(1:40...); groupsize=1)

    few_args_kernel(out, x) = (out[1] = x; return)
    few_args_launch(out) = @roc few_args_kernel(out, 1)
    few_args_call(kernel, out) = kernel(out, 1; groupsize=1)

    out = ROCArray([0])
    kernel = Base.invokelatest(many_args_launch, out)
    @test Array(out)[1] == sum(1:40)
    @test Base.invokelatest(many_args_call, kernel, out) === nothing
    @test Array(out)[1] == sum(1:40)

    # launching should not be much more expensive than with few arguments
    # (Julia 1.11 and older allocate a little per argument)
    Base.invokelatest() do
        @inferred many_args_launch(out)
        few_kernel = few_args_launch(out)
        few_args_call(few_kernel, out)
        @test @allocated(many_args_launch(out)) <= @allocated(few_args_launch(out)) + 40*32
        @test @allocated(many_args_call(kernel, out)) <=
              @allocated(few_args_call(few_kernel, out)) + 40*32
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

    # TODO Come up with more robust test.
    # @testset "Local memory" begin
    #     function f(X)
    #         Y = @ROCStaticLocalArray(Float32, 16)
    #         # N.B. Use unsafe accesses to avoid bounds checks from `--check-bounds=yes`
    #         unsafe_store!(Y.ptr, unsafe_load(X.ptr))
    #         return
    #     end

    #     RX = ROCArray(rand(Float32, 1))
    #     # Test that localmem is properly accounted for
    #     occ1 = AMDGPU.launch_configuration(@roc launch=false f(RX))
    #     occ2 = AMDGPU.launch_configuration(@roc launch=false f(RX); shmem=65536 ÷ 2)
    #     @test occ1 != occ2
    # end
end

if VERSION >= v"1.12-" && !iszero(AMDGPU.HIP.properties(AMDGPU.device()).cooperativeLaunch)
    @testset "Cooperative Groups" begin
        function test_kernel!(x)
            block_row, block_col = workgroupIdx().x, workgroupIdx().y

            for diag in 2:(gridGroupDim().x + gridGroupDim().y)
                if block_row + block_col == diag
                    if diag == 2
                        x[block_col, block_row] = 1
                    else
                        x[block_col, block_row] = 0
                        for I in CartesianIndices(x)
                            i, j = Tuple(I)
                            i + j == diag - 1 || continue
                            x[block_col, block_row] += x[I]
                        end
                    end
                end
                AMDGPU.Device.sync_grid()
            end

            return nothing
        end

        n = 4
        x = ROCArray{Int}(undef, n, n)
        @roc groupsize = (1, 1, 1) gridsize = (n, n, 1) cooperative = true test_kernel!(x)
        @test Array(x) == [1 1 2 6; 1 2 6 24; 2 6 24 72; 6 24 72 144]
    end
end
