const ROCCacheAllocator = GPUArrays.AllocCache.PerDeviceCacheAllocator(ROCArray)

GPUArrays.AllocCache.cache_allocator(::Type{<: ROCArray}) = ROCCacheAllocator

GPUArrays.AllocCache.device(::Type{<: ROCArray}) = AMDGPU.device()
