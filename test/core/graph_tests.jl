using Test
using AMDGPU
using GPUArrays

@testset "HIP Graphs" begin
    @testset "+1" begin
        f!(o) = o .+= one(eltype(o))

        z = AMDGPU.zeros(Int, 4, 4)
        graph = AMDGPU.@captured f!(z)
        @test sum(z) == 16

        AMDGPU.launch(graph)
        @test sum(z) == 16 * 2
        AMDGPU.launch(graph)
        @test sum(z) == 16 * 3
    end

    @testset "malloc/free" begin
        function f!(o)
            x = AMDGPU.ones(eltype(o), size(o))
            o .+= x .+ one(eltype(o))
            AMDGPU.unsafe_free!(x)
        end

        z = AMDGPU.zeros(Int, 4, 4)
        graph = AMDGPU.@captured f!(z)
        @test sum(z) == 32

        AMDGPU.launch(graph)
        @test sum(z) == 32 * 2
        AMDGPU.launch(graph)
        @test sum(z) == 32 * 3
    end

    @testset "only malloc + alloc cache" begin
        function f!(o)
            x = AMDGPU.ones(eltype(o), size(o))
            y = AMDGPU.ones(eltype(o), size(o))
            o .+= (x * y) .+ one(eltype(o))
        end

        z = AMDGPU.zeros(Int, 4, 4)
        cache = GPUArrays.AllocCache()
        # Pre-populate alloc cache, to avoid malloc calls during capture.
        GPUArrays.@cached cache f!(z)
        # Capture with alloc cache.
        graph = GPUArrays.@cached cache AMDGPU.@captured f!(z)
        @test sum(z) == length(z) * 5 * 2

        AMDGPU.launch(graph)
        @test sum(z) == length(z) * 5 * 3
        AMDGPU.launch(graph)
        @test sum(z) == length(z) * 5 * 4
    end

    @testset "Update graph" begin
        f1!(o) = o .+= 1f0
        f2!(o) = o .+= 2f0

        z = AMDGPU.zeros(Int, 4, 4)
        graph = AMDGPU.@captured f1!(z)
        @test sum(z) == 16

        g_new = AMDGPU.capture() do
            f2!(z)
        end
        @test AMDGPU.update(graph, g_new)
        AMDGPU.launch(graph)
        @test sum(z) == 16 * 3
    end
end
