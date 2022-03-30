@testset "Memory" begin

@testset "Pointer-based" begin
    src = 42

    buf1 = Mem.alloc(sizeof(src); coherent=true)

    Mem.set!(buf1, UInt32(57), 1)
    x = Mem.download(UInt32, buf1)
    @test x[1] == UInt32(57)

    GC.@preserve Mem.upload!(buf1, pointer_from_objref(Ref(src)), sizeof(src))

    dst1 = Ref(0)
    GC.@preserve Mem.download!(pointer_from_objref(dst1), buf1, sizeof(src))
    @test src == dst1[]

    buf2 = Mem.alloc(sizeof(src))

    Mem.transfer!(buf2, buf1, sizeof(src))

    dst2 = Ref(0)
    GC.@preserve Mem.download!(pointer_from_objref(dst2), buf2, sizeof(src))
    @test src == dst2[]

    Mem.free(buf2)
    Mem.free(buf1)
end

@testset "Array-based" begin
    src = [42]

    buf1 = Mem.alloc(src)

    Mem.upload!(buf1, src)

    dst1 = similar(src)
    Mem.download!(dst1, buf1)
    @test src == dst1

    buf2 = Mem.upload(src)

    dst2 = similar(src)
    Mem.download!(dst2, buf2)
    @test src == dst2

    Mem.free(buf1)
end

@testset "Type-based" begin
    buf = Mem.alloc(Int)

    # there's no type-based upload, duh
    src = [42]
    Mem.upload!(buf, src)

    dst = Mem.download(eltype(src), buf)
    @test src == dst
end

@testset "Pointer information" begin
    default_agent = get_default_agent()

    N = 1024
    a = rand(N)
    b = Mem.alloc(default_agent, N)

    ptrinfo_host = Mem.pointerinfo(a)
    ptrinfo_hsa = Mem.pointerinfo(b)

    @test ptrinfo_host.type == HSA.EXT_POINTER_TYPE_UNKNOWN
    @test ptrinfo_hsa.type == HSA.EXT_POINTER_TYPE_HSA
    @test_skip ptrinfo_hsa.agentOwner.handle == default_agent.agent.handle

    Mem.free(b)
end

@testset "Page-locked memory (OS allocations)" begin
    a = rand(1024)
    plocked = Mem.lock(a)

    # NOTE - For a single agent, it seems that plocked == pointer(a)
    @test Mem.pointerinfo(pointer(a)).type == HSA.EXT_POINTER_TYPE_LOCKED
    @test Mem.pointerinfo(plocked).type == HSA.EXT_POINTER_TYPE_LOCKED
    @test Mem.pointerinfo(plocked).sizeInBytes == sizeof(a)

    Mem.unlock(a)
    @test Mem.pointerinfo(pointer(a)).type == HSA.EXT_POINTER_TYPE_UNKNOWN
    @test Mem.pointerinfo(plocked).type == HSA.EXT_POINTER_TYPE_UNKNOWN
end

