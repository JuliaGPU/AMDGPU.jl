using CEnum

struct hipUUID_t
    bytes::NTuple{16, Cchar}
end

const hipUUID = hipUUID_t

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

struct hipDeviceProp_tR0600
    name::NTuple{256, Cchar}
    uuid::hipUUID
    luid::NTuple{8, Cchar}
    luidDeviceNodeMask::Cuint
    totalGlobalMem::Csize_t
    sharedMemPerBlock::Csize_t
    regsPerBlock::Cint
    warpSize::Cint
    memPitch::Csize_t
    maxThreadsPerBlock::Cint
    maxThreadsDim::NTuple{3, Cint}
    maxGridSize::NTuple{3, Cint}
    clockRate::Cint
    totalConstMem::Csize_t
    major::Cint
    minor::Cint
    textureAlignment::Csize_t
    texturePitchAlignment::Csize_t
    deviceOverlap::Cint
    multiProcessorCount::Cint
    kernelExecTimeoutEnabled::Cint
    integrated::Cint
    canMapHostMemory::Cint
    computeMode::Cint
    maxTexture1D::Cint
    maxTexture1DMipmap::Cint
    maxTexture1DLinear::Cint
    maxTexture2D::NTuple{2, Cint}
    maxTexture2DMipmap::NTuple{2, Cint}
    maxTexture2DLinear::NTuple{3, Cint}
    maxTexture2DGather::NTuple{2, Cint}
    maxTexture3D::NTuple{3, Cint}
    maxTexture3DAlt::NTuple{3, Cint}
    maxTextureCubemap::Cint
    maxTexture1DLayered::NTuple{2, Cint}
    maxTexture2DLayered::NTuple{3, Cint}
    maxTextureCubemapLayered::NTuple{2, Cint}
    maxSurface1D::Cint
    maxSurface2D::NTuple{2, Cint}
    maxSurface3D::NTuple{3, Cint}
    maxSurface1DLayered::NTuple{2, Cint}
    maxSurface2DLayered::NTuple{3, Cint}
    maxSurfaceCubemap::Cint
    maxSurfaceCubemapLayered::NTuple{2, Cint}
    surfaceAlignment::Csize_t
    concurrentKernels::Cint
    ECCEnabled::Cint
    pciBusID::Cint
    pciDeviceID::Cint
    pciDomainID::Cint
    tccDriver::Cint
    asyncEngineCount::Cint
    unifiedAddressing::Cint
    memoryClockRate::Cint
    memoryBusWidth::Cint
    l2CacheSize::Cint
    persistingL2CacheMaxSize::Cint
    maxThreadsPerMultiProcessor::Cint
    streamPrioritiesSupported::Cint
    globalL1CacheSupported::Cint
    localL1CacheSupported::Cint
    sharedMemPerMultiprocessor::Csize_t
    regsPerMultiprocessor::Cint
    managedMemory::Cint
    isMultiGpuBoard::Cint
    multiGpuBoardGroupID::Cint
    hostNativeAtomicSupported::Cint
    singleToDoublePrecisionPerfRatio::Cint
    pageableMemoryAccess::Cint
    concurrentManagedAccess::Cint
    computePreemptionSupported::Cint
    canUseHostPointerForRegisteredMem::Cint
    cooperativeLaunch::Cint
    cooperativeMultiDeviceLaunch::Cint
    sharedMemPerBlockOptin::Csize_t
    pageableMemoryAccessUsesHostPageTables::Cint
    directManagedMemAccessFromHost::Cint
    maxBlocksPerMultiProcessor::Cint
    accessPolicyMaxWindowSize::Cint
    reservedSharedMemPerBlock::Csize_t
    hostRegisterSupported::Cint
    sparseHipArraySupported::Cint
    hostRegisterReadOnlySupported::Cint
    timelineSemaphoreInteropSupported::Cint
    memoryPoolsSupported::Cint
    gpuDirectRDMASupported::Cint
    gpuDirectRDMAFlushWritesOptions::Cuint
    gpuDirectRDMAWritesOrdering::Cint
    memoryPoolSupportedHandleTypes::Cuint
    deferredMappingHipArraySupported::Cint
    ipcEventSupported::Cint
    clusterLaunch::Cint
    unifiedFunctionPointers::Cint
    reserved::NTuple{63, Cint}
    hipReserved::NTuple{32, Cint}
    gcnArchName::NTuple{256, Cchar}
    maxSharedMemoryPerMultiProcessor::Csize_t
    clockInstructionRate::Cint
    arch::hipDeviceArch_t
    hdpMemFlushCntl::Ptr{Cuint}
    hdpRegFlushCntl::Ptr{Cuint}
    cooperativeMultiDeviceUnmatchedFunc::Cint
    cooperativeMultiDeviceUnmatchedGridDim::Cint
    cooperativeMultiDeviceUnmatchedBlockDim::Cint
    cooperativeMultiDeviceUnmatchedSharedMem::Cint
    isLargeBar::Cint
    asicRevision::Cint
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

function hipGetDevicePropertiesR0600(prop, deviceId)
    @ccall libhip.hipGetDevicePropertiesR0600(prop::Ptr{hipDeviceProp_tR0600}, deviceId::Cint)::hipError_t
end

function hipChooseDeviceR0600(device, prop)
    @ccall libhip.hipChooseDeviceR0600(device::Ptr{Cint}, prop::Ptr{hipDeviceProp_tR0600})::hipError_t
end

mutable struct ihipStream_t end

const hipStream_t = Ptr{ihipStream_t}

@cenum var"##Ctag#225"::UInt32 begin
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
    hipDeviceAttributeAmdSpecificEnd = 19999
    hipDeviceAttributeVendorSpecificBegin = 20000
end

@cenum hipComputeMode::UInt32 begin
    hipComputeModeDefault = 0
    hipComputeModeExclusive = 1
    hipComputeModeProhibited = 2
    hipComputeModeExclusiveProcess = 3
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
    addressMode::NTuple{3, HIPaddress_mode}
    filterMode::HIPfilter_mode
    flags::Cuint
    maxAnisotropy::Cuint
    mipmapFilterMode::HIPfilter_mode
    mipmapLevelBias::Cfloat
    minMipmapLevelClamp::Cfloat
    maxMipmapLevelClamp::Cfloat
    borderColor::NTuple{4, Cfloat}
    reserved::NTuple{12, Cint}
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

