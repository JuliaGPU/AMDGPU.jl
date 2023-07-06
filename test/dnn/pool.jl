@testset "NNlib comparison" begin
    x = rand(Float32, 16, 16, 3, 2)
    xd = ROCArray(x)

    for k in (2, 3, 4), stride in (1, 2, 3), padding in (0, 1, 2)
        pdims = NNlib.PoolDims(x, k; stride, padding)
        pkwargs = (; dims=(k, k), padding=(padding, padding), stride=(stride, stride))

        # Max pooling.

        y = NNlib.maxpool(x, pdims)
        yd, workspace = MIOpen.maxpool(xd; pkwargs...)
        yd, workspace = MIOpen.maxpool!(yd, xd; pkwargs...)
        @test Array(yd) ≈ y
        @test Array(yd) ≈ y

        dy = ones(Float32, size(y))
        dyd = ROCArray(dy)

        dx = NNlib.∇maxpool(dy, y, x, pdims)
        dxd = MIOpen.∇maxpool(dyd, yd, xd; workspace, pkwargs...)
        @test Array(dxd) ≈ dx

        dxd = MIOpen.∇maxpool!(dxd, dyd, yd, xd; workspace, pkwargs...)
        @test Array(dxd) ≈ dx

        # Mean pooling.

        y = NNlib.meanpool(x, pdims)
        yd, workspace = MIOpen.meanpool(xd; pkwargs...)
        @test Array(yd) ≈ y
        yd, workspace = MIOpen.meanpool!(yd, xd; pkwargs...)
        @test Array(yd) ≈ y

        dy = ones(Float32, size(y))
        dyd = ROCArray(dy)

        dx = NNlib.∇meanpool(dy, y, x, pdims)
        dxd = MIOpen.∇meanpool(dyd, yd, xd; workspace, pkwargs...)
        @test Array(dxd) ≈ dx
        dxd = MIOpen.∇meanpool!(dxd, dyd, yd, xd; workspace, pkwargs...)
        @test Array(dxd) ≈ dx
    end
end
