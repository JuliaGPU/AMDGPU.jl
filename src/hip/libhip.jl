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
    hipErrorTbd = 1054
end

function hipGetDevicePropertiesR0600(prop, deviceId)
    @check @gcsafe_ccall(libhip.hipGetDevicePropertiesR0600(prop::Ptr{hipDeviceProp_tR0600},
                                                            deviceId::Cint)::hipError_t)
end

function hipChooseDeviceR0600(device, prop)
    @check @gcsafe_ccall(libhip.hipChooseDeviceR0600(device::Ptr{Cint},
                                                     prop::Ptr{hipDeviceProp_tR0600})::hipError_t)
end

mutable struct ihipStream_t end

const hipStream_t = Ptr{ihipStream_t}

@cenum hipLaunchAttributeID::UInt32 begin
    hipLaunchAttributeAccessPolicyWindow = 1
    hipLaunchAttributeCooperative = 2
    hipLaunchAttributeSynchronizationPolicy = 3
    hipLaunchAttributePriority = 8
    hipLaunchAttributeMemSyncDomainMap = 9
    hipLaunchAttributeMemSyncDomain = 10
    hipLaunchAttributeMax = 11
end

struct hipLaunchAttributeValue
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipLaunchAttributeValue}, f::Symbol)
    f === :pad && return Ptr{NTuple{64,Cchar}}(x + 0)
    f === :accessPolicyWindow && return Ptr{hipAccessPolicyWindow}(x + 0)
    f === :cooperative && return Ptr{Cint}(x + 0)
    f === :priority && return Ptr{Cint}(x + 0)
    f === :syncPolicy && return Ptr{hipSynchronizationPolicy}(x + 0)
    f === :memSyncDomainMap && return Ptr{hipLaunchMemSyncDomainMap}(x + 0)
    f === :memSyncDomain && return Ptr{hipLaunchMemSyncDomain}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipLaunchAttributeValue, f::Symbol)
    r = Ref{hipLaunchAttributeValue}(x)
    ptr = Base.unsafe_convert(Ptr{hipLaunchAttributeValue}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipLaunchAttributeValue}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipLaunchAttributeValue, private::Bool=false)
    return (:pad, :accessPolicyWindow, :cooperative, :priority, :syncPolicy,
            :memSyncDomainMap, :memSyncDomain, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipLaunchAttribute_st
    data::NTuple{72,UInt8}
end

function Base.getproperty(x::Ptr{hipLaunchAttribute_st}, f::Symbol)
    f === :id && return Ptr{hipLaunchAttributeID}(x + 0)
    f === :pad && return Ptr{NTuple{4,Cchar}}(x + 4)
    f === :val && return Ptr{hipLaunchAttributeValue}(x + 8)
    f === :value && return Ptr{hipLaunchAttributeValue}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipLaunchAttribute_st, f::Symbol)
    r = Ref{hipLaunchAttribute_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipLaunchAttribute_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipLaunchAttribute_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipLaunchAttribute_st, private::Bool=false)
    return (:id, :pad, :val, :value, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipLaunchAttribute = hipLaunchAttribute_st

@cenum hipJitOption::UInt32 begin
    hipJitOptionMaxRegisters = 0
    hipJitOptionThreadsPerBlock = 1
    hipJitOptionWallTime = 2
    hipJitOptionInfoLogBuffer = 3
    hipJitOptionInfoLogBufferSizeBytes = 4
    hipJitOptionErrorLogBuffer = 5
    hipJitOptionErrorLogBufferSizeBytes = 6
    hipJitOptionOptimizationLevel = 7
    hipJitOptionTargetFromContext = 8
    hipJitOptionTarget = 9
    hipJitOptionFallbackStrategy = 10
    hipJitOptionGenerateDebugInfo = 11
    hipJitOptionLogVerbose = 12
    hipJitOptionGenerateLineInfo = 13
    hipJitOptionCacheMode = 14
    hipJitOptionSm3xOpt = 15
    hipJitOptionFastCompile = 16
    hipJitOptionGlobalSymbolNames = 17
    hipJitOptionGlobalSymbolAddresses = 18
    hipJitOptionGlobalSymbolCount = 19
    hipJitOptionLto = 20
    hipJitOptionFtz = 21
    hipJitOptionPrecDiv = 22
    hipJitOptionPrecSqrt = 23
    hipJitOptionFma = 24
    hipJitOptionPositionIndependentCode = 25
    hipJitOptionMinCTAPerSM = 26
    hipJitOptionMaxThreadsPerBlock = 27
    hipJitOptionOverrideDirectiveValues = 28
    hipJitOptionNumOptions = 29
    hipJitOptionIRtoISAOptExt = 10000
    hipJitOptionIRtoISAOptCountExt = 10001
end

@cenum hipJitInputType::UInt32 begin
    hipJitInputCubin = 0
    hipJitInputPtx = 1
    hipJitInputFatBinary = 2
    hipJitInputObject = 3
    hipJitInputLibrary = 4
    hipJitInputNvvm = 5
    hipJitNumLegacyInputTypes = 6
    hipJitInputLLVMBitcode = 100
    hipJitInputLLVMBundledBitcode = 101
    hipJitInputLLVMArchivesOfBundledBitcode = 102
    hipJitInputSpirv = 103
    hipJitNumInputTypes = 10
end

@cenum hipJitCacheMode::UInt32 begin
    hipJitCacheOptionNone = 0
    hipJitCacheOptionCG = 1
    hipJitCacheOptionCA = 2
end

@cenum hipJitFallback::UInt32 begin
    hipJitPreferPTX = 0
    hipJitPreferBinary = 1
end

@cenum hipLibraryOption_e::UInt32 begin
    hipLibraryHostUniversalFunctionAndDataTable = 0
    hipLibraryBinaryIsPreserved = 1
end

const hipLibraryOption = hipLibraryOption_e

@cenum var"##Ctag#277"::UInt32 begin
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

const hipDeviceptr_t = Ptr{Cvoid}

@cenum hipChannelFormatKind::UInt32 begin
    hipChannelFormatKindSigned = 0
    hipChannelFormatKindUnsigned = 1
    hipChannelFormatKindFloat = 2
    hipChannelFormatKindNone = 3
end

struct hipChannelFormatDesc
    x::Cint
    y::Cint
    z::Cint
    w::Cint
    f::hipChannelFormatKind
end

mutable struct hipArray end

const hipArray_t = Ptr{hipArray}

const hipArray_const_t = Ptr{hipArray}

@cenum hipArray_Format::UInt32 begin
    HIP_AD_FORMAT_UNSIGNED_INT8 = 1
    HIP_AD_FORMAT_UNSIGNED_INT16 = 2
    HIP_AD_FORMAT_UNSIGNED_INT32 = 3
    HIP_AD_FORMAT_SIGNED_INT8 = 8
    HIP_AD_FORMAT_SIGNED_INT16 = 9
    HIP_AD_FORMAT_SIGNED_INT32 = 10
    HIP_AD_FORMAT_HALF = 16
    HIP_AD_FORMAT_FLOAT = 32
end

struct HIP_ARRAY_DESCRIPTOR
    Width::Csize_t
    Height::Csize_t
    Format::hipArray_Format
    NumChannels::Cuint
end

struct HIP_ARRAY3D_DESCRIPTOR
    Width::Csize_t
    Height::Csize_t
    Depth::Csize_t
    Format::hipArray_Format
    NumChannels::Cuint
    Flags::Cuint
end

struct hip_Memcpy2D
    srcXInBytes::Csize_t
    srcY::Csize_t
    srcMemoryType::hipMemoryType
    srcHost::Ptr{Cvoid}
    srcDevice::hipDeviceptr_t
    srcArray::hipArray_t
    srcPitch::Csize_t
    dstXInBytes::Csize_t
    dstY::Csize_t
    dstMemoryType::hipMemoryType
    dstHost::Ptr{Cvoid}
    dstDevice::hipDeviceptr_t
    dstArray::hipArray_t
    dstPitch::Csize_t
    WidthInBytes::Csize_t
    Height::Csize_t
end

struct hipMipmappedArray
    data::Ptr{Cvoid}
    desc::hipChannelFormatDesc
    type::Cuint
    width::Cuint
    height::Cuint
    depth::Cuint
    min_mipmap_level::Cuint
    max_mipmap_level::Cuint
    flags::Cuint
    format::hipArray_Format
    num_channels::Cuint
end

const hipMipmappedArray_t = Ptr{hipMipmappedArray}

const hipmipmappedArray = hipMipmappedArray_t

const hipMipmappedArray_const_t = Ptr{hipMipmappedArray}

@cenum hipResourceType::UInt32 begin
    hipResourceTypeArray = 0
    hipResourceTypeMipmappedArray = 1
    hipResourceTypeLinear = 2
    hipResourceTypePitch2D = 3
end

@cenum HIPresourcetype_enum::UInt32 begin
    HIP_RESOURCE_TYPE_ARRAY = 0
    HIP_RESOURCE_TYPE_MIPMAPPED_ARRAY = 1
    HIP_RESOURCE_TYPE_LINEAR = 2
    HIP_RESOURCE_TYPE_PITCH2D = 3
end

const HIPresourcetype = HIPresourcetype_enum

const hipResourcetype = HIPresourcetype_enum

@cenum HIPaddress_mode_enum::UInt32 begin
    HIP_TR_ADDRESS_MODE_WRAP = 0
    HIP_TR_ADDRESS_MODE_CLAMP = 1
    HIP_TR_ADDRESS_MODE_MIRROR = 2
    HIP_TR_ADDRESS_MODE_BORDER = 3
end

const HIPaddress_mode = HIPaddress_mode_enum

@cenum HIPfilter_mode_enum::UInt32 begin
    HIP_TR_FILTER_MODE_POINT = 0
    HIP_TR_FILTER_MODE_LINEAR = 1
end

const HIPfilter_mode = HIPfilter_mode_enum

struct HIP_TEXTURE_DESC_st
    addressMode::NTuple{3,HIPaddress_mode}
    filterMode::HIPfilter_mode
    flags::Cuint
    maxAnisotropy::Cuint
    mipmapFilterMode::HIPfilter_mode
    mipmapLevelBias::Cfloat
    minMipmapLevelClamp::Cfloat
    maxMipmapLevelClamp::Cfloat
    borderColor::NTuple{4,Cfloat}
    reserved::NTuple{12,Cint}
end

const HIP_TEXTURE_DESC = HIP_TEXTURE_DESC_st

@cenum hipResourceViewFormat::UInt32 begin
    hipResViewFormatNone = 0
    hipResViewFormatUnsignedChar1 = 1
    hipResViewFormatUnsignedChar2 = 2
    hipResViewFormatUnsignedChar4 = 3
    hipResViewFormatSignedChar1 = 4
    hipResViewFormatSignedChar2 = 5
    hipResViewFormatSignedChar4 = 6
    hipResViewFormatUnsignedShort1 = 7
    hipResViewFormatUnsignedShort2 = 8
    hipResViewFormatUnsignedShort4 = 9
    hipResViewFormatSignedShort1 = 10
    hipResViewFormatSignedShort2 = 11
    hipResViewFormatSignedShort4 = 12
    hipResViewFormatUnsignedInt1 = 13
    hipResViewFormatUnsignedInt2 = 14
    hipResViewFormatUnsignedInt4 = 15
    hipResViewFormatSignedInt1 = 16
    hipResViewFormatSignedInt2 = 17
    hipResViewFormatSignedInt4 = 18
    hipResViewFormatHalf1 = 19
    hipResViewFormatHalf2 = 20
    hipResViewFormatHalf4 = 21
    hipResViewFormatFloat1 = 22
    hipResViewFormatFloat2 = 23
    hipResViewFormatFloat4 = 24
    hipResViewFormatUnsignedBlockCompressed1 = 25
    hipResViewFormatUnsignedBlockCompressed2 = 26
    hipResViewFormatUnsignedBlockCompressed3 = 27
    hipResViewFormatUnsignedBlockCompressed4 = 28
    hipResViewFormatSignedBlockCompressed4 = 29
    hipResViewFormatUnsignedBlockCompressed5 = 30
    hipResViewFormatSignedBlockCompressed5 = 31
    hipResViewFormatUnsignedBlockCompressed6H = 32
    hipResViewFormatSignedBlockCompressed6H = 33
    hipResViewFormatUnsignedBlockCompressed7 = 34
end

@cenum HIPresourceViewFormat_enum::UInt32 begin
    HIP_RES_VIEW_FORMAT_NONE = 0
    HIP_RES_VIEW_FORMAT_UINT_1X8 = 1
    HIP_RES_VIEW_FORMAT_UINT_2X8 = 2
    HIP_RES_VIEW_FORMAT_UINT_4X8 = 3
    HIP_RES_VIEW_FORMAT_SINT_1X8 = 4
    HIP_RES_VIEW_FORMAT_SINT_2X8 = 5
    HIP_RES_VIEW_FORMAT_SINT_4X8 = 6
    HIP_RES_VIEW_FORMAT_UINT_1X16 = 7
    HIP_RES_VIEW_FORMAT_UINT_2X16 = 8
    HIP_RES_VIEW_FORMAT_UINT_4X16 = 9
    HIP_RES_VIEW_FORMAT_SINT_1X16 = 10
    HIP_RES_VIEW_FORMAT_SINT_2X16 = 11
    HIP_RES_VIEW_FORMAT_SINT_4X16 = 12
    HIP_RES_VIEW_FORMAT_UINT_1X32 = 13
    HIP_RES_VIEW_FORMAT_UINT_2X32 = 14
    HIP_RES_VIEW_FORMAT_UINT_4X32 = 15
    HIP_RES_VIEW_FORMAT_SINT_1X32 = 16
    HIP_RES_VIEW_FORMAT_SINT_2X32 = 17
    HIP_RES_VIEW_FORMAT_SINT_4X32 = 18
    HIP_RES_VIEW_FORMAT_FLOAT_1X16 = 19
    HIP_RES_VIEW_FORMAT_FLOAT_2X16 = 20
    HIP_RES_VIEW_FORMAT_FLOAT_4X16 = 21
    HIP_RES_VIEW_FORMAT_FLOAT_1X32 = 22
    HIP_RES_VIEW_FORMAT_FLOAT_2X32 = 23
    HIP_RES_VIEW_FORMAT_FLOAT_4X32 = 24
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC1 = 25
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC2 = 26
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC3 = 27
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC4 = 28
    HIP_RES_VIEW_FORMAT_SIGNED_BC4 = 29
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC5 = 30
    HIP_RES_VIEW_FORMAT_SIGNED_BC5 = 31
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC6H = 32
    HIP_RES_VIEW_FORMAT_SIGNED_BC6H = 33
    HIP_RES_VIEW_FORMAT_UNSIGNED_BC7 = 34
end

const HIPresourceViewFormat = HIPresourceViewFormat_enum

struct var"##Ctag#292"
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#292"}, f::Symbol)
    f === :array && return Ptr{var"##Ctag#293"}(x + 0)
    f === :mipmap && return Ptr{var"##Ctag#294"}(x + 0)
    f === :linear && return Ptr{var"##Ctag#295"}(x + 0)
    f === :pitch2D && return Ptr{var"##Ctag#296"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#292", f::Symbol)
    r = Ref{var"##Ctag#292"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#292"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#292"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#292", private::Bool=false)
    return (:array, :mipmap, :linear, :pitch2D, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipResourceDesc
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipResourceDesc}, f::Symbol)
    f === :resType && return Ptr{hipResourceType}(x + 0)
    f === :res && return Ptr{var"##Ctag#292"}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipResourceDesc, f::Symbol)
    r = Ref{hipResourceDesc}(x)
    ptr = Base.unsafe_convert(Ptr{hipResourceDesc}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipResourceDesc}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipResourceDesc, private::Bool=false)
    return (:resType, :res, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#299"
    data::NTuple{128,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#299"}, f::Symbol)
    f === :array && return Ptr{var"##Ctag#300"}(x + 0)
    f === :mipmap && return Ptr{var"##Ctag#301"}(x + 0)
    f === :linear && return Ptr{var"##Ctag#302"}(x + 0)
    f === :pitch2D && return Ptr{var"##Ctag#303"}(x + 0)
    f === :reserved && return Ptr{var"##Ctag#304"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#299", f::Symbol)
    r = Ref{var"##Ctag#299"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#299"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#299"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#299", private::Bool=false)
    return (:array, :mipmap, :linear, :pitch2D, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct HIP_RESOURCE_DESC_st
    data::NTuple{144,UInt8}
end

function Base.getproperty(x::Ptr{HIP_RESOURCE_DESC_st}, f::Symbol)
    f === :resType && return Ptr{HIPresourcetype}(x + 0)
    f === :res && return Ptr{var"##Ctag#299"}(x + 8)
    f === :flags && return Ptr{Cuint}(x + 136)
    return getfield(x, f)
end

function Base.getproperty(x::HIP_RESOURCE_DESC_st, f::Symbol)
    r = Ref{HIP_RESOURCE_DESC_st}(x)
    ptr = Base.unsafe_convert(Ptr{HIP_RESOURCE_DESC_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{HIP_RESOURCE_DESC_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::HIP_RESOURCE_DESC_st, private::Bool=false)
    return (:resType, :res, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const HIP_RESOURCE_DESC = HIP_RESOURCE_DESC_st

struct hipResourceViewDesc
    format::hipResourceViewFormat
    width::Csize_t
    height::Csize_t
    depth::Csize_t
    firstMipmapLevel::Cuint
    lastMipmapLevel::Cuint
    firstLayer::Cuint
    lastLayer::Cuint
end

struct HIP_RESOURCE_VIEW_DESC_st
    format::HIPresourceViewFormat
    width::Csize_t
    height::Csize_t
    depth::Csize_t
    firstMipmapLevel::Cuint
    lastMipmapLevel::Cuint
    firstLayer::Cuint
    lastLayer::Cuint
    reserved::NTuple{16,Cuint}
end

const HIP_RESOURCE_VIEW_DESC = HIP_RESOURCE_VIEW_DESC_st

@cenum hipMemcpyKind::UInt32 begin
    hipMemcpyHostToHost = 0
    hipMemcpyHostToDevice = 1
    hipMemcpyDeviceToHost = 2
    hipMemcpyDeviceToDevice = 3
    hipMemcpyDefault = 4
    hipMemcpyDeviceToDeviceNoCU = 1024
end

struct hipPitchedPtr
    ptr::Ptr{Cvoid}
    pitch::Csize_t
    xsize::Csize_t
    ysize::Csize_t
end

struct hipExtent
    width::Csize_t
    height::Csize_t
    depth::Csize_t
end

struct hipPos
    x::Csize_t
    y::Csize_t
    z::Csize_t
end

struct hipMemcpy3DParms
    srcArray::hipArray_t
    srcPos::hipPos
    srcPtr::hipPitchedPtr
    dstArray::hipArray_t
    dstPos::hipPos
    dstPtr::hipPitchedPtr
    extent::hipExtent
    kind::hipMemcpyKind
end

struct HIP_MEMCPY3D
    srcXInBytes::Csize_t
    srcY::Csize_t
    srcZ::Csize_t
    srcLOD::Csize_t
    srcMemoryType::hipMemoryType
    srcHost::Ptr{Cvoid}
    srcDevice::hipDeviceptr_t
    srcArray::hipArray_t
    srcPitch::Csize_t
    srcHeight::Csize_t
    dstXInBytes::Csize_t
    dstY::Csize_t
    dstZ::Csize_t
    dstLOD::Csize_t
    dstMemoryType::hipMemoryType
    dstHost::Ptr{Cvoid}
    dstDevice::hipDeviceptr_t
    dstArray::hipArray_t
    dstPitch::Csize_t
    dstHeight::Csize_t
    WidthInBytes::Csize_t
    Height::Csize_t
    Depth::Csize_t
end

@cenum hipMemLocationType::UInt32 begin
    hipMemLocationTypeInvalid = 0
    hipMemLocationTypeNone = 0
    hipMemLocationTypeDevice = 1
    hipMemLocationTypeHost = 2
    hipMemLocationTypeHostNuma = 3
    hipMemLocationTypeHostNumaCurrent = 4
end

struct hipMemLocation
    type::hipMemLocationType
    id::Cint
end

@cenum hipMemcpyFlags::UInt32 begin
    hipMemcpyFlagDefault = 0
    hipMemcpyFlagPreferOverlapWithCompute = 1
end

@cenum hipMemcpySrcAccessOrder::UInt32 begin
    hipMemcpySrcAccessOrderInvalid = 0
    hipMemcpySrcAccessOrderStream = 1
    hipMemcpySrcAccessOrderDuringApiCall = 2
    hipMemcpySrcAccessOrderAny = 3
    hipMemcpySrcAccessOrderMax = 2147483647
end

struct hipMemcpyAttributes
    srcAccessOrder::hipMemcpySrcAccessOrder
    srcLocHint::hipMemLocation
    dstLocHint::hipMemLocation
    flags::Cuint
end

@cenum hipMemcpy3DOperandType::UInt32 begin
    hipMemcpyOperandTypePointer = 1
    hipMemcpyOperandTypeArray = 2
    hipMemcpyOperandTypeMax = 2147483647
end

struct hipOffset3D
    x::Csize_t
    y::Csize_t
    z::Csize_t
end

struct var"##Ctag#278"
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#278"}, f::Symbol)
    f === :ptr && return Ptr{var"##Ctag#279"}(x + 0)
    f === :array && return Ptr{var"##Ctag#280"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#278", f::Symbol)
    r = Ref{var"##Ctag#278"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#278"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#278"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#278", private::Bool=false)
    return (:ptr, :array, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemcpy3DOperand
    data::NTuple{40,UInt8}
end

function Base.getproperty(x::Ptr{hipMemcpy3DOperand}, f::Symbol)
    f === :type && return Ptr{hipMemcpy3DOperandType}(x + 0)
    f === :op && return Ptr{var"##Ctag#278"}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemcpy3DOperand, f::Symbol)
    r = Ref{hipMemcpy3DOperand}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemcpy3DOperand}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemcpy3DOperand}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemcpy3DOperand, private::Bool=false)
    return (:type, :op, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemcpy3DBatchOp
    data::NTuple{112,UInt8}
end

function Base.getproperty(x::Ptr{hipMemcpy3DBatchOp}, f::Symbol)
    f === :src && return Ptr{hipMemcpy3DOperand}(x + 0)
    f === :dst && return Ptr{hipMemcpy3DOperand}(x + 40)
    f === :extent && return Ptr{hipExtent}(x + 80)
    f === :srcAccessOrder && return Ptr{hipMemcpySrcAccessOrder}(x + 104)
    f === :flags && return Ptr{Cuint}(x + 108)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemcpy3DBatchOp, f::Symbol)
    r = Ref{hipMemcpy3DBatchOp}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemcpy3DBatchOp}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemcpy3DBatchOp}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemcpy3DBatchOp, private::Bool=false)
    return (:src, :dst, :extent, :srcAccessOrder, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemcpy3DPeerParms
    srcArray::hipArray_t
    srcPos::hipPos
    srcPtr::hipPitchedPtr
    srcDevice::Cint
    dstArray::hipArray_t
    dstPos::hipPos
    dstPtr::hipPitchedPtr
    dstDevice::Cint
    extent::hipExtent
end

function make_hipPitchedPtr(d, p, xsz, ysz)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_hipPitchedPtr(d::Ptr{Cvoid}, p::Csize_t, xsz::Csize_t,
                                                   ysz::Csize_t)::hipPitchedPtr)
end

function make_hipPos(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_hipPos(x::Csize_t, y::Csize_t, z::Csize_t)::hipPos)
end

function make_hipExtent(w, h, d)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_hipExtent(w::Csize_t, h::Csize_t,
                                               d::Csize_t)::hipExtent)
end

@cenum hipFunction_attribute::UInt32 begin
    HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 0
    HIP_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES = 1
    HIP_FUNC_ATTRIBUTE_CONST_SIZE_BYTES = 2
    HIP_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES = 3
    HIP_FUNC_ATTRIBUTE_NUM_REGS = 4
    HIP_FUNC_ATTRIBUTE_PTX_VERSION = 5
    HIP_FUNC_ATTRIBUTE_BINARY_VERSION = 6
    HIP_FUNC_ATTRIBUTE_CACHE_MODE_CA = 7
    HIP_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES = 8
    HIP_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = 9
    HIP_FUNC_ATTRIBUTE_MAX = 10
end

@cenum hipPointer_attribute::UInt32 begin
    HIP_POINTER_ATTRIBUTE_CONTEXT = 1
    HIP_POINTER_ATTRIBUTE_MEMORY_TYPE = 2
    HIP_POINTER_ATTRIBUTE_DEVICE_POINTER = 3
    HIP_POINTER_ATTRIBUTE_HOST_POINTER = 4
    HIP_POINTER_ATTRIBUTE_P2P_TOKENS = 5
    HIP_POINTER_ATTRIBUTE_SYNC_MEMOPS = 6
    HIP_POINTER_ATTRIBUTE_BUFFER_ID = 7
    HIP_POINTER_ATTRIBUTE_IS_MANAGED = 8
    HIP_POINTER_ATTRIBUTE_DEVICE_ORDINAL = 9
    HIP_POINTER_ATTRIBUTE_IS_LEGACY_HIP_IPC_CAPABLE = 10
    HIP_POINTER_ATTRIBUTE_RANGE_START_ADDR = 11
    HIP_POINTER_ATTRIBUTE_RANGE_SIZE = 12
    HIP_POINTER_ATTRIBUTE_MAPPED = 13
    HIP_POINTER_ATTRIBUTE_ALLOWED_HANDLE_TYPES = 14
    HIP_POINTER_ATTRIBUTE_IS_GPU_DIRECT_RDMA_CAPABLE = 15
    HIP_POINTER_ATTRIBUTE_ACCESS_FLAGS = 16
    HIP_POINTER_ATTRIBUTE_MEMPOOL_HANDLE = 17
end

struct uchar1
    x::Cuchar
end

struct uchar2
    x::Cuchar
    y::Cuchar
end

struct uchar3
    x::Cuchar
    y::Cuchar
    z::Cuchar
end

struct uchar4
    x::Cuchar
    y::Cuchar
    z::Cuchar
    w::Cuchar
end

struct char1
    x::Cchar
end

struct char2
    x::Cchar
    y::Cchar
end

struct char3
    x::Cchar
    y::Cchar
    z::Cchar
end

struct char4
    x::Cchar
    y::Cchar
    z::Cchar
    w::Cchar
end

struct ushort1
    x::Cushort
end

struct ushort2
    x::Cushort
    y::Cushort
end

struct ushort3
    x::Cushort
    y::Cushort
    z::Cushort
end

struct ushort4
    x::Cushort
    y::Cushort
    z::Cushort
    w::Cushort
end

struct short1
    x::Cshort
end

struct short2
    x::Cshort
    y::Cshort
end

struct short3
    x::Cshort
    y::Cshort
    z::Cshort
end

struct short4
    x::Cshort
    y::Cshort
    z::Cshort
    w::Cshort
end

struct uint1
    x::Cuint
end

struct uint2
    x::Cuint
    y::Cuint
end

struct uint3
    x::Cuint
    y::Cuint
    z::Cuint
end

struct uint4
    x::Cuint
    y::Cuint
    z::Cuint
    w::Cuint
end

struct int1
    x::Cint
end

struct int2
    x::Cint
    y::Cint
end

struct int3
    x::Cint
    y::Cint
    z::Cint
end

struct int4
    x::Cint
    y::Cint
    z::Cint
    w::Cint
end

struct ulong1
    x::Culong
end

struct ulong2
    x::Culong
    y::Culong
end

struct ulong3
    x::Culong
    y::Culong
    z::Culong
end

struct ulong4
    x::Culong
    y::Culong
    z::Culong
    w::Culong
end

struct long1
    x::Clong
end

struct long2
    x::Clong
    y::Clong
end

struct long3
    x::Clong
    y::Clong
    z::Clong
end

struct long4
    x::Clong
    y::Clong
    z::Clong
    w::Clong
end

struct ulonglong1
    x::Culonglong
end

struct ulonglong2
    x::Culonglong
    y::Culonglong
end

struct ulonglong3
    x::Culonglong
    y::Culonglong
    z::Culonglong
end

struct ulonglong4
    x::Culonglong
    y::Culonglong
    z::Culonglong
    w::Culonglong
end

struct longlong1
    x::Clonglong
end

struct longlong2
    x::Clonglong
    y::Clonglong
end

struct longlong3
    x::Clonglong
    y::Clonglong
    z::Clonglong
end

struct longlong4
    x::Clonglong
    y::Clonglong
    z::Clonglong
    w::Clonglong
end

struct float1
    x::Cfloat
end

struct float2
    x::Cfloat
    y::Cfloat
end

struct float3
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

struct float4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

struct double1
    x::Cdouble
end

struct double2
    x::Cdouble
    y::Cdouble
end

struct double3
    x::Cdouble
    y::Cdouble
    z::Cdouble
end

struct double4
    x::Cdouble
    y::Cdouble
    z::Cdouble
    w::Cdouble
end

function make_uchar1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uchar1(x::Cuchar)::uchar1)
end

function make_uchar2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uchar2(x::Cuchar, y::Cuchar)::uchar2)
end

function make_uchar3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uchar3(x::Cuchar, y::Cuchar, z::Cuchar)::uchar3)
end

