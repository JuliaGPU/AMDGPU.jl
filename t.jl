using AMDGPU

function main()
    cache_allocator = AMDGPU.CacheAllocator()

    # Scope.
    for i in 1:10
        AMDGPU.CACHE_ALLOC[] = cache_allocator
        for j in 1:10
            ROCArray{Float32}(undef, 1024^2 * 256) # 1 GiB
        end
        AMDGPU.free_busy!(cache_allocator)
    end

    # TODO api

    while true
        AMDGPU.with_caching_allocator(:loop) do
            for j in 1:10
                ROCArray{Float32}(undef, 1024^2 * 256) # 1 GiB
            end
        end
    end
    return
end
main()
