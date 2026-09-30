using Test
using AMDGPU

import KernelInterface
import KernelInterface as KI
include(joinpath(pkgdir(KernelInterface), "test", "testsuite.jl"))

AMDGPU.allowscalar(false)

function ki_fill!(A)
    i = KI.get_global_id().x
    if i <= length(A)
        @inbounds A[i] = i
    end
    return
end

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

function ki_wavefront_size_kernel(ws)
    @inbounds ws[1] = KI.get_max_sub_group_size()
    return
end

@testset "kernelinterface" begin

backend = ROCBackend()
Testsuite.testsuite(backend, ROCArray)

@testset "copyto!" begin
    # host to host
    a = zeros(Float32, 4)
    @test KI.copyto!(backend, a, ones(Float32, 4)) === a
    @test a == ones(Float32, 4)

    # contiguous views of host arrays (those of a `ROCArray` are `ROCArray`s)
    dev = AMDGPU.zeros(Float32, 4)
    host = Float32[1, 2, 3, 4, 5, 6]
    @test KI.copyto!(backend, dev, view(host, 2:5)) === dev
    KI.synchronize(backend)
    @test Array(dev) == [2, 3, 4, 5]
    KI.copyto!(backend, view(host, 1:4), AMDGPU.ones(Float32, 4))
    KI.synchronize(backend)
    @test host == [1, 1, 1, 1, 5, 6]

    # only contiguous arrays
    @test_throws ArgumentError KI.copyto!(backend, view(AMDGPU.zeros(Float32, 8), 1:2:8), AMDGPU.ones(Float32, 4))
end

@testset "launch keywords" begin
    A = AMDGPU.zeros(Int, 4)
    kernel = KI.@launch backend launch=false ki_fill!(A)

    # AMDGPU's launch options are passed on
    kernel(A; ndrange=4, stream=AMDGPU.stream())
    @test Array(A) == 1:4

    # but not ones that would override the launch geometry
    @test_throws ArgumentError kernel(A; ndrange=4, groupsize=8)
    @test_throws ArgumentError kernel(A; ndrange=4, gridsize=2)
end

@testset "wavefront size" begin
    # kernels are compiled for, and execute with, the device's wavefront size
    ws = AMDGPU.HIP.wavefrontsize(AMDGPU.device())
    @test KI.sub_group_size(backend) == ws
    out = AMDGPU.zeros(Int, 1)
    KI.@launch backend ki_wavefront_size_kernel(out)
    @test Array(out)[1] == ws
    A = AMDGPU.zeros(Int, 4)
    tt = Tuple{typeof(KI.argconvert(backend, A))}
    @test KI.kernel_function(backend, ki_fill!, tt; wavefrontsize64 = ws == 64) isa KI.Kernel
    @test_throws ArgumentError KI.kernel_function(backend, ki_fill!, tt; wavefrontsize64 = ws == 32)
end

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
