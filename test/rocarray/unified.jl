using KernelAbstractions
using AMDGPU.HIP

@testset "Unified Memory" begin

@testset "Allocation and deallocation" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 2, B}(undef, 16, 12)
    @test size(x) == (16, 12)
    @test x.buf[].mem isa B
    AMDGPU.unsafe_free!(x)
end

@testset "Host and device access" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 16)

    x .= 1.0f0
    @test Array(x) == ones(Float32, 16)

    x .+= 2.0f0
    @test Array(x) == fill(3.0f0, 16)
end

@testset "Memory advise" begin
    dev = AMDGPU.device()
    if HIP.attribute(dev, HIP.hipDeviceAttributeManagedMemory) == 1
        B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
        x = ROCArray{Float32, 1, B}(undef, 1024)
        buf = x.buf[].mem

        AMDGPU.Runtime.Mem.advise!(buf, HIP.hipMemAdviseSetReadMostly)
        @test AMDGPU.Runtime.Mem.query_attribute(buf, HIP.hipMemRangeAttributeReadMostly)

        AMDGPU.Runtime.Mem.advise!(buf, HIP.hipMemAdviseUnsetReadMostly)
        @test !AMDGPU.Runtime.Mem.query_attribute(buf, HIP.hipMemRangeAttributeReadMostly)
    else
        @test_skip "Device does not support managed memory"
    end
end

@testset "Prefetching" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 1024)
    buf = x.buf[].mem

    AMDGPU.Runtime.Mem.prefetch!(buf)
    x .= 1.0f0
    @test Array(x) == ones(Float32, 1024)
end

@testset "Preferred location" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 512)
    buf = x.buf[].mem

    AMDGPU.Runtime.Mem.advise!(buf, HIP.hipMemAdviseSetPreferredLocation, AMDGPU.device())
    x .= 2.0f0
    @test Array(x) == fill(2.0f0, 512)
end

@testset "Coarse-grain coherency" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 256)
    buf = x.buf[].mem

    AMDGPU.Runtime.Mem.advise!(buf, HIP.hipMemAdviseSetCoarseGrain)
    x .= 3.0f0
    @test Array(x) == fill(3.0f0, 256)

    AMDGPU.Runtime.Mem.advise!(buf, HIP.hipMemAdviseUnsetCoarseGrain)
end

@testset "Interop with HIPBuffer" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 32)
    y = AMDGPU.ones(Float32, 32)

    copyto!(x, y)
    @test Array(x) == ones(Float32, 32)

    x .+= 1.0f0
    copyto!(y, x)
    @test Array(y) == fill(2.0f0, 32)
end

@testset "Broadcasting" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 64)
    y = ROCArray{Float32, 1, B}(undef, 64)

    x .= 1.0f0
    y .= 2.0f0
    z = x .+ y
    @test Array(z) == fill(3.0f0, 64)
end

@testset "Reduction operations" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 128)

    x .= 1.0f0
    @test sum(x) == 128.0f0
    @test maximum(x) == 1.0f0
    @test minimum(x) == 1.0f0
end

@testset "View operations" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 1, B}(undef, 16)

    x .= 1.0f0:16.0f0
    v = view(x, 5:12)
    @test Array(v) == collect(5.0f0:12.0f0)

    v .= 0.0f0
    @test Array(x[5:12]) == zeros(Float32, 8)
end

@testset "Multidimensional arrays" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Float32, 3, B}(undef, 4, 8, 16)

    x .= 1.0f0
    @test size(x) == (4, 8, 16)
    @test Array(x) == ones(Float32, 4, 8, 16)
end

@testset "resize!" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer
    x = ROCArray{Int, 1, B}(undef, 10)

    x .= 1:10
    resize!(x, 15)
    x[11:15] .= 11:15
    @test Array(x) == 1:15

    resize!(x, 5)
    @test Array(x) == 1:5
end

