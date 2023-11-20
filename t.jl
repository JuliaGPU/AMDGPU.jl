using AMDGPU
using KernelAbstractions
using KernelAbstractions: @atomic

@kernel function f(target, source, indices)
    i = @index(Global)
    idx = indices[i]
    v = source[i]
    @atomic max(target[idx], v)
    # AMDGPU.Device.atomic_max!(pointer(target, idx), v)
end

function main()
    T = Float32
    n = 1024
    source = rand(T, n)
    indices = rand(1:32, n)
    target = zeros(T, 32)
    @assert length(unique(indices)) < length(indices)

    dsource, dindices, dtarget = ROCArray.((source, indices, target))

    for i in 1:1024
        idx = indices[i]
        target[idx] = max(target[idx], source[i])
    end

    kab = ROCBackend()
    f(kab)(dtarget, dsource, dindices; ndrange=n)
    @assert Array(dtarget) == target
    return
end
main()
