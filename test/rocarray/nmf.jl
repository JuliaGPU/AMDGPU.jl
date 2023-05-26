@testset "NMF" begin

## A simple NMF implementation, which is useful to test mark/wait

function step(X, W, H)
    # H update
    H = (H .* (W' * (X ./ (W * H)))
         ./ (sum(W; dims=1))')
    # W update
    W = (W .* ((X ./ (W * H)) * (H'))
         ./ (sum(H; dims=2)'))
    # error estimate
    X - W * H
end

for scale in 1:5
    ncol = 2001
    nrow = 1002 * scale
    nfeatures = 12

    X = rand(Float32, nrow, ncol)
    W = rand(Float32, nrow, nfeatures)
    H = rand(Float32, nfeatures, ncol)
    cpu_res = step(X, W, H)

    RX = ROCArray(X)
    RW = ROCArray(W)
    RH = ROCArray(H)

    gpu_res = step(RX, RW, RH)
    @test Array(gpu_res) ≈ cpu_res

    AMDGPU.unsafe_free!.((RX, RW, RH, gpu_res))
end

end
