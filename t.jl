using AMDGPU
using KernelAbstractions

@kernel cpu=false function groupreduce_1!(y, x, op, neutral)
    i = @index(Global)
    val = i > length(x) ? neutral : x[i]
    res = @groupreduce(op, val, neutral)
    i == 1 && (y[1] = res)
end

function main()
    x = ROCArray(ones(Float32, 256))
    y = ROCArray(zeros(Float32, 1))
    groupreduce_1!(ROCBackend(), 256)(y, x, +, 0f0; ndrange=256)
    @show y
    return
end
main()
