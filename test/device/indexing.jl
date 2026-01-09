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
