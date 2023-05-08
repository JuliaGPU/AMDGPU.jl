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
