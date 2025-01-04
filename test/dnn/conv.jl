@testset "Simple Convolution" begin
    for T in (Float16, Float32), nd in 2:3
        ndims = Val{nd}()
        spatial_size = ntuple(i -> 3, ndims)
        target_size = ntuple(i -> 1, ndims)

        padding = ntuple(i -> 0, ndims)
        stride = ntuple(i -> 1, ndims)
        dilation = ntuple(i -> 1, ndims)
        groups = 1

        x = AMDGPU.ones(T, (spatial_size..., 1, 1))
        w = AMDGPU.ones(T, (spatial_size..., 1, 1))
        y = MIOpen.convolution(x, w; padding, stride, dilation, groups)
        @test eltype(y) == T
        @test size(y) == (target_size..., 1, 1)
        @test Array(y)[1] == prod(spatial_size)

        Δ = AMDGPU.ones(T, size(y))
        ∇w = MIOpen.∇convolution_weight(Δ, x, w; padding, stride, dilation, groups)
        @test size(∇w) == size(w)

        ∇x = MIOpen.∇convolution_data(Δ, x, w; padding, stride, dilation, groups)
        @test size(∇x) == size(x)
    end
end

# Adapted from:
# https://github.com/FluxML/NNlib.jl/blob/f5fd67e50fa303866f224e14b98fc2c9ce8d6db9/test/conv.jl#L717
@testset "Check different padding, stride, dilation arguments" begin
    xh = rand(Float32, 10, 10, 3, 10)
    wh1 = rand(Float32, 2, 2, 3, 16)
    wh2 = rand(Float32, 3, 4, 3, 16)
    x, w1, w2 = ROCArray.((xh, wh1, wh2))

    y = MIOpen.convolution(x, w1; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
    @test size(y) == (9, 9, 16, 10)

    y = MIOpen.convolution(x, w1; padding=(2, 2), stride=(2, 2), dilation=(1, 1), groups=1)
    @test size(y) == (7, 7, 16, 10)

    y = MIOpen.convolution(x, w2; padding=(2, 3), stride=(1, 2), dilation=(1, 1), groups=1)
    @test size(y) == (12, 7, 16, 10)

    y = MIOpen.convolution(x, w1; padding=(2, 3), stride=(1, 2), dilation=(2, 2), groups=1)
    @test size(y) == (12, 7, 16, 10)

    # Depthwise convolution.
    wdh1 = rand(Float32, 2, 2, 1, 3)
    wd1 = ROCArray(wdh1)
    y = MIOpen.convolution(x, wd1; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=3)
    @test size(y) == (9, 9, 3, 10)

    # Grouped convolution.
    xh = ones(Float32, 10, 10, 4, 10)
    wdh2 = ones(Float32, 2, 2, 2, 4)
    x, wd2 = ROCArray.((xh, wdh2))
    y = MIOpen.convolution(x, wd2; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=2)
    @test size(y) == (9, 9, 4, 10)
end

@testset "Check MIOpenException" begin
    x = AMDGPU.rand(Float32, 3, 3, 3, 1)
    w = AMDGPU.rand(Float32, 3, 3, 1, 1) # invalid channels number
    @test_throws MIOpen.MIOpenException MIOpen.convolution(
        x, w; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
end
