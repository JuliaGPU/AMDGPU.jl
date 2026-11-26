using Test
using Adapt
using AMDGPU
using AMDGPU: HIP, Mem, @allowscalar
import KernelInterface as KI

AMDGPU.allowscalar(false)

const HIPBuffer = Mem.HIPBuffer
const UnifiedBuffer = Mem.UnifiedBuffer
const HostBuffer = Mem.HostBuffer

@testset "unified memory" begin

@testset "memory types" begin
    @test AMDGPU.default_memory in (HIPBuffer, UnifiedBuffer, HostBuffer)
    @test AMDGPU.memory_type(ROCArray{Int}(undef, 1)) == AMDGPU.default_memory
    @test AMDGPU.memory_type(ROCArray([1])) == AMDGPU.default_memory
    @test AMDGPU.memory_type(ROCVector{Int, UnifiedBuffer}) == UnifiedBuffer
    @test AMDGPU.memory_type(ROCVector{Int}) == Any

    a = ROCVector{Int, HIPBuffer}(undef, 1)
    @test is_device(a) && !is_unified(a) && !is_host(a)
    a = ROCVector{Int, UnifiedBuffer}(undef, 1)
    @test !is_device(a) && is_unified(a) && !is_host(a)
    a = ROCVector{Int, HostBuffer}(undef, 1)
    @test !is_device(a) && !is_unified(a) && is_host(a)
end

@testset "buffer" begin
    buf = UnifiedBuffer(16 * sizeof(Int))
    @test sizeof(buf) == 16 * sizeof(Int)
    ptr = convert(Ptr{Int}, buf)
    @test ptr != C_NULL
    @test Mem.is_managed(ptr)
    @test Mem.device_ptr(buf) == Mem.host_ptr(buf) == buf.ptr
    @test !Mem.is_managed(pointer(zeros(Int, 1)))
    @test !Mem.is_managed(C_NULL)

    # accessible from the host
    unsafe_store!(ptr, 42, 16)
    @test unsafe_load(ptr, 16) == 42
    @test convert(Ptr{Int}, Mem.view(buf, 15 * sizeof(Int))) == ptr + 15 * sizeof(Int)

    Mem.prefetch(buf)
    Mem.prefetch(buf, 8 * sizeof(Int); device=nothing)
    Mem.advise(buf, HIP.hipMemAdviseSetReadMostly)
    Mem.advise(buf, HIP.hipMemAdviseUnsetReadMostly)
    @test_throws BoundsError Mem.prefetch(buf, 17 * sizeof(Int))
    @test_throws BoundsError Mem.advise(buf, HIP.hipMemAdviseSetReadMostly, 17 * sizeof(Int))
    AMDGPU.synchronize()
    @test unsafe_load(ptr, 16) == 42
    Mem.free(buf)

    empty = UnifiedBuffer(0)
    @test sizeof(empty) == 0
    Mem.prefetch(empty)
    Mem.free(empty)
end

@testset "accounting" begin
    # without the GC freeing the arrays of other tests in between
    GC.gc()
    GC.enable(false)
    try
        live = AMDGPU.host_stats().live
        a = ROCVector{Int, UnifiedBuffer}(undef, 1024)
        @test AMDGPU.host_stats().live == live + sizeof(a)
        AMDGPU.unsafe_free!(a)
        @test AMDGPU.host_stats().live == live
    finally
        GC.enable(true)
    end
end

