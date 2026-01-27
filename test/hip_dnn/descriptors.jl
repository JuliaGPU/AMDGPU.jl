using Test
using AMDGPU
using AMDGPU: ROCArray
using AMDGPU.MIOpen

@assert AMDGPU.functional(:MIOpen)

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
