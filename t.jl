using AMDGPU

# function ker!(x)
#     # x[1] = AMDGPU.Device.sync_workgroup_or(Cint(0))
#     i = workitemIdx().x
#     if i ≤ length(x)
#         x[i] = cos(x[i])
#     end
#     return
# end

function main()
    x = ROCArray(ones(Float32, 64))
    cumsum(x)
    # # AMDGPU.@device_code dir="./devcode-112"
    # @roc groupsize=64 gridsize=1 ker!(x)
    # @show x
    return
end
main()