@testset "host access ($B)" for B in (UnifiedBuffer, HostBuffer)
    a = ROCVector{Int, B}(undef, 4)
    fill!(a, 1)

    # scalar indexing happens on the CPU, so does not need `@allowscalar`
    @test a[1] == 1
    a[2] = 2
    @test a[2] == 2
    @test_throws BoundsError a[5]
    @test_throws BoundsError a[0] = 1

    # host accesses wait for the device
    a .+= 1
    @test a[2] == 3
    @test Array(a) == [2, 3, 2, 2]

    m = ROCMatrix{Float32, B}(reshape(Float32.(1:6), 2, 3))
    @test m[2, 3] == 6
    m[1, 2] = 0
    @test Array(m) == Float32[1 0 5; 2 4 6]

    # derived arrays, at an offset
    v = view(m, :, 2)
    @test v isa ROCVector{Float32, B}
    @test v[2] == 4
    v[1] = 7
    @test m[1, 2] == 7
    r = reshape(m, 3, 2)
    @test r[3, 1] == 7
    # non-contiguous views
    s = view(m, 2, :)
    @test s isa SubArray
    @test s[3] == 6
    @test pointer(s, 2; type=HostBuffer) == pointer(m, 4; type=HostBuffer)

    # pointers
    @test pointer(a; type=HostBuffer) isa Ptr{Int}
    @test pointer(a, 3; type=HostBuffer) == pointer(a; type=HostBuffer) + 2 * sizeof(Int)
    @test pointer(a, 3) == pointer(a) + 2 * sizeof(Int)
    @test unsafe_load(pointer(a, 2; type=HostBuffer)) == 3
    @test_throws "invalid pointer type" pointer(a; type=UnifiedBuffer)
    if B == UnifiedBuffer
        @test pointer(a; type=HostBuffer) == pointer(a)
    end

    # empty arrays
    e = ROCVector{Int, B}(undef, 0)
    @test Array(e) == Int[]
    @test copyto!(e, Int[]) === e
    @test isempty(unsafe_wrap(Array, e))
end

@testset "device memory is not host accessible" begin
    a = ROCVector{Int, HIPBuffer}([1, 2])
    @test_throws "cannot take the CPU address of GPU memory" pointer(a; type=HostBuffer)
    @test_throws "Can only create a CPU array object from a unified or host ROCArray" unsafe_wrap(Array, a)
    @test_throws ErrorException a[1]
    @test (@allowscalar a[1]) == 1
end

@testset "unsafe_wrap ($B)" for B in (UnifiedBuffer, HostBuffer)
    a = ROCVector{Float32, B}(Float32[1, 2, 3])
    for AT in (Array, Array{Float32}, Array{Float32, 1})
        @test unsafe_wrap(AT, a) isa Vector{Float32}
    end
    b = unsafe_wrap(Array, a)
    @test b == Float32[1, 2, 3]

    # changes on the host are visible on the device, and the other way around
    b[1] = 10
    @test Array(a .+ 1f0) == Float32[11, 3, 4]
    a .*= 2f0
    AMDGPU.synchronize(a)
    @test b == Float32[20, 4, 6]

    # host libraries can use the memory
    @test sum(b) == 30
    @test sort!(b; rev=true) == Float32[20, 6, 4]
    @test Array(a) == Float32[20, 6, 4]

    m = ROCMatrix{Float32, B}(undef, 2, 2)
    @test size(unsafe_wrap(Array, m)) == (2, 2)
    @test size(unsafe_wrap(Array, view(m, :, 2))) == (2,)

    @test_throws ArgumentError unsafe_wrap(Array, ROCVector{Union{Int, Nothing}, B}(undef, 1))
end

@testset "wrapping unified pointers" begin
    a = ROCVector{Int, UnifiedBuffer}([1, 2, 3])
    b = unsafe_wrap(ROCArray, pointer(a), size(a))
    @test b isa ROCVector{Int, UnifiedBuffer}
    b .+= 1
    @test a[1] == 2
    @test b[3] == 4
    AMDGPU.unsafe_free!(b)
    # the wrapper did not own the memory
    @test a[1] == 2

    buf = UnifiedBuffer(2 * sizeof(Int))
    live = AMDGPU.host_stats().live
    c = unsafe_wrap(ROCArray, convert(Ptr{Int}, buf), 2; own=true)
    @test is_unified(c)
    fill!(c, 3)
    @test c[2] == 3
    AMDGPU.unsafe_free!(c)
    @test AMDGPU.host_stats().live == live - 2 * sizeof(Int)
end

