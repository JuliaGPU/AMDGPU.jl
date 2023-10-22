using CEnum

@cenum var"##Ctag#225"::UInt32 begin
    HIP_SUCCESS = 0
    HIP_ERROR_INVALID_VALUE = 1
    HIP_ERROR_NOT_INITIALIZED = 2
    HIP_ERROR_LAUNCH_OUT_OF_RESOURCES = 3
end

struct hipDeviceArch_t
    hasGlobalInt32Atomics::Cuint
    hasGlobalFloatAtomicExch::Cuint
    hasSharedInt32Atomics::Cuint
    hasSharedFloatAtomicExch::Cuint
    hasFloatAtomicAdd::Cuint
    hasGlobalInt64Atomics::Cuint
    hasSharedInt64Atomics::Cuint
    hasDoubles::Cuint
    hasWarpVote::Cuint
    hasWarpBallot::Cuint
    hasWarpShuffle::Cuint
    hasFunnelShift::Cuint
    hasThreadFenceSystem::Cuint
    hasSyncThreadsExt::Cuint
    hasSurfaceFuncs::Cuint
    has3dGrid::Cuint
    hasDynamicParallelism::Cuint
end

struct hipUUID_t
    bytes::NTuple{16, Cchar}
end

const hipUUID = hipUUID_t

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

@cenum hipMemoryType::UInt32 begin
    hipMemoryTypeHost = 0
    hipMemoryTypeDevice = 1
    hipMemoryTypeArray = 2
    hipMemoryTypeUnified = 3
    hipMemoryTypeManaged = 4
end

struct hipPointerAttribute_t
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{hipPointerAttribute_t}, f::Symbol)
    f === :memoryType && return Ptr{hipMemoryType}(x + 0)
    f === :type && return Ptr{hipMemoryType}(x + 0)
    f === :device && return Ptr{Cint}(x + 4)
    f === :devicePointer && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :hostPointer && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :isManaged && return Ptr{Cint}(x + 24)
    f === :allocationFlags && return Ptr{Cuint}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::hipPointerAttribute_t, f::Symbol)
    r = Ref{hipPointerAttribute_t}(x)
    ptr = Base.unsafe_convert(Ptr{hipPointerAttribute_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipPointerAttribute_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
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
    hipErrorUnknown = 999
    hipErrorRuntimeMemory = 1052
    hipErrorRuntimeOther = 1053
    hipErrorTbd = 1054
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
    hipDeviceAttributeName = 64
    hipDeviceAttributePageableMemoryAccess = 65
    hipDeviceAttributePageableMemoryAccessUsesHostPageTables = 66
    hipDeviceAttributePciBusId = 67
    hipDeviceAttributePciDeviceId = 68
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
    hipDeviceAttributeUuid = 86
    hipDeviceAttributeWarpSize = 87
    hipDeviceAttributeMemoryPoolsSupported = 88
    hipDeviceAttributeVirtualMemoryManagementSupported = 89
    hipDeviceAttributeCudaCompatibleEnd = 9999
    hipDeviceAttributeAmdSpecificBegin = 10000
    hipDeviceAttributeClockInstructionRate = 10000
    hipDeviceAttributeArch = 10001
    hipDeviceAttributeMaxSharedMemoryPerMultiprocessor = 10002
    hipDeviceAttributeGcnArch = 10003
    hipDeviceAttributeGcnArchName = 10004
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
    hipDeviceAttributeAmdSpecificEnd = 19999
    hipDeviceAttributeVendorSpecificBegin = 20000
end

@cenum hipComputeMode::UInt32 begin
    hipComputeModeDefault = 0
    hipComputeModeExclusive = 1
    hipComputeModeProhibited = 2
    hipComputeModeExclusiveProcess = 3
end

const HIP_VERSION_MAJOR = 5

const HIP_VERSION_MINOR = 6

const HIP_VERSION_PATCH = 31062

const HIP_VERSION_GITHASH = "73ed8adfd"

const HIP_VERSION_BUILD_ID = 0

const HIP_VERSION_BUILD_NAME = ""

const HIP_VERSION = HIP_VERSION_MAJOR * 10000000 + HIP_VERSION_MINOR * 100000 + HIP_VERSION_PATCH

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

