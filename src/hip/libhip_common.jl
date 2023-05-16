const HIP_LAUNCH_PARAM_BUFFER_POINTER = Ptr{Cvoid}(1)
const HIP_LAUNCH_PARAM_BUFFER_SIZE = Ptr{Cvoid}(2)
const HIP_LAUNCH_PARAM_END = Ptr{Cvoid}(3)

@cenum hiprtcResult::UInt32 begin
    HIPRTC_SUCCESS = 0
    HIPRTC_ERROR_OUT_OF_MEMORY = 1
    HIPRTC_ERROR_PROGRAM_CREATION_FAILURE = 2
    HIPRTC_ERROR_INVALID_INPUT = 3
    HIPRTC_ERROR_INVALID_PROGRAM = 4
    HIPRTC_ERROR_INVALID_OPTION = 5
    HIPRTC_ERROR_COMPILATION = 6
    HIPRTC_ERROR_BUILTIN_OPERATION_FAILURE = 7
    HIPRTC_ERROR_NO_NAME_EXPRESSIONS_AFTER_COMPILATION = 8
    HIPRTC_ERROR_NO_LOWERED_NAMES_BEFORE_COMPILATION = 9
    HIPRTC_ERROR_NAME_EXPRESSION_NOT_VALID = 10
    HIPRTC_ERROR_INTERNAL_ERROR = 11
    HIPRTC_ERROR_LINKING = 100
end

@cenum hiprtcJIT_option::UInt32 begin
    HIPRTC_JIT_MAX_REGISTERS = 0
    HIPRTC_JIT_THREADS_PER_BLOCK
    HIPRTC_JIT_WALL_TIME
    HIPRTC_JIT_INFO_LOG_BUFFER
    HIPRTC_JIT_INFO_LOG_BUFFER_SIZE_BYTES
    HIPRTC_JIT_ERROR_LOG_BUFFER
    HIPRTC_JIT_ERROR_LOG_BUFFER_SIZE_BYTES
    HIPRTC_JIT_OPTIMIZATION_LEVEL
    HIPRTC_JIT_TARGET_FROM_HIPCONTEXT
    HIPRTC_JIT_TARGET
    HIPRTC_JIT_FALLBACK_STRATEGY
    HIPRTC_JIT_GENERATE_DEBUG_INFO
    HIPRTC_JIT_LOG_VERBOSE
    HIPRTC_JIT_GENERATE_LINE_INFO
    HIPRTC_JIT_CACHE_MODE
    HIPRTC_JIT_NEW_SM3X_OPT
    HIPRTC_JIT_FAST_COMPILE
    HIPRTC_JIT_GLOBAL_SYMBOL_NAMES
    HIPRTC_JIT_GLOBAL_SYMBOL_ADDRESS
    HIPRTC_JIT_GLOBAL_SYMBOL_COUNT
    HIPRTC_JIT_LTO
    HIPRTC_JIT_FTZ
    HIPRTC_JIT_PREC_DIV
    HIPRTC_JIT_PREC_SQRT
    HIPRTC_JIT_FMA
    HIPRTC_JIT_NUM_OPTIONS
end

@cenum hiprtcJITInputType::UInt32 begin
    HIPRTC_JIT_INPUT_CUBIN = 0
    HIPRTC_JIT_INPUT_PTX
    HIPRTC_JIT_INPUT_FATBINARY
    HIPRTC_JIT_INPUT_OBJECT
    HIPRTC_JIT_INPUT_LIBRARY
    HIPRTC_JIT_INPUT_NVVM
    HIPRTC_JIT_NUM_LEGACY_INPUT_TYPES
    HIPRTC_JIT_INPUT_LLVM_BITCODE = 100
    HIPRTC_JIT_INPUT_LLVM_BUNDLED_BITCODE = 101
    HIPRTC_JIT_INPUT_LLVM_ARCHIVES_OF_BUNDLED_BITCODE = 102
end

@cenum hipLimit_t::UInt32 begin
    hipLimitStackSize = 0
    hipLimitPrintfFifoSize = 1
    hipLimitMallocHeapSize = 2
end

@cenum hipMemAllocationHandleType::UInt32 begin
    hipMemHandleTypeNone = 0
    hipMemHandleTypePosixFileDescriptor = 1
    hipMemHandleTypeWin32 = 2
    hipMemHandleTypeWin32Kmt = 4
end

@cenum hipMemAllocationType::UInt32 begin
    hipMemAllocationTypeInvalid = 0
    hipMemAllocationTypePinned = 1
    hipMemAllocationTypeMax = 2147483647
end

@cenum hipMemLocationType::UInt32 begin
    hipMemLocationTypeInvalid = 0
    hipMemLocationTypeDevice = 1
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

