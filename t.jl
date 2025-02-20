using AMDGPU
using KernelAbstractions

import KernelAbstractions as KA

struct MD
    m::Float32
    d::Float32
end

KA.shfl_down(md::MD, offset) = MD(KA.shfl_down(md.m, offset), KA.shfl_down(md.d, offset))

function md_reduce(a::MD, b::MD)::MD
    bigger_m, smaller_m = (a.m > b.m) ? (a, b) : (b, a)
    return MD(
        bigger_m.m,
        bigger_m.d + smaller_m.d * exp(smaller_m.m - bigger_m.m),
    )
end

# struct A
#     x::Float32
#     y::Float32
# end
# Base.:(+)(a::A, b::A) = A(a.x + b.x, a.y + b.y)

# KA.shfl_down(a::A, offset) = A(KA.shfl_down(a.x, offset), KA.shfl_down(a.y, offset))

# @kernel cpu=false function groupreduce_1!(y, x, op, neutral)
#     i = @index(Global)
#     val = i > length(x) ? neutral : x[i]
#     x = A(val, val)
#     nx = A(neutral, neutral)
#     res = @warp_groupreduce op x nx
#     # res = @groupreduce op x
#     i == 1 && (y[1] = res.x + res.y)
# end

@kernel cpu=false function groupreduce_2!(y, x)
    i = @index(Global)
    nx = MD(-1f-6, 0f0)
    x = MD(x[i], 1f0)
    res = @warp_groupreduce md_reduce x nx
    i == 1 && (y[1] = res.d)
end

function main()
    x = ROCArray(ones(Float32, 256))
    y = ROCArray(zeros(Float32, 1))
    # groupreduce_1!(ROCBackend(), 256)(y, x, +, 0f0; ndrange=256)
    groupreduce_2!(ROCBackend(), 256)(y, x; ndrange=256)
    @show y
    return
end
main()
