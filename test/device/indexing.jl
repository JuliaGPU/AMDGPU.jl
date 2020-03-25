@testset "Kernel Indexing" begin

function idx_kern(X)
    X[1] = AMDGPUnative.workitemIdx_x()
    X[2] = AMDGPUnative.workitemIdx_y()
    X[3] = AMDGPUnative.workitemIdx_z()

    X[4] = AMDGPUnative.workgroupIdx_x()
    X[5] = AMDGPUnative.workgroupIdx_y()
    X[6] = AMDGPUnative.workgroupIdx_z()

    nothing
end

A = zeros(Int64, 6)
HA = HSAArray(A)
@roc groupsize=(1,2,3) gridsize=(4,5,6) idx_kern(HA)
A = Array(HA)
@test all(A .> 0)

function dim_kern(X)
    X[1] = AMDGPUnative.workitemDim_x()
    X[2] = AMDGPUnative.workitemDim_y()
    X[3] = AMDGPUnative.workitemDim_z()

    X[4] = AMDGPUnative.workgroupDim_x()
    X[5] = AMDGPUnative.workgroupDim_y()
    X[6] = AMDGPUnative.workgroupDim_z()

    nothing
end

A = zeros(Int64, 6)
HA = HSAArray(A)
wait(@roc groupsize=(1,2,3) gridsize=(4,5,6) dim_kern(HA))
A = Array(HA)
@test A ≈ [1,2,3,4,5,6]

end