@cenum hipEventFlag_t::Cuint begin
    hipEventDefault = 0
    hipEventDisableTiming = 2
    hipEventInterprocess = 4
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
    hipErrorUnknown = 999
    # HSA Runtime Error Codes start here.
    hipErrorRuntimeMemory = 1052
    hipErrorRuntimeOther = 1053
    hipErrorTbd
end

hipContext_t = Ptr{Cvoid}

hipDevice_t = Ptr{Cvoid}

hipStream_t = Ptr{Cvoid}

hipEvent_t = Ptr{Cvoid}

hipMemPool_t = Ptr{Cvoid}

hipModule_t = Ptr{Cvoid}

hipFunction_t = Ptr{Cvoid}

hiprtcLinkState = Ptr{Cvoid}

struct hipMemLocation
    type::hipMemLocationType
    id::Cint
end

struct hipMemPoolProps
    allocType::hipMemAllocationType
    handleTypes::hipMemAllocationHandleType
    location::hipMemLocation
    win32SecurityAttributes::Ptr{Cvoid}
    reserved::NTuple{64,Cuchar}
end

Base.@kwdef struct hipDeviceArch_t
    hasGlobalInt32Atomics::Cuint = 1
    hasGlobalFloatAtomicExch::Cuint = 1
    hasSharedInt32Atomics::Cuint = 1
    hasSharedFloatAtomicExch::Cuint = 1
    hasFloatAtomicAdd::Cuint = 1

    hasGlobalInt64Atomics::Cuint = 1
    hasSharedInt64Atomics::Cuint = 1

    # Doubles
    hasDoubles::Cuint = 1

    # Warp cross-lane operations
    hasWarpVote::Cuint = 1
    hasWarpBallot::Cuint = 1
    hasWarpShuffle::Cuint = 1
    hasFunnelShift::Cuint = 1

    # Sync
    hasThreadFenceSystem::Cuint = 1
    hasSyncThreadsExt::Cuint = 1

    # Misc
    hasSurfaceFuncs::Cuint = 1
    has3dGrid::Cuint = 1
    hasDynamicParallelism::Cuint = 1
end

function Base.show(io::IO, arch::hipDeviceArch_t)
    print(io,
    """
    struct hipDeviceArch_t
        hasGlobalInt32Atomics = $(arch.hasGlobalInt32Atomics)
        hasGlobalFloatAtomicExch = $(arch.hasGlobalFloatAtomicExch)
        hasSharedInt32Atomics = $(arch.hasSharedInt32Atomics)
        hasSharedFloatAtomicExch = $(arch.hasSharedFloatAtomicExch)
        hasFloatAtomicAdd = $(arch.hasFloatAtomicAdd)

        hasGlobalInt64Atomics = $(arch.hasGlobalInt64Atomics)
        hasSharedInt64Atomics = $(arch.hasSharedInt64Atomics)

        # Doubles
        hasDoubles = $(arch.hasDoubles)

        # Warp cross-lane operations
        hasWarpVote = $(arch.hasWarpVote)
        hasWarpBallot = $(arch.hasWarpBallot)
        hasWarpShuffle = $(arch.hasWarpShuffle)
        hasFunnelShift = $(arch.hasFunnelShift)

        # Sync
        hasThreadFenceSystem = $(arch.hasThreadFenceSystem)
        hasSyncThreadsExt = $(arch.hasSyncThreadsExt)

        # Misc
        hasSurfaceFuncs = $(arch.hasSurfaceFuncs)
        has3dGrid = $(arch.has3dGrid)
        hasDynamicParallelism = $(arch.hasDynamicParallelism)
    end
    """)
end

struct hipDeviceProp_t
    name::NTuple{256, Cchar}
    totalGlobalMem::Csize_t
    sharedMemPerBlock::Csize_t
    regsPerBlock::Cint
    warpSize::Cint
    maxThreadsPerBlock::Cint
    maxThreadsDim::NTuple{3, Cint}
    maxGridSize::NTuple{3, Cint}
    clockRate::Cint
    memoryClockRate::Cint
    memoryBusWidth::Cint
    totalConstMem::Csize_t
    major::Cint
    minor::Cint
    multiProcessorCount::Cint
    l2CacheSize::Cint
    maxThreadsPerMultiProcessor::Cint
    computeMode::Cint
    clockInstructionRate::Cint
    arch::hipDeviceArch_t
    concurrentKernels::Cint
    pciDomainID::Cint
    pciBusID::Cint
    pciDeviceID::Cint
    maxSharedMemoryPerMultiProcessor::Csize_t
    isMultiGpuBoard::Cint
    canMapHostMemory::Cint
    gcnArch::Cint
    gcnArchName::NTuple{256, Cchar}
    integrated::Cint
    cooperativeLaunch::Cint
    cooperativeMultiDeviceLaunch::Cint
    maxTexture1DLinear::Cint
    maxTexture1D::Cint
    maxTexture2D::NTuple{2, Cint}
    maxTexture3D::NTuple{3, Cint}
    hdpMemFlushCntl::Ptr{Cuint}
    hdpRegFlushCntl::Ptr{Cuint}
    memPitch::Csize_t
    textureAlignment::Csize_t
    texturePitchAlignment::Csize_t
    kernelExecTimeoutEnabled::Cint
    ECCEnabled::Cint
    tccDriver::Cint
    cooperativeMultiDeviceUnmatchedFunc::Cint
    cooperativeMultiDeviceUnmatchedGridDim::Cint
    cooperativeMultiDeviceUnmatchedBlockDim::Cint
    cooperativeMultiDeviceUnmatchedSharedMem::Cint
    isLargeBar::Cint
    asicRevision::Cint
    managedMemory::Cint
    directManagedMemAccessFromHost::Cint
    concurrentManagedAccess::Cint
    pageableMemoryAccess::Cint
    pageableMemoryAccessUsesHostPageTables::Cint