@testset "unsafe_wrap(Array, ::ROCArray)" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer

    # Test with unified memory
    x = ROCArray{Float32, 1, B}(undef, 100)
    x .= 1.0f0
    AMDGPU.synchronize()

    # Wrap as CPU array
    cpu_view = unsafe_wrap(Array, x)
    @test cpu_view isa Array{Float32, 1}
    @test size(cpu_view) == size(x)
    @test cpu_view ≈ ones(Float32, 100)

    # Modify through CPU view
    cpu_view[1] = 42.0f0
    cpu_view[50] = 99.0f0
    @test Array(x)[1] == 42.0f0
    @test Array(x)[50] == 99.0f0

    # Test with multidimensional array
    y = ROCArray{Int32, 2, B}(undef, 10, 20)
    y .= 1
    AMDGPU.synchronize()

    cpu_view2 = unsafe_wrap(Array, y)
    @test cpu_view2 isa Array{Int32, 2}
    @test size(cpu_view2) == (10, 20)
    @test all(cpu_view2 .== 1)

    # Test that it fails for device-only memory
    z = ROCArray{Float32, 1}(undef, 10)  # Default HIPBuffer
    @test_throws ArgumentError unsafe_wrap(Array, z)

    # Test with HostBuffer
    HB = AMDGPU.Runtime.Mem.HostBuffer
    h = ROCArray{Float64, 1, HB}(undef, 50)
    h .= 2.0
    AMDGPU.synchronize()

    cpu_view3 = unsafe_wrap(Array, h)
    @test cpu_view3 isa Array{Float64, 1}
    @test size(cpu_view3) == (50,)
    @test cpu_view3 == fill(2.0, 50)

    cpu_view3[25] = 3.14
    @test Array(h)[25] == 3.14
end

@testset "Scalar indexing" begin
    B = AMDGPU.Runtime.Mem.HIPUnifiedBuffer

    # Test scalar getindex with unified memory
    x = ROCArray{Float32, 1, B}(undef, 100)
    x .= 1.0f0:100.0f0
    AMDGPU.synchronize()

    @test x[1] == 1.0f0
    @test x[50] == 50.0f0
    @test x[100] == 100.0f0

    # Test scalar setindex! with unified memory
    x[1] = 42.0f0
    x[50] = 99.0f0
    AMDGPU.synchronize()

    @test x[1] == 42.0f0
    @test x[50] == 99.0f0
    @test Array(x)[1] == 42.0f0
    @test Array(x)[50] == 99.0f0

    # Test with multidimensional arrays
    y = ROCArray{Int32, 2, B}(undef, 10, 20)
    y .= reshape(1:200, 10, 20)
    AMDGPU.synchronize()

    @test y[1, 1] == 1
    @test y[10, 20] == 200
    @test y[5, 10] == 95

    y[1, 1] = 999
    y[5, 10] = 888
    AMDGPU.synchronize()

    @test y[1, 1] == 999
    @test y[5, 10] == 888

    # Test with HostBuffer
    HB = AMDGPU.Runtime.Mem.HostBuffer
    h = ROCArray{Float64, 1, HB}(undef, 50)
    h .= 2.0:51.0
    AMDGPU.synchronize()

    @test h[1] == 2.0
    @test h[25] == 26.0
    @test h[50] == 51.0

    h[25] = 3.14
    AMDGPU.synchronize()
    @test h[25] == 3.14

    # Test bounds checking
    @test_throws BoundsError x[0]
    @test_throws BoundsError x[101]
    @test_throws BoundsError y[0, 1]
    @test_throws BoundsError y[1, 21]
end

@testset "KernelAbstractions integration" begin
    import KernelAbstractions as KA

    # Test supports_unified
    backend = ROCBackend()
    @test KA.supports_unified(backend) isa Bool

    if KA.supports_unified(backend)
        # Test unified allocate with kwarg
        x = KA.allocate(backend, Float32, (16, 16); unified=true)
        @test x isa ROCArray{Float32, 2, AMDGPU.Runtime.Mem.HIPUnifiedBuffer}
        @test size(x) == (16, 16)

        # Test basic operations with unified memory
        fill!(x, 1.0f0)
        @test Array(x) == ones(Float32, 16, 16)

        # Test kernel execution with unified memory
        @kernel function addone_kernel!(x)
            i = @index(Global)
            x[i] += 1.0f0
        end
        addone_kernel!(backend)(x, ndrange=length(x))
        KA.synchronize(backend)
        @test Array(x) == fill(2.0f0, 16, 16)

        AMDGPU.unsafe_free!(x)

        # Test non-unified allocation (default)
        y = KA.allocate(backend, Float32, (16, 16); unified=false)
        @test y isa ROCArray{Float32, 2, AMDGPU.Runtime.Mem.HIPBuffer}
        AMDGPU.unsafe_free!(y)
    else
        # Device doesn't support unified memory
        @test_throws ArgumentError KA.allocate(backend, Float32, (16, 16); unified=true)
    end
end

end