@testset "wrapping as a given memory type" begin
    hmm = AMDGPU.supports_hmm(AMDGPU.device())
    a = Float32[1, 2, 3]

    # host memory
    for b in (unsafe_wrap(ROCVector{Float32, HostBuffer}, a),
              unsafe_wrap(ROCVector{Float32, HostBuffer}, pointer(a), 3),
              unsafe_wrap(ROCVector{Float32, HostBuffer}, pointer(a), (3,)))
        @test b isa ROCVector{Float32, HostBuffer}
        @test Array(b) == a
        AMDGPU.unsafe_free!(b)
    end
    @test_throws "Cannot wrap host memory" unsafe_wrap(ROCVector{Float32, HIPBuffer}, a)
    @test_throws "Cannot wrap host memory" unsafe_wrap(ROCVector{Float32, HIPBuffer}, pointer(a), 3)
    # as unified memory, on devices that can access pageable memory
    if hmm
        b = unsafe_wrap(ROCVector{Float32, UnifiedBuffer}, a)
        @test b isa ROCVector{Float32, UnifiedBuffer}
        b .+= 1f0
        @test b[1] == 2f0
        @test a == Float32[2, 3, 4]
    else
        @test_throws "Cannot wrap system memory as unified memory" unsafe_wrap(ROCVector{Float32, UnifiedBuffer}, a)
        @test_throws "Cannot wrap system memory as unified memory" unsafe_wrap(ROCVector{Float32, UnifiedBuffer}, pointer(a), 3)
    end
    @test !Mem.is_registered(Ptr{Cvoid}(pointer(a)))

    # unified memory
    u = ROCVector{Float32, UnifiedBuffer}(a)
    b = unsafe_wrap(ROCVector{Float32, UnifiedBuffer}, pointer(u), 3)
    @test b isa ROCVector{Float32, UnifiedBuffer}
    @test b[3] == 3f0
    @test_throws "Cannot wrap unified memory" unsafe_wrap(ROCVector{Float32, HIPBuffer}, pointer(u), 3)
    @test_throws "Cannot wrap unified memory" unsafe_wrap(ROCVector{Float32, HostBuffer}, pointer(u), 3)

    # device memory
    d = ROCVector{Float32, HIPBuffer}(a)
    b = unsafe_wrap(ROCVector{Float32, HIPBuffer}, pointer(d), 3)
    @test b isa ROCVector{Float32, HIPBuffer}
    @test Array(b) == a
    @test_throws "Cannot wrap device memory" unsafe_wrap(ROCVector{Float32, UnifiedBuffer}, pointer(d), 3)
    @test_throws "Cannot wrap device memory" unsafe_wrap(ROCVector{Float32, HostBuffer}, pointer(d), 3)
end

@testset "copies ($B)" for B in (UnifiedBuffer, HostBuffer)
    data = collect(1:8)
    a = ROCVector{Int, B}(data)
    @test Array(a) == data
    @test collect(a) == data

    # partial copies, both ways
    h = zeros(Int, 8)
    copyto!(h, 2, a, 5, 3)
    @test h == [0, 5, 6, 7, 0, 0, 0, 0]
    copyto!(a, 6, [10, 20], 1, 2)
    @test Array(a) == [1, 2, 3, 4, 5, 10, 20, 8]
    @test_throws BoundsError copyto!(h, 7, a, 1, 3)
    @test_throws BoundsError copyto!(a, 7, h, 1, 3)

    # copies after device operations see their result
    a .= 0
    @test Array(a) == zeros(Int, 8)

    # between memory types
    for B2 in (HIPBuffer, UnifiedBuffer, HostBuffer)
        b = ROCVector{Int, B2}(data)
        c = ROCVector{Int, B}(undef, 8)
        @test copyto!(c, b) === c
        @test Array(c) == data
        d = ROCVector{Int, B2}(undef, 8)
        copyto!(d, c)
        @test Array(d) == data
    end

    @test copy(a) isa ROCVector{Int, B}
    @test similar(a) isa ROCVector{Int, B}
    @test similar(a, Float32, 2, 2) isa ROCMatrix{Float32, B}
    @test deepcopy(a) isa ROCVector{Int, B}

    # 2D and 3D copies
    m = ROCMatrix{Float32, B}(rand(Float32, 4, 4))
    n = ROCMatrix{Float32, B}(undef, 4, 4)
    fill!(n, 0f0)
    copyto!(n, CartesianIndices((2:3, 2:3)), m, CartesianIndices((1:2, 1:2)))
    @test Array(n)[2:3, 2:3] == Array(m)[1:2, 1:2]
end

@testset "isbits unions" begin
    a = ROCVector{Union{Int, Nothing}, UnifiedBuffer}([1, nothing, 3])
    @test a[1] === 1
    @test a[2] === nothing
    a[1] = nothing
    a[2] = 2
    @test Array(a) == [nothing, 2, 3]
    @test Array(a[2:3]) == [2, 3]
end

