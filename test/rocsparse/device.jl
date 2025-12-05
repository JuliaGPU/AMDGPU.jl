@testset "rocconvert" begin
    @test isbitstype(GPUSparseDeviceVector{
        Float32, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float32, AS.Global}, AS.Global})
    @test isbitstype(GPUSparseDeviceMatrixCSC{
        Float32, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float32, AS.Global}, AS.Global})
    @test isbitstype(GPUSparseDeviceMatrixCSR{
        Float32, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float32, AS.Global}, AS.Global})
    @test isbitstype(GPUSparseDeviceMatrixBSR{
        Float32, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float32, AS.Global}, AS.Global})
    @test isbitstype(GPUSparseDeviceMatrixCOO{
        Float32, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float32, AS.Global}, AS.Global})

    V = sprand(10, 0.5)
    rocV = ROCSparseVector(V)
    @test rocconvert(rocV) isa GPUSparseDeviceVector{
        Float64, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float64, AS.Global}, AS.Global}

    A = sprand(10, 10, 0.5)
    rocA = ROCSparseMatrixCSC(A)
    @test rocconvert(rocA) isa GPUSparseDeviceMatrixCSC{
        Float64, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float64, AS.Global}, AS.Global}

    rocA = ROCSparseMatrixCSR(A)
    @test rocconvert(rocA) isa GPUSparseDeviceMatrixCSR{
        Float64, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float64, AS.Global}, AS.Global}

    rocA = ROCSparseMatrixCOO(A)
    @test rocconvert(rocA) isa GPUSparseDeviceMatrixCOO{
        Float64, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float64, AS.Global}, AS.Global}

    rocA = ROCSparseMatrixBSR(A, 2)
    @test rocconvert(rocA) isa GPUSparseDeviceMatrixBSR{
        Float64, Cint,
        ROCDeviceVector{Cint, AS.Global},
        ROCDeviceVector{Float64, AS.Global}, AS.Global}
end