end

function Base.show(io::IO, props::hipDeviceProp_t)
    name_ptr = pointer([props.name...])
    gcn_name = pointer([props.gcnArchName...])
    print(io,
    """
    struct hipDeviceProp_t
        name = $(unsafe_string(name_ptr))
        totalGlobalMem = $(Base.format_bytes(props.totalGlobalMem))
        sharedMemPerBlock = $(Base.format_bytes(props.sharedMemPerBlock))
        regsPerBlock = $(props.regsPerBlock)
        warpSize = $(props.warpSize)
        maxThreadsPerBlock = $(props.maxThreadsPerBlock)
        maxThreadsDim = $(props.maxThreadsDim)
        maxGridSize = $(props.maxGridSize)
        clockRate = $(props.clockRate)
        memoryClockRate = $(props.memoryClockRate)
        memoryBusWidth = $(props.memoryBusWidth)
        totalConstMem = $(Base.format_bytes(props.totalConstMem))
        major = $(props.major)
        minor = $(props.minor)
        multiProcessorCount = $(props.multiProcessorCount)
        l2CacheSize = $(Base.format_bytes(props.l2CacheSize))
        maxThreadsPerMultiProcessor = $(props.maxThreadsPerMultiProcessor)
        computeMode = $(props.computeMode)
        clockInstructionRate = $(props.clockInstructionRate)
        arch = [printed separately below]
        concurrentKernels = $(props.concurrentKernels)
        pciBusID = $(props.pciBusID)
        pciDeviceID = $(props.pciDeviceID)
        maxSharedMemoryPerMultiProcessor = $(Base.format_bytes(props.maxSharedMemoryPerMultiProcessor))
        isMultiGpuBoard = $(props.isMultiGpuBoard)
        canMapHostMemory = $(props.canMapHostMemory)
        gcnArch = $(props.gcnArch)
        gcnArchName = $(unsafe_string(gcn_name))
        ...
    end
    """)
    println(io)
    show(io, props.arch)
end