function make_uchar4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uchar4(x::Cuchar, y::Cuchar, z::Cuchar,
                                            w::Cuchar)::uchar4)
end

function make_char1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_char1(x::Int8)::char1)
end

function make_char2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_char2(x::Int8, y::Int8)::char2)
end

function make_char3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_char3(x::Int8, y::Int8, z::Int8)::char3)
end

function make_char4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_char4(x::Int8, y::Int8, z::Int8, w::Int8)::char4)
end

function make_ushort1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ushort1(x::Cushort)::ushort1)
end

function make_ushort2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ushort2(x::Cushort, y::Cushort)::ushort2)
end

function make_ushort3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ushort3(x::Cushort, y::Cushort, z::Cushort)::ushort3)
end

function make_ushort4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ushort4(x::Cushort, y::Cushort, z::Cushort,
                                             w::Cushort)::ushort4)
end

function make_short1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_short1(x::Cshort)::short1)
end

function make_short2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_short2(x::Cshort, y::Cshort)::short2)
end

function make_short3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_short3(x::Cshort, y::Cshort, z::Cshort)::short3)
end

function make_short4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_short4(x::Cshort, y::Cshort, z::Cshort,
                                            w::Cshort)::short4)
end

function make_uint1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uint1(x::Cuint)::uint1)
end

function make_uint2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uint2(x::Cuint, y::Cuint)::uint2)
end

function make_uint3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uint3(x::Cuint, y::Cuint, z::Cuint)::uint3)
end

function make_uint4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_uint4(x::Cuint, y::Cuint, z::Cuint, w::Cuint)::uint4)
end

function make_int1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_int1(x::Cint)::int1)
end

function make_int2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_int2(x::Cint, y::Cint)::int2)
end

function make_int3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_int3(x::Cint, y::Cint, z::Cint)::int3)
end

function make_int4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_int4(x::Cint, y::Cint, z::Cint, w::Cint)::int4)
end

function make_float1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_float1(x::Cfloat)::float1)
end

function make_float2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_float2(x::Cfloat, y::Cfloat)::float2)
end

function make_float3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_float3(x::Cfloat, y::Cfloat, z::Cfloat)::float3)
end

function make_float4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_float4(x::Cfloat, y::Cfloat, z::Cfloat,
                                            w::Cfloat)::float4)
end

function make_double1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_double1(x::Cdouble)::double1)
end

function make_double2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_double2(x::Cdouble, y::Cdouble)::double2)
end

function make_double3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_double3(x::Cdouble, y::Cdouble, z::Cdouble)::double3)
end

function make_double4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_double4(x::Cdouble, y::Cdouble, z::Cdouble,
                                             w::Cdouble)::double4)
end

function make_ulong1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulong1(x::Culong)::ulong1)
end

function make_ulong2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulong2(x::Culong, y::Culong)::ulong2)
end

function make_ulong3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulong3(x::Culong, y::Culong, z::Culong)::ulong3)
end

function make_ulong4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulong4(x::Culong, y::Culong, z::Culong,
                                            w::Culong)::ulong4)
end

function make_long1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_long1(x::Clong)::long1)
end

function make_long2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_long2(x::Clong, y::Clong)::long2)
end

function make_long3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_long3(x::Clong, y::Clong, z::Clong)::long3)
end

function make_long4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_long4(x::Clong, y::Clong, z::Clong, w::Clong)::long4)
end

function make_ulonglong1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulonglong1(x::Culonglong)::ulonglong1)
end

function make_ulonglong2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulonglong2(x::Culonglong, y::Culonglong)::ulonglong2)
end

function make_ulonglong3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulonglong3(x::Culonglong, y::Culonglong,
                                                z::Culonglong)::ulonglong3)
end

function make_ulonglong4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_ulonglong4(x::Culonglong, y::Culonglong, z::Culonglong,
                                                w::Culonglong)::ulonglong4)
end

function make_longlong1(x)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_longlong1(x::Clonglong)::longlong1)
end

function make_longlong2(x, y)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_longlong2(x::Clonglong, y::Clonglong)::longlong2)
end

function make_longlong3(x, y, z)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_longlong3(x::Clonglong, y::Clonglong,
                                               z::Clonglong)::longlong3)
end

function make_longlong4(x, y, z, w)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.make_longlong4(x::Clonglong, y::Clonglong, z::Clonglong,
                                               w::Clonglong)::longlong4)
end

function hipCreateChannelDesc(x, y, z, w, f)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCreateChannelDesc(x::Cint, y::Cint, z::Cint, w::Cint,
                                                     f::hipChannelFormatKind)::hipChannelFormatDesc)
end

mutable struct __hip_texture end

const hipTextureObject_t = Ptr{__hip_texture}

@cenum hipTextureAddressMode::UInt32 begin
    hipAddressModeWrap = 0
    hipAddressModeClamp = 1
    hipAddressModeMirror = 2
    hipAddressModeBorder = 3
end

@cenum hipTextureFilterMode::UInt32 begin
    hipFilterModePoint = 0
    hipFilterModeLinear = 1
end

@cenum hipTextureReadMode::UInt32 begin
    hipReadModeElementType = 0
    hipReadModeNormalizedFloat = 1
end

struct textureReference
    normalized::Cint
    readMode::hipTextureReadMode
    filterMode::hipTextureFilterMode
    addressMode::NTuple{3,hipTextureAddressMode}
    channelDesc::hipChannelFormatDesc
    sRGB::Cint
    maxAnisotropy::Cuint
    mipmapFilterMode::hipTextureFilterMode
    mipmapLevelBias::Cfloat
    minMipmapLevelClamp::Cfloat
    maxMipmapLevelClamp::Cfloat
    textureObject::hipTextureObject_t
    numChannels::Cint
    format::hipArray_Format
end

struct hipTextureDesc
    addressMode::NTuple{3,hipTextureAddressMode}
    filterMode::hipTextureFilterMode
    readMode::hipTextureReadMode
    sRGB::Cint
    borderColor::NTuple{4,Cfloat}
    normalizedCoords::Cint
    maxAnisotropy::Cuint
    mipmapFilterMode::hipTextureFilterMode
    mipmapLevelBias::Cfloat
    minMipmapLevelClamp::Cfloat
    maxMipmapLevelClamp::Cfloat
end

mutable struct __hip_surface end

const hipSurfaceObject_t = Ptr{__hip_surface}

struct surfaceReference
    surfaceObject::hipSurfaceObject_t
end

@cenum hipSurfaceBoundaryMode::UInt32 begin
    hipBoundaryModeZero = 0
    hipBoundaryModeTrap = 1
    hipBoundaryModeClamp = 2
end

mutable struct ihipCtx_t end

const hipCtx_t = Ptr{ihipCtx_t}

const hipDevice_t = Cint

@cenum hipDeviceP2PAttr::UInt32 begin
    hipDevP2PAttrPerformanceRank = 0
    hipDevP2PAttrAccessSupported = 1
    hipDevP2PAttrNativeAtomicSupported = 2
    hipDevP2PAttrHipArrayAccessSupported = 3
end

@cenum hipDriverEntryPointQueryResult::UInt32 begin
    hipDriverEntryPointSuccess = 0
    hipDriverEntryPointSymbolNotFound = 1
    hipDriverEntryPointVersionNotSufficent = 2
end

