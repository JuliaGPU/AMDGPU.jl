using Test
using AMDGPU
using AMDGPU: ROCArray, ROCVector, ROCMatrix, @allowscalar

@testset "Base" begin

@testset "Specifying buffer type" begin
    B = AMDGPU.Runtime.Mem.HIPBuffer
    x = ROCArray{Float32, 2, B}(undef, 16, 12)
    @test size(x) == (16, 12)
    @test x.buf[].mem isa B
    x = ROCArray{Float32, 2, B}(undef, (16, 12))
    @test size(x) == (16, 12)
    @test x.buf[].mem isa B
end

@testset "Constructor" begin
    x = ROCArray([1.0])
    y = ROCArray(x)
    # Constructor doesn't just return its argument.
    @test y !== x
    # But is still equal.
    @test y == x
end

@testset "ones/zeros" begin
    x = @inferred AMDGPU.ones(4, 3)
    @test x isa ROCArray
    x = @inferred AMDGPU.zeros(3, 4)
    @test x isa ROCArray
end

@testset "view" begin
    xs = copyto!(ROCVector{Int}(undef, 4), 1, collect(1:4), 1, 4)
    a = view(xs, 1:2)
    b = view(xs, 3:4)
    @test a isa ROCVector{Int}
    @test b isa ROCVector{Int}
    @test collect(a)::Vector{Int} == 1:2
    @test collect(b)::Vector{Int} == 3:4
    @allowscalar begin
        @test a[[1, 2]] == 1:2
        @test b[[1, 2]] == 3:4
    end

    b_cpu = Vector{Int}(undef, 2)
    @test copyto!(b_cpu, 1, b, 1, 2) === b_cpu
    @test b_cpu == 3:4

    c = ROCVector{Int}(undef, 2)
    @test copyto!(c, 1, b, 1, 2) === c
    @test collect(c) == 3:4
end

@testset "reinterpret of view with non-aligned offset" begin
    # reinterpreting a view to a larger element type where the byte offset
    # is not a multiple of the new element size
    a = ROCArray(Int32[1,2,3,4,5,6,7,8,9])
    v = view(a, 2:7)  # offset of 1 Int32 = 4 bytes
    r = reinterpret(Int64, v)  # Int64 = 8 bytes; 4 is not a multiple of 8
    @test Array(r) == reinterpret(Int64, @view Array(a)[2:7])
end

@testset "resize!" begin
    a_h = Array(range(1, 10))
    a_d = a_h |> roc
    # Resize up
    resize!(a_h, 15)
    resize!(a_d, 15)
    # Set the appended bytes to the same value on both host and device
    a_h[10:15] .= 15
    a_d[10:15] .= 15
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
    # Keep the size as is
    resize!(a_h, 15)
    resize!(a_d, 15)
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
    # Resize down
    resize!(a_h, 3)
    resize!(a_d, 3)
    @allowscalar begin
        @test a_h == a_d
        length(a_h) == length(a_d)
    end
end

