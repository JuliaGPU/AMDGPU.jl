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
HA = HSAArray(A)
@roc groupsize=(1,2,3) gridsize=(4,5,6) idx_kern(HA)
A = Array(HA)
@test all(A .> 0)

function dim_kern(X)
    X[1] = workgroupDim().x
    X[2] = workgroupDim().y
    X[3] = workgroupDim().z

    X[4] = gridDim().x
    X[5] = gridDim().y
    X[6] = gridDim().z

    nothing
end

A = zeros(Int64, 6)
HA = HSAArray(A)
wait(@roc groupsize=(1,2,3) gridsize=(4,5,6) dim_kern(HA))
A = Array(HA)
@test A ≈ [1,2,3,4,5,6]

end