struct hipIpcMemHandle_st
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipIpcMemHandle_st}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64,Cchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipIpcMemHandle_st, f::Symbol)
    r = Ref{hipIpcMemHandle_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipIpcMemHandle_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipIpcMemHandle_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipIpcMemHandle_st, private::Bool=false)
    return (:reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipIpcMemHandle_t = hipIpcMemHandle_st

struct hipIpcEventHandle_st
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipIpcEventHandle_st}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64,Cchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipIpcEventHandle_st, f::Symbol)
    r = Ref{hipIpcEventHandle_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipIpcEventHandle_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipIpcEventHandle_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipIpcEventHandle_st, private::Bool=false)
    return (:reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipIpcEventHandle_t = hipIpcEventHandle_st

mutable struct ihipModule_t end

const hipModule_t = Ptr{ihipModule_t}

mutable struct ihipModuleSymbol_t end

const hipFunction_t = Ptr{ihipModuleSymbol_t}

mutable struct ihipLinkState_t end

const hipLinkState_t = Ptr{ihipLinkState_t}

mutable struct ihipLibrary_t end

const hipLibrary_t = Ptr{ihipLibrary_t}

mutable struct ihipKernel_t end

const hipKernel_t = Ptr{ihipKernel_t}

mutable struct ihipMemPoolHandle_t end

const hipMemPool_t = Ptr{ihipMemPoolHandle_t}

struct hipFuncAttributes
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{hipFuncAttributes}, f::Symbol)
    f === :binaryVersion && return Ptr{Cint}(x + 0)
    f === :cacheModeCA && return Ptr{Cint}(x + 4)
    f === :constSizeBytes && return Ptr{Csize_t}(x + 8)
    f === :localSizeBytes && return Ptr{Csize_t}(x + 16)
    f === :maxDynamicSharedSizeBytes && return Ptr{Cint}(x + 24)
    f === :maxThreadsPerBlock && return Ptr{Cint}(x + 28)
    f === :numRegs && return Ptr{Cint}(x + 32)
    f === :preferredShmemCarveout && return Ptr{Cint}(x + 36)
    f === :ptxVersion && return Ptr{Cint}(x + 40)
    f === :sharedSizeBytes && return Ptr{Csize_t}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::hipFuncAttributes, f::Symbol)
    r = Ref{hipFuncAttributes}(x)
    ptr = Base.unsafe_convert(Ptr{hipFuncAttributes}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipFuncAttributes}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipFuncAttributes, private::Bool=false)
    return (:binaryVersion, :cacheModeCA, :constSizeBytes, :localSizeBytes,
            :maxDynamicSharedSizeBytes, :maxThreadsPerBlock, :numRegs,
            :preferredShmemCarveout, :ptxVersion, :sharedSizeBytes,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

mutable struct ihipEvent_t end

const hipEvent_t = Ptr{ihipEvent_t}

@cenum hipLimit_t::UInt32 begin
    hipLimitStackSize = 0
    hipLimitPrintfFifoSize = 1
    hipLimitMallocHeapSize = 2
    hipExtLimitScratchMin = 4096
    hipExtLimitScratchMax = 4097
    hipExtLimitScratchCurrent = 4098
    hipLimitRange = 4099
end

@cenum hipStreamBatchMemOpType::UInt32 begin
    hipStreamMemOpWaitValue32 = 1
    hipStreamMemOpWriteValue32 = 2
    hipStreamMemOpWaitValue64 = 4
    hipStreamMemOpWriteValue64 = 5
    hipStreamMemOpBarrier = 6
    hipStreamMemOpFlushRemoteWrites = 3
end

struct hipStreamBatchMemOpParams_union
    data::NTuple{48,UInt8}
end

function Base.getproperty(x::Ptr{hipStreamBatchMemOpParams_union}, f::Symbol)
    f === :operation && return Ptr{hipStreamBatchMemOpType}(x + 0)
    f === :waitValue && return Ptr{hipStreamMemOpWaitValueParams_t}(x + 0)
    f === :writeValue && return Ptr{hipStreamMemOpWriteValueParams_t}(x + 0)
    f === :flushRemoteWrites && return Ptr{hipStreamMemOpFlushRemoteWritesParams_t}(x + 0)
    f === :memoryBarrier && return Ptr{hipStreamMemOpMemoryBarrierParams_t}(x + 0)
    f === :pad && return Ptr{NTuple{6,UInt64}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipStreamBatchMemOpParams_union, f::Symbol)
    r = Ref{hipStreamBatchMemOpParams_union}(x)
    ptr = Base.unsafe_convert(Ptr{hipStreamBatchMemOpParams_union}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipStreamBatchMemOpParams_union}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipStreamBatchMemOpParams_union, private::Bool=false)
    return (:operation, :waitValue, :writeValue, :flushRemoteWrites, :memoryBarrier, :pad,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipStreamBatchMemOpParams = hipStreamBatchMemOpParams_union

struct hipBatchMemOpNodeParams
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{hipBatchMemOpNodeParams}, f::Symbol)
    f === :ctx && return Ptr{hipCtx_t}(x + 0)
    f === :count && return Ptr{Cuint}(x + 8)
    f === :paramArray && return Ptr{Ptr{hipStreamBatchMemOpParams}}(x + 16)
    f === :flags && return Ptr{Cuint}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipBatchMemOpNodeParams, f::Symbol)
    r = Ref{hipBatchMemOpNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipBatchMemOpNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipBatchMemOpNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipBatchMemOpNodeParams, private::Bool=false)
    return (:ctx, :count, :paramArray, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipMemoryAdvise::UInt32 begin
    hipMemAdviseSetReadMostly = 1
    hipMemAdviseUnsetReadMostly = 2
    hipMemAdviseSetPreferredLocation = 3
    hipMemAdviseUnsetPreferredLocation = 4
    hipMemAdviseSetAccessedBy = 5
    hipMemAdviseUnsetAccessedBy = 6
    hipMemAdviseSetCoarseGrain = 100
    hipMemAdviseUnsetCoarseGrain = 101
end

@cenum hipMemRangeCoherencyMode::UInt32 begin
    hipMemRangeCoherencyModeFineGrain = 0
    hipMemRangeCoherencyModeCoarseGrain = 1
    hipMemRangeCoherencyModeIndeterminate = 2
end

@cenum hipMemRangeAttribute::UInt32 begin
    hipMemRangeAttributeReadMostly = 1
    hipMemRangeAttributePreferredLocation = 2
    hipMemRangeAttributeAccessedBy = 3
    hipMemRangeAttributeLastPrefetchLocation = 4
    hipMemRangeAttributeCoherencyMode = 100
end

@cenum hipMemPoolAttr::UInt32 begin
    hipMemPoolReuseFollowEventDependencies = 1
    hipMemPoolReuseAllowOpportunistic = 2
    hipMemPoolReuseAllowInternalDependencies = 3
    hipMemPoolAttrReleaseThreshold = 4
    hipMemPoolAttrReservedMemCurrent = 5
    hipMemPoolAttrReservedMemHigh = 6
    hipMemPoolAttrUsedMemCurrent = 7
    hipMemPoolAttrUsedMemHigh = 8
end

@cenum hipMemAccessFlags::UInt32 begin
    hipMemAccessFlagsProtNone = 0
    hipMemAccessFlagsProtRead = 1
    hipMemAccessFlagsProtReadWrite = 3
end

struct hipMemAccessDesc
    data::NTuple{12,UInt8}
end

function Base.getproperty(x::Ptr{hipMemAccessDesc}, f::Symbol)
    f === :location && return Ptr{hipMemLocation}(x + 0)
    f === :flags && return Ptr{hipMemAccessFlags}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemAccessDesc, f::Symbol)
    r = Ref{hipMemAccessDesc}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemAccessDesc}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemAccessDesc}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemAccessDesc, private::Bool=false)
    return (:location, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipMemAllocationType::UInt32 begin
    hipMemAllocationTypeInvalid = 0
    hipMemAllocationTypePinned = 1
    hipMemAllocationTypeUncached = 1073741824
    hipMemAllocationTypeMax = 2147483647
end

@cenum hipMemAllocationHandleType::UInt32 begin
    hipMemHandleTypeNone = 0
    hipMemHandleTypePosixFileDescriptor = 1
    hipMemHandleTypeWin32 = 2
    hipMemHandleTypeWin32Kmt = 4
end

struct hipMemPoolProps
    data::NTuple{88,UInt8}
end

function Base.getproperty(x::Ptr{hipMemPoolProps}, f::Symbol)
    f === :allocType && return Ptr{hipMemAllocationType}(x + 0)
    f === :handleTypes && return Ptr{hipMemAllocationHandleType}(x + 4)
    f === :location && return Ptr{hipMemLocation}(x + 8)
    f === :win32SecurityAttributes && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :maxSize && return Ptr{Csize_t}(x + 24)
    f === :reserved && return Ptr{NTuple{56,Cuchar}}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemPoolProps, f::Symbol)
    r = Ref{hipMemPoolProps}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemPoolProps}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemPoolProps}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemPoolProps, private::Bool=false)
    return (:allocType, :handleTypes, :location, :win32SecurityAttributes, :maxSize,
            :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemPoolPtrExportData
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipMemPoolPtrExportData}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64,Cuchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemPoolPtrExportData, f::Symbol)
    r = Ref{hipMemPoolPtrExportData}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemPoolPtrExportData}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemPoolPtrExportData}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemPoolPtrExportData, private::Bool=false)
    return (:reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipFuncAttribute::UInt32 begin
    hipFuncAttributeMaxDynamicSharedMemorySize = 8
    hipFuncAttributePreferredSharedMemoryCarveout = 9
    hipFuncAttributeMax = 10
end

@cenum hipFuncCache_t::UInt32 begin
    hipFuncCachePreferNone = 0
    hipFuncCachePreferShared = 1
    hipFuncCachePreferL1 = 2
    hipFuncCachePreferEqual = 3
end

@cenum hipSharedMemConfig::UInt32 begin
    hipSharedMemBankSizeDefault = 0
    hipSharedMemBankSizeFourByte = 1
    hipSharedMemBankSizeEightByte = 2
end

struct dim3
    data::NTuple{12,UInt8}
end

function Base.getproperty(x::Ptr{dim3}, f::Symbol)
    f === :x && return Ptr{UInt32}(x + 0)
    f === :y && return Ptr{UInt32}(x + 4)
    f === :z && return Ptr{UInt32}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::dim3, f::Symbol)
    r = Ref{dim3}(x)
    ptr = Base.unsafe_convert(Ptr{dim3}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{dim3}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::dim3, private::Bool=false)
    return (:x, :y, :z, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipLaunchParams_t
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{hipLaunchParams_t}, f::Symbol)
    f === :func && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :gridDim && return Ptr{dim3}(x + 8)
    f === :blockDim && return Ptr{dim3}(x + 20)
    f === :args && return Ptr{Ptr{Ptr{Cvoid}}}(x + 32)
    f === :sharedMem && return Ptr{Csize_t}(x + 40)
    f === :stream && return Ptr{hipStream_t}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::hipLaunchParams_t, f::Symbol)
    r = Ref{hipLaunchParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipLaunchParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipLaunchParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipLaunchParams_t, private::Bool=false)
    return (:func, :gridDim, :blockDim, :args, :sharedMem, :stream,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipLaunchParams = hipLaunchParams_t

struct hipFunctionLaunchParams_t
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{hipFunctionLaunchParams_t}, f::Symbol)
    f === :_function && return Ptr{hipFunction_t}(x + 0)
    f === :gridDimX && return Ptr{Cuint}(x + 8)
    f === :gridDimY && return Ptr{Cuint}(x + 12)
    f === :gridDimZ && return Ptr{Cuint}(x + 16)
    f === :blockDimX && return Ptr{Cuint}(x + 20)
    f === :blockDimY && return Ptr{Cuint}(x + 24)
    f === :blockDimZ && return Ptr{Cuint}(x + 28)
    f === :sharedMemBytes && return Ptr{Cuint}(x + 32)
    f === :hStream && return Ptr{hipStream_t}(x + 40)
    f === :kernelParams && return Ptr{Ptr{Ptr{Cvoid}}}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::hipFunctionLaunchParams_t, f::Symbol)
    r = Ref{hipFunctionLaunchParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipFunctionLaunchParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipFunctionLaunchParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipFunctionLaunchParams_t, private::Bool=false)
    return (:_function, :gridDimX, :gridDimY, :gridDimZ, :blockDimX, :blockDimY, :blockDimZ,
            :sharedMemBytes, :hStream, :kernelParams, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipFunctionLaunchParams = hipFunctionLaunchParams_t

@cenum hipExternalMemoryHandleType_enum::UInt32 begin
    hipExternalMemoryHandleTypeOpaqueFd = 1
    hipExternalMemoryHandleTypeOpaqueWin32 = 2
    hipExternalMemoryHandleTypeOpaqueWin32Kmt = 3
    hipExternalMemoryHandleTypeD3D12Heap = 4
    hipExternalMemoryHandleTypeD3D12Resource = 5
    hipExternalMemoryHandleTypeD3D11Resource = 6
    hipExternalMemoryHandleTypeD3D11ResourceKmt = 7
    hipExternalMemoryHandleTypeNvSciBuf = 8
end

const hipExternalMemoryHandleType = hipExternalMemoryHandleType_enum

struct var"##Ctag#297"
    data::NTuple{16,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#297"}, f::Symbol)
    f === :fd && return Ptr{Cint}(x + 0)
    f === :win32 && return Ptr{var"##Ctag#298"}(x + 0)
    f === :nvSciBufObject && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#297", f::Symbol)
    r = Ref{var"##Ctag#297"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#297"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#297"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#297", private::Bool=false)
    return (:fd, :win32, :nvSciBufObject, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalMemoryHandleDesc_st
    data::NTuple{104,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalMemoryHandleDesc_st}, f::Symbol)
    f === :type && return Ptr{hipExternalMemoryHandleType}(x + 0)
    f === :handle && return Ptr{var"##Ctag#297"}(x + 8)
    f === :size && return Ptr{Culonglong}(x + 24)
    f === :flags && return Ptr{Cuint}(x + 32)
    f === :reserved && return Ptr{NTuple{16,Cuint}}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalMemoryHandleDesc_st, f::Symbol)
    r = Ref{hipExternalMemoryHandleDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalMemoryHandleDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalMemoryHandleDesc_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalMemoryHandleDesc_st, private::Bool=false)
    return (:type, :handle, :size, :flags, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalMemoryHandleDesc = hipExternalMemoryHandleDesc_st

struct hipExternalMemoryBufferDesc_st
    data::NTuple{88,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalMemoryBufferDesc_st}, f::Symbol)
    f === :offset && return Ptr{Culonglong}(x + 0)
    f === :size && return Ptr{Culonglong}(x + 8)
    f === :flags && return Ptr{Cuint}(x + 16)
    f === :reserved && return Ptr{NTuple{16,Cuint}}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalMemoryBufferDesc_st, f::Symbol)
    r = Ref{hipExternalMemoryBufferDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalMemoryBufferDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalMemoryBufferDesc_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalMemoryBufferDesc_st, private::Bool=false)
    return (:offset, :size, :flags, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalMemoryBufferDesc = hipExternalMemoryBufferDesc_st

struct hipExternalMemoryMipmappedArrayDesc_st
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalMemoryMipmappedArrayDesc_st}, f::Symbol)
    f === :offset && return Ptr{Culonglong}(x + 0)
    f === :formatDesc && return Ptr{hipChannelFormatDesc}(x + 8)
    f === :extent && return Ptr{hipExtent}(x + 32)
    f === :flags && return Ptr{Cuint}(x + 56)
    f === :numLevels && return Ptr{Cuint}(x + 60)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalMemoryMipmappedArrayDesc_st, f::Symbol)
    r = Ref{hipExternalMemoryMipmappedArrayDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalMemoryMipmappedArrayDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalMemoryMipmappedArrayDesc_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalMemoryMipmappedArrayDesc_st, private::Bool=false)
    return (:offset, :formatDesc, :extent, :flags, :numLevels, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalMemoryMipmappedArrayDesc = hipExternalMemoryMipmappedArrayDesc_st

const hipExternalMemory_t = Ptr{Cvoid}

@cenum hipExternalSemaphoreHandleType_enum::UInt32 begin
    hipExternalSemaphoreHandleTypeOpaqueFd = 1
    hipExternalSemaphoreHandleTypeOpaqueWin32 = 2
    hipExternalSemaphoreHandleTypeOpaqueWin32Kmt = 3
    hipExternalSemaphoreHandleTypeD3D12Fence = 4
    hipExternalSemaphoreHandleTypeD3D11Fence = 5
    hipExternalSemaphoreHandleTypeNvSciSync = 6
    hipExternalSemaphoreHandleTypeKeyedMutex = 7
    hipExternalSemaphoreHandleTypeKeyedMutexKmt = 8
    hipExternalSemaphoreHandleTypeTimelineSemaphoreFd = 9
    hipExternalSemaphoreHandleTypeTimelineSemaphoreWin32 = 10
end

const hipExternalSemaphoreHandleType = hipExternalSemaphoreHandleType_enum

struct var"##Ctag#290"
    data::NTuple{16,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#290"}, f::Symbol)
    f === :fd && return Ptr{Cint}(x + 0)
    f === :win32 && return Ptr{var"##Ctag#291"}(x + 0)
    f === :NvSciSyncObj && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#290", f::Symbol)
    r = Ref{var"##Ctag#290"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#290"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#290"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#290", private::Bool=false)
    return (:fd, :win32, :NvSciSyncObj, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalSemaphoreHandleDesc_st
    data::NTuple{96,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreHandleDesc_st}, f::Symbol)
    f === :type && return Ptr{hipExternalSemaphoreHandleType}(x + 0)
    f === :handle && return Ptr{var"##Ctag#290"}(x + 8)
    f === :flags && return Ptr{Cuint}(x + 24)
    f === :reserved && return Ptr{NTuple{16,Cuint}}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreHandleDesc_st, f::Symbol)
    r = Ref{hipExternalSemaphoreHandleDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreHandleDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreHandleDesc_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalSemaphoreHandleDesc_st, private::Bool=false)
    return (:type, :handle, :flags, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalSemaphoreHandleDesc = hipExternalSemaphoreHandleDesc_st

const hipExternalSemaphore_t = Ptr{Cvoid}

struct var"##Ctag#287"
    value::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#287"}, f::Symbol)
    f === :value && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#287", f::Symbol)
    r = Ref{var"##Ctag#287"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#287"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#287"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#288"
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#288"}, f::Symbol)
    f === :fence && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :reserved && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#288", f::Symbol)
    r = Ref{var"##Ctag#288"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#288"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#288"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#288", private::Bool=false)
    return (:fence, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#289"
    key::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#289"}, f::Symbol)
    f === :key && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#289", f::Symbol)
    r = Ref{var"##Ctag#289"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#289"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#289"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#286"
    data::NTuple{72,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#286"}, f::Symbol)
    f === :fence && return Ptr{var"##Ctag#287"}(x + 0)
    f === :nvSciSync && return Ptr{var"##Ctag#288"}(x + 8)
    f === :keyedMutex && return Ptr{var"##Ctag#289"}(x + 16)
    f === :reserved && return Ptr{NTuple{12,Cuint}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#286", f::Symbol)
    r = Ref{var"##Ctag#286"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#286"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#286"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#286", private::Bool=false)
    return (:fence, :nvSciSync, :keyedMutex, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalSemaphoreSignalParams_st
    data::NTuple{144,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreSignalParams_st}, f::Symbol)
    f === :params && return Ptr{Cvoid}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 72)
    f === :reserved && return Ptr{NTuple{16,Cuint}}(x + 76)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreSignalParams_st, f::Symbol)
    r = Ref{hipExternalSemaphoreSignalParams_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreSignalParams_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreSignalParams_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalSemaphoreSignalParams_st, private::Bool=false)
    return (:params, :flags, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalSemaphoreSignalParams = hipExternalSemaphoreSignalParams_st

struct var"##Ctag#307"
    value::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#307"}, f::Symbol)
    f === :value && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#307", f::Symbol)
    r = Ref{var"##Ctag#307"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#307"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#307"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#308"
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#308"}, f::Symbol)
    f === :fence && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :reserved && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#308", f::Symbol)
    r = Ref{var"##Ctag#308"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#308"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#308"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#308", private::Bool=false)
    return (:fence, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#309"
    key::Culonglong
    timeoutMs::Cuint
end
function Base.getproperty(x::Ptr{var"##Ctag#309"}, f::Symbol)
    f === :key && return Ptr{Culonglong}(x + 0)
    f === :timeoutMs && return Ptr{Cuint}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#309", f::Symbol)
    r = Ref{var"##Ctag#309"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#309"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#309"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#306"
    data::NTuple{72,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#306"}, f::Symbol)
    f === :fence && return Ptr{var"##Ctag#307"}(x + 0)
    f === :nvSciSync && return Ptr{var"##Ctag#308"}(x + 8)
    f === :keyedMutex && return Ptr{var"##Ctag#309"}(x + 16)
    f === :reserved && return Ptr{NTuple{10,Cuint}}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#306", f::Symbol)
    r = Ref{var"##Ctag#306"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#306"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#306"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#306", private::Bool=false)
    return (:fence, :nvSciSync, :keyedMutex, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalSemaphoreWaitParams_st
    data::NTuple{144,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreWaitParams_st}, f::Symbol)
    f === :params && return Ptr{Cvoid}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 72)
    f === :reserved && return Ptr{NTuple{16,Cuint}}(x + 76)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreWaitParams_st, f::Symbol)
    r = Ref{hipExternalSemaphoreWaitParams_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreWaitParams_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreWaitParams_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalSemaphoreWaitParams_st, private::Bool=false)
    return (:params, :flags, :reserved, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipExternalSemaphoreWaitParams = hipExternalSemaphoreWaitParams_st

function __hipGetPCH(pch, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.__hipGetPCH(pch::Ptr{Cstring}, size::Ptr{Cuint})::Cvoid)
end

@cenum hipGraphicsRegisterFlags::UInt32 begin
    hipGraphicsRegisterFlagsNone = 0
    hipGraphicsRegisterFlagsReadOnly = 1
    hipGraphicsRegisterFlagsWriteDiscard = 2
    hipGraphicsRegisterFlagsSurfaceLoadStore = 4
    hipGraphicsRegisterFlagsTextureGather = 8
end

mutable struct _hipGraphicsResource end

const hipGraphicsResource = _hipGraphicsResource

const hipGraphicsResource_t = Ptr{hipGraphicsResource}

mutable struct ihipGraph end

const hipGraph_t = Ptr{ihipGraph}

mutable struct hipGraphNode end

const hipGraphNode_t = Ptr{hipGraphNode}

mutable struct hipGraphExec end

const hipGraphExec_t = Ptr{hipGraphExec}

mutable struct hipUserObject end

const hipUserObject_t = Ptr{hipUserObject}

@cenum hipGraphNodeType::UInt32 begin
    hipGraphNodeTypeKernel = 0
    hipGraphNodeTypeMemcpy = 1
    hipGraphNodeTypeMemset = 2
    hipGraphNodeTypeHost = 3
    hipGraphNodeTypeGraph = 4
    hipGraphNodeTypeEmpty = 5
    hipGraphNodeTypeWaitEvent = 6
    hipGraphNodeTypeEventRecord = 7
    hipGraphNodeTypeExtSemaphoreSignal = 8
    hipGraphNodeTypeExtSemaphoreWait = 9
    hipGraphNodeTypeMemAlloc = 10
    hipGraphNodeTypeMemFree = 11
    hipGraphNodeTypeMemcpyFromSymbol = 12
    hipGraphNodeTypeMemcpyToSymbol = 13
    hipGraphNodeTypeBatchMemOp = 14
    hipGraphNodeTypeCount = 15
end

# typedef void ( * hipHostFn_t ) ( void * userData )
const hipHostFn_t = Ptr{Cvoid}

struct hipHostNodeParams
    data::NTuple{16,UInt8}
end

function Base.getproperty(x::Ptr{hipHostNodeParams}, f::Symbol)
    f === :fn && return Ptr{hipHostFn_t}(x + 0)
    f === :userData && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipHostNodeParams, f::Symbol)
    r = Ref{hipHostNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipHostNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipHostNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipHostNodeParams, private::Bool=false)
    return (:fn, :userData, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipKernelNodeParams
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{hipKernelNodeParams}, f::Symbol)
    f === :blockDim && return Ptr{dim3}(x + 0)
    f === :extra && return Ptr{Ptr{Ptr{Cvoid}}}(x + 16)
    f === :func && return Ptr{Ptr{Cvoid}}(x + 24)
    f === :gridDim && return Ptr{dim3}(x + 32)
    f === :kernelParams && return Ptr{Ptr{Ptr{Cvoid}}}(x + 48)
    f === :sharedMemBytes && return Ptr{Cuint}(x + 56)
    return getfield(x, f)
end

function Base.getproperty(x::hipKernelNodeParams, f::Symbol)
    r = Ref{hipKernelNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipKernelNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipKernelNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipKernelNodeParams, private::Bool=false)
    return (:blockDim, :extra, :func, :gridDim, :kernelParams, :sharedMemBytes,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemsetParams
    data::NTuple{48,UInt8}
end

function Base.getproperty(x::Ptr{hipMemsetParams}, f::Symbol)
    f === :dst && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :elementSize && return Ptr{Cuint}(x + 8)
    f === :height && return Ptr{Csize_t}(x + 16)
    f === :pitch && return Ptr{Csize_t}(x + 24)
    f === :value && return Ptr{Cuint}(x + 32)
    f === :width && return Ptr{Csize_t}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemsetParams, f::Symbol)
    r = Ref{hipMemsetParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemsetParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemsetParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemsetParams, private::Bool=false)
    return (:dst, :elementSize, :height, :pitch, :value, :width,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemAllocNodeParams
    data::NTuple{120,UInt8}
end

function Base.getproperty(x::Ptr{hipMemAllocNodeParams}, f::Symbol)
    f === :poolProps && return Ptr{hipMemPoolProps}(x + 0)
    f === :accessDescs && return Ptr{Ptr{hipMemAccessDesc}}(x + 88)
    f === :accessDescCount && return Ptr{Csize_t}(x + 96)
    f === :bytesize && return Ptr{Csize_t}(x + 104)
    f === :dptr && return Ptr{Ptr{Cvoid}}(x + 112)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemAllocNodeParams, f::Symbol)
    r = Ref{hipMemAllocNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemAllocNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemAllocNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemAllocNodeParams, private::Bool=false)
    return (:poolProps, :accessDescs, :accessDescCount, :bytesize, :dptr,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipAccessProperty::UInt32 begin
    hipAccessPropertyNormal = 0
    hipAccessPropertyStreaming = 1
    hipAccessPropertyPersisting = 2
end

struct hipAccessPolicyWindow
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{hipAccessPolicyWindow}, f::Symbol)
    f === :base_ptr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :hitProp && return Ptr{hipAccessProperty}(x + 8)
    f === :hitRatio && return Ptr{Cfloat}(x + 12)
    f === :missProp && return Ptr{hipAccessProperty}(x + 16)
    f === :num_bytes && return Ptr{Csize_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipAccessPolicyWindow, f::Symbol)
    r = Ref{hipAccessPolicyWindow}(x)
    ptr = Base.unsafe_convert(Ptr{hipAccessPolicyWindow}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipAccessPolicyWindow}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipAccessPolicyWindow, private::Bool=false)
    return (:base_ptr, :hitProp, :hitRatio, :missProp, :num_bytes,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipLaunchMemSyncDomainMap
    data::NTuple{2,UInt8}
end

function Base.getproperty(x::Ptr{hipLaunchMemSyncDomainMap}, f::Symbol)
    f === :default_ && return Ptr{Cuchar}(x + 0)
    f === :remote && return Ptr{Cuchar}(x + 1)
    return getfield(x, f)
end

function Base.getproperty(x::hipLaunchMemSyncDomainMap, f::Symbol)
    r = Ref{hipLaunchMemSyncDomainMap}(x)
    ptr = Base.unsafe_convert(Ptr{hipLaunchMemSyncDomainMap}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipLaunchMemSyncDomainMap}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipLaunchMemSyncDomainMap, private::Bool=false)
    return (:default_, :remote, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipLaunchMemSyncDomain::UInt32 begin
    hipLaunchMemSyncDomainDefault = 0
    hipLaunchMemSyncDomainRemote = 1
end

@cenum hipSynchronizationPolicy::UInt32 begin
    hipSyncPolicyAuto = 1
    hipSyncPolicySpin = 2
    hipSyncPolicyYield = 3
    hipSyncPolicyBlockingSync = 4
end

@cenum hipGraphExecUpdateResult::UInt32 begin
    hipGraphExecUpdateSuccess = 0
    hipGraphExecUpdateError = 1
    hipGraphExecUpdateErrorTopologyChanged = 2
    hipGraphExecUpdateErrorNodeTypeChanged = 3
    hipGraphExecUpdateErrorFunctionChanged = 4
    hipGraphExecUpdateErrorParametersChanged = 5
    hipGraphExecUpdateErrorNotSupported = 6
    hipGraphExecUpdateErrorUnsupportedFunctionChange = 7
end

@cenum hipStreamCaptureMode::UInt32 begin
    hipStreamCaptureModeGlobal = 0
    hipStreamCaptureModeThreadLocal = 1
    hipStreamCaptureModeRelaxed = 2
end

@cenum hipStreamCaptureStatus::UInt32 begin
    hipStreamCaptureStatusNone = 0
    hipStreamCaptureStatusActive = 1
    hipStreamCaptureStatusInvalidated = 2
end

@cenum hipStreamUpdateCaptureDependenciesFlags::UInt32 begin
    hipStreamAddCaptureDependencies = 0
    hipStreamSetCaptureDependencies = 1
end

@cenum hipGraphMemAttributeType::UInt32 begin
    hipGraphMemAttrUsedMemCurrent = 0
    hipGraphMemAttrUsedMemHigh = 1
    hipGraphMemAttrReservedMemCurrent = 2
    hipGraphMemAttrReservedMemHigh = 3
end

@cenum hipUserObjectFlags::UInt32 begin
    hipUserObjectNoDestructorSync = 1
end

@cenum hipUserObjectRetainFlags::UInt32 begin
    hipGraphUserObjectMove = 1
end

@cenum hipGraphInstantiateFlags::UInt32 begin
    hipGraphInstantiateFlagAutoFreeOnLaunch = 1
    hipGraphInstantiateFlagUpload = 2
    hipGraphInstantiateFlagDeviceLaunch = 4
    hipGraphInstantiateFlagUseNodePriority = 8
end

@cenum hipGraphDebugDotFlags::UInt32 begin
    hipGraphDebugDotFlagsVerbose = 1
    hipGraphDebugDotFlagsKernelNodeParams = 4
    hipGraphDebugDotFlagsMemcpyNodeParams = 8
    hipGraphDebugDotFlagsMemsetNodeParams = 16
    hipGraphDebugDotFlagsHostNodeParams = 32
    hipGraphDebugDotFlagsEventNodeParams = 64
    hipGraphDebugDotFlagsExtSemasSignalNodeParams = 128
    hipGraphDebugDotFlagsExtSemasWaitNodeParams = 256
    hipGraphDebugDotFlagsKernelNodeAttributes = 512
    hipGraphDebugDotFlagsHandles = 1024
end

@cenum hipGraphInstantiateResult::UInt32 begin
    hipGraphInstantiateSuccess = 0
    hipGraphInstantiateError = 1
    hipGraphInstantiateInvalidStructure = 2
    hipGraphInstantiateNodeOperationNotSupported = 3
    hipGraphInstantiateMultipleDevicesNotSupported = 4
end

struct hipGraphInstantiateParams
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{hipGraphInstantiateParams}, f::Symbol)
    f === :errNode_out && return Ptr{hipGraphNode_t}(x + 0)
    f === :flags && return Ptr{Culonglong}(x + 8)
    f === :result_out && return Ptr{hipGraphInstantiateResult}(x + 16)
    f === :uploadStream && return Ptr{hipStream_t}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipGraphInstantiateParams, f::Symbol)
    r = Ref{hipGraphInstantiateParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipGraphInstantiateParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipGraphInstantiateParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipGraphInstantiateParams, private::Bool=false)
    return (:errNode_out, :flags, :result_out, :uploadStream, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#305"
    compressionType::Cuchar
    gpuDirectRDMACapable::Cuchar
    usage::Cushort
end
function Base.getproperty(x::Ptr{var"##Ctag#305"}, f::Symbol)
    f === :compressionType && return Ptr{Cuchar}(x + 0)
    f === :gpuDirectRDMACapable && return Ptr{Cuchar}(x + 1)
    f === :usage && return Ptr{Cushort}(x + 2)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#305", f::Symbol)
    r = Ref{var"##Ctag#305"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#305"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#305"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct hipMemAllocationProp
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{hipMemAllocationProp}, f::Symbol)
    f === :type && return Ptr{hipMemAllocationType}(x + 0)
    f === :requestedHandleType && return Ptr{hipMemAllocationHandleType}(x + 4)
    f === :requestedHandleTypes && return Ptr{hipMemAllocationHandleType}(x + 4)
    f === :location && return Ptr{hipMemLocation}(x + 8)
    f === :win32HandleMetaData && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :allocFlags && return Ptr{var"##Ctag#305"}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemAllocationProp, f::Symbol)
    r = Ref{hipMemAllocationProp}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemAllocationProp}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemAllocationProp}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemAllocationProp, private::Bool=false)
    return (:type, :requestedHandleType, :requestedHandleTypes, :location,
            :win32HandleMetaData, :allocFlags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalSemaphoreSignalNodeParams
    data::NTuple{24,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreSignalNodeParams}, f::Symbol)
    f === :extSemArray && return Ptr{Ptr{hipExternalSemaphore_t}}(x + 0)
    f === :paramsArray && return Ptr{Ptr{hipExternalSemaphoreSignalParams}}(x + 8)
    f === :numExtSems && return Ptr{Cuint}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreSignalNodeParams, f::Symbol)
    r = Ref{hipExternalSemaphoreSignalNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreSignalNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreSignalNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalSemaphoreSignalNodeParams, private::Bool=false)
    return (:extSemArray, :paramsArray, :numExtSems, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipExternalSemaphoreWaitNodeParams
    data::NTuple{24,UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreWaitNodeParams}, f::Symbol)
    f === :extSemArray && return Ptr{Ptr{hipExternalSemaphore_t}}(x + 0)
    f === :paramsArray && return Ptr{Ptr{hipExternalSemaphoreWaitParams}}(x + 8)
    f === :numExtSems && return Ptr{Cuint}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreWaitNodeParams, f::Symbol)
    r = Ref{hipExternalSemaphoreWaitNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreWaitNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreWaitNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipExternalSemaphoreWaitNodeParams, private::Bool=false)
    return (:extSemArray, :paramsArray, :numExtSems, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

mutable struct ihipMemGenericAllocationHandle end

const hipMemGenericAllocationHandle_t = Ptr{ihipMemGenericAllocationHandle}

@cenum hipMemAllocationGranularity_flags::UInt32 begin
    hipMemAllocationGranularityMinimum = 0
    hipMemAllocationGranularityRecommended = 1
end

@cenum hipMemHandleType::UInt32 begin
    hipMemHandleTypeGeneric = 0
end

@cenum hipMemOperationType::UInt32 begin
    hipMemOperationTypeMap = 1
    hipMemOperationTypeUnmap = 2
end

@cenum hipArraySparseSubresourceType::UInt32 begin
    hipArraySparseSubresourceTypeSparseLevel = 0
    hipArraySparseSubresourceTypeMiptail = 1
end

struct var"##Ctag#281"
    data::NTuple{64,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#281"}, f::Symbol)
    f === :mipmap && return Ptr{hipMipmappedArray}(x + 0)
    f === :array && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#281", f::Symbol)
    r = Ref{var"##Ctag#281"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#281"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#281"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#281", private::Bool=false)
    return (:mipmap, :array, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#282"
    data::NTuple{32,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#282"}, f::Symbol)
    f === :sparseLevel && return Ptr{var"##Ctag#283"}(x + 0)
    f === :miptail && return Ptr{var"##Ctag#284"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#282", f::Symbol)
    r = Ref{var"##Ctag#282"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#282"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#282"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#282", private::Bool=false)
    return (:sparseLevel, :miptail, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#285"
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#285"}, f::Symbol)
    f === :memHandle && return Ptr{hipMemGenericAllocationHandle_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#285", f::Symbol)
    r = Ref{var"##Ctag#285"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#285"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#285"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::var"##Ctag#285", private::Bool=false)
    return (:memHandle, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipArrayMapInfo
    data::NTuple{152,UInt8}
end

function Base.getproperty(x::Ptr{hipArrayMapInfo}, f::Symbol)
    f === :resourceType && return Ptr{hipResourceType}(x + 0)
    f === :resource && return Ptr{var"##Ctag#281"}(x + 8)
    f === :subresourceType && return Ptr{hipArraySparseSubresourceType}(x + 72)
    f === :subresource && return Ptr{var"##Ctag#282"}(x + 80)
    f === :memOperationType && return Ptr{hipMemOperationType}(x + 112)
    f === :memHandleType && return Ptr{hipMemHandleType}(x + 116)
    f === :memHandle && return Ptr{var"##Ctag#285"}(x + 120)
    f === :offset && return Ptr{Culonglong}(x + 128)
    f === :deviceBitMask && return Ptr{Cuint}(x + 136)
    f === :flags && return Ptr{Cuint}(x + 140)
    f === :reserved && return Ptr{NTuple{2,Cuint}}(x + 144)
    return getfield(x, f)
end

function Base.getproperty(x::hipArrayMapInfo, f::Symbol)
    r = Ref{hipArrayMapInfo}(x)
    ptr = Base.unsafe_convert(Ptr{hipArrayMapInfo}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipArrayMapInfo}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipArrayMapInfo, private::Bool=false)
    return (:resourceType, :resource, :subresourceType, :subresource, :memOperationType,
            :memHandleType, :memHandle, :offset, :deviceBitMask, :flags, :reserved,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemcpyNodeParams
    data::NTuple{176,UInt8}
end

function Base.getproperty(x::Ptr{hipMemcpyNodeParams}, f::Symbol)
    f === :flags && return Ptr{Cint}(x + 0)
    f === :reserved && return Ptr{NTuple{3,Cint}}(x + 4)
    f === :copyParams && return Ptr{hipMemcpy3DParms}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemcpyNodeParams, f::Symbol)
    r = Ref{hipMemcpyNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemcpyNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemcpyNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemcpyNodeParams, private::Bool=false)
    return (:flags, :reserved, :copyParams, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipChildGraphNodeParams
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipChildGraphNodeParams}, f::Symbol)
    f === :graph && return Ptr{hipGraph_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipChildGraphNodeParams, f::Symbol)
    r = Ref{hipChildGraphNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipChildGraphNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipChildGraphNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipChildGraphNodeParams, private::Bool=false)
    return (:graph, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipEventWaitNodeParams
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipEventWaitNodeParams}, f::Symbol)
    f === :event && return Ptr{hipEvent_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipEventWaitNodeParams, f::Symbol)
    r = Ref{hipEventWaitNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipEventWaitNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipEventWaitNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipEventWaitNodeParams, private::Bool=false)
    return (:event, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipEventRecordNodeParams
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipEventRecordNodeParams}, f::Symbol)
    f === :event && return Ptr{hipEvent_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipEventRecordNodeParams, f::Symbol)
    r = Ref{hipEventRecordNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipEventRecordNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipEventRecordNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipEventRecordNodeParams, private::Bool=false)
    return (:event, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipMemFreeNodeParams
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipMemFreeNodeParams}, f::Symbol)
    f === :dptr && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemFreeNodeParams, f::Symbol)
    r = Ref{hipMemFreeNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemFreeNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemFreeNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipMemFreeNodeParams, private::Bool=false)
    return (:dptr, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipGraphNodeParams
    data::NTuple{256,UInt8}
end

function Base.getproperty(x::Ptr{hipGraphNodeParams}, f::Symbol)
    f === :type && return Ptr{hipGraphNodeType}(x + 0)
    f === :reserved0 && return Ptr{NTuple{3,Cint}}(x + 4)
    f === :reserved1 && return Ptr{NTuple{29,Clonglong}}(x + 16)
    f === :kernel && return Ptr{hipKernelNodeParams}(x + 16)
    f === :memcpy && return Ptr{hipMemcpyNodeParams}(x + 16)
    f === :memset && return Ptr{hipMemsetParams}(x + 16)
    f === :host && return Ptr{hipHostNodeParams}(x + 16)
    f === :graph && return Ptr{hipChildGraphNodeParams}(x + 16)
    f === :eventWait && return Ptr{hipEventWaitNodeParams}(x + 16)
    f === :eventRecord && return Ptr{hipEventRecordNodeParams}(x + 16)
    f === :extSemSignal && return Ptr{hipExternalSemaphoreSignalNodeParams}(x + 16)
    f === :extSemWait && return Ptr{hipExternalSemaphoreWaitNodeParams}(x + 16)
    f === :alloc && return Ptr{hipMemAllocNodeParams}(x + 16)
    f === :free && return Ptr{hipMemFreeNodeParams}(x + 16)
    f === :reserved2 && return Ptr{Clonglong}(x + 248)
    return getfield(x, f)
end

function Base.getproperty(x::hipGraphNodeParams, f::Symbol)
    r = Ref{hipGraphNodeParams}(x)
    ptr = Base.unsafe_convert(Ptr{hipGraphNodeParams}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipGraphNodeParams}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipGraphNodeParams, private::Bool=false)
    return (:type, :reserved0, :reserved1, :kernel, :memcpy, :memset, :host, :graph,
            :eventWait, :eventRecord, :extSemSignal, :extSemWait, :alloc, :free, :reserved2,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

@cenum hipGraphDependencyType::UInt32 begin
    hipGraphDependencyTypeDefault = 0
    hipGraphDependencyTypeProgrammatic = 1
end

struct hipGraphEdgeData
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipGraphEdgeData}, f::Symbol)
    f === :from_port && return Ptr{Cuchar}(x + 0)
    f === :reserved && return Ptr{NTuple{5,Cuchar}}(x + 1)
    f === :to_port && return Ptr{Cuchar}(x + 6)
    f === :type && return Ptr{Cuchar}(x + 7)
    return getfield(x, f)
end

function Base.getproperty(x::hipGraphEdgeData, f::Symbol)
    r = Ref{hipGraphEdgeData}(x)
    ptr = Base.unsafe_convert(Ptr{hipGraphEdgeData}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipGraphEdgeData}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipGraphEdgeData, private::Bool=false)
    return (:from_port, :reserved, :to_port, :type, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipLaunchConfig_st
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{hipLaunchConfig_st}, f::Symbol)
    f === :gridDim && return Ptr{dim3}(x + 0)
    f === :blockDim && return Ptr{dim3}(x + 12)
    f === :dynamicSmemBytes && return Ptr{Csize_t}(x + 24)
    f === :stream && return Ptr{hipStream_t}(x + 32)
    f === :attrs && return Ptr{Ptr{hipLaunchAttribute}}(x + 40)
    f === :numAttrs && return Ptr{Cuint}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::hipLaunchConfig_st, f::Symbol)
    r = Ref{hipLaunchConfig_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipLaunchConfig_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipLaunchConfig_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipLaunchConfig_st, private::Bool=false)
    return (:gridDim, :blockDim, :dynamicSmemBytes, :stream, :attrs, :numAttrs,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const hipLaunchConfig_t = hipLaunchConfig_st

struct HIP_LAUNCH_CONFIG_st
    data::NTuple{56,UInt8}
end

function Base.getproperty(x::Ptr{HIP_LAUNCH_CONFIG_st}, f::Symbol)
    f === :gridDimX && return Ptr{Cuint}(x + 0)
    f === :gridDimY && return Ptr{Cuint}(x + 4)
    f === :gridDimZ && return Ptr{Cuint}(x + 8)
    f === :blockDimX && return Ptr{Cuint}(x + 12)
    f === :blockDimY && return Ptr{Cuint}(x + 16)
    f === :blockDimZ && return Ptr{Cuint}(x + 20)
    f === :sharedMemBytes && return Ptr{Cuint}(x + 24)
    f === :hStream && return Ptr{hipStream_t}(x + 32)
    f === :attrs && return Ptr{Ptr{hipLaunchAttribute}}(x + 40)
    f === :numAttrs && return Ptr{Cuint}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::HIP_LAUNCH_CONFIG_st, f::Symbol)
    r = Ref{HIP_LAUNCH_CONFIG_st}(x)
    ptr = Base.unsafe_convert(Ptr{HIP_LAUNCH_CONFIG_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{HIP_LAUNCH_CONFIG_st}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::HIP_LAUNCH_CONFIG_st, private::Bool=false)
    return (:gridDimX, :gridDimY, :gridDimZ, :blockDimX, :blockDimY, :blockDimZ,
            :sharedMemBytes, :hStream, :attrs, :numAttrs, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

const HIP_LAUNCH_CONFIG = HIP_LAUNCH_CONFIG_st

@cenum hipMemRangeHandleType::UInt32 begin
    hipMemRangeHandleTypeDmaBufFd = 1
    hipMemRangeHandleTypeMax = 2147483647
end

@cenum hipMemRangeFlags::UInt32 begin
    hipMemRangeFlagDmaBufMappingTypePcie = 1
    hipMemRangeFlagsMax = 2147483647
end

function hipInit(flags)
    @check @gcsafe_ccall(libhip.hipInit(flags::Cuint)::hipError_t)
end

function hipDriverGetVersion(driverVersion)
    @check @gcsafe_ccall(libhip.hipDriverGetVersion(driverVersion::Ptr{Cint})::hipError_t)
end

function hipRuntimeGetVersion(runtimeVersion)
    @check @gcsafe_ccall(libhip.hipRuntimeGetVersion(runtimeVersion::Ptr{Cint})::hipError_t)
end

function hipDeviceGet(device, ordinal)
    @check @gcsafe_ccall(libhip.hipDeviceGet(device::Ptr{hipDevice_t},
                                             ordinal::Cint)::hipError_t)
end

function hipDeviceComputeCapability(major, minor, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceComputeCapability(major::Ptr{Cint},
                                                           minor::Ptr{Cint},
                                                           device::hipDevice_t)::hipError_t)
end

function hipDeviceGetName(name, len, device)
    @check @gcsafe_ccall(libhip.hipDeviceGetName(name::Cstring, len::Cint,
                                                 device::hipDevice_t)::hipError_t)
end

function hipDeviceGetUuid(uuid, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetUuid(uuid::Ptr{hipUUID},
                                                 device::hipDevice_t)::hipError_t)
end

function hipDeviceGetP2PAttribute(value, attr, srcDevice, dstDevice)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetP2PAttribute(value::Ptr{Cint},
                                                         attr::hipDeviceP2PAttr,
                                                         srcDevice::Cint,
                                                         dstDevice::Cint)::hipError_t)
end

function hipDeviceGetPCIBusId(pciBusId, len, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetPCIBusId(pciBusId::Cstring, len::Cint,
                                                     device::Cint)::hipError_t)
end

function hipDeviceGetByPCIBusId(device, pciBusId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetByPCIBusId(device::Ptr{Cint},
                                                       pciBusId::Cstring)::hipError_t)
end

function hipDeviceTotalMem(bytes, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceTotalMem(bytes::Ptr{Csize_t},
                                                  device::hipDevice_t)::hipError_t)
end

function hipDeviceSynchronize()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSynchronize()::hipError_t)
end

function hipDeviceReset()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceReset()::hipError_t)
end

function hipSetDevice(deviceId)
    @check @gcsafe_ccall(libhip.hipSetDevice(deviceId::Cint)::hipError_t)
end

function hipSetValidDevices(device_arr, len)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipSetValidDevices(device_arr::Ptr{Cint},
                                                   len::Cint)::hipError_t)
end

function hipGetDevice(deviceId)
    @check @gcsafe_ccall(libhip.hipGetDevice(deviceId::Ptr{Cint})::hipError_t)
end

function hipGetDeviceCount(count)
    @check @gcsafe_ccall(libhip.hipGetDeviceCount(count::Ptr{Cint})::hipError_t)
end

function hipDeviceGetAttribute(pi, attr, deviceId)
    @check @gcsafe_ccall(libhip.hipDeviceGetAttribute(pi::Ptr{Cint},
                                                      attr::hipDeviceAttribute_t,
                                                      deviceId::Cint)::hipError_t)
end

function hipDeviceGetDefaultMemPool(mem_pool, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetDefaultMemPool(mem_pool::Ptr{hipMemPool_t},
                                                           device::Cint)::hipError_t)
end

function hipDeviceSetMemPool(device, mem_pool)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSetMemPool(device::Cint,
                                                    mem_pool::hipMemPool_t)::hipError_t)
end

function hipDeviceGetMemPool(mem_pool, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetMemPool(mem_pool::Ptr{hipMemPool_t},
                                                    device::Cint)::hipError_t)
end

function hipDeviceGetTexture1DLinearMaxWidth(max_width, desc, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetTexture1DLinearMaxWidth(max_width::Ptr{Csize_t},
                                                                    desc::Ptr{hipChannelFormatDesc},
                                                                    device::Cint)::hipError_t)
end

function hipDeviceSetCacheConfig(cacheConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSetCacheConfig(cacheConfig::hipFuncCache_t)::hipError_t)
end

function hipDeviceGetCacheConfig(cacheConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetCacheConfig(cacheConfig::Ptr{hipFuncCache_t})::hipError_t)
end

function hipDeviceGetLimit(pValue, limit)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetLimit(pValue::Ptr{Csize_t},
                                                  limit::hipLimit_t)::hipError_t)
end

function hipDeviceSetLimit(limit, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSetLimit(limit::hipLimit_t,
                                                  value::Csize_t)::hipError_t)
end

function hipDeviceGetSharedMemConfig(pConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetSharedMemConfig(pConfig::Ptr{hipSharedMemConfig})::hipError_t)
end

function hipGetDeviceFlags(flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetDeviceFlags(flags::Ptr{Cuint})::hipError_t)
end

function hipDeviceSetSharedMemConfig(config)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSetSharedMemConfig(config::hipSharedMemConfig)::hipError_t)
end

function hipSetDeviceFlags(flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipSetDeviceFlags(flags::Cuint)::hipError_t)
end

function hipExtGetLinkTypeAndHopCount(device1, device2, linktype, hopcount)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtGetLinkTypeAndHopCount(device1::Cint, device2::Cint,
                                                             linktype::Ptr{UInt32},
                                                             hopcount::Ptr{UInt32})::hipError_t)
end

function hipIpcGetMemHandle(handle, devPtr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipIpcGetMemHandle(handle::Ptr{hipIpcMemHandle_t},
                                                   devPtr::Ptr{Cvoid})::hipError_t)
end

function hipIpcOpenMemHandle(devPtr, handle, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipIpcOpenMemHandle(devPtr::Ptr{Ptr{Cvoid}},
                                                    handle::hipIpcMemHandle_t,
                                                    flags::Cuint)::hipError_t)
end

function hipIpcCloseMemHandle(devPtr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipIpcCloseMemHandle(devPtr::Ptr{Cvoid})::hipError_t)
end

function hipIpcGetEventHandle(handle, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipIpcGetEventHandle(handle::Ptr{hipIpcEventHandle_t},
                                                     event::hipEvent_t)::hipError_t)
end

function hipIpcOpenEventHandle(event, handle)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipIpcOpenEventHandle(event::Ptr{hipEvent_t},
                                                      handle::hipIpcEventHandle_t)::hipError_t)
end

function hipFuncSetAttribute(func, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFuncSetAttribute(func::Ptr{Cvoid},
                                                    attr::hipFuncAttribute,
                                                    value::Cint)::hipError_t)
end

function hipFuncSetCacheConfig(func, config)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFuncSetCacheConfig(func::Ptr{Cvoid},
                                                      config::hipFuncCache_t)::hipError_t)