@testset "unsafe_wrap" begin
    @testset "Wrap host array" begin
        A = rand(4, 4)
        A_orig = copy(A)

        RA = Base.unsafe_wrap(ROCArray, pointer(A), size(A))
        @test AMDGPU.device(RA) == AMDGPU.device()
        @test RA isa ROCArray{Float64, 2}
        # pointer gives device mapped pointer, not host.
        @test pointer(RA) == RA.buf[].mem.dev_ptr

        # ROCArray -> Array copy.
        B = zeros(4, 4)
        copyto!(B, RA)
        @test B ≈ Array(RA)

        # GPU pointer works.
        AMDGPU.@sync RA .+= 1.0

        # Host pointer is updated.
        @test A ≈ A_orig .+ 1.0

        # Base.show
        @test (println(devnull, RA); true)

        # ROCArray -> ROCArray copy.
        D = rand(4, 4)
        RD = Base.unsafe_wrap(ROCArray, pointer(D), size(D))
        copyto!(RD, RA)
        @test Array(RD) ≈ Array(RA)

        # Can use in HIP libraries.
        @test Array(RA * RA) ≈ Array(A * A)
    end

    @testset "Wrap device array" begin
        x = AMDGPU.rand(Float32, 4, 4)
        xhost = Array(x)
        xd = unsafe_wrap(ROCArray, pointer(x), size(x))

        xd .+= 1f0
        @test Array(x) ≈ Array(xd) ≈ xhost .+ 1f0

        y = AMDGPU.zeros(Float32, 4, 4)
        copyto!(y, xd)
        @test Array(y) ≈ Array(xd)

        # Can use in HIP libraries.
        @test Array(xd * xd) ≈ Array(x * x)
    end

    @testset "Multiple wraps of the same array" begin
        x = zeros(Float32, 16)
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(x))) == false

        xd1 = unsafe_wrap(ROCArray, pointer(x), size(x); own=true)
        xd2 = unsafe_wrap(ROCArray, pointer(x), size(x); own=true)

        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd1))) == true
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == true

        # Refcounted: first free decrements the pin count but memory stays pinned.
        AMDGPU.unsafe_free!(xd1)
        @test_throws ArgumentError pointer(xd1)
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(xd2))) == true

        # Second free drops refcount to zero and actually unregisters.
        AMDGPU.unsafe_free!(xd2)
        @test_throws ArgumentError pointer(xd2)
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(x))) == false
    end

    @testset "Registration is undone when freeing" begin
        x = zeros(Float32, 16)
        xd = unsafe_wrap(ROCArray, pointer(x), size(x))
        @test AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(x)))
        AMDGPU.unsafe_free!(xd)
        @test !AMDGPU.Mem.is_pinned(Ptr{Cvoid}(pointer(x)))
        @test !AMDGPU.Mem.is_registered(Ptr{Cvoid}(pointer(x)))
    end

    @testset "Wrap Array" begin
        for AT in [ROCArray, ROCArray{Float32}, ROCArray{Float32, 1}]
            a = Float32[1, 2, 3]
            b = unsafe_wrap(AT, a)
            @test b isa ROCVector{Float32, AMDGPU.Mem.HostBuffer}
            @test Array(b) == a
        end
        @test isempty(Array(unsafe_wrap(ROCArray, Float32[])))

        # the wrapper keeps the array alive
        xd = unsafe_wrap(ROCArray, fill(1f0, 1024))
        GC.gc(true)
        AMDGPU.@sync xd .+= 1f0
        @test all(==(2f0), Array(xd))

        # ... and lets go of it once the device is done using it
        function wrap_tracked(collected)
            local a, xd
            a = fill(1f0, 1024)
            finalizer(_ -> collected[] = true, a)
            xd = unsafe_wrap(ROCArray, a)
            xd .+= 1f0
            return
        end
        collected = Threads.Atomic{Bool}(false)
        wrap_tracked(collected)
        t = time()
        while !collected[] && time() - t < 10
            GC.gc(true)
            sleep(0.01)
        end
        @test collected[]

        # and the other way around
        a = Float32[1, 2, 3]
        b = unsafe_wrap(ROCArray, a)
        @test pointer(unsafe_wrap(Array, b)) == pointer(a)
        @test_throws ArgumentError unsafe_wrap(Array, AMDGPU.zeros(Float32, 3))
    end

    @testset "Re-wrapping after freeing" begin
        # an explicit free waits for the release, so that the memory can be wrapped again
        x = zeros(Float32, 1 << 20)
        xd = unsafe_wrap(ROCArray, pointer(x), 16)
        xd .+= 1f0
        AMDGPU.unsafe_free!(xd)
        @test !AMDGPU.Mem.is_registered(Ptr{Cvoid}(pointer(x)))
        xd = unsafe_wrap(ROCArray, pointer(x), length(x))
        xd .+= 1f0
        AMDGPU.synchronize()
        @test sum(x) == 16 + length(x)

        # a registration can't be extended while it's still in use
        @test_throws ErrorException unsafe_wrap(ROCArray, pointer(x), 2 * length(x))
        AMDGPU.unsafe_free!(xd)
    end

    @testset "Freeing while capturing" begin
        # last used on the stream of another task, which is still alive
        a = zeros(Float32, 1024)
        wrapped = Channel(1)
        finish = Channel(1)
        t = @async begin
            xd = unsafe_wrap(ROCArray, a)
            xd .+= 1f0
            put!(wrapped, xd)
            take!(finish)
        end
        xd = take!(wrapped)
        y = AMDGPU.zeros(Float32, 16)
        graph = AMDGPU.capture() do
            AMDGPU.unsafe_free!(xd)
            y .+= 1f0
        end
        @test graph !== nothing
        @test !AMDGPU.Mem.is_registered(Ptr{Cvoid}(pointer(a)))
        put!(finish, nothing)
        wait(t)
        @test all(==(1f0), a)
        AMDGPU.HIP.launch(AMDGPU.HIP.instantiate(graph))
        @test all(==(1f0), Array(y))

        # last used on a stream that has since been handed to another task, which is
        # capturing it. that work has finished, so the memory is released right away.
        # (simulated by bumping the stream's generation, as recycling isn't deterministic)
        a = zeros(Float32, 1024)
        s = HIPStream()
        old_stream = AMDGPU.stream()
        AMDGPU.stream!(s)
        try
            xd = unsafe_wrap(ROCArray, a)
            xd .+= 1f0
            AMDGPU.synchronize()
            Base.@atomic s.generation += 1
            z = AMDGPU.zeros(Float32, 16)
            released = false
            graph = AMDGPU.capture() do
                AMDGPU.unsafe_free!(xd)
                released = !AMDGPU.Mem.is_registered(Ptr{Cvoid}(pointer(a)))
                z .+= 1f0
            end
            @test graph !== nothing
            @test released
        finally
            AMDGPU.stream!(old_stream)
        end
        @test all(==(1f0), a)
    end

    @testset "Broadcasting different buffer types" begin
        x = rand(Float32, 4, 16, 16)
        xd = unsafe_wrap(ROCArray, pointer(x), size(x))
        y = AMDGPU.zeros(Float32, 3, 16, 16)
        y .= @view(xd[1:3, :, :])
        @test Array(y) ≈ @view(x[1:3, :, :])
    end

    @testset "Symbols" begin
        # symbols and tuples thereof
        let a = ROCArray([:a])
            b = unsafe_wrap(ROCArray, pointer(a), 1)
            @test typeof(b) <: ROCArray{Symbol,1}
            @test size(b) == (1,)
        end
        let a = ROCArray([(:a,:b)])
            b = unsafe_wrap(ROCArray, pointer(a), 1)
            @test typeof(b) <: ROCArray{Tuple{Symbol,Symbol},1}
            @test size(b) == (1,)
        end
    end
