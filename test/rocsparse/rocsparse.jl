@testset "rocSPARSE" begin
    using Adapt
    using LinearAlgebra
    using SparseArrays

    using AMDGPU.rocSPARSE
    using AMDGPU.Device.AS
    using AMDGPU.Device: ROCDeviceVector
    using AMDGPU.GPUArrays:
        GPUSparseDeviceVector, GPUSparseDeviceMatrixCSC, GPUSparseDeviceMatrixCSR,
        GPUSparseDeviceMatrixBSR, GPUSparseDeviceMatrixCOO

    include("broadcast.jl")
    include("conversions.jl")
    include("device.jl")
    include("generic.jl")
    include("interfaces.jl")
    include("linalg.jl")
    include("preconditioners.jl")
end
