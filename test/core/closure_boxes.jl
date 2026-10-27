using Test
using AMDGPU
import KernelAbstractions, SparseMatricesCSR, SpecialFunctions

# captured variables that get boxed (`Core.Box`) lose their type
if isdefined(Test, :detect_closure_boxes)
    @test Test.detect_closure_boxes(AMDGPU,
        Base.get_extension(AMDGPU, :AMDGPUKernelAbstractionsExt),
        Base.get_extension(AMDGPU, :AMDGPUSparseMatricesCSRExt),
        Base.get_extension(AMDGPU, :AMDGPUSpecialFunctionsExt)) == []
end
