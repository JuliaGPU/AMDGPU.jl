using AMDGPU.MIOpen

const MIOPEN_TYPES = (
    (Float16, MIOpen.miopenHalf),
    (Float32, MIOpen.miopenFloat),
    (Float64, MIOpen.miopenDouble),
    (Int8, MIOpen.miopenInt8),
    (Int32, MIOpen.miopenInt32),
)
# TODO check why other types don't work
const MIOPEN_CONV_TYPES = (Float32,)

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

@testset "2D Convolution" begin
    for T in MIOPEN_CONV_TYPES
        x = AMDGPU.ones(T, 3, 3, 1, 1)
        w = AMDGPU.ones(T, 3, 3, 1, 1)
        y = MIOpen.convolution(x, w)
        @test eltype(y) == T
        @test size(y) == (1, 1, 1, 1)
        @test Array(y)[1] == T(9)

        Δ = AMDGPU.ones(T, size(y))
        ∇w = MIOpen.∇convolution_weight(Δ, x, w)
        @test size(∇w) == size(w)
        ∇x = MIOpen.∇convolution_data(Δ, x, w)
        @test size(∇x) == size(x)
    end
end
