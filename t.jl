using AMDGPU
using KernelAbstractions
import KernelAbstractions as KA

@kernel function ker!(y, x, neutral, op)
    i = @index(Global)
    val = i > length(x) ? neutral : x[i]

    res = KA.@groupreduce(:warp, op, val, neutral)
    if i == 1
        y[1] = res
    end
end

function main()
    n = 256
    x = ROCArray(ones(Int64, n))
    y = ROCArray(zeros(Int64, 1))

    ker!(ROCBackend(), n)(y, x, 0, +; ndrange=length(x))
    @show y
    return
end
main()
