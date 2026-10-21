using Test,AMDGPU,SparseArrays,GPUArrays
using AMDGPU.rocSPARSE
using AMDGPU.Device: ROCDeviceVector
using GPUArrays: GPUSparseVector,GPUSparseMatrixCSC,GPUSparseMatrixCSR,GPUSparseMatrixCOO

@testset "canonical device adaptation" begin
    function count_bsr_kernel(out,A)
        out[1]=nnz(A)
        nothing
    end
    A=ROCSparseMatrixBSR(sparse(Float32[1 0;0 2]),2)
    out=ROCVector{Int}(undef,1)
    @roc groupsize=1 gridsize=1 count_bsr_kernel(out,A)
    @test only(Array(out))==nnz(A)==4
    for (host,constructor,format) in ((sprand(Float32,10,0.5),ROCSparseVector,GPUSparseVector),
        (sprand(Float32,10,10,0.5),ROCSparseMatrixCSC,GPUSparseMatrixCSC),
        (sprand(Float32,10,10,0.5),ROCSparseMatrixCSR,GPUSparseMatrixCSR),
        (sprand(Float32,10,10,0.5),ROCSparseMatrixCOO,GPUSparseMatrixCOO))
        result=rocconvert(constructor(host))
        @test result isa format
        @test isbitstype(typeof(result))
        @test nonzeros(result) isa ROCDeviceVector{Float32}
    end
    result=rocconvert(ROCSparseMatrixBSR(sprand(Float32,10,10,0.5),2))
    @test result isa AMDGPU.rocSPARSE.ROCSparseDeviceMatrixBSR
    @test isbitstype(typeof(result))
end
