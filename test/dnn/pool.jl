@testset "Maxpool" begin
    x = rand(Float32, 16, 16, 3, 2)
    xd = ROCArray(x)

    for k in (2, 3, 4), stride in (1, 2, 3), padding in (0, 1, 2)
        pkwargs = (; dims=(k, k), padding=(padding, padding), stride=(stride, stride))

        # Max pooling.

        yd, workspace = MIOpen.maxpool(xd; pkwargs...)
        yd, workspace = MIOpen.maxpool!(yd, xd; pkwargs...)

        dy = ones(Float32, size(yd))
        dyd = ROCArray(dy)
        dxd = MIOpen.∇maxpool(dyd, yd, xd; workspace, pkwargs...)
        dxd = MIOpen.∇maxpool!(dxd, dyd, yd, xd; workspace, pkwargs...)

        # Mean pooling.

        yd, workspace = MIOpen.meanpool(xd; pkwargs...)
        yd, workspace = MIOpen.meanpool!(yd, xd; pkwargs...)

        dy = ones(Float32, size(yd))
        dyd = ROCArray(dy)

        dxd = MIOpen.∇meanpool(dyd, yd, xd; workspace, pkwargs...)
        dxd = MIOpen.∇meanpool!(dxd, dyd, yd, xd; workspace, pkwargs...)
    end
end
