using CEnum: CEnum, @cenum

struct hipUUID_t
    bytes::NTuple{16,Cchar}
end

const hipUUID = hipUUID_t

struct hipDeviceArch_t
    data::NTuple{4,UInt8}
end

function Base.getproperty(x::Ptr{hipDeviceArch_t}, f::Symbol)
    f === :hasGlobalInt32Atomics && return (Ptr{Cuint}(x + 0), 0, 1)
    f === :hasGlobalFloatAtomicExch && return (Ptr{Cuint}(x + 0), 1, 1)
    f === :hasSharedInt32Atomics && return (Ptr{Cuint}(x + 0), 2, 1)
    f === :hasSharedFloatAtomicExch && return (Ptr{Cuint}(x + 0), 3, 1)
    f === :hasFloatAtomicAdd && return (Ptr{Cuint}(x + 0), 4, 1)
    f === :hasGlobalInt64Atomics && return (Ptr{Cuint}(x + 0), 5, 1)
    f === :hasSharedInt64Atomics && return (Ptr{Cuint}(x + 0), 6, 1)
    f === :hasDoubles && return (Ptr{Cuint}(x + 0), 7, 1)
    f === :hasWarpVote && return (Ptr{Cuint}(x + 0), 8, 1)
    f === :hasWarpBallot && return (Ptr{Cuint}(x + 0), 9, 1)
    f === :hasWarpShuffle && return (Ptr{Cuint}(x + 0), 10, 1)
    f === :hasFunnelShift && return (Ptr{Cuint}(x + 0), 11, 1)
    f === :hasThreadFenceSystem && return (Ptr{Cuint}(x + 0), 12, 1)
    f === :hasSyncThreadsExt && return (Ptr{Cuint}(x + 0), 13, 1)
    f === :hasSurfaceFuncs && return (Ptr{Cuint}(x + 0), 14, 1)
    f === :has3dGrid && return (Ptr{Cuint}(x + 0), 15, 1)
    f === :hasDynamicParallelism && return (Ptr{Cuint}(x + 0), 16, 1)
    return getfield(x, f)
end

function Base.getproperty(x::hipDeviceArch_t, f::Symbol)
    r = Ref{hipDeviceArch_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipDeviceArch_t}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{hipDeviceArch_t}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

function Base.propertynames(x::hipDeviceArch_t, private::Bool=false)
    return (:hasGlobalInt32Atomics, :hasGlobalFloatAtomicExch, :hasSharedInt32Atomics,
            :hasSharedFloatAtomicExch, :hasFloatAtomicAdd, :hasGlobalInt64Atomics,
            :hasSharedInt64Atomics, :hasDoubles, :hasWarpVote, :hasWarpBallot,
            :hasWarpShuffle, :hasFunnelShift, :hasThreadFenceSystem, :hasSyncThreadsExt,
            :hasSurfaceFuncs, :has3dGrid, :hasDynamicParallelism,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipDeviceProp_tR0600
    data::NTuple{1472,UInt8}
end

function Base.getproperty(x::Ptr{hipDeviceProp_tR0600}, f::Symbol)
    f === :name && return Ptr{NTuple{256,Cchar}}(x + 0)
    f === :uuid && return Ptr{hipUUID}(x + 256)
    f === :luid && return Ptr{NTuple{8,Cchar}}(x + 272)
    f === :luidDeviceNodeMask && return Ptr{Cuint}(x + 280)
    f === :totalGlobalMem && return Ptr{Csize_t}(x + 288)
    f === :sharedMemPerBlock && return Ptr{Csize_t}(x + 296)
    f === :regsPerBlock && return Ptr{Cint}(x + 304)
    f === :warpSize && return Ptr{Cint}(x + 308)
    f === :memPitch && return Ptr{Csize_t}(x + 312)
    f === :maxThreadsPerBlock && return Ptr{Cint}(x + 320)
    f === :maxThreadsDim && return Ptr{NTuple{3,Cint}}(x + 324)
    f === :maxGridSize && return Ptr{NTuple{3,Cint}}(x + 336)
    f === :clockRate && return Ptr{Cint}(x + 348)
    f === :totalConstMem && return Ptr{Csize_t}(x + 352)
    f === :major && return Ptr{Cint}(x + 360)
    f === :minor && return Ptr{Cint}(x + 364)
    f === :textureAlignment && return Ptr{Csize_t}(x + 368)
    f === :texturePitchAlignment && return Ptr{Csize_t}(x + 376)
    f === :deviceOverlap && return Ptr{Cint}(x + 384)
    f === :multiProcessorCount && return Ptr{Cint}(x + 388)
    f === :kernelExecTimeoutEnabled && return Ptr{Cint}(x + 392)
    f === :integrated && return Ptr{Cint}(x + 396)
    f === :canMapHostMemory && return Ptr{Cint}(x + 400)
    f === :computeMode && return Ptr{Cint}(x + 404)
    f === :maxTexture1D && return Ptr{Cint}(x + 408)
    f === :maxTexture1DMipmap && return Ptr{Cint}(x + 412)
    f === :maxTexture1DLinear && return Ptr{Cint}(x + 416)
    f === :maxTexture2D && return Ptr{NTuple{2,Cint}}(x + 420)
    f === :maxTexture2DMipmap && return Ptr{NTuple{2,Cint}}(x + 428)
    f === :maxTexture2DLinear && return Ptr{NTuple{3,Cint}}(x + 436)
    f === :maxTexture2DGather && return Ptr{NTuple{2,Cint}}(x + 448)
    f === :maxTexture3D && return Ptr{NTuple{3,Cint}}(x + 456)
    f === :maxTexture3DAlt && return Ptr{NTuple{3,Cint}}(x + 468)
    f === :maxTextureCubemap && return Ptr{Cint}(x + 480)
    f === :maxTexture1DLayered && return Ptr{NTuple{2,Cint}}(x + 484)
    f === :maxTexture2DLayered && return Ptr{NTuple{3,Cint}}(x + 492)
    f === :maxTextureCubemapLayered && return Ptr{NTuple{2,Cint}}(x + 504)
    f === :maxSurface1D && return Ptr{Cint}(x + 512)
    f === :maxSurface2D && return Ptr{NTuple{2,Cint}}(x + 516)
    f === :maxSurface3D && return Ptr{NTuple{3,Cint}}(x + 524)
    f === :maxSurface1DLayered && return Ptr{NTuple{2,Cint}}(x + 536)
    f === :maxSurface2DLayered && return Ptr{NTuple{3,Cint}}(x + 544)
    f === :maxSurfaceCubemap && return Ptr{Cint}(x + 556)
    f === :maxSurfaceCubemapLayered && return Ptr{NTuple{2,Cint}}(x + 560)
    f === :surfaceAlignment && return Ptr{Csize_t}(x + 568)
    f === :concurrentKernels && return Ptr{Cint}(x + 576)
    f === :ECCEnabled && return Ptr{Cint}(x + 580)
    f === :pciBusID && return Ptr{Cint}(x + 584)
    f === :pciDeviceID && return Ptr{Cint}(x + 588)
    f === :pciDomainID && return Ptr{Cint}(x + 592)
    f === :tccDriver && return Ptr{Cint}(x + 596)
    f === :asyncEngineCount && return Ptr{Cint}(x + 600)
    f === :unifiedAddressing && return Ptr{Cint}(x + 604)
    f === :memoryClockRate && return Ptr{Cint}(x + 608)
    f === :memoryBusWidth && return Ptr{Cint}(x + 612)
    f === :l2CacheSize && return Ptr{Cint}(x + 616)
    f === :persistingL2CacheMaxSize && return Ptr{Cint}(x + 620)
    f === :maxThreadsPerMultiProcessor && return Ptr{Cint}(x + 624)
    f === :streamPrioritiesSupported && return Ptr{Cint}(x + 628)
    f === :globalL1CacheSupported && return Ptr{Cint}(x + 632)
    f === :localL1CacheSupported && return Ptr{Cint}(x + 636)
    f === :sharedMemPerMultiprocessor && return Ptr{Csize_t}(x + 640)
    f === :regsPerMultiprocessor && return Ptr{Cint}(x + 648)
    f === :managedMemory && return Ptr{Cint}(x + 652)
    f === :isMultiGpuBoard && return Ptr{Cint}(x + 656)
    f === :multiGpuBoardGroupID && return Ptr{Cint}(x + 660)
    f === :hostNativeAtomicSupported && return Ptr{Cint}(x + 664)
    f === :singleToDoublePrecisionPerfRatio && return Ptr{Cint}(x + 668)
    f === :pageableMemoryAccess && return Ptr{Cint}(x + 672)
    f === :concurrentManagedAccess && return Ptr{Cint}(x + 676)
    f === :computePreemptionSupported && return Ptr{Cint}(x + 680)
    f === :canUseHostPointerForRegisteredMem && return Ptr{Cint}(x + 684)
    f === :cooperativeLaunch && return Ptr{Cint}(x + 688)
    f === :cooperativeMultiDeviceLaunch && return Ptr{Cint}(x + 692)
    f === :sharedMemPerBlockOptin && return Ptr{Csize_t}(x + 696)
    f === :pageableMemoryAccessUsesHostPageTables && return Ptr{Cint}(x + 704)
    f === :directManagedMemAccessFromHost && return Ptr{Cint}(x + 708)
    f === :maxBlocksPerMultiProcessor && return Ptr{Cint}(x + 712)
    f === :accessPolicyMaxWindowSize && return Ptr{Cint}(x + 716)
    f === :reservedSharedMemPerBlock && return Ptr{Csize_t}(x + 720)
    f === :hostRegisterSupported && return Ptr{Cint}(x + 728)
    f === :sparseHipArraySupported && return Ptr{Cint}(x + 732)
    f === :hostRegisterReadOnlySupported && return Ptr{Cint}(x + 736)
    f === :timelineSemaphoreInteropSupported && return Ptr{Cint}(x + 740)
    f === :memoryPoolsSupported && return Ptr{Cint}(x + 744)
    f === :gpuDirectRDMASupported && return Ptr{Cint}(x + 748)
    f === :gpuDirectRDMAFlushWritesOptions && return Ptr{Cuint}(x + 752)
    f === :gpuDirectRDMAWritesOrdering && return Ptr{Cint}(x + 756)
    f === :memoryPoolSupportedHandleTypes && return Ptr{Cuint}(x + 760)
    f === :deferredMappingHipArraySupported && return Ptr{Cint}(x + 764)
    f === :ipcEventSupported && return Ptr{Cint}(x + 768)
    f === :clusterLaunch && return Ptr{Cint}(x + 772)
    f === :unifiedFunctionPointers && return Ptr{Cint}(x + 776)
    f === :reserved && return Ptr{NTuple{63,Cint}}(x + 780)
    f === :hipReserved && return Ptr{NTuple{32,Cint}}(x + 1032)
    f === :gcnArchName && return Ptr{NTuple{256,Cchar}}(x + 1160)
    f === :maxSharedMemoryPerMultiProcessor && return Ptr{Csize_t}(x + 1416)
    f === :clockInstructionRate && return Ptr{Cint}(x + 1424)
    f === :arch && return Ptr{hipDeviceArch_t}(x + 1428)
    f === :hdpMemFlushCntl && return Ptr{Ptr{Cuint}}(x + 1432)
    f === :hdpRegFlushCntl && return Ptr{Ptr{Cuint}}(x + 1440)
    f === :cooperativeMultiDeviceUnmatchedFunc && return Ptr{Cint}(x + 1448)
    f === :cooperativeMultiDeviceUnmatchedGridDim && return Ptr{Cint}(x + 1452)
    f === :cooperativeMultiDeviceUnmatchedBlockDim && return Ptr{Cint}(x + 1456)
    f === :cooperativeMultiDeviceUnmatchedSharedMem && return Ptr{Cint}(x + 1460)
    f === :isLargeBar && return Ptr{Cint}(x + 1464)
    f === :asicRevision && return Ptr{Cint}(x + 1468)
    return getfield(x, f)
end

function Base.getproperty(x::hipDeviceProp_tR0600, f::Symbol)
    r = Ref{hipDeviceProp_tR0600}(x)
    ptr = Base.unsafe_convert(Ptr{hipDeviceProp_tR0600}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipDeviceProp_tR0600}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipDeviceProp_tR0600, private::Bool=false)
    return (:name, :uuid, :luid, :luidDeviceNodeMask, :totalGlobalMem, :sharedMemPerBlock,
            :regsPerBlock, :warpSize, :memPitch, :maxThreadsPerBlock, :maxThreadsDim,
            :maxGridSize, :clockRate, :totalConstMem, :major, :minor, :textureAlignment,
            :texturePitchAlignment, :deviceOverlap, :multiProcessorCount,
            :kernelExecTimeoutEnabled, :integrated, :canMapHostMemory, :computeMode,
            :maxTexture1D, :maxTexture1DMipmap, :maxTexture1DLinear, :maxTexture2D,
            :maxTexture2DMipmap, :maxTexture2DLinear, :maxTexture2DGather, :maxTexture3D,
            :maxTexture3DAlt, :maxTextureCubemap, :maxTexture1DLayered,
            :maxTexture2DLayered, :maxTextureCubemapLayered, :maxSurface1D, :maxSurface2D,
            :maxSurface3D, :maxSurface1DLayered, :maxSurface2DLayered, :maxSurfaceCubemap,
            :maxSurfaceCubemapLayered, :surfaceAlignment, :concurrentKernels, :ECCEnabled,
            :pciBusID, :pciDeviceID, :pciDomainID, :tccDriver, :asyncEngineCount,
            :unifiedAddressing, :memoryClockRate, :memoryBusWidth, :l2CacheSize,
            :persistingL2CacheMaxSize, :maxThreadsPerMultiProcessor,
            :streamPrioritiesSupported, :globalL1CacheSupported, :localL1CacheSupported,
            :sharedMemPerMultiprocessor, :regsPerMultiprocessor, :managedMemory,
            :isMultiGpuBoard, :multiGpuBoardGroupID, :hostNativeAtomicSupported,
            :singleToDoublePrecisionPerfRatio, :pageableMemoryAccess,
            :concurrentManagedAccess, :computePreemptionSupported,
            :canUseHostPointerForRegisteredMem, :cooperativeLaunch,
            :cooperativeMultiDeviceLaunch, :sharedMemPerBlockOptin,
            :pageableMemoryAccessUsesHostPageTables, :directManagedMemAccessFromHost,
            :maxBlocksPerMultiProcessor, :accessPolicyMaxWindowSize,
            :reservedSharedMemPerBlock, :hostRegisterSupported, :sparseHipArraySupported,
            :hostRegisterReadOnlySupported, :timelineSemaphoreInteropSupported,
            :memoryPoolsSupported, :gpuDirectRDMASupported,
            :gpuDirectRDMAFlushWritesOptions, :gpuDirectRDMAWritesOrdering,
            :memoryPoolSupportedHandleTypes, :deferredMappingHipArraySupported,
            :ipcEventSupported, :clusterLaunch, :unifiedFunctionPointers, :reserved,
            :hipReserved, :gcnArchName, :maxSharedMemoryPerMultiProcessor,
            :clockInstructionRate, :arch, :hdpMemFlushCntl, :hdpRegFlushCntl,
            :cooperativeMultiDeviceUnmatchedFunc, :cooperativeMultiDeviceUnmatchedGridDim,
            :cooperativeMultiDeviceUnmatchedBlockDim,
            :cooperativeMultiDeviceUnmatchedSharedMem, :isLargeBar, :asicRevision,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum var"##Ctag#232"::UInt32 begin
    HIP_SUCCESS = 0
    HIP_ERROR_INVALID_VALUE = 1
    HIP_ERROR_NOT_INITIALIZED = 2
    HIP_ERROR_LAUNCH_OUT_OF_RESOURCES = 3
end

@cenum hipMemoryType::UInt32 begin
    hipMemoryTypeUnregistered = 0
    hipMemoryTypeHost = 1
    hipMemoryTypeDevice = 2
    hipMemoryTypeManaged = 3
    hipMemoryTypeArray = 10
    hipMemoryTypeUnified = 11
end

struct hipPointerAttribute_t
    type::hipMemoryType
    device::Cint
    devicePointer::Ptr{Cvoid}
    hostPointer::Ptr{Cvoid}
    isManaged::Cint
    allocationFlags::Cuint
end

@cenum hipError_t::UInt32 begin
    hipSuccess = 0
    hipErrorInvalidValue = 1
    hipErrorOutOfMemory = 2
    hipErrorMemoryAllocation = 2
    hipErrorNotInitialized = 3
    hipErrorInitializationError = 3
    hipErrorDeinitialized = 4
    hipErrorProfilerDisabled = 5
    hipErrorProfilerNotInitialized = 6
    hipErrorProfilerAlreadyStarted = 7
    hipErrorProfilerAlreadyStopped = 8
    hipErrorInvalidConfiguration = 9
    hipErrorInvalidPitchValue = 12
    hipErrorInvalidSymbol = 13
    hipErrorInvalidDevicePointer = 17
    hipErrorInvalidMemcpyDirection = 21
    hipErrorInsufficientDriver = 35
    hipErrorMissingConfiguration = 52
    hipErrorPriorLaunchFailure = 53
    hipErrorInvalidDeviceFunction = 98
    hipErrorNoDevice = 100
    hipErrorInvalidDevice = 101
    hipErrorInvalidImage = 200
    hipErrorInvalidContext = 201
    hipErrorContextAlreadyCurrent = 202
    hipErrorMapFailed = 205
    hipErrorMapBufferObjectFailed = 205
    hipErrorUnmapFailed = 206
    hipErrorArrayIsMapped = 207
    hipErrorAlreadyMapped = 208
    hipErrorNoBinaryForGpu = 209
    hipErrorAlreadyAcquired = 210
    hipErrorNotMapped = 211
    hipErrorNotMappedAsArray = 212
    hipErrorNotMappedAsPointer = 213
    hipErrorECCNotCorrectable = 214
    hipErrorUnsupportedLimit = 215
    hipErrorContextAlreadyInUse = 216
    hipErrorPeerAccessUnsupported = 217
    hipErrorInvalidKernelFile = 218
    hipErrorInvalidGraphicsContext = 219
    hipErrorInvalidSource = 300
    hipErrorFileNotFound = 301
    hipErrorSharedObjectSymbolNotFound = 302
    hipErrorSharedObjectInitFailed = 303
    hipErrorOperatingSystem = 304
    hipErrorInvalidHandle = 400
    hipErrorInvalidResourceHandle = 400
    hipErrorIllegalState = 401
    hipErrorNotFound = 500
    hipErrorNotReady = 600
    hipErrorIllegalAddress = 700
    hipErrorLaunchOutOfResources = 701
    hipErrorLaunchTimeOut = 702
    hipErrorPeerAccessAlreadyEnabled = 704
    hipErrorPeerAccessNotEnabled = 705
    hipErrorSetOnActiveProcess = 708
    hipErrorContextIsDestroyed = 709
    hipErrorAssert = 710
    hipErrorHostMemoryAlreadyRegistered = 712
    hipErrorHostMemoryNotRegistered = 713
    hipErrorLaunchFailure = 719
    hipErrorCooperativeLaunchTooLarge = 720
    hipErrorNotSupported = 801
    hipErrorStreamCaptureUnsupported = 900
    hipErrorStreamCaptureInvalidated = 901
    hipErrorStreamCaptureMerge = 902
    hipErrorStreamCaptureUnmatched = 903
    hipErrorStreamCaptureUnjoined = 904
    hipErrorStreamCaptureIsolation = 905
    hipErrorStreamCaptureImplicit = 906
    hipErrorCapturedEvent = 907
    hipErrorStreamCaptureWrongThread = 908
    hipErrorGraphExecUpdateFailure = 910
    hipErrorInvalidChannelDescriptor = 911
    hipErrorInvalidTexture = 912
    hipErrorUnknown = 999
    hipErrorRuntimeMemory = 1052
    hipErrorRuntimeOther = 1053
    hipErrorInvalidClusterSize = 1054
    hipErrorTbd = 1055
end

@cenum hipDeviceAttribute_t::UInt32 begin
    hipDeviceAttributeCudaCompatibleBegin = 0
    hipDeviceAttributeEccEnabled = 0
    hipDeviceAttributeAccessPolicyMaxWindowSize = 1
    hipDeviceAttributeAsyncEngineCount = 2
    hipDeviceAttributeCanMapHostMemory = 3
    hipDeviceAttributeCanUseHostPointerForRegisteredMem = 4
    hipDeviceAttributeClockRate = 5
    hipDeviceAttributeComputeMode = 6
    hipDeviceAttributeComputePreemptionSupported = 7
    hipDeviceAttributeConcurrentKernels = 8
    hipDeviceAttributeConcurrentManagedAccess = 9
    hipDeviceAttributeCooperativeLaunch = 10
    hipDeviceAttributeCooperativeMultiDeviceLaunch = 11
    hipDeviceAttributeDeviceOverlap = 12
    hipDeviceAttributeDirectManagedMemAccessFromHost = 13
    hipDeviceAttributeGlobalL1CacheSupported = 14
    hipDeviceAttributeHostNativeAtomicSupported = 15
    hipDeviceAttributeIntegrated = 16
    hipDeviceAttributeIsMultiGpuBoard = 17
    hipDeviceAttributeKernelExecTimeout = 18
    hipDeviceAttributeL2CacheSize = 19
    hipDeviceAttributeLocalL1CacheSupported = 20
    hipDeviceAttributeLuid = 21
    hipDeviceAttributeLuidDeviceNodeMask = 22
    hipDeviceAttributeComputeCapabilityMajor = 23
    hipDeviceAttributeManagedMemory = 24
    hipDeviceAttributeMaxBlocksPerMultiProcessor = 25
    hipDeviceAttributeMaxBlockDimX = 26
    hipDeviceAttributeMaxBlockDimY = 27
    hipDeviceAttributeMaxBlockDimZ = 28
    hipDeviceAttributeMaxGridDimX = 29
    hipDeviceAttributeMaxGridDimY = 30
    hipDeviceAttributeMaxGridDimZ = 31
    hipDeviceAttributeMaxSurface1D = 32
    hipDeviceAttributeMaxSurface1DLayered = 33
    hipDeviceAttributeMaxSurface2D = 34
    hipDeviceAttributeMaxSurface2DLayered = 35
    hipDeviceAttributeMaxSurface3D = 36
    hipDeviceAttributeMaxSurfaceCubemap = 37
    hipDeviceAttributeMaxSurfaceCubemapLayered = 38
    hipDeviceAttributeMaxTexture1DWidth = 39
    hipDeviceAttributeMaxTexture1DLayered = 40
    hipDeviceAttributeMaxTexture1DLinear = 41
    hipDeviceAttributeMaxTexture1DMipmap = 42
    hipDeviceAttributeMaxTexture2DWidth = 43
    hipDeviceAttributeMaxTexture2DHeight = 44
    hipDeviceAttributeMaxTexture2DGather = 45
    hipDeviceAttributeMaxTexture2DLayered = 46
    hipDeviceAttributeMaxTexture2DLinear = 47
    hipDeviceAttributeMaxTexture2DMipmap = 48
    hipDeviceAttributeMaxTexture3DWidth = 49
    hipDeviceAttributeMaxTexture3DHeight = 50
    hipDeviceAttributeMaxTexture3DDepth = 51
    hipDeviceAttributeMaxTexture3DAlt = 52
    hipDeviceAttributeMaxTextureCubemap = 53
    hipDeviceAttributeMaxTextureCubemapLayered = 54
    hipDeviceAttributeMaxThreadsDim = 55
    hipDeviceAttributeMaxThreadsPerBlock = 56
    hipDeviceAttributeMaxThreadsPerMultiProcessor = 57
    hipDeviceAttributeMaxPitch = 58
    hipDeviceAttributeMemoryBusWidth = 59
    hipDeviceAttributeMemoryClockRate = 60
    hipDeviceAttributeComputeCapabilityMinor = 61
    hipDeviceAttributeMultiGpuBoardGroupID = 62
    hipDeviceAttributeMultiprocessorCount = 63
    hipDeviceAttributeUnused1 = 64
    hipDeviceAttributePageableMemoryAccess = 65
    hipDeviceAttributePageableMemoryAccessUsesHostPageTables = 66
    hipDeviceAttributePciBusId = 67
    hipDeviceAttributePciDeviceId = 68
    hipDeviceAttributePciDomainId = 69
    hipDeviceAttributePciDomainID = 69
    hipDeviceAttributePersistingL2CacheMaxSize = 70
    hipDeviceAttributeMaxRegistersPerBlock = 71
    hipDeviceAttributeMaxRegistersPerMultiprocessor = 72
    hipDeviceAttributeReservedSharedMemPerBlock = 73
    hipDeviceAttributeMaxSharedMemoryPerBlock = 74
    hipDeviceAttributeSharedMemPerBlockOptin = 75
    hipDeviceAttributeSharedMemPerMultiprocessor = 76
    hipDeviceAttributeSingleToDoublePrecisionPerfRatio = 77
    hipDeviceAttributeStreamPrioritiesSupported = 78
    hipDeviceAttributeSurfaceAlignment = 79
    hipDeviceAttributeTccDriver = 80
    hipDeviceAttributeTextureAlignment = 81
    hipDeviceAttributeTexturePitchAlignment = 82
    hipDeviceAttributeTotalConstantMemory = 83
    hipDeviceAttributeTotalGlobalMem = 84
    hipDeviceAttributeUnifiedAddressing = 85
    hipDeviceAttributeUnused2 = 86
    hipDeviceAttributeWarpSize = 87
    hipDeviceAttributeMemoryPoolsSupported = 88
    hipDeviceAttributeVirtualMemoryManagementSupported = 89
    hipDeviceAttributeHostRegisterSupported = 90
    hipDeviceAttributeMemoryPoolSupportedHandleTypes = 91
    hipDeviceAttributeHostNumaId = 92
    hipDeviceAttributeDmaBufSupported = 93
    hipDeviceAttributeGPUDirectRDMAWithHipVMMSupported = 94
    hipDeviceAttributeCudaCompatibleEnd = 9999
    hipDeviceAttributeAmdSpecificBegin = 10000
    hipDeviceAttributeClockInstructionRate = 10000
    hipDeviceAttributeUnused3 = 10001
    hipDeviceAttributeMaxSharedMemoryPerMultiprocessor = 10002
    hipDeviceAttributeUnused4 = 10003
    hipDeviceAttributeUnused5 = 10004
    hipDeviceAttributeHdpMemFlushCntl = 10005
    hipDeviceAttributeHdpRegFlushCntl = 10006
    hipDeviceAttributeCooperativeMultiDeviceUnmatchedFunc = 10007
    hipDeviceAttributeCooperativeMultiDeviceUnmatchedGridDim = 10008
    hipDeviceAttributeCooperativeMultiDeviceUnmatchedBlockDim = 10009
    hipDeviceAttributeCooperativeMultiDeviceUnmatchedSharedMem = 10010
    hipDeviceAttributeIsLargeBar = 10011
    hipDeviceAttributeAsicRevision = 10012
    hipDeviceAttributeCanUseStreamWaitValue = 10013
    hipDeviceAttributeImageSupport = 10014
    hipDeviceAttributePhysicalMultiProcessorCount = 10015
    hipDeviceAttributeFineGrainSupport = 10016
    hipDeviceAttributeWallClockRate = 10017
    hipDeviceAttributeNumberOfXccs = 10018
    hipDeviceAttributeMaxAvailableVgprsPerThread = 10019
    hipDeviceAttributePciChipId = 10020
    hipDeviceAttributeExpertSchedMode = 10021
    hipDeviceAttributeAmdSpecificEnd = 19999
    hipDeviceAttributeVendorSpecificBegin = 20000
end

@cenum hipDriverProcAddressQueryResult::UInt32 begin
    HIP_GET_PROC_ADDRESS_SUCCESS = 0
    HIP_GET_PROC_ADDRESS_SYMBOL_NOT_FOUND = 1
    HIP_GET_PROC_ADDRESS_VERSION_NOT_SUFFICIENT = 2
end

@cenum hipComputeMode::UInt32 begin
    hipComputeModeDefault = 0
    hipComputeModeExclusive = 1
    hipComputeModeProhibited = 2
    hipComputeModeExclusiveProcess = 3
end

@cenum hipFlushGPUDirectRDMAWritesOptions::UInt32 begin
    hipFlushGPUDirectRDMAWritesOptionHost = 1
    hipFlushGPUDirectRDMAWritesOptionMemOps = 2
end

@cenum hipGPUDirectRDMAWritesOrdering::UInt32 begin
    hipGPUDirectRDMAWritesOrderingNone = 0
    hipGPUDirectRDMAWritesOrderingOwner = 100
    hipGPUDirectRDMAWritesOrderingAllDevices = 200
end

struct miopenHandle
end

const miopenHandle_t = Ptr{miopenHandle}

@cenum miopenStatus_t::UInt32 begin
    miopenStatusSuccess = 0
    miopenStatusNotInitialized = 1
    miopenStatusInvalidValue = 2
    miopenStatusBadParm = 3
    miopenStatusAllocFailed = 4
    miopenStatusInternalError = 5
    miopenStatusNotImplemented = 6
    miopenStatusUnknownError = 7
    miopenStatusUnsupportedOp = 8
    miopenStatusGpuOperationsSkipped = 9
    miopenStatusVersionMismatch = 10
end

@cenum miopenMathType_t::UInt32 begin
    miopenMathDefault = 0
    miopenMathPedantic = 1
end

function miopenGetErrorString(error)
    @check @ccall(libMIOpen_path.miopenGetErrorString(error::miopenStatus_t)::Ptr{Cchar})
end

#  typedef void * ( * miopenAllocatorFunction ) ( void * context , size_t sizeBytes )
const miopenAllocatorFunction = Ptr{Cvoid}

#  typedef void ( * miopenDeallocatorFunction ) ( void * context , void * memory )
const miopenDeallocatorFunction = Ptr{Cvoid}

function miopenGetVersion(major, minor, patch)
    @check @ccall(libMIOpen_path.miopenGetVersion(major::Ptr{Csize_t}, minor::Ptr{Csize_t},
                                                  patch::Ptr{Csize_t})::miopenStatus_t)
end

function miopenCreate(handle)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreate(handle::Ptr{miopenHandle_t})::miopenStatus_t)
end

