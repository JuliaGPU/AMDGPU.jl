using AMDGPU.MIOpen

const MIOPEN_TYPES = (
    (Float16, MIOpen.miopenHalf),
    (Float32, MIOpen.miopenFloat),
    (Float64, MIOpen.miopenDouble),
    (Int8, MIOpen.miopenInt8),
    (Int32, MIOpen.miopenInt32),
)
const MIOPEN_CONV_TYPES = (Float16, Float32) # FIXME: support more types

@testset "Tensor descriptors" begin
    for nd in 1:MIOpen.MIOPEN_DIM_MAX
        for (T, mT) in MIOPEN_TYPES
            x = ROCArray(zeros(T, ntuple(i -> i + 1, Val{nd}())))
            desc = MIOpen.TensorDescriptor(x)
            @test ndims(desc) == nd

            dtype, dims, stride = MIOpen.get(desc)
            @test desc.dtype == mT
            @test desc.dtype == dtype
            # NOTE: Dims and strides are reversed to support WHCN convolutions.
            @test all(dims .== reverse(size(x)))
            @test all(stride .== reverse(strides(x)))
        end
    end
end

@testset "Simple Convolution" begin
    for T in MIOPEN_CONV_TYPES, nd in 2:3
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
    x = AMDGPU.rand(Float32, 10, 10, 3, 10)
    w1 = AMDGPU.rand(Float32, 2, 2, 3, 16)
    w2 = AMDGPU.rand(Float32, 3, 4, 3, 16)

    y = MIOpen.convolution(
        x, w1; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=1)
    @test size(y) == (9, 9, 16, 10)

    y = MIOpen.convolution(
        x, w1; padding=(2, 2), stride=(2, 2), dilation=(1, 1), groups=1)
    @test size(y) == (7, 7, 16, 10)

    y = MIOpen.convolution(
        x, w2; padding=(2, 3), stride=(1, 2), dilation=(1, 1), groups=1)
    @test size(y) == (12, 7, 16, 10)

    y = MIOpen.convolution(
        x, w1; padding=(2, 3), stride=(1, 2), dilation=(2, 2), groups=1)
    @test size(y) == (12, 7, 16, 10)

    # Depthwise convolution.
    wd1 = AMDGPU.rand(Float32, 2, 2, 1, 3)
    y = MIOpen.convolution(
        x, wd1; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=3)
    @test size(y) == (9, 9, 3, 10)

    x = AMDGPU.ones(Float32, 10, 10, 4, 10)
    wd2 = AMDGPU.ones(Float32, 2, 2, 2, 4)
    y = AMDGPU.MIOpen.convolution(
        x, wd2; padding=(0, 0), stride=(1, 1), dilation=(1, 1), groups=2)
    @test size(y) == (9, 9, 4, 10)
end
