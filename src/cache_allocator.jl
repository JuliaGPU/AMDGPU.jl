const CacheAllocatorName = ScopedValue(:none)

const ROCCacheAllocator = GPUArrays.PerDeviceCacheAllocator(ROCArray)

GPUArrays.cache_alloc_scope(::ROCBackend) = CacheAllocatorName

GPUArrays.cache_allocator(::ROCBackend) = ROCCacheAllocator

GPUArrays.free_busy_cache_alloc!(pdcache::GPUArrays.PerDeviceCacheAllocator{ROCArray}, name::Symbol) =
    GPUArrays.free_busy!(GPUArrays.named_cache_allocator!(pdcache, AMDGPU.device(), name))

GPUArrays.invalidate_cache_allocator!(pdcache::GPUArrays.PerDeviceCacheAllocator{ROCArray}, name::Symbol) =
    GPUArrays.invalidate_cache_allocator!(pdcache, AMDGPU.device(), name)
