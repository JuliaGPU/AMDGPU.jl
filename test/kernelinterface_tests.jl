using Test
using AMDGPU
using AMDGPU: ROCInterface

import KernelInterface
import KernelInterface as KI
include(joinpath(pkgdir(KernelInterface), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

function ki_subgroup_kernel(num, sizes, id, lane)
    l = KI.get_local_id()
    s = KI.get_local_size()
    i = l.x + (l.y - 1) * s.x
    @inbounds begin
        num[i] = KI.get_num_sub_groups()
        sizes[i] = KI.get_sub_group_size()
        id[i] = KI.get_sub_group_id()
        lane[i] = KI.get_sub_group_local_id()
    end
    return
end

# only the odd lanes are active when querying the lane id
function ki_divergent_lane_kernel(lane)
    i = KI.get_local_id().x
    if isodd(i)
        @inbounds lane[i] = KI.get_sub_group_local_id()
    end
    return
end

@testset "kernelinterface" begin

backend = ROCInterface.ROCBackend()
Testsuite.testsuite(backend, ROCArray)

# KernelInterface leaves the formation of sub-groups unspecified; AMD GPUs form wavefronts
# from consecutive linear work-item indices
@testset "partial sub-groups" begin
    ws = KI.sub_group_size(backend)
    # a (ws + 1)x2 workgroup is made up of 3 wavefronts, the last one only partially filled
    workgroupsize = (ws + 1, 2)
    n = prod(workgroupsize)
    num = ROCArray{UInt32}(undef, n)
    sizes = ROCArray{UInt32}(undef, n)
    id = ROCArray{UInt32}(undef, n)
    lane = ROCArray{UInt32}(undef, n)
    KI.@launch backend workgroupsize=workgroupsize ki_subgroup_kernel(num, sizes, id, lane)
    @test all(==(3), Array(num))
    @test Array(sizes) == [i < 2ws ? ws : 2 for i in 0:n-1]
    @test Array(id) == [div(i, ws) + 1 for i in 0:n-1]
    @test Array(lane) == [rem(i, ws) + 1 for i in 0:n-1]
end

@testset "lane ids under divergence" begin
    ws = KI.sub_group_size(backend)
    lane = AMDGPU.zeros(UInt32, 2ws)
    KI.@launch backend workgroupsize=2ws ki_divergent_lane_kernel(lane)
    @test Array(lane) == [isodd(i) ? mod1(i, ws) : 0 for i in 1:2ws]
end

end