function miopenCreateWithStream(handle, stream)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateWithStream(handle::Ptr{miopenHandle_t},
                                                        stream::miopenAcceleratorQueue_t)::miopenStatus_t)
end

function miopenDestroy(handle)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroy(handle::miopenHandle_t)::miopenStatus_t)
end

function miopenSetStream(handle, streamID)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetStream(handle::miopenHandle_t,
                                                 streamID::miopenAcceleratorQueue_t)::miopenStatus_t)
end

function miopenGetStream(handle, streamID)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetStream(handle::miopenHandle_t,
                                                 streamID::Ptr{miopenAcceleratorQueue_t})::miopenStatus_t)
end

function miopenSetAllocator(handle, allocator, deallocator, allocatorContext)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetAllocator(handle::miopenHandle_t,
                                                    allocator::miopenAllocatorFunction,
                                                    deallocator::miopenDeallocatorFunction,
                                                    allocatorContext::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetKernelTime(handle, time)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetKernelTime(handle::miopenHandle_t,
                                                     time::Ptr{Cfloat})::miopenStatus_t)
end

function miopenEnableProfiling(handle, enable)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenEnableProfiling(handle::miopenHandle_t,
                                                       enable::Bool)::miopenStatus_t)
end

struct miopenFusionOpDescriptor
end

const miopenFusionOpDescriptor_t = Ptr{miopenFusionOpDescriptor}

struct miopenTensorDescriptor
end

const miopenTensorDescriptor_t = Ptr{miopenTensorDescriptor}

struct miopenSeqTensorDescriptor
end

const miopenSeqTensorDescriptor_t = Ptr{miopenSeqTensorDescriptor}

struct miopenConvolutionDescriptor
end

const miopenConvolutionDescriptor_t = Ptr{miopenConvolutionDescriptor}

struct miopenPoolingDescriptor
end

const miopenPoolingDescriptor_t = Ptr{miopenPoolingDescriptor}

struct miopenLRNDescriptor
end

const miopenLRNDescriptor_t = Ptr{miopenLRNDescriptor}

struct miopenActivationDescriptor
end

const miopenActivationDescriptor_t = Ptr{miopenActivationDescriptor}

struct miopenRNNDescriptor
end

const miopenRNNDescriptor_t = Ptr{miopenRNNDescriptor}

struct miopenCTCLossDescriptor
end

const miopenCTCLossDescriptor_t = Ptr{miopenCTCLossDescriptor}

struct miopenDropoutDescriptor
end

const miopenDropoutDescriptor_t = Ptr{miopenDropoutDescriptor}

struct miopenReduceTensorDescriptor
end

const miopenReduceTensorDescriptor_t = Ptr{miopenReduceTensorDescriptor}

struct miopenMhaDescriptor
end

const miopenMhaDescriptor_t = Ptr{miopenMhaDescriptor}

struct miopenSoftmaxDescriptor
end

const miopenSoftmaxDescriptor_t = Ptr{miopenSoftmaxDescriptor}

@cenum miopenDataType_t::UInt32 begin
    miopenHalf = 0
    miopenFloat = 1
    miopenInt32 = 2
    miopenInt8 = 3
    miopenBFloat16 = 5
    miopenDouble = 6
    miopenFloat8_fnuz = 7
    miopenBFloat8_fnuz = 8
    miopenInt64 = 9
end

@cenum miopenTensorLayout_t::UInt32 begin
    miopenTensorNCHW = 0
    miopenTensorNHWC = 1
    miopenTensorCHWN = 2
    miopenTensorNCHWc4 = 3
    miopenTensorNCHWc8 = 4
    miopenTensorCHWNc4 = 5
    miopenTensorCHWNc8 = 6
    miopenTensorNCDHW = 7
    miopenTensorNDHWC = 8
end

@cenum miopenIndexType_t::UInt32 begin
    miopenIndexUint8 = 0
    miopenIndexUint16 = 1
    miopenIndexUint32 = 2
    miopenIndexUint64 = 3
end

@cenum miopenTensorOp_t::UInt32 begin
    miopenTensorOpAdd = 0
    miopenTensorOpMul = 1
    miopenTensorOpMin = 2
    miopenTensorOpMax = 3
end

@cenum miopenConvolutionMode_t::UInt32 begin
    miopenConvolution = 0
    miopenTranspose = 1
    miopenGroupConv = 2
    miopenDepthwise = 3
end

@cenum miopenPaddingMode_t::UInt32 begin
    miopenPaddingDefault = 0
    miopenPaddingSame = 1
    miopenPaddingValid = 2
end

@cenum miopenPoolingMode_t::UInt32 begin
    miopenPoolingMax = 0
    miopenPoolingAverage = 1
    miopenPoolingAverageInclusive = 2
end

@cenum miopenPoolingWorkspaceIndexMode_t::UInt32 begin
    miopenPoolingWorkspaceIndexMask = 0
    miopenPoolingWorkspaceIndexImage = 1
end

@cenum miopenLRNMode_t::UInt32 begin
    miopenLRNWithinChannel = 0
    miopenLRNCrossChannel = 1
end

@cenum miopenBatchNormMode_t::UInt32 begin
    miopenBNPerActivation = 0
    miopenBNSpatial = 1
end

@cenum miopenActivationMode_t::UInt32 begin
    miopenActivationPASTHRU = 0
    miopenActivationLOGISTIC = 1
    miopenActivationTANH = 2
    miopenActivationRELU = 3
    miopenActivationSOFTRELU = 4
    miopenActivationABS = 5
    miopenActivationPOWER = 6
    miopenActivationCLIPPEDRELU = 7
    miopenActivationLEAKYRELU = 8
    miopenActivationELU = 9
    miopenActivationCLAMP = 10
end

@cenum miopenSoftmaxAlgorithm_t::UInt32 begin
    MIOPEN_SOFTMAX_FAST = 0
    MIOPEN_SOFTMAX_ACCURATE = 1
    MIOPEN_SOFTMAX_LOG = 2
end

@cenum miopenSoftmaxMode_t::UInt32 begin
    MIOPEN_SOFTMAX_MODE_INSTANCE = 0
    MIOPEN_SOFTMAX_MODE_CHANNEL = 1
end

@cenum miopenReduceTensorOp_t::UInt32 begin
    MIOPEN_REDUCE_TENSOR_ADD = 0
    MIOPEN_REDUCE_TENSOR_MUL = 1
    MIOPEN_REDUCE_TENSOR_MIN = 2
    MIOPEN_REDUCE_TENSOR_MAX = 3
    MIOPEN_REDUCE_TENSOR_AMAX = 4
    MIOPEN_REDUCE_TENSOR_AVG = 5
    MIOPEN_REDUCE_TENSOR_NORM1 = 6
    MIOPEN_REDUCE_TENSOR_NORM2 = 7
end

@cenum miopenNanPropagation_t::UInt32 begin
    MIOPEN_NOT_PROPAGATE_NAN = 0
    MIOPEN_PROPAGATE_NAN = 1
end

@cenum miopenReduceTensorIndices_t::UInt32 begin
    MIOPEN_REDUCE_TENSOR_NO_INDICES = 0
    MIOPEN_REDUCE_TENSOR_FLATTENED_INDICES = 1
end

@cenum miopenIndicesType_t::UInt32 begin
    MIOPEN_32BIT_INDICES = 0
    MIOPEN_64BIT_INDICES = 1
    MIOPEN_16BIT_INDICES = 2
    MIOPEN_8BIT_INDICES = 3
end

@cenum miopenConvolutionAttrib_t::UInt32 begin
    MIOPEN_CONVOLUTION_ATTRIB_FP16_ALT_IMPL = 0
    MIOPEN_CONVOLUTION_ATTRIB_DETERMINISTIC = 1
    MIOPEN_CONVOLUTION_ATTRIB_MATH_TYPE = 3
end

@cenum miopenConvolutionFindMode_t::UInt32 begin
    miopenConvolutionFindModeNormal = 1
    miopenConvolutionFindModeFast = 2
    miopenConvolutionFindModeHybrid = 3
    miopenConvolutionFindModeDynamicHybrid = 5
    miopenConvolutionFindModeTrustVerify = 6
    miopenConvolutionFindModeTrustVerifyFull = 7
    miopenConvolutionFindModeDefault = 5
end

function miopenCreateTensorDescriptor(tensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateTensorDescriptor(tensorDesc::Ptr{miopenTensorDescriptor_t})::miopenStatus_t)
end

function miopenSet4dTensorDescriptor(tensorDesc, dataType, n, c, h, w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSet4dTensorDescriptor(tensorDesc::miopenTensorDescriptor_t,
                                                             dataType::miopenDataType_t,
                                                             n::Cint, c::Cint, h::Cint,
                                                             w::Cint)::miopenStatus_t)
end

function miopenSetNdTensorDescriptorWithLayout(tensorDesc, dataType, tensorLayout, lens,
                                               num_lens)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetNdTensorDescriptorWithLayout(tensorDesc::miopenTensorDescriptor_t,
                                                                       dataType::miopenDataType_t,
                                                                       tensorLayout::miopenTensorLayout_t,
                                                                       lens::Ptr{Cint},
                                                                       num_lens::Cint)::miopenStatus_t)
end

function miopenSet4dTensorDescriptorEx(tensorDesc, dataType, n, c, h, w, nStride, cStride,
                                       hStride, wStride)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSet4dTensorDescriptorEx(tensorDesc::miopenTensorDescriptor_t,
                                                               dataType::miopenDataType_t,
                                                               n::Cint, c::Cint, h::Cint,
                                                               w::Cint, nStride::Cint,
                                                               cStride::Cint, hStride::Cint,
                                                               wStride::Cint)::miopenStatus_t)
end

function miopenGet4dTensorDescriptor(tensorDesc, dataType, n, c, h, w, nStride, cStride,
                                     hStride, wStride)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGet4dTensorDescriptor(tensorDesc::miopenTensorDescriptor_t,
                                                             dataType::Ptr{miopenDataType_t},
                                                             n::Ptr{Cint}, c::Ptr{Cint},
                                                             h::Ptr{Cint}, w::Ptr{Cint},
                                                             nStride::Ptr{Cint},
                                                             cStride::Ptr{Cint},
                                                             hStride::Ptr{Cint},
                                                             wStride::Ptr{Cint})::miopenStatus_t)
end

