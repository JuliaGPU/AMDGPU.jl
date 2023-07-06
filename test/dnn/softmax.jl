@testset "Contiguous & non-contiguous dims" begin
    for (T, atol) in ((Float16, 1f-2), (Float32, 1f-5))
        for (sz, dims) in [
            ((5,), :), ((5,), 1),
            ((5, 5), :), ((5, 5), 1), ((5, 5), 2),
            ((5, 5, 5), (1, 2)), ((5, 5, 5), (1, 3)),
            ((5, 5, 5, 5), (2, 3)), ((5, 5, 5, 5), (2, 4)),
        ]
            if T == Float16
                x, dy = ones(T, sz), ones(T, sz) # Really low precision.
            else
                x, dy = randn(T, sz), randn(T, sz)
            end
            xd, dyd = ROCArray(x), ROCArray(dy)

            # Regular softmax.

            y = NNlib.softmax(x; dims)
            yd = MIOpen.softmax(xd; dims)
            @test Array(yd) ≈ y atol=atol

            dx = NNlib.∇softmax_data(dy, y; dims)
            dxd = MIOpen.∇softmax(dyd, yd; dims)
            @test Array(dxd) ≈ dx atol=atol

            # Log softmax.

            y = NNlib.logsoftmax(x; dims)
            yd = MIOpen.logsoftmax(xd; dims)
            @test Array(yd) ≈ y atol=atol

            dx = NNlib.∇logsoftmax_data(dy, y; dims)
            dxd = MIOpen.∇logsoftmax(dyd, yd; dims)
            @test Array(dxd) ≈ dx atol=atol
        end
    end
end