@testset "constructors and conversions" begin
    data = rand(Float32, 4)
    for B in (HIPBuffer, UnifiedBuffer, HostBuffer)
        a = ROCVector{Float32, B}(data)
        @test a isa ROCVector{Float32, B}

        # the memory type of the source is kept, unless another one is asked for
        @test ROCArray(a) isa ROCVector{Float32, B}
        @test ROCVector(a) isa ROCVector{Float32, B}
        @test ROCVector{Float32}(a) isa ROCVector{Float32, B}
        @test ROCArray{Float64}(a) isa ROCVector{Float64, B}
        @test ROCVector{Float64}(a) isa ROCVector{Float64, B}
        @test Array(ROCVector{Float64}(a)) == data
        @test ROCVector{Float32, B}(a) !== a
        @test convert(ROCVector{Float32, B}, a) === a
        for B2 in (HIPBuffer, UnifiedBuffer, HostBuffer)
            b = ROCVector{Float32, B2}(a)
            @test b isa ROCVector{Float32, B2}
            @test Array(b) == data
        end

        @test adapt(ROCArray, a) === a
        @test adapt(ROCArray{Float64}, a) isa ROCVector{Float64, B}
        @test adapt(ROCArray{<:Any, <:Any, B}, data) isa ROCVector{Float32, B}
    end
    @test adapt(ROCArray, data) isa ROCVector{Float32, AMDGPU.default_memory}
end

@testset "roc" begin
    @test roc([1.0]) isa ROCVector{Float32, AMDGPU.default_memory}
    @test roc([1.0]; device=true) isa ROCVector{Float32, HIPBuffer}
    @test roc([1.0]; unified=true) isa ROCVector{Float32, UnifiedBuffer}
    @test roc([1.0]; host=true) isa ROCVector{Float32, HostBuffer}
    @test roc([1.0 + 2.0im]; unified=true) isa ROCVector{ComplexF32, UnifiedBuffer}
    @test roc(Float16[1]; unified=true) isa ROCVector{Float16, UnifiedBuffer}
    @test roc([1]; unified=true) isa ROCVector{Int, UnifiedBuffer}
    @test roc(1:3; unified=true) === 1:3
    @test roc((a=[1.0], b=2); unified=true).a isa ROCVector{Float32, UnifiedBuffer}
    # like the constructors, `roc` copies arrays that are on the device already,
    # to the selected (or the default) type of memory
    for B in (HIPBuffer, UnifiedBuffer, HostBuffer)
        a = ROCVector{Float32, B}(Float32[1, 2])
        b = roc(a)
        @test b isa ROCVector{Float32, AMDGPU.default_memory}
        @test b !== a
        @test !Base.mightalias(a, b)
        @test Array(b) == Float32[1, 2]
        @test roc(ROCVector{Float64, B}([1.0])) isa ROCVector{Float32, AMDGPU.default_memory}
        for (kw, B2) in ((:device, HIPBuffer), (:unified, UnifiedBuffer), (:host, HostBuffer))
            c = roc(a; kw => true)
            @test c isa ROCVector{Float32, B2}
            @test c !== a
            @test Array(c) == Float32[1, 2]
        end
    end
    @test_throws ArgumentError("Can only specify one of `device`, `unified`, or `host`") roc([1]; device=true, host=true)
    @test_throws ArgumentError roc([1]; unified=true, host=true)
end