end

function hipFuncSetSharedMemConfig(func, config)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFuncSetSharedMemConfig(func::Ptr{Cvoid},
                                                          config::hipSharedMemConfig)::hipError_t)
end

function hipGetLastError()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetLastError()::hipError_t)
end

function hipExtGetLastError()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtGetLastError()::hipError_t)
end

function hipPeekAtLastError()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipPeekAtLastError()::hipError_t)
end

function hipGetErrorName(hip_error)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetErrorName(hip_error::hipError_t)::Cstring)
end

function hipGetErrorString(hipError)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetErrorString(hipError::hipError_t)::Cstring)
end

function hipDrvGetErrorName(hipError, errorString)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGetErrorName(hipError::hipError_t,
                                                   errorString::Ptr{Cstring})::hipError_t)
end

function hipDrvGetErrorString(hipError, errorString)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGetErrorString(hipError::hipError_t,
                                                     errorString::Ptr{Cstring})::hipError_t)
end

function hipStreamCreate(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamCreate(stream::Ptr{hipStream_t})::hipError_t)
end

function hipStreamCreateWithFlags(stream, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamCreateWithFlags(stream::Ptr{hipStream_t},
                                                         flags::Cuint)::hipError_t)
end

function hipStreamCreateWithPriority(stream, flags, priority)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamCreateWithPriority(stream::Ptr{hipStream_t},
                                                            flags::Cuint,
                                                            priority::Cint)::hipError_t)
end

function hipDeviceGetStreamPriorityRange(leastPriority, greatestPriority)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetStreamPriorityRange(leastPriority::Ptr{Cint},
                                                                greatestPriority::Ptr{Cint})::hipError_t)
end

function hipStreamDestroy(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamDestroy(stream::hipStream_t)::hipError_t)
end

function hipStreamQuery(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamQuery(stream::hipStream_t)::hipError_t)
end

function hipStreamSynchronize(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t)
end

function hipStreamWaitEvent(stream, event, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWaitEvent(stream::hipStream_t, event::hipEvent_t,
                                                   flags::Cuint)::hipError_t)
end

function hipStreamGetFlags(stream, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetFlags(stream::hipStream_t,
                                                  flags::Ptr{Cuint})::hipError_t)
end

function hipStreamGetId(stream, streamId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetId(stream::hipStream_t,
                                               streamId::Ptr{Culonglong})::hipError_t)
end

function hipStreamGetPriority(stream, priority)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetPriority(stream::hipStream_t,
                                                     priority::Ptr{Cint})::hipError_t)
end

function hipStreamGetDevice(stream, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetDevice(stream::hipStream_t,
                                                   device::Ptr{hipDevice_t})::hipError_t)
end

function hipExtStreamCreateWithCUMask(stream, cuMaskSize, cuMask)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtStreamCreateWithCUMask(stream::Ptr{hipStream_t},
                                                             cuMaskSize::UInt32,
                                                             cuMask::Ptr{UInt32})::hipError_t)
end

function hipExtStreamGetCUMask(stream, cuMaskSize, cuMask)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtStreamGetCUMask(stream::hipStream_t,
                                                      cuMaskSize::UInt32,
                                                      cuMask::Ptr{UInt32})::hipError_t)
end

# typedef void ( * hipStreamCallback_t ) ( hipStream_t stream , hipError_t status , void * userData )
const hipStreamCallback_t = Ptr{Cvoid}

function hipStreamAddCallback(stream, callback, userData, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamAddCallback(stream::hipStream_t,
                                                     callback::hipStreamCallback_t,
                                                     userData::Ptr{Cvoid},
                                                     flags::Cuint)::hipError_t)
end

function hipStreamSetAttribute(stream, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamSetAttribute(stream::hipStream_t,
                                                      attr::hipLaunchAttributeID,
                                                      value::Ptr{hipLaunchAttributeValue})::hipError_t)
end

function hipStreamGetAttribute(stream, attr, value_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetAttribute(stream::hipStream_t,
                                                      attr::hipLaunchAttributeID,
                                                      value_out::Ptr{hipLaunchAttributeValue})::hipError_t)
end

function hipStreamCopyAttributes(dst, src)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamCopyAttributes(dst::hipStream_t,
                                                        src::hipStream_t)::hipError_t)
end

function hipStreamWaitValue32(stream, ptr, value, flags, mask)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWaitValue32(stream::hipStream_t, ptr::Ptr{Cvoid},
                                                     value::UInt32, flags::Cuint,
                                                     mask::UInt32)::hipError_t)
end

function hipStreamWaitValue64(stream, ptr, value, flags, mask)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWaitValue64(stream::hipStream_t, ptr::Ptr{Cvoid},
                                                     value::UInt64, flags::Cuint,
                                                     mask::UInt64)::hipError_t)
end

function hipStreamWriteValue32(stream, ptr, value, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWriteValue32(stream::hipStream_t, ptr::Ptr{Cvoid},
                                                      value::UInt32,
                                                      flags::Cuint)::hipError_t)
end

function hipStreamWriteValue64(stream, ptr, value, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWriteValue64(stream::hipStream_t, ptr::Ptr{Cvoid},
                                                      value::UInt64,
                                                      flags::Cuint)::hipError_t)
end

function hipStreamBatchMemOp(stream, count, paramArray, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamBatchMemOp(stream::hipStream_t, count::Cuint,
                                                    paramArray::Ptr{hipStreamBatchMemOpParams},
                                                    flags::Cuint)::hipError_t)
end

function hipGraphAddBatchMemOpNode(phGraphNode, hGraph, dependencies, numDependencies,
                                   nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddBatchMemOpNode(phGraphNode::Ptr{hipGraphNode_t},
                                                          hGraph::hipGraph_t,
                                                          dependencies::Ptr{hipGraphNode_t},
                                                          numDependencies::Csize_t,
                                                          nodeParams::Ptr{hipBatchMemOpNodeParams})::hipError_t)
end

function hipGraphBatchMemOpNodeGetParams(hNode, nodeParams_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphBatchMemOpNodeGetParams(hNode::hipGraphNode_t,
                                                                nodeParams_out::Ptr{hipBatchMemOpNodeParams})::hipError_t)
end

function hipGraphBatchMemOpNodeSetParams(hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphBatchMemOpNodeSetParams(hNode::hipGraphNode_t,
                                                                nodeParams::Ptr{hipBatchMemOpNodeParams})::hipError_t)
end

function hipGraphExecBatchMemOpNodeSetParams(hGraphExec, hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecBatchMemOpNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                    hNode::hipGraphNode_t,
                                                                    nodeParams::Ptr{hipBatchMemOpNodeParams})::hipError_t)
end

function hipEventCreateWithFlags(event, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventCreateWithFlags(event::Ptr{hipEvent_t},
                                                        flags::Cuint)::hipError_t)
end

function hipEventCreate(event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventCreate(event::Ptr{hipEvent_t})::hipError_t)
end

function hipEventRecordWithFlags(event, stream, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventRecordWithFlags(event::hipEvent_t,
                                                        stream::hipStream_t,
                                                        flags::Cuint)::hipError_t)
end

function hipEventRecord(event, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventRecord(event::hipEvent_t,
                                               stream::hipStream_t)::hipError_t)
end

function hipEventDestroy(event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventDestroy(event::hipEvent_t)::hipError_t)
end

function hipEventSynchronize(event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventSynchronize(event::hipEvent_t)::hipError_t)
end

function hipEventElapsedTime(ms, start, stop)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventElapsedTime(ms::Ptr{Cfloat}, start::hipEvent_t,
                                                    stop::hipEvent_t)::hipError_t)
end

function hipEventQuery(event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventQuery(event::hipEvent_t)::hipError_t)
end

function hipPointerSetAttribute(value, attribute, ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipPointerSetAttribute(value::Ptr{Cvoid},
                                                       attribute::hipPointer_attribute,
                                                       ptr::hipDeviceptr_t)::hipError_t)
end

function hipPointerGetAttributes(attributes, ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipPointerGetAttributes(attributes::Ptr{hipPointerAttribute_t},
                                                        ptr::Ptr{Cvoid})::hipError_t)
end

function hipPointerGetAttribute(data, attribute, ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipPointerGetAttribute(data::Ptr{Cvoid},
                                                       attribute::hipPointer_attribute,
                                                       ptr::hipDeviceptr_t)::hipError_t)
end

function hipDrvPointerGetAttributes(numAttributes, attributes, data, ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvPointerGetAttributes(numAttributes::Cuint,
                                                           attributes::Ptr{hipPointer_attribute},
                                                           data::Ptr{Ptr{Cvoid}},
                                                           ptr::hipDeviceptr_t)::hipError_t)
end

function hipImportExternalSemaphore(extSem_out, semHandleDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipImportExternalSemaphore(extSem_out::Ptr{hipExternalSemaphore_t},
                                                           semHandleDesc::Ptr{hipExternalSemaphoreHandleDesc})::hipError_t)
end

function hipSignalExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipSignalExternalSemaphoresAsync(extSemArray::Ptr{hipExternalSemaphore_t},
                                                                 paramsArray::Ptr{hipExternalSemaphoreSignalParams},
                                                                 numExtSems::Cuint,
                                                                 stream::hipStream_t)::hipError_t)
end

function hipWaitExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipWaitExternalSemaphoresAsync(extSemArray::Ptr{hipExternalSemaphore_t},
                                                               paramsArray::Ptr{hipExternalSemaphoreWaitParams},
                                                               numExtSems::Cuint,
                                                               stream::hipStream_t)::hipError_t)
end

function hipDestroyExternalSemaphore(extSem)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDestroyExternalSemaphore(extSem::hipExternalSemaphore_t)::hipError_t)
end

function hipImportExternalMemory(extMem_out, memHandleDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipImportExternalMemory(extMem_out::Ptr{hipExternalMemory_t},
                                                        memHandleDesc::Ptr{hipExternalMemoryHandleDesc})::hipError_t)
end

function hipExternalMemoryGetMappedBuffer(devPtr, extMem, bufferDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExternalMemoryGetMappedBuffer(devPtr::Ptr{Ptr{Cvoid}},
                                                                 extMem::hipExternalMemory_t,
                                                                 bufferDesc::Ptr{hipExternalMemoryBufferDesc})::hipError_t)
end

function hipDestroyExternalMemory(extMem)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDestroyExternalMemory(extMem::hipExternalMemory_t)::hipError_t)
end

function hipExternalMemoryGetMappedMipmappedArray(mipmap, extMem, mipmapDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExternalMemoryGetMappedMipmappedArray(mipmap::Ptr{hipMipmappedArray_t},
                                                                         extMem::hipExternalMemory_t,
                                                                         mipmapDesc::Ptr{hipExternalMemoryMipmappedArrayDesc})::hipError_t)
end

function hipMalloc(ptr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::hipError_t)
end

function hipExtMallocWithFlags(ptr, sizeBytes, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtMallocWithFlags(ptr::Ptr{Ptr{Cvoid}},
                                                      sizeBytes::Csize_t,
                                                      flags::Cuint)::hipError_t)
end

function hipMallocHost(ptr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocHost(ptr::Ptr{Ptr{Cvoid}},
                                              size::Csize_t)::hipError_t)
end

function hipMemAllocHost(ptr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAllocHost(ptr::Ptr{Ptr{Cvoid}},
                                                size::Csize_t)::hipError_t)
end

function hipHostMalloc(ptr, size, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t,
                                              flags::Cuint)::hipError_t)
end

function hipMallocManaged(dev_ptr, size, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocManaged(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t,
                                                 flags::Cuint)::hipError_t)
end

function hipMemPrefetchAsync(dev_ptr, count, device, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPrefetchAsync(dev_ptr::Ptr{Cvoid}, count::Csize_t,
                                                    device::Cint,
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemPrefetchAsync_v2(dev_ptr, count, location, flags, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPrefetchAsync_v2(dev_ptr::Ptr{Cvoid}, count::Csize_t,
                                                       location::hipMemLocation,
                                                       flags::Cuint,
                                                       stream::hipStream_t)::hipError_t)
end

function hipMemAdvise(dev_ptr, count, advice, device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAdvise(dev_ptr::Ptr{Cvoid}, count::Csize_t,
                                             advice::hipMemoryAdvise,
                                             device::Cint)::hipError_t)
end

function hipMemAdvise_v2(dev_ptr, count, advice, location)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAdvise_v2(dev_ptr::Ptr{Cvoid}, count::Csize_t,
                                                advice::hipMemoryAdvise,
                                                location::hipMemLocation)::hipError_t)
end

function hipMemRangeGetAttribute(data, data_size, attribute, dev_ptr, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemRangeGetAttribute(data::Ptr{Cvoid},
                                                        data_size::Csize_t,
                                                        attribute::hipMemRangeAttribute,
                                                        dev_ptr::Ptr{Cvoid},
                                                        count::Csize_t)::hipError_t)
end

function hipMemRangeGetAttributes(data, data_sizes, attributes, num_attributes, dev_ptr,
                                  count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemRangeGetAttributes(data::Ptr{Ptr{Cvoid}},
                                                         data_sizes::Ptr{Csize_t},
                                                         attributes::Ptr{hipMemRangeAttribute},
                                                         num_attributes::Csize_t,
                                                         dev_ptr::Ptr{Cvoid},
                                                         count::Csize_t)::hipError_t)
end

function hipStreamAttachMemAsync(stream, dev_ptr, length, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamAttachMemAsync(stream::hipStream_t,
                                                        dev_ptr::Ptr{Cvoid},
                                                        length::Csize_t,
                                                        flags::Cuint)::hipError_t)
end

function hipMallocAsync(dev_ptr, size, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocAsync(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t,
                                               stream::hipStream_t)::hipError_t)
end

function hipFreeAsync(dev_ptr, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFreeAsync(dev_ptr::Ptr{Cvoid},
                                             stream::hipStream_t)::hipError_t)
end

function hipMemPoolTrimTo(mem_pool, min_bytes_to_hold)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolTrimTo(mem_pool::hipMemPool_t,
                                                 min_bytes_to_hold::Csize_t)::hipError_t)
end

function hipMemPoolSetAttribute(mem_pool, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolSetAttribute(mem_pool::hipMemPool_t,
                                                       attr::hipMemPoolAttr,
                                                       value::Ptr{Cvoid})::hipError_t)
end

function hipMemPoolGetAttribute(mem_pool, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolGetAttribute(mem_pool::hipMemPool_t,
                                                       attr::hipMemPoolAttr,
                                                       value::Ptr{Cvoid})::hipError_t)
end

function hipMemPoolSetAccess(mem_pool, desc_list, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolSetAccess(mem_pool::hipMemPool_t,
                                                    desc_list::Ptr{hipMemAccessDesc},
                                                    count::Csize_t)::hipError_t)
end

function hipMemPoolGetAccess(flags, mem_pool, location)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolGetAccess(flags::Ptr{hipMemAccessFlags},
                                                    mem_pool::hipMemPool_t,
                                                    location::Ptr{hipMemLocation})::hipError_t)
end

function hipMemPoolCreate(mem_pool, pool_props)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolCreate(mem_pool::Ptr{hipMemPool_t},
                                                 pool_props::Ptr{hipMemPoolProps})::hipError_t)
end

function hipMemPoolDestroy(mem_pool)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolDestroy(mem_pool::hipMemPool_t)::hipError_t)
end

function hipMallocFromPoolAsync(dev_ptr, size, mem_pool, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocFromPoolAsync(dev_ptr::Ptr{Ptr{Cvoid}},
                                                       size::Csize_t,
                                                       mem_pool::hipMemPool_t,
                                                       stream::hipStream_t)::hipError_t)
end

function hipMemPoolExportToShareableHandle(shared_handle, mem_pool, handle_type, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolExportToShareableHandle(shared_handle::Ptr{Cvoid},
                                                                  mem_pool::hipMemPool_t,
                                                                  handle_type::hipMemAllocationHandleType,
                                                                  flags::Cuint)::hipError_t)
end

function hipMemPoolImportFromShareableHandle(mem_pool, shared_handle, handle_type, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolImportFromShareableHandle(mem_pool::Ptr{hipMemPool_t},
                                                                    shared_handle::Ptr{Cvoid},
                                                                    handle_type::hipMemAllocationHandleType,
                                                                    flags::Cuint)::hipError_t)
end

function hipMemPoolExportPointer(export_data, dev_ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolExportPointer(export_data::Ptr{hipMemPoolPtrExportData},
                                                        dev_ptr::Ptr{Cvoid})::hipError_t)
end

function hipMemPoolImportPointer(dev_ptr, mem_pool, export_data)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPoolImportPointer(dev_ptr::Ptr{Ptr{Cvoid}},
                                                        mem_pool::hipMemPool_t,
                                                        export_data::Ptr{hipMemPoolPtrExportData})::hipError_t)
end

function hipHostAlloc(ptr, size, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostAlloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t,
                                             flags::Cuint)::hipError_t)
end

function hipHostGetDevicePointer(devPtr, hstPtr, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostGetDevicePointer(devPtr::Ptr{Ptr{Cvoid}},
                                                        hstPtr::Ptr{Cvoid},
                                                        flags::Cuint)::hipError_t)
end

function hipHostGetFlags(flagsPtr, hostPtr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostGetFlags(flagsPtr::Ptr{Cuint},
                                                hostPtr::Ptr{Cvoid})::hipError_t)
end

function hipHostRegister(hostPtr, sizeBytes, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostRegister(hostPtr::Ptr{Cvoid}, sizeBytes::Csize_t,
                                                flags::Cuint)::hipError_t)
end

function hipHostUnregister(hostPtr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostUnregister(hostPtr::Ptr{Cvoid})::hipError_t)
end

function hipMallocPitch(ptr, pitch, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocPitch(ptr::Ptr{Ptr{Cvoid}}, pitch::Ptr{Csize_t},
                                               width::Csize_t, height::Csize_t)::hipError_t)
