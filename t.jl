using AMDGPU
using KernelAbstractions
using KernelAbstractions: @atomic

@kernel function ker!(x)
    i = @index(Global)
    @inbounds @atomic x[i] += 1f0
end

function main()
    x = ROCArray(zeros(Float32, 1))
    @device_code dir="./devcode" ker!(get_backend(x))(x; ndrange=length(x))
    @show x
    return
end
main()
