@testset "Reverse kernel" begin
    @testset "1D full reverse" begin
        for T in (Float16, Float32, Float64), sz in (1, 2, 3, 4, 16, 128, 1024, 1025)
            x = rand(T, sz)
            xd = ROCArray(x)

            y = reverse(x)
            @test y ≈ Array(reverse(xd))
            reverse!(xd)
            @test y ≈ Array(xd)
        end
    end

    @testset "1D partial" begin
        for offset in (1, 2, 13, 16)
            x = rand(Int16, 127)
            xd = ROCArray(x)

            y = reverse(x, offset, length(x) - offset)
            yd = reverse(xd, offset, length(xd) - offset)
            @test y ≈ Array(yd)

            reverse!(xd, offset, length(xd) - offset)
            @test y ≈ Array(xd)
        end
    end

    @testset "2D" begin
        for sz in ((1, 1), (1, 3), (4, 4), (127, 128), (1024, 1025)),
            dims in (:, 1, 2)
            x = rand(Int16, sz)
            xd = ROCArray(x)

            y = reverse(x; dims)
            @test y == Array(reverse(xd; dims))
            @test y == Array(reverse!(xd; dims))
        end

        x = rand(Int16, (8, 9, 10, 11, 12))
        xd = ROCArray(x)
        dims = (1, 2, 4, 5)

        y = reverse(x; dims)
        @test y == Array(reverse(xd; dims))
        @test y == Array(reverse!(xd; dims))
    end
end