end

function hipMemAllocPitch(dptr, pitch, widthInBytes, height, elementSizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAllocPitch(dptr::Ptr{hipDeviceptr_t},
                                                 pitch::Ptr{Csize_t}, widthInBytes::Csize_t,
                                                 height::Csize_t,
                                                 elementSizeBytes::Cuint)::hipError_t)
end

function hipFree(ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFree(ptr::Ptr{Cvoid})::hipError_t)
end

function hipFreeHost(ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFreeHost(ptr::Ptr{Cvoid})::hipError_t)
end

function hipHostFree(ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipHostFree(ptr::Ptr{Cvoid})::hipError_t)
end

function hipMemcpy(dst, src, sizeBytes, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy(dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                          sizeBytes::Csize_t,
                                          kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyWithStream(dst, src, sizeBytes, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyWithStream(dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                    sizeBytes::Csize_t, kind::hipMemcpyKind,
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemcpyHtoD(dst, src, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyHtoD(dst::hipDeviceptr_t, src::Ptr{Cvoid},
                                              sizeBytes::Csize_t)::hipError_t)
end

function hipMemcpyDtoH(dst, src, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyDtoH(dst::Ptr{Cvoid}, src::hipDeviceptr_t,
                                              sizeBytes::Csize_t)::hipError_t)
end

function hipMemcpyDtoD(dst, src, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyDtoD(dst::hipDeviceptr_t, src::hipDeviceptr_t,
                                              sizeBytes::Csize_t)::hipError_t)
end

function hipMemcpyAtoD(dstDevice, srcArray, srcOffset, ByteCount)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAtoD(dstDevice::hipDeviceptr_t,
                                              srcArray::hipArray_t, srcOffset::Csize_t,
                                              ByteCount::Csize_t)::hipError_t)
end

function hipMemcpyDtoA(dstArray, dstOffset, srcDevice, ByteCount)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyDtoA(dstArray::hipArray_t, dstOffset::Csize_t,
                                              srcDevice::hipDeviceptr_t,
                                              ByteCount::Csize_t)::hipError_t)
end

function hipMemcpyAtoA(dstArray, dstOffset, srcArray, srcOffset, ByteCount)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAtoA(dstArray::hipArray_t, dstOffset::Csize_t,
                                              srcArray::hipArray_t, srcOffset::Csize_t,
                                              ByteCount::Csize_t)::hipError_t)
end

function hipMemcpyHtoDAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyHtoDAsync(dst::hipDeviceptr_t, src::Ptr{Cvoid},
                                                   sizeBytes::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemcpyDtoHAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyDtoHAsync(dst::Ptr{Cvoid}, src::hipDeviceptr_t,
                                                   sizeBytes::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemcpyDtoDAsync(dst, src, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyDtoDAsync(dst::hipDeviceptr_t, src::hipDeviceptr_t,
                                                   sizeBytes::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemcpyAtoHAsync(dstHost, srcArray, srcOffset, ByteCount, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAtoHAsync(dstHost::Ptr{Cvoid},
                                                   srcArray::hipArray_t, srcOffset::Csize_t,
                                                   ByteCount::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemcpyHtoAAsync(dstArray, dstOffset, srcHost, ByteCount, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyHtoAAsync(dstArray::hipArray_t, dstOffset::Csize_t,
                                                   srcHost::Ptr{Cvoid}, ByteCount::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipModuleGetGlobal(dptr, bytes, hmod, name)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleGetGlobal(dptr::Ptr{hipDeviceptr_t},
                                                   bytes::Ptr{Csize_t}, hmod::hipModule_t,
                                                   name::Cstring)::hipError_t)
end

function hipGetSymbolAddress(devPtr, symbol)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetSymbolAddress(devPtr::Ptr{Ptr{Cvoid}},
                                                    symbol::Ptr{Cvoid})::hipError_t)
end

function hipGetSymbolSize(size, symbol)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetSymbolSize(size::Ptr{Csize_t},
                                                 symbol::Ptr{Cvoid})::hipError_t)
end

function hipGetProcAddress(symbol, pfn, hipVersion, flags, symbolStatus)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetProcAddress(symbol::Cstring, pfn::Ptr{Ptr{Cvoid}},
                                                  hipVersion::Cint, flags::UInt64,
                                                  symbolStatus::Ptr{hipDriverProcAddressQueryResult})::hipError_t)
end

function hipMemcpyToSymbol(symbol, src, sizeBytes, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyToSymbol(symbol::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                  sizeBytes::Csize_t, offset::Csize_t,
                                                  kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyToSymbolAsync(symbol, src, sizeBytes, offset, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyToSymbolAsync(symbol::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                       sizeBytes::Csize_t, offset::Csize_t,
                                                       kind::hipMemcpyKind,
                                                       stream::hipStream_t)::hipError_t)
end

function hipMemcpyFromSymbol(dst, symbol, sizeBytes, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromSymbol(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid},
                                                    sizeBytes::Csize_t, offset::Csize_t,
                                                    kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyFromSymbolAsync(dst, symbol, sizeBytes, offset, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromSymbolAsync(dst::Ptr{Cvoid},
                                                         symbol::Ptr{Cvoid},
                                                         sizeBytes::Csize_t,
                                                         offset::Csize_t,
                                                         kind::hipMemcpyKind,
                                                         stream::hipStream_t)::hipError_t)
end

function hipMemcpyAsync(dst, src, sizeBytes, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                               sizeBytes::Csize_t, kind::hipMemcpyKind,
                                               stream::hipStream_t)::hipError_t)
end

function hipMemset(dst, value, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset(dst::Ptr{Cvoid}, value::Cint,
                                          sizeBytes::Csize_t)::hipError_t)
end

function hipMemsetD8(dest, value, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD8(dest::hipDeviceptr_t, value::Cuchar,
                                            count::Csize_t)::hipError_t)
end

function hipMemsetD8Async(dest, value, count, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD8Async(dest::hipDeviceptr_t, value::Cuchar,
                                                 count::Csize_t,
                                                 stream::hipStream_t)::hipError_t)
end

function hipMemsetD16(dest, value, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD16(dest::hipDeviceptr_t, value::Cushort,
                                             count::Csize_t)::hipError_t)
end

function hipMemsetD16Async(dest, value, count, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD16Async(dest::hipDeviceptr_t, value::Cushort,
                                                  count::Csize_t,
                                                  stream::hipStream_t)::hipError_t)
end

function hipMemsetD32(dest, value, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD32(dest::hipDeviceptr_t, value::Cint,
                                             count::Csize_t)::hipError_t)
end

function hipMemsetAsync(dst, value, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetAsync(dst::Ptr{Cvoid}, value::Cint,
                                               sizeBytes::Csize_t,
                                               stream::hipStream_t)::hipError_t)
end

function hipMemsetD32Async(dst, value, count, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD32Async(dst::hipDeviceptr_t, value::Cint,
                                                  count::Csize_t,
                                                  stream::hipStream_t)::hipError_t)
end

function hipMemset2D(dst, pitch, value, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset2D(dst::Ptr{Cvoid}, pitch::Csize_t, value::Cint,
                                            width::Csize_t, height::Csize_t)::hipError_t)
end

function hipMemset2DAsync(dst, pitch, value, width, height, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset2DAsync(dst::Ptr{Cvoid}, pitch::Csize_t,
                                                 value::Cint, width::Csize_t,
                                                 height::Csize_t,
                                                 stream::hipStream_t)::hipError_t)
end

function hipMemset3D(pitchedDevPtr, value, extent)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset3D(pitchedDevPtr::hipPitchedPtr, value::Cint,
                                            extent::hipExtent)::hipError_t)
end

function hipMemset3DAsync(pitchedDevPtr, value, extent, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset3DAsync(pitchedDevPtr::hipPitchedPtr, value::Cint,
                                                 extent::hipExtent,
                                                 stream::hipStream_t)::hipError_t)
end

function hipMemsetD2D8(dst, dstPitch, value, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D8(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                              value::Cuchar, width::Csize_t,
                                              height::Csize_t)::hipError_t)
end

function hipMemsetD2D8Async(dst, dstPitch, value, width, height, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D8Async(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                                   value::Cuchar, width::Csize_t,
                                                   height::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemsetD2D16(dst, dstPitch, value, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D16(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                               value::Cushort, width::Csize_t,
                                               height::Csize_t)::hipError_t)
end

function hipMemsetD2D16Async(dst, dstPitch, value, width, height, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D16Async(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                                    value::Cushort, width::Csize_t,
                                                    height::Csize_t,
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemsetD2D32(dst, dstPitch, value, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D32(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                               value::Cuint, width::Csize_t,
                                               height::Csize_t)::hipError_t)
end

function hipMemsetD2D32Async(dst, dstPitch, value, width, height, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetD2D32Async(dst::hipDeviceptr_t, dstPitch::Csize_t,
                                                    value::Cuint, width::Csize_t,
                                                    height::Csize_t,
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemGetInfo(free, total)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetInfo(free::Ptr{Csize_t},
                                              total::Ptr{Csize_t})::hipError_t)
end

function hipMemPtrGetInfo(ptr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemPtrGetInfo(ptr::Ptr{Cvoid},
                                                 size::Ptr{Csize_t})::hipError_t)
end

function hipMallocArray(array, desc, width, height, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocArray(array::Ptr{hipArray_t},
                                               desc::Ptr{hipChannelFormatDesc},
                                               width::Csize_t, height::Csize_t,
                                               flags::Cuint)::hipError_t)
end

function hipArrayCreate(pHandle, pAllocateArray)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArrayCreate(pHandle::Ptr{hipArray_t},
                                               pAllocateArray::Ptr{HIP_ARRAY_DESCRIPTOR})::hipError_t)
end

function hipArrayDestroy(array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArrayDestroy(array::hipArray_t)::hipError_t)
end

function hipArray3DCreate(array, pAllocateArray)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArray3DCreate(array::Ptr{hipArray_t},
                                                 pAllocateArray::Ptr{HIP_ARRAY3D_DESCRIPTOR})::hipError_t)
end

function hipMalloc3D(pitchedDevPtr, extent)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMalloc3D(pitchedDevPtr::Ptr{hipPitchedPtr},
                                            extent::hipExtent)::hipError_t)
end

function hipFreeArray(array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFreeArray(array::hipArray_t)::hipError_t)
end

function hipMalloc3DArray(array, desc, extent, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMalloc3DArray(array::Ptr{hipArray_t},
                                                 desc::Ptr{hipChannelFormatDesc},
                                                 extent::hipExtent,
                                                 flags::Cuint)::hipError_t)
end

function hipArrayGetInfo(desc, extent, flags, array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArrayGetInfo(desc::Ptr{hipChannelFormatDesc},
                                                extent::Ptr{hipExtent}, flags::Ptr{Cuint},
                                                array::hipArray_t)::hipError_t)
end

function hipArrayGetDescriptor(pArrayDescriptor, array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArrayGetDescriptor(pArrayDescriptor::Ptr{HIP_ARRAY_DESCRIPTOR},
                                                      array::hipArray_t)::hipError_t)
end

function hipArray3DGetDescriptor(pArrayDescriptor, array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipArray3DGetDescriptor(pArrayDescriptor::Ptr{HIP_ARRAY3D_DESCRIPTOR},
                                                        array::hipArray_t)::hipError_t)
end

function hipMemcpy2D(dst, dpitch, src, spitch, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2D(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                            src::Ptr{Cvoid}, spitch::Csize_t,
                                            width::Csize_t, height::Csize_t,
                                            kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyParam2D(pCopy)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyParam2D(pCopy::Ptr{hip_Memcpy2D})::hipError_t)
end

function hipMemcpyParam2DAsync(pCopy, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyParam2DAsync(pCopy::Ptr{hip_Memcpy2D},
                                                      stream::hipStream_t)::hipError_t)
end

function hipMemcpy2DAsync(dst, dpitch, src, spitch, width, height, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DAsync(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                 src::Ptr{Cvoid}, spitch::Csize_t,
                                                 width::Csize_t, height::Csize_t,
                                                 kind::hipMemcpyKind,
                                                 stream::hipStream_t)::hipError_t)
end

function hipMemcpy2DToArray(dst, wOffset, hOffset, src, spitch, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DToArray(dst::hipArray_t, wOffset::Csize_t,
                                                   hOffset::Csize_t, src::Ptr{Cvoid},
                                                   spitch::Csize_t, width::Csize_t,
                                                   height::Csize_t,
                                                   kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DToArrayAsync(dst, wOffset, hOffset, src, spitch, width, height, kind,
                                 stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DToArrayAsync(dst::hipArray_t, wOffset::Csize_t,
                                                        hOffset::Csize_t, src::Ptr{Cvoid},
                                                        spitch::Csize_t, width::Csize_t,
                                                        height::Csize_t,
                                                        kind::hipMemcpyKind,
                                                        stream::hipStream_t)::hipError_t)
end

function hipMemcpy2DArrayToArray(dst, wOffsetDst, hOffsetDst, src, wOffsetSrc, hOffsetSrc,
                                 width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DArrayToArray(dst::hipArray_t,
                                                        wOffsetDst::Csize_t,
                                                        hOffsetDst::Csize_t,
                                                        src::hipArray_const_t,
                                                        wOffsetSrc::Csize_t,
                                                        hOffsetSrc::Csize_t, width::Csize_t,
                                                        height::Csize_t,
                                                        kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyToArray(dst, wOffset, hOffset, src, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyToArray(dst::hipArray_t, wOffset::Csize_t,
                                                 hOffset::Csize_t, src::Ptr{Cvoid},
                                                 count::Csize_t,
                                                 kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyFromArray(dst, srcArray, wOffset, hOffset, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromArray(dst::Ptr{Cvoid},
                                                   srcArray::hipArray_const_t,
                                                   wOffset::Csize_t, hOffset::Csize_t,
                                                   count::Csize_t,
                                                   kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DFromArray(dst, dpitch, src, wOffset, hOffset, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DFromArray(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                     src::hipArray_const_t,
                                                     wOffset::Csize_t, hOffset::Csize_t,
                                                     width::Csize_t, height::Csize_t,
                                                     kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DFromArrayAsync(dst, dpitch, src, wOffset, hOffset, width, height, kind,
                                   stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DFromArrayAsync(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                          src::hipArray_const_t,
                                                          wOffset::Csize_t,
                                                          hOffset::Csize_t, width::Csize_t,
                                                          height::Csize_t,
                                                          kind::hipMemcpyKind,
                                                          stream::hipStream_t)::hipError_t)
end

function hipMemcpyAtoH(dst, srcArray, srcOffset, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAtoH(dst::Ptr{Cvoid}, srcArray::hipArray_t,
                                              srcOffset::Csize_t,
                                              count::Csize_t)::hipError_t)
end

function hipMemcpyHtoA(dstArray, dstOffset, srcHost, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyHtoA(dstArray::hipArray_t, dstOffset::Csize_t,
                                              srcHost::Ptr{Cvoid},
                                              count::Csize_t)::hipError_t)
end

function hipMemcpy3D(p)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3D(p::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipMemcpy3DAsync(p, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3DAsync(p::Ptr{hipMemcpy3DParms},
                                                 stream::hipStream_t)::hipError_t)
end

function hipDrvMemcpy3D(pCopy)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvMemcpy3D(pCopy::Ptr{HIP_MEMCPY3D})::hipError_t)
end

function hipDrvMemcpy3DAsync(pCopy, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvMemcpy3DAsync(pCopy::Ptr{HIP_MEMCPY3D},
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemGetAddressRange(pbase, psize, dptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetAddressRange(pbase::Ptr{hipDeviceptr_t},
                                                      psize::Ptr{Csize_t},
                                                      dptr::hipDeviceptr_t)::hipError_t)
end

function hipMemcpyBatchAsync(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx,
                             stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyBatchAsync(dsts::Ptr{Ptr{Cvoid}},
                                                    srcs::Ptr{Ptr{Cvoid}},
                                                    sizes::Ptr{Csize_t}, count::Csize_t,
                                                    attrs::Ptr{hipMemcpyAttributes},
                                                    attrsIdxs::Ptr{Csize_t},
                                                    numAttrs::Csize_t,
                                                    failIdx::Ptr{Csize_t},
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemcpy3DBatchAsync(numOps, opList, failIdx, flags, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3DBatchAsync(numOps::Csize_t,
                                                      opList::Ptr{hipMemcpy3DBatchOp},
                                                      failIdx::Ptr{Csize_t},
                                                      flags::Culonglong,
                                                      stream::hipStream_t)::hipError_t)
end

function hipMemcpy3DPeer(p)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3DPeer(p::Ptr{hipMemcpy3DPeerParms})::hipError_t)
end

function hipMemcpy3DPeerAsync(p, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3DPeerAsync(p::Ptr{hipMemcpy3DPeerParms},
                                                     stream::hipStream_t)::hipError_t)
end

function hipDeviceCanAccessPeer(canAccessPeer, deviceId, peerDeviceId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceCanAccessPeer(canAccessPeer::Ptr{Cint},
                                                       deviceId::Cint,
                                                       peerDeviceId::Cint)::hipError_t)
end

function hipDeviceEnablePeerAccess(peerDeviceId, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceEnablePeerAccess(peerDeviceId::Cint,
                                                          flags::Cuint)::hipError_t)
end

function hipDeviceDisablePeerAccess(peerDeviceId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceDisablePeerAccess(peerDeviceId::Cint)::hipError_t)
end

function hipMemcpyPeer(dst, dstDeviceId, src, srcDeviceId, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyPeer(dst::Ptr{Cvoid}, dstDeviceId::Cint,
                                              src::Ptr{Cvoid}, srcDeviceId::Cint,
                                              sizeBytes::Csize_t)::hipError_t)
end

function hipMemcpyPeerAsync(dst, dstDeviceId, src, srcDevice, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyPeerAsync(dst::Ptr{Cvoid}, dstDeviceId::Cint,
                                                   src::Ptr{Cvoid}, srcDevice::Cint,
                                                   sizeBytes::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipCtxCreate(ctx, flags, device)
    @check @gcsafe_ccall(libhip.hipCtxCreate(ctx::Ptr{hipCtx_t}, flags::Cuint,
                                             device::hipDevice_t)::hipError_t)
end

function hipCtxDestroy(ctx)
    @check @gcsafe_ccall(libhip.hipCtxDestroy(ctx::hipCtx_t)::hipError_t)
end

function hipCtxPopCurrent(ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxPopCurrent(ctx::Ptr{hipCtx_t})::hipError_t)
end

function hipCtxPushCurrent(ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxPushCurrent(ctx::hipCtx_t)::hipError_t)
end

function hipCtxSetCurrent(ctx)
    @check @gcsafe_ccall(libhip.hipCtxSetCurrent(ctx::hipCtx_t)::hipError_t)
end

function hipCtxGetCurrent(ctx)
    @check @gcsafe_ccall(libhip.hipCtxGetCurrent(ctx::Ptr{hipCtx_t})::hipError_t)
end

function hipCtxGetDevice(device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxGetDevice(device::Ptr{hipDevice_t})::hipError_t)
end

function hipCtxGetApiVersion(ctx, apiVersion)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxGetApiVersion(ctx::hipCtx_t,
                                                    apiVersion::Ptr{Cuint})::hipError_t)
end

function hipCtxGetCacheConfig(cacheConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxGetCacheConfig(cacheConfig::Ptr{hipFuncCache_t})::hipError_t)
end

function hipCtxSetCacheConfig(cacheConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxSetCacheConfig(cacheConfig::hipFuncCache_t)::hipError_t)
end

function hipCtxSetSharedMemConfig(config)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxSetSharedMemConfig(config::hipSharedMemConfig)::hipError_t)
end

function hipCtxGetSharedMemConfig(pConfig)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxGetSharedMemConfig(pConfig::Ptr{hipSharedMemConfig})::hipError_t)
end

function hipCtxSynchronize()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxSynchronize()::hipError_t)
end

function hipCtxGetFlags(flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxGetFlags(flags::Ptr{Cuint})::hipError_t)
end

function hipCtxEnablePeerAccess(peerCtx, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxEnablePeerAccess(peerCtx::hipCtx_t,
                                                       flags::Cuint)::hipError_t)
end

function hipCtxDisablePeerAccess(peerCtx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCtxDisablePeerAccess(peerCtx::hipCtx_t)::hipError_t)
end

function hipDevicePrimaryCtxGetState(dev, flags, active)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDevicePrimaryCtxGetState(dev::hipDevice_t,
                                                            flags::Ptr{Cuint},
                                                            active::Ptr{Cint})::hipError_t)
end

function hipDevicePrimaryCtxRelease(dev)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDevicePrimaryCtxRelease(dev::hipDevice_t)::hipError_t)
end

function hipDevicePrimaryCtxRetain(pctx, dev)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDevicePrimaryCtxRetain(pctx::Ptr{hipCtx_t},
                                                          dev::hipDevice_t)::hipError_t)
end

function hipDevicePrimaryCtxReset(dev)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDevicePrimaryCtxReset(dev::hipDevice_t)::hipError_t)
end

function hipDevicePrimaryCtxSetFlags(dev, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDevicePrimaryCtxSetFlags(dev::hipDevice_t,
                                                            flags::Cuint)::hipError_t)
end

function hipModuleLoadFatBinary(_module, fatbin)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLoadFatBinary(_module::Ptr{hipModule_t},
                                                       fatbin::Ptr{Cvoid})::hipError_t)
end

function hipModuleLoad(_module, fname)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLoad(_module::Ptr{hipModule_t},
                                              fname::Cstring)::hipError_t)
end

function hipModuleUnload(_module)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleUnload(_module::hipModule_t)::hipError_t)
end

function hipModuleGetFunction(_function, _module, kname)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleGetFunction(_function::Ptr{hipFunction_t},
                                                     _module::hipModule_t,
                                                     kname::Cstring)::hipError_t)
end

function hipModuleGetFunctionCount(count, mod)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleGetFunctionCount(count::Ptr{Cuint},
                                                          mod::hipModule_t)::hipError_t)
end

function hipLibraryLoadData(library, code, jitOptions, jitOptionsValues, numJitOptions,
                            libraryOptions, libraryOptionValues, numLibraryOptions)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryLoadData(library::Ptr{hipLibrary_t},
                                                   code::Ptr{Cvoid},
                                                   jitOptions::Ptr{hipJitOption},
                                                   jitOptionsValues::Ptr{Ptr{Cvoid}},
                                                   numJitOptions::Cuint,
                                                   libraryOptions::Ptr{hipLibraryOption},
                                                   libraryOptionValues::Ptr{Ptr{Cvoid}},
                                                   numLibraryOptions::Cuint)::hipError_t)
end

function hipLibraryLoadFromFile(library, fileName, jitOptions, jitOptionsValues,
                                numJitOptions, libraryOptions, libraryOptionValues,
                                numLibraryOptions)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryLoadFromFile(library::Ptr{hipLibrary_t},
                                                       fileName::Cstring,
                                                       jitOptions::Ptr{hipJitOption},
                                                       jitOptionsValues::Ptr{Ptr{Cvoid}},
                                                       numJitOptions::Cuint,
                                                       libraryOptions::Ptr{hipLibraryOption},
                                                       libraryOptionValues::Ptr{Ptr{Cvoid}},
                                                       numLibraryOptions::Cuint)::hipError_t)
end

function hipLibraryUnload(library)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryUnload(library::hipLibrary_t)::hipError_t)
end

function hipLibraryGetKernel(pKernel, library, name)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryGetKernel(pKernel::Ptr{hipKernel_t},
                                                    library::hipLibrary_t,
                                                    name::Cstring)::hipError_t)
end

function hipLibraryGetKernelCount(count, library)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryGetKernelCount(count::Ptr{Cuint},
                                                         library::hipLibrary_t)::hipError_t)
end

function hipLibraryEnumerateKernels(kernels, numKernels, library)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLibraryEnumerateKernels(kernels::Ptr{hipKernel_t},
                                                           numKernels::Cuint,
                                                           library::hipLibrary_t)::hipError_t)
end

function hipKernelGetLibrary(library, kernel)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipKernelGetLibrary(library::Ptr{hipLibrary_t},
                                                    kernel::hipKernel_t)::hipError_t)
end

function hipKernelGetName(name, kernel)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipKernelGetName(name::Ptr{Cstring},
                                                 kernel::hipKernel_t)::hipError_t)
end

function hipKernelGetParamInfo(kernel, paramIndex, paramOffset, paramSize)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipKernelGetParamInfo(kernel::hipKernel_t,
                                                      paramIndex::Csize_t,
                                                      paramOffset::Ptr{Csize_t},
                                                      paramSize::Ptr{Csize_t})::hipError_t)
end

function hipFuncGetAttributes(attr, func)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFuncGetAttributes(attr::Ptr{hipFuncAttributes},
                                                     func::Ptr{Cvoid})::hipError_t)
end

function hipFuncGetAttribute(value, attrib, hfunc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFuncGetAttribute(value::Ptr{Cint},
                                                    attrib::hipFunction_attribute,
                                                    hfunc::hipFunction_t)::hipError_t)
end

function hipGetFuncBySymbol(functionPtr, symbolPtr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetFuncBySymbol(functionPtr::Ptr{hipFunction_t},
                                                   symbolPtr::Ptr{Cvoid})::hipError_t)
end

function hipGetDriverEntryPoint(symbol, funcPtr, flags, driverStatus)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetDriverEntryPoint(symbol::Cstring,
                                                       funcPtr::Ptr{Ptr{Cvoid}},
                                                       flags::Culonglong,
                                                       driverStatus::Ptr{hipDriverEntryPointQueryResult})::hipError_t)
end

function hipModuleGetTexRef(texRef, hmod, name)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleGetTexRef(texRef::Ptr{Ptr{textureReference}},
                                                   hmod::hipModule_t,
                                                   name::Cstring)::hipError_t)
end

function hipModuleLoadData(_module, image)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLoadData(_module::Ptr{hipModule_t},
                                                  image::Ptr{Cvoid})::hipError_t)
end