@cenum hipDeviceAttribute_t begin
    hipDeviceAttributeCudaCompatibleBegin = 0

    hipDeviceAttributeEccEnabled = 0
    hipDeviceAttributeAccessPolicyMaxWindowSize
    hipDeviceAttributeAsyncEngineCount
    hipDeviceAttributeCanMapHostMemory
    hipDeviceAttributeCanUseHostPointerForRegisteredMem

    hipDeviceAttributeClockRate
    hipDeviceAttributeComputeMode
    hipDeviceAttributeComputePreemptionSupported
    hipDeviceAttributeConcurrentKernels
    hipDeviceAttributeConcurrentManagedAccess
    hipDeviceAttributeCooperativeLaunch
    hipDeviceAttributeCooperativeMultiDeviceLaunch
    hipDeviceAttributeDeviceOverlap

    hipDeviceAttributeDirectManagedMemAccessFromHost

    hipDeviceAttributeGlobalL1CacheSupported
    hipDeviceAttributeHostNativeAtomicSupported
    hipDeviceAttributeIntegrated
    hipDeviceAttributeIsMultiGpuBoard
    hipDeviceAttributeKernelExecTimeout
    hipDeviceAttributeL2CacheSize
    hipDeviceAttributeLocalL1CacheSupported
    hipDeviceAttributeLuid
    hipDeviceAttributeLuidDeviceNodeMask
    hipDeviceAttributeComputeCapabilityMajor
    hipDeviceAttributeManagedMemory
    hipDeviceAttributeMaxBlocksPerMultiProcessor
    hipDeviceAttributeMaxBlockDimX
    hipDeviceAttributeMaxBlockDimY
    hipDeviceAttributeMaxBlockDimZ
    hipDeviceAttributeMaxGridDimX
    hipDeviceAttributeMaxGridDimY
    hipDeviceAttributeMaxGridDimZ
    hipDeviceAttributeMaxSurface1D
    hipDeviceAttributeMaxSurface1DLayered
    hipDeviceAttributeMaxSurface2D
    hipDeviceAttributeMaxSurface2DLayered
    hipDeviceAttributeMaxSurface3D
    hipDeviceAttributeMaxSurfaceCubemap
    hipDeviceAttributeMaxSurfaceCubemapLayered
    hipDeviceAttributeMaxTexture1DWidth
    hipDeviceAttributeMaxTexture1DLayered
    hipDeviceAttributeMaxTexture1DLinear

    hipDeviceAttributeMaxTexture1DMipmap
    hipDeviceAttributeMaxTexture2DWidth
    hipDeviceAttributeMaxTexture2DHeight
    hipDeviceAttributeMaxTexture2DGather
    hipDeviceAttributeMaxTexture2DLayered
    hipDeviceAttributeMaxTexture2DLinear
    hipDeviceAttributeMaxTexture2DMipmap
    hipDeviceAttributeMaxTexture3DWidth
    hipDeviceAttributeMaxTexture3DHeight
    hipDeviceAttributeMaxTexture3DDepth
    hipDeviceAttributeMaxTexture3DAlt
    hipDeviceAttributeMaxTextureCubemap
    hipDeviceAttributeMaxTextureCubemapLayered
    hipDeviceAttributeMaxThreadsDim
    hipDeviceAttributeMaxThreadsPerBlock
    hipDeviceAttributeMaxThreadsPerMultiProcessor
    hipDeviceAttributeMaxPitch
    hipDeviceAttributeMemoryBusWidth
    hipDeviceAttributeMemoryClockRate
    hipDeviceAttributeComputeCapabilityMinor
    hipDeviceAttributeMultiGpuBoardGroupID
    hipDeviceAttributeMultiprocessorCount
    hipDeviceAttributeName
    hipDeviceAttributePageableMemoryAccess

    hipDeviceAttributePageableMemoryAccessUsesHostPageTables
    hipDeviceAttributePciBusId
    hipDeviceAttributePciDeviceId
    hipDeviceAttributePciDomainID
    hipDeviceAttributePersistingL2CacheMaxSize
    hipDeviceAttributeMaxRegistersPerBlock

    hipDeviceAttributeMaxRegistersPerMultiprocessor
    hipDeviceAttributeReservedSharedMemPerBlock
    hipDeviceAttributeMaxSharedMemoryPerBlock
    hipDeviceAttributeSharedMemPerBlockOptin
    hipDeviceAttributeSharedMemPerMultiprocessor
    hipDeviceAttributeSingleToDoublePrecisionPerfRatio
    hipDeviceAttributeStreamPrioritiesSupported
    hipDeviceAttributeSurfaceAlignment
    hipDeviceAttributeTccDriver
    hipDeviceAttributeTextureAlignment
    hipDeviceAttributeTexturePitchAlignment
    hipDeviceAttributeTotalConstantMemory
    hipDeviceAttributeTotalGlobalMem
    hipDeviceAttributeUnifiedAddressing
    hipDeviceAttributeUuid
    hipDeviceAttributeWarpSize
    hipDeviceAttributeMemoryPoolsSupported
    hipDeviceAttributeVirtualMemoryManagementSupported

    hipDeviceAttributeCudaCompatibleEnd = 9999
    hipDeviceAttributeAmdSpecificBegin = 10000

    hipDeviceAttributeClockInstructionRate = 10000
    hipDeviceAttributeArch
    hipDeviceAttributeMaxSharedMemoryPerMultiprocessor
    hipDeviceAttributeGcnArch
    hipDeviceAttributeGcnArchName
    hipDeviceAttributeHdpMemFlushCntl
    hipDeviceAttributeHdpRegFlushCntl
    hipDeviceAttributeCooperativeMultiDeviceUnmatchedFunc

    hipDeviceAttributeCooperativeMultiDeviceUnmatchedGridDim

    hipDeviceAttributeCooperativeMultiDeviceUnmatchedBlockDim

    hipDeviceAttributeCooperativeMultiDeviceUnmatchedSharedMem

    hipDeviceAttributeIsLargeBar
    hipDeviceAttributeAsicRevision
    hipDeviceAttributeCanUseStreamWaitValue

    hipDeviceAttributeImageSupport
    hipDeviceAttributePhysicalMultiProcessorCount

    hipDeviceAttributeFineGrainSupport
    hipDeviceAttributeWallClockRate

    hipDeviceAttributeAmdSpecificEnd = 19999
    hipDeviceAttributeVendorSpecificBegin = 20000
end
