using Test
using AMDGPU
import GPUToolbox, SparseMatricesCSR, SpecialFunctions

# sysimage builds compile methods for the host, which must not reach device-only code
@testset for mod in (AMDGPU,
                     Base.get_extension(AMDGPU, :AMDGPUSparseMatricesCSRExt),
                     Base.get_extension(AMDGPU, :AMDGPUSpecialFunctionsExt))
    @test isempty(GPUToolbox.Overlays.host_leaks(mod))
end
