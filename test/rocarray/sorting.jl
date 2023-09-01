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
