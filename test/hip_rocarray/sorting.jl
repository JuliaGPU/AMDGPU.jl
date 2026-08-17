using Test
using AMDGPU
using AMDGPU: ROCArray

@testset "Sorting" begin
    for sz in (1, 2, 3, 4, 33, 333, 3333, 4096), T in (
        Float16, Float32, Float64, Int16, Int32, Int64,
    )
        x = rand(T, sz)
        xd = ROCArray(x)

        y = sort(x)
        @test y ≈ Array(sort(xd))
        @test y ≈ Array(xd[sortperm(xd)])

        y = sort(x; rev=true)
        @test y ≈ Array(sort(xd; rev=true))
        @test y ≈ Array(xd[sortperm(xd; rev=true)])

        y = sort(x; lt=!isless)
        @test y ≈ Array(sort(xd; lt=!isless))
        @test y ≈ Array(xd[sortperm(xd; lt=!isless)])

        y = sort(x; by=k -> 2 * k)
        @test y ≈ Array(sort(xd; by=k -> 2 * k))
        @test y ≈ Array(xd[sortperm(xd; by=k -> 2 * k)])
    end
end

@testset "Sorting along dims" begin
    for sz in ((1, 1), (4, 7), (33, 65), (100, 100), (7, 5, 3), (1, 64, 1)), T in (
        Float32, Float64, Int32, Int64,
    )
        x = rand(T, sz...)
        xd = ROCArray(x)

        for dims in 1:length(sz), kwargs in (
            (;), (; rev=true), (; by=k -> 2 * k), (; lt=!isless),
            (; order=Base.Order.Reverse),
        )
            y = sort(x; dims, kwargs...)
            @test y == Array(sort(xd; dims, kwargs...))

            yd = copy(xd)
            @test y == Array(sort!(yd; dims, kwargs...))
            @test y == Array(yd)

            p = sortperm(xd; dims, kwargs...)
            @test size(p) == size(x)
            @test y == Array(xd)[Array(p)]
        end
    end

    # `sort` must not mutate its argument.
    x = ROCArray(Float32[3 1; 2 4])
    @test Array(sort(x; dims=2)) == Float32[1 3; 2 4]
    @test Array(x) == Float32[3 1; 2 4]

    # `sortperm!` writes into the given index array.
    ix = ROCArray(reshape(collect(1:4), 2, 2))
    @test Array(sortperm!(ix, x; dims=2)) == [3 1; 2 4]

    # Out-of-range dimensions error like `Base.sort!` does.
    @test_throws ArgumentError sort!(x; dims=3)
    @test_throws ArgumentError sort!(x; dims=0)

    # Larger-than-a-block slices, exercising the global merge passes.
    x = rand(Float32, 1024, 1024)
    for dims in 1:2
        @test sort(x; dims) == Array(sort(ROCArray(x); dims))
    end
end