function hipModuleLoadDataEx(_module, image, numOptions, options, optionValues)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLoadDataEx(_module::Ptr{hipModule_t},
                                                    image::Ptr{Cvoid}, numOptions::Cuint,
                                                    options::Ptr{hipJitOption},
                                                    optionValues::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipLinkAddData(state, type, data, size, name, numOptions, options, optionValues)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLinkAddData(state::hipLinkState_t, type::hipJitInputType,
                                               data::Ptr{Cvoid}, size::Csize_t,
                                               name::Cstring, numOptions::Cuint,
                                               options::Ptr{hipJitOption},
                                               optionValues::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipLinkAddFile(state, type, path, numOptions, options, optionValues)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLinkAddFile(state::hipLinkState_t, type::hipJitInputType,
                                               path::Cstring, numOptions::Cuint,
                                               options::Ptr{hipJitOption},
                                               optionValues::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipLinkComplete(state, hipBinOut, sizeOut)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLinkComplete(state::hipLinkState_t,
                                                hipBinOut::Ptr{Ptr{Cvoid}},
                                                sizeOut::Ptr{Csize_t})::hipError_t)
end

function hipLinkCreate(numOptions, options, optionValues, stateOut)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLinkCreate(numOptions::Cuint, options::Ptr{hipJitOption},
                                              optionValues::Ptr{Ptr{Cvoid}},
                                              stateOut::Ptr{hipLinkState_t})::hipError_t)
end

function hipLinkDestroy(state)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLinkDestroy(state::hipLinkState_t)::hipError_t)
end

function hipModuleLaunchKernel(f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY,
                               blockDimZ, sharedMemBytes, stream, kernelParams, extra)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLaunchKernel(f::hipFunction_t, gridDimX::Cuint,
                                                      gridDimY::Cuint, gridDimZ::Cuint,
                                                      blockDimX::Cuint, blockDimY::Cuint,
                                                      blockDimZ::Cuint,
                                                      sharedMemBytes::Cuint,
                                                      stream::hipStream_t,
                                                      kernelParams::Ptr{Ptr{Cvoid}},
                                                      extra::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipModuleLaunchCooperativeKernel(f, gridDimX, gridDimY, gridDimZ, blockDimX,
                                          blockDimY, blockDimZ, sharedMemBytes, stream,
                                          kernelParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLaunchCooperativeKernel(f::hipFunction_t,
                                                                 gridDimX::Cuint,
                                                                 gridDimY::Cuint,
                                                                 gridDimZ::Cuint,
                                                                 blockDimX::Cuint,
                                                                 blockDimY::Cuint,
                                                                 blockDimZ::Cuint,
                                                                 sharedMemBytes::Cuint,
                                                                 stream::hipStream_t,
                                                                 kernelParams::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipModuleLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleLaunchCooperativeKernelMultiDevice(launchParamsList::Ptr{hipFunctionLaunchParams},
                                                                            numDevices::Cuint,
                                                                            flags::Cuint)::hipError_t)
end

function hipLaunchCooperativeKernel(f, gridDim, blockDimX, kernelParams, sharedMemBytes,
                                    stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchCooperativeKernel(f::Ptr{Cvoid}, gridDim::dim3,
                                                           blockDimX::dim3,
                                                           kernelParams::Ptr{Ptr{Cvoid}},
                                                           sharedMemBytes::Cuint,
                                                           stream::hipStream_t)::hipError_t)
end

function hipLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchCooperativeKernelMultiDevice(launchParamsList::Ptr{hipLaunchParams},
                                                                      numDevices::Cint,
                                                                      flags::Cuint)::hipError_t)
end

function hipExtLaunchMultiKernelMultiDevice(launchParamsList, numDevices, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtLaunchMultiKernelMultiDevice(launchParamsList::Ptr{hipLaunchParams},
                                                                   numDevices::Cint,
                                                                   flags::Cuint)::hipError_t)
end

function hipLaunchKernelExC(config, fPtr, args)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchKernelExC(config::Ptr{hipLaunchConfig_t},
                                                   fPtr::Ptr{Cvoid},
                                                   args::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipDrvLaunchKernelEx(config, f, params, extra)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvLaunchKernelEx(config::Ptr{HIP_LAUNCH_CONFIG},
                                                     f::hipFunction_t,
                                                     params::Ptr{Ptr{Cvoid}},
                                                     extra::Ptr{Ptr{Cvoid}})::hipError_t)
end

function hipMemGetHandleForAddressRange(handle, dptr, size, handleType, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetHandleForAddressRange(handle::Ptr{Cvoid},
                                                               dptr::hipDeviceptr_t,
                                                               size::Csize_t,
                                                               handleType::hipMemRangeHandleType,
                                                               flags::Culonglong)::hipError_t)
end

function hipModuleOccupancyMaxPotentialBlockSize(gridSize, blockSize, f, dynSharedMemPerBlk,
                                                 blockSizeLimit)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleOccupancyMaxPotentialBlockSize(gridSize::Ptr{Cint},
                                                                        blockSize::Ptr{Cint},
                                                                        f::hipFunction_t,
                                                                        dynSharedMemPerBlk::Csize_t,
                                                                        blockSizeLimit::Cint)::hipError_t)
end

function hipModuleOccupancyMaxPotentialBlockSizeWithFlags(gridSize, blockSize, f,
                                                          dynSharedMemPerBlk,
                                                          blockSizeLimit, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleOccupancyMaxPotentialBlockSizeWithFlags(gridSize::Ptr{Cint},
                                                                                 blockSize::Ptr{Cint},
                                                                                 f::hipFunction_t,
                                                                                 dynSharedMemPerBlk::Csize_t,
                                                                                 blockSizeLimit::Cint,
                                                                                 flags::Cuint)::hipError_t)
end

function hipModuleOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks, f, blockSize,
                                                            dynSharedMemPerBlk)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks::Ptr{Cint},
                                                                                   f::hipFunction_t,
                                                                                   blockSize::Cint,
                                                                                   dynSharedMemPerBlk::Csize_t)::hipError_t)
end

function hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks, f,
                                                                     blockSize,
                                                                     dynSharedMemPerBlk,
                                                                     flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks::Ptr{Cint},
                                                                                            f::hipFunction_t,
                                                                                            blockSize::Cint,
                                                                                            dynSharedMemPerBlk::Csize_t,
                                                                                            flags::Cuint)::hipError_t)
end

function hipOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks, f, blockSize,
                                                      dynSharedMemPerBlk)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks::Ptr{Cint},
                                                                             f::Ptr{Cvoid},
                                                                             blockSize::Cint,
                                                                             dynSharedMemPerBlk::Csize_t)::hipError_t)
end

function hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks, f, blockSize,
                                                               dynSharedMemPerBlk, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks::Ptr{Cint},
                                                                                      f::Ptr{Cvoid},
                                                                                      blockSize::Cint,
                                                                                      dynSharedMemPerBlk::Csize_t,
                                                                                      flags::Cuint)::hipError_t)
end

function hipOccupancyMaxPotentialBlockSize(gridSize, blockSize, f, dynSharedMemPerBlk,
                                           blockSizeLimit)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipOccupancyMaxPotentialBlockSize(gridSize::Ptr{Cint},
                                                                  blockSize::Ptr{Cint},
                                                                  f::Ptr{Cvoid},
                                                                  dynSharedMemPerBlk::Csize_t,
                                                                  blockSizeLimit::Cint)::hipError_t)
end

function hipOccupancyAvailableDynamicSMemPerBlock(dynamicSmemSize, f, numBlocks, blockSize)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipOccupancyAvailableDynamicSMemPerBlock(dynamicSmemSize::Ptr{Csize_t},
                                                                         f::Ptr{Cvoid},
                                                                         numBlocks::Cint,
                                                                         blockSize::Cint)::hipError_t)
end

# no prototype is found for this function at hip_runtime_api.h:6989:12, please use with caution
function hipProfilerStart()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipProfilerStart()::hipError_t)
end

# no prototype is found for this function at hip_runtime_api.h:6997:12, please use with caution
function hipProfilerStop()
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipProfilerStop()::hipError_t)
end

function hipConfigureCall(gridDim, blockDim, sharedMem, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipConfigureCall(gridDim::dim3, blockDim::dim3,
                                                 sharedMem::Csize_t,
                                                 stream::hipStream_t)::hipError_t)
end

function hipSetupArgument(arg, size, offset)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipSetupArgument(arg::Ptr{Cvoid}, size::Csize_t,
                                                 offset::Csize_t)::hipError_t)
end

function hipLaunchByPtr(func)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchByPtr(func::Ptr{Cvoid})::hipError_t)
end

function __hipPushCallConfiguration(gridDim, blockDim, sharedMem, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.__hipPushCallConfiguration(gridDim::dim3, blockDim::dim3,
                                                           sharedMem::Csize_t,
                                                           stream::hipStream_t)::hipError_t)
end

function __hipPopCallConfiguration(gridDim, blockDim, sharedMem, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.__hipPopCallConfiguration(gridDim::Ptr{dim3},
                                                          blockDim::Ptr{dim3},
                                                          sharedMem::Ptr{Csize_t},
                                                          stream::Ptr{hipStream_t})::hipError_t)
end

function hipLaunchKernel(function_address, numBlocks, dimBlocks, args, sharedMemBytes,
                         stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchKernel(function_address::Ptr{Cvoid},
                                                numBlocks::dim3, dimBlocks::dim3,
                                                args::Ptr{Ptr{Cvoid}},
                                                sharedMemBytes::Csize_t,
                                                stream::hipStream_t)::hipError_t)
end

function hipLaunchHostFunc(stream, fn, userData)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchHostFunc(stream::hipStream_t, fn::hipHostFn_t,
                                                  userData::Ptr{Cvoid})::hipError_t)
end

function hipDrvMemcpy2DUnaligned(pCopy)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvMemcpy2DUnaligned(pCopy::Ptr{hip_Memcpy2D})::hipError_t)
end

function hipExtLaunchKernel(function_address, numBlocks, dimBlocks, args, sharedMemBytes,
                            stream, startEvent, stopEvent, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipExtLaunchKernel(function_address::Ptr{Cvoid},
                                                   numBlocks::dim3, dimBlocks::dim3,
                                                   args::Ptr{Ptr{Cvoid}},
                                                   sharedMemBytes::Csize_t,
                                                   stream::hipStream_t,
                                                   startEvent::hipEvent_t,
                                                   stopEvent::hipEvent_t,
                                                   flags::Cint)::hipError_t)
end

function hipCreateTextureObject(pTexObject, pResDesc, pTexDesc, pResViewDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCreateTextureObject(pTexObject::Ptr{hipTextureObject_t},
                                                       pResDesc::Ptr{hipResourceDesc},
                                                       pTexDesc::Ptr{hipTextureDesc},
                                                       pResViewDesc::Ptr{hipResourceViewDesc})::hipError_t)
end

function hipDestroyTextureObject(textureObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDestroyTextureObject(textureObject::hipTextureObject_t)::hipError_t)
end

function hipGetChannelDesc(desc, array)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetChannelDesc(desc::Ptr{hipChannelFormatDesc},
                                                  array::hipArray_const_t)::hipError_t)
end

function hipGetTextureObjectResourceDesc(pResDesc, textureObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetTextureObjectResourceDesc(pResDesc::Ptr{hipResourceDesc},
                                                                textureObject::hipTextureObject_t)::hipError_t)
end

function hipGetTextureObjectResourceViewDesc(pResViewDesc, textureObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetTextureObjectResourceViewDesc(pResViewDesc::Ptr{hipResourceViewDesc},
                                                                    textureObject::hipTextureObject_t)::hipError_t)
end

function hipGetTextureObjectTextureDesc(pTexDesc, textureObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetTextureObjectTextureDesc(pTexDesc::Ptr{hipTextureDesc},
                                                               textureObject::hipTextureObject_t)::hipError_t)
end

function hipTexObjectCreate(pTexObject, pResDesc, pTexDesc, pResViewDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexObjectCreate(pTexObject::Ptr{hipTextureObject_t},
                                                   pResDesc::Ptr{HIP_RESOURCE_DESC},
                                                   pTexDesc::Ptr{HIP_TEXTURE_DESC},
                                                   pResViewDesc::Ptr{HIP_RESOURCE_VIEW_DESC})::hipError_t)
end

function hipTexObjectDestroy(texObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexObjectDestroy(texObject::hipTextureObject_t)::hipError_t)
end

function hipTexObjectGetResourceDesc(pResDesc, texObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexObjectGetResourceDesc(pResDesc::Ptr{HIP_RESOURCE_DESC},
                                                            texObject::hipTextureObject_t)::hipError_t)
end

function hipTexObjectGetResourceViewDesc(pResViewDesc, texObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexObjectGetResourceViewDesc(pResViewDesc::Ptr{HIP_RESOURCE_VIEW_DESC},
                                                                texObject::hipTextureObject_t)::hipError_t)
end

function hipTexObjectGetTextureDesc(pTexDesc, texObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexObjectGetTextureDesc(pTexDesc::Ptr{HIP_TEXTURE_DESC},
                                                           texObject::hipTextureObject_t)::hipError_t)
end

function hipMallocMipmappedArray(mipmappedArray, desc, extent, numLevels, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMallocMipmappedArray(mipmappedArray::Ptr{hipMipmappedArray_t},
                                                        desc::Ptr{hipChannelFormatDesc},
                                                        extent::hipExtent, numLevels::Cuint,
                                                        flags::Cuint)::hipError_t)
end

function hipFreeMipmappedArray(mipmappedArray)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipFreeMipmappedArray(mipmappedArray::hipMipmappedArray_t)::hipError_t)
end

function hipGetMipmappedArrayLevel(levelArray, mipmappedArray, level)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetMipmappedArrayLevel(levelArray::Ptr{hipArray_t},
                                                          mipmappedArray::hipMipmappedArray_const_t,
                                                          level::Cuint)::hipError_t)
end

function hipMipmappedArrayCreate(pHandle, pMipmappedArrayDesc, numMipmapLevels)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMipmappedArrayCreate(pHandle::Ptr{hipMipmappedArray_t},
                                                        pMipmappedArrayDesc::Ptr{HIP_ARRAY3D_DESCRIPTOR},
                                                        numMipmapLevels::Cuint)::hipError_t)
end

function hipMipmappedArrayDestroy(hMipmappedArray)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMipmappedArrayDestroy(hMipmappedArray::hipMipmappedArray_t)::hipError_t)
end

function hipMipmappedArrayGetLevel(pLevelArray, hMipMappedArray, level)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMipmappedArrayGetLevel(pLevelArray::Ptr{hipArray_t},
                                                          hMipMappedArray::hipMipmappedArray_t,
                                                          level::Cuint)::hipError_t)
end

function hipBindTextureToMipmappedArray(tex, mipmappedArray, desc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipBindTextureToMipmappedArray(tex::Ptr{textureReference},
                                                               mipmappedArray::hipMipmappedArray_const_t,
                                                               desc::Ptr{hipChannelFormatDesc})::hipError_t)
end

function hipGetTextureReference(texref, symbol)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetTextureReference(texref::Ptr{Ptr{textureReference}},
                                                       symbol::Ptr{Cvoid})::hipError_t)
end

function hipTexRefGetBorderColor(pBorderColor, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetBorderColor(pBorderColor::Ptr{Cfloat},
                                                        texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetArray(pArray, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetArray(pArray::Ptr{hipArray_t},
                                                  texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefSetAddressMode(texRef, dim, am)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetAddressMode(texRef::Ptr{textureReference},
                                                        dim::Cint,
                                                        am::hipTextureAddressMode)::hipError_t)
end

function hipTexRefSetArray(tex, array, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetArray(tex::Ptr{textureReference},
                                                  array::hipArray_const_t,
                                                  flags::Cuint)::hipError_t)
end

function hipTexRefSetFilterMode(texRef, fm)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetFilterMode(texRef::Ptr{textureReference},
                                                       fm::hipTextureFilterMode)::hipError_t)
end

function hipTexRefSetFlags(texRef, Flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetFlags(texRef::Ptr{textureReference},
                                                  Flags::Cuint)::hipError_t)
end

function hipTexRefSetFormat(texRef, fmt, NumPackedComponents)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetFormat(texRef::Ptr{textureReference},
                                                   fmt::hipArray_Format,
                                                   NumPackedComponents::Cint)::hipError_t)
end

function hipBindTexture(offset, tex, devPtr, desc, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipBindTexture(offset::Ptr{Csize_t},
                                               tex::Ptr{textureReference},
                                               devPtr::Ptr{Cvoid},
                                               desc::Ptr{hipChannelFormatDesc},
                                               size::Csize_t)::hipError_t)
end

function hipBindTexture2D(offset, tex, devPtr, desc, width, height, pitch)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipBindTexture2D(offset::Ptr{Csize_t},
                                                 tex::Ptr{textureReference},
                                                 devPtr::Ptr{Cvoid},
                                                 desc::Ptr{hipChannelFormatDesc},
                                                 width::Csize_t, height::Csize_t,
                                                 pitch::Csize_t)::hipError_t)
end

function hipBindTextureToArray(tex, array, desc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipBindTextureToArray(tex::Ptr{textureReference},
                                                      array::hipArray_const_t,
                                                      desc::Ptr{hipChannelFormatDesc})::hipError_t)
end

function hipGetTextureAlignmentOffset(offset, texref)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetTextureAlignmentOffset(offset::Ptr{Csize_t},
                                                             texref::Ptr{textureReference})::hipError_t)
end

function hipUnbindTexture(tex)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipUnbindTexture(tex::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetAddress(dev_ptr, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetAddress(dev_ptr::Ptr{hipDeviceptr_t},
                                                    texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetAddressMode(pam, texRef, dim)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetAddressMode(pam::Ptr{hipTextureAddressMode},
                                                        texRef::Ptr{textureReference},
                                                        dim::Cint)::hipError_t)
end

function hipTexRefGetFilterMode(pfm, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetFilterMode(pfm::Ptr{hipTextureFilterMode},
                                                       texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetFlags(pFlags, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetFlags(pFlags::Ptr{Cuint},
                                                  texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetFormat(pFormat, pNumChannels, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetFormat(pFormat::Ptr{hipArray_Format},
                                                   pNumChannels::Ptr{Cint},
                                                   texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetMaxAnisotropy(pmaxAnsio, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetMaxAnisotropy(pmaxAnsio::Ptr{Cint},
                                                          texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetMipmapFilterMode(pfm, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetMipmapFilterMode(pfm::Ptr{hipTextureFilterMode},
                                                             texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetMipmapLevelBias(pbias, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetMipmapLevelBias(pbias::Ptr{Cfloat},
                                                            texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetMipmapLevelClamp(pminMipmapLevelClamp, pmaxMipmapLevelClamp, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetMipmapLevelClamp(pminMipmapLevelClamp::Ptr{Cfloat},
                                                             pmaxMipmapLevelClamp::Ptr{Cfloat},
                                                             texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefGetMipMappedArray(pArray, texRef)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefGetMipMappedArray(pArray::Ptr{hipMipmappedArray_t},
                                                           texRef::Ptr{textureReference})::hipError_t)
end

function hipTexRefSetAddress(ByteOffset, texRef, dptr, bytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetAddress(ByteOffset::Ptr{Csize_t},
                                                    texRef::Ptr{textureReference},
                                                    dptr::hipDeviceptr_t,
                                                    bytes::Csize_t)::hipError_t)
end

function hipTexRefSetAddress2D(texRef, desc, dptr, Pitch)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetAddress2D(texRef::Ptr{textureReference},
                                                      desc::Ptr{HIP_ARRAY_DESCRIPTOR},
                                                      dptr::hipDeviceptr_t,
                                                      Pitch::Csize_t)::hipError_t)
end

function hipTexRefSetMaxAnisotropy(texRef, maxAniso)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetMaxAnisotropy(texRef::Ptr{textureReference},
                                                          maxAniso::Cuint)::hipError_t)
end

function hipTexRefSetBorderColor(texRef, pBorderColor)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetBorderColor(texRef::Ptr{textureReference},
                                                        pBorderColor::Ptr{Cfloat})::hipError_t)
end

function hipTexRefSetMipmapFilterMode(texRef, fm)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetMipmapFilterMode(texRef::Ptr{textureReference},
                                                             fm::hipTextureFilterMode)::hipError_t)
end

function hipTexRefSetMipmapLevelBias(texRef, bias)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetMipmapLevelBias(texRef::Ptr{textureReference},
                                                            bias::Cfloat)::hipError_t)
end

function hipTexRefSetMipmapLevelClamp(texRef, minMipMapLevelClamp, maxMipMapLevelClamp)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetMipmapLevelClamp(texRef::Ptr{textureReference},
                                                             minMipMapLevelClamp::Cfloat,
                                                             maxMipMapLevelClamp::Cfloat)::hipError_t)
end

function hipTexRefSetMipmappedArray(texRef, mipmappedArray, Flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipTexRefSetMipmappedArray(texRef::Ptr{textureReference},
                                                           mipmappedArray::Ptr{hipMipmappedArray},
                                                           Flags::Cuint)::hipError_t)
end

function hipApiName(id)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipApiName(id::UInt32)::Cstring)
end

function hipKernelNameRef(f)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipKernelNameRef(f::hipFunction_t)::Cstring)
end

function hipKernelNameRefByPtr(hostFunction, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipKernelNameRefByPtr(hostFunction::Ptr{Cvoid},
                                                      stream::hipStream_t)::Cstring)
end

function hipGetStreamDeviceId(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetStreamDeviceId(stream::hipStream_t)::Cint)
end

function hipStreamBeginCapture(stream, mode)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamBeginCapture(stream::hipStream_t,
                                                      mode::hipStreamCaptureMode)::hipError_t)
end

function hipStreamBeginCaptureToGraph(stream, graph, dependencies, dependencyData,
                                      numDependencies, mode)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamBeginCaptureToGraph(stream::hipStream_t,
                                                             graph::hipGraph_t,
                                                             dependencies::Ptr{hipGraphNode_t},
                                                             dependencyData::Ptr{hipGraphEdgeData},
                                                             numDependencies::Csize_t,
                                                             mode::hipStreamCaptureMode)::hipError_t)
end

function hipStreamEndCapture(stream, pGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamEndCapture(stream::hipStream_t,
                                                    pGraph::Ptr{hipGraph_t})::hipError_t)
end

function hipStreamGetCaptureInfo(stream, pCaptureStatus, pId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetCaptureInfo(stream::hipStream_t,
                                                        pCaptureStatus::Ptr{hipStreamCaptureStatus},
                                                        pId::Ptr{Culonglong})::hipError_t)
end

function hipStreamGetCaptureInfo_v2(stream, captureStatus_out, id_out, graph_out,
                                    dependencies_out, numDependencies_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetCaptureInfo_v2(stream::hipStream_t,
                                                           captureStatus_out::Ptr{hipStreamCaptureStatus},
                                                           id_out::Ptr{Culonglong},
                                                           graph_out::Ptr{hipGraph_t},
                                                           dependencies_out::Ptr{Ptr{hipGraphNode_t}},
                                                           numDependencies_out::Ptr{Csize_t})::hipError_t)
end

function hipStreamIsCapturing(stream, pCaptureStatus)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamIsCapturing(stream::hipStream_t,
                                                     pCaptureStatus::Ptr{hipStreamCaptureStatus})::hipError_t)
end

function hipStreamUpdateCaptureDependencies(stream, dependencies, numDependencies, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamUpdateCaptureDependencies(stream::hipStream_t,
                                                                   dependencies::Ptr{hipGraphNode_t},
                                                                   numDependencies::Csize_t,
                                                                   flags::Cuint)::hipError_t)
end

function hipThreadExchangeStreamCaptureMode(mode)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipThreadExchangeStreamCaptureMode(mode::Ptr{hipStreamCaptureMode})::hipError_t)
end

function hipGraphCreate(pGraph, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphCreate(pGraph::Ptr{hipGraph_t},
                                               flags::Cuint)::hipError_t)
end

function hipGraphDestroy(graph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphDestroy(graph::hipGraph_t)::hipError_t)
end

function hipGraphAddDependencies(graph, from, to, numDependencies)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddDependencies(graph::hipGraph_t,
                                                        from::Ptr{hipGraphNode_t},
                                                        to::Ptr{hipGraphNode_t},
                                                        numDependencies::Csize_t)::hipError_t)
end

function hipGraphRemoveDependencies(graph, from, to, numDependencies)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphRemoveDependencies(graph::hipGraph_t,
                                                           from::Ptr{hipGraphNode_t},
                                                           to::Ptr{hipGraphNode_t},
                                                           numDependencies::Csize_t)::hipError_t)
end

function hipGraphGetEdges(graph, from, to, numEdges)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphGetEdges(graph::hipGraph_t,
                                                 from::Ptr{hipGraphNode_t},
                                                 to::Ptr{hipGraphNode_t},
                                                 numEdges::Ptr{Csize_t})::hipError_t)
end

function hipGraphGetNodes(graph, nodes, numNodes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphGetNodes(graph::hipGraph_t,
                                                 nodes::Ptr{hipGraphNode_t},
                                                 numNodes::Ptr{Csize_t})::hipError_t)
end

function hipGraphGetRootNodes(graph, pRootNodes, pNumRootNodes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphGetRootNodes(graph::hipGraph_t,
                                                     pRootNodes::Ptr{hipGraphNode_t},
                                                     pNumRootNodes::Ptr{Csize_t})::hipError_t)
end

function hipGraphNodeGetDependencies(node, pDependencies, pNumDependencies)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeGetDependencies(node::hipGraphNode_t,
                                                            pDependencies::Ptr{hipGraphNode_t},
                                                            pNumDependencies::Ptr{Csize_t})::hipError_t)
end

function hipGraphNodeGetDependentNodes(node, pDependentNodes, pNumDependentNodes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeGetDependentNodes(node::hipGraphNode_t,
                                                              pDependentNodes::Ptr{hipGraphNode_t},
                                                              pNumDependentNodes::Ptr{Csize_t})::hipError_t)
end

function hipGraphNodeGetType(node, pType)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeGetType(node::hipGraphNode_t,
                                                    pType::Ptr{hipGraphNodeType})::hipError_t)
end

function hipGraphDestroyNode(node)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphDestroyNode(node::hipGraphNode_t)::hipError_t)
end

function hipGraphClone(pGraphClone, originalGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphClone(pGraphClone::Ptr{hipGraph_t},
                                              originalGraph::hipGraph_t)::hipError_t)
end

function hipGraphNodeFindInClone(pNode, originalNode, clonedGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeFindInClone(pNode::Ptr{hipGraphNode_t},
                                                        originalNode::hipGraphNode_t,
                                                        clonedGraph::hipGraph_t)::hipError_t)
end

function hipGraphInstantiate(pGraphExec, graph, pErrorNode, pLogBuffer, bufferSize)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphInstantiate(pGraphExec::Ptr{hipGraphExec_t},
                                                    graph::hipGraph_t,
                                                    pErrorNode::Ptr{hipGraphNode_t},
                                                    pLogBuffer::Cstring,
                                                    bufferSize::Csize_t)::hipError_t)
end

function hipGraphInstantiateWithFlags(pGraphExec, graph, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphInstantiateWithFlags(pGraphExec::Ptr{hipGraphExec_t},
                                                             graph::hipGraph_t,
                                                             flags::Culonglong)::hipError_t)
