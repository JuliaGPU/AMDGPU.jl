group = addgroup!(SUITE, "kernel")

group["launch"] = @benchmarkable @roc identity(nothing)

src = AMDGPU.rand(Float32, 512, 1000)
dest = similar(src)

function indexing_kernel(dest, src)
    i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
    @inbounds dest[i] = src[i]
    return
end
group["indexing"] = @async_benchmarkable @roc groupsize=size(src,1) gridsize=size(src,2) $indexing_kernel($dest, $src)

function checked_indexing_kernel(dest, src)
    i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
    dest[i] = src[i]
    return
end
group["indexing_checked"] = @async_benchmarkable @roc groupsize=size(src,1) gridsize=size(src,2) $checked_indexing_kernel($dest, $src)

function rand_kernel(dest::AbstractArray{T}) where {T}
    i = (workgroupIdx().x - 1) * workgroupDim().x + workitemIdx().x
    dest[i] = rand(T)
    return
end
group["rand"] = @async_benchmarkable @roc groupsize=size($dest,1) gridsize=size($dest,2) $rand_kernel($dest)