struct var"##Ctag#277"
    data::NTuple{56, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#277"}, f::Symbol)
    f === :array && return Ptr{var"##Ctag#278"}(x + 0)
    f === :mipmap && return Ptr{var"##Ctag#279"}(x + 0)
    f === :linear && return Ptr{var"##Ctag#280"}(x + 0)
    f === :pitch2D && return Ptr{var"##Ctag#281"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#277", f::Symbol)
    r = Ref{var"##Ctag#277"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#277"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#277"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipResourceDesc
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{hipResourceDesc}, f::Symbol)
    f === :resType && return Ptr{hipResourceType}(x + 0)
    f === :res && return Ptr{var"##Ctag#277"}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::hipResourceDesc, f::Symbol)
    r = Ref{hipResourceDesc}(x)
    ptr = Base.unsafe_convert(Ptr{hipResourceDesc}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipResourceDesc}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#293"
    data::NTuple{128, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#293"}, f::Symbol)
    f === :array && return Ptr{var"##Ctag#294"}(x + 0)
    f === :mipmap && return Ptr{var"##Ctag#295"}(x + 0)
    f === :linear && return Ptr{var"##Ctag#296"}(x + 0)
    f === :pitch2D && return Ptr{var"##Ctag#297"}(x + 0)
    f === :reserved && return Ptr{var"##Ctag#298"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#293", f::Symbol)
    r = Ref{var"##Ctag#293"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#293"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#293"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct HIP_RESOURCE_DESC_st
    data::NTuple{144, UInt8}
end

function Base.getproperty(x::Ptr{HIP_RESOURCE_DESC_st}, f::Symbol)
    f === :resType && return Ptr{HIPresourcetype}(x + 0)
    f === :res && return Ptr{var"##Ctag#293"}(x + 8)
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
    unsafe_store!(getproperty(x, f), v)
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
    reserved::NTuple{16, Cuint}
end

const HIP_RESOURCE_VIEW_DESC = HIP_RESOURCE_VIEW_DESC_st

@cenum hipMemcpyKind::UInt32 begin
    hipMemcpyHostToHost = 0
    hipMemcpyHostToDevice = 1
    hipMemcpyDeviceToHost = 2
    hipMemcpyDeviceToDevice = 3
    hipMemcpyDefault = 4
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

function make_hipPitchedPtr(d, p, xsz, ysz)
    @ccall libhip.make_hipPitchedPtr(d::Ptr{Cvoid}, p::Csize_t, xsz::Csize_t, ysz::Csize_t)::hipPitchedPtr
end

function make_hipPos(x, y, z)
    @ccall libhip.make_hipPos(x::Csize_t, y::Csize_t, z::Csize_t)::hipPos
end

function make_hipExtent(w, h, d)
    @ccall libhip.make_hipExtent(w::Csize_t, h::Csize_t, d::Csize_t)::hipExtent
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
    @ccall libhip.make_uchar1(x::Cuchar)::uchar1
end

function make_uchar2(x, y)
    @ccall libhip.make_uchar2(x::Cuchar, y::Cuchar)::uchar2
end

function make_uchar3(x, y, z)
    @ccall libhip.make_uchar3(x::Cuchar, y::Cuchar, z::Cuchar)::uchar3
end

function make_uchar4(x, y, z, w)
    @ccall libhip.make_uchar4(x::Cuchar, y::Cuchar, z::Cuchar, w::Cuchar)::uchar4
end

function make_char1(x)
    @ccall libhip.make_char1(x::Int8)::char1
end

function make_char2(x, y)
    @ccall libhip.make_char2(x::Int8, y::Int8)::char2
end

function make_char3(x, y, z)
    @ccall libhip.make_char3(x::Int8, y::Int8, z::Int8)::char3
end

function make_char4(x, y, z, w)
    @ccall libhip.make_char4(x::Int8, y::Int8, z::Int8, w::Int8)::char4
end

function make_ushort1(x)
    @ccall libhip.make_ushort1(x::Cushort)::ushort1
end

function make_ushort2(x, y)
    @ccall libhip.make_ushort2(x::Cushort, y::Cushort)::ushort2
end

function make_ushort3(x, y, z)
    @ccall libhip.make_ushort3(x::Cushort, y::Cushort, z::Cushort)::ushort3
end

function make_ushort4(x, y, z, w)
    @ccall libhip.make_ushort4(x::Cushort, y::Cushort, z::Cushort, w::Cushort)::ushort4
end

function make_short1(x)
    @ccall libhip.make_short1(x::Cshort)::short1
end

function make_short2(x, y)
    @ccall libhip.make_short2(x::Cshort, y::Cshort)::short2
end

function make_short3(x, y, z)
    @ccall libhip.make_short3(x::Cshort, y::Cshort, z::Cshort)::short3
end

function make_short4(x, y, z, w)
    @ccall libhip.make_short4(x::Cshort, y::Cshort, z::Cshort, w::Cshort)::short4
end

function make_uint1(x)
    @ccall libhip.make_uint1(x::Cuint)::uint1
end

function make_uint2(x, y)
    @ccall libhip.make_uint2(x::Cuint, y::Cuint)::uint2
end

function make_uint3(x, y, z)
    @ccall libhip.make_uint3(x::Cuint, y::Cuint, z::Cuint)::uint3
end

function make_uint4(x, y, z, w)
    @ccall libhip.make_uint4(x::Cuint, y::Cuint, z::Cuint, w::Cuint)::uint4
end

function make_int1(x)
    @ccall libhip.make_int1(x::Cint)::int1
end

function make_int2(x, y)
    @ccall libhip.make_int2(x::Cint, y::Cint)::int2
end

function make_int3(x, y, z)
    @ccall libhip.make_int3(x::Cint, y::Cint, z::Cint)::int3
end

function make_int4(x, y, z, w)
    @ccall libhip.make_int4(x::Cint, y::Cint, z::Cint, w::Cint)::int4
end

function make_float1(x)
    @ccall libhip.make_float1(x::Cfloat)::float1
end

function make_float2(x, y)
    @ccall libhip.make_float2(x::Cfloat, y::Cfloat)::float2
end

function make_float3(x, y, z)
    @ccall libhip.make_float3(x::Cfloat, y::Cfloat, z::Cfloat)::float3
end

function make_float4(x, y, z, w)
    @ccall libhip.make_float4(x::Cfloat, y::Cfloat, z::Cfloat, w::Cfloat)::float4
end

function make_double1(x)
    @ccall libhip.make_double1(x::Cdouble)::double1
end

function make_double2(x, y)
    @ccall libhip.make_double2(x::Cdouble, y::Cdouble)::double2
end

function make_double3(x, y, z)
    @ccall libhip.make_double3(x::Cdouble, y::Cdouble, z::Cdouble)::double3
end

function make_double4(x, y, z, w)
    @ccall libhip.make_double4(x::Cdouble, y::Cdouble, z::Cdouble, w::Cdouble)::double4
end

function make_ulong1(x)
    @ccall libhip.make_ulong1(x::Culong)::ulong1
end

function make_ulong2(x, y)
    @ccall libhip.make_ulong2(x::Culong, y::Culong)::ulong2
end

function make_ulong3(x, y, z)
    @ccall libhip.make_ulong3(x::Culong, y::Culong, z::Culong)::ulong3
end

function make_ulong4(x, y, z, w)
    @ccall libhip.make_ulong4(x::Culong, y::Culong, z::Culong, w::Culong)::ulong4
end

function make_long1(x)
    @ccall libhip.make_long1(x::Clong)::long1
end

function make_long2(x, y)
    @ccall libhip.make_long2(x::Clong, y::Clong)::long2
end

function make_long3(x, y, z)
    @ccall libhip.make_long3(x::Clong, y::Clong, z::Clong)::long3
end

function make_long4(x, y, z, w)
    @ccall libhip.make_long4(x::Clong, y::Clong, z::Clong, w::Clong)::long4
end

function make_ulonglong1(x)
    @ccall libhip.make_ulonglong1(x::Culonglong)::ulonglong1
end

function make_ulonglong2(x, y)
    @ccall libhip.make_ulonglong2(x::Culonglong, y::Culonglong)::ulonglong2
end

function make_ulonglong3(x, y, z)
    @ccall libhip.make_ulonglong3(x::Culonglong, y::Culonglong, z::Culonglong)::ulonglong3
end

function make_ulonglong4(x, y, z, w)
    @ccall libhip.make_ulonglong4(x::Culonglong, y::Culonglong, z::Culonglong, w::Culonglong)::ulonglong4
end

function make_longlong1(x)
    @ccall libhip.make_longlong1(x::Clonglong)::longlong1
end

function make_longlong2(x, y)
    @ccall libhip.make_longlong2(x::Clonglong, y::Clonglong)::longlong2
end

function make_longlong3(x, y, z)
    @ccall libhip.make_longlong3(x::Clonglong, y::Clonglong, z::Clonglong)::longlong3
end

function make_longlong4(x, y, z, w)
    @ccall libhip.make_longlong4(x::Clonglong, y::Clonglong, z::Clonglong, w::Clonglong)::longlong4
end

function hipCreateChannelDesc(x, y, z, w, f)
    @ccall libhip.hipCreateChannelDesc(x::Cint, y::Cint, z::Cint, w::Cint, f::hipChannelFormatKind)::hipChannelFormatDesc
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
    addressMode::NTuple{3, hipTextureAddressMode}
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
    addressMode::NTuple{3, hipTextureAddressMode}
    filterMode::hipTextureFilterMode
    readMode::hipTextureReadMode
    sRGB::Cint
    borderColor::NTuple{4, Cfloat}
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

struct hipIpcMemHandle_st
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{hipIpcMemHandle_st}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64, Cchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipIpcMemHandle_st, f::Symbol)
    r = Ref{hipIpcMemHandle_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipIpcMemHandle_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipIpcMemHandle_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipIpcMemHandle_t = hipIpcMemHandle_st

struct hipIpcEventHandle_st
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{hipIpcEventHandle_st}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64, Cchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipIpcEventHandle_st, f::Symbol)
    r = Ref{hipIpcEventHandle_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipIpcEventHandle_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipIpcEventHandle_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipIpcEventHandle_t = hipIpcEventHandle_st

mutable struct ihipModule_t end

const hipModule_t = Ptr{ihipModule_t}

mutable struct ihipModuleSymbol_t end

const hipFunction_t = Ptr{ihipModuleSymbol_t}

mutable struct ihipMemPoolHandle_t end

const hipMemPool_t = Ptr{ihipMemPoolHandle_t}

struct hipFuncAttributes
    data::NTuple{56, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

mutable struct ihipEvent_t end

const hipEvent_t = Ptr{ihipEvent_t}

@cenum hipLimit_t::UInt32 begin
    hipLimitStackSize = 0
    hipLimitPrintfFifoSize = 1
    hipLimitMallocHeapSize = 2
    hipLimitRange = 3
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

@cenum hipMemLocationType::UInt32 begin
    hipMemLocationTypeInvalid = 0
    hipMemLocationTypeDevice = 1
end

struct hipMemLocation
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{hipMemLocation}, f::Symbol)
    f === :type && return Ptr{hipMemLocationType}(x + 0)
    f === :id && return Ptr{Cint}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemLocation, f::Symbol)
    r = Ref{hipMemLocation}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemLocation}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemLocation}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

@cenum hipMemAccessFlags::UInt32 begin
    hipMemAccessFlagsProtNone = 0
    hipMemAccessFlagsProtRead = 1
    hipMemAccessFlagsProtReadWrite = 3
end

struct hipMemAccessDesc
    data::NTuple{12, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

@cenum hipMemAllocationType::UInt32 begin
    hipMemAllocationTypeInvalid = 0
    hipMemAllocationTypePinned = 1
    hipMemAllocationTypeMax = 2147483647
end

@cenum hipMemAllocationHandleType::UInt32 begin
    hipMemHandleTypeNone = 0
    hipMemHandleTypePosixFileDescriptor = 1
    hipMemHandleTypeWin32 = 2
    hipMemHandleTypeWin32Kmt = 4
end

struct hipMemPoolProps
    data::NTuple{88, UInt8}
end

function Base.getproperty(x::Ptr{hipMemPoolProps}, f::Symbol)
    f === :allocType && return Ptr{hipMemAllocationType}(x + 0)
    f === :handleTypes && return Ptr{hipMemAllocationHandleType}(x + 4)
    f === :location && return Ptr{hipMemLocation}(x + 8)
    f === :win32SecurityAttributes && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :reserved && return Ptr{NTuple{64, Cuchar}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemPoolProps, f::Symbol)
    r = Ref{hipMemPoolProps}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemPoolProps}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemPoolProps}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipMemPoolPtrExportData
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{hipMemPoolPtrExportData}, f::Symbol)
    f === :reserved && return Ptr{NTuple{64, Cuchar}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemPoolPtrExportData, f::Symbol)
    r = Ref{hipMemPoolPtrExportData}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemPoolPtrExportData}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemPoolPtrExportData}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

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
    hipJitOptionNumOptions = 17
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
    data::NTuple{12, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipLaunchParams_t
    data::NTuple{56, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

const hipLaunchParams = hipLaunchParams_t

struct hipFunctionLaunchParams_t
    data::NTuple{56, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
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

struct var"##Ctag#282"
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#282"}, f::Symbol)
    f === :fd && return Ptr{Cint}(x + 0)
    f === :win32 && return Ptr{var"##Ctag#283"}(x + 0)
    f === :nvSciBufObject && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#282", f::Symbol)
    r = Ref{var"##Ctag#282"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#282"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#282"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalMemoryHandleDesc_st
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{hipExternalMemoryHandleDesc_st}, f::Symbol)
    f === :type && return Ptr{hipExternalMemoryHandleType}(x + 0)
    f === :handle && return Ptr{var"##Ctag#282"}(x + 8)
    f === :size && return Ptr{Culonglong}(x + 24)
    f === :flags && return Ptr{Cuint}(x + 32)
    f === :reserved && return Ptr{NTuple{16, Cuint}}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalMemoryHandleDesc_st, f::Symbol)
    r = Ref{hipExternalMemoryHandleDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalMemoryHandleDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalMemoryHandleDesc_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipExternalMemoryHandleDesc = hipExternalMemoryHandleDesc_st

struct hipExternalMemoryBufferDesc_st
    data::NTuple{88, UInt8}
end

function Base.getproperty(x::Ptr{hipExternalMemoryBufferDesc_st}, f::Symbol)
    f === :offset && return Ptr{Culonglong}(x + 0)
    f === :size && return Ptr{Culonglong}(x + 8)
    f === :flags && return Ptr{Cuint}(x + 16)
    f === :reserved && return Ptr{NTuple{16, Cuint}}(x + 20)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalMemoryBufferDesc_st, f::Symbol)
    r = Ref{hipExternalMemoryBufferDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalMemoryBufferDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalMemoryBufferDesc_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipExternalMemoryBufferDesc = hipExternalMemoryBufferDesc_st

struct hipExternalMemoryMipmappedArrayDesc_st
    data::NTuple{64, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
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

struct var"##Ctag#303"
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#303"}, f::Symbol)
    f === :fd && return Ptr{Cint}(x + 0)
    f === :win32 && return Ptr{var"##Ctag#304"}(x + 0)
    f === :NvSciSyncObj && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#303", f::Symbol)
    r = Ref{var"##Ctag#303"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#303"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#303"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalSemaphoreHandleDesc_st
    data::NTuple{96, UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreHandleDesc_st}, f::Symbol)
    f === :type && return Ptr{hipExternalSemaphoreHandleType}(x + 0)
    f === :handle && return Ptr{var"##Ctag#303"}(x + 8)
    f === :flags && return Ptr{Cuint}(x + 24)
    f === :reserved && return Ptr{NTuple{16, Cuint}}(x + 28)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreHandleDesc_st, f::Symbol)
    r = Ref{hipExternalSemaphoreHandleDesc_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreHandleDesc_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreHandleDesc_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipExternalSemaphoreHandleDesc = hipExternalSemaphoreHandleDesc_st

const hipExternalSemaphore_t = Ptr{Cvoid}

struct var"##Ctag#300"
    value::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#300"}, f::Symbol)
    f === :value && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#300", f::Symbol)
    r = Ref{var"##Ctag#300"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#300"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#300"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#301"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#301"}, f::Symbol)
    f === :fence && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :reserved && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#301", f::Symbol)
    r = Ref{var"##Ctag#301"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#301"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#301"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#302"
    key::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#302"}, f::Symbol)
    f === :key && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#302", f::Symbol)
    r = Ref{var"##Ctag#302"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#302"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#302"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#299"
    data::NTuple{72, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#299"}, f::Symbol)
    f === :fence && return Ptr{var"##Ctag#300"}(x + 0)
    f === :nvSciSync && return Ptr{var"##Ctag#301"}(x + 8)
    f === :keyedMutex && return Ptr{var"##Ctag#302"}(x + 16)
    f === :reserved && return Ptr{NTuple{12, Cuint}}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#299", f::Symbol)
    r = Ref{var"##Ctag#299"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#299"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#299"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalSemaphoreSignalParams_st
    data::NTuple{144, UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreSignalParams_st}, f::Symbol)
    f === :params && return Ptr{Cvoid}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 72)
    f === :reserved && return Ptr{NTuple{16, Cuint}}(x + 76)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreSignalParams_st, f::Symbol)
    r = Ref{hipExternalSemaphoreSignalParams_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreSignalParams_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreSignalParams_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipExternalSemaphoreSignalParams = hipExternalSemaphoreSignalParams_st

struct var"##Ctag#290"
    value::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#290"}, f::Symbol)
    f === :value && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#290", f::Symbol)
    r = Ref{var"##Ctag#290"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#290"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#290"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#291"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#291"}, f::Symbol)
    f === :fence && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :reserved && return Ptr{Culonglong}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#291", f::Symbol)
    r = Ref{var"##Ctag#291"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#291"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#291"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#292"
    key::Culonglong
    timeoutMs::Cuint
end
function Base.getproperty(x::Ptr{var"##Ctag#292"}, f::Symbol)
    f === :key && return Ptr{Culonglong}(x + 0)
    f === :timeoutMs && return Ptr{Cuint}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#292", f::Symbol)
    r = Ref{var"##Ctag#292"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#292"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#292"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#289"
    data::NTuple{72, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#289"}, f::Symbol)
    f === :fence && return Ptr{var"##Ctag#290"}(x + 0)
    f === :nvSciSync && return Ptr{var"##Ctag#291"}(x + 8)
    f === :keyedMutex && return Ptr{var"##Ctag#292"}(x + 16)
    f === :reserved && return Ptr{NTuple{10, Cuint}}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#289", f::Symbol)
    r = Ref{var"##Ctag#289"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#289"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#289"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalSemaphoreWaitParams_st
    data::NTuple{144, UInt8}
end

function Base.getproperty(x::Ptr{hipExternalSemaphoreWaitParams_st}, f::Symbol)
    f === :params && return Ptr{Cvoid}(x + 0)
    f === :flags && return Ptr{Cuint}(x + 72)
    f === :reserved && return Ptr{NTuple{16, Cuint}}(x + 76)
    return getfield(x, f)
end

function Base.getproperty(x::hipExternalSemaphoreWaitParams_st, f::Symbol)
    r = Ref{hipExternalSemaphoreWaitParams_st}(x)
    ptr = Base.unsafe_convert(Ptr{hipExternalSemaphoreWaitParams_st}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipExternalSemaphoreWaitParams_st}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const hipExternalSemaphoreWaitParams = hipExternalSemaphoreWaitParams_st

function __hipGetPCH(pch, size)
    @ccall libhip.__hipGetPCH(pch::Ptr{Cstring}, size::Ptr{Cuint})::Cvoid
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
    hipGraphNodeTypeCount = 14
end

# typedef void ( * hipHostFn_t ) ( void * userData )
const hipHostFn_t = Ptr{Cvoid}

struct hipHostNodeParams
    data::NTuple{16, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipKernelNodeParams
    data::NTuple{64, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipMemsetParams
    data::NTuple{48, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipMemAllocNodeParams
    data::NTuple{120, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

@cenum hipKernelNodeAttrID::UInt32 begin
    hipKernelNodeAttributeAccessPolicyWindow = 1
    hipKernelNodeAttributeCooperative = 2
end

@cenum hipAccessProperty::UInt32 begin
    hipAccessPropertyNormal = 0
    hipAccessPropertyStreaming = 1
    hipAccessPropertyPersisting = 2
end

struct hipAccessPolicyWindow
    data::NTuple{32, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipKernelNodeAttrValue
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{hipKernelNodeAttrValue}, f::Symbol)
    f === :accessPolicyWindow && return Ptr{hipAccessPolicyWindow}(x + 0)
    f === :cooperative && return Ptr{Cint}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::hipKernelNodeAttrValue, f::Symbol)
    r = Ref{hipKernelNodeAttrValue}(x)
    ptr = Base.unsafe_convert(Ptr{hipKernelNodeAttrValue}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipKernelNodeAttrValue}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
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

struct var"##Ctag#276"
    compressionType::Cuchar
    gpuDirectRDMACapable::Cuchar
    usage::Cushort
end
function Base.getproperty(x::Ptr{var"##Ctag#276"}, f::Symbol)
    f === :compressionType && return Ptr{Cuchar}(x + 0)
    f === :gpuDirectRDMACapable && return Ptr{Cuchar}(x + 1)
    f === :usage && return Ptr{Cushort}(x + 2)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#276", f::Symbol)
    r = Ref{var"##Ctag#276"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#276"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#276"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct hipMemAllocationProp
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{hipMemAllocationProp}, f::Symbol)
    f === :type && return Ptr{hipMemAllocationType}(x + 0)
    f === :requestedHandleType && return Ptr{hipMemAllocationHandleType}(x + 4)
    f === :location && return Ptr{hipMemLocation}(x + 8)
    f === :win32HandleMetaData && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :allocFlags && return Ptr{var"##Ctag#276"}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::hipMemAllocationProp, f::Symbol)
    r = Ref{hipMemAllocationProp}(x)
    ptr = Base.unsafe_convert(Ptr{hipMemAllocationProp}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipMemAllocationProp}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalSemaphoreSignalNodeParams
    data::NTuple{24, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
end

struct hipExternalSemaphoreWaitNodeParams
    data::NTuple{24, UInt8}
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
    unsafe_store!(getproperty(x, f), v)
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

struct var"##Ctag#284"
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#284"}, f::Symbol)
    f === :mipmap && return Ptr{hipMipmappedArray}(x + 0)
    f === :array && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#284", f::Symbol)
    r = Ref{var"##Ctag#284"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#284"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#284"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#285"
    data::NTuple{32, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#285"}, f::Symbol)
    f === :sparseLevel && return Ptr{var"##Ctag#286"}(x + 0)
    f === :miptail && return Ptr{var"##Ctag#287"}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#285", f::Symbol)
    r = Ref{var"##Ctag#285"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#285"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#285"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#288"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#288"}, f::Symbol)
    f === :memHandle && return Ptr{hipMemGenericAllocationHandle_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#288", f::Symbol)
    r = Ref{var"##Ctag#288"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#288"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#288"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct hipArrayMapInfo
    data::NTuple{152, UInt8}
end

function Base.getproperty(x::Ptr{hipArrayMapInfo}, f::Symbol)
    f === :resourceType && return Ptr{hipResourceType}(x + 0)
    f === :resource && return Ptr{var"##Ctag#284"}(x + 8)
    f === :subresourceType && return Ptr{hipArraySparseSubresourceType}(x + 72)
    f === :subresource && return Ptr{var"##Ctag#285"}(x + 80)
    f === :memOperationType && return Ptr{hipMemOperationType}(x + 112)
    f === :memHandleType && return Ptr{hipMemHandleType}(x + 116)
    f === :memHandle && return Ptr{var"##Ctag#288"}(x + 120)
    f === :offset && return Ptr{Culonglong}(x + 128)
    f === :deviceBitMask && return Ptr{Cuint}(x + 136)
    f === :flags && return Ptr{Cuint}(x + 140)
    f === :reserved && return Ptr{NTuple{2, Cuint}}(x + 144)
    return getfield(x, f)
end

function Base.getproperty(x::hipArrayMapInfo, f::Symbol)
    r = Ref{hipArrayMapInfo}(x)
    ptr = Base.unsafe_convert(Ptr{hipArrayMapInfo}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{hipArrayMapInfo}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

function hipInit(flags)
    @ccall libhip.hipInit(flags::Cuint)::hipError_t
end

function hipDriverGetVersion(driverVersion)
    @ccall libhip.hipDriverGetVersion(driverVersion::Ptr{Cint})::hipError_t
end

function hipRuntimeGetVersion(runtimeVersion)
    @ccall libhip.hipRuntimeGetVersion(runtimeVersion::Ptr{Cint})::hipError_t
end

function hipDeviceGet(device, ordinal)
    @ccall libhip.hipDeviceGet(device::Ptr{hipDevice_t}, ordinal::Cint)::hipError_t
end

function hipDeviceComputeCapability(major, minor, device)
    @ccall libhip.hipDeviceComputeCapability(major::Ptr{Cint}, minor::Ptr{Cint}, device::hipDevice_t)::hipError_t
end

function hipDeviceGetName(name, len, device)
    @ccall libhip.hipDeviceGetName(name::Cstring, len::Cint, device::hipDevice_t)::hipError_t
end

function hipDeviceGetUuid(uuid, device)
    @ccall libhip.hipDeviceGetUuid(uuid::Ptr{hipUUID}, device::hipDevice_t)::hipError_t
end

function hipDeviceGetP2PAttribute(value, attr, srcDevice, dstDevice)
    @ccall libhip.hipDeviceGetP2PAttribute(value::Ptr{Cint}, attr::hipDeviceP2PAttr, srcDevice::Cint, dstDevice::Cint)::hipError_t
end

function hipDeviceGetPCIBusId(pciBusId, len, device)
    @ccall libhip.hipDeviceGetPCIBusId(pciBusId::Cstring, len::Cint, device::Cint)::hipError_t
end

function hipDeviceGetByPCIBusId(device, pciBusId)
    @ccall libhip.hipDeviceGetByPCIBusId(device::Ptr{Cint}, pciBusId::Cstring)::hipError_t
end

function hipDeviceTotalMem(bytes, device)
    @ccall libhip.hipDeviceTotalMem(bytes::Ptr{Csize_t}, device::hipDevice_t)::hipError_t
end

function hipDeviceSynchronize()
    @ccall libhip.hipDeviceSynchronize()::hipError_t
end

function hipDeviceReset()
    @ccall libhip.hipDeviceReset()::hipError_t
end

function hipSetDevice(deviceId)
    @ccall libhip.hipSetDevice(deviceId::Cint)::hipError_t
end

function hipGetDevice(deviceId)
    @ccall libhip.hipGetDevice(deviceId::Ptr{Cint})::hipError_t
end

function hipGetDeviceCount(count)
    @ccall libhip.hipGetDeviceCount(count::Ptr{Cint})::hipError_t
end

function hipDeviceGetAttribute(pi, attr, deviceId)
    @ccall libhip.hipDeviceGetAttribute(pi::Ptr{Cint}, attr::hipDeviceAttribute_t, deviceId::Cint)::hipError_t
end

function hipDeviceGetDefaultMemPool(mem_pool, device)
    @ccall libhip.hipDeviceGetDefaultMemPool(mem_pool::Ptr{hipMemPool_t}, device::Cint)::hipError_t
end

function hipDeviceSetMemPool(device, mem_pool)
    @ccall libhip.hipDeviceSetMemPool(device::Cint, mem_pool::hipMemPool_t)::hipError_t
end

function hipDeviceGetMemPool(mem_pool, device)
    @ccall libhip.hipDeviceGetMemPool(mem_pool::Ptr{hipMemPool_t}, device::Cint)::hipError_t
end

function hipDeviceSetCacheConfig(cacheConfig)
    @ccall libhip.hipDeviceSetCacheConfig(cacheConfig::hipFuncCache_t)::hipError_t
end

function hipDeviceGetCacheConfig(cacheConfig)
    @ccall libhip.hipDeviceGetCacheConfig(cacheConfig::Ptr{hipFuncCache_t})::hipError_t
end

function hipDeviceGetLimit(pValue, limit)
    @ccall libhip.hipDeviceGetLimit(pValue::Ptr{Csize_t}, limit::hipLimit_t)::hipError_t
end

function hipDeviceSetLimit(limit, value)
    @ccall libhip.hipDeviceSetLimit(limit::hipLimit_t, value::Csize_t)::hipError_t
end

function hipDeviceGetSharedMemConfig(pConfig)
    @ccall libhip.hipDeviceGetSharedMemConfig(pConfig::Ptr{hipSharedMemConfig})::hipError_t
end

function hipGetDeviceFlags(flags)
    @ccall libhip.hipGetDeviceFlags(flags::Ptr{Cuint})::hipError_t
end

function hipDeviceSetSharedMemConfig(config)
    @ccall libhip.hipDeviceSetSharedMemConfig(config::hipSharedMemConfig)::hipError_t
end

function hipSetDeviceFlags(flags)
    @ccall libhip.hipSetDeviceFlags(flags::Cuint)::hipError_t
end

function hipExtGetLinkTypeAndHopCount(device1, device2, linktype, hopcount)
    @ccall libhip.hipExtGetLinkTypeAndHopCount(device1::Cint, device2::Cint, linktype::Ptr{UInt32}, hopcount::Ptr{UInt32})::hipError_t
end

function hipIpcGetMemHandle(handle, devPtr)
    @ccall libhip.hipIpcGetMemHandle(handle::Ptr{hipIpcMemHandle_t}, devPtr::Ptr{Cvoid})::hipError_t
end

function hipIpcOpenMemHandle(devPtr, handle, flags)
    @ccall libhip.hipIpcOpenMemHandle(devPtr::Ptr{Ptr{Cvoid}}, handle::hipIpcMemHandle_t, flags::Cuint)::hipError_t
end

function hipIpcCloseMemHandle(devPtr)
    @ccall libhip.hipIpcCloseMemHandle(devPtr::Ptr{Cvoid})::hipError_t
end

function hipIpcGetEventHandle(handle, event)
    @ccall libhip.hipIpcGetEventHandle(handle::Ptr{hipIpcEventHandle_t}, event::hipEvent_t)::hipError_t
end

function hipIpcOpenEventHandle(event, handle)
    @ccall libhip.hipIpcOpenEventHandle(event::Ptr{hipEvent_t}, handle::hipIpcEventHandle_t)::hipError_t
end

function hipFuncSetAttribute(func, attr, value)
    @ccall libhip.hipFuncSetAttribute(func::Ptr{Cvoid}, attr::hipFuncAttribute, value::Cint)::hipError_t
end

function hipFuncSetCacheConfig(func, config)
    @ccall libhip.hipFuncSetCacheConfig(func::Ptr{Cvoid}, config::hipFuncCache_t)::hipError_t
end

function hipFuncSetSharedMemConfig(func, config)
    @ccall libhip.hipFuncSetSharedMemConfig(func::Ptr{Cvoid}, config::hipSharedMemConfig)::hipError_t
end

function hipGetLastError()
    @ccall libhip.hipGetLastError()::hipError_t
end

function hipExtGetLastError()
    @ccall libhip.hipExtGetLastError()::hipError_t
end

function hipPeekAtLastError()
    @ccall libhip.hipPeekAtLastError()::hipError_t
end

function hipGetErrorName(hip_error)
    @ccall libhip.hipGetErrorName(hip_error::hipError_t)::Cstring
end

function hipGetErrorString(hipError)
    @ccall libhip.hipGetErrorString(hipError::hipError_t)::Cstring
end

function hipDrvGetErrorName(hipError, errorString)
    @ccall libhip.hipDrvGetErrorName(hipError::hipError_t, errorString::Ptr{Cstring})::hipError_t
end

function hipDrvGetErrorString(hipError, errorString)
    @ccall libhip.hipDrvGetErrorString(hipError::hipError_t, errorString::Ptr{Cstring})::hipError_t
end

function hipStreamCreate(stream)
    @ccall libhip.hipStreamCreate(stream::Ptr{hipStream_t})::hipError_t
end

function hipStreamCreateWithFlags(stream, flags)
    @ccall libhip.hipStreamCreateWithFlags(stream::Ptr{hipStream_t}, flags::Cuint)::hipError_t
end

function hipStreamCreateWithPriority(stream, flags, priority)
    @ccall libhip.hipStreamCreateWithPriority(stream::Ptr{hipStream_t}, flags::Cuint, priority::Cint)::hipError_t
end

function hipDeviceGetStreamPriorityRange(leastPriority, greatestPriority)
    @ccall libhip.hipDeviceGetStreamPriorityRange(leastPriority::Ptr{Cint}, greatestPriority::Ptr{Cint})::hipError_t
end

function hipStreamDestroy(stream)
    @ccall libhip.hipStreamDestroy(stream::hipStream_t)::hipError_t
end

function hipStreamQuery(stream)
    @ccall libhip.hipStreamQuery(stream::hipStream_t)::hipError_t
end

function hipStreamSynchronize(stream)
    @ccall libhip.hipStreamSynchronize(stream::hipStream_t)::hipError_t
end

function hipStreamWaitEvent(stream, event, flags)
    @ccall libhip.hipStreamWaitEvent(stream::hipStream_t, event::hipEvent_t, flags::Cuint)::hipError_t
end

function hipStreamGetFlags(stream, flags)
    @ccall libhip.hipStreamGetFlags(stream::hipStream_t, flags::Ptr{Cuint})::hipError_t
end

function hipStreamGetPriority(stream, priority)
    @ccall libhip.hipStreamGetPriority(stream::hipStream_t, priority::Ptr{Cint})::hipError_t
end

function hipStreamGetDevice(stream, device)
    @ccall libhip.hipStreamGetDevice(stream::hipStream_t, device::Ptr{hipDevice_t})::hipError_t
end

function hipExtStreamCreateWithCUMask(stream, cuMaskSize, cuMask)
    @ccall libhip.hipExtStreamCreateWithCUMask(stream::Ptr{hipStream_t}, cuMaskSize::UInt32, cuMask::Ptr{UInt32})::hipError_t
end

function hipExtStreamGetCUMask(stream, cuMaskSize, cuMask)
    @ccall libhip.hipExtStreamGetCUMask(stream::hipStream_t, cuMaskSize::UInt32, cuMask::Ptr{UInt32})::hipError_t
end

# typedef void ( * hipStreamCallback_t ) ( hipStream_t stream , hipError_t status , void * userData )
const hipStreamCallback_t = Ptr{Cvoid}

function hipStreamAddCallback(stream, callback, userData, flags)
    @ccall libhip.hipStreamAddCallback(stream::hipStream_t, callback::hipStreamCallback_t, userData::Ptr{Cvoid}, flags::Cuint)::hipError_t
end

function hipStreamWaitValue32(stream, ptr, value, flags, mask)
    @ccall libhip.hipStreamWaitValue32(stream::hipStream_t, ptr::Ptr{Cvoid}, value::UInt32, flags::Cuint, mask::UInt32)::hipError_t
end

function hipStreamWaitValue64(stream, ptr, value, flags, mask)
    @ccall libhip.hipStreamWaitValue64(stream::hipStream_t, ptr::Ptr{Cvoid}, value::UInt64, flags::Cuint, mask::UInt64)::hipError_t
end

function hipStreamWriteValue32(stream, ptr, value, flags)
    @ccall libhip.hipStreamWriteValue32(stream::hipStream_t, ptr::Ptr{Cvoid}, value::UInt32, flags::Cuint)::hipError_t
end

function hipStreamWriteValue64(stream, ptr, value, flags)
    @ccall libhip.hipStreamWriteValue64(stream::hipStream_t, ptr::Ptr{Cvoid}, value::UInt64, flags::Cuint)::hipError_t
end

function hipEventCreateWithFlags(event, flags)
    @ccall libhip.hipEventCreateWithFlags(event::Ptr{hipEvent_t}, flags::Cuint)::hipError_t
end

function hipEventCreate(event)
    @ccall libhip.hipEventCreate(event::Ptr{hipEvent_t})::hipError_t
end

function hipEventRecord(event, stream)
    @ccall libhip.hipEventRecord(event::hipEvent_t, stream::hipStream_t)::hipError_t
end

function hipEventDestroy(event)
    @ccall libhip.hipEventDestroy(event::hipEvent_t)::hipError_t
end

function hipEventSynchronize(event)
    @ccall libhip.hipEventSynchronize(event::hipEvent_t)::hipError_t
end

function hipEventElapsedTime(ms, start, stop)
    @ccall libhip.hipEventElapsedTime(ms::Ptr{Cfloat}, start::hipEvent_t, stop::hipEvent_t)::hipError_t
end

function hipEventQuery(event)
    @ccall libhip.hipEventQuery(event::hipEvent_t)::hipError_t
end

function hipPointerSetAttribute(value, attribute, ptr)
    @ccall libhip.hipPointerSetAttribute(value::Ptr{Cvoid}, attribute::hipPointer_attribute, ptr::hipDeviceptr_t)::hipError_t
end

function hipPointerGetAttributes(attributes, ptr)
    @ccall libhip.hipPointerGetAttributes(attributes::Ptr{hipPointerAttribute_t}, ptr::Ptr{Cvoid})::hipError_t
end

function hipPointerGetAttribute(data, attribute, ptr)
    @ccall libhip.hipPointerGetAttribute(data::Ptr{Cvoid}, attribute::hipPointer_attribute, ptr::hipDeviceptr_t)::hipError_t
end

function hipDrvPointerGetAttributes(numAttributes, attributes, data, ptr)
    @ccall libhip.hipDrvPointerGetAttributes(numAttributes::Cuint, attributes::Ptr{hipPointer_attribute}, data::Ptr{Ptr{Cvoid}}, ptr::hipDeviceptr_t)::hipError_t
end

function hipImportExternalSemaphore(extSem_out, semHandleDesc)
    @ccall libhip.hipImportExternalSemaphore(extSem_out::Ptr{hipExternalSemaphore_t}, semHandleDesc::Ptr{hipExternalSemaphoreHandleDesc})::hipError_t
end

function hipSignalExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream)
    @ccall libhip.hipSignalExternalSemaphoresAsync(extSemArray::Ptr{hipExternalSemaphore_t}, paramsArray::Ptr{hipExternalSemaphoreSignalParams}, numExtSems::Cuint, stream::hipStream_t)::hipError_t
end

function hipWaitExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream)
    @ccall libhip.hipWaitExternalSemaphoresAsync(extSemArray::Ptr{hipExternalSemaphore_t}, paramsArray::Ptr{hipExternalSemaphoreWaitParams}, numExtSems::Cuint, stream::hipStream_t)::hipError_t
end

function hipDestroyExternalSemaphore(extSem)
    @ccall libhip.hipDestroyExternalSemaphore(extSem::hipExternalSemaphore_t)::hipError_t
end

function hipImportExternalMemory(extMem_out, memHandleDesc)
    @ccall libhip.hipImportExternalMemory(extMem_out::Ptr{hipExternalMemory_t}, memHandleDesc::Ptr{hipExternalMemoryHandleDesc})::hipError_t
end

function hipExternalMemoryGetMappedBuffer(devPtr, extMem, bufferDesc)
    @ccall libhip.hipExternalMemoryGetMappedBuffer(devPtr::Ptr{Ptr{Cvoid}}, extMem::hipExternalMemory_t, bufferDesc::Ptr{hipExternalMemoryBufferDesc})::hipError_t
end

function hipDestroyExternalMemory(extMem)
    @ccall libhip.hipDestroyExternalMemory(extMem::hipExternalMemory_t)::hipError_t
end

function hipExternalMemoryGetMappedMipmappedArray(mipmap, extMem, mipmapDesc)
    @ccall libhip.hipExternalMemoryGetMappedMipmappedArray(mipmap::Ptr{hipMipmappedArray_t}, extMem::hipExternalMemory_t, mipmapDesc::Ptr{hipExternalMemoryMipmappedArrayDesc})::hipError_t
end

function hipMalloc(ptr, size)
    @ccall libhip.hipMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::hipError_t
end

function hipExtMallocWithFlags(ptr, sizeBytes, flags)
    @ccall libhip.hipExtMallocWithFlags(ptr::Ptr{Ptr{Cvoid}}, sizeBytes::Csize_t, flags::Cuint)::hipError_t
end

function hipMallocHost(ptr, size)
    @ccall libhip.hipMallocHost(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::hipError_t
end

function hipMemAllocHost(ptr, size)
    @ccall libhip.hipMemAllocHost(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t)::hipError_t
end

function hipHostMalloc(ptr, size, flags)
    @ccall libhip.hipHostMalloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, flags::Cuint)::hipError_t
end

function hipMallocManaged(dev_ptr, size, flags)
    @ccall libhip.hipMallocManaged(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, flags::Cuint)::hipError_t
end

function hipMemPrefetchAsync(dev_ptr, count, device, stream)
    @ccall libhip.hipMemPrefetchAsync(dev_ptr::Ptr{Cvoid}, count::Csize_t, device::Cint, stream::hipStream_t)::hipError_t
end

function hipMemAdvise(dev_ptr, count, advice, device)
    @ccall libhip.hipMemAdvise(dev_ptr::Ptr{Cvoid}, count::Csize_t, advice::hipMemoryAdvise, device::Cint)::hipError_t
end

function hipMemRangeGetAttribute(data, data_size, attribute, dev_ptr, count)
    @ccall libhip.hipMemRangeGetAttribute(data::Ptr{Cvoid}, data_size::Csize_t, attribute::hipMemRangeAttribute, dev_ptr::Ptr{Cvoid}, count::Csize_t)::hipError_t
end

function hipMemRangeGetAttributes(data, data_sizes, attributes, num_attributes, dev_ptr, count)
    @ccall libhip.hipMemRangeGetAttributes(data::Ptr{Ptr{Cvoid}}, data_sizes::Ptr{Csize_t}, attributes::Ptr{hipMemRangeAttribute}, num_attributes::Csize_t, dev_ptr::Ptr{Cvoid}, count::Csize_t)::hipError_t
end

function hipStreamAttachMemAsync(stream, dev_ptr, length, flags)
    @ccall libhip.hipStreamAttachMemAsync(stream::hipStream_t, dev_ptr::Ptr{Cvoid}, length::Csize_t, flags::Cuint)::hipError_t
end

function hipMallocAsync(dev_ptr, size, stream)
    @ccall libhip.hipMallocAsync(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, stream::hipStream_t)::hipError_t
end

function hipFreeAsync(dev_ptr, stream)
    @ccall libhip.hipFreeAsync(dev_ptr::Ptr{Cvoid}, stream::hipStream_t)::hipError_t
end

function hipMemPoolTrimTo(mem_pool, min_bytes_to_hold)
    @ccall libhip.hipMemPoolTrimTo(mem_pool::hipMemPool_t, min_bytes_to_hold::Csize_t)::hipError_t
end

function hipMemPoolSetAttribute(mem_pool, attr, value)
    @ccall libhip.hipMemPoolSetAttribute(mem_pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolGetAttribute(mem_pool, attr, value)
    @ccall libhip.hipMemPoolGetAttribute(mem_pool::hipMemPool_t, attr::hipMemPoolAttr, value::Ptr{Cvoid})::hipError_t
end

function hipMemPoolSetAccess(mem_pool, desc_list, count)
    @ccall libhip.hipMemPoolSetAccess(mem_pool::hipMemPool_t, desc_list::Ptr{hipMemAccessDesc}, count::Csize_t)::hipError_t
end

function hipMemPoolGetAccess(flags, mem_pool, location)
    @ccall libhip.hipMemPoolGetAccess(flags::Ptr{hipMemAccessFlags}, mem_pool::hipMemPool_t, location::Ptr{hipMemLocation})::hipError_t
end

function hipMemPoolCreate(mem_pool, pool_props)
    @ccall libhip.hipMemPoolCreate(mem_pool::Ptr{hipMemPool_t}, pool_props::Ptr{hipMemPoolProps})::hipError_t
end

function hipMemPoolDestroy(mem_pool)
    @ccall libhip.hipMemPoolDestroy(mem_pool::hipMemPool_t)::hipError_t
end

function hipMallocFromPoolAsync(dev_ptr, size, mem_pool, stream)
    @ccall libhip.hipMallocFromPoolAsync(dev_ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, mem_pool::hipMemPool_t, stream::hipStream_t)::hipError_t
end

function hipMemPoolExportToShareableHandle(shared_handle, mem_pool, handle_type, flags)
    @ccall libhip.hipMemPoolExportToShareableHandle(shared_handle::Ptr{Cvoid}, mem_pool::hipMemPool_t, handle_type::hipMemAllocationHandleType, flags::Cuint)::hipError_t
end

function hipMemPoolImportFromShareableHandle(mem_pool, shared_handle, handle_type, flags)
    @ccall libhip.hipMemPoolImportFromShareableHandle(mem_pool::Ptr{hipMemPool_t}, shared_handle::Ptr{Cvoid}, handle_type::hipMemAllocationHandleType, flags::Cuint)::hipError_t
end

function hipMemPoolExportPointer(export_data, dev_ptr)
    @ccall libhip.hipMemPoolExportPointer(export_data::Ptr{hipMemPoolPtrExportData}, dev_ptr::Ptr{Cvoid})::hipError_t
end

function hipMemPoolImportPointer(dev_ptr, mem_pool, export_data)
    @ccall libhip.hipMemPoolImportPointer(dev_ptr::Ptr{Ptr{Cvoid}}, mem_pool::hipMemPool_t, export_data::Ptr{hipMemPoolPtrExportData})::hipError_t
end

function hipHostAlloc(ptr, size, flags)
    @ccall libhip.hipHostAlloc(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, flags::Cuint)::hipError_t
end

function hipHostGetDevicePointer(devPtr, hstPtr, flags)
    @ccall libhip.hipHostGetDevicePointer(devPtr::Ptr{Ptr{Cvoid}}, hstPtr::Ptr{Cvoid}, flags::Cuint)::hipError_t
end

function hipHostGetFlags(flagsPtr, hostPtr)
    @ccall libhip.hipHostGetFlags(flagsPtr::Ptr{Cuint}, hostPtr::Ptr{Cvoid})::hipError_t
end

function hipHostRegister(hostPtr, sizeBytes, flags)
    @ccall libhip.hipHostRegister(hostPtr::Ptr{Cvoid}, sizeBytes::Csize_t, flags::Cuint)::hipError_t
end

function hipHostUnregister(hostPtr)
    @ccall libhip.hipHostUnregister(hostPtr::Ptr{Cvoid})::hipError_t
end

function hipMallocPitch(ptr, pitch, width, height)
    @ccall libhip.hipMallocPitch(ptr::Ptr{Ptr{Cvoid}}, pitch::Ptr{Csize_t}, width::Csize_t, height::Csize_t)::hipError_t
end

function hipMemAllocPitch(dptr, pitch, widthInBytes, height, elementSizeBytes)
    @ccall libhip.hipMemAllocPitch(dptr::Ptr{hipDeviceptr_t}, pitch::Ptr{Csize_t}, widthInBytes::Csize_t, height::Csize_t, elementSizeBytes::Cuint)::hipError_t
end

function hipFree(ptr)
    @ccall libhip.hipFree(ptr::Ptr{Cvoid})::hipError_t
end

function hipFreeHost(ptr)
    @ccall libhip.hipFreeHost(ptr::Ptr{Cvoid})::hipError_t
end

function hipHostFree(ptr)
    @ccall libhip.hipHostFree(ptr::Ptr{Cvoid})::hipError_t
end

function hipMemcpy(dst, src, sizeBytes, kind)
    @ccall libhip.hipMemcpy(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyWithStream(dst, src, sizeBytes, kind, stream)
    @ccall libhip.hipMemcpyWithStream(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyHtoD(dst, src, sizeBytes)
    @ccall libhip.hipMemcpyHtoD(dst::hipDeviceptr_t, src::Ptr{Cvoid}, sizeBytes::Csize_t)::hipError_t
end

function hipMemcpyDtoH(dst, src, sizeBytes)
    @ccall libhip.hipMemcpyDtoH(dst::Ptr{Cvoid}, src::hipDeviceptr_t, sizeBytes::Csize_t)::hipError_t
end

function hipMemcpyDtoD(dst, src, sizeBytes)
    @ccall libhip.hipMemcpyDtoD(dst::hipDeviceptr_t, src::hipDeviceptr_t, sizeBytes::Csize_t)::hipError_t
end

function hipMemcpyHtoDAsync(dst, src, sizeBytes, stream)
    @ccall libhip.hipMemcpyHtoDAsync(dst::hipDeviceptr_t, src::Ptr{Cvoid}, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoHAsync(dst, src, sizeBytes, stream)
    @ccall libhip.hipMemcpyDtoHAsync(dst::Ptr{Cvoid}, src::hipDeviceptr_t, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemcpyDtoDAsync(dst, src, sizeBytes, stream)
    @ccall libhip.hipMemcpyDtoDAsync(dst::hipDeviceptr_t, src::hipDeviceptr_t, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipModuleGetGlobal(dptr, bytes, hmod, name)
    @ccall libhip.hipModuleGetGlobal(dptr::Ptr{hipDeviceptr_t}, bytes::Ptr{Csize_t}, hmod::hipModule_t, name::Cstring)::hipError_t
end

function hipGetSymbolAddress(devPtr, symbol)
    @ccall libhip.hipGetSymbolAddress(devPtr::Ptr{Ptr{Cvoid}}, symbol::Ptr{Cvoid})::hipError_t
end

function hipGetSymbolSize(size, symbol)
    @ccall libhip.hipGetSymbolSize(size::Ptr{Csize_t}, symbol::Ptr{Cvoid})::hipError_t
end

function hipMemcpyToSymbol(symbol, src, sizeBytes, offset, kind)
    @ccall libhip.hipMemcpyToSymbol(symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyToSymbolAsync(symbol, src, sizeBytes, offset, kind, stream)
    @ccall libhip.hipMemcpyToSymbolAsync(symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyFromSymbol(dst, symbol, sizeBytes, offset, kind)
    @ccall libhip.hipMemcpyFromSymbol(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyFromSymbolAsync(dst, symbol, sizeBytes, offset, kind, stream)
    @ccall libhip.hipMemcpyFromSymbolAsync(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyAsync(dst, src, sizeBytes, kind, stream)
    @ccall libhip.hipMemcpyAsync(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemset(dst, value, sizeBytes)
    @ccall libhip.hipMemset(dst::Ptr{Cvoid}, value::Cint, sizeBytes::Csize_t)::hipError_t
end

function hipMemsetD8(dest, value, count)
    @ccall libhip.hipMemsetD8(dest::hipDeviceptr_t, value::Cuchar, count::Csize_t)::hipError_t
end

function hipMemsetD8Async(dest, value, count, stream)
    @ccall libhip.hipMemsetD8Async(dest::hipDeviceptr_t, value::Cuchar, count::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemsetD16(dest, value, count)
    @ccall libhip.hipMemsetD16(dest::hipDeviceptr_t, value::Cushort, count::Csize_t)::hipError_t
end

function hipMemsetD16Async(dest, value, count, stream)
    @ccall libhip.hipMemsetD16Async(dest::hipDeviceptr_t, value::Cushort, count::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemsetD32(dest, value, count)
    @ccall libhip.hipMemsetD32(dest::hipDeviceptr_t, value::Cint, count::Csize_t)::hipError_t
end

function hipMemsetAsync(dst, value, sizeBytes, stream)
    @ccall libhip.hipMemsetAsync(dst::Ptr{Cvoid}, value::Cint, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemsetD32Async(dst, value, count, stream)
    @ccall libhip.hipMemsetD32Async(dst::hipDeviceptr_t, value::Cint, count::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemset2D(dst, pitch, value, width, height)
    @ccall libhip.hipMemset2D(dst::Ptr{Cvoid}, pitch::Csize_t, value::Cint, width::Csize_t, height::Csize_t)::hipError_t
end

function hipMemset2DAsync(dst, pitch, value, width, height, stream)
    @ccall libhip.hipMemset2DAsync(dst::Ptr{Cvoid}, pitch::Csize_t, value::Cint, width::Csize_t, height::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemset3D(pitchedDevPtr, value, extent)
    @ccall libhip.hipMemset3D(pitchedDevPtr::hipPitchedPtr, value::Cint, extent::hipExtent)::hipError_t
end

function hipMemset3DAsync(pitchedDevPtr, value, extent, stream)
    @ccall libhip.hipMemset3DAsync(pitchedDevPtr::hipPitchedPtr, value::Cint, extent::hipExtent, stream::hipStream_t)::hipError_t
end

function hipMemGetInfo(free, total)
    @ccall libhip.hipMemGetInfo(free::Ptr{Csize_t}, total::Ptr{Csize_t})::hipError_t
end

function hipMemPtrGetInfo(ptr, size)
    @ccall libhip.hipMemPtrGetInfo(ptr::Ptr{Cvoid}, size::Ptr{Csize_t})::hipError_t
end

function hipMallocArray(array, desc, width, height, flags)
    @ccall libhip.hipMallocArray(array::Ptr{hipArray_t}, desc::Ptr{hipChannelFormatDesc}, width::Csize_t, height::Csize_t, flags::Cuint)::hipError_t
end

function hipArrayCreate(pHandle, pAllocateArray)
    @ccall libhip.hipArrayCreate(pHandle::Ptr{hipArray_t}, pAllocateArray::Ptr{HIP_ARRAY_DESCRIPTOR})::hipError_t
end

function hipArrayDestroy(array)
    @ccall libhip.hipArrayDestroy(array::hipArray_t)::hipError_t
end

function hipArray3DCreate(array, pAllocateArray)
    @ccall libhip.hipArray3DCreate(array::Ptr{hipArray_t}, pAllocateArray::Ptr{HIP_ARRAY3D_DESCRIPTOR})::hipError_t
end

function hipMalloc3D(pitchedDevPtr, extent)
    @ccall libhip.hipMalloc3D(pitchedDevPtr::Ptr{hipPitchedPtr}, extent::hipExtent)::hipError_t
end

function hipFreeArray(array)
    @ccall libhip.hipFreeArray(array::hipArray_t)::hipError_t
end

function hipMalloc3DArray(array, desc, extent, flags)
    @ccall libhip.hipMalloc3DArray(array::Ptr{hipArray_t}, desc::Ptr{hipChannelFormatDesc}, extent::hipExtent, flags::Cuint)::hipError_t
end

function hipArrayGetInfo(desc, extent, flags, array)
    @ccall libhip.hipArrayGetInfo(desc::Ptr{hipChannelFormatDesc}, extent::Ptr{hipExtent}, flags::Ptr{Cuint}, array::hipArray_t)::hipError_t
end

function hipArrayGetDescriptor(pArrayDescriptor, array)
    @ccall libhip.hipArrayGetDescriptor(pArrayDescriptor::Ptr{HIP_ARRAY_DESCRIPTOR}, array::hipArray_t)::hipError_t
end

function hipArray3DGetDescriptor(pArrayDescriptor, array)
    @ccall libhip.hipArray3DGetDescriptor(pArrayDescriptor::Ptr{HIP_ARRAY3D_DESCRIPTOR}, array::hipArray_t)::hipError_t
end

function hipMemcpy2D(dst, dpitch, src, spitch, width, height, kind)
    @ccall libhip.hipMemcpy2D(dst::Ptr{Cvoid}, dpitch::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyParam2D(pCopy)
    @ccall libhip.hipMemcpyParam2D(pCopy::Ptr{hip_Memcpy2D})::hipError_t
end

function hipMemcpyParam2DAsync(pCopy, stream)
    @ccall libhip.hipMemcpyParam2DAsync(pCopy::Ptr{hip_Memcpy2D}, stream::hipStream_t)::hipError_t
end

function hipMemcpy2DAsync(dst, dpitch, src, spitch, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DAsync(dst::Ptr{Cvoid}, dpitch::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpy2DToArray(dst, wOffset, hOffset, src, spitch, width, height, kind)
    @ccall libhip.hipMemcpy2DToArray(dst::hipArray_t, wOffset::Csize_t, hOffset::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DToArrayAsync(dst, wOffset, hOffset, src, spitch, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DToArrayAsync(dst::hipArray_t, wOffset::Csize_t, hOffset::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyToArray(dst, wOffset, hOffset, src, count, kind)
    @ccall libhip.hipMemcpyToArray(dst::hipArray_t, wOffset::Csize_t, hOffset::Csize_t, src::Ptr{Cvoid}, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyFromArray(dst, srcArray, wOffset, hOffset, count, kind)
    @ccall libhip.hipMemcpyFromArray(dst::Ptr{Cvoid}, srcArray::hipArray_const_t, wOffset::Csize_t, hOffset::Csize_t, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DFromArray(dst, dpitch, src, wOffset, hOffset, width, height, kind)
    @ccall libhip.hipMemcpy2DFromArray(dst::Ptr{Cvoid}, dpitch::Csize_t, src::hipArray_const_t, wOffset::Csize_t, hOffset::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DFromArrayAsync(dst, dpitch, src, wOffset, hOffset, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DFromArrayAsync(dst::Ptr{Cvoid}, dpitch::Csize_t, src::hipArray_const_t, wOffset::Csize_t, hOffset::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyAtoH(dst, srcArray, srcOffset, count)
    @ccall libhip.hipMemcpyAtoH(dst::Ptr{Cvoid}, srcArray::hipArray_t, srcOffset::Csize_t, count::Csize_t)::hipError_t
end

function hipMemcpyHtoA(dstArray, dstOffset, srcHost, count)
    @ccall libhip.hipMemcpyHtoA(dstArray::hipArray_t, dstOffset::Csize_t, srcHost::Ptr{Cvoid}, count::Csize_t)::hipError_t
end

function hipMemcpy3D(p)
    @ccall libhip.hipMemcpy3D(p::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipMemcpy3DAsync(p, stream)
    @ccall libhip.hipMemcpy3DAsync(p::Ptr{hipMemcpy3DParms}, stream::hipStream_t)::hipError_t
end

function hipDrvMemcpy3D(pCopy)
    @ccall libhip.hipDrvMemcpy3D(pCopy::Ptr{HIP_MEMCPY3D})::hipError_t
end

function hipDrvMemcpy3DAsync(pCopy, stream)
    @ccall libhip.hipDrvMemcpy3DAsync(pCopy::Ptr{HIP_MEMCPY3D}, stream::hipStream_t)::hipError_t
end

function hipDeviceCanAccessPeer(canAccessPeer, deviceId, peerDeviceId)
    @ccall libhip.hipDeviceCanAccessPeer(canAccessPeer::Ptr{Cint}, deviceId::Cint, peerDeviceId::Cint)::hipError_t
end

function hipDeviceEnablePeerAccess(peerDeviceId, flags)
    @ccall libhip.hipDeviceEnablePeerAccess(peerDeviceId::Cint, flags::Cuint)::hipError_t
end

function hipDeviceDisablePeerAccess(peerDeviceId)
    @ccall libhip.hipDeviceDisablePeerAccess(peerDeviceId::Cint)::hipError_t
end

function hipMemGetAddressRange(pbase, psize, dptr)
    @ccall libhip.hipMemGetAddressRange(pbase::Ptr{hipDeviceptr_t}, psize::Ptr{Csize_t}, dptr::hipDeviceptr_t)::hipError_t
end

function hipMemcpyPeer(dst, dstDeviceId, src, srcDeviceId, sizeBytes)
    @ccall libhip.hipMemcpyPeer(dst::Ptr{Cvoid}, dstDeviceId::Cint, src::Ptr{Cvoid}, srcDeviceId::Cint, sizeBytes::Csize_t)::hipError_t
end

function hipMemcpyPeerAsync(dst, dstDeviceId, src, srcDevice, sizeBytes, stream)
    @ccall libhip.hipMemcpyPeerAsync(dst::Ptr{Cvoid}, dstDeviceId::Cint, src::Ptr{Cvoid}, srcDevice::Cint, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipCtxCreate(ctx, flags, device)
    @ccall libhip.hipCtxCreate(ctx::Ptr{hipCtx_t}, flags::Cuint, device::hipDevice_t)::hipError_t
end

function hipCtxDestroy(ctx)
    @ccall libhip.hipCtxDestroy(ctx::hipCtx_t)::hipError_t
end

function hipCtxPopCurrent(ctx)
    @ccall libhip.hipCtxPopCurrent(ctx::Ptr{hipCtx_t})::hipError_t
end

function hipCtxPushCurrent(ctx)
    @ccall libhip.hipCtxPushCurrent(ctx::hipCtx_t)::hipError_t
end

function hipCtxSetCurrent(ctx)
    @ccall libhip.hipCtxSetCurrent(ctx::hipCtx_t)::hipError_t
end

function hipCtxGetCurrent(ctx)
    @ccall libhip.hipCtxGetCurrent(ctx::Ptr{hipCtx_t})::hipError_t
end

function hipCtxGetDevice(device)
    @ccall libhip.hipCtxGetDevice(device::Ptr{hipDevice_t})::hipError_t
end

function hipCtxGetApiVersion(ctx, apiVersion)
    @ccall libhip.hipCtxGetApiVersion(ctx::hipCtx_t, apiVersion::Ptr{Cint})::hipError_t
end

function hipCtxGetCacheConfig(cacheConfig)
    @ccall libhip.hipCtxGetCacheConfig(cacheConfig::Ptr{hipFuncCache_t})::hipError_t
end

function hipCtxSetCacheConfig(cacheConfig)
    @ccall libhip.hipCtxSetCacheConfig(cacheConfig::hipFuncCache_t)::hipError_t
end

function hipCtxSetSharedMemConfig(config)
    @ccall libhip.hipCtxSetSharedMemConfig(config::hipSharedMemConfig)::hipError_t
end

function hipCtxGetSharedMemConfig(pConfig)
    @ccall libhip.hipCtxGetSharedMemConfig(pConfig::Ptr{hipSharedMemConfig})::hipError_t
end

function hipCtxSynchronize()
    @ccall libhip.hipCtxSynchronize()::hipError_t
end

function hipCtxGetFlags(flags)
    @ccall libhip.hipCtxGetFlags(flags::Ptr{Cuint})::hipError_t
end

function hipCtxEnablePeerAccess(peerCtx, flags)
    @ccall libhip.hipCtxEnablePeerAccess(peerCtx::hipCtx_t, flags::Cuint)::hipError_t
end

function hipCtxDisablePeerAccess(peerCtx)
    @ccall libhip.hipCtxDisablePeerAccess(peerCtx::hipCtx_t)::hipError_t
end

function hipDevicePrimaryCtxGetState(dev, flags, active)
    @ccall libhip.hipDevicePrimaryCtxGetState(dev::hipDevice_t, flags::Ptr{Cuint}, active::Ptr{Cint})::hipError_t
end

function hipDevicePrimaryCtxRelease(dev)
    @ccall libhip.hipDevicePrimaryCtxRelease(dev::hipDevice_t)::hipError_t
end

function hipDevicePrimaryCtxRetain(pctx, dev)
    @ccall libhip.hipDevicePrimaryCtxRetain(pctx::Ptr{hipCtx_t}, dev::hipDevice_t)::hipError_t
end

function hipDevicePrimaryCtxReset(dev)
    @ccall libhip.hipDevicePrimaryCtxReset(dev::hipDevice_t)::hipError_t
end

function hipDevicePrimaryCtxSetFlags(dev, flags)
    @ccall libhip.hipDevicePrimaryCtxSetFlags(dev::hipDevice_t, flags::Cuint)::hipError_t
end

function hipModuleLoad(_module, fname)
    @ccall libhip.hipModuleLoad(_module::Ptr{hipModule_t}, fname::Cstring)::hipError_t
end

function hipModuleUnload(_module)
    @ccall libhip.hipModuleUnload(_module::hipModule_t)::hipError_t
end

function hipModuleGetFunction(_function, _module, kname)
    @ccall libhip.hipModuleGetFunction(_function::Ptr{hipFunction_t}, _module::hipModule_t, kname::Cstring)::hipError_t
end

function hipFuncGetAttributes(attr, func)
    @ccall libhip.hipFuncGetAttributes(attr::Ptr{hipFuncAttributes}, func::Ptr{Cvoid})::hipError_t
end

function hipFuncGetAttribute(value, attrib, hfunc)
    @ccall libhip.hipFuncGetAttribute(value::Ptr{Cint}, attrib::hipFunction_attribute, hfunc::hipFunction_t)::hipError_t
end

function hipModuleGetTexRef(texRef, hmod, name)
    @ccall libhip.hipModuleGetTexRef(texRef::Ptr{Ptr{textureReference}}, hmod::hipModule_t, name::Cstring)::hipError_t
end

function hipModuleLoadData(_module, image)
    @ccall libhip.hipModuleLoadData(_module::Ptr{hipModule_t}, image::Ptr{Cvoid})::hipError_t
end

function hipModuleLoadDataEx(_module, image, numOptions, options, optionValues)
    @ccall libhip.hipModuleLoadDataEx(_module::Ptr{hipModule_t}, image::Ptr{Cvoid}, numOptions::Cuint, options::Ptr{hipJitOption}, optionValues::Ptr{Ptr{Cvoid}})::hipError_t
end

function hipModuleLaunchKernel(f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, sharedMemBytes, stream, kernelParams, extra)
    @ccall libhip.hipModuleLaunchKernel(f::hipFunction_t, gridDimX::Cuint, gridDimY::Cuint, gridDimZ::Cuint, blockDimX::Cuint, blockDimY::Cuint, blockDimZ::Cuint, sharedMemBytes::Cuint, stream::hipStream_t, kernelParams::Ptr{Ptr{Cvoid}}, extra::Ptr{Ptr{Cvoid}})::hipError_t
end

function hipModuleLaunchCooperativeKernel(f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, sharedMemBytes, stream, kernelParams)
    @ccall libhip.hipModuleLaunchCooperativeKernel(f::hipFunction_t, gridDimX::Cuint, gridDimY::Cuint, gridDimZ::Cuint, blockDimX::Cuint, blockDimY::Cuint, blockDimZ::Cuint, sharedMemBytes::Cuint, stream::hipStream_t, kernelParams::Ptr{Ptr{Cvoid}})::hipError_t
end

function hipModuleLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags)
    @ccall libhip.hipModuleLaunchCooperativeKernelMultiDevice(launchParamsList::Ptr{hipFunctionLaunchParams}, numDevices::Cuint, flags::Cuint)::hipError_t
end

function hipLaunchCooperativeKernel(f, gridDim, blockDimX, kernelParams, sharedMemBytes, stream)
    @ccall libhip.hipLaunchCooperativeKernel(f::Ptr{Cvoid}, gridDim::dim3, blockDimX::dim3, kernelParams::Ptr{Ptr{Cvoid}}, sharedMemBytes::Cuint, stream::hipStream_t)::hipError_t
end

function hipLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags)
    @ccall libhip.hipLaunchCooperativeKernelMultiDevice(launchParamsList::Ptr{hipLaunchParams}, numDevices::Cint, flags::Cuint)::hipError_t
end

function hipExtLaunchMultiKernelMultiDevice(launchParamsList, numDevices, flags)
    @ccall libhip.hipExtLaunchMultiKernelMultiDevice(launchParamsList::Ptr{hipLaunchParams}, numDevices::Cint, flags::Cuint)::hipError_t
end

function hipModuleOccupancyMaxPotentialBlockSize(gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit)
    @ccall libhip.hipModuleOccupancyMaxPotentialBlockSize(gridSize::Ptr{Cint}, blockSize::Ptr{Cint}, f::hipFunction_t, dynSharedMemPerBlk::Csize_t, blockSizeLimit::Cint)::hipError_t
end

function hipModuleOccupancyMaxPotentialBlockSizeWithFlags(gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit, flags)
    @ccall libhip.hipModuleOccupancyMaxPotentialBlockSizeWithFlags(gridSize::Ptr{Cint}, blockSize::Ptr{Cint}, f::hipFunction_t, dynSharedMemPerBlk::Csize_t, blockSizeLimit::Cint, flags::Cuint)::hipError_t
end

function hipModuleOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks, f, blockSize, dynSharedMemPerBlk)
    @ccall libhip.hipModuleOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks::Ptr{Cint}, f::hipFunction_t, blockSize::Cint, dynSharedMemPerBlk::Csize_t)::hipError_t
end

function hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks, f, blockSize, dynSharedMemPerBlk, flags)
    @ccall libhip.hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks::Ptr{Cint}, f::hipFunction_t, blockSize::Cint, dynSharedMemPerBlk::Csize_t, flags::Cuint)::hipError_t
end

function hipOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks, f, blockSize, dynSharedMemPerBlk)
    @ccall libhip.hipOccupancyMaxActiveBlocksPerMultiprocessor(numBlocks::Ptr{Cint}, f::Ptr{Cvoid}, blockSize::Cint, dynSharedMemPerBlk::Csize_t)::hipError_t
end

function hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks, f, blockSize, dynSharedMemPerBlk, flags)
    @ccall libhip.hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(numBlocks::Ptr{Cint}, f::Ptr{Cvoid}, blockSize::Cint, dynSharedMemPerBlk::Csize_t, flags::Cuint)::hipError_t
end

function hipOccupancyMaxPotentialBlockSize(gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit)
    @ccall libhip.hipOccupancyMaxPotentialBlockSize(gridSize::Ptr{Cint}, blockSize::Ptr{Cint}, f::Ptr{Cvoid}, dynSharedMemPerBlk::Csize_t, blockSizeLimit::Cint)::hipError_t
end

# no prototype is found for this function at hip_runtime_api.h:5397:12, please use with caution
function hipProfilerStart()
    @ccall libhip.hipProfilerStart()::hipError_t
end

# no prototype is found for this function at hip_runtime_api.h:5405:12, please use with caution
function hipProfilerStop()
    @ccall libhip.hipProfilerStop()::hipError_t
end

function hipConfigureCall(gridDim, blockDim, sharedMem, stream)
    @ccall libhip.hipConfigureCall(gridDim::dim3, blockDim::dim3, sharedMem::Csize_t, stream::hipStream_t)::hipError_t
end

function hipSetupArgument(arg, size, offset)
    @ccall libhip.hipSetupArgument(arg::Ptr{Cvoid}, size::Csize_t, offset::Csize_t)::hipError_t
end

function hipLaunchByPtr(func)
    @ccall libhip.hipLaunchByPtr(func::Ptr{Cvoid})::hipError_t
end

function __hipPushCallConfiguration(gridDim, blockDim, sharedMem, stream)
    @ccall libhip.__hipPushCallConfiguration(gridDim::dim3, blockDim::dim3, sharedMem::Csize_t, stream::hipStream_t)::hipError_t
end

function __hipPopCallConfiguration(gridDim, blockDim, sharedMem, stream)
    @ccall libhip.__hipPopCallConfiguration(gridDim::Ptr{dim3}, blockDim::Ptr{dim3}, sharedMem::Ptr{Csize_t}, stream::Ptr{hipStream_t})::hipError_t
end

function hipLaunchKernel(function_address, numBlocks, dimBlocks, args, sharedMemBytes, stream)
    @ccall libhip.hipLaunchKernel(function_address::Ptr{Cvoid}, numBlocks::dim3, dimBlocks::dim3, args::Ptr{Ptr{Cvoid}}, sharedMemBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipLaunchHostFunc(stream, fn, userData)
    @ccall libhip.hipLaunchHostFunc(stream::hipStream_t, fn::hipHostFn_t, userData::Ptr{Cvoid})::hipError_t
end

function hipDrvMemcpy2DUnaligned(pCopy)
    @ccall libhip.hipDrvMemcpy2DUnaligned(pCopy::Ptr{hip_Memcpy2D})::hipError_t
end

function hipExtLaunchKernel(function_address, numBlocks, dimBlocks, args, sharedMemBytes, stream, startEvent, stopEvent, flags)
    @ccall libhip.hipExtLaunchKernel(function_address::Ptr{Cvoid}, numBlocks::dim3, dimBlocks::dim3, args::Ptr{Ptr{Cvoid}}, sharedMemBytes::Csize_t, stream::hipStream_t, startEvent::hipEvent_t, stopEvent::hipEvent_t, flags::Cint)::hipError_t
end

function hipCreateTextureObject(pTexObject, pResDesc, pTexDesc, pResViewDesc)
    @ccall libhip.hipCreateTextureObject(pTexObject::Ptr{hipTextureObject_t}, pResDesc::Ptr{hipResourceDesc}, pTexDesc::Ptr{hipTextureDesc}, pResViewDesc::Ptr{hipResourceViewDesc})::hipError_t
end

function hipDestroyTextureObject(textureObject)
    @ccall libhip.hipDestroyTextureObject(textureObject::hipTextureObject_t)::hipError_t
end

function hipGetChannelDesc(desc, array)
    @ccall libhip.hipGetChannelDesc(desc::Ptr{hipChannelFormatDesc}, array::hipArray_const_t)::hipError_t
end

function hipGetTextureObjectResourceDesc(pResDesc, textureObject)
    @ccall libhip.hipGetTextureObjectResourceDesc(pResDesc::Ptr{hipResourceDesc}, textureObject::hipTextureObject_t)::hipError_t
end

function hipGetTextureObjectResourceViewDesc(pResViewDesc, textureObject)
    @ccall libhip.hipGetTextureObjectResourceViewDesc(pResViewDesc::Ptr{hipResourceViewDesc}, textureObject::hipTextureObject_t)::hipError_t
end

function hipGetTextureObjectTextureDesc(pTexDesc, textureObject)
    @ccall libhip.hipGetTextureObjectTextureDesc(pTexDesc::Ptr{hipTextureDesc}, textureObject::hipTextureObject_t)::hipError_t
end

function hipTexObjectCreate(pTexObject, pResDesc, pTexDesc, pResViewDesc)
    @ccall libhip.hipTexObjectCreate(pTexObject::Ptr{hipTextureObject_t}, pResDesc::Ptr{HIP_RESOURCE_DESC}, pTexDesc::Ptr{HIP_TEXTURE_DESC}, pResViewDesc::Ptr{HIP_RESOURCE_VIEW_DESC})::hipError_t
end

function hipTexObjectDestroy(texObject)
    @ccall libhip.hipTexObjectDestroy(texObject::hipTextureObject_t)::hipError_t
end

function hipTexObjectGetResourceDesc(pResDesc, texObject)
    @ccall libhip.hipTexObjectGetResourceDesc(pResDesc::Ptr{HIP_RESOURCE_DESC}, texObject::hipTextureObject_t)::hipError_t
end

function hipTexObjectGetResourceViewDesc(pResViewDesc, texObject)
    @ccall libhip.hipTexObjectGetResourceViewDesc(pResViewDesc::Ptr{HIP_RESOURCE_VIEW_DESC}, texObject::hipTextureObject_t)::hipError_t
end

function hipTexObjectGetTextureDesc(pTexDesc, texObject)
    @ccall libhip.hipTexObjectGetTextureDesc(pTexDesc::Ptr{HIP_TEXTURE_DESC}, texObject::hipTextureObject_t)::hipError_t
end

function hipMallocMipmappedArray(mipmappedArray, desc, extent, numLevels, flags)
    @ccall libhip.hipMallocMipmappedArray(mipmappedArray::Ptr{hipMipmappedArray_t}, desc::Ptr{hipChannelFormatDesc}, extent::hipExtent, numLevels::Cuint, flags::Cuint)::hipError_t
end

function hipFreeMipmappedArray(mipmappedArray)
    @ccall libhip.hipFreeMipmappedArray(mipmappedArray::hipMipmappedArray_t)::hipError_t
end

function hipGetMipmappedArrayLevel(levelArray, mipmappedArray, level)
    @ccall libhip.hipGetMipmappedArrayLevel(levelArray::Ptr{hipArray_t}, mipmappedArray::hipMipmappedArray_const_t, level::Cuint)::hipError_t
end

function hipMipmappedArrayCreate(pHandle, pMipmappedArrayDesc, numMipmapLevels)
    @ccall libhip.hipMipmappedArrayCreate(pHandle::Ptr{hipMipmappedArray_t}, pMipmappedArrayDesc::Ptr{HIP_ARRAY3D_DESCRIPTOR}, numMipmapLevels::Cuint)::hipError_t
end

function hipMipmappedArrayDestroy(hMipmappedArray)
    @ccall libhip.hipMipmappedArrayDestroy(hMipmappedArray::hipMipmappedArray_t)::hipError_t
end

function hipMipmappedArrayGetLevel(pLevelArray, hMipMappedArray, level)
    @ccall libhip.hipMipmappedArrayGetLevel(pLevelArray::Ptr{hipArray_t}, hMipMappedArray::hipMipmappedArray_t, level::Cuint)::hipError_t
end

function hipBindTextureToMipmappedArray(tex, mipmappedArray, desc)
    @ccall libhip.hipBindTextureToMipmappedArray(tex::Ptr{textureReference}, mipmappedArray::hipMipmappedArray_const_t, desc::Ptr{hipChannelFormatDesc})::hipError_t
end

function hipGetTextureReference(texref, symbol)
    @ccall libhip.hipGetTextureReference(texref::Ptr{Ptr{textureReference}}, symbol::Ptr{Cvoid})::hipError_t
end

function hipTexRefSetAddressMode(texRef, dim, am)
    @ccall libhip.hipTexRefSetAddressMode(texRef::Ptr{textureReference}, dim::Cint, am::hipTextureAddressMode)::hipError_t
end

function hipTexRefSetArray(tex, array, flags)
    @ccall libhip.hipTexRefSetArray(tex::Ptr{textureReference}, array::hipArray_const_t, flags::Cuint)::hipError_t
end

function hipTexRefSetFilterMode(texRef, fm)
    @ccall libhip.hipTexRefSetFilterMode(texRef::Ptr{textureReference}, fm::hipTextureFilterMode)::hipError_t
end

function hipTexRefSetFlags(texRef, Flags)
    @ccall libhip.hipTexRefSetFlags(texRef::Ptr{textureReference}, Flags::Cuint)::hipError_t
end

function hipTexRefSetFormat(texRef, fmt, NumPackedComponents)
    @ccall libhip.hipTexRefSetFormat(texRef::Ptr{textureReference}, fmt::hipArray_Format, NumPackedComponents::Cint)::hipError_t
end

function hipBindTexture(offset, tex, devPtr, desc, size)
    @ccall libhip.hipBindTexture(offset::Ptr{Csize_t}, tex::Ptr{textureReference}, devPtr::Ptr{Cvoid}, desc::Ptr{hipChannelFormatDesc}, size::Csize_t)::hipError_t
end

function hipBindTexture2D(offset, tex, devPtr, desc, width, height, pitch)
    @ccall libhip.hipBindTexture2D(offset::Ptr{Csize_t}, tex::Ptr{textureReference}, devPtr::Ptr{Cvoid}, desc::Ptr{hipChannelFormatDesc}, width::Csize_t, height::Csize_t, pitch::Csize_t)::hipError_t
end

function hipBindTextureToArray(tex, array, desc)
    @ccall libhip.hipBindTextureToArray(tex::Ptr{textureReference}, array::hipArray_const_t, desc::Ptr{hipChannelFormatDesc})::hipError_t
end

function hipGetTextureAlignmentOffset(offset, texref)
    @ccall libhip.hipGetTextureAlignmentOffset(offset::Ptr{Csize_t}, texref::Ptr{textureReference})::hipError_t
end

function hipUnbindTexture(tex)
    @ccall libhip.hipUnbindTexture(tex::Ptr{textureReference})::hipError_t
end

function hipTexRefGetAddress(dev_ptr, texRef)
    @ccall libhip.hipTexRefGetAddress(dev_ptr::Ptr{hipDeviceptr_t}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetAddressMode(pam, texRef, dim)
    @ccall libhip.hipTexRefGetAddressMode(pam::Ptr{hipTextureAddressMode}, texRef::Ptr{textureReference}, dim::Cint)::hipError_t
end

function hipTexRefGetFilterMode(pfm, texRef)
    @ccall libhip.hipTexRefGetFilterMode(pfm::Ptr{hipTextureFilterMode}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetFlags(pFlags, texRef)
    @ccall libhip.hipTexRefGetFlags(pFlags::Ptr{Cuint}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetFormat(pFormat, pNumChannels, texRef)
    @ccall libhip.hipTexRefGetFormat(pFormat::Ptr{hipArray_Format}, pNumChannels::Ptr{Cint}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetMaxAnisotropy(pmaxAnsio, texRef)
    @ccall libhip.hipTexRefGetMaxAnisotropy(pmaxAnsio::Ptr{Cint}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetMipmapFilterMode(pfm, texRef)
    @ccall libhip.hipTexRefGetMipmapFilterMode(pfm::Ptr{hipTextureFilterMode}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetMipmapLevelBias(pbias, texRef)
    @ccall libhip.hipTexRefGetMipmapLevelBias(pbias::Ptr{Cfloat}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetMipmapLevelClamp(pminMipmapLevelClamp, pmaxMipmapLevelClamp, texRef)
    @ccall libhip.hipTexRefGetMipmapLevelClamp(pminMipmapLevelClamp::Ptr{Cfloat}, pmaxMipmapLevelClamp::Ptr{Cfloat}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefGetMipMappedArray(pArray, texRef)
    @ccall libhip.hipTexRefGetMipMappedArray(pArray::Ptr{hipMipmappedArray_t}, texRef::Ptr{textureReference})::hipError_t
end

function hipTexRefSetAddress(ByteOffset, texRef, dptr, bytes)
    @ccall libhip.hipTexRefSetAddress(ByteOffset::Ptr{Csize_t}, texRef::Ptr{textureReference}, dptr::hipDeviceptr_t, bytes::Csize_t)::hipError_t
end

function hipTexRefSetAddress2D(texRef, desc, dptr, Pitch)
    @ccall libhip.hipTexRefSetAddress2D(texRef::Ptr{textureReference}, desc::Ptr{HIP_ARRAY_DESCRIPTOR}, dptr::hipDeviceptr_t, Pitch::Csize_t)::hipError_t
end

function hipTexRefSetMaxAnisotropy(texRef, maxAniso)
    @ccall libhip.hipTexRefSetMaxAnisotropy(texRef::Ptr{textureReference}, maxAniso::Cuint)::hipError_t
end

function hipTexRefSetBorderColor(texRef, pBorderColor)
    @ccall libhip.hipTexRefSetBorderColor(texRef::Ptr{textureReference}, pBorderColor::Ptr{Cfloat})::hipError_t
end

function hipTexRefSetMipmapFilterMode(texRef, fm)
    @ccall libhip.hipTexRefSetMipmapFilterMode(texRef::Ptr{textureReference}, fm::hipTextureFilterMode)::hipError_t
end

function hipTexRefSetMipmapLevelBias(texRef, bias)
    @ccall libhip.hipTexRefSetMipmapLevelBias(texRef::Ptr{textureReference}, bias::Cfloat)::hipError_t
end

function hipTexRefSetMipmapLevelClamp(texRef, minMipMapLevelClamp, maxMipMapLevelClamp)
    @ccall libhip.hipTexRefSetMipmapLevelClamp(texRef::Ptr{textureReference}, minMipMapLevelClamp::Cfloat, maxMipMapLevelClamp::Cfloat)::hipError_t
end

function hipTexRefSetMipmappedArray(texRef, mipmappedArray, Flags)
    @ccall libhip.hipTexRefSetMipmappedArray(texRef::Ptr{textureReference}, mipmappedArray::Ptr{hipMipmappedArray}, Flags::Cuint)::hipError_t
end

function hipApiName(id)
    @ccall libhip.hipApiName(id::UInt32)::Cstring
end

function hipKernelNameRef(f)
    @ccall libhip.hipKernelNameRef(f::hipFunction_t)::Cstring
end

function hipKernelNameRefByPtr(hostFunction, stream)
    @ccall libhip.hipKernelNameRefByPtr(hostFunction::Ptr{Cvoid}, stream::hipStream_t)::Cstring
end

function hipGetStreamDeviceId(stream)
    @ccall libhip.hipGetStreamDeviceId(stream::hipStream_t)::Cint
end

function hipStreamBeginCapture(stream, mode)
    @ccall libhip.hipStreamBeginCapture(stream::hipStream_t, mode::hipStreamCaptureMode)::hipError_t
end

function hipStreamEndCapture(stream, pGraph)
    @ccall libhip.hipStreamEndCapture(stream::hipStream_t, pGraph::Ptr{hipGraph_t})::hipError_t
end

function hipStreamGetCaptureInfo(stream, pCaptureStatus, pId)
    @ccall libhip.hipStreamGetCaptureInfo(stream::hipStream_t, pCaptureStatus::Ptr{hipStreamCaptureStatus}, pId::Ptr{Culonglong})::hipError_t
end

function hipStreamGetCaptureInfo_v2(stream, captureStatus_out, id_out, graph_out, dependencies_out, numDependencies_out)
    @ccall libhip.hipStreamGetCaptureInfo_v2(stream::hipStream_t, captureStatus_out::Ptr{hipStreamCaptureStatus}, id_out::Ptr{Culonglong}, graph_out::Ptr{hipGraph_t}, dependencies_out::Ptr{Ptr{hipGraphNode_t}}, numDependencies_out::Ptr{Csize_t})::hipError_t
end

function hipStreamIsCapturing(stream, pCaptureStatus)
    @ccall libhip.hipStreamIsCapturing(stream::hipStream_t, pCaptureStatus::Ptr{hipStreamCaptureStatus})::hipError_t
end

function hipStreamUpdateCaptureDependencies(stream, dependencies, numDependencies, flags)
    @ccall libhip.hipStreamUpdateCaptureDependencies(stream::hipStream_t, dependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, flags::Cuint)::hipError_t
end

function hipThreadExchangeStreamCaptureMode(mode)
    @ccall libhip.hipThreadExchangeStreamCaptureMode(mode::Ptr{hipStreamCaptureMode})::hipError_t
end

function hipGraphCreate(pGraph, flags)
    @ccall libhip.hipGraphCreate(pGraph::Ptr{hipGraph_t}, flags::Cuint)::hipError_t
end

function hipGraphDestroy(graph)
    @ccall libhip.hipGraphDestroy(graph::hipGraph_t)::hipError_t
end

function hipGraphAddDependencies(graph, from, to, numDependencies)
    @ccall libhip.hipGraphAddDependencies(graph::hipGraph_t, from::Ptr{hipGraphNode_t}, to::Ptr{hipGraphNode_t}, numDependencies::Csize_t)::hipError_t
end

function hipGraphRemoveDependencies(graph, from, to, numDependencies)
    @ccall libhip.hipGraphRemoveDependencies(graph::hipGraph_t, from::Ptr{hipGraphNode_t}, to::Ptr{hipGraphNode_t}, numDependencies::Csize_t)::hipError_t
end

function hipGraphGetEdges(graph, from, to, numEdges)
    @ccall libhip.hipGraphGetEdges(graph::hipGraph_t, from::Ptr{hipGraphNode_t}, to::Ptr{hipGraphNode_t}, numEdges::Ptr{Csize_t})::hipError_t
end

function hipGraphGetNodes(graph, nodes, numNodes)
    @ccall libhip.hipGraphGetNodes(graph::hipGraph_t, nodes::Ptr{hipGraphNode_t}, numNodes::Ptr{Csize_t})::hipError_t
end

function hipGraphGetRootNodes(graph, pRootNodes, pNumRootNodes)
    @ccall libhip.hipGraphGetRootNodes(graph::hipGraph_t, pRootNodes::Ptr{hipGraphNode_t}, pNumRootNodes::Ptr{Csize_t})::hipError_t
end

function hipGraphNodeGetDependencies(node, pDependencies, pNumDependencies)
    @ccall libhip.hipGraphNodeGetDependencies(node::hipGraphNode_t, pDependencies::Ptr{hipGraphNode_t}, pNumDependencies::Ptr{Csize_t})::hipError_t
end

function hipGraphNodeGetDependentNodes(node, pDependentNodes, pNumDependentNodes)
    @ccall libhip.hipGraphNodeGetDependentNodes(node::hipGraphNode_t, pDependentNodes::Ptr{hipGraphNode_t}, pNumDependentNodes::Ptr{Csize_t})::hipError_t
end

function hipGraphNodeGetType(node, pType)
    @ccall libhip.hipGraphNodeGetType(node::hipGraphNode_t, pType::Ptr{hipGraphNodeType})::hipError_t
end

function hipGraphDestroyNode(node)
    @ccall libhip.hipGraphDestroyNode(node::hipGraphNode_t)::hipError_t
end

function hipGraphClone(pGraphClone, originalGraph)
    @ccall libhip.hipGraphClone(pGraphClone::Ptr{hipGraph_t}, originalGraph::hipGraph_t)::hipError_t
end

function hipGraphNodeFindInClone(pNode, originalNode, clonedGraph)
    @ccall libhip.hipGraphNodeFindInClone(pNode::Ptr{hipGraphNode_t}, originalNode::hipGraphNode_t, clonedGraph::hipGraph_t)::hipError_t
end

function hipGraphInstantiate(pGraphExec, graph, pErrorNode, pLogBuffer, bufferSize)
    @ccall libhip.hipGraphInstantiate(pGraphExec::Ptr{hipGraphExec_t}, graph::hipGraph_t, pErrorNode::Ptr{hipGraphNode_t}, pLogBuffer::Cstring, bufferSize::Csize_t)::hipError_t
end

function hipGraphInstantiateWithFlags(pGraphExec, graph, flags)
    @ccall libhip.hipGraphInstantiateWithFlags(pGraphExec::Ptr{hipGraphExec_t}, graph::hipGraph_t, flags::Culonglong)::hipError_t
end

function hipGraphLaunch(graphExec, stream)
    @ccall libhip.hipGraphLaunch(graphExec::hipGraphExec_t, stream::hipStream_t)::hipError_t
end

function hipGraphUpload(graphExec, stream)
    @ccall libhip.hipGraphUpload(graphExec::hipGraphExec_t, stream::hipStream_t)::hipError_t
end

function hipGraphExecDestroy(graphExec)
    @ccall libhip.hipGraphExecDestroy(graphExec::hipGraphExec_t)::hipError_t
end

function hipGraphExecUpdate(hGraphExec, hGraph, hErrorNode_out, updateResult_out)
    @ccall libhip.hipGraphExecUpdate(hGraphExec::hipGraphExec_t, hGraph::hipGraph_t, hErrorNode_out::Ptr{hipGraphNode_t}, updateResult_out::Ptr{hipGraphExecUpdateResult})::hipError_t
end

function hipGraphAddKernelNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams)
    @ccall libhip.hipGraphAddKernelNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, pNodeParams::Ptr{hipKernelNodeParams})::hipError_t
end

function hipGraphKernelNodeGetParams(node, pNodeParams)
    @ccall libhip.hipGraphKernelNodeGetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipKernelNodeParams})::hipError_t
end

function hipGraphKernelNodeSetParams(node, pNodeParams)
    @ccall libhip.hipGraphKernelNodeSetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipKernelNodeParams})::hipError_t
end

function hipGraphExecKernelNodeSetParams(hGraphExec, node, pNodeParams)
    @ccall libhip.hipGraphExecKernelNodeSetParams(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, pNodeParams::Ptr{hipKernelNodeParams})::hipError_t
end

function hipDrvGraphAddMemcpyNode(phGraphNode, hGraph, dependencies, numDependencies, copyParams, ctx)
    @ccall libhip.hipDrvGraphAddMemcpyNode(phGraphNode::Ptr{hipGraphNode_t}, hGraph::hipGraph_t, dependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, copyParams::Ptr{HIP_MEMCPY3D}, ctx::hipCtx_t)::hipError_t
end

function hipGraphAddMemcpyNode(pGraphNode, graph, pDependencies, numDependencies, pCopyParams)
    @ccall libhip.hipGraphAddMemcpyNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, pCopyParams::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipGraphMemcpyNodeGetParams(node, pNodeParams)
    @ccall libhip.hipGraphMemcpyNodeGetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipGraphMemcpyNodeSetParams(node, pNodeParams)
    @ccall libhip.hipGraphMemcpyNodeSetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipGraphKernelNodeSetAttribute(hNode, attr, value)
    @ccall libhip.hipGraphKernelNodeSetAttribute(hNode::hipGraphNode_t, attr::hipKernelNodeAttrID, value::Ptr{hipKernelNodeAttrValue})::hipError_t
end

function hipGraphKernelNodeGetAttribute(hNode, attr, value)
    @ccall libhip.hipGraphKernelNodeGetAttribute(hNode::hipGraphNode_t, attr::hipKernelNodeAttrID, value::Ptr{hipKernelNodeAttrValue})::hipError_t
end

function hipGraphExecMemcpyNodeSetParams(hGraphExec, node, pNodeParams)
    @ccall libhip.hipGraphExecMemcpyNodeSetParams(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, pNodeParams::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipGraphAddMemcpyNode1D(pGraphNode, graph, pDependencies, numDependencies, dst, src, count, kind)
    @ccall libhip.hipGraphAddMemcpyNode1D(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, dst::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphMemcpyNodeSetParams1D(node, dst, src, count, kind)
    @ccall libhip.hipGraphMemcpyNodeSetParams1D(node::hipGraphNode_t, dst::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphExecMemcpyNodeSetParams1D(hGraphExec, node, dst, src, count, kind)
    @ccall libhip.hipGraphExecMemcpyNodeSetParams1D(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, dst::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphAddMemcpyNodeFromSymbol(pGraphNode, graph, pDependencies, numDependencies, dst, symbol, count, offset, kind)
    @ccall libhip.hipGraphAddMemcpyNodeFromSymbol(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphMemcpyNodeSetParamsFromSymbol(node, dst, symbol, count, offset, kind)
    @ccall libhip.hipGraphMemcpyNodeSetParamsFromSymbol(node::hipGraphNode_t, dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphExecMemcpyNodeSetParamsFromSymbol(hGraphExec, node, dst, symbol, count, offset, kind)
    @ccall libhip.hipGraphExecMemcpyNodeSetParamsFromSymbol(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphAddMemcpyNodeToSymbol(pGraphNode, graph, pDependencies, numDependencies, symbol, src, count, offset, kind)
    @ccall libhip.hipGraphAddMemcpyNodeToSymbol(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphMemcpyNodeSetParamsToSymbol(node, symbol, src, count, offset, kind)
    @ccall libhip.hipGraphMemcpyNodeSetParamsToSymbol(node::hipGraphNode_t, symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphExecMemcpyNodeSetParamsToSymbol(hGraphExec, node, symbol, src, count, offset, kind)
    @ccall libhip.hipGraphExecMemcpyNodeSetParamsToSymbol(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, count::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipGraphAddMemsetNode(pGraphNode, graph, pDependencies, numDependencies, pMemsetParams)
    @ccall libhip.hipGraphAddMemsetNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, pMemsetParams::Ptr{hipMemsetParams})::hipError_t
end

function hipGraphMemsetNodeGetParams(node, pNodeParams)
    @ccall libhip.hipGraphMemsetNodeGetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipMemsetParams})::hipError_t
end

function hipGraphMemsetNodeSetParams(node, pNodeParams)
    @ccall libhip.hipGraphMemsetNodeSetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipMemsetParams})::hipError_t
end

function hipGraphExecMemsetNodeSetParams(hGraphExec, node, pNodeParams)
    @ccall libhip.hipGraphExecMemsetNodeSetParams(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, pNodeParams::Ptr{hipMemsetParams})::hipError_t
end

function hipGraphAddHostNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams)
    @ccall libhip.hipGraphAddHostNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, pNodeParams::Ptr{hipHostNodeParams})::hipError_t
end

function hipGraphHostNodeGetParams(node, pNodeParams)
    @ccall libhip.hipGraphHostNodeGetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipHostNodeParams})::hipError_t
end

function hipGraphHostNodeSetParams(node, pNodeParams)
    @ccall libhip.hipGraphHostNodeSetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipHostNodeParams})::hipError_t
end

function hipGraphExecHostNodeSetParams(hGraphExec, node, pNodeParams)
    @ccall libhip.hipGraphExecHostNodeSetParams(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, pNodeParams::Ptr{hipHostNodeParams})::hipError_t
end

function hipGraphAddChildGraphNode(pGraphNode, graph, pDependencies, numDependencies, childGraph)
    @ccall libhip.hipGraphAddChildGraphNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, childGraph::hipGraph_t)::hipError_t
end

function hipGraphChildGraphNodeGetGraph(node, pGraph)
    @ccall libhip.hipGraphChildGraphNodeGetGraph(node::hipGraphNode_t, pGraph::Ptr{hipGraph_t})::hipError_t
end

function hipGraphExecChildGraphNodeSetParams(hGraphExec, node, childGraph)
    @ccall libhip.hipGraphExecChildGraphNodeSetParams(hGraphExec::hipGraphExec_t, node::hipGraphNode_t, childGraph::hipGraph_t)::hipError_t
end

function hipGraphAddEmptyNode(pGraphNode, graph, pDependencies, numDependencies)
    @ccall libhip.hipGraphAddEmptyNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t)::hipError_t
end

function hipGraphAddEventRecordNode(pGraphNode, graph, pDependencies, numDependencies, event)
    @ccall libhip.hipGraphAddEventRecordNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, event::hipEvent_t)::hipError_t
end

function hipGraphEventRecordNodeGetEvent(node, event_out)
    @ccall libhip.hipGraphEventRecordNodeGetEvent(node::hipGraphNode_t, event_out::Ptr{hipEvent_t})::hipError_t
end

function hipGraphEventRecordNodeSetEvent(node, event)
    @ccall libhip.hipGraphEventRecordNodeSetEvent(node::hipGraphNode_t, event::hipEvent_t)::hipError_t
end

function hipGraphExecEventRecordNodeSetEvent(hGraphExec, hNode, event)
    @ccall libhip.hipGraphExecEventRecordNodeSetEvent(hGraphExec::hipGraphExec_t, hNode::hipGraphNode_t, event::hipEvent_t)::hipError_t
end

function hipGraphAddEventWaitNode(pGraphNode, graph, pDependencies, numDependencies, event)
    @ccall libhip.hipGraphAddEventWaitNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, event::hipEvent_t)::hipError_t
end

function hipGraphEventWaitNodeGetEvent(node, event_out)
    @ccall libhip.hipGraphEventWaitNodeGetEvent(node::hipGraphNode_t, event_out::Ptr{hipEvent_t})::hipError_t
end

function hipGraphEventWaitNodeSetEvent(node, event)
    @ccall libhip.hipGraphEventWaitNodeSetEvent(node::hipGraphNode_t, event::hipEvent_t)::hipError_t
end

function hipGraphExecEventWaitNodeSetEvent(hGraphExec, hNode, event)
    @ccall libhip.hipGraphExecEventWaitNodeSetEvent(hGraphExec::hipGraphExec_t, hNode::hipGraphNode_t, event::hipEvent_t)::hipError_t
end

function hipGraphAddMemAllocNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams)
    @ccall libhip.hipGraphAddMemAllocNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, pNodeParams::Ptr{hipMemAllocNodeParams})::hipError_t
end

function hipGraphMemAllocNodeGetParams(node, pNodeParams)
    @ccall libhip.hipGraphMemAllocNodeGetParams(node::hipGraphNode_t, pNodeParams::Ptr{hipMemAllocNodeParams})::hipError_t
end

function hipGraphAddMemFreeNode(pGraphNode, graph, pDependencies, numDependencies, dev_ptr)
    @ccall libhip.hipGraphAddMemFreeNode(pGraphNode::Ptr{hipGraphNode_t}, graph::hipGraph_t, pDependencies::Ptr{hipGraphNode_t}, numDependencies::Csize_t, dev_ptr::Ptr{Cvoid})::hipError_t
end

function hipGraphMemFreeNodeGetParams(node, dev_ptr)
    @ccall libhip.hipGraphMemFreeNodeGetParams(node::hipGraphNode_t, dev_ptr::Ptr{Cvoid})::hipError_t
end

function hipDeviceGetGraphMemAttribute(device, attr, value)
    @ccall libhip.hipDeviceGetGraphMemAttribute(device::Cint, attr::hipGraphMemAttributeType, value::Ptr{Cvoid})::hipError_t
end

function hipDeviceSetGraphMemAttribute(device, attr, value)
    @ccall libhip.hipDeviceSetGraphMemAttribute(device::Cint, attr::hipGraphMemAttributeType, value::Ptr{Cvoid})::hipError_t
end

function hipDeviceGraphMemTrim(device)
    @ccall libhip.hipDeviceGraphMemTrim(device::Cint)::hipError_t
end

function hipUserObjectCreate(object_out, ptr, destroy, initialRefcount, flags)
    @ccall libhip.hipUserObjectCreate(object_out::Ptr{hipUserObject_t}, ptr::Ptr{Cvoid}, destroy::hipHostFn_t, initialRefcount::Cuint, flags::Cuint)::hipError_t
end

function hipUserObjectRelease(object, count)
    @ccall libhip.hipUserObjectRelease(object::hipUserObject_t, count::Cuint)::hipError_t
end

function hipUserObjectRetain(object, count)
    @ccall libhip.hipUserObjectRetain(object::hipUserObject_t, count::Cuint)::hipError_t
end

function hipGraphRetainUserObject(graph, object, count, flags)
    @ccall libhip.hipGraphRetainUserObject(graph::hipGraph_t, object::hipUserObject_t, count::Cuint, flags::Cuint)::hipError_t
end

function hipGraphReleaseUserObject(graph, object, count)
    @ccall libhip.hipGraphReleaseUserObject(graph::hipGraph_t, object::hipUserObject_t, count::Cuint)::hipError_t
end

function hipGraphDebugDotPrint(graph, path, flags)
    @ccall libhip.hipGraphDebugDotPrint(graph::hipGraph_t, path::Cstring, flags::Cuint)::hipError_t
end

function hipGraphKernelNodeCopyAttributes(hSrc, hDst)
    @ccall libhip.hipGraphKernelNodeCopyAttributes(hSrc::hipGraphNode_t, hDst::hipGraphNode_t)::hipError_t
end

function hipGraphNodeSetEnabled(hGraphExec, hNode, isEnabled)
    @ccall libhip.hipGraphNodeSetEnabled(hGraphExec::hipGraphExec_t, hNode::hipGraphNode_t, isEnabled::Cuint)::hipError_t
end

function hipGraphNodeGetEnabled(hGraphExec, hNode, isEnabled)
    @ccall libhip.hipGraphNodeGetEnabled(hGraphExec::hipGraphExec_t, hNode::hipGraphNode_t, isEnabled::Ptr{Cuint})::hipError_t
end

function hipMemAddressFree(devPtr, size)
    @ccall libhip.hipMemAddressFree(devPtr::Ptr{Cvoid}, size::Csize_t)::hipError_t
end

function hipMemAddressReserve(ptr, size, alignment, addr, flags)
    @ccall libhip.hipMemAddressReserve(ptr::Ptr{Ptr{Cvoid}}, size::Csize_t, alignment::Csize_t, addr::Ptr{Cvoid}, flags::Culonglong)::hipError_t
end

function hipMemCreate(handle, size, prop, flags)
    @ccall libhip.hipMemCreate(handle::Ptr{hipMemGenericAllocationHandle_t}, size::Csize_t, prop::Ptr{hipMemAllocationProp}, flags::Culonglong)::hipError_t
end

function hipMemExportToShareableHandle(shareableHandle, handle, handleType, flags)
    @ccall libhip.hipMemExportToShareableHandle(shareableHandle::Ptr{Cvoid}, handle::hipMemGenericAllocationHandle_t, handleType::hipMemAllocationHandleType, flags::Culonglong)::hipError_t
end

function hipMemGetAccess(flags, location, ptr)
    @ccall libhip.hipMemGetAccess(flags::Ptr{Culonglong}, location::Ptr{hipMemLocation}, ptr::Ptr{Cvoid})::hipError_t
end

function hipMemGetAllocationGranularity(granularity, prop, option)
    @ccall libhip.hipMemGetAllocationGranularity(granularity::Ptr{Csize_t}, prop::Ptr{hipMemAllocationProp}, option::hipMemAllocationGranularity_flags)::hipError_t
end

function hipMemGetAllocationPropertiesFromHandle(prop, handle)
    @ccall libhip.hipMemGetAllocationPropertiesFromHandle(prop::Ptr{hipMemAllocationProp}, handle::hipMemGenericAllocationHandle_t)::hipError_t
end

function hipMemImportFromShareableHandle(handle, osHandle, shHandleType)
    @ccall libhip.hipMemImportFromShareableHandle(handle::Ptr{hipMemGenericAllocationHandle_t}, osHandle::Ptr{Cvoid}, shHandleType::hipMemAllocationHandleType)::hipError_t
end

function hipMemMap(ptr, size, offset, handle, flags)
    @ccall libhip.hipMemMap(ptr::Ptr{Cvoid}, size::Csize_t, offset::Csize_t, handle::hipMemGenericAllocationHandle_t, flags::Culonglong)::hipError_t
end

function hipMemMapArrayAsync(mapInfoList, count, stream)
    @ccall libhip.hipMemMapArrayAsync(mapInfoList::Ptr{hipArrayMapInfo}, count::Cuint, stream::hipStream_t)::hipError_t
end

function hipMemRelease(handle)
    @ccall libhip.hipMemRelease(handle::hipMemGenericAllocationHandle_t)::hipError_t
end

function hipMemRetainAllocationHandle(handle, addr)
    @ccall libhip.hipMemRetainAllocationHandle(handle::Ptr{hipMemGenericAllocationHandle_t}, addr::Ptr{Cvoid})::hipError_t
end

function hipMemSetAccess(ptr, size, desc, count)
    @ccall libhip.hipMemSetAccess(ptr::Ptr{Cvoid}, size::Csize_t, desc::Ptr{hipMemAccessDesc}, count::Csize_t)::hipError_t
end

function hipMemUnmap(ptr, size)
    @ccall libhip.hipMemUnmap(ptr::Ptr{Cvoid}, size::Csize_t)::hipError_t
end

function hipGraphicsMapResources(count, resources, stream)
    @ccall libhip.hipGraphicsMapResources(count::Cint, resources::Ptr{hipGraphicsResource_t}, stream::hipStream_t)::hipError_t
end

function hipGraphicsSubResourceGetMappedArray(array, resource, arrayIndex, mipLevel)
    @ccall libhip.hipGraphicsSubResourceGetMappedArray(array::Ptr{hipArray_t}, resource::hipGraphicsResource_t, arrayIndex::Cuint, mipLevel::Cuint)::hipError_t
end

function hipGraphicsResourceGetMappedPointer(devPtr, size, resource)
    @ccall libhip.hipGraphicsResourceGetMappedPointer(devPtr::Ptr{Ptr{Cvoid}}, size::Ptr{Csize_t}, resource::hipGraphicsResource_t)::hipError_t
end

function hipGraphicsUnmapResources(count, resources, stream)
    @ccall libhip.hipGraphicsUnmapResources(count::Cint, resources::Ptr{hipGraphicsResource_t}, stream::hipStream_t)::hipError_t
end

function hipGraphicsUnregisterResource(resource)
    @ccall libhip.hipGraphicsUnregisterResource(resource::hipGraphicsResource_t)::hipError_t
end

function hipCreateSurfaceObject(pSurfObject, pResDesc)
    @ccall libhip.hipCreateSurfaceObject(pSurfObject::Ptr{hipSurfaceObject_t}, pResDesc::Ptr{hipResourceDesc})::hipError_t
end

function hipDestroySurfaceObject(surfaceObject)
    @ccall libhip.hipDestroySurfaceObject(surfaceObject::hipSurfaceObject_t)::hipError_t
end

function hipMemcpy_spt(dst, src, sizeBytes, kind)
    @ccall libhip.hipMemcpy_spt(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyToSymbol_spt(symbol, src, sizeBytes, offset, kind)
    @ccall libhip.hipMemcpyToSymbol_spt(symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpyFromSymbol_spt(dst, symbol, sizeBytes, offset, kind)
    @ccall libhip.hipMemcpyFromSymbol_spt(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2D_spt(dst, dpitch, src, spitch, width, height, kind)
    @ccall libhip.hipMemcpy2D_spt(dst::Ptr{Cvoid}, dpitch::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DFromArray_spt(dst, dpitch, src, wOffset, hOffset, width, height, kind)
    @ccall libhip.hipMemcpy2DFromArray_spt(dst::Ptr{Cvoid}, dpitch::Csize_t, src::hipArray_const_t, wOffset::Csize_t, hOffset::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy3D_spt(p)
    @ccall libhip.hipMemcpy3D_spt(p::Ptr{hipMemcpy3DParms})::hipError_t
end

function hipMemset_spt(dst, value, sizeBytes)
    @ccall libhip.hipMemset_spt(dst::Ptr{Cvoid}, value::Cint, sizeBytes::Csize_t)::hipError_t
end

function hipMemsetAsync_spt(dst, value, sizeBytes, stream)
    @ccall libhip.hipMemsetAsync_spt(dst::Ptr{Cvoid}, value::Cint, sizeBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemset2D_spt(dst, pitch, value, width, height)
    @ccall libhip.hipMemset2D_spt(dst::Ptr{Cvoid}, pitch::Csize_t, value::Cint, width::Csize_t, height::Csize_t)::hipError_t
end

function hipMemset2DAsync_spt(dst, pitch, value, width, height, stream)
    @ccall libhip.hipMemset2DAsync_spt(dst::Ptr{Cvoid}, pitch::Csize_t, value::Cint, width::Csize_t, height::Csize_t, stream::hipStream_t)::hipError_t
end

function hipMemset3DAsync_spt(pitchedDevPtr, value, extent, stream)
    @ccall libhip.hipMemset3DAsync_spt(pitchedDevPtr::hipPitchedPtr, value::Cint, extent::hipExtent, stream::hipStream_t)::hipError_t
end

function hipMemset3D_spt(pitchedDevPtr, value, extent)
    @ccall libhip.hipMemset3D_spt(pitchedDevPtr::hipPitchedPtr, value::Cint, extent::hipExtent)::hipError_t
end

function hipMemcpyAsync_spt(dst, src, sizeBytes, kind, stream)
    @ccall libhip.hipMemcpyAsync_spt(dst::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpy3DAsync_spt(p, stream)
    @ccall libhip.hipMemcpy3DAsync_spt(p::Ptr{hipMemcpy3DParms}, stream::hipStream_t)::hipError_t
end

function hipMemcpy2DAsync_spt(dst, dpitch, src, spitch, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DAsync_spt(dst::Ptr{Cvoid}, dpitch::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyFromSymbolAsync_spt(dst, symbol, sizeBytes, offset, kind, stream)
    @ccall libhip.hipMemcpyFromSymbolAsync_spt(dst::Ptr{Cvoid}, symbol::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyToSymbolAsync_spt(symbol, src, sizeBytes, offset, kind, stream)
    @ccall libhip.hipMemcpyToSymbolAsync_spt(symbol::Ptr{Cvoid}, src::Ptr{Cvoid}, sizeBytes::Csize_t, offset::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpyFromArray_spt(dst, src, wOffsetSrc, hOffset, count, kind)
    @ccall libhip.hipMemcpyFromArray_spt(dst::Ptr{Cvoid}, src::hipArray_const_t, wOffsetSrc::Csize_t, hOffset::Csize_t, count::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DToArray_spt(dst, wOffset, hOffset, src, spitch, width, height, kind)
    @ccall libhip.hipMemcpy2DToArray_spt(dst::hipArray_t, wOffset::Csize_t, hOffset::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind)::hipError_t
end

function hipMemcpy2DFromArrayAsync_spt(dst, dpitch, src, wOffsetSrc, hOffsetSrc, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DFromArrayAsync_spt(dst::Ptr{Cvoid}, dpitch::Csize_t, src::hipArray_const_t, wOffsetSrc::Csize_t, hOffsetSrc::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipMemcpy2DToArrayAsync_spt(dst, wOffset, hOffset, src, spitch, width, height, kind, stream)
    @ccall libhip.hipMemcpy2DToArrayAsync_spt(dst::hipArray_t, wOffset::Csize_t, hOffset::Csize_t, src::Ptr{Cvoid}, spitch::Csize_t, width::Csize_t, height::Csize_t, kind::hipMemcpyKind, stream::hipStream_t)::hipError_t
end

function hipStreamQuery_spt(stream)
    @ccall libhip.hipStreamQuery_spt(stream::hipStream_t)::hipError_t
end

function hipStreamSynchronize_spt(stream)
    @ccall libhip.hipStreamSynchronize_spt(stream::hipStream_t)::hipError_t
end

function hipStreamGetPriority_spt(stream, priority)
    @ccall libhip.hipStreamGetPriority_spt(stream::hipStream_t, priority::Ptr{Cint})::hipError_t
end

function hipStreamWaitEvent_spt(stream, event, flags)
    @ccall libhip.hipStreamWaitEvent_spt(stream::hipStream_t, event::hipEvent_t, flags::Cuint)::hipError_t
end

function hipStreamGetFlags_spt(stream, flags)
    @ccall libhip.hipStreamGetFlags_spt(stream::hipStream_t, flags::Ptr{Cuint})::hipError_t
end

function hipStreamAddCallback_spt(stream, callback, userData, flags)
    @ccall libhip.hipStreamAddCallback_spt(stream::hipStream_t, callback::hipStreamCallback_t, userData::Ptr{Cvoid}, flags::Cuint)::hipError_t
end

function hipEventRecord_spt(event, stream)
    @ccall libhip.hipEventRecord_spt(event::hipEvent_t, stream::hipStream_t)::hipError_t
end

function hipLaunchCooperativeKernel_spt(f, gridDim, blockDim, kernelParams, sharedMemBytes, hStream)
    @ccall libhip.hipLaunchCooperativeKernel_spt(f::Ptr{Cvoid}, gridDim::dim3, blockDim::dim3, kernelParams::Ptr{Ptr{Cvoid}}, sharedMemBytes::UInt32, hStream::hipStream_t)::hipError_t
end

function hipLaunchKernel_spt(function_address, numBlocks, dimBlocks, args, sharedMemBytes, stream)
    @ccall libhip.hipLaunchKernel_spt(function_address::Ptr{Cvoid}, numBlocks::dim3, dimBlocks::dim3, args::Ptr{Ptr{Cvoid}}, sharedMemBytes::Csize_t, stream::hipStream_t)::hipError_t
end

function hipGraphLaunch_spt(graphExec, stream)
    @ccall libhip.hipGraphLaunch_spt(graphExec::hipGraphExec_t, stream::hipStream_t)::hipError_t
end

function hipStreamBeginCapture_spt(stream, mode)
    @ccall libhip.hipStreamBeginCapture_spt(stream::hipStream_t, mode::hipStreamCaptureMode)::hipError_t
end

function hipStreamEndCapture_spt(stream, pGraph)
    @ccall libhip.hipStreamEndCapture_spt(stream::hipStream_t, pGraph::Ptr{hipGraph_t})::hipError_t
end

function hipStreamIsCapturing_spt(stream, pCaptureStatus)
    @ccall libhip.hipStreamIsCapturing_spt(stream::hipStream_t, pCaptureStatus::Ptr{hipStreamCaptureStatus})::hipError_t
end

function hipStreamGetCaptureInfo_spt(stream, pCaptureStatus, pId)
    @ccall libhip.hipStreamGetCaptureInfo_spt(stream::hipStream_t, pCaptureStatus::Ptr{hipStreamCaptureStatus}, pId::Ptr{Culonglong})::hipError_t
end

function hipStreamGetCaptureInfo_v2_spt(stream, captureStatus_out, id_out, graph_out, dependencies_out, numDependencies_out)
    @ccall libhip.hipStreamGetCaptureInfo_v2_spt(stream::hipStream_t, captureStatus_out::Ptr{hipStreamCaptureStatus}, id_out::Ptr{Culonglong}, graph_out::Ptr{hipGraph_t}, dependencies_out::Ptr{Ptr{hipGraphNode_t}}, numDependencies_out::Ptr{Csize_t})::hipError_t
end

function hipLaunchHostFunc_spt(stream, fn, userData)
    @ccall libhip.hipLaunchHostFunc_spt(stream::hipStream_t, fn::hipHostFn_t, userData::Ptr{Cvoid})::hipError_t
end

struct var"##Ctag#278"
    array::hipArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#278"}, f::Symbol)
    f === :array && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#278", f::Symbol)
    r = Ref{var"##Ctag#278"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#278"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#278"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#279"
    mipmap::hipMipmappedArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#279"}, f::Symbol)
    f === :mipmap && return Ptr{hipMipmappedArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#279", f::Symbol)
    r = Ref{var"##Ctag#279"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#279"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#279"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#280"
    devPtr::Ptr{Cvoid}
    desc::hipChannelFormatDesc
    sizeInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#280"}, f::Symbol)
    f === :devPtr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :desc && return Ptr{hipChannelFormatDesc}(x + 8)
    f === :sizeInBytes && return Ptr{Csize_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#280", f::Symbol)
    r = Ref{var"##Ctag#280"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#280"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#280"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#281"
    devPtr::Ptr{Cvoid}
    desc::hipChannelFormatDesc
    width::Csize_t
    height::Csize_t
    pitchInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#281"}, f::Symbol)
    f === :devPtr && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :desc && return Ptr{hipChannelFormatDesc}(x + 8)
    f === :width && return Ptr{Csize_t}(x + 32)
    f === :height && return Ptr{Csize_t}(x + 40)
    f === :pitchInBytes && return Ptr{Csize_t}(x + 48)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#281", f::Symbol)
    r = Ref{var"##Ctag#281"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#281"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#281"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#283"
    handle::Ptr{Cvoid}
    name::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{var"##Ctag#283"}, f::Symbol)
    f === :handle && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :name && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#283", f::Symbol)
    r = Ref{var"##Ctag#283"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#283"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#283"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#286"
    level::Cuint
    layer::Cuint
    offsetX::Cuint
    offsetY::Cuint
    offsetZ::Cuint
    extentWidth::Cuint
    extentHeight::Cuint
    extentDepth::Cuint
end
function Base.getproperty(x::Ptr{var"##Ctag#286"}, f::Symbol)
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

function Base.getproperty(x::var"##Ctag#286", f::Symbol)
    r = Ref{var"##Ctag#286"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#286"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#286"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#287"
    layer::Cuint
    offset::Culonglong
    size::Culonglong
end
function Base.getproperty(x::Ptr{var"##Ctag#287"}, f::Symbol)
    f === :layer && return Ptr{Cuint}(x + 0)
    f === :offset && return Ptr{Culonglong}(x + 8)
    f === :size && return Ptr{Culonglong}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#287", f::Symbol)
    r = Ref{var"##Ctag#287"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#287"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#287"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#294"
    hArray::hipArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#294"}, f::Symbol)
    f === :hArray && return Ptr{hipArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#294", f::Symbol)
    r = Ref{var"##Ctag#294"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#294"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#294"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#295"
    hMipmappedArray::hipMipmappedArray_t
end
function Base.getproperty(x::Ptr{var"##Ctag#295"}, f::Symbol)
    f === :hMipmappedArray && return Ptr{hipMipmappedArray_t}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#295", f::Symbol)
    r = Ref{var"##Ctag#295"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#295"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#295"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#296"
    devPtr::hipDeviceptr_t
    format::hipArray_Format
    numChannels::Cuint
    sizeInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#296"}, f::Symbol)
    f === :devPtr && return Ptr{hipDeviceptr_t}(x + 0)
    f === :format && return Ptr{hipArray_Format}(x + 8)
    f === :numChannels && return Ptr{Cuint}(x + 12)
    f === :sizeInBytes && return Ptr{Csize_t}(x + 16)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#296", f::Symbol)
    r = Ref{var"##Ctag#296"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#296"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#296"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#297"
    devPtr::hipDeviceptr_t
    format::hipArray_Format
    numChannels::Cuint
    width::Csize_t
    height::Csize_t
    pitchInBytes::Csize_t
end
function Base.getproperty(x::Ptr{var"##Ctag#297"}, f::Symbol)
    f === :devPtr && return Ptr{hipDeviceptr_t}(x + 0)
    f === :format && return Ptr{hipArray_Format}(x + 8)
    f === :numChannels && return Ptr{Cuint}(x + 12)
    f === :width && return Ptr{Csize_t}(x + 16)
    f === :height && return Ptr{Csize_t}(x + 24)
    f === :pitchInBytes && return Ptr{Csize_t}(x + 32)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#297", f::Symbol)
    r = Ref{var"##Ctag#297"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#297"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#297"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#298"
    reserved::NTuple{32, Cint}
end
function Base.getproperty(x::Ptr{var"##Ctag#298"}, f::Symbol)
    f === :reserved && return Ptr{NTuple{32, Cint}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#298", f::Symbol)
    r = Ref{var"##Ctag#298"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#298"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#298"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct var"##Ctag#304"
    handle::Ptr{Cvoid}
    name::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{var"##Ctag#304"}, f::Symbol)
    f === :handle && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :name && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#304", f::Symbol)
    r = Ref{var"##Ctag#304"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#304"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#304"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const HIP_VERSION_MAJOR = 6

const HIP_VERSION_MINOR = 0

const HIP_VERSION_PATCH = 32831

const HIP_VERSION_GITHASH = "204d35d16"

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

const hipGetDeviceProperties = hipGetDevicePropertiesR0600

const hipDeviceProp_t = hipDeviceProp_tR0600

const hipChooseDevice = hipChooseDeviceR0600

const GENERIC_GRID_LAUNCH = 1

# Skipping MacroDefinition: __forceinline__ inline

const HIP_TRSA_OVERRIDE_FORMAT = 0x01

const HIP_TRSF_READ_AS_INTEGER = 0x01

const HIP_TRSF_NORMALIZED_COORDINATES = 0x02

const HIP_TRSF_SRGB = 0x10

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

const HIP_TEXTURE_OBJECT_SIZE_DWORD = HIP_IMAGE_OBJECT_SIZE_DWORD + HIP_SAMPLER_OBJECT_SIZE_DWORD

const DEPRECATED_MSG = "This API is marked as deprecated and may not be supported in future releases. For more details please refer https://github.com/ROCm-Developer-Tools/HIP/blob/master/docs/markdown/hip_deprecated_api_list.md"

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

const hipEventDisableSystemFence = 0x20000000

const hipEventReleaseToDevice = 0x40000000

const hipEventReleaseToSystem = 0x80000000

const hipHostMallocDefault = 0x00

const hipHostMallocPortable = 0x01

const hipHostMallocMapped = 0x02

const hipHostMallocWriteCombined = 0x04

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

const hipHostRegisterDefault = 0x00

const hipHostRegisterPortable = 0x01

const hipHostRegisterMapped = 0x02

const hipHostRegisterIoMemory = 0x04

const hipHostRegisterReadOnly = 0x08

const hipExtHostRegisterCoarseGrained = 0x08

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

const hipCpuDeviceId = Cint - 1

const hipInvalidDeviceId = Cint - 2

const hipExtAnyOrderLaunch = 0x01

const hipStreamWaitValueGte = 0x00

const hipStreamWaitValueEq = 0x01

const hipStreamWaitValueAnd = 0x02

const hipStreamWaitValueNor = 0x03

const hipStreamPerThread = hipStream_t(2)

const hipExternalMemoryDedicated = 0x01

const USE_PEER_NON_UNIFIED = 1