end

function hipGraphInstantiateWithParams(pGraphExec, graph, instantiateParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphInstantiateWithParams(pGraphExec::Ptr{hipGraphExec_t},
                                                              graph::hipGraph_t,
                                                              instantiateParams::Ptr{hipGraphInstantiateParams})::hipError_t)
end

function hipGraphLaunch(graphExec, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphLaunch(graphExec::hipGraphExec_t,
                                               stream::hipStream_t)::hipError_t)
end

function hipGraphUpload(graphExec, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphUpload(graphExec::hipGraphExec_t,
                                               stream::hipStream_t)::hipError_t)
end

function hipGraphAddNode(pGraphNode, graph, pDependencies, numDependencies, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddNode(pGraphNode::Ptr{hipGraphNode_t},
                                                graph::hipGraph_t,
                                                pDependencies::Ptr{hipGraphNode_t},
                                                numDependencies::Csize_t,
                                                nodeParams::Ptr{hipGraphNodeParams})::hipError_t)
end

function hipGraphExecGetFlags(graphExec, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecGetFlags(graphExec::hipGraphExec_t,
                                                     flags::Ptr{Culonglong})::hipError_t)
end

function hipGraphNodeSetParams(node, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeSetParams(node::hipGraphNode_t,
                                                      nodeParams::Ptr{hipGraphNodeParams})::hipError_t)
end

function hipGraphExecNodeSetParams(graphExec, node, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecNodeSetParams(graphExec::hipGraphExec_t,
                                                          node::hipGraphNode_t,
                                                          nodeParams::Ptr{hipGraphNodeParams})::hipError_t)
end

function hipGraphExecDestroy(graphExec)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecDestroy(graphExec::hipGraphExec_t)::hipError_t)
end

function hipGraphExecUpdate(hGraphExec, hGraph, hErrorNode_out, updateResult_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecUpdate(hGraphExec::hipGraphExec_t,
                                                   hGraph::hipGraph_t,
                                                   hErrorNode_out::Ptr{hipGraphNode_t},
                                                   updateResult_out::Ptr{hipGraphExecUpdateResult})::hipError_t)
end

function hipGraphAddKernelNode(pGraphNode, graph, pDependencies, numDependencies,
                               pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddKernelNode(pGraphNode::Ptr{hipGraphNode_t},
                                                      graph::hipGraph_t,
                                                      pDependencies::Ptr{hipGraphNode_t},
                                                      numDependencies::Csize_t,
                                                      pNodeParams::Ptr{hipKernelNodeParams})::hipError_t)
end

function hipGraphKernelNodeGetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphKernelNodeGetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipKernelNodeParams})::hipError_t)
end

function hipGraphKernelNodeSetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphKernelNodeSetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipKernelNodeParams})::hipError_t)
end

function hipGraphExecKernelNodeSetParams(hGraphExec, node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecKernelNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                node::hipGraphNode_t,
                                                                pNodeParams::Ptr{hipKernelNodeParams})::hipError_t)
end

function hipDrvGraphAddMemcpyNode(phGraphNode, hGraph, dependencies, numDependencies,
                                  copyParams, ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphAddMemcpyNode(phGraphNode::Ptr{hipGraphNode_t},
                                                         hGraph::hipGraph_t,
                                                         dependencies::Ptr{hipGraphNode_t},
                                                         numDependencies::Csize_t,
                                                         copyParams::Ptr{HIP_MEMCPY3D},
                                                         ctx::hipCtx_t)::hipError_t)
end

function hipGraphAddMemcpyNode(pGraphNode, graph, pDependencies, numDependencies,
                               pCopyParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemcpyNode(pGraphNode::Ptr{hipGraphNode_t},
                                                      graph::hipGraph_t,
                                                      pDependencies::Ptr{hipGraphNode_t},
                                                      numDependencies::Csize_t,
                                                      pCopyParams::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipGraphMemcpyNodeGetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemcpyNodeGetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipGraphMemcpyNodeSetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemcpyNodeSetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipGraphKernelNodeSetAttribute(hNode, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphKernelNodeSetAttribute(hNode::hipGraphNode_t,
                                                               attr::hipLaunchAttributeID,
                                                               value::Ptr{hipLaunchAttributeValue})::hipError_t)
end

function hipGraphKernelNodeGetAttribute(hNode, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphKernelNodeGetAttribute(hNode::hipGraphNode_t,
                                                               attr::hipLaunchAttributeID,
                                                               value::Ptr{hipLaunchAttributeValue})::hipError_t)
end

function hipGraphExecMemcpyNodeSetParams(hGraphExec, node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecMemcpyNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                node::hipGraphNode_t,
                                                                pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipGraphAddMemcpyNode1D(pGraphNode, graph, pDependencies, numDependencies, dst,
                                 src, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemcpyNode1D(pGraphNode::Ptr{hipGraphNode_t},
                                                        graph::hipGraph_t,
                                                        pDependencies::Ptr{hipGraphNode_t},
                                                        numDependencies::Csize_t,
                                                        dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                        count::Csize_t,
                                                        kind::hipMemcpyKind)::hipError_t)
end

function hipGraphMemcpyNodeSetParams1D(node, dst, src, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemcpyNodeSetParams1D(node::hipGraphNode_t,
                                                              dst::Ptr{Cvoid},
                                                              src::Ptr{Cvoid},
                                                              count::Csize_t,
                                                              kind::hipMemcpyKind)::hipError_t)
end

function hipGraphExecMemcpyNodeSetParams1D(hGraphExec, node, dst, src, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecMemcpyNodeSetParams1D(hGraphExec::hipGraphExec_t,
                                                                  node::hipGraphNode_t,
                                                                  dst::Ptr{Cvoid},
                                                                  src::Ptr{Cvoid},
                                                                  count::Csize_t,
                                                                  kind::hipMemcpyKind)::hipError_t)
end

function hipGraphAddMemcpyNodeFromSymbol(pGraphNode, graph, pDependencies, numDependencies,
                                         dst, symbol, count, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemcpyNodeFromSymbol(pGraphNode::Ptr{hipGraphNode_t},
                                                                graph::hipGraph_t,
                                                                pDependencies::Ptr{hipGraphNode_t},
                                                                numDependencies::Csize_t,
                                                                dst::Ptr{Cvoid},
                                                                symbol::Ptr{Cvoid},
                                                                count::Csize_t,
                                                                offset::Csize_t,
                                                                kind::hipMemcpyKind)::hipError_t)
end

function hipGraphMemcpyNodeSetParamsFromSymbol(node, dst, symbol, count, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemcpyNodeSetParamsFromSymbol(node::hipGraphNode_t,
                                                                      dst::Ptr{Cvoid},
                                                                      symbol::Ptr{Cvoid},
                                                                      count::Csize_t,
                                                                      offset::Csize_t,
                                                                      kind::hipMemcpyKind)::hipError_t)
end

function hipGraphExecMemcpyNodeSetParamsFromSymbol(hGraphExec, node, dst, symbol, count,
                                                   offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecMemcpyNodeSetParamsFromSymbol(hGraphExec::hipGraphExec_t,
                                                                          node::hipGraphNode_t,
                                                                          dst::Ptr{Cvoid},
                                                                          symbol::Ptr{Cvoid},
                                                                          count::Csize_t,
                                                                          offset::Csize_t,
                                                                          kind::hipMemcpyKind)::hipError_t)
end

function hipGraphAddMemcpyNodeToSymbol(pGraphNode, graph, pDependencies, numDependencies,
                                       symbol, src, count, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemcpyNodeToSymbol(pGraphNode::Ptr{hipGraphNode_t},
                                                              graph::hipGraph_t,
                                                              pDependencies::Ptr{hipGraphNode_t},
                                                              numDependencies::Csize_t,
                                                              symbol::Ptr{Cvoid},
                                                              src::Ptr{Cvoid},
                                                              count::Csize_t,
                                                              offset::Csize_t,
                                                              kind::hipMemcpyKind)::hipError_t)
end

function hipGraphMemcpyNodeSetParamsToSymbol(node, symbol, src, count, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemcpyNodeSetParamsToSymbol(node::hipGraphNode_t,
                                                                    symbol::Ptr{Cvoid},
                                                                    src::Ptr{Cvoid},
                                                                    count::Csize_t,
                                                                    offset::Csize_t,
                                                                    kind::hipMemcpyKind)::hipError_t)
end

function hipGraphExecMemcpyNodeSetParamsToSymbol(hGraphExec, node, symbol, src, count,
                                                 offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecMemcpyNodeSetParamsToSymbol(hGraphExec::hipGraphExec_t,
                                                                        node::hipGraphNode_t,
                                                                        symbol::Ptr{Cvoid},
                                                                        src::Ptr{Cvoid},
                                                                        count::Csize_t,
                                                                        offset::Csize_t,
                                                                        kind::hipMemcpyKind)::hipError_t)
end

function hipGraphAddMemsetNode(pGraphNode, graph, pDependencies, numDependencies,
                               pMemsetParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemsetNode(pGraphNode::Ptr{hipGraphNode_t},
                                                      graph::hipGraph_t,
                                                      pDependencies::Ptr{hipGraphNode_t},
                                                      numDependencies::Csize_t,
                                                      pMemsetParams::Ptr{hipMemsetParams})::hipError_t)
end

function hipGraphMemsetNodeGetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemsetNodeGetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipMemsetParams})::hipError_t)
end

function hipGraphMemsetNodeSetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemsetNodeSetParams(node::hipGraphNode_t,
                                                            pNodeParams::Ptr{hipMemsetParams})::hipError_t)
end

function hipGraphExecMemsetNodeSetParams(hGraphExec, node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecMemsetNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                node::hipGraphNode_t,
                                                                pNodeParams::Ptr{hipMemsetParams})::hipError_t)
end

function hipGraphAddHostNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddHostNode(pGraphNode::Ptr{hipGraphNode_t},
                                                    graph::hipGraph_t,
                                                    pDependencies::Ptr{hipGraphNode_t},
                                                    numDependencies::Csize_t,
                                                    pNodeParams::Ptr{hipHostNodeParams})::hipError_t)
end

function hipGraphHostNodeGetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphHostNodeGetParams(node::hipGraphNode_t,
                                                          pNodeParams::Ptr{hipHostNodeParams})::hipError_t)
end

function hipGraphHostNodeSetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphHostNodeSetParams(node::hipGraphNode_t,
                                                          pNodeParams::Ptr{hipHostNodeParams})::hipError_t)
end

function hipGraphExecHostNodeSetParams(hGraphExec, node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecHostNodeSetParams(hGraphExec::hipGraphExec_t,
                                                              node::hipGraphNode_t,
                                                              pNodeParams::Ptr{hipHostNodeParams})::hipError_t)
end

function hipGraphAddChildGraphNode(pGraphNode, graph, pDependencies, numDependencies,
                                   childGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddChildGraphNode(pGraphNode::Ptr{hipGraphNode_t},
                                                          graph::hipGraph_t,
                                                          pDependencies::Ptr{hipGraphNode_t},
                                                          numDependencies::Csize_t,
                                                          childGraph::hipGraph_t)::hipError_t)
end

function hipGraphChildGraphNodeGetGraph(node, pGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphChildGraphNodeGetGraph(node::hipGraphNode_t,
                                                               pGraph::Ptr{hipGraph_t})::hipError_t)
end

function hipGraphExecChildGraphNodeSetParams(hGraphExec, node, childGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecChildGraphNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                    node::hipGraphNode_t,
                                                                    childGraph::hipGraph_t)::hipError_t)
end

function hipGraphAddEmptyNode(pGraphNode, graph, pDependencies, numDependencies)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddEmptyNode(pGraphNode::Ptr{hipGraphNode_t},
                                                     graph::hipGraph_t,
                                                     pDependencies::Ptr{hipGraphNode_t},
                                                     numDependencies::Csize_t)::hipError_t)
end

function hipGraphAddEventRecordNode(pGraphNode, graph, pDependencies, numDependencies,
                                    event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddEventRecordNode(pGraphNode::Ptr{hipGraphNode_t},
                                                           graph::hipGraph_t,
                                                           pDependencies::Ptr{hipGraphNode_t},
                                                           numDependencies::Csize_t,
                                                           event::hipEvent_t)::hipError_t)
end

function hipGraphEventRecordNodeGetEvent(node, event_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphEventRecordNodeGetEvent(node::hipGraphNode_t,
                                                                event_out::Ptr{hipEvent_t})::hipError_t)
end

function hipGraphEventRecordNodeSetEvent(node, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphEventRecordNodeSetEvent(node::hipGraphNode_t,
                                                                event::hipEvent_t)::hipError_t)
end

function hipGraphExecEventRecordNodeSetEvent(hGraphExec, hNode, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecEventRecordNodeSetEvent(hGraphExec::hipGraphExec_t,
                                                                    hNode::hipGraphNode_t,
                                                                    event::hipEvent_t)::hipError_t)
end

function hipGraphAddEventWaitNode(pGraphNode, graph, pDependencies, numDependencies, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddEventWaitNode(pGraphNode::Ptr{hipGraphNode_t},
                                                         graph::hipGraph_t,
                                                         pDependencies::Ptr{hipGraphNode_t},
                                                         numDependencies::Csize_t,
                                                         event::hipEvent_t)::hipError_t)
end

function hipGraphEventWaitNodeGetEvent(node, event_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphEventWaitNodeGetEvent(node::hipGraphNode_t,
                                                              event_out::Ptr{hipEvent_t})::hipError_t)
end

function hipGraphEventWaitNodeSetEvent(node, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphEventWaitNodeSetEvent(node::hipGraphNode_t,
                                                              event::hipEvent_t)::hipError_t)
end

function hipGraphExecEventWaitNodeSetEvent(hGraphExec, hNode, event)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecEventWaitNodeSetEvent(hGraphExec::hipGraphExec_t,
                                                                  hNode::hipGraphNode_t,
                                                                  event::hipEvent_t)::hipError_t)
end

function hipGraphAddMemAllocNode(pGraphNode, graph, pDependencies, numDependencies,
                                 pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemAllocNode(pGraphNode::Ptr{hipGraphNode_t},
                                                        graph::hipGraph_t,
                                                        pDependencies::Ptr{hipGraphNode_t},
                                                        numDependencies::Csize_t,
                                                        pNodeParams::Ptr{hipMemAllocNodeParams})::hipError_t)
end

function hipGraphMemAllocNodeGetParams(node, pNodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemAllocNodeGetParams(node::hipGraphNode_t,
                                                              pNodeParams::Ptr{hipMemAllocNodeParams})::hipError_t)
end

function hipGraphAddMemFreeNode(pGraphNode, graph, pDependencies, numDependencies, dev_ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddMemFreeNode(pGraphNode::Ptr{hipGraphNode_t},
                                                       graph::hipGraph_t,
                                                       pDependencies::Ptr{hipGraphNode_t},
                                                       numDependencies::Csize_t,
                                                       dev_ptr::Ptr{Cvoid})::hipError_t)
end

function hipGraphMemFreeNodeGetParams(node, dev_ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphMemFreeNodeGetParams(node::hipGraphNode_t,
                                                             dev_ptr::Ptr{Cvoid})::hipError_t)
end

function hipDeviceGetGraphMemAttribute(device, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGetGraphMemAttribute(device::Cint,
                                                              attr::hipGraphMemAttributeType,
                                                              value::Ptr{Cvoid})::hipError_t)
end

function hipDeviceSetGraphMemAttribute(device, attr, value)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceSetGraphMemAttribute(device::Cint,
                                                              attr::hipGraphMemAttributeType,
                                                              value::Ptr{Cvoid})::hipError_t)
end

function hipDeviceGraphMemTrim(device)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDeviceGraphMemTrim(device::Cint)::hipError_t)
end

function hipUserObjectCreate(object_out, ptr, destroy, initialRefcount, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipUserObjectCreate(object_out::Ptr{hipUserObject_t},
                                                    ptr::Ptr{Cvoid}, destroy::hipHostFn_t,
                                                    initialRefcount::Cuint,
                                                    flags::Cuint)::hipError_t)
end

function hipUserObjectRelease(object, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipUserObjectRelease(object::hipUserObject_t,
                                                     count::Cuint)::hipError_t)
end

function hipUserObjectRetain(object, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipUserObjectRetain(object::hipUserObject_t,
                                                    count::Cuint)::hipError_t)
end

function hipGraphRetainUserObject(graph, object, count, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphRetainUserObject(graph::hipGraph_t,
                                                         object::hipUserObject_t,
                                                         count::Cuint,
                                                         flags::Cuint)::hipError_t)
end

function hipGraphReleaseUserObject(graph, object, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphReleaseUserObject(graph::hipGraph_t,
                                                          object::hipUserObject_t,
                                                          count::Cuint)::hipError_t)
end

function hipGraphDebugDotPrint(graph, path, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphDebugDotPrint(graph::hipGraph_t, path::Cstring,
                                                      flags::Cuint)::hipError_t)
end

function hipGraphKernelNodeCopyAttributes(hSrc, hDst)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphKernelNodeCopyAttributes(hSrc::hipGraphNode_t,
                                                                 hDst::hipGraphNode_t)::hipError_t)
end

function hipGraphNodeSetEnabled(hGraphExec, hNode, isEnabled)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeSetEnabled(hGraphExec::hipGraphExec_t,
                                                       hNode::hipGraphNode_t,
                                                       isEnabled::Cuint)::hipError_t)
end

function hipGraphNodeGetEnabled(hGraphExec, hNode, isEnabled)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphNodeGetEnabled(hGraphExec::hipGraphExec_t,
                                                       hNode::hipGraphNode_t,
                                                       isEnabled::Ptr{Cuint})::hipError_t)
end

function hipGraphAddExternalSemaphoresWaitNode(pGraphNode, graph, pDependencies,
                                               numDependencies, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddExternalSemaphoresWaitNode(pGraphNode::Ptr{hipGraphNode_t},
                                                                      graph::hipGraph_t,
                                                                      pDependencies::Ptr{hipGraphNode_t},
                                                                      numDependencies::Csize_t,
                                                                      nodeParams::Ptr{hipExternalSemaphoreWaitNodeParams})::hipError_t)
end

function hipGraphAddExternalSemaphoresSignalNode(pGraphNode, graph, pDependencies,
                                                 numDependencies, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphAddExternalSemaphoresSignalNode(pGraphNode::Ptr{hipGraphNode_t},
                                                                        graph::hipGraph_t,
                                                                        pDependencies::Ptr{hipGraphNode_t},
                                                                        numDependencies::Csize_t,
                                                                        nodeParams::Ptr{hipExternalSemaphoreSignalNodeParams})::hipError_t)
end

function hipGraphExternalSemaphoresSignalNodeSetParams(hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExternalSemaphoresSignalNodeSetParams(hNode::hipGraphNode_t,
                                                                              nodeParams::Ptr{hipExternalSemaphoreSignalNodeParams})::hipError_t)
end

function hipGraphExternalSemaphoresWaitNodeSetParams(hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExternalSemaphoresWaitNodeSetParams(hNode::hipGraphNode_t,
                                                                            nodeParams::Ptr{hipExternalSemaphoreWaitNodeParams})::hipError_t)
end

function hipGraphExternalSemaphoresSignalNodeGetParams(hNode, params_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExternalSemaphoresSignalNodeGetParams(hNode::hipGraphNode_t,
                                                                              params_out::Ptr{hipExternalSemaphoreSignalNodeParams})::hipError_t)
end

function hipGraphExternalSemaphoresWaitNodeGetParams(hNode, params_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExternalSemaphoresWaitNodeGetParams(hNode::hipGraphNode_t,
                                                                            params_out::Ptr{hipExternalSemaphoreWaitNodeParams})::hipError_t)
end

function hipGraphExecExternalSemaphoresSignalNodeSetParams(hGraphExec, hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecExternalSemaphoresSignalNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                                  hNode::hipGraphNode_t,
                                                                                  nodeParams::Ptr{hipExternalSemaphoreSignalNodeParams})::hipError_t)
end

function hipGraphExecExternalSemaphoresWaitNodeSetParams(hGraphExec, hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphExecExternalSemaphoresWaitNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                                hNode::hipGraphNode_t,
                                                                                nodeParams::Ptr{hipExternalSemaphoreWaitNodeParams})::hipError_t)
end

function hipDrvGraphMemcpyNodeGetParams(hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphMemcpyNodeGetParams(hNode::hipGraphNode_t,
                                                               nodeParams::Ptr{HIP_MEMCPY3D})::hipError_t)
end

function hipDrvGraphMemcpyNodeSetParams(hNode, nodeParams)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphMemcpyNodeSetParams(hNode::hipGraphNode_t,
                                                               nodeParams::Ptr{HIP_MEMCPY3D})::hipError_t)
end

function hipDrvGraphAddMemsetNode(phGraphNode, hGraph, dependencies, numDependencies,
                                  memsetParams, ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphAddMemsetNode(phGraphNode::Ptr{hipGraphNode_t},
                                                         hGraph::hipGraph_t,
                                                         dependencies::Ptr{hipGraphNode_t},
                                                         numDependencies::Csize_t,
                                                         memsetParams::Ptr{hipMemsetParams},
                                                         ctx::hipCtx_t)::hipError_t)
end

function hipDrvGraphAddMemFreeNode(phGraphNode, hGraph, dependencies, numDependencies, dptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphAddMemFreeNode(phGraphNode::Ptr{hipGraphNode_t},
                                                          hGraph::hipGraph_t,
                                                          dependencies::Ptr{hipGraphNode_t},
                                                          numDependencies::Csize_t,
                                                          dptr::hipDeviceptr_t)::hipError_t)
end

function hipDrvGraphExecMemcpyNodeSetParams(hGraphExec, hNode, copyParams, ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphExecMemcpyNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                   hNode::hipGraphNode_t,
                                                                   copyParams::Ptr{HIP_MEMCPY3D},
                                                                   ctx::hipCtx_t)::hipError_t)
end

function hipDrvGraphExecMemsetNodeSetParams(hGraphExec, hNode, memsetParams, ctx)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDrvGraphExecMemsetNodeSetParams(hGraphExec::hipGraphExec_t,
                                                                   hNode::hipGraphNode_t,
                                                                   memsetParams::Ptr{hipMemsetParams},
                                                                   ctx::hipCtx_t)::hipError_t)
end

function hipMemAddressFree(devPtr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAddressFree(devPtr::Ptr{Cvoid},
                                                  size::Csize_t)::hipError_t)
end

function hipMemAddressReserve(ptr, size, alignment, addr, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemAddressReserve(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t,
                                                     alignment::Csize_t, addr::Ptr{Cvoid},
                                                     flags::Culonglong)::hipError_t)
end

function hipMemCreate(handle, size, prop, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemCreate(handle::Ptr{hipMemGenericAllocationHandle_t},
                                             size::Csize_t, prop::Ptr{hipMemAllocationProp},
                                             flags::Culonglong)::hipError_t)
end

function hipMemExportToShareableHandle(shareableHandle, handle, handleType, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemExportToShareableHandle(shareableHandle::Ptr{Cvoid},
                                                              handle::hipMemGenericAllocationHandle_t,
                                                              handleType::hipMemAllocationHandleType,
                                                              flags::Culonglong)::hipError_t)
end

function hipMemGetAccess(flags, location, ptr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetAccess(flags::Ptr{Culonglong},
                                                location::Ptr{hipMemLocation},
                                                ptr::Ptr{Cvoid})::hipError_t)
end

function hipMemGetAllocationGranularity(granularity, prop, option)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetAllocationGranularity(granularity::Ptr{Csize_t},
                                                               prop::Ptr{hipMemAllocationProp},
                                                               option::hipMemAllocationGranularity_flags)::hipError_t)
end

function hipMemGetAllocationPropertiesFromHandle(prop, handle)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemGetAllocationPropertiesFromHandle(prop::Ptr{hipMemAllocationProp},
                                                                        handle::hipMemGenericAllocationHandle_t)::hipError_t)
end

function hipMemImportFromShareableHandle(handle, osHandle, shHandleType)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemImportFromShareableHandle(handle::Ptr{hipMemGenericAllocationHandle_t},
                                                                osHandle::Ptr{Cvoid},
                                                                shHandleType::hipMemAllocationHandleType)::hipError_t)
end

function hipMemMap(ptr, size, offset, handle, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemMap(ptr::Ptr{Cvoid}, size::Csize_t, offset::Csize_t,
                                          handle::hipMemGenericAllocationHandle_t,
                                          flags::Culonglong)::hipError_t)
end

function hipMemMapArrayAsync(mapInfoList, count, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemMapArrayAsync(mapInfoList::Ptr{hipArrayMapInfo},
                                                    count::Cuint,
                                                    stream::hipStream_t)::hipError_t)
end

function hipMemRelease(handle)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemRelease(handle::hipMemGenericAllocationHandle_t)::hipError_t)
end

function hipMemRetainAllocationHandle(handle, addr)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemRetainAllocationHandle(handle::Ptr{hipMemGenericAllocationHandle_t},
                                                             addr::Ptr{Cvoid})::hipError_t)
end

function hipMemSetAccess(ptr, size, desc, count)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemSetAccess(ptr::Ptr{Cvoid}, size::Csize_t,
                                                desc::Ptr{hipMemAccessDesc},
                                                count::Csize_t)::hipError_t)
end

function hipMemUnmap(ptr, size)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemUnmap(ptr::Ptr{Cvoid}, size::Csize_t)::hipError_t)
end

function hipGraphicsMapResources(count, resources, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphicsMapResources(count::Cint,
                                                        resources::Ptr{hipGraphicsResource_t},
                                                        stream::hipStream_t)::hipError_t)
end

function hipGraphicsSubResourceGetMappedArray(array, resource, arrayIndex, mipLevel)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphicsSubResourceGetMappedArray(array::Ptr{hipArray_t},
                                                                     resource::hipGraphicsResource_t,
                                                                     arrayIndex::Cuint,
                                                                     mipLevel::Cuint)::hipError_t)
end

function hipGraphicsResourceGetMappedPointer(devPtr, size, resource)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphicsResourceGetMappedPointer(devPtr::Ptr{Ptr{Cvoid}},
                                                                    size::Ptr{Csize_t},
                                                                    resource::hipGraphicsResource_t)::hipError_t)
end

function hipGraphicsUnmapResources(count, resources, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphicsUnmapResources(count::Cint,
                                                          resources::Ptr{hipGraphicsResource_t},
                                                          stream::hipStream_t)::hipError_t)
end

function hipGraphicsUnregisterResource(resource)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphicsUnregisterResource(resource::hipGraphicsResource_t)::hipError_t)
end

