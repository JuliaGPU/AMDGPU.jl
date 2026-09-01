using Test
using AMDGPU
using AMDGPU: Device, ROCArray, @roc
using AMDGPU.Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim

@testset "Kernel Indexing" begin
    function idx_kern(X)
        X[1] = workitemIdx().x
        X[2] = workitemIdx().y
        X[3] = workitemIdx().z

        X[4] = workgroupIdx().x
        X[5] = workgroupIdx().y
        X[6] = workgroupIdx().z

        nothing
    end

    A = zeros(Int64, 6)
    RA = ROCArray(A)
    @roc groupsize=(1,2,3) gridsize=(4,5,6) idx_kern(RA)
    A = Array(RA)
    @test all(A .> 0)

    function dim_kern(X)
        X[1] = workgroupDim().x
        X[2] = workgroupDim().y
        X[3] = workgroupDim().z

        X[4] = gridItemDim().x
        X[5] = gridItemDim().y
        X[6] = gridItemDim().z

        X[7] = gridGroupDim().x
        X[8] = gridGroupDim().y
        X[9] = gridGroupDim().z

        nothing
    end

    A = zeros(Int64, 9)
    RA = ROCArray(A)
    groupsize = (1, 2, 3)
    gridsize = (4, 4, 6)
    @roc groupsize=groupsize gridsize=gridsize dim_kern(RA)
    A = Array(RA)
    @test A == [groupsize..., (groupsize .* gridsize)..., gridsize...]
end

@testset "Indexing range metadata" begin
    # !range is half-open, so an inclusive bound puts the topmost legal value
    # outside it and comparisons against it fold away. Shows up at groupsize=1024.
    function edge_kern(X)
        i = workitemIdx().x
        (i == 1024) && (@inbounds X[1] = 1)
        (i >= 1024) && (@inbounds X[2] = 1)
        (workgroupDim().x == 1024) && (@inbounds X[3] = 1)
        (gridItemDim().x == 1024) && (@inbounds X[4] = 1)
        nothing
    end

    RA = ROCArray(zeros(Int32, 4))
    @roc groupsize=1024 gridsize=1 edge_kern(RA)
    @test Array(RA) == Int32[1, 1, 1, 1]

    # ...and the top lane does run, independently of any comparison.
    function ident_kern(X)
        @inbounds X[workitemIdx().x] = workitemIdx().x
        nothing
    end

    RB = ROCArray(zeros(Int32, 1024))
    @roc groupsize=1024 gridsize=1 ident_kern(RB)
    @test Array(RB) == Int32.(1:1024)
end
