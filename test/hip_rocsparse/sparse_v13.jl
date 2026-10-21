using Test,AMDGPU,GPUArrays,SparseArrays,LinearAlgebra
using AMDGPU: rocSPARSE
using AMDGPU.rocSPARSE

@testset "canonical vendor boundary preflight" begin
    for dims in ((0,0),(0,3),(3,0),(3,5)), T in (Float32,Float64,ComplexF32,ComplexF64)
        empty=ROCSparseMatrixCSR(spzeros(T,dims...))
        blocked=ROCSparseMatrixBSR(empty,2)
        @test iszero(nnz(blocked))
        @test Array(ROCSparseMatrixCSR(blocked))==zeros(T,dims)
    end
    A=ROCSparseMatrixCSR(sparse(Float32[2 0;1 3]))
    wide=ROCSparseMatrixCSR(ROCVector{Int64}(A.rowPtr),copy(A.colVal),copy(nonzeros(A)),size(A))
    x=ROCArray(Float32[1,2]); original=Array(x)
    for operation in (ic0!,ilu0!)
        before=Array(nonzeros(wide))
        @test_throws ArgumentError operation(wide,'O')
        @test Array(nonzeros(wide))==before
    end
    @test_throws ArgumentError rocSPARSE.sv2!('N','L','N',1f0,wide,x,'O')
    @test Array(x)==original
    vector=ROCSparseVector(ROCArray(Int32[2]),ROCArray(Float32[3]),2)
    @test_throws ArgumentError rocSPARSE.scatter!(x,vector,'Z')
    @test Array(x)==original
    @test_throws ArgumentError rocSPARSE.densetosparse(ROCArray(Float32[1 0;0 1]),:csr,'Z')
    C=copy(A)
    before=map(Array,GPUArrays.sparse_buffers(C))
    @test_throws ArgumentError rocSPARSE.gemm!('N','N',1f0,A,A,0f0,C,'Z')
    @test map(Array,GPUArrays.sparse_buffers(C))==before
end

@testset "rectangular dense-times-sparse selection" begin
    for T in (Float32,ComplexF32), S in (ROCSparseMatrixCSR,ROCSparseMatrixCSC,ROCSparseMatrixCOO),
        ta in ('N','T','C'),tb in ('N','T','C')
        hostA=rand(T,ta=='N' ? (2,3) : (3,2))
        hostB=sprand(T,tb=='N' ? 3 : 4,tb=='N' ? 4 : 3,0.6)
        A=ROCArray(hostA); B=S(hostB)
        expected=LinearAlgebra.wrap(hostA,ta)*LinearAlgebra.wrap(hostB,tb)
        for policy in (GPUArrays.Portable(),GPUArrays.Automatic(),GPUArrays.Vendor())
            @testset "$T $S $ta $tb $policy" begin
            C=AMDGPU.fill(T(7),2,4)
            if policy isa GPUArrays.Vendor && T<:Complex && S===ROCSparseMatrixCSR && tb=='C'
                @test_throws ArgumentError GPUArrays.spmm!(C,ta,tb,A,B,one(T),zero(T);algorithm=policy)
                @test Array(C)==fill(T(7),2,4)
            else
                GPUArrays.spmm!(C,ta,tb,A,B,one(T),zero(T);algorithm=policy)
                @test Array(C) ≈ expected
            end
            end
        end
    end
end