function hipCreateSurfaceObject(pSurfObject, pResDesc)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipCreateSurfaceObject(pSurfObject::Ptr{hipSurfaceObject_t},
                                                       pResDesc::Ptr{hipResourceDesc})::hipError_t)
end

function hipDestroySurfaceObject(surfaceObject)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipDestroySurfaceObject(surfaceObject::hipSurfaceObject_t)::hipError_t)
end

function hipMemcpy_spt(dst, src, sizeBytes, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy_spt(dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                              sizeBytes::Csize_t,
                                              kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyToSymbol_spt(symbol, src, sizeBytes, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyToSymbol_spt(symbol::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                      sizeBytes::Csize_t, offset::Csize_t,
                                                      kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpyFromSymbol_spt(dst, symbol, sizeBytes, offset, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromSymbol_spt(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid},
                                                        sizeBytes::Csize_t, offset::Csize_t,
                                                        kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2D_spt(dst, dpitch, src, spitch, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2D_spt(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                src::Ptr{Cvoid}, spitch::Csize_t,
                                                width::Csize_t, height::Csize_t,
                                                kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DFromArray_spt(dst, dpitch, src, wOffset, hOffset, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DFromArray_spt(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                         src::hipArray_const_t,
                                                         wOffset::Csize_t, hOffset::Csize_t,
                                                         width::Csize_t, height::Csize_t,
                                                         kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy3D_spt(p)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3D_spt(p::Ptr{hipMemcpy3DParms})::hipError_t)
end

function hipMemset_spt(dst, value, sizeBytes)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset_spt(dst::Ptr{Cvoid}, value::Cint,
                                              sizeBytes::Csize_t)::hipError_t)
end

function hipMemsetAsync_spt(dst, value, sizeBytes, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemsetAsync_spt(dst::Ptr{Cvoid}, value::Cint,
                                                   sizeBytes::Csize_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemset2D_spt(dst, pitch, value, width, height)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset2D_spt(dst::Ptr{Cvoid}, pitch::Csize_t,
                                                value::Cint, width::Csize_t,
                                                height::Csize_t)::hipError_t)
end

function hipMemset2DAsync_spt(dst, pitch, value, width, height, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset2DAsync_spt(dst::Ptr{Cvoid}, pitch::Csize_t,
                                                     value::Cint, width::Csize_t,
                                                     height::Csize_t,
                                                     stream::hipStream_t)::hipError_t)
end

function hipMemset3DAsync_spt(pitchedDevPtr, value, extent, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset3DAsync_spt(pitchedDevPtr::hipPitchedPtr,
                                                     value::Cint, extent::hipExtent,
                                                     stream::hipStream_t)::hipError_t)
end

function hipMemset3D_spt(pitchedDevPtr, value, extent)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemset3D_spt(pitchedDevPtr::hipPitchedPtr, value::Cint,
                                                extent::hipExtent)::hipError_t)
end

function hipMemcpyAsync_spt(dst, src, sizeBytes, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyAsync_spt(dst::Ptr{Cvoid}, src::Ptr{Cvoid},
                                                   sizeBytes::Csize_t, kind::hipMemcpyKind,
                                                   stream::hipStream_t)::hipError_t)
end

function hipMemcpy3DAsync_spt(p, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy3DAsync_spt(p::Ptr{hipMemcpy3DParms},
                                                     stream::hipStream_t)::hipError_t)
end

function hipMemcpy2DAsync_spt(dst, dpitch, src, spitch, width, height, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DAsync_spt(dst::Ptr{Cvoid}, dpitch::Csize_t,
                                                     src::Ptr{Cvoid}, spitch::Csize_t,
                                                     width::Csize_t, height::Csize_t,
                                                     kind::hipMemcpyKind,
                                                     stream::hipStream_t)::hipError_t)
end

function hipMemcpyFromSymbolAsync_spt(dst, symbol, sizeBytes, offset, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromSymbolAsync_spt(dst::Ptr{Cvoid},
                                                             symbol::Ptr{Cvoid},
                                                             sizeBytes::Csize_t,
                                                             offset::Csize_t,
                                                             kind::hipMemcpyKind,
                                                             stream::hipStream_t)::hipError_t)
end

function hipMemcpyToSymbolAsync_spt(symbol, src, sizeBytes, offset, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyToSymbolAsync_spt(symbol::Ptr{Cvoid},
                                                           src::Ptr{Cvoid},
                                                           sizeBytes::Csize_t,
                                                           offset::Csize_t,
                                                           kind::hipMemcpyKind,
                                                           stream::hipStream_t)::hipError_t)
end

function hipMemcpyFromArray_spt(dst, src, wOffsetSrc, hOffset, count, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpyFromArray_spt(dst::Ptr{Cvoid},
                                                       src::hipArray_const_t,
                                                       wOffsetSrc::Csize_t,
                                                       hOffset::Csize_t, count::Csize_t,
                                                       kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DToArray_spt(dst, wOffset, hOffset, src, spitch, width, height, kind)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DToArray_spt(dst::hipArray_t, wOffset::Csize_t,
                                                       hOffset::Csize_t, src::Ptr{Cvoid},
                                                       spitch::Csize_t, width::Csize_t,
                                                       height::Csize_t,
                                                       kind::hipMemcpyKind)::hipError_t)
end

function hipMemcpy2DFromArrayAsync_spt(dst, dpitch, src, wOffsetSrc, hOffsetSrc, width,
                                       height, kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DFromArrayAsync_spt(dst::Ptr{Cvoid},
                                                              dpitch::Csize_t,
                                                              src::hipArray_const_t,
                                                              wOffsetSrc::Csize_t,
                                                              hOffsetSrc::Csize_t,
                                                              width::Csize_t,
                                                              height::Csize_t,
                                                              kind::hipMemcpyKind,
                                                              stream::hipStream_t)::hipError_t)
end

function hipMemcpy2DToArrayAsync_spt(dst, wOffset, hOffset, src, spitch, width, height,
                                     kind, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipMemcpy2DToArrayAsync_spt(dst::hipArray_t,
                                                            wOffset::Csize_t,
                                                            hOffset::Csize_t,
                                                            src::Ptr{Cvoid},
                                                            spitch::Csize_t, width::Csize_t,
                                                            height::Csize_t,
                                                            kind::hipMemcpyKind,
                                                            stream::hipStream_t)::hipError_t)
end

function hipStreamQuery_spt(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamQuery_spt(stream::hipStream_t)::hipError_t)
end

function hipStreamSynchronize_spt(stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamSynchronize_spt(stream::hipStream_t)::hipError_t)
end

function hipStreamGetPriority_spt(stream, priority)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetPriority_spt(stream::hipStream_t,
                                                         priority::Ptr{Cint})::hipError_t)
end

function hipStreamWaitEvent_spt(stream, event, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamWaitEvent_spt(stream::hipStream_t,
                                                       event::hipEvent_t,
                                                       flags::Cuint)::hipError_t)
end

function hipStreamGetFlags_spt(stream, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetFlags_spt(stream::hipStream_t,
                                                      flags::Ptr{Cuint})::hipError_t)
end

function hipStreamAddCallback_spt(stream, callback, userData, flags)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamAddCallback_spt(stream::hipStream_t,
                                                         callback::hipStreamCallback_t,
                                                         userData::Ptr{Cvoid},
                                                         flags::Cuint)::hipError_t)
end

function hipEventRecord_spt(event, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipEventRecord_spt(event::hipEvent_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipLaunchCooperativeKernel_spt(f, gridDim, blockDim, kernelParams, sharedMemBytes,
                                        hStream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchCooperativeKernel_spt(f::Ptr{Cvoid}, gridDim::dim3,
                                                               blockDim::dim3,
                                                               kernelParams::Ptr{Ptr{Cvoid}},
                                                               sharedMemBytes::UInt32,
                                                               hStream::hipStream_t)::hipError_t)
end

function hipLaunchKernel_spt(function_address, numBlocks, dimBlocks, args, sharedMemBytes,
                             stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchKernel_spt(function_address::Ptr{Cvoid},
                                                    numBlocks::dim3, dimBlocks::dim3,
                                                    args::Ptr{Ptr{Cvoid}},
                                                    sharedMemBytes::Csize_t,
                                                    stream::hipStream_t)::hipError_t)
end

function hipGraphLaunch_spt(graphExec, stream)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGraphLaunch_spt(graphExec::hipGraphExec_t,
                                                   stream::hipStream_t)::hipError_t)
end

function hipStreamBeginCapture_spt(stream, mode)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamBeginCapture_spt(stream::hipStream_t,
                                                          mode::hipStreamCaptureMode)::hipError_t)
end

function hipStreamEndCapture_spt(stream, pGraph)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamEndCapture_spt(stream::hipStream_t,
                                                        pGraph::Ptr{hipGraph_t})::hipError_t)
end

function hipStreamIsCapturing_spt(stream, pCaptureStatus)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamIsCapturing_spt(stream::hipStream_t,
                                                         pCaptureStatus::Ptr{hipStreamCaptureStatus})::hipError_t)
end

function hipStreamGetCaptureInfo_spt(stream, pCaptureStatus, pId)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetCaptureInfo_spt(stream::hipStream_t,
                                                            pCaptureStatus::Ptr{hipStreamCaptureStatus},
                                                            pId::Ptr{Culonglong})::hipError_t)
end

function hipStreamGetCaptureInfo_v2_spt(stream, captureStatus_out, id_out, graph_out,
                                        dependencies_out, numDependencies_out)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipStreamGetCaptureInfo_v2_spt(stream::hipStream_t,
                                                               captureStatus_out::Ptr{hipStreamCaptureStatus},
                                                               id_out::Ptr{Culonglong},
                                                               graph_out::Ptr{hipGraph_t},
                                                               dependencies_out::Ptr{Ptr{hipGraphNode_t}},
                                                               numDependencies_out::Ptr{Csize_t})::hipError_t)
end

function hipLaunchHostFunc_spt(stream, fn, userData)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipLaunchHostFunc_spt(stream::hipStream_t, fn::hipHostFn_t,
                                                      userData::Ptr{Cvoid})::hipError_t)
end

function hipGetDriverEntryPoint_spt(symbol, funcPtr, flags, status)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetDriverEntryPoint_spt(symbol::Cstring,
                                                           funcPtr::Ptr{Ptr{Cvoid}},
                                                           flags::Culonglong,
                                                           status::Ptr{hipDriverEntryPointQueryResult})::hipError_t)
end

function hipGetProcAddress_spt(symbol, pfn, hipVersion, flags, symbolStatus)
    AMDGPU.prepare_state()
    @check @gcsafe_ccall(libhip.hipGetProcAddress_spt(symbol::Cstring, pfn::Ptr{Ptr{Cvoid}},
                                                      hipVersion::Cint, flags::UInt64,
                                                      symbolStatus::Ptr{hipDriverProcAddressQueryResult})::hipError_t)
end

struct var"##Ctag#279"
    ptr::Ptr{Cvoid}
    rowLength::Csize_t
    layerHeight::Csize_t
    locHint::hipMemLocation
end
function Base.getproperty(x::Ptr{var"##Ctag#279"}, f::Symbol)
    f === :ptr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :rowLength && return Ptr{Csize_t}(x + 8)
    f === :layerHeight && return Ptr{Csize_t}(x + 16)
    f === :locHint && return Ptr{hipMemLocation}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#279", f::Symbol)
    r = Ref{var"##Ctag#279"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#279"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#279"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#280"
    array::hipArray_t
    offset::hipOffset3D
end
function Base.getproperty(x::Ptr{var"##Ctag#280"}, f::Symbol)
    f === :array && return Ptr{hipArray_t}(x + 0)
    f === :offset && return Ptr{hipOffset3D}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#280", f::Symbol)
    r = Ref{var"##Ctag#280"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#280"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#280"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#283"
    level::Cuint
    layer::Cuint
    offsetX::Cuint
    offsetY::Cuint
    offsetZ::Cuint
    extentWidth::Cuint
    extentHeight::Cuint
    extentDepth::Cuint
end
function Base.getproperty(x::Ptr{var"##Ctag#283"}, f::Symbol)
    f === :level && return Ptr{Cuint}(x + 0)
    f === :layer && return Ptr{Cuint}(x + 4)
    f === :offsetX && return Ptr{Cuint}(x + 8)
    f === :offsetY && return Ptr{Cuint}(x + 12)
    f === :offsetZ && return Ptr{Cuint}(x + 16)
    f === :extentWidth && return Ptr{Cuint}(x + 20)
    f === :extentHeight && return Ptr{Cuint}(x + 24)
    f === :extentDepth && return Ptr{Cuint}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#283", f::Symbol)
    r = Ref{var"##Ctag#283"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#283"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#283"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#284"
    layer::Cuint
    offset::Culonglong
    size::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#284"}, f::Symbol)
    f === :layer && return Ptr{Cuint}(x + 0)
    f === :offset && return Ptr{Culonglong}(x + 8)
    f === :size && return Ptr{Culonglong}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#284", f::Symbol)
    r = Ref{var"##Ctag#284"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#284"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#284"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#291"
    handle::Ptr{Cvoid}
    name::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{var"##Ctag#291"}, f::Symbol)
    f === :handle && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :name && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#291", f::Symbol)
    r = Ref{var"##Ctag#291"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#291"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#291"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#293"
    array::hipArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#293"}, f::Symbol)
    f === :array && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#293", f::Symbol)
    r = Ref{var"##Ctag#293"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#293"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#293"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#294"
    mipmap::hipMipmappedArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#294"}, f::Symbol)
    f === :mipmap && return Ptr{hipMipmappedArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#294", f::Symbol)
    r = Ref{var"##Ctag#294"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#294"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#294"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#295"
    devPtr::Ptr{Cvoid}
    desc::hipChannelFormatDesc
    sizeInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#295"}, f::Symbol)
    f === :devPtr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :desc && return Ptr{hipChannelFormatDesc}(x + 8)
    f === :sizeInBytes && return Ptr{Csize_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#295", f::Symbol)
    r = Ref{var"##Ctag#295"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#295"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#295"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#296"
    devPtr::Ptr{Cvoid}
    desc::hipChannelFormatDesc
    width::Csize_t
    height::Csize_t
    pitchInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#296"}, f::Symbol)
    f === :devPtr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :desc && return Ptr{hipChannelFormatDesc}(x + 8)
    f === :width && return Ptr{Csize_t}(x + 32)
    f === :height && return Ptr{Csize_t}(x + 40)
    f === :pitchInBytes && return Ptr{Csize_t}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#296", f::Symbol)
    r = Ref{var"##Ctag#296"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#296"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#296"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct hipStreamMemOpWaitValueParams_t
    data::NTuple{40,UInt8}
end

function Base.getproperty(x::Ptr{hipStreamMemOpWaitValueParams_t}, f::Symbol)
    f === :operation && return Ptr{hipStreamBatchMemOpType}(x + 0)
    f === :address && return Ptr{hipDeviceptr_t}(x + 8)
    f === :value && return Ptr{UInt32}(x + 16)
    f === :value64 && return Ptr{UInt64}(x + 16)
    f === :flags && return Ptr{Cuint}(x + 24)
    f === :alias && return Ptr{hipDeviceptr_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::hipStreamMemOpWaitValueParams_t, f::Symbol)
    r = Ref{hipStreamMemOpWaitValueParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipStreamMemOpWaitValueParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipStreamMemOpWaitValueParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipStreamMemOpWaitValueParams_t, private::Bool=false)
    return (:operation, :address, :value, :value64, :flags, :alias,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipStreamMemOpWriteValueParams_t
    data::NTuple{40,UInt8}
end

function Base.getproperty(x::Ptr{hipStreamMemOpWriteValueParams_t}, f::Symbol)
    f === :operation && return Ptr{hipStreamBatchMemOpType}(x + 0)
    f === :address && return Ptr{hipDeviceptr_t}(x + 8)
    f === :value && return Ptr{UInt32}(x + 16)
    f === :value64 && return Ptr{UInt64}(x + 16)
    f === :flags && return Ptr{Cuint}(x + 24)
    f === :alias && return Ptr{hipDeviceptr_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::hipStreamMemOpWriteValueParams_t, f::Symbol)
    r = Ref{hipStreamMemOpWriteValueParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipStreamMemOpWriteValueParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipStreamMemOpWriteValueParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipStreamMemOpWriteValueParams_t, private::Bool=false)
    return (:operation, :address, :value, :value64, :flags, :alias,
            if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipStreamMemOpFlushRemoteWritesParams_t
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipStreamMemOpFlushRemoteWritesParams_t}, f::Symbol)
    f === :operation && return Ptr{hipStreamBatchMemOpType}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::hipStreamMemOpFlushRemoteWritesParams_t, f::Symbol)
    r = Ref{hipStreamMemOpFlushRemoteWritesParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipStreamMemOpFlushRemoteWritesParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipStreamMemOpFlushRemoteWritesParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipStreamMemOpFlushRemoteWritesParams_t, private::Bool=false)
    return (:operation, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct hipStreamMemOpMemoryBarrierParams_t
    data::NTuple{8,UInt8}
end

function Base.getproperty(x::Ptr{hipStreamMemOpMemoryBarrierParams_t}, f::Symbol)
    f === :operation && return Ptr{hipStreamBatchMemOpType}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::hipStreamMemOpMemoryBarrierParams_t, f::Symbol)
    r = Ref{hipStreamMemOpMemoryBarrierParams_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipStreamMemOpMemoryBarrierParams_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipStreamMemOpMemoryBarrierParams_t}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

function Base.propertynames(x::hipStreamMemOpMemoryBarrierParams_t, private::Bool=false)
    return (:operation, :flags, if private
                fieldnames(typeof(x))
            else
                ()
            end...)
end

struct var"##Ctag#298"
    handle::Ptr{Cvoid}
    name::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{var"##Ctag#298"}, f::Symbol)
    f === :handle && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :name && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#298", f::Symbol)
    r = Ref{var"##Ctag#298"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#298"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#298"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#300"
    hArray::hipArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#300"}, f::Symbol)
    f === :hArray && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#300", f::Symbol)
    r = Ref{var"##Ctag#300"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#300"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#300"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#301"
    hMipmappedArray::hipMipmappedArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#301"}, f::Symbol)
    f === :hMipmappedArray && return Ptr{hipMipmappedArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#301", f::Symbol)
    r = Ref{var"##Ctag#301"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#301"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#301"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#302"
    devPtr::hipDeviceptr_t
    format::hipArray_Format
    numChannels::Cuint
    sizeInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#302"}, f::Symbol)
    f === :devPtr && return Ptr{hipDeviceptr_t}(x + 0)
    f === :format && return Ptr{hipArray_Format}(x + 8)
    f === :numChannels && return Ptr{Cuint}(x + 12)
    f === :sizeInBytes && return Ptr{Csize_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#302", f::Symbol)
    r = Ref{var"##Ctag#302"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#302"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#302"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#303"
    devPtr::hipDeviceptr_t
    format::hipArray_Format
    numChannels::Cuint
    width::Csize_t
    height::Csize_t
    pitchInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#303"}, f::Symbol)
    f === :devPtr && return Ptr{hipDeviceptr_t}(x + 0)
    f === :format && return Ptr{hipArray_Format}(x + 8)
    f === :numChannels && return Ptr{Cuint}(x + 12)
    f === :width && return Ptr{Csize_t}(x + 16)
    f === :height && return Ptr{Csize_t}(x + 24)
    f === :pitchInBytes && return Ptr{Csize_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#303", f::Symbol)
    r = Ref{var"##Ctag#303"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#303"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#303"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#304"
    reserved::NTuple{32,Cint}
end
function Base.getproperty(x::Ptr{var"##Ctag#304"}, f::Symbol)
    f === :reserved && return Ptr{NTuple{32,Cint}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#304", f::Symbol)
    r = Ref{var"##Ctag#304"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#304"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#304"}, f::Symbol, v)
    return unsafe_store!(getproperty(x, f), v)
end

const HIP_VERSION_MAJOR = 7

const HIP_VERSION_MINOR = 2

const HIP_VERSION_PATCH = 53150

const HIP_VERSION_GITHASH = "494cbb3b9b"

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

const GENERIC_GRID_LAUNCH = 1

# Skipping MacroDefinition: __forceinline__ inline

const HIP_TRSA_OVERRIDE_FORMAT = 0x01

const HIP_TRSF_READ_AS_INTEGER = 0x01

const HIP_TRSF_NORMALIZED_COORDINATES = 0x02

const HIP_TRSF_SRGB = 0x10

const __HIP_USE_NATIVE_VECTOR__ = 1

const hipTextureType1D = 0x01

const hipTextureType2D = 0x02

const hipTextureType3D = 0x03

const hipTextureTypeCubemap = 0x0c

const hipTextureType1DLayered = 0xf1

const hipTextureType2DLayered = 0xf2

const hipTextureTypeCubemapLayered = 0xfc

const HIP_IMAGE_OBJECT_SIZE_DWORD = 12

const HIP_SAMPLER_OBJECT_SIZE_DWORD = 8

const HIP_SAMPLER_OBJECT_OFFSET_DWORD = HIP_IMAGE_OBJECT_SIZE_DWORD

const HIP_TEXTURE_OBJECT_SIZE_DWORD = HIP_IMAGE_OBJECT_SIZE_DWORD +
                                      HIP_SAMPLER_OBJECT_SIZE_DWORD

const HIP_DEPRECATED_MSG = ("This API is marked as deprecated and might not be supported in future releases. For more details please refer ")("https://github.com/ROCm/HIP/blob/develop/docs/reference/deprecated_api_list.md")

# Skipping MacroDefinition: HIP_LAUNCH_PARAM_BUFFER_POINTER ( ( void * ) 0x01 )

# Skipping MacroDefinition: HIP_LAUNCH_PARAM_BUFFER_SIZE ( ( void * ) 0x02 )

# Skipping MacroDefinition: HIP_LAUNCH_PARAM_END ( ( void * ) 0x03 )

const hipIpcMemLazyEnablePeerAccess = 0x01

const HIP_IPC_HANDLE_SIZE = 64

const hipStreamDefault = 0x00

const hipStreamNonBlocking = 0x01

const hipEventDefault = 0x00

const hipEventBlockingSync = 0x01

const hipEventDisableTiming = 0x02

const hipEventInterprocess = 0x04

const hipEventRecordDefault = 0x00

const hipEventRecordExternal = 0x01

const hipEventWaitDefault = 0x00

const hipEventWaitExternal = 0x01

const hipEventDisableSystemFence = 0x20000000

const hipEventReleaseToDevice = 0x40000000

const hipEventReleaseToSystem = 0x80000000

const hipEnableDefault = 0x00

const hipEnableLegacyStream = 0x01

const hipEnablePerThreadDefaultStream = 0x02

const hipHostAllocDefault = 0x00

const hipHostMallocDefault = 0x00

const hipHostAllocPortable = 0x01

const hipHostMallocPortable = 0x01

const hipHostAllocMapped = 0x02

const hipHostMallocMapped = 0x02

const hipHostAllocWriteCombined = 0x04

const hipHostMallocWriteCombined = 0x04

const hipHostMallocUncached = 0x10000000

const hipHostAllocUncached = hipHostMallocUncached

const hipHostMallocNumaUser = 0x20000000

const hipHostMallocCoherent = 0x40000000

const hipHostMallocNonCoherent = 0x80000000

const hipMemAttachGlobal = 0x01

const hipMemAttachHost = 0x02

const hipMemAttachSingle = 0x04

const hipDeviceMallocDefault = 0x00

const hipDeviceMallocFinegrained = 0x01

const hipMallocSignalMemory = 0x02

const hipDeviceMallocUncached = 0x03

const hipDeviceMallocContiguous = 0x04

const hipHostRegisterDefault = 0x00

const hipHostRegisterPortable = 0x01

const hipHostRegisterMapped = 0x02

const hipHostRegisterIoMemory = 0x04

const hipHostRegisterReadOnly = 0x08

const hipExtHostRegisterCoarseGrained = 0x08

const hipExtHostRegisterUncached = 0x80000000

const hipDeviceScheduleAuto = 0x00

const hipDeviceScheduleSpin = 0x01

const hipDeviceScheduleYield = 0x02

const hipDeviceScheduleBlockingSync = 0x04

const hipDeviceScheduleMask = 0x07

const hipDeviceMapHost = 0x08

const hipDeviceLmemResizeToMax = 0x10

const hipArrayDefault = 0x00

const hipArrayLayered = 0x01

const hipArraySurfaceLoadStore = 0x02

const hipArrayCubemap = 0x04

const hipArrayTextureGather = 0x08

const hipOccupancyDefault = 0x00

const hipOccupancyDisableCachingOverride = 0x01

const hipCooperativeLaunchMultiDeviceNoPreSync = 0x01

const hipCooperativeLaunchMultiDeviceNoPostSync = 0x02

const hipCpuDeviceId = Cint(-1)

const hipInvalidDeviceId = Cint(-2)

const hipExtAnyOrderLaunch = 0x01

const hipStreamWaitValueGte = 0x00

const hipStreamWaitValueEq = 0x01

const hipStreamWaitValueAnd = 0x02

const hipStreamWaitValueNor = 0x03

const hipStreamPerThread = hipStream_t(2)

const hipStreamLegacy = hipStream_t(1)

const hipExternalMemoryDedicated = 0x01

const hipStreamAttrID = hipLaunchAttributeID

const hipStreamAttributeAccessPolicyWindow = hipLaunchAttributeAccessPolicyWindow

const hipStreamAttributeSynchronizationPolicy = hipLaunchAttributeSynchronizationPolicy

const hipStreamAttributeMemSyncDomainMap = hipLaunchAttributeMemSyncDomainMap

const hipStreamAttributeMemSyncDomain = hipLaunchAttributeMemSyncDomain

const hipStreamAttributePriority = hipLaunchAttributePriority

const hipStreamAttrValue = hipLaunchAttributeValue

const hipKernelNodeAttrID = hipLaunchAttributeID

const hipKernelNodeAttributeAccessPolicyWindow = hipLaunchAttributeAccessPolicyWindow

const hipKernelNodeAttributeCooperative = hipLaunchAttributeCooperative

const hipKernelNodeAttributePriority = hipLaunchAttributePriority

const hipKernelNodeAttrValue = hipLaunchAttributeValue

const hipDrvLaunchAttributeCooperative = hipLaunchAttributeCooperative

const hipDrvLaunchAttributeID = hipLaunchAttributeID

const hipDrvLaunchAttributeValue = hipLaunchAttributeValue

const hipDrvLaunchAttribute = hipLaunchAttribute

const hipGraphKernelNodePortDefault = 0

const hipGraphKernelNodePortLaunchCompletion = 2

const hipGraphKernelNodePortProgrammatic = 1
