using AMDGPU.MIOpen

@testset "Tensor descriptors" begin
    for nd in 1:MIOpen.MIOPEN_DIM_MAX
        for (T, mT) in MIOpen.DATA_TYPES
            x = ROCArray(zeros(T, ntuple(i -> i + 1, Val{nd}())))
            desc = MIOpen.TensorDescriptor(x)
            @test ndims(desc) == nd

            dtype, dims, stride = MIOpen.unpack(desc)
            @test desc.dtype == mT
            @test desc.dtype == dtype
            # NOTE: Dims and strides are reversed to support WHCN convolutions.
            @test all(dims .== reverse(size(x)))
            @test all(stride .== reverse(strides(x)))
        end
    end
end

@testset "Convolutions" begin
    include("conv.jl")
end

@testset "Pooling" begin
    include("pool.jl")
end

@testset "Softmax" begin
    include("softmax.jl")
end

@testset "Activations" begin
    include("activations.jl")
end

@testset "Batch Normalization" begin
    include("batchnorm.jl")
end
