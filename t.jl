using AMDGPU
using EnzymeCore, Enzyme

function square_kernel!(x)
    i = workgroupIdx().x
    x[i] *= x[i]
    # AMDGPU.sync_workgroup()
    return
end

function square!(x)
    @roc groupsize=length(x) gridsize=1 square_kernel!(x)
    return
end

function main()
    A = ROCArray(collect(1.0:64.0))
    dA = ROCArray(ones(Float64, 64))
    Enzyme.autodiff(Forward, square!, Duplicated(A, dA))
    @show A
    @show dA
    @assert all(dA .≈ (2:2:128))
    return
end
main()
