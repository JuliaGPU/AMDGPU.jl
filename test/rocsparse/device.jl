using AMDGPU.rocSparse
using SparseArrays
using AMDGPU.rocSparse: ROCSparseDeviceVector, ROCSparseDeviceMatrixCSC, ROCSparseDeviceMatrixCSR,
                     ROCSparseDeviceMatrixBSR, ROCSparseDeviceMatrixCOO

@testset "rocconvert" begin
    @test isbitstype(ROCSparseDeviceVector{Float32, Cint, AMDGPU.Device.AS.Global})
    @test isbitstype(ROCSparseDeviceMatrixCSC{Float32, Cint, AMDGPU.Device.AS.Global})
    @test isbitstype(ROCSparseDeviceMatrixCSR{Float32, Cint, AMDGPU.Device.AS.Global})
    @test isbitstype(ROCSparseDeviceMatrixBSR{Float32, Cint, AMDGPU.Device.AS.Global})
    @test isbitstype(ROCSparseDeviceMatrixCOO{Float32, Cint, AMDGPU.Device.AS.Global})

    V = sprand(10, 0.5)
    rocV = ROCSparseVector(V)
    @test rocconvert(rocV) isa ROCSparseDeviceVector{Float64, Cint, 1}

    A = sprand(10, 10, 0.5)
    rocA = ROCSparseMatrixCSC(A)
    @test rocconvert(rocA) isa ROCSparseDeviceMatrixCSC{Float64, Cint, 1}

    rocA = ROCSparseMatrixCSR(A)
    @test rocconvert(rocA) isa ROCSparseDeviceMatrixCSR{Float64, Cint, 1}

    rocA = ROCSparseMatrixCOO(A)
    @test rocconvert(rocA) isa ROCSparseDeviceMatrixCOO{Float64, Cint, 1}

    rocA = ROCSparseMatrixBSR(A, 2)
    @test rocconvert(rocA) isa ROCSparseDeviceMatrixBSR
end
