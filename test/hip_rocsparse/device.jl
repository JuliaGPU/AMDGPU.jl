using Test
using AMDGPU
using AMDGPU: ROCVector, ROCMatrix, ROCArray
using AMDGPU.rocSPARSE
using AMDGPU.Device.AS
using AMDGPU.Device: ROCDeviceVector
using AMDGPU.GPUArrays: GPUSparseVector, GPUSparseMatrixCSC, GPUSparseMatrixCSR, GPUSparseMatrixCOO
using SparseArrays

@assert AMDGPU.functional(:rocsparse)

# the canonical formats are the same structs on the device, with device vectors
@testset "rocconvert" begin
    DV{T} = ROCDeviceVector{T, AS.Global}
    @test isbitstype(GPUSparseVector{Float32, Cint, DV{Cint}, DV{Float32}})
    @test isbitstype(GPUSparseMatrixCSC{Float32, Cint, DV{Cint}, DV{Float32}})
    @test isbitstype(GPUSparseMatrixCSR{Float32, Cint, DV{Cint}, DV{Float32}})
    @test isbitstype(GPUSparseMatrixCOO{Float32, Cint, DV{Cint}, DV{Float32}})
    @test isbitstype(rocSPARSE.ROCSparseDeviceMatrixBSR{Float32, Cint, DV{Cint}, DV{Float32}})

    V = sprand(10, 0.5)
    rocV = ROCSparseVector(V)
    @test rocconvert(rocV) isa GPUSparseVector{Float64, Cint, DV{Cint}, DV{Float64}}

    A = sprand(10, 10, 0.5)
    rocA = ROCSparseMatrixCSC{Float64,Cint}(A)
    @test rocconvert(rocA) isa GPUSparseMatrixCSC{Float64, Cint, DV{Cint}, DV{Float64}}

    rocA = ROCSparseMatrixCSR{Float64,Cint}(A)
    @test rocconvert(rocA) isa GPUSparseMatrixCSR{Float64, Cint, DV{Cint}, DV{Float64}}

    rocA = ROCSparseMatrixCOO{Float64,Cint}(A)
    @test rocconvert(rocA) isa GPUSparseMatrixCOO{Float64, Cint, DV{Cint}, DV{Float64}}

    rocA = ROCSparseMatrixBSR(A, 2)
    @test rocconvert(rocA) isa rocSPARSE.ROCSparseDeviceMatrixBSR{Float64, Cint, DV{Cint}, DV{Float64}}
end