function miopenSetTensorDescriptor(tensorDesc, dataType, nbDims, dimsA, stridesA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetTensorDescriptor(tensorDesc::miopenTensorDescriptor_t,
                                                           dataType::miopenDataType_t,
                                                           nbDims::Cint, dimsA::Ptr{Cint},
                                                           stridesA::Ptr{Cint})::miopenStatus_t)
end

function miopenGetTensorDescriptorSize(tensorDesc, size)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetTensorDescriptorSize(tensorDesc::miopenTensorDescriptor_t,
                                                               size::Ptr{Cint})::miopenStatus_t)
end

function miopenGetTensorDescriptor(tensorDesc, dataType, dimsA, stridesA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetTensorDescriptor(tensorDesc::miopenTensorDescriptor_t,
                                                           dataType::Ptr{miopenDataType_t},
                                                           dimsA::Ptr{Cint},
                                                           stridesA::Ptr{Cint})::miopenStatus_t)
end

function miopenDestroyTensorDescriptor(tensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyTensorDescriptor(tensorDesc::miopenTensorDescriptor_t)::miopenStatus_t)
end

function miopenCreateSeqTensorDescriptor(tensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateSeqTensorDescriptor(tensorDesc::Ptr{miopenSeqTensorDescriptor_t})::miopenStatus_t)
end

function miopenDestroySeqTensorDescriptor(tensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroySeqTensorDescriptor(tensorDesc::miopenSeqTensorDescriptor_t)::miopenStatus_t)
end

function miopenOpTensor(handle, tensorOp, alpha1, aDesc, A, alpha2, bDesc, B, beta, cDesc,
                        C)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenOpTensor(handle::miopenHandle_t,
                                                tensorOp::miopenTensorOp_t,
                                                alpha1::Ptr{Cvoid},
                                                aDesc::miopenTensorDescriptor_t,
                                                A::Ptr{Cvoid}, alpha2::Ptr{Cvoid},
                                                bDesc::miopenTensorDescriptor_t,
                                                B::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                cDesc::miopenTensorDescriptor_t,
                                                C::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetTensor(handle, yDesc, y, alpha)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetTensor(handle::miopenHandle_t,
                                                 yDesc::miopenTensorDescriptor_t,
                                                 y::Ptr{Cvoid},
                                                 alpha::Ptr{Cvoid})::miopenStatus_t)
end

function miopenScaleTensor(handle, yDesc, y, alpha)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenScaleTensor(handle::miopenHandle_t,
                                                   yDesc::miopenTensorDescriptor_t,
                                                   y::Ptr{Cvoid},
                                                   alpha::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetTensorNumBytes(tensorDesc, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetTensorNumBytes(tensorDesc::miopenTensorDescriptor_t,
                                                         numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenTransformTensor(handle, alpha, xDesc, x, beta, yDesc, y)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenTransformTensor(handle::miopenHandle_t,
                                                       alpha::Ptr{Cvoid},
                                                       xDesc::miopenTensorDescriptor_t,
                                                       x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                       yDesc::miopenTensorDescriptor_t,
                                                       y::Ptr{Cvoid})::miopenStatus_t)
end

function miopenCreateConvolutionDescriptor(convDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateConvolutionDescriptor(convDesc::Ptr{miopenConvolutionDescriptor_t})::miopenStatus_t)
end

function miopenInitConvolutionDescriptor(convDesc, c_mode, pad_h, pad_w, stride_h, stride_w,
                                         dilation_h, dilation_w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenInitConvolutionDescriptor(convDesc::miopenConvolutionDescriptor_t,
                                                                 c_mode::miopenConvolutionMode_t,
                                                                 pad_h::Cint, pad_w::Cint,
                                                                 stride_h::Cint,
                                                                 stride_w::Cint,
                                                                 dilation_h::Cint,
                                                                 dilation_w::Cint)::miopenStatus_t)
end

function miopenInitConvolutionNdDescriptor(convDesc, spatialDim, padA, strideA, dilationA,
                                           c_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenInitConvolutionNdDescriptor(convDesc::miopenConvolutionDescriptor_t,
                                                                   spatialDim::Cint,
                                                                   padA::Ptr{Cint},
                                                                   strideA::Ptr{Cint},
                                                                   dilationA::Ptr{Cint},
                                                                   c_mode::miopenConvolutionMode_t)::miopenStatus_t)
end

function miopenGetConvolutionSpatialDim(convDesc, spatialDim)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionSpatialDim(convDesc::miopenConvolutionDescriptor_t,
                                                                spatialDim::Ptr{Cint})::miopenStatus_t)
end

function miopenGetConvolutionDescriptor(convDesc, c_mode, pad_h, pad_w, stride_h, stride_w,
                                        dilation_h, dilation_w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionDescriptor(convDesc::miopenConvolutionDescriptor_t,
                                                                c_mode::Ptr{miopenConvolutionMode_t},
                                                                pad_h::Ptr{Cint},
                                                                pad_w::Ptr{Cint},
                                                                stride_h::Ptr{Cint},
                                                                stride_w::Ptr{Cint},
                                                                dilation_h::Ptr{Cint},
                                                                dilation_w::Ptr{Cint})::miopenStatus_t)
end

function miopenGetConvolutionNdDescriptor(convDesc, requestedSpatialDim, spatialDim, padA,
                                          strideA, dilationA, c_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionNdDescriptor(convDesc::miopenConvolutionDescriptor_t,
                                                                  requestedSpatialDim::Cint,
                                                                  spatialDim::Ptr{Cint},
                                                                  padA::Ptr{Cint},
                                                                  strideA::Ptr{Cint},
                                                                  dilationA::Ptr{Cint},
                                                                  c_mode::Ptr{miopenConvolutionMode_t})::miopenStatus_t)
end

function miopenGetConvolutionGroupCount(convDesc, groupCount)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionGroupCount(convDesc::miopenConvolutionDescriptor_t,
                                                                groupCount::Ptr{Cint})::miopenStatus_t)
end

function miopenSetConvolutionGroupCount(convDesc, groupCount)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetConvolutionGroupCount(convDesc::miopenConvolutionDescriptor_t,
                                                                groupCount::Cint)::miopenStatus_t)
end

function miopenSetTransposeConvOutputPadding(convDesc, adj_h, adj_w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetTransposeConvOutputPadding(convDesc::miopenConvolutionDescriptor_t,
                                                                     adj_h::Cint,
                                                                     adj_w::Cint)::miopenStatus_t)
end

function miopenSetTransposeConvNdOutputPadding(convDesc, spatialDim, adjA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetTransposeConvNdOutputPadding(convDesc::miopenConvolutionDescriptor_t,
                                                                       spatialDim::Cint,
                                                                       adjA::Ptr{Cint})::miopenStatus_t)
end

function miopenGetConvolutionForwardOutputDim(convDesc, inputTensorDesc, filterDesc, n, c,
                                              h, w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionForwardOutputDim(convDesc::miopenConvolutionDescriptor_t,
                                                                      inputTensorDesc::miopenTensorDescriptor_t,
                                                                      filterDesc::miopenTensorDescriptor_t,
                                                                      n::Ptr{Cint},
                                                                      c::Ptr{Cint},
                                                                      h::Ptr{Cint},
                                                                      w::Ptr{Cint})::miopenStatus_t)
end

function miopenGetConvolutionNdForwardOutputDim(convDesc, inputTensorDesc, filterDesc, nDim,
                                                outputTensorDimA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionNdForwardOutputDim(convDesc::miopenConvolutionDescriptor_t,
                                                                        inputTensorDesc::miopenTensorDescriptor_t,
                                                                        filterDesc::miopenTensorDescriptor_t,
                                                                        nDim::Ptr{Cint},
                                                                        outputTensorDimA::Ptr{Cint})::miopenStatus_t)
end

function miopenDestroyConvolutionDescriptor(convDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyConvolutionDescriptor(convDesc::miopenConvolutionDescriptor_t)::miopenStatus_t)
end

function miopenSetConvolutionAttribute(convDesc, attr, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetConvolutionAttribute(convDesc::miopenConvolutionDescriptor_t,
                                                               attr::miopenConvolutionAttrib_t,
                                                               value::Cint)::miopenStatus_t)
end

function miopenGetConvolutionAttribute(convDesc, attr, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionAttribute(convDesc::miopenConvolutionDescriptor_t,
                                                               attr::miopenConvolutionAttrib_t,
                                                               value::Ptr{Cint})::miopenStatus_t)
end

function miopenSetConvolutionFindMode(convDesc, findMode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetConvolutionFindMode(convDesc::miopenConvolutionDescriptor_t,
                                                              findMode::miopenConvolutionFindMode_t)::miopenStatus_t)
end

function miopenGetConvolutionFindMode(convDesc, findMode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetConvolutionFindMode(convDesc::miopenConvolutionDescriptor_t,
                                                              findMode::Ptr{miopenConvolutionFindMode_t})::miopenStatus_t)
end

@cenum miopenConvFwdAlgorithm_t::UInt32 begin
    miopenConvolutionFwdAlgoGEMM = 0
    miopenConvolutionFwdAlgoDirect = 1
    miopenConvolutionFwdAlgoFFT = 2
    miopenConvolutionFwdAlgoWinograd = 3
    miopenConvolutionFwdAlgoImplicitGEMM = 5
end

@cenum miopenConvBwdWeightsAlgorithm_t::UInt32 begin
    miopenConvolutionBwdWeightsAlgoGEMM = 0
    miopenConvolutionBwdWeightsAlgoDirect = 1
    miopenConvolutionBwdWeightsAlgoWinograd = 3
    miopenConvolutionBwdWeightsAlgoImplicitGEMM = 5
end

@cenum miopenConvBwdDataAlgorithm_t::UInt32 begin
    miopenConvolutionBwdDataAlgoGEMM = 0
    miopenConvolutionBwdDataAlgoDirect = 1
    miopenConvolutionBwdDataAlgoFFT = 2
    miopenConvolutionBwdDataAlgoWinograd = 3
    miopenTransposeBwdDataAlgoGEMM = 4
    miopenConvolutionBwdDataAlgoImplicitGEMM = 5
end

@cenum miopenConvAlgorithm_t::UInt32 begin
    miopenConvolutionAlgoGEMM = 0
    miopenConvolutionAlgoDirect = 1
    miopenConvolutionAlgoFFT = 2
    miopenConvolutionAlgoWinograd = 3
    miopenConvolutionAlgoImplicitGEMM = 5
end

struct miopenConvAlgoPerf_t
    data::NTuple{16,UInt8}
end