@testset "broadcast" begin
    u = roc([1f0, 2f0]; unified=true)
    d = roc([1f0, 2f0]; device=true)
    h = roc([1f0, 2f0]; host=true)

    @test u .+ u isa ROCVector{Float32, UnifiedBuffer}
    @test u .+ 1 isa ROCVector{Float32, UnifiedBuffer}
    @test d .+ d isa ROCVector{Float32, HIPBuffer}
    # mixing memory types gives unified memory
    for (x, y) in ((u, d), (d, u), (d, h), (h, u))
        z = x .+ y
        @test z isa ROCVector{Float32, UnifiedBuffer}
        @test Array(z) == Float32[2, 4]
    end
    @test u .+ reshape(d, 1, 2) isa ROCMatrix{Float32, UnifiedBuffer}
    @test map(+, u, u) isa ROCVector{Float32, UnifiedBuffer}
    @test Array(u' .* 2) == Float32[2 4]
end

@testset "operations" begin
    a = rand(Float32, 8, 8)
    u = ROCMatrix{Float32, UnifiedBuffer}(a)

    @test sum(u) ≈ sum(a)
    @test Array(sum(u; dims=1)) ≈ sum(a; dims=1)
    @test Array(u * u) ≈ a * a
    @test u * u isa ROCMatrix{Float32, UnifiedBuffer}
    @test Array(permutedims(u)) == permutedims(a)
    @test Array(u[2:3, :]) == a[2:3, :]

    # kernels
    function kernel(x)
        i = workitemIdx().x
        @inbounds x[i] = i
        return
    end
    x = ROCVector{Int, UnifiedBuffer}(undef, 16)
    @roc groupsize=16 kernel(x)
    @test x[16] == 16
    @test Array(x) == 1:16

    # the device sees host writes that happen between kernels
    x[1] = 100
    x .+= 1
    @test x[1] == 101

    v = ROCVector{Int, UnifiedBuffer}([1, 2, 3])
    resize!(v, 5)
    @test v isa ROCVector{Int, UnifiedBuffer}
    @test v[3] == 3
    resize!(v, 2)
    @test Array(v) == [1, 2]

    f = fill!(ROCVector{Float32, UnifiedBuffer}(undef, 4), 2f0)
    @test f[4] == 2f0
    f64 = fill!(ROCVector{Float64, UnifiedBuffer}(undef, 4), 2.0)
    @test f64[4] == 2.0
end

@testset "atomics" begin
    # unified memory is fine-grained, which kernels using it are compiled for
    @test Mem.is_fine_grained(UnifiedBuffer)
    @test AMDGPU.uses_fine_grained_memory(ROCVector{Int, UnifiedBuffer}(undef, 1))
    function atomic_add!(hist)
        i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
        AMDGPU.@atomic hist[(i - 1) % 32 + 1] += one(eltype(hist))
        return
    end
    for T in (Int32, Float32, Int64, Float64)
        hist = ROCVector{T, UnifiedBuffer}(zeros(T, 32))
        @roc groupsize=256 gridsize=4 atomic_add!(hist)
        @test all(==(T(32)), Array(hist))
    end
end

@testset "graph capture" begin
    z = ROCMatrix{Int, UnifiedBuffer}(zeros(Int, 4, 4))
    graph = AMDGPU.@captured z .+= 1
    @test sum(z) == 16
    AMDGPU.launch(graph)
    @test sum(z) == 32
    @test z[1] == 2

    # NOTE: unified memory can't be allocated as part of a graph, which invalidates the
    #       capture. that isn't tested, as ROCm 7.2 leaves the stream capturing after it.
end

@testset "synchronization" begin
    a = ROCVector{Float32, UnifiedBuffer}(undef, 1024)
    fill!(a, 0f0)
    for i in 1:16
        a .+= 1f0
        # every host access waits for the device
        @test a[end] == i
    end

    # use from another task
    t = Threads.@spawn begin
        a .+= 1f0
        a[1]
    end
    @test fetch(t) == 17f0
    @test a[1] == 17f0

    # host accesses of memory that is not synchronized implicitly are up to the user
    AMDGPU.enable_synchronization!(a, false)
    a .+= 1f0
    AMDGPU.synchronize()
    @test a[1] == 18f0
    AMDGPU.enable_synchronization!(a)
end

@testset "KernelInterface" begin
    backend = ROCBackend()
    @test KI.supports_unified(backend)

    x = KI.allocate(backend, Float32, (2, 3); unified=true)
    @test x isa ROCMatrix{Float32, UnifiedBuffer}
    @test KI.allocate(backend, Float32, 2, 3; unified=true) isa ROCMatrix{Float32, UnifiedBuffer}
    @test KI.allocate(backend, Float32, (4,)) isa ROCVector{Float32, AMDGPU.default_memory}
    @test KI.allocate(backend, Float32, (4,); unified=false) isa ROCVector{Float32, AMDGPU.default_memory}

    y = KI.zeros(backend, Float32, (4,); unified=true)
    @test is_unified(y)
    @test y[2] == 0f0
    z = KI.ones(backend, Float32, 4; unified=true)
    @test is_unified(z)
    @test Array(z) == ones(Float32, 4)

    h = zeros(Float32, 4)
    KI.copyto!(backend, h, z)
    KI.synchronize(backend)
    @test h == ones(Float32, 4)
    KI.copyto!(backend, y, Float32[1, 2, 3, 4])
    KI.synchronize(backend)
    @test y[3] == 3f0
    @test KI.get_backend(y) === backend
end

end
