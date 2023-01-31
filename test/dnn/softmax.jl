@testset "Contiguous & non-contiguous dims" begin
    for (sz, dims) in [
        ((5,), :),
        ((5,), 1),
        ((5, 5), :),
        ((5, 5), 1),
        ((5, 5), 2),
        ((5, 5, 5, 5), (2, 3)),
        ((5, 5, 5, 5), (2, 4)),
    ]
        x = ones(Float32, sz)
        dy = ones(Float32, sz)
        xd = ROCArray(x)
        dyd = ROCArray(dy)

        # Regular softmax.

        y = NNlib.softmax(x; dims)
        yd = MIOpen.softmax(xd; dims)
        @test isapprox(Array(yd), y; atol=1f-5, rtol=1f-5)

        dx = NNlib.∇softmax_data(dy, y; dims)
        dxd = MIOpen.∇softmax(dyd, yd; dims)
        @test isapprox(Array(dxd), dx; atol=1f-5, rtol=1f-5)

        # Log softmax.

        y = NNlib.logsoftmax(x; dims)
        yd = MIOpen.logsoftmax(xd; dims)
        @test isapprox(Array(yd), y; atol=1f-5, rtol=1f-5)

        dx = NNlib.∇logsoftmax_data(dy, y; dims)
        dxd = MIOpen.∇logsoftmax(dyd, yd; dims)
        @test isapprox(Array(dxd), dx; atol=1f-5, rtol=1f-5)
    end
end