@testset "Memory Region Queries" begin
    @testset "Region API Queries" begin
        for (idx, agent) in enumerate(AMDGPU.get_agents(:gpu))
            regions = AMDGPU.regions(agent)
            regions_global = filter(r->AMDGPU.region_segment(r) == AMDGPU.HSA.REGION_SEGMENT_GLOBAL, regions)
            regions_global_coarse_nohost = filter(r->(AMDGPU.region_global_flags(r) & AMDGPU.HSA.REGION_GLOBAL_FLAG_COARSE_GRAINED > 0) &&
                                                     !AMDGPU.region_host_accessible(r), regions)
            regions_group = filter(r->AMDGPU.region_segment(r) == AMDGPU.HSA.REGION_SEGMENT_GROUP, regions)
            regions_finegrained = filter(r->AMDGPU.region_global_flags(r) & AMDGPU.HSA.REGION_GLOBAL_FLAG_FINE_GRAINED > 0, regions)
            regions_kernarg = filter(r->AMDGPU.region_global_flags(r) & AMDGPU.HSA.REGION_GLOBAL_FLAG_KERNARG > 0, regions)

            @test length(regions_global) > 0
            if idx == 1
                @test length(regions_global_coarse_nohost) >= 1
                @test length(regions_group) == 1
            else
                # BUG: https://github.com/RadeonOpenCompute/ROCR-Runtime/issues/134
                @test length(regions_global_coarse_nohost) == 0
                @test length(regions_group) == 0
            end
            @test length(regions_finegrained) > 0
            @test length(regions_kernarg) > 0

            @test all(r->AMDGPU.region_size(r) > 0, regions)

            @test all(AMDGPU.region_runtime_alloc_allowed, regions_global)
            @test all(r->AMDGPU.region_runtime_alloc_granule(r) > 0, regions_global)
            @test all(r->AMDGPU.region_runtime_alloc_alignment(r) > 0, regions_global)
            @test all(r->AMDGPU.region_alloc_max_size(r) > 0, regions_global)

            @test !any(AMDGPU.region_runtime_alloc_allowed, regions_group)
            @test !any(AMDGPU.region_host_accessible, regions_group)

            @test all(AMDGPU.region_runtime_alloc_allowed, regions_finegrained)
            @test all(AMDGPU.region_host_accessible, regions_finegrained)

            @test all(AMDGPU.region_runtime_alloc_allowed, regions_kernarg)
            @test all(AMDGPU.region_host_accessible, regions_kernarg)

            for region in filter(AMDGPU.region_runtime_alloc_allowed, regions)
                buf = Mem.alloc(agent, region, 8)
                @test buf.ptr != C_NULL
                @test !buf.pool_alloc
                Mem.free(buf)
            end
        end
    end
    @testset "Memory Pool API Queries" begin
        for agent in AMDGPU.get_agents(:gpu)
            pools = AMDGPU.memory_pools(agent)
            pools_global = filter(r->AMDGPU.pool_segment(r) == AMDGPU.HSA.AMD_SEGMENT_GLOBAL, pools)
            pools_group = filter(r->AMDGPU.pool_segment(r) == AMDGPU.HSA.AMD_SEGMENT_GROUP, pools)

            @test length(pools_global) >= 1
            @test length(pools_group) == 1

            @test all(r->AMDGPU.pool_size(r) > 0, pools)
            @test !any(AMDGPU.pool_accessible_by_all, pools)

            @test all(AMDGPU.pool_runtime_alloc_allowed, pools_global)
            @test all(r->AMDGPU.pool_runtime_alloc_granule(r) > 0, pools_global)
            @test all(r->AMDGPU.pool_runtime_alloc_alignment(r) > 0, pools_global)
            @test all(r->AMDGPU.pool_alloc_max_size(r) > 0, pools_global)

            @test !any(AMDGPU.pool_runtime_alloc_allowed, pools_group)

            for pool in filter(AMDGPU.pool_runtime_alloc_allowed, pools)
                buf = Mem.alloc(agent, pool, 8)
                @test buf.ptr != C_NULL
                @test buf.pool_alloc
                Mem.free(buf)
            end
        end
    end
end

@testset "Exceptions" begin
    @test_throws ArgumentError Mem.alloc(Function, 1)   # abstract
    @test_throws ArgumentError Mem.alloc(Array{Int}, 1) # UnionAll
    @test_throws ArgumentError Mem.alloc(Integer, 1)    # abstract
    # TODO: can we test for the third case?
    #       !abstract && leaftype seems to imply UnionAll nowadays...

    # zero-width allocations should be permitted
    null = Mem.alloc(Int, 0)
    Mem.free(null)

    # double-free should throw
    x = Mem.alloc(1)
    Mem.free(x)
    # FIXME: Segfaults... @test_throws HSAError Mem.free(x)
end

@testset "Mutable structs" begin
    @eval mutable struct MutablePtrFree
        foo::Int
        bar::Int
    end
    buf = Mem.alloc(MutablePtrFree)
    Mem.upload!(buf, [MutablePtrFree(0,0)])
    Mem.free(buf)

    @eval mutable struct MutableNonPtrFree
        foo::Int
        bar::String
    end
    @test_throws ArgumentError Mem.alloc(MutableNonPtrFree)
end

end