function Base.getproperty(x::Ptr{miopenConvAlgoPerf_t}, f::Symbol)
    f === :fwd_algo && return Ptr{miopenConvFwdAlgorithm_t}(x + 0)
    f === :bwd_weights_algo && return Ptr{miopenConvBwdWeightsAlgorithm_t}(x + 0)
    f === :bwd_data_algo && return Ptr{miopenConvBwdDataAlgorithm_t}(x + 0)
    f === :time && return Ptr{Cfloat}(x + 4)
    f === :memory && return Ptr{Csize_t}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::miopenConvAlgoPerf_t, f::Symbol)
    r = Ref{miopenConvAlgoPerf_t}(x)
    ptr = Base.unsafe_convert(Ptr{miopenConvAlgoPerf_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{miopenConvAlgoPerf_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::miopenConvAlgoPerf_t, private::Bool=false)
    return (:fwd_algo, :bwd_weights_algo, :bwd_data_algo, :time, :memory,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct miopenConvSolution_t
    time::Cfloat
    workspace_size::Csize_t
    solution_id::UInt64
    algorithm::miopenConvAlgorithm_t
end

function miopenConvolutionForwardGetSolutionCount(handle, wDesc, xDesc, convDesc, yDesc,
                                                  solutionCount)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardGetSolutionCount(handle::miopenHandle_t,
                                                                          wDesc::miopenTensorDescriptor_t,
                                                                          xDesc::miopenTensorDescriptor_t,
                                                                          convDesc::miopenConvolutionDescriptor_t,
                                                                          yDesc::miopenTensorDescriptor_t,
                                                                          solutionCount::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionForwardGetSolution(handle, wDesc, xDesc, convDesc, yDesc,
                                             maxSolutionCount, solutionCount, solutions)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardGetSolution(handle::miopenHandle_t,
                                                                     wDesc::miopenTensorDescriptor_t,
                                                                     xDesc::miopenTensorDescriptor_t,
                                                                     convDesc::miopenConvolutionDescriptor_t,
                                                                     yDesc::miopenTensorDescriptor_t,
                                                                     maxSolutionCount::Csize_t,
                                                                     solutionCount::Ptr{Csize_t},
                                                                     solutions::Ptr{miopenConvSolution_t})::miopenStatus_t)
end

function miopenConvolutionForwardGetSolutionWorkspaceSize(handle, wDesc, xDesc, convDesc,
                                                          yDesc, solution_id, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardGetSolutionWorkspaceSize(handle::miopenHandle_t,
                                                                                  wDesc::miopenTensorDescriptor_t,
                                                                                  xDesc::miopenTensorDescriptor_t,
                                                                                  convDesc::miopenConvolutionDescriptor_t,
                                                                                  yDesc::miopenTensorDescriptor_t,
                                                                                  solution_id::UInt64,
                                                                                  workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionForwardCompileSolution(handle, wDesc, xDesc, convDesc, yDesc,
                                                 solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardCompileSolution(handle::miopenHandle_t,
                                                                         wDesc::miopenTensorDescriptor_t,
                                                                         xDesc::miopenTensorDescriptor_t,
                                                                         convDesc::miopenConvolutionDescriptor_t,
                                                                         yDesc::miopenTensorDescriptor_t,
                                                                         solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionForwardImmediate(handle, wDesc, w, xDesc, x, convDesc, yDesc, y,
                                           workSpace, workSpaceSize, solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardImmediate(handle::miopenHandle_t,
                                                                   wDesc::miopenTensorDescriptor_t,
                                                                   w::Ptr{Cvoid},
                                                                   xDesc::miopenTensorDescriptor_t,
                                                                   x::Ptr{Cvoid},
                                                                   convDesc::miopenConvolutionDescriptor_t,
                                                                   yDesc::miopenTensorDescriptor_t,
                                                                   y::Ptr{Cvoid},
                                                                   workSpace::Ptr{Cvoid},
                                                                   workSpaceSize::Csize_t,
                                                                   solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionBackwardDataGetSolutionCount(handle, dyDesc, wDesc, convDesc,
                                                       dxDesc, solutionCount)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataGetSolutionCount(handle::miopenHandle_t,
                                                                               dyDesc::miopenTensorDescriptor_t,
                                                                               wDesc::miopenTensorDescriptor_t,
                                                                               convDesc::miopenConvolutionDescriptor_t,
                                                                               dxDesc::miopenTensorDescriptor_t,
                                                                               solutionCount::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionBackwardDataGetSolution(handle, dyDesc, wDesc, convDesc, dxDesc,
                                                  maxSolutionCount, solutionCount,
                                                  solutions)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataGetSolution(handle::miopenHandle_t,
                                                                          dyDesc::miopenTensorDescriptor_t,
                                                                          wDesc::miopenTensorDescriptor_t,
                                                                          convDesc::miopenConvolutionDescriptor_t,
                                                                          dxDesc::miopenTensorDescriptor_t,
                                                                          maxSolutionCount::Csize_t,
                                                                          solutionCount::Ptr{Csize_t},
                                                                          solutions::Ptr{miopenConvSolution_t})::miopenStatus_t)
end

function miopenConvolutionBackwardDataGetSolutionWorkspaceSize(handle, dyDesc, wDesc,
                                                               convDesc, dxDesc,
                                                               solution_id, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataGetSolutionWorkspaceSize(handle::miopenHandle_t,
                                                                                       dyDesc::miopenTensorDescriptor_t,
                                                                                       wDesc::miopenTensorDescriptor_t,
                                                                                       convDesc::miopenConvolutionDescriptor_t,
                                                                                       dxDesc::miopenTensorDescriptor_t,
                                                                                       solution_id::UInt64,
                                                                                       workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionBackwardDataCompileSolution(handle, dyDesc, wDesc, convDesc,
                                                      dxDesc, solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataCompileSolution(handle::miopenHandle_t,
                                                                              dyDesc::miopenTensorDescriptor_t,
                                                                              wDesc::miopenTensorDescriptor_t,
                                                                              convDesc::miopenConvolutionDescriptor_t,
                                                                              dxDesc::miopenTensorDescriptor_t,
                                                                              solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionBackwardDataImmediate(handle, dyDesc, dy, wDesc, w, convDesc,
                                                dxDesc, dx, workSpace, workSpaceSize,
                                                solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataImmediate(handle::miopenHandle_t,
                                                                        dyDesc::miopenTensorDescriptor_t,
                                                                        dy::Ptr{Cvoid},
                                                                        wDesc::miopenTensorDescriptor_t,
                                                                        w::Ptr{Cvoid},
                                                                        convDesc::miopenConvolutionDescriptor_t,
                                                                        dxDesc::miopenTensorDescriptor_t,
                                                                        dx::Ptr{Cvoid},
                                                                        workSpace::Ptr{Cvoid},
                                                                        workSpaceSize::Csize_t,
                                                                        solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsGetSolutionCount(handle, dyDesc, xDesc, convDesc,
                                                          dwDesc, solutionCount)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsGetSolutionCount(handle::miopenHandle_t,
                                                                                  dyDesc::miopenTensorDescriptor_t,
                                                                                  xDesc::miopenTensorDescriptor_t,
                                                                                  convDesc::miopenConvolutionDescriptor_t,
                                                                                  dwDesc::miopenTensorDescriptor_t,
                                                                                  solutionCount::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsGetSolution(handle, dyDesc, xDesc, convDesc,
                                                     dwDesc, maxSolutionCount,
                                                     solutionCount, solutions)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsGetSolution(handle::miopenHandle_t,
                                                                             dyDesc::miopenTensorDescriptor_t,
                                                                             xDesc::miopenTensorDescriptor_t,
                                                                             convDesc::miopenConvolutionDescriptor_t,
                                                                             dwDesc::miopenTensorDescriptor_t,
                                                                             maxSolutionCount::Csize_t,
                                                                             solutionCount::Ptr{Csize_t},
                                                                             solutions::Ptr{miopenConvSolution_t})::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsGetSolutionWorkspaceSize(handle, dyDesc, xDesc,
                                                                  convDesc, dwDesc,
                                                                  solution_id,
                                                                  workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsGetSolutionWorkspaceSize(handle::miopenHandle_t,
                                                                                          dyDesc::miopenTensorDescriptor_t,
                                                                                          xDesc::miopenTensorDescriptor_t,
                                                                                          convDesc::miopenConvolutionDescriptor_t,
                                                                                          dwDesc::miopenTensorDescriptor_t,
                                                                                          solution_id::UInt64,
                                                                                          workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsCompileSolution(handle, dyDesc, xDesc, convDesc,
                                                         dwDesc, solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsCompileSolution(handle::miopenHandle_t,
                                                                                 dyDesc::miopenTensorDescriptor_t,
                                                                                 xDesc::miopenTensorDescriptor_t,
                                                                                 convDesc::miopenConvolutionDescriptor_t,
                                                                                 dwDesc::miopenTensorDescriptor_t,
                                                                                 solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsImmediate(handle, dyDesc, dy, xDesc, x, convDesc,
                                                   dwDesc, dw, workSpace, workSpaceSize,
                                                   solution_id)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsImmediate(handle::miopenHandle_t,
                                                                           dyDesc::miopenTensorDescriptor_t,
                                                                           dy::Ptr{Cvoid},
                                                                           xDesc::miopenTensorDescriptor_t,
                                                                           x::Ptr{Cvoid},
                                                                           convDesc::miopenConvolutionDescriptor_t,
                                                                           dwDesc::miopenTensorDescriptor_t,
                                                                           dw::Ptr{Cvoid},
                                                                           workSpace::Ptr{Cvoid},
                                                                           workSpaceSize::Csize_t,
                                                                           solution_id::UInt64)::miopenStatus_t)
end

function miopenConvolutionForwardGetWorkSpaceSize(handle, wDesc, xDesc, convDesc, yDesc,
                                                  workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardGetWorkSpaceSize(handle::miopenHandle_t,
                                                                          wDesc::miopenTensorDescriptor_t,
                                                                          xDesc::miopenTensorDescriptor_t,
                                                                          convDesc::miopenConvolutionDescriptor_t,
                                                                          yDesc::miopenTensorDescriptor_t,
                                                                          workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenFindConvolutionForwardAlgorithm(handle, xDesc, x, wDesc, w, convDesc, yDesc,
                                               y, requestAlgoCount, returnedAlgoCount,
                                               perfResults, workSpace, workSpaceSize,
                                               exhaustiveSearch)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFindConvolutionForwardAlgorithm(handle::miopenHandle_t,
                                                                       xDesc::miopenTensorDescriptor_t,
                                                                       x::Ptr{Cvoid},
                                                                       wDesc::miopenTensorDescriptor_t,
                                                                       w::Ptr{Cvoid},
                                                                       convDesc::miopenConvolutionDescriptor_t,
                                                                       yDesc::miopenTensorDescriptor_t,
                                                                       y::Ptr{Cvoid},
                                                                       requestAlgoCount::Cint,
                                                                       returnedAlgoCount::Ptr{Cint},
                                                                       perfResults::Ptr{miopenConvAlgoPerf_t},
                                                                       workSpace::Ptr{Cvoid},
                                                                       workSpaceSize::Csize_t,
                                                                       exhaustiveSearch::Bool)::miopenStatus_t)
end

function miopenConvolutionForward(handle, alpha, xDesc, x, wDesc, w, convDesc, algo, beta,
                                  yDesc, y, workSpace, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForward(handle::miopenHandle_t,
                                                          alpha::Ptr{Cvoid},
                                                          xDesc::miopenTensorDescriptor_t,
                                                          x::Ptr{Cvoid},
                                                          wDesc::miopenTensorDescriptor_t,
                                                          w::Ptr{Cvoid},
                                                          convDesc::miopenConvolutionDescriptor_t,
                                                          algo::miopenConvFwdAlgorithm_t,
                                                          beta::Ptr{Cvoid},
                                                          yDesc::miopenTensorDescriptor_t,
                                                          y::Ptr{Cvoid},
                                                          workSpace::Ptr{Cvoid},
                                                          workSpaceSize::Csize_t)::miopenStatus_t)
end

function miopenConvolutionForwardBias(handle, alpha, bDesc, b, beta, yDesc, y)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionForwardBias(handle::miopenHandle_t,
                                                              alpha::Ptr{Cvoid},
                                                              bDesc::miopenTensorDescriptor_t,
                                                              b::Ptr{Cvoid},
                                                              beta::Ptr{Cvoid},
                                                              yDesc::miopenTensorDescriptor_t,
                                                              y::Ptr{Cvoid})::miopenStatus_t)
end

function miopenConvolutionBackwardDataGetWorkSpaceSize(handle, dyDesc, wDesc, convDesc,
                                                       dxDesc, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardDataGetWorkSpaceSize(handle::miopenHandle_t,
                                                                               dyDesc::miopenTensorDescriptor_t,
                                                                               wDesc::miopenTensorDescriptor_t,
                                                                               convDesc::miopenConvolutionDescriptor_t,
                                                                               dxDesc::miopenTensorDescriptor_t,
                                                                               workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenFindConvolutionBackwardDataAlgorithm(handle, dyDesc, dy, wDesc, w, convDesc,
                                                    dxDesc, dx, requestAlgoCount,
                                                    returnedAlgoCount, perfResults,
                                                    workSpace, workSpaceSize,
                                                    exhaustiveSearch)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFindConvolutionBackwardDataAlgorithm(handle::miopenHandle_t,
                                                                            dyDesc::miopenTensorDescriptor_t,
                                                                            dy::Ptr{Cvoid},
                                                                            wDesc::miopenTensorDescriptor_t,
                                                                            w::Ptr{Cvoid},
                                                                            convDesc::miopenConvolutionDescriptor_t,
                                                                            dxDesc::miopenTensorDescriptor_t,
                                                                            dx::Ptr{Cvoid},
                                                                            requestAlgoCount::Cint,
                                                                            returnedAlgoCount::Ptr{Cint},
                                                                            perfResults::Ptr{miopenConvAlgoPerf_t},
                                                                            workSpace::Ptr{Cvoid},
                                                                            workSpaceSize::Csize_t,
                                                                            exhaustiveSearch::Bool)::miopenStatus_t)
end

function miopenConvolutionBackwardData(handle, alpha, dyDesc, dy, wDesc, w, convDesc, algo,
                                       beta, dxDesc, dx, workSpace, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardData(handle::miopenHandle_t,
                                                               alpha::Ptr{Cvoid},
                                                               dyDesc::miopenTensorDescriptor_t,
                                                               dy::Ptr{Cvoid},
                                                               wDesc::miopenTensorDescriptor_t,
                                                               w::Ptr{Cvoid},
                                                               convDesc::miopenConvolutionDescriptor_t,
                                                               algo::miopenConvBwdDataAlgorithm_t,
                                                               beta::Ptr{Cvoid},
                                                               dxDesc::miopenTensorDescriptor_t,
                                                               dx::Ptr{Cvoid},
                                                               workSpace::Ptr{Cvoid},
                                                               workSpaceSize::Csize_t)::miopenStatus_t)
end

function miopenConvolutionBackwardWeightsGetWorkSpaceSize(handle, dyDesc, xDesc, convDesc,
                                                          dwDesc, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeightsGetWorkSpaceSize(handle::miopenHandle_t,
                                                                                  dyDesc::miopenTensorDescriptor_t,
                                                                                  xDesc::miopenTensorDescriptor_t,
                                                                                  convDesc::miopenConvolutionDescriptor_t,
                                                                                  dwDesc::miopenTensorDescriptor_t,
                                                                                  workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenFindConvolutionBackwardWeightsAlgorithm(handle, dyDesc, dy, xDesc, x,
                                                       convDesc, dwDesc, dw,
                                                       requestAlgoCount, returnedAlgoCount,
                                                       perfResults, workSpace,
                                                       workSpaceSize, exhaustiveSearch)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFindConvolutionBackwardWeightsAlgorithm(handle::miopenHandle_t,
                                                                               dyDesc::miopenTensorDescriptor_t,
                                                                               dy::Ptr{Cvoid},
                                                                               xDesc::miopenTensorDescriptor_t,
                                                                               x::Ptr{Cvoid},
                                                                               convDesc::miopenConvolutionDescriptor_t,
                                                                               dwDesc::miopenTensorDescriptor_t,
                                                                               dw::Ptr{Cvoid},
                                                                               requestAlgoCount::Cint,
                                                                               returnedAlgoCount::Ptr{Cint},
                                                                               perfResults::Ptr{miopenConvAlgoPerf_t},
                                                                               workSpace::Ptr{Cvoid},
                                                                               workSpaceSize::Csize_t,
                                                                               exhaustiveSearch::Bool)::miopenStatus_t)
end

function miopenConvolutionBackwardWeights(handle, alpha, dyDesc, dy, xDesc, x, convDesc,
                                          algo, beta, dwDesc, dw, workSpace, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardWeights(handle::miopenHandle_t,
                                                                  alpha::Ptr{Cvoid},
                                                                  dyDesc::miopenTensorDescriptor_t,
                                                                  dy::Ptr{Cvoid},
                                                                  xDesc::miopenTensorDescriptor_t,
                                                                  x::Ptr{Cvoid},
                                                                  convDesc::miopenConvolutionDescriptor_t,
                                                                  algo::miopenConvBwdWeightsAlgorithm_t,
                                                                  beta::Ptr{Cvoid},
                                                                  dwDesc::miopenTensorDescriptor_t,
                                                                  dw::Ptr{Cvoid},
                                                                  workSpace::Ptr{Cvoid},
                                                                  workSpaceSize::Csize_t)::miopenStatus_t)
end

function miopenConvolutionBackwardBias(handle, alpha, dyDesc, dy, beta, dbDesc, db)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBackwardBias(handle::miopenHandle_t,
                                                               alpha::Ptr{Cvoid},
                                                               dyDesc::miopenTensorDescriptor_t,
                                                               dy::Ptr{Cvoid},
                                                               beta::Ptr{Cvoid},
                                                               dbDesc::miopenTensorDescriptor_t,
                                                               db::Ptr{Cvoid})::miopenStatus_t)
end

function miopenCreatePoolingDescriptor(poolDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreatePoolingDescriptor(poolDesc::Ptr{miopenPoolingDescriptor_t})::miopenStatus_t)
end

function miopenSetPoolingIndexType(poolDesc, index_type)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetPoolingIndexType(poolDesc::miopenPoolingDescriptor_t,
                                                           index_type::miopenIndexType_t)::miopenStatus_t)
end

function miopenGetPoolingIndexType(poolDesc, index_type)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetPoolingIndexType(poolDesc::miopenPoolingDescriptor_t,
                                                           index_type::Ptr{miopenIndexType_t})::miopenStatus_t)
end

function miopenSetPoolingWorkSpaceIndexMode(poolDesc, workspace_index)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetPoolingWorkSpaceIndexMode(poolDesc::miopenPoolingDescriptor_t,
                                                                    workspace_index::miopenPoolingWorkspaceIndexMode_t)::miopenStatus_t)
end

function miopenGetPoolingWorkSpaceIndexMode(poolDesc, workspace_index)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetPoolingWorkSpaceIndexMode(poolDesc::miopenPoolingDescriptor_t,
                                                                    workspace_index::Ptr{miopenPoolingWorkspaceIndexMode_t})::miopenStatus_t)
end

function miopenSet2dPoolingDescriptor(poolDesc, mode, windowHeight, windowWidth, pad_h,
                                      pad_w, stride_h, stride_w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSet2dPoolingDescriptor(poolDesc::miopenPoolingDescriptor_t,
                                                              mode::miopenPoolingMode_t,
                                                              windowHeight::Cint,
                                                              windowWidth::Cint,
                                                              pad_h::Cint, pad_w::Cint,
                                                              stride_h::Cint,
                                                              stride_w::Cint)::miopenStatus_t)
end

function miopenGet2dPoolingDescriptor(poolDesc, mode, windowHeight, windowWidth, pad_h,
                                      pad_w, stride_h, stride_w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGet2dPoolingDescriptor(poolDesc::miopenPoolingDescriptor_t,
                                                              mode::Ptr{miopenPoolingMode_t},
                                                              windowHeight::Ptr{Cint},
                                                              windowWidth::Ptr{Cint},
                                                              pad_h::Ptr{Cint},
                                                              pad_w::Ptr{Cint},
                                                              stride_h::Ptr{Cint},
                                                              stride_w::Ptr{Cint})::miopenStatus_t)
end

function miopenGetPoolingForwardOutputDim(poolDesc, tensorDesc, n, c, h, w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetPoolingForwardOutputDim(poolDesc::miopenPoolingDescriptor_t,
                                                                  tensorDesc::miopenTensorDescriptor_t,
                                                                  n::Ptr{Cint},
                                                                  c::Ptr{Cint},
                                                                  h::Ptr{Cint},
                                                                  w::Ptr{Cint})::miopenStatus_t)
end

function miopenSetNdPoolingDescriptor(poolDesc, mode, nbDims, windowDimA, padA, stridesA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetNdPoolingDescriptor(poolDesc::miopenPoolingDescriptor_t,
                                                              mode::miopenPoolingMode_t,
                                                              nbDims::Cint,
                                                              windowDimA::Ptr{Cint},
                                                              padA::Ptr{Cint},
                                                              stridesA::Ptr{Cint})::miopenStatus_t)
end

function miopenGetNdPoolingDescriptor(poolDesc, nbDimsRequested, mode, nbDims, windowDimA,
                                      padA, stridesA)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetNdPoolingDescriptor(poolDesc::miopenPoolingDescriptor_t,
                                                              nbDimsRequested::Cint,
                                                              mode::Ptr{miopenPoolingMode_t},
                                                              nbDims::Ptr{Cint},
                                                              windowDimA::Ptr{Cint},
                                                              padA::Ptr{Cint},
                                                              stridesA::Ptr{Cint})::miopenStatus_t)
end

function miopenGetPoolingNdForwardOutputDim(poolDesc, tensorDesc, dims, tensorDimArr)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetPoolingNdForwardOutputDim(poolDesc::miopenPoolingDescriptor_t,
                                                                    tensorDesc::miopenTensorDescriptor_t,
                                                                    dims::Cint,
                                                                    tensorDimArr::Ptr{Cint})::miopenStatus_t)
end

function miopenPoolingGetWorkSpaceSize(yDesc, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenPoolingGetWorkSpaceSize(yDesc::miopenTensorDescriptor_t,
                                                               workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenPoolingGetWorkSpaceSizeV2(poolDesc, yDesc, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenPoolingGetWorkSpaceSizeV2(poolDesc::miopenPoolingDescriptor_t,
                                                                 yDesc::miopenTensorDescriptor_t,
                                                                 workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenPoolingForward(handle, poolDesc, alpha, xDesc, x, beta, yDesc, y,
                              do_backward, workSpace, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenPoolingForward(handle::miopenHandle_t,
                                                      poolDesc::miopenPoolingDescriptor_t,
                                                      alpha::Ptr{Cvoid},
                                                      xDesc::miopenTensorDescriptor_t,
                                                      x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                      yDesc::miopenTensorDescriptor_t,
                                                      y::Ptr{Cvoid}, do_backward::Bool,
                                                      workSpace::Ptr{Cvoid},
                                                      workSpaceSize::Csize_t)::miopenStatus_t)
end

function miopenPoolingBackward(handle, poolDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x,
                               beta, dxDesc, dx, workSpace)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenPoolingBackward(handle::miopenHandle_t,
                                                       poolDesc::miopenPoolingDescriptor_t,
                                                       alpha::Ptr{Cvoid},
                                                       yDesc::miopenTensorDescriptor_t,
                                                       y::Ptr{Cvoid},
                                                       dyDesc::miopenTensorDescriptor_t,
                                                       dy::Ptr{Cvoid},
                                                       xDesc::miopenTensorDescriptor_t,
                                                       x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                       dxDesc::miopenTensorDescriptor_t,
                                                       dx::Ptr{Cvoid},
                                                       workSpace::Ptr{Cvoid})::miopenStatus_t)
end

function miopenDestroyPoolingDescriptor(poolDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyPoolingDescriptor(poolDesc::miopenPoolingDescriptor_t)::miopenStatus_t)
end

function miopenCreateLRNDescriptor(lrnDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateLRNDescriptor(lrnDesc::Ptr{miopenLRNDescriptor_t})::miopenStatus_t)
end

function miopenSetLRNDescriptor(lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetLRNDescriptor(lrnDesc::miopenLRNDescriptor_t,
                                                        mode::miopenLRNMode_t, lrnN::Cuint,
                                                        lrnAlpha::Cdouble, lrnBeta::Cdouble,
                                                        lrnK::Cdouble)::miopenStatus_t)
end

function miopenGetLRNDescriptor(lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetLRNDescriptor(lrnDesc::miopenLRNDescriptor_t,
                                                        mode::Ptr{miopenLRNMode_t},
                                                        lrnN::Ptr{Cuint},
                                                        lrnAlpha::Ptr{Cdouble},
                                                        lrnBeta::Ptr{Cdouble},
                                                        lrnK::Ptr{Cdouble})::miopenStatus_t)
end

function miopenLRNGetWorkSpaceSize(yDesc, workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenLRNGetWorkSpaceSize(yDesc::miopenTensorDescriptor_t,
                                                           workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenLRNForward(handle, lrnDesc, alpha, xDesc, x, beta, yDesc, y, do_backward,
                          workSpace)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenLRNForward(handle::miopenHandle_t,
                                                  lrnDesc::miopenLRNDescriptor_t,
                                                  alpha::Ptr{Cvoid},
                                                  xDesc::miopenTensorDescriptor_t,
                                                  x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                  yDesc::miopenTensorDescriptor_t,
                                                  y::Ptr{Cvoid}, do_backward::Bool,
                                                  workSpace::Ptr{Cvoid})::miopenStatus_t)
end

function miopenLRNBackward(handle, lrnDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta,
                           dxDesc, dx, workSpace)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenLRNBackward(handle::miopenHandle_t,
                                                   lrnDesc::miopenLRNDescriptor_t,
                                                   alpha::Ptr{Cvoid},
                                                   yDesc::miopenTensorDescriptor_t,
                                                   y::Ptr{Cvoid},
                                                   dyDesc::miopenTensorDescriptor_t,
                                                   dy::Ptr{Cvoid},
                                                   xDesc::miopenTensorDescriptor_t,
                                                   x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                   dxDesc::miopenTensorDescriptor_t,
                                                   dx::Ptr{Cvoid},
                                                   workSpace::Ptr{Cvoid})::miopenStatus_t)
end

function miopenDestroyLRNDescriptor(lrnDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyLRNDescriptor(lrnDesc::miopenLRNDescriptor_t)::miopenStatus_t)
end

function miopenDeriveBNTensorDescriptor(derivedBnDesc, xDesc, bn_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDeriveBNTensorDescriptor(derivedBnDesc::miopenTensorDescriptor_t,
                                                                xDesc::miopenTensorDescriptor_t,
                                                                bn_mode::miopenBatchNormMode_t)::miopenStatus_t)
end

function miopenBatchNormalizationForwardTraining(handle, bn_mode, alpha, beta, xDesc, x,
                                                 yDesc, y, bnScaleBiasMeanVarDesc, bnScale,
                                                 bnBias, expAvgFactor, resultRunningMean,
                                                 resultRunningVariance, epsilon,
                                                 resultSaveMean, resultSaveInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardTraining(handle::miopenHandle_t,
                                                                         bn_mode::miopenBatchNormMode_t,
                                                                         alpha::Ptr{Cvoid},
                                                                         beta::Ptr{Cvoid},
                                                                         xDesc::miopenTensorDescriptor_t,
                                                                         x::Ptr{Cvoid},
                                                                         yDesc::miopenTensorDescriptor_t,
                                                                         y::Ptr{Cvoid},
                                                                         bnScaleBiasMeanVarDesc::miopenTensorDescriptor_t,
                                                                         bnScale::Ptr{Cvoid},
                                                                         bnBias::Ptr{Cvoid},
                                                                         expAvgFactor::Cdouble,
                                                                         resultRunningMean::Ptr{Cvoid},
                                                                         resultRunningVariance::Ptr{Cvoid},
                                                                         epsilon::Cdouble,
                                                                         resultSaveMean::Ptr{Cvoid},
                                                                         resultSaveInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormalizationForwardTraining_V2(handle, bn_mode, alpha, beta, xDesc, x,
                                                    yDesc, y, scaleDesc, biasVarDesc,
                                                    savedMeanDesc, savedVarDesc, bnScale,
                                                    bnBias, expAvgFactor, resultRunningMean,
                                                    resultRunningVariance, epsilon,
                                                    resultSaveMean, resultSaveInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardTraining_V2(handle::miopenHandle_t,
                                                                            bn_mode::miopenBatchNormMode_t,
                                                                            alpha::Ptr{Cvoid},
                                                                            beta::Ptr{Cvoid},
                                                                            xDesc::miopenTensorDescriptor_t,
                                                                            x::Ptr{Cvoid},
                                                                            yDesc::miopenTensorDescriptor_t,
                                                                            y::Ptr{Cvoid},
                                                                            scaleDesc::miopenTensorDescriptor_t,
                                                                            biasVarDesc::miopenTensorDescriptor_t,
                                                                            savedMeanDesc::miopenTensorDescriptor_t,
                                                                            savedVarDesc::miopenTensorDescriptor_t,
                                                                            bnScale::Ptr{Cvoid},
                                                                            bnBias::Ptr{Cvoid},
                                                                            expAvgFactor::Cdouble,
                                                                            resultRunningMean::Ptr{Cvoid},
                                                                            resultRunningVariance::Ptr{Cvoid},
                                                                            epsilon::Cdouble,
                                                                            resultSaveMean::Ptr{Cvoid},
                                                                            resultSaveInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormalizationForwardTraining_V3(handle, bn_mode, alpha, beta, xDesc, x,
                                                    yDesc, y, scaleDesc, biasVarDesc,
                                                    savedMeanDesc, savedVarDesc, bnScale,
                                                    bnBias, expAvgFactor,
                                                    prevResultRunningMean,
                                                    prevResultRunningVariance,
                                                    nextResultRunningMean,
                                                    nextResultRunningVariance, epsilon,
                                                    resultSaveMean, resultSaveInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardTraining_V3(handle::miopenHandle_t,
                                                                            bn_mode::miopenBatchNormMode_t,
                                                                            alpha::Ptr{Cvoid},
                                                                            beta::Ptr{Cvoid},
                                                                            xDesc::miopenTensorDescriptor_t,
                                                                            x::Ptr{Cvoid},
                                                                            yDesc::miopenTensorDescriptor_t,
                                                                            y::Ptr{Cvoid},
                                                                            scaleDesc::miopenTensorDescriptor_t,
                                                                            biasVarDesc::miopenTensorDescriptor_t,
                                                                            savedMeanDesc::miopenTensorDescriptor_t,
                                                                            savedVarDesc::miopenTensorDescriptor_t,
                                                                            bnScale::Ptr{Cvoid},
                                                                            bnBias::Ptr{Cvoid},
                                                                            expAvgFactor::Cdouble,
                                                                            prevResultRunningMean::Ptr{Cvoid},
                                                                            prevResultRunningVariance::Ptr{Cvoid},
                                                                            nextResultRunningMean::Ptr{Cvoid},
                                                                            nextResultRunningVariance::Ptr{Cvoid},
                                                                            epsilon::Cdouble,
                                                                            resultSaveMean::Ptr{Cvoid},
                                                                            resultSaveInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormForwardTrainingActivation(handle, bn_mode, alpha, beta, xDesc, x,
                                                  yDesc, y, scaleDesc, biasVarDesc,
                                                  savedMeanDesc, savedVarDesc, bnScale,
                                                  bnBias, expAvgFactor, resultRunningMean,
                                                  resultRunningVariance, epsilon,
                                                  resultSaveMean, resultSaveInvVariance,
                                                  activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormForwardTrainingActivation(handle::miopenHandle_t,
                                                                          bn_mode::miopenBatchNormMode_t,
                                                                          alpha::Ptr{Cvoid},
                                                                          beta::Ptr{Cvoid},
                                                                          xDesc::miopenTensorDescriptor_t,
                                                                          x::Ptr{Cvoid},
                                                                          yDesc::miopenTensorDescriptor_t,
                                                                          y::Ptr{Cvoid},
                                                                          scaleDesc::miopenTensorDescriptor_t,
                                                                          biasVarDesc::miopenTensorDescriptor_t,
                                                                          savedMeanDesc::miopenTensorDescriptor_t,
                                                                          savedVarDesc::miopenTensorDescriptor_t,
                                                                          bnScale::Ptr{Cvoid},
                                                                          bnBias::Ptr{Cvoid},
                                                                          expAvgFactor::Cdouble,
                                                                          resultRunningMean::Ptr{Cvoid},
                                                                          resultRunningVariance::Ptr{Cvoid},
                                                                          epsilon::Cdouble,
                                                                          resultSaveMean::Ptr{Cvoid},
                                                                          resultSaveInvVariance::Ptr{Cvoid},
                                                                          activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenBatchNormForwardTrainingActivation_V2(handle, bn_mode, alpha, beta, xDesc, x,
                                                     yDesc, y, scaleDesc, biasVarDesc,
                                                     savedMeanDesc, savedVarDesc, bnScale,
                                                     bnBias, expAvgFactor,
                                                     prevResultRunningMean,
                                                     prevResultRunningVariance,
                                                     nextResultRunningMean,
                                                     nextResultRunningVariance, epsilon,
                                                     resultSaveMean, resultSaveInvVariance,
                                                     activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormForwardTrainingActivation_V2(handle::miopenHandle_t,
                                                                             bn_mode::miopenBatchNormMode_t,
                                                                             alpha::Ptr{Cvoid},
                                                                             beta::Ptr{Cvoid},
                                                                             xDesc::miopenTensorDescriptor_t,
                                                                             x::Ptr{Cvoid},
                                                                             yDesc::miopenTensorDescriptor_t,
                                                                             y::Ptr{Cvoid},
                                                                             scaleDesc::miopenTensorDescriptor_t,
                                                                             biasVarDesc::miopenTensorDescriptor_t,
                                                                             savedMeanDesc::miopenTensorDescriptor_t,
                                                                             savedVarDesc::miopenTensorDescriptor_t,
                                                                             bnScale::Ptr{Cvoid},
                                                                             bnBias::Ptr{Cvoid},
                                                                             expAvgFactor::Cdouble,
                                                                             prevResultRunningMean::Ptr{Cvoid},
                                                                             prevResultRunningVariance::Ptr{Cvoid},
                                                                             nextResultRunningMean::Ptr{Cvoid},
                                                                             nextResultRunningVariance::Ptr{Cvoid},
                                                                             epsilon::Cdouble,
                                                                             resultSaveMean::Ptr{Cvoid},
                                                                             resultSaveInvVariance::Ptr{Cvoid},
                                                                             activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenBatchNormalizationForwardInference(handle, bn_mode, alpha, beta, xDesc, x,
                                                  yDesc, y, bnScaleBiasMeanVarDesc, bnScale,
                                                  bnBias, estimatedMean, estimatedVariance,
                                                  epsilon)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardInference(handle::miopenHandle_t,
                                                                          bn_mode::miopenBatchNormMode_t,
                                                                          alpha::Ptr{Cvoid},
                                                                          beta::Ptr{Cvoid},
                                                                          xDesc::miopenTensorDescriptor_t,
                                                                          x::Ptr{Cvoid},
                                                                          yDesc::miopenTensorDescriptor_t,
                                                                          y::Ptr{Cvoid},
                                                                          bnScaleBiasMeanVarDesc::miopenTensorDescriptor_t,
                                                                          bnScale::Ptr{Cvoid},
                                                                          bnBias::Ptr{Cvoid},
                                                                          estimatedMean::Ptr{Cvoid},
                                                                          estimatedVariance::Ptr{Cvoid},
                                                                          epsilon::Cdouble)::miopenStatus_t)
end

function miopenBatchNormalizationForwardInference_V2(handle, bn_mode, alpha, beta, xDesc, x,
                                                     yDesc, y, scaleDesc, biasDesc,
                                                     estMeanDesc, estVarianceDesc, bnScale,
                                                     bnBias, estimatedMean,
                                                     estimatedVariance, epsilon)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardInference_V2(handle::miopenHandle_t,
                                                                             bn_mode::miopenBatchNormMode_t,
                                                                             alpha::Ptr{Cvoid},
                                                                             beta::Ptr{Cvoid},
                                                                             xDesc::miopenTensorDescriptor_t,
                                                                             x::Ptr{Cvoid},
                                                                             yDesc::miopenTensorDescriptor_t,
                                                                             y::Ptr{Cvoid},
                                                                             scaleDesc::miopenTensorDescriptor_t,
                                                                             biasDesc::miopenTensorDescriptor_t,
                                                                             estMeanDesc::miopenTensorDescriptor_t,
                                                                             estVarianceDesc::miopenTensorDescriptor_t,
                                                                             bnScale::Ptr{Cvoid},
                                                                             bnBias::Ptr{Cvoid},
                                                                             estimatedMean::Ptr{Cvoid},
                                                                             estimatedVariance::Ptr{Cvoid},
                                                                             epsilon::Cdouble)::miopenStatus_t)
end

function miopenBatchNormalizationForwardInferenceInvVariance(handle, bn_mode, alpha, beta,
                                                             xDesc, x, yDesc, y, scaleDesc,
                                                             biasDesc, estMeanDesc,
                                                             estInvVarianceDesc, bnScale,
                                                             bnBias, estimatedMean,
                                                             estimatedInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationForwardInferenceInvVariance(handle::miopenHandle_t,
                                                                                     bn_mode::miopenBatchNormMode_t,
                                                                                     alpha::Ptr{Cvoid},
                                                                                     beta::Ptr{Cvoid},
                                                                                     xDesc::miopenTensorDescriptor_t,
                                                                                     x::Ptr{Cvoid},
                                                                                     yDesc::miopenTensorDescriptor_t,
                                                                                     y::Ptr{Cvoid},
                                                                                     scaleDesc::miopenTensorDescriptor_t,
                                                                                     biasDesc::miopenTensorDescriptor_t,
                                                                                     estMeanDesc::miopenTensorDescriptor_t,
                                                                                     estInvVarianceDesc::miopenTensorDescriptor_t,
                                                                                     bnScale::Ptr{Cvoid},
                                                                                     bnBias::Ptr{Cvoid},
                                                                                     estimatedMean::Ptr{Cvoid},
                                                                                     estimatedInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormForwardInferenceActivationInvVariance(handle, bn_mode, alpha, beta,
                                                              xDesc, x, yDesc, y, scaleDesc,
                                                              biasDesc, estMeanDesc,
                                                              estInvVarianceDesc, bnScale,
                                                              bnBias, estimatedMean,
                                                              estimatedInvVariance,
                                                              activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormForwardInferenceActivationInvVariance(handle::miopenHandle_t,
                                                                                      bn_mode::miopenBatchNormMode_t,
                                                                                      alpha::Ptr{Cvoid},
                                                                                      beta::Ptr{Cvoid},
                                                                                      xDesc::miopenTensorDescriptor_t,
                                                                                      x::Ptr{Cvoid},
                                                                                      yDesc::miopenTensorDescriptor_t,
                                                                                      y::Ptr{Cvoid},
                                                                                      scaleDesc::miopenTensorDescriptor_t,
                                                                                      biasDesc::miopenTensorDescriptor_t,
                                                                                      estMeanDesc::miopenTensorDescriptor_t,
                                                                                      estInvVarianceDesc::miopenTensorDescriptor_t,
                                                                                      bnScale::Ptr{Cvoid},
                                                                                      bnBias::Ptr{Cvoid},
                                                                                      estimatedMean::Ptr{Cvoid},
                                                                                      estimatedInvVariance::Ptr{Cvoid},
                                                                                      activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenBatchNormForwardInferenceActivation(handle, bn_mode, alpha, beta, xDesc, x,
                                                   yDesc, y, scaleDesc, biasDesc,
                                                   estMeanDesc, estVarianceDesc, bnScale,
                                                   bnBias, estimatedMean, estimatedVariance,
                                                   epsilon, activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormForwardInferenceActivation(handle::miopenHandle_t,
                                                                           bn_mode::miopenBatchNormMode_t,
                                                                           alpha::Ptr{Cvoid},
                                                                           beta::Ptr{Cvoid},
                                                                           xDesc::miopenTensorDescriptor_t,
                                                                           x::Ptr{Cvoid},
                                                                           yDesc::miopenTensorDescriptor_t,
                                                                           y::Ptr{Cvoid},
                                                                           scaleDesc::miopenTensorDescriptor_t,
                                                                           biasDesc::miopenTensorDescriptor_t,
                                                                           estMeanDesc::miopenTensorDescriptor_t,
                                                                           estVarianceDesc::miopenTensorDescriptor_t,
                                                                           bnScale::Ptr{Cvoid},
                                                                           bnBias::Ptr{Cvoid},
                                                                           estimatedMean::Ptr{Cvoid},
                                                                           estimatedVariance::Ptr{Cvoid},
                                                                           epsilon::Cdouble,
                                                                           activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenBatchNormalizationBackward(handle, bn_mode, alphaDataDiff, betaDataDiff,
                                          alphaParamDiff, betaParamDiff, xDesc, x, dyDesc,
                                          dy, dxDesc, dx, bnScaleBiasDiffDesc, bnScale,
                                          resultBnScaleDiff, resultBnBiasDiff, epsilon,
                                          savedMean, savedInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationBackward(handle::miopenHandle_t,
                                                                  bn_mode::miopenBatchNormMode_t,
                                                                  alphaDataDiff::Ptr{Cvoid},
                                                                  betaDataDiff::Ptr{Cvoid},
                                                                  alphaParamDiff::Ptr{Cvoid},
                                                                  betaParamDiff::Ptr{Cvoid},
                                                                  xDesc::miopenTensorDescriptor_t,
                                                                  x::Ptr{Cvoid},
                                                                  dyDesc::miopenTensorDescriptor_t,
                                                                  dy::Ptr{Cvoid},
                                                                  dxDesc::miopenTensorDescriptor_t,
                                                                  dx::Ptr{Cvoid},
                                                                  bnScaleBiasDiffDesc::miopenTensorDescriptor_t,
                                                                  bnScale::Ptr{Cvoid},
                                                                  resultBnScaleDiff::Ptr{Cvoid},
                                                                  resultBnBiasDiff::Ptr{Cvoid},
                                                                  epsilon::Cdouble,
                                                                  savedMean::Ptr{Cvoid},
                                                                  savedInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormalizationBackward_V2(handle, bn_mode, alphaDataDiff, betaDataDiff,
                                             alphaParamDiff, betaParamDiff, xDesc, x,
                                             dyDesc, dy, dxDesc, dx, scaleDesc, biasDesc,
                                             savedMeanDesc, savedVarDesc, bnScale,
                                             resultBnScaleDiff, resultBnBiasDiff, epsilon,
                                             savedMean, savedInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormalizationBackward_V2(handle::miopenHandle_t,
                                                                     bn_mode::miopenBatchNormMode_t,
                                                                     alphaDataDiff::Ptr{Cvoid},
                                                                     betaDataDiff::Ptr{Cvoid},
                                                                     alphaParamDiff::Ptr{Cvoid},
                                                                     betaParamDiff::Ptr{Cvoid},
                                                                     xDesc::miopenTensorDescriptor_t,
                                                                     x::Ptr{Cvoid},
                                                                     dyDesc::miopenTensorDescriptor_t,
                                                                     dy::Ptr{Cvoid},
                                                                     dxDesc::miopenTensorDescriptor_t,
                                                                     dx::Ptr{Cvoid},
                                                                     scaleDesc::miopenTensorDescriptor_t,
                                                                     biasDesc::miopenTensorDescriptor_t,
                                                                     savedMeanDesc::miopenTensorDescriptor_t,
                                                                     savedVarDesc::miopenTensorDescriptor_t,
                                                                     bnScale::Ptr{Cvoid},
                                                                     resultBnScaleDiff::Ptr{Cvoid},
                                                                     resultBnBiasDiff::Ptr{Cvoid},
                                                                     epsilon::Cdouble,
                                                                     savedMean::Ptr{Cvoid},
                                                                     savedInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenBatchNormBackwardActivation(handle, bn_mode, alphaDataDiff, betaDataDiff,
                                           alphaParamDiff, betaParamDiff, xDesc, x, dyDesc,
                                           dy, dxDesc, dx, scaleDesc, biasDesc,
                                           savedMeanDesc, savedVarianceDesc, bnScale,
                                           bnBias, resultBnScaleDiff, resultBnBiasDiff,
                                           epsilon, savedMean, savedInvVariance, activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenBatchNormBackwardActivation(handle::miopenHandle_t,
                                                                   bn_mode::miopenBatchNormMode_t,
                                                                   alphaDataDiff::Ptr{Cvoid},
                                                                   betaDataDiff::Ptr{Cvoid},
                                                                   alphaParamDiff::Ptr{Cvoid},
                                                                   betaParamDiff::Ptr{Cvoid},
                                                                   xDesc::miopenTensorDescriptor_t,
                                                                   x::Ptr{Cvoid},
                                                                   dyDesc::miopenTensorDescriptor_t,
                                                                   dy::Ptr{Cvoid},
                                                                   dxDesc::miopenTensorDescriptor_t,
                                                                   dx::Ptr{Cvoid},
                                                                   scaleDesc::miopenTensorDescriptor_t,
                                                                   biasDesc::miopenTensorDescriptor_t,
                                                                   savedMeanDesc::miopenTensorDescriptor_t,
                                                                   savedVarianceDesc::miopenTensorDescriptor_t,
                                                                   bnScale::Ptr{Cvoid},
                                                                   bnBias::Ptr{Cvoid},
                                                                   resultBnScaleDiff::Ptr{Cvoid},
                                                                   resultBnBiasDiff::Ptr{Cvoid},
                                                                   epsilon::Cdouble,
                                                                   savedMean::Ptr{Cvoid},
                                                                   savedInvVariance::Ptr{Cvoid},
                                                                   activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenCreateActivationDescriptor(activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateActivationDescriptor(activDesc::Ptr{miopenActivationDescriptor_t})::miopenStatus_t)
end

function miopenSetActivationDescriptor(activDesc, mode, activAlpha, activBeta, activGamma)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetActivationDescriptor(activDesc::miopenActivationDescriptor_t,
                                                               mode::miopenActivationMode_t,
                                                               activAlpha::Cdouble,
                                                               activBeta::Cdouble,
                                                               activGamma::Cdouble)::miopenStatus_t)
end

function miopenGetActivationDescriptor(activDesc, mode, activAlpha, activBeta, activGamma)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetActivationDescriptor(activDesc::miopenActivationDescriptor_t,
                                                               mode::Ptr{miopenActivationMode_t},
                                                               activAlpha::Ptr{Cdouble},
                                                               activBeta::Ptr{Cdouble},
                                                               activGamma::Ptr{Cdouble})::miopenStatus_t)
end

function miopenActivationForward(handle, activDesc, alpha, xDesc, x, beta, yDesc, y)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenActivationForward(handle::miopenHandle_t,
                                                         activDesc::miopenActivationDescriptor_t,
                                                         alpha::Ptr{Cvoid},
                                                         xDesc::miopenTensorDescriptor_t,
                                                         x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                         yDesc::miopenTensorDescriptor_t,
                                                         y::Ptr{Cvoid})::miopenStatus_t)
end

function miopenActivationBackward(handle, activDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x,
                                  beta, dxDesc, dx)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenActivationBackward(handle::miopenHandle_t,
                                                          activDesc::miopenActivationDescriptor_t,
                                                          alpha::Ptr{Cvoid},
                                                          yDesc::miopenTensorDescriptor_t,
                                                          y::Ptr{Cvoid},
                                                          dyDesc::miopenTensorDescriptor_t,
                                                          dy::Ptr{Cvoid},
                                                          xDesc::miopenTensorDescriptor_t,
                                                          x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                          dxDesc::miopenTensorDescriptor_t,
                                                          dx::Ptr{Cvoid})::miopenStatus_t)
end

function miopenDestroyActivationDescriptor(activDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyActivationDescriptor(activDesc::miopenActivationDescriptor_t)::miopenStatus_t)
end

function miopenSoftmaxForward(handle, alpha, xDesc, x, beta, yDesc, y)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSoftmaxForward(handle::miopenHandle_t,
                                                      alpha::Ptr{Cvoid},
                                                      xDesc::miopenTensorDescriptor_t,
                                                      x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                      yDesc::miopenTensorDescriptor_t,
                                                      y::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSoftmaxBackward(handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSoftmaxBackward(handle::miopenHandle_t,
                                                       alpha::Ptr{Cvoid},
                                                       yDesc::miopenTensorDescriptor_t,
                                                       y::Ptr{Cvoid},
                                                       dyDesc::miopenTensorDescriptor_t,
                                                       dy::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                       dxDesc::miopenTensorDescriptor_t,
                                                       dx::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSoftmaxForward_V2(handle, alpha, xDesc, x, beta, yDesc, y, algorithm, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSoftmaxForward_V2(handle::miopenHandle_t,
                                                         alpha::Ptr{Cvoid},
                                                         xDesc::miopenTensorDescriptor_t,
                                                         x::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                         yDesc::miopenTensorDescriptor_t,
                                                         y::Ptr{Cvoid},
                                                         algorithm::miopenSoftmaxAlgorithm_t,
                                                         mode::miopenSoftmaxMode_t)::miopenStatus_t)
end

function miopenSoftmaxBackward_V2(handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx,
                                  algorithm, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSoftmaxBackward_V2(handle::miopenHandle_t,
                                                          alpha::Ptr{Cvoid},
                                                          yDesc::miopenTensorDescriptor_t,
                                                          y::Ptr{Cvoid},
                                                          dyDesc::miopenTensorDescriptor_t,
                                                          dy::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                          dxDesc::miopenTensorDescriptor_t,
                                                          dx::Ptr{Cvoid},
                                                          algorithm::miopenSoftmaxAlgorithm_t,
                                                          mode::miopenSoftmaxMode_t)::miopenStatus_t)
end

struct miopenFusionPlanDescriptor
end

const miopenFusionPlanDescriptor_t = Ptr{miopenFusionPlanDescriptor}

struct miopenOperatorDescriptor
end

const miopenOperatorDescriptor_t = Ptr{miopenOperatorDescriptor}

struct miopenOperatorArgs
end

const miopenOperatorArgs_t = Ptr{miopenOperatorArgs}

@cenum miopenFusionDirection_t::UInt32 begin
    miopenVerticalFusion = 0
    miopenHorizontalFusion = 1
end

function miopenCreateFusionPlan(fusePlanDesc, fuseDirection, inputDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateFusionPlan(fusePlanDesc::Ptr{miopenFusionPlanDescriptor_t},
                                                        fuseDirection::miopenFusionDirection_t,
                                                        inputDesc::miopenTensorDescriptor_t)::miopenStatus_t)
end

function miopenDestroyFusionPlan(fusePlanDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyFusionPlan(fusePlanDesc::miopenFusionPlanDescriptor_t)::miopenStatus_t)
end

function miopenCompileFusionPlan(handle, fusePlanDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCompileFusionPlan(handle::miopenHandle_t,
                                                         fusePlanDesc::miopenFusionPlanDescriptor_t)::miopenStatus_t)
end

function miopenFusionPlanGetOp(fusePlanDesc, op_idx, op)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFusionPlanGetOp(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                       op_idx::Cint,
                                                       op::Ptr{miopenFusionOpDescriptor_t})::miopenStatus_t)
end

function miopenFusionPlanGetWorkSpaceSize(handle, fusePlanDesc, workSpaceSize, algo)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFusionPlanGetWorkSpaceSize(handle::miopenHandle_t,
                                                                  fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                  workSpaceSize::Ptr{Csize_t},
                                                                  algo::miopenConvFwdAlgorithm_t)::miopenStatus_t)
end

function miopenFusionPlanConvolutionGetAlgo(fusePlanDesc, requestAlgoCount,
                                            returnedAlgoCount, returnedAlgos)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFusionPlanConvolutionGetAlgo(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                    requestAlgoCount::Cint,
                                                                    returnedAlgoCount::Ptr{Cint},
                                                                    returnedAlgos::Ptr{miopenConvFwdAlgorithm_t})::miopenStatus_t)
end

function miopenFusionPlanConvolutionSetAlgo(fusePlanDesc, algo)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFusionPlanConvolutionSetAlgo(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                    algo::miopenConvFwdAlgorithm_t)::miopenStatus_t)
end

function miopenCreateOpConvForward(fusePlanDesc, convOp, convDesc, wDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpConvForward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                           convOp::Ptr{miopenFusionOpDescriptor_t},
                                                           convDesc::miopenConvolutionDescriptor_t,
                                                           wDesc::miopenTensorDescriptor_t)::miopenStatus_t)
end

function miopenCreateOpActivationForward(fusePlanDesc, activFwdOp, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpActivationForward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                 activFwdOp::Ptr{miopenFusionOpDescriptor_t},
                                                                 mode::miopenActivationMode_t)::miopenStatus_t)
end

function miopenCreateOpActivationBackward(fusePlanDesc, activBwdOp, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpActivationBackward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                  activBwdOp::Ptr{miopenFusionOpDescriptor_t},
                                                                  mode::miopenActivationMode_t)::miopenStatus_t)
end

function miopenCreateOpBiasForward(fusePlanDesc, biasOp, bDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpBiasForward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                           biasOp::Ptr{miopenFusionOpDescriptor_t},
                                                           bDesc::miopenTensorDescriptor_t)::miopenStatus_t)
end

function miopenCreateOpBatchNormInference(fusePlanDesc, bnOp, bn_mode,
                                          bnScaleBiasMeanVarDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpBatchNormInference(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                  bnOp::Ptr{miopenFusionOpDescriptor_t},
                                                                  bn_mode::miopenBatchNormMode_t,
                                                                  bnScaleBiasMeanVarDesc::miopenTensorDescriptor_t)::miopenStatus_t)
end

function miopenCreateOpBatchNormForward(fusePlanDesc, bnFwdOp, bn_mode, runningMeanVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpBatchNormForward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                bnFwdOp::Ptr{miopenFusionOpDescriptor_t},
                                                                bn_mode::miopenBatchNormMode_t,
                                                                runningMeanVariance::Bool)::miopenStatus_t)
end

function miopenCreateOpBatchNormBackward(fusePlanDesc, bnBwdOp, bn_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOpBatchNormBackward(fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                                 bnBwdOp::Ptr{miopenFusionOpDescriptor_t},
                                                                 bn_mode::miopenBatchNormMode_t)::miopenStatus_t)
end

function miopenCreateOperatorArgs(args)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateOperatorArgs(args::Ptr{miopenOperatorArgs_t})::miopenStatus_t)
end

function miopenDestroyOperatorArgs(args)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyOperatorArgs(args::miopenOperatorArgs_t)::miopenStatus_t)
end

function miopenSetOpArgsConvForward(args, convOp, alpha, beta, w)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsConvForward(args::miopenOperatorArgs_t,
                                                            convOp::miopenFusionOpDescriptor_t,
                                                            alpha::Ptr{Cvoid},
                                                            beta::Ptr{Cvoid},
                                                            w::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetOpArgsActivForward(args, activFwdOp, alpha, beta, activAlpha, activBeta,
                                     activGamma)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsActivForward(args::miopenOperatorArgs_t,
                                                             activFwdOp::miopenFusionOpDescriptor_t,
                                                             alpha::Ptr{Cvoid},
                                                             beta::Ptr{Cvoid},
                                                             activAlpha::Cdouble,
                                                             activBeta::Cdouble,
                                                             activGamma::Cdouble)::miopenStatus_t)
end

function miopenSetOpArgsActivBackward(args, activBwdOp, alpha, beta, y, reserved,
                                      activAlpha, activBeta, activGamma)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsActivBackward(args::miopenOperatorArgs_t,
                                                              activBwdOp::miopenFusionOpDescriptor_t,
                                                              alpha::Ptr{Cvoid},
                                                              beta::Ptr{Cvoid},
                                                              y::Ptr{Cvoid},
                                                              reserved::Ptr{Cvoid},
                                                              activAlpha::Cdouble,
                                                              activBeta::Cdouble,
                                                              activGamma::Cdouble)::miopenStatus_t)
end

function miopenSetOpArgsBatchNormInference(args, bnOp, alpha, beta, bnScale, bnBias,
                                           estimatedMean, estimatedVariance, epsilon)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsBatchNormInference(args::miopenOperatorArgs_t,
                                                                   bnOp::miopenFusionOpDescriptor_t,
                                                                   alpha::Ptr{Cvoid},
                                                                   beta::Ptr{Cvoid},
                                                                   bnScale::Ptr{Cvoid},
                                                                   bnBias::Ptr{Cvoid},
                                                                   estimatedMean::Ptr{Cvoid},
                                                                   estimatedVariance::Ptr{Cvoid},
                                                                   epsilon::Cdouble)::miopenStatus_t)
end

function miopenSetOpArgsBatchNormForward(args, bnOp, alpha, beta, bnScale, bnBias,
                                         savedMean, savedInvVariance, runningMean,
                                         runningVariance, expAvgFactor, epsilon)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsBatchNormForward(args::miopenOperatorArgs_t,
                                                                 bnOp::miopenFusionOpDescriptor_t,
                                                                 alpha::Ptr{Cvoid},
                                                                 beta::Ptr{Cvoid},
                                                                 bnScale::Ptr{Cvoid},
                                                                 bnBias::Ptr{Cvoid},
                                                                 savedMean::Ptr{Cvoid},
                                                                 savedInvVariance::Ptr{Cvoid},
                                                                 runningMean::Ptr{Cvoid},
                                                                 runningVariance::Ptr{Cvoid},
                                                                 expAvgFactor::Cdouble,
                                                                 epsilon::Cdouble)::miopenStatus_t)
end

function miopenSetOpArgsBatchNormBackward(args, bnOp, alpha, beta, x, bnScale, bnBias,
                                          resultBnScaleDiff, resultBnBiasDiff, savedMean,
                                          savedInvVariance)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsBatchNormBackward(args::miopenOperatorArgs_t,
                                                                  bnOp::miopenFusionOpDescriptor_t,
                                                                  alpha::Ptr{Cvoid},
                                                                  beta::Ptr{Cvoid},
                                                                  x::Ptr{Cvoid},
                                                                  bnScale::Ptr{Cvoid},
                                                                  bnBias::Ptr{Cvoid},
                                                                  resultBnScaleDiff::Ptr{Cvoid},
                                                                  resultBnBiasDiff::Ptr{Cvoid},
                                                                  savedMean::Ptr{Cvoid},
                                                                  savedInvVariance::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetOpArgsBiasForward(args, biasOp, alpha, beta, bias)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetOpArgsBiasForward(args::miopenOperatorArgs_t,
                                                            biasOp::miopenFusionOpDescriptor_t,
                                                            alpha::Ptr{Cvoid},
                                                            beta::Ptr{Cvoid},
                                                            bias::Ptr{Cvoid})::miopenStatus_t)
end

function miopenExecuteFusionPlan(handle, fusePlanDesc, inputDesc, input, outputDesc, output,
                                 args)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenExecuteFusionPlan(handle::miopenHandle_t,
                                                         fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                         inputDesc::miopenTensorDescriptor_t,
                                                         input::Ptr{Cvoid},
                                                         outputDesc::miopenTensorDescriptor_t,
                                                         output::Ptr{Cvoid},
                                                         args::miopenOperatorArgs_t)::miopenStatus_t)
end

function miopenExecuteFusionPlan_v2(handle, fusePlanDesc, inputDesc, input, outputDesc,
                                    output, args, workspace, workspaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenExecuteFusionPlan_v2(handle::miopenHandle_t,
                                                            fusePlanDesc::miopenFusionPlanDescriptor_t,
                                                            inputDesc::miopenTensorDescriptor_t,
                                                            input::Ptr{Cvoid},
                                                            outputDesc::miopenTensorDescriptor_t,
                                                            output::Ptr{Cvoid},
                                                            args::miopenOperatorArgs_t,
                                                            workspace::Ptr{Cvoid},
                                                            workspaceSize::Csize_t)::miopenStatus_t)
end

function miopenConvolutionBiasActivationForward(handle, alpha1, xDesc, x, wDesc, w,
                                                convDesc, algo, workspace,
                                                workspaceSizeInBytes, alpha2, zDesc, z,
                                                biasDesc, bias, activationDesc, yDesc, y)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenConvolutionBiasActivationForward(handle::miopenHandle_t,
                                                                        alpha1::Ptr{Cvoid},
                                                                        xDesc::miopenTensorDescriptor_t,
                                                                        x::Ptr{Cvoid},
                                                                        wDesc::miopenTensorDescriptor_t,
                                                                        w::Ptr{Cvoid},
                                                                        convDesc::miopenConvolutionDescriptor_t,
                                                                        algo::miopenConvFwdAlgorithm_t,
                                                                        workspace::Ptr{Cvoid},
                                                                        workspaceSizeInBytes::Csize_t,
                                                                        alpha2::Ptr{Cvoid},
                                                                        zDesc::miopenTensorDescriptor_t,
                                                                        z::Ptr{Cvoid},
                                                                        biasDesc::miopenTensorDescriptor_t,
                                                                        bias::Ptr{Cvoid},
                                                                        activationDesc::miopenActivationDescriptor_t,
                                                                        yDesc::miopenTensorDescriptor_t,
                                                                        y::Ptr{Cvoid})::miopenStatus_t)
end

@cenum miopenRNNMode_t::UInt32 begin
    miopenRNNRELU = 0
    miopenRNNTANH = 1
    miopenLSTM = 2
    miopenGRU = 3
end

@cenum miopenRNNInputMode_t::UInt32 begin
    miopenRNNlinear = 0
    miopenRNNskip = 1
end

@cenum miopenRNNAlgo_t::UInt32 begin
    miopenRNNdefault = 0
    miopenRNNfundamental = 1
    miopenRNNroundedDynamic = 2
end

@cenum miopenRNNDirectionMode_t::UInt32 begin
    miopenRNNunidirection = 0
    miopenRNNbidirection = 1
end

@cenum miopenRNNBiasMode_t::UInt32 begin
    miopenRNNNoBias = 0
    miopenRNNwithBias = 1
end

@cenum miopenRNNGEMMalgoMode_t::UInt32 begin
    miopenRNNAlgoGEMM = 0
end

@cenum miopenRNNPaddingMode_t::UInt32 begin
    miopenRNNIONotPadded = 0
    miopenRNNIOWithPadding = 1
end

@cenum miopenRNNFWDMode_t::UInt32 begin
    miopenRNNTraining = 0
    miopenRNNInference = 1
end

@cenum miopenRNNBaseLayout_t::UInt32 begin
    miopenRNNDataUnknownLayout = 0
    miopenRNNDataSeqMajorNotPadded = 1
    miopenRNNDataSeqMajorPadded = 2
    miopenRNNDataBatchMajorPadded = 3
end

function miopenCreateRNNDescriptor(rnnDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateRNNDescriptor(rnnDesc::Ptr{miopenRNNDescriptor_t})::miopenStatus_t)
end

function miopenGetRNNDescriptor(rnnDesc, rnnMode, algoMode, inputMode, dirMode, biasMode,
                                hiddenSize, layer)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNDescriptor(rnnDesc::miopenRNNDescriptor_t,
                                                        rnnMode::Ptr{miopenRNNMode_t},
                                                        algoMode::Ptr{miopenRNNAlgo_t},
                                                        inputMode::Ptr{miopenRNNInputMode_t},
                                                        dirMode::Ptr{miopenRNNDirectionMode_t},
                                                        biasMode::Ptr{miopenRNNBiasMode_t},
                                                        hiddenSize::Ptr{Cint},
                                                        layer::Ptr{Cint})::miopenStatus_t)
end

function miopenGetRNNDescriptor_V2(rnnDesc, hiddenSize, layer, dropoutDesc, inputMode,
                                   dirMode, rnnMode, biasMode, algoMode, dataType)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNDescriptor_V2(rnnDesc::miopenRNNDescriptor_t,
                                                           hiddenSize::Ptr{Cint},
                                                           layer::Ptr{Cint},
                                                           dropoutDesc::Ptr{miopenDropoutDescriptor_t},
                                                           inputMode::Ptr{miopenRNNInputMode_t},
                                                           dirMode::Ptr{miopenRNNDirectionMode_t},
                                                           rnnMode::Ptr{miopenRNNMode_t},
                                                           biasMode::Ptr{miopenRNNBiasMode_t},
                                                           algoMode::Ptr{miopenRNNAlgo_t},
                                                           dataType::Ptr{miopenDataType_t})::miopenStatus_t)
end

function miopenDestroyRNNDescriptor(rnnDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyRNNDescriptor(rnnDesc::miopenRNNDescriptor_t)::miopenStatus_t)
end

function miopenSetRNNDescriptor(rnnDesc, hsize, nlayers, inMode, direction, rnnMode,
                                biasMode, algo, dataType)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNDescriptor(rnnDesc::miopenRNNDescriptor_t,
                                                        hsize::Cint, nlayers::Cint,
                                                        inMode::miopenRNNInputMode_t,
                                                        direction::miopenRNNDirectionMode_t,
                                                        rnnMode::miopenRNNMode_t,
                                                        biasMode::miopenRNNBiasMode_t,
                                                        algo::miopenRNNAlgo_t,
                                                        dataType::miopenDataType_t)::miopenStatus_t)
end

function miopenSetRNNDescriptor_V2(rnnDesc, hsize, nlayers, dropoutDesc, inMode, direction,
                                   rnnMode, biasMode, algo, dataType)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNDescriptor_V2(rnnDesc::miopenRNNDescriptor_t,
                                                           hsize::Cint, nlayers::Cint,
                                                           dropoutDesc::miopenDropoutDescriptor_t,
                                                           inMode::miopenRNNInputMode_t,
                                                           direction::miopenRNNDirectionMode_t,
                                                           rnnMode::miopenRNNMode_t,
                                                           biasMode::miopenRNNBiasMode_t,
                                                           algo::miopenRNNAlgo_t,
                                                           dataType::miopenDataType_t)::miopenStatus_t)
end

function miopenSetRNNDataSeqTensorDescriptor(seqTensorDesc, dataType, layout,
                                             maxSequenceLen, batchSize, vectorSize,
                                             sequenceLenArray, paddingMarker)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNDataSeqTensorDescriptor(seqTensorDesc::miopenSeqTensorDescriptor_t,
                                                                     dataType::miopenDataType_t,
                                                                     layout::miopenRNNBaseLayout_t,
                                                                     maxSequenceLen::Cint,
                                                                     batchSize::Cint,
                                                                     vectorSize::Cint,
                                                                     sequenceLenArray::Ptr{Cint},
                                                                     paddingMarker::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetRNNDataSeqTensorDescriptor(seqTensorDesc, dataType, layout,
                                             maxSequenceLen, batchSize, vectorSize,
                                             sequenceLenArrayLimit, sequenceLenArray,
                                             paddingMarker)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNDataSeqTensorDescriptor(seqTensorDesc::miopenSeqTensorDescriptor_t,
                                                                     dataType::Ptr{miopenDataType_t},
                                                                     layout::Ptr{miopenRNNBaseLayout_t},
                                                                     maxSequenceLen::Ptr{Cint},
                                                                     batchSize::Ptr{Cint},
                                                                     vectorSize::Ptr{Cint},
                                                                     sequenceLenArrayLimit::Cint,
                                                                     sequenceLenArray::Ptr{Cint},
                                                                     paddingMarker::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetRNNWorkspaceSize(handle, rnnDesc, sequenceLen, xDesc, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNWorkspaceSize(handle::miopenHandle_t,
                                                           rnnDesc::miopenRNNDescriptor_t,
                                                           sequenceLen::Cint,
                                                           xDesc::Ptr{miopenTensorDescriptor_t},
                                                           numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNTrainingReserveSize(handle, rnnDesc, sequenceLen, xDesc, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNTrainingReserveSize(handle::miopenHandle_t,
                                                                 rnnDesc::miopenRNNDescriptor_t,
                                                                 sequenceLen::Cint,
                                                                 xDesc::Ptr{miopenTensorDescriptor_t},
                                                                 numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNTempSpaceSizes(handle, rnnDesc, xDesc, fwdMode, workSpaceSize,
                                    reserveSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNTempSpaceSizes(handle::miopenHandle_t,
                                                            rnnDesc::miopenRNNDescriptor_t,
                                                            xDesc::miopenSeqTensorDescriptor_t,
                                                            fwdMode::miopenRNNFWDMode_t,
                                                            workSpaceSize::Ptr{Csize_t},
                                                            reserveSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNParamsSize(handle, rnnDesc, xDesc, numBytes, dtype)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNParamsSize(handle::miopenHandle_t,
                                                        rnnDesc::miopenRNNDescriptor_t,
                                                        xDesc::miopenTensorDescriptor_t,
                                                        numBytes::Ptr{Csize_t},
                                                        dtype::miopenDataType_t)::miopenStatus_t)
end

function miopenGetRNNParamsDescriptor(handle, rnnDesc, xDesc, wDesc, dtype)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNParamsDescriptor(handle::miopenHandle_t,
                                                              rnnDesc::miopenRNNDescriptor_t,
                                                              xDesc::miopenTensorDescriptor_t,
                                                              wDesc::miopenTensorDescriptor_t,
                                                              dtype::miopenDataType_t)::miopenStatus_t)
end

function miopenGetRNNInputTensorSize(handle, rnnDesc, seqLen, xDesc, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNInputTensorSize(handle::miopenHandle_t,
                                                             rnnDesc::miopenRNNDescriptor_t,
                                                             seqLen::Cint,
                                                             xDesc::Ptr{miopenTensorDescriptor_t},
                                                             numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNHiddenTensorSize(handle, rnnDesc, seqLen, xDesc, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNHiddenTensorSize(handle::miopenHandle_t,
                                                              rnnDesc::miopenRNNDescriptor_t,
                                                              seqLen::Cint,
                                                              xDesc::Ptr{miopenTensorDescriptor_t},
                                                              numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNLayerParamSize(handle, rnnDesc, layer, xDesc, paramID, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerParamSize(handle::miopenHandle_t,
                                                            rnnDesc::miopenRNNDescriptor_t,
                                                            layer::Cint,
                                                            xDesc::miopenTensorDescriptor_t,
                                                            paramID::Cint,
                                                            numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNLayerBiasSize(handle, rnnDesc, layer, biasID, numBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerBiasSize(handle::miopenHandle_t,
                                                           rnnDesc::miopenRNNDescriptor_t,
                                                           layer::Cint, biasID::Cint,
                                                           numBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNLayerParam(handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc,
                                layerParam)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerParam(handle::miopenHandle_t,
                                                        rnnDesc::miopenRNNDescriptor_t,
                                                        layer::Cint,
                                                        xDesc::miopenTensorDescriptor_t,
                                                        wDesc::miopenTensorDescriptor_t,
                                                        w::Ptr{Cvoid}, paramID::Cint,
                                                        paramDesc::miopenTensorDescriptor_t,
                                                        layerParam::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetRNNLayerBias(handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc,
                               layerBias)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerBias(handle::miopenHandle_t,
                                                       rnnDesc::miopenRNNDescriptor_t,
                                                       layer::Cint,
                                                       xDesc::miopenTensorDescriptor_t,
                                                       wDesc::miopenTensorDescriptor_t,
                                                       w::Ptr{Cvoid}, biasID::Cint,
                                                       biasDesc::miopenTensorDescriptor_t,
                                                       layerBias::Ptr{Cvoid})::miopenStatus_t)
end

function miopenGetRNNLayerParamOffset(rnnDesc, layer, xDesc, paramID, paramDesc,
                                      layerParamOffset)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerParamOffset(rnnDesc::miopenRNNDescriptor_t,
                                                              layer::Cint,
                                                              xDesc::miopenTensorDescriptor_t,
                                                              paramID::Cint,
                                                              paramDesc::miopenTensorDescriptor_t,
                                                              layerParamOffset::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetRNNLayerBiasOffset(rnnDesc, layer, xDesc, biasID, biasDesc,
                                     layerBiasOffset)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNLayerBiasOffset(rnnDesc::miopenRNNDescriptor_t,
                                                             layer::Cint,
                                                             xDesc::miopenTensorDescriptor_t,
                                                             biasID::Cint,
                                                             biasDesc::miopenTensorDescriptor_t,
                                                             layerBiasOffset::Ptr{Csize_t})::miopenStatus_t)
end

function miopenSetRNNLayerParam(handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc,
                                layerParam)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNLayerParam(handle::miopenHandle_t,
                                                        rnnDesc::miopenRNNDescriptor_t,
                                                        layer::Cint,
                                                        xDesc::miopenTensorDescriptor_t,
                                                        wDesc::miopenTensorDescriptor_t,
                                                        w::Ptr{Cvoid}, paramID::Cint,
                                                        paramDesc::miopenTensorDescriptor_t,
                                                        layerParam::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetRNNLayerBias(handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc,
                               layerBias)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNLayerBias(handle::miopenHandle_t,
                                                       rnnDesc::miopenRNNDescriptor_t,
                                                       layer::Cint,
                                                       xDesc::miopenTensorDescriptor_t,
                                                       wDesc::miopenTensorDescriptor_t,
                                                       w::Ptr{Cvoid}, biasID::Cint,
                                                       biasDesc::miopenTensorDescriptor_t,
                                                       layerBias::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetRNNPaddingMode(rnnDesc, paddingMode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetRNNPaddingMode(rnnDesc::miopenRNNDescriptor_t,
                                                         paddingMode::miopenRNNPaddingMode_t)::miopenStatus_t)
end

function miopenGetRNNPaddingMode(rnnDesc, paddingMode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetRNNPaddingMode(rnnDesc::miopenRNNDescriptor_t,
                                                         paddingMode::Ptr{miopenRNNPaddingMode_t})::miopenStatus_t)
end

function miopenRNNForward(handle, rnnDesc, fwdMode, xDesc, x, hDesc, hx, hy, cDesc, cx, cy,
                          yDesc, y, w, weightSpaceSize, workSpace, workSpaceNumBytes,
                          reserveSpace, reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNForward(handle::miopenHandle_t,
                                                  rnnDesc::miopenRNNDescriptor_t,
                                                  fwdMode::miopenRNNFWDMode_t,
                                                  xDesc::miopenSeqTensorDescriptor_t,
                                                  x::Ptr{Cvoid},
                                                  hDesc::miopenTensorDescriptor_t,
                                                  hx::Ptr{Cvoid}, hy::Ptr{Cvoid},
                                                  cDesc::miopenTensorDescriptor_t,
                                                  cx::Ptr{Cvoid}, cy::Ptr{Cvoid},
                                                  yDesc::miopenSeqTensorDescriptor_t,
                                                  y::Ptr{Cvoid}, w::Ptr{Cvoid},
                                                  weightSpaceSize::Csize_t,
                                                  workSpace::Ptr{Cvoid},
                                                  workSpaceNumBytes::Csize_t,
                                                  reserveSpace::Ptr{Cvoid},
                                                  reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNBackwardSeqData(handle, rnnDesc, yDesc, y, dy, hDesc, hx, dhy, dhx, cDesc,
                                  cx, dcy, dcx, xDesc, dx, w, weightSpaceSize, workSpace,
                                  workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNBackwardSeqData(handle::miopenHandle_t,
                                                          rnnDesc::miopenRNNDescriptor_t,
                                                          yDesc::miopenSeqTensorDescriptor_t,
                                                          y::Ptr{Cvoid}, dy::Ptr{Cvoid},
                                                          hDesc::miopenTensorDescriptor_t,
                                                          hx::Ptr{Cvoid}, dhy::Ptr{Cvoid},
                                                          dhx::Ptr{Cvoid},
                                                          cDesc::miopenTensorDescriptor_t,
                                                          cx::Ptr{Cvoid}, dcy::Ptr{Cvoid},
                                                          dcx::Ptr{Cvoid},
                                                          xDesc::miopenSeqTensorDescriptor_t,
                                                          dx::Ptr{Cvoid}, w::Ptr{Cvoid},
                                                          weightSpaceSize::Csize_t,
                                                          workSpace::Ptr{Cvoid},
                                                          workSpaceNumBytes::Csize_t,
                                                          reserveSpace::Ptr{Cvoid},
                                                          reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNBackwardWeightsSeqTensor(handle, rnnDesc, xDesc, x, hDesc, hx, yDesc, y,
                                           dw, weightSpaceSize, workSpace,
                                           workSpaceNumBytes, reserveSpace,
                                           reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNBackwardWeightsSeqTensor(handle::miopenHandle_t,
                                                                   rnnDesc::miopenRNNDescriptor_t,
                                                                   xDesc::miopenSeqTensorDescriptor_t,
                                                                   x::Ptr{Cvoid},
                                                                   hDesc::miopenTensorDescriptor_t,
                                                                   hx::Ptr{Cvoid},
                                                                   yDesc::miopenSeqTensorDescriptor_t,
                                                                   y::Ptr{Cvoid},
                                                                   dw::Ptr{Cvoid},
                                                                   weightSpaceSize::Csize_t,
                                                                   workSpace::Ptr{Cvoid},
                                                                   workSpaceNumBytes::Csize_t,
                                                                   reserveSpace::Ptr{Cvoid},
                                                                   reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNForwardTraining(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx,
                                  cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy,
                                  workSpace, workSpaceNumBytes, reserveSpace,
                                  reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNForwardTraining(handle::miopenHandle_t,
                                                          rnnDesc::miopenRNNDescriptor_t,
                                                          sequenceLen::Cint,
                                                          xDesc::Ptr{miopenTensorDescriptor_t},
                                                          x::Ptr{Cvoid},
                                                          hxDesc::miopenTensorDescriptor_t,
                                                          hx::Ptr{Cvoid},
                                                          cxDesc::miopenTensorDescriptor_t,
                                                          cx::Ptr{Cvoid},
                                                          wDesc::miopenTensorDescriptor_t,
                                                          w::Ptr{Cvoid},
                                                          yDesc::Ptr{miopenTensorDescriptor_t},
                                                          y::Ptr{Cvoid},
                                                          hyDesc::miopenTensorDescriptor_t,
                                                          hy::Ptr{Cvoid},
                                                          cyDesc::miopenTensorDescriptor_t,
                                                          cy::Ptr{Cvoid},
                                                          workSpace::Ptr{Cvoid},
                                                          workSpaceNumBytes::Csize_t,
                                                          reserveSpace::Ptr{Cvoid},
                                                          reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNBackwardData(handle, rnnDesc, sequenceLen, yDesc, y, dyDesc, dy, dhyDesc,
                               dhy, dcyDesc, dcy, wDesc, w, hxDesc, hx, cxDesc, cx, dxDesc,
                               dx, dhxDesc, dhx, dcxDesc, dcx, workSpace, workSpaceNumBytes,
                               reserveSpace, reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNBackwardData(handle::miopenHandle_t,
                                                       rnnDesc::miopenRNNDescriptor_t,
                                                       sequenceLen::Cint,
                                                       yDesc::Ptr{miopenTensorDescriptor_t},
                                                       y::Ptr{Cvoid},
                                                       dyDesc::Ptr{miopenTensorDescriptor_t},
                                                       dy::Ptr{Cvoid},
                                                       dhyDesc::miopenTensorDescriptor_t,
                                                       dhy::Ptr{Cvoid},
                                                       dcyDesc::miopenTensorDescriptor_t,
                                                       dcy::Ptr{Cvoid},
                                                       wDesc::miopenTensorDescriptor_t,
                                                       w::Ptr{Cvoid},
                                                       hxDesc::miopenTensorDescriptor_t,
                                                       hx::Ptr{Cvoid},
                                                       cxDesc::miopenTensorDescriptor_t,
                                                       cx::Ptr{Cvoid},
                                                       dxDesc::Ptr{miopenTensorDescriptor_t},
                                                       dx::Ptr{Cvoid},
                                                       dhxDesc::miopenTensorDescriptor_t,
                                                       dhx::Ptr{Cvoid},
                                                       dcxDesc::miopenTensorDescriptor_t,
                                                       dcx::Ptr{Cvoid},
                                                       workSpace::Ptr{Cvoid},
                                                       workSpaceNumBytes::Csize_t,
                                                       reserveSpace::Ptr{Cvoid},
                                                       reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNBackwardWeights(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, yDesc,
                                  y, dwDesc, dw, workSpace, workSpaceNumBytes, reserveSpace,
                                  reserveSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNBackwardWeights(handle::miopenHandle_t,
                                                          rnnDesc::miopenRNNDescriptor_t,
                                                          sequenceLen::Cint,
                                                          xDesc::Ptr{miopenTensorDescriptor_t},
                                                          x::Ptr{Cvoid},
                                                          hxDesc::miopenTensorDescriptor_t,
                                                          hx::Ptr{Cvoid},
                                                          yDesc::Ptr{miopenTensorDescriptor_t},
                                                          y::Ptr{Cvoid},
                                                          dwDesc::miopenTensorDescriptor_t,
                                                          dw::Ptr{Cvoid},
                                                          workSpace::Ptr{Cvoid},
                                                          workSpaceNumBytes::Csize_t,
                                                          reserveSpace::Ptr{Cvoid},
                                                          reserveSpaceNumBytes::Csize_t)::miopenStatus_t)
end

function miopenRNNForwardInference(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx,
                                   cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy,
                                   workSpace, workSpaceNumBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRNNForwardInference(handle::miopenHandle_t,
                                                           rnnDesc::miopenRNNDescriptor_t,
                                                           sequenceLen::Cint,
                                                           xDesc::Ptr{miopenTensorDescriptor_t},
                                                           x::Ptr{Cvoid},
                                                           hxDesc::miopenTensorDescriptor_t,
                                                           hx::Ptr{Cvoid},
                                                           cxDesc::miopenTensorDescriptor_t,
                                                           cx::Ptr{Cvoid},
                                                           wDesc::miopenTensorDescriptor_t,
                                                           w::Ptr{Cvoid},
                                                           yDesc::Ptr{miopenTensorDescriptor_t},
                                                           y::Ptr{Cvoid},
                                                           hyDesc::miopenTensorDescriptor_t,
                                                           hy::Ptr{Cvoid},
                                                           cyDesc::miopenTensorDescriptor_t,
                                                           cy::Ptr{Cvoid},
                                                           workSpace::Ptr{Cvoid},
                                                           workSpaceNumBytes::Csize_t)::miopenStatus_t)
end

@cenum miopenCTCLossAlgo_t::UInt32 begin
    MIOPEN_CTC_LOSS_ALGO_DETERMINISTIC = 0
end

function miopenCreateCTCLossDescriptor(ctcLossDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateCTCLossDescriptor(ctcLossDesc::Ptr{miopenCTCLossDescriptor_t})::miopenStatus_t)
end

function miopenGetCTCLossDescriptor(ctcLossDesc, dataType, blank_label_id,
                                    apply_softmax_layer)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetCTCLossDescriptor(ctcLossDesc::miopenCTCLossDescriptor_t,
                                                            dataType::Ptr{miopenDataType_t},
                                                            blank_label_id::Ptr{Cint},
                                                            apply_softmax_layer::Ptr{Bool})::miopenStatus_t)
end

function miopenDestroyCTCLossDescriptor(ctcLossDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyCTCLossDescriptor(ctcLossDesc::miopenCTCLossDescriptor_t)::miopenStatus_t)
end

function miopenSetCTCLossDescriptor(ctcLossDesc, dataType, blank_label_id,
                                    apply_softmax_layer)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetCTCLossDescriptor(ctcLossDesc::miopenCTCLossDescriptor_t,
                                                            dataType::miopenDataType_t,
                                                            blank_label_id::Cint,
                                                            apply_softmax_layer::Bool)::miopenStatus_t)
end

function miopenGetCTCLossWorkspaceSize(handle, probsDesc, gradientsDesc, labels,
                                       labelLengths, inputLengths, algo, ctcLossDesc,
                                       workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetCTCLossWorkspaceSize(handle::miopenHandle_t,
                                                               probsDesc::miopenTensorDescriptor_t,
                                                               gradientsDesc::miopenTensorDescriptor_t,
                                                               labels::Ptr{Cint},
                                                               labelLengths::Ptr{Cint},
                                                               inputLengths::Ptr{Cint},
                                                               algo::miopenCTCLossAlgo_t,
                                                               ctcLossDesc::miopenCTCLossDescriptor_t,
                                                               workSpaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenCTCLoss(handle, probsDesc, probs, labels, labelLengths, inputLengths, losses,
                       gradientsDesc, gradients, algo, ctcLossDesc, workSpace,
                       workSpaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCTCLoss(handle::miopenHandle_t,
                                               probsDesc::miopenTensorDescriptor_t,
                                               probs::Ptr{Cvoid}, labels::Ptr{Cint},
                                               labelLengths::Ptr{Cint},
                                               inputLengths::Ptr{Cint}, losses::Ptr{Cvoid},
                                               gradientsDesc::miopenTensorDescriptor_t,
                                               gradients::Ptr{Cvoid},
                                               algo::miopenCTCLossAlgo_t,
                                               ctcLossDesc::miopenCTCLossDescriptor_t,
                                               workSpace::Ptr{Cvoid},
                                               workSpaceSize::Csize_t)::miopenStatus_t)
end

@cenum miopenRNGType_t::UInt32 begin
    MIOPEN_RNG_PSEUDO_XORWOW = 0
end

function miopenCreateDropoutDescriptor(dropoutDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateDropoutDescriptor(dropoutDesc::Ptr{miopenDropoutDescriptor_t})::miopenStatus_t)
end

function miopenDestroyDropoutDescriptor(dropoutDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyDropoutDescriptor(dropoutDesc::miopenDropoutDescriptor_t)::miopenStatus_t)
end

function miopenDropoutGetReserveSpaceSize(xDesc, reserveSpaceSizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDropoutGetReserveSpaceSize(xDesc::miopenTensorDescriptor_t,
                                                                  reserveSpaceSizeInBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenDropoutGetStatesSize(handle, stateSizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDropoutGetStatesSize(handle::miopenHandle_t,
                                                            stateSizeInBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetDropoutDescriptor(dropoutDesc, handle, dropout, states, seed, use_mask,
                                    state_evo, rng_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetDropoutDescriptor(dropoutDesc::miopenDropoutDescriptor_t,
                                                            handle::miopenHandle_t,
                                                            dropout::Ptr{Cfloat},
                                                            states::Ptr{Ptr{Cvoid}},
                                                            seed::Ptr{Culonglong},
                                                            use_mask::Ptr{Bool},
                                                            state_evo::Ptr{Bool},
                                                            rng_mode::Ptr{miopenRNGType_t})::miopenStatus_t)
end

function miopenRestoreDropoutDescriptor(dropoutDesc, handle, dropout, states,
                                        stateSizeInBytes, seed, use_mask, state_evo,
                                        rng_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRestoreDropoutDescriptor(dropoutDesc::miopenDropoutDescriptor_t,
                                                                handle::miopenHandle_t,
                                                                dropout::Cfloat,
                                                                states::Ptr{Cvoid},
                                                                stateSizeInBytes::Csize_t,
                                                                seed::Culonglong,
                                                                use_mask::Bool,
                                                                state_evo::Bool,
                                                                rng_mode::miopenRNGType_t)::miopenStatus_t)
end

function miopenSetDropoutDescriptor(dropoutDesc, handle, dropout, states, stateSizeInBytes,
                                    seed, use_mask, state_evo, rng_mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetDropoutDescriptor(dropoutDesc::miopenDropoutDescriptor_t,
                                                            handle::miopenHandle_t,
                                                            dropout::Cfloat,
                                                            states::Ptr{Cvoid},
                                                            stateSizeInBytes::Csize_t,
                                                            seed::Culonglong,
                                                            use_mask::Bool, state_evo::Bool,
                                                            rng_mode::miopenRNGType_t)::miopenStatus_t)
end

function miopenDropoutForward(handle, dropoutDesc, noise_shape, xDesc, x, yDesc, y,
                              reserveSpace, reserveSpaceSizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDropoutForward(handle::miopenHandle_t,
                                                      dropoutDesc::miopenDropoutDescriptor_t,
                                                      noise_shape::miopenTensorDescriptor_t,
                                                      xDesc::miopenTensorDescriptor_t,
                                                      x::Ptr{Cvoid},
                                                      yDesc::miopenTensorDescriptor_t,
                                                      y::Ptr{Cvoid},
                                                      reserveSpace::Ptr{Cvoid},
                                                      reserveSpaceSizeInBytes::Csize_t)::miopenStatus_t)
end

function miopenDropoutBackward(handle, dropoutDesc, noise_shape, dyDesc, dy, dxDesc, dx,
                               reserveSpace, reserveSpaceSizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDropoutBackward(handle::miopenHandle_t,
                                                       dropoutDesc::miopenDropoutDescriptor_t,
                                                       noise_shape::miopenTensorDescriptor_t,
                                                       dyDesc::miopenTensorDescriptor_t,
                                                       dy::Ptr{Cvoid},
                                                       dxDesc::miopenTensorDescriptor_t,
                                                       dx::Ptr{Cvoid},
                                                       reserveSpace::Ptr{Cvoid},
                                                       reserveSpaceSizeInBytes::Csize_t)::miopenStatus_t)
end

function miopenCreateReduceTensorDescriptor(reduceTensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateReduceTensorDescriptor(reduceTensorDesc::Ptr{miopenReduceTensorDescriptor_t})::miopenStatus_t)
end

function miopenDestroyReduceTensorDescriptor(reduceTensorDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyReduceTensorDescriptor(reduceTensorDesc::miopenReduceTensorDescriptor_t)::miopenStatus_t)
end

function miopenSetReduceTensorDescriptor(reduceTensorDesc, reduceTensorOp,
                                         reduceTensorCompType, reduceTensorNanOpt,
                                         reduceTensorIndices, reduceTensorIndicesType)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetReduceTensorDescriptor(reduceTensorDesc::miopenReduceTensorDescriptor_t,
                                                                 reduceTensorOp::miopenReduceTensorOp_t,
                                                                 reduceTensorCompType::miopenDataType_t,
                                                                 reduceTensorNanOpt::miopenNanPropagation_t,
                                                                 reduceTensorIndices::miopenReduceTensorIndices_t,
                                                                 reduceTensorIndicesType::miopenIndicesType_t)::miopenStatus_t)
end

function miopenGetReduceTensorDescriptor(reduceTensorDesc, reduceTensorOp,
                                         reduceTensorCompType, reduceTensorNanOpt,
                                         reduceTensorIndices, reduceTensorIndicesType)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetReduceTensorDescriptor(reduceTensorDesc::miopenReduceTensorDescriptor_t,
                                                                 reduceTensorOp::Ptr{miopenReduceTensorOp_t},
                                                                 reduceTensorCompType::Ptr{miopenDataType_t},
                                                                 reduceTensorNanOpt::Ptr{miopenNanPropagation_t},
                                                                 reduceTensorIndices::Ptr{miopenReduceTensorIndices_t},
                                                                 reduceTensorIndicesType::Ptr{miopenIndicesType_t})::miopenStatus_t)
end

function miopenGetReductionIndicesSize(handle, reduceTensorDesc, aDesc, cDesc, sizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetReductionIndicesSize(handle::miopenHandle_t,
                                                               reduceTensorDesc::miopenReduceTensorDescriptor_t,
                                                               aDesc::miopenTensorDescriptor_t,
                                                               cDesc::miopenTensorDescriptor_t,
                                                               sizeInBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetReductionWorkspaceSize(handle, reduceTensorDesc, aDesc, cDesc,
                                         sizeInBytes)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetReductionWorkspaceSize(handle::miopenHandle_t,
                                                                 reduceTensorDesc::miopenReduceTensorDescriptor_t,
                                                                 aDesc::miopenTensorDescriptor_t,
                                                                 cDesc::miopenTensorDescriptor_t,
                                                                 sizeInBytes::Ptr{Csize_t})::miopenStatus_t)
end

function miopenReduceTensor(handle, reduceTensorDesc, indices, indicesSizeInBytes,
                            workspace, workspaceSizeInBytes, alpha, aDesc, A, beta, cDesc,
                            C)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenReduceTensor(handle::miopenHandle_t,
                                                    reduceTensorDesc::miopenReduceTensorDescriptor_t,
                                                    indices::Ptr{Cvoid},
                                                    indicesSizeInBytes::Csize_t,
                                                    workspace::Ptr{Cvoid},
                                                    workspaceSizeInBytes::Csize_t,
                                                    alpha::Ptr{Cvoid},
                                                    aDesc::miopenTensorDescriptor_t,
                                                    A::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                                    cDesc::miopenTensorDescriptor_t,
                                                    C::Ptr{Cvoid})::miopenStatus_t)
end

struct miopenProblem
end

const miopenProblem_t = Ptr{miopenProblem}

@cenum miopenProblemDirection_t::UInt32 begin
    miopenProblemDirectionForward = 0
    miopenProblemDirectionBackward = 1
    miopenProblemDirectionBackwardWeights = 2
end

@cenum miopenTensorArgumentId_t::UInt32 begin
    miopenTensorArgumentIdInvalid = 0
    miopenTensorConvolutionX = 1
    miopenTensorConvolutionW = 2
    miopenTensorConvolutionY = 3
    miopenTensorMhaK = 4
    miopenTensorMhaQ = 5
    miopenTensorMhaV = 6
    miopenTensorMhaDescaleK = 7
    miopenTensorMhaDescaleQ = 8
    miopenTensorMhaDescaleV = 9
    miopenTensorMhaDescaleS = 10
    miopenTensorMhaScaleS = 11
    miopenTensorMhaScaleO = 12
    miopenTensorMhaDropoutProbability = 13
    miopenTensorMhaDropoutSeed = 14
    miopenTensorMhaDropoutOffset = 15
    miopenTensorMhaO = 16
    miopenTensorMhaAmaxO = 17
    miopenTensorMhaAmaxS = 18
    miopenTensorMhaM = 19
    miopenTensorMhaZInv = 20
    miopenTensorMhaDO = 21
    miopenTensorMhaDescaleO = 22
    miopenTensorMhaDescaleDO = 23
    miopenTensorMhaDescaleDS = 24
    miopenTensorMhaScaleDS = 25
    miopenTensorMhaScaleDQ = 26
    miopenTensorMhaScaleDK = 27
    miopenTensorMhaScaleDV = 28
    miopenTensorMhaDQ = 29
    miopenTensorMhaDK = 30
    miopenTensorMhaDV = 31
    miopenTensorMhaAmaxDQ = 32
    miopenTensorMhaAmaxDK = 33
    miopenTensorMhaAmaxDV = 34
    miopenTensorMhaAmaxDS = 35
    miopenTensorMhaBias = 36
    miopenTensorArgumentIsScalar = 0x0000000080000000
    miopenTensorMhaMask = 0x0000000080000001
end

@cenum miopenFindResultsOrder_t::UInt32 begin
    miopenFindResultsOrderByTime = 0
    miopenFindResultsOrderByWorkspaceSize = 1
end

function miopenCreateConvProblem(problem, operatorDesc, direction)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateConvProblem(problem::Ptr{miopenProblem_t},
                                                         operatorDesc::miopenConvolutionDescriptor_t,
                                                         direction::miopenProblemDirection_t)::miopenStatus_t)
end

@cenum miopenMhaMask_t::UInt32 begin
    miopenMhaMaskNone = 0
    miopenMhaMaskCausal = 1
end

function miopenCreateMhaProblem(problem, operatorDesc, direction)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateMhaProblem(problem::Ptr{miopenProblem_t},
                                                        operatorDesc::miopenMhaDescriptor_t,
                                                        direction::miopenProblemDirection_t)::miopenStatus_t)
end

function miopenCreateMhaDescriptor(mhaDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateMhaDescriptor(mhaDesc::Ptr{miopenMhaDescriptor_t})::miopenStatus_t)
end

function miopenSetMhaDescriptor(mhaDesc, scale)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetMhaDescriptor(mhaDesc::miopenMhaDescriptor_t,
                                                        scale::Cfloat)::miopenStatus_t)
end

function miopenGetMhaDescriptor(mhaDesc, scale)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetMhaDescriptor(mhaDesc::miopenMhaDescriptor_t,
                                                        scale::Ptr{Cfloat})::miopenStatus_t)
end

function miopenCreateSoftmaxDescriptor(softmaxDesc)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateSoftmaxDescriptor(softmaxDesc::Ptr{miopenSoftmaxDescriptor_t})::miopenStatus_t)
end

function miopenSetSoftmaxDescriptor(softmaxDesc, alpha, beta, algorithm, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetSoftmaxDescriptor(softmaxDesc::miopenSoftmaxDescriptor_t,
                                                            alpha::Cfloat, beta::Cfloat,
                                                            algorithm::miopenSoftmaxAlgorithm_t,
                                                            mode::miopenSoftmaxMode_t)::miopenStatus_t)
end

function miopenGetSoftmaxDescriptor(softmaxDesc, alpha, beta, algorithm, mode)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSoftmaxDescriptor(softmaxDesc::miopenSoftmaxDescriptor_t,
                                                            alpha::Ptr{Cfloat},
                                                            beta::Ptr{Cfloat},
                                                            algorithm::Ptr{miopenSoftmaxAlgorithm_t},
                                                            mode::Ptr{miopenSoftmaxMode_t})::miopenStatus_t)
end

function miopenDestroyProblem(problem)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyProblem(problem::miopenProblem_t)::miopenStatus_t)
end

function miopenSetProblemTensorDescriptor(problem, id, descriptor)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetProblemTensorDescriptor(problem::miopenProblem_t,
                                                                  id::miopenTensorArgumentId_t,
                                                                  descriptor::miopenTensorDescriptor_t)::miopenStatus_t)
end

struct miopenFindOptions
end

const miopenFindOptions_t = Ptr{miopenFindOptions}

function miopenCreateFindOptions(options)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenCreateFindOptions(options::Ptr{miopenFindOptions_t})::miopenStatus_t)
end

function miopenDestroyFindOptions(options)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroyFindOptions(options::miopenFindOptions_t)::miopenStatus_t)
end

function miopenSetFindOptionTuning(options, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionTuning(options::miopenFindOptions_t,
                                                           value::Cint)::miopenStatus_t)
end

function miopenSetFindOptionResultsOrder(options, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionResultsOrder(options::miopenFindOptions_t,
                                                                 value::miopenFindResultsOrder_t)::miopenStatus_t)
end

function miopenSetFindOptionWorkspaceLimit(options, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionWorkspaceLimit(options::miopenFindOptions_t,
                                                                   value::Csize_t)::miopenStatus_t)
end

function miopenSetFindOptionPreallocatedWorkspace(options, buffer, size)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionPreallocatedWorkspace(options::miopenFindOptions_t,
                                                                          buffer::Ptr{Cvoid},
                                                                          size::Csize_t)::miopenStatus_t)
end

function miopenSetFindOptionPreallocatedTensor(options, id, buffer)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionPreallocatedTensor(options::miopenFindOptions_t,
                                                                       id::miopenTensorArgumentId_t,
                                                                       buffer::Ptr{Cvoid})::miopenStatus_t)
end

function miopenSetFindOptionAttachBinaries(options, attach)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetFindOptionAttachBinaries(options::miopenFindOptions_t,
                                                                   attach::Cuint)::miopenStatus_t)
end

struct miopenSolution
end

const miopenSolution_t = Ptr{miopenSolution}

function miopenFindSolutions(handle, problem, options, solutions, numSolutions,
                             maxSolutions)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenFindSolutions(handle::miopenHandle_t,
                                                     problem::miopenProblem_t,
                                                     options::miopenFindOptions_t,
                                                     solutions::Ptr{miopenSolution_t},
                                                     numSolutions::Ptr{Csize_t},
                                                     maxSolutions::Csize_t)::miopenStatus_t)
end

struct miopenTensorArgument_t
    id::miopenTensorArgumentId_t
    descriptor::Ptr{miopenTensorDescriptor_t}
    buffer::Ptr{Cvoid}
end

function miopenRunSolution(handle, solution, nInputs, tensors, workspace, workspaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenRunSolution(handle::miopenHandle_t,
                                                   solution::miopenSolution_t,
                                                   nInputs::Csize_t,
                                                   tensors::Ptr{miopenTensorArgument_t},
                                                   workspace::Ptr{Cvoid},
                                                   workspaceSize::Csize_t)::miopenStatus_t)
end

function miopenDestroySolution(solution)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenDestroySolution(solution::miopenSolution_t)::miopenStatus_t)
end

function miopenLoadSolution(solution, data, size)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenLoadSolution(solution::Ptr{miopenSolution_t},
                                                    data::Ptr{Cchar},
                                                    size::Csize_t)::miopenStatus_t)
end

function miopenSaveSolution(solution, data)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSaveSolution(solution::miopenSolution_t,
                                                    data::Ptr{Cchar})::miopenStatus_t)
end

function miopenGetSolutionSize(solution, size)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSolutionSize(solution::miopenSolution_t,
                                                       size::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetSolutionWorkspaceSize(solution, workspaceSize)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSolutionWorkspaceSize(solution::miopenSolution_t,
                                                                workspaceSize::Ptr{Csize_t})::miopenStatus_t)
end

function miopenGetSolutionTime(solution, time)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSolutionTime(solution::miopenSolution_t,
                                                       time::Ptr{Cfloat})::miopenStatus_t)
end

function miopenGetSolutionSolverId(solution, solverId)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSolutionSolverId(solution::miopenSolution_t,
                                                           solverId::Ptr{UInt64})::miopenStatus_t)
end

function miopenGetSolverIdConvAlgorithm(solverId, result)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetSolverIdConvAlgorithm(solverId::UInt64,
                                                                result::Ptr{miopenConvAlgorithm_t})::miopenStatus_t)
end

@cenum miopenAlphaBetaCase_t::UInt32 begin
    DEFAULT = 0
    SCALE = 1
    BILINEAR = 2
    ERROR_STATE = 3
end

@cenum miopenTuningPolicy_t::UInt32 begin
    miopenTuningPolicyNone = 1
    miopenTuningPolicyDbUpdate = 2
    miopenTuningPolicySearch = 3
    miopenTuningPolicySearchDbUpdate = 4
    miopenTuningPolicyDbClean = 5
end

function miopenSetTuningPolicy(handle, newValue)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenSetTuningPolicy(handle::miopenHandle_t,
                                                       newValue::miopenTuningPolicy_t)::miopenStatus_t)
end

function miopenGetTuningPolicy(handle, value)
    AMDGPU.prepare_state()
    @check @ccall(libMIOpen_path.miopenGetTuningPolicy(handle::miopenHandle_t,
                                                       value::Ptr{miopenTuningPolicy_t})::miopenStatus_t)
end

const MIOPEN_BACKEND_OPENCL = 0

const MIOPEN_BACKEND_HIP = 1

const MIOPEN_MODE_NOGPU = 0

const MIOPEN_USE_ROCBLAS = 1

const MIOPEN_USE_HIPBLASLT = 1

const MIOPEN_USE_ROCTRACER = 1

const MIOPEN_BUILD_DEV = 0

const MIOPEN_GPU_SYNC = 0

const MIOPEN_ENABLE_SQLITE = 1

const MIOPEN_ENABLE_SQLITE_KERN_CACHE = 1

const MIOPEN_DEBUG_FIND_DB_CACHING = 1

const MIOPEN_USE_COMGR = 1

const MIOPEN_USE_HIPRTC = 1

const MIOPEN_USE_HIP_KERNELS = 1

const MIOPEN_DISABLE_USERDB = 0

const MIOPEN_EMBED_DB = 0

const BUILD_SHARED_LIBS = 1

const MIOPEN_DISABLE_SYSDB = 0

const MIOPEN_LOG_FUNC_TIME_ENABLE = 0

const MIOPEN_ENABLE_SQLITE_BACKOFF = 1

const MIOPEN_USE_MLIR = 0

const MIOPEN_USE_COMPOSABLEKERNEL = 1

const MIOPEN_BUILD_DRIVER = 1

const MIOPEN_ENABLE_AI_IMMED_MODE_FALLBACK = 1

const MIOPEN_ENABLE_AI_KERNEL_TUNING = 1

const MIOPEN_HIP_COMPILER_HAS_OPTION_OFFLOAD_UNIFORM_BLOCK = 1

const MIOPEN_ENABLE_FIN_INTERFACE = 0

const HIP_PACKAGE_VERSION_MAJOR = 7

const HIP_PACKAGE_VERSION_MINOR = 13

const HIP_PACKAGE_VERSION_PATCH = 99004

const MIOPEN_AMD_COMGR_VERSION_MAJOR = 3

const MIOPEN_AMD_COMGR_VERSION_MINOR = 0

const MIOPEN_AMD_COMGR_VERSION_PATCH = 0

const MIOPEN_USE_RNE_BFLOAT16 = 1

const MIOPEN_FP8_IEEE_EXPONENT_BIAS = 0

const MIOPEN_FP8_CLIPPING = 1

const MIOPEN_OFFLINE_COMPILER_PATHS_V2 = 0

const MIOPEN_AMDGCN_ASSEMBLER = "/home/runner/_work/rockrel/rockrel/output/build/compiler/amd-llvm/dist/lib/llvm/bin/clang"

const HIP_OC_COMPILER = "/home/runner/_work/rockrel/rockrel/output/build/compiler/amd-llvm/dist/lib/llvm/bin/amdclang"

const MIOPEN_HIP_COMPILER = "/home/runner/_work/rockrel/rockrel/output/build/core/clr/dist/lib/llvm/bin/clang++"

const MIOPEN_OFFLOADBUNDLER_BIN = "/home/runner/_work/rockrel/rockrel/output/build/compiler/amd-llvm/dist/lib/llvm/bin/clang-offload-bundler"

const MIOPEN_CACHE_DIR = "~/.cache/miopen/"

const MIOPEN_USE_SQLITE_PERFDB = 0

const MIOPEN_NDEBUG = 0

const MIOPEN_ALLOC_BUFFERS = 0

const HIP_PACKAGE_VERSION_FLAT = (HIP_PACKAGE_VERSION_MAJOR * Culonglong(1000) +
                                  HIP_PACKAGE_VERSION_MINOR) * 1000000 +
                                 HIP_PACKAGE_VERSION_PATCH

const MIOPEN_ROCBLAS_VERSION_MAJOR = 5

const MIOPEN_ROCBLAS_VERSION_MINOR = 4

const MIOPEN_ROCBLAS_VERSION_PATCH = 0

const MIOPEN_ROCBLAS_VERSION_FLAT = (MIOPEN_ROCBLAS_VERSION_MAJOR * 1000 +
                                     MIOPEN_ROCBLAS_VERSION_MINOR) * 1000 +
                                    MIOPEN_ROCBLAS_VERSION_PATCH

const MIOPEN_HIPBLASLT_VERSION_MAJOR = 1

const MIOPEN_HIPBLASLT_VERSION_MINOR = 3

const MIOPEN_HIPBLASLT_VERSION_PATCH = 0

const MIOPEN_HIPBLASLT_VERSION_FLAT = (MIOPEN_HIPBLASLT_VERSION_MAJOR * 1000 +
                                       MIOPEN_HIPBLASLT_VERSION_MINOR) * 1000 +
                                      MIOPEN_HIPBLASLT_VERSION_PATCH

const MIOPEN_GOLDEN_DB_VERSION = 21

# Skipping MacroDefinition: MIOPEN_EXPORT __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: MIOPEN_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: MIOPEN_DEPRECATED __attribute__ ( ( __deprecated__ ) )

# Skipping MacroDefinition: MIOPEN_INTERNALS_EXPORT __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: MIOPEN_INTERNALS_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: MIOPEN_INTERNALS_DEPRECATED __attribute__ ( ( __deprecated__ ) )

const HIP_VERSION_MAJOR = 7

const HIP_VERSION_MINOR = 13

const HIP_VERSION_PATCH = 99004

const HIP_VERSION_GITHASH = "3309c6114a"

const HIP_VERSION_BUILD_ID = 0

const HIP_VERSION_BUILD_NAME = ""

const HIP_VERSION = HIP_VERSION_MAJOR * 10000000 + HIP_VERSION_MINOR * 100000 +
                    HIP_VERSION_PATCH

const __HIP_HAS_GET_PCH = 1

# Skipping MacroDefinition: HIP_PUBLIC_API __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: HIP_INTERNAL_EXPORTED_API __attribute__ ( ( visibility ( "default" ) ) )

const __HIP_ARCH_HAS_GLOBAL_INT32_ATOMICS__ = 0

const __HIP_ARCH_HAS_GLOBAL_FLOAT_ATOMIC_EXCH__ = 0

const __HIP_ARCH_HAS_SHARED_INT32_ATOMICS__ = 0

const __HIP_ARCH_HAS_SHARED_FLOAT_ATOMIC_EXCH__ = 0

const __HIP_ARCH_HAS_FLOAT_ATOMIC_ADD__ = 0

const __HIP_ARCH_HAS_GLOBAL_INT64_ATOMICS__ = 0

const __HIP_ARCH_HAS_SHARED_INT64_ATOMICS__ = 0

const __HIP_ARCH_HAS_DOUBLES__ = 0

const __HIP_ARCH_HAS_WARP_VOTE__ = 0

const __HIP_ARCH_HAS_WARP_BALLOT__ = 0

const __HIP_ARCH_HAS_WARP_SHUFFLE__ = 0

const __HIP_ARCH_HAS_WARP_FUNNEL_SHIFT__ = 0

const __HIP_ARCH_HAS_THREAD_FENCE_SYSTEM__ = 0

const __HIP_ARCH_HAS_SYNC_THREAD_EXT__ = 0

const __HIP_ARCH_HAS_SURFACE_FUNCS__ = 0

const __HIP_ARCH_HAS_3DGRID__ = 0

const __HIP_ARCH_HAS_DYNAMIC_PARALLEL__ = 0

const hipGetDeviceProperties = hipGetDevicePropertiesR0600

const hipDeviceProp_t = hipDeviceProp_tR0600

const hipChooseDevice = hipChooseDeviceR0600

const HIP_GET_PROC_ADDRESS_DEFAULT = 0x00

const HIP_GET_PROC_ADDRESS_LEGACY_STREAM = 0x01

const HIP_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM = 0x02

const MIOPEN_API_VERSION_REDUCE_TENSOR = 1

const MIOPEN_VERSION_MAJOR = 3

const MIOPEN_VERSION_MINOR = 5

const MIOPEN_VERSION_PATCH = 1
