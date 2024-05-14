@testset "Contiguous & non-contiguous dims" begin
    for (T, atol) in ((Float16, 1f-2), (Float32, 1f-5))
        for (sz, dims) in [
            ((5,), :), ((5,), 1),
            ((5, 5), :), ((5, 5), 1), ((5, 5), 2),
            ((5, 5, 5), (1, 2)), ((5, 5, 5), (1, 3)),
            ((5, 5, 5, 5), (2, 3)), ((5, 5, 5, 5), (2, 4)),
        ]
            x, dy = randn(T, sz), randn(T, sz)
            xd, dyd = ROCArray(x), ROCArray(dy)

            # Regular softmax.

            yd = MIOpen.softmax(xd; dims)
            if T == Float16
                @test !any(isnan.(Array(yd)))
            else
                y = NNlib.softmax(x; dims)
                @test Array(yd) ≈ y atol=atol
            end

            dxd = MIOpen.∇softmax(dyd, yd; dims)
            if T == Float16
                @test !any(isnan.(Array(dxd)))
            else
                dx = NNlib.∇softmax_data(dy, y; dims)
                @test Array(dxd) ≈ dx atol=atol
            end

            # Log softmax.

            yd = MIOpen.logsoftmax(xd; dims)
            if T == Float16
                @test !any(isnan.(Array(yd)))
            else
                y = NNlib.logsoftmax(x; dims)
                @test Array(yd) ≈ y atol=atol
            end

            dxd = MIOpen.∇logsoftmax(dyd, yd; dims)
            if T == Float16
                @test !any(isnan.(Array(dxd)))
            else
                dx = NNlib.∇logsoftmax_data(dy, y; dims)
                @test Array(dxd) ≈ dx atol=atol
            end
        end
    end
end
