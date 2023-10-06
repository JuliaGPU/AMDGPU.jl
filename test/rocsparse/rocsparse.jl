@testset "rocSPARSE" begin
    using Adapt
    using LinearAlgebra
    using SparseArrays

    using AMDGPU.rocSPARSE
    using .rocSPARSE: ROCSparseDeviceVector, ROCSparseDeviceMatrixCSC
    using .rocSPARSE: ROCSparseDeviceMatrixCSR, ROCSparseDeviceMatrixBSR
    using .rocSPARSE: ROCSparseDeviceMatrixCOO

    include("broadcast.jl")
    include("conversions.jl")
    include("device.jl")
    include("generic.jl")
    include("interfaces.jl")
    include("linalg.jl")
end