end

@testset "unsafe_free" begin
    A = AMDGPU.ones(4, 3)
    AMDGPU.unsafe_free!(A)
    finalize(A)
end

@testset "accumulate" begin
    @testset "N=$n" for n in (0, 1, 2, 3, 10, 10_000, 16384, 16384 + 1)
        x = rand(n)
        xd = ROCArray(x)
        init = rand()
        @test Array(accumulate(+, xd)) ≈ accumulate(+, x)
        @test Array(accumulate(+, xd; init)) ≈ accumulate(+, x; init)
    end

    # Multidimensional.
    @testset "Sizes: $sizes, dims: $dims" for (sizes, dims) in (
        (2,) => 2,
        (3, 4, 5) => 2,
        (1, 70, 50, 20) => 3,
    )
        x = rand(Int, sizes)
        xd = ROCArray(x)
        @test Array(accumulate(+, xd; dims)) ≈ accumulate(+, x; dims)
        @test Array(accumulate(+, xd; dims)) ≈ accumulate(+, x; dims)
    end

    # In-place.
    x = rand(2)
    xd = ROCArray(x)
    accumulate!(+, x, copy(x))
    accumulate!(+, xd, copy(xd))
    @test Array(xd) ≈ x

    # Specialized.
    @test Array(cumsum(xd)) ≈ cumsum(x)
    @test Array(cumprod(xd)) ≈ cumprod(x)
end

@testset "Atomics" begin
    function ker_atomic_max!(target, source, indices)
        i = workitemIdx().x + (workgroupIdx().x - 0x1) * workgroupDim().x
        idx = indices[i]
        v = source[i]
        AMDGPU.@atomic max(target[idx], v)
        return
    end

    n, bins = 1024, 32
    source = rand(UInt32, n)
    indices = rand(1:bins, n)
    target = zeros(UInt32, bins)
    for i in 1:n
        idx = indices[i]
        target[idx] = max(target[idx], source[i])
    end

    dsource, dindices, dtarget = ROCArray.((source, indices, target))
    @roc groupsize=256 gridsize=4 ker_atomic_max!(dtarget, dsource, dindices)
    @test Array(dtarget) == target
end

@testset "Symbols" begin
    function pass_symbol(x, name)
        i = name == :var ? 1 : 2
        x[i] = true
        return nothing
    end
    x = ROCArray([false, false])
    @roc pass_symbol(x, :var)
    @test Array(x) == [true, false]
    @roc pass_symbol(x, :not_var)
    @test Array(x) == [true, true]
end

@testset "mapreducedim! returning same type" begin
    R = transpose(AMDGPU.zeros(Float32, 2, 3))
    A = ROCArray(rand(Float32, 3, 2, 10))
    @test @inferred(GPUArrays.mapreducedim!(identity, +, R, A)) === R
end

end
