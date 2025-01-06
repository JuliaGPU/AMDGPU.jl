const ROCCacheAllocator = GPUArrays.PerDeviceCacheAllocator(ROCArray; free_immediately=false)

GPUArrays.cache_allocator(::ROCBackend) = ROCCacheAllocator

GPUArrays.device(::ROCBackend) = AMDGPU.device()
