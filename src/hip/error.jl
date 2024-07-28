struct HIPError <: Exception
    code::hipError_t
    msg::AbstractString
end
Base.show(io::IO, err::HIPError) = print(io, "HIPError(code $(err.code), $(err.msg))")

function HIPError(code::hipError_t)
    msg = status_message(code)
    return HIPError(code, msg)
end

function status_message(status)
    if status == hipSuccess
        return "the operation completed successfully"
    elseif status == hipErrorOutOfMemory
        return "out of memory"
    elseif status == hipErrorNotInitialized
        return "not initialized"
    elseif status == hipErrorDeinitialized
        return "already deinitialized"
    elseif status == hipErrorProfilerDisabled
        return "profiler disabled"
    elseif status == hipErrorProfilerNotInitialized
        return "profiler not initialized"
    elseif status == hipErrorProfilerAlreadyStarted
        return "profiler already started"
    elseif status == hipErrorProfilerAlreadyStopped
        return "profiler already stopped"
    elseif status == hipErrorInsufficientDriver
        return "insufficient driver"
    elseif status == hipErrorInvalidImage
        return "invalid image"
    elseif status == hipErrorInvalidContext
        return "invalid context"
    elseif status == hipErrorContextAlreadyCurrent
        return "context is already current"
    elseif status == hipErrorMapFailed
        return "map failed"
    elseif status == hipErrorUnmapFailed
        return "unmap failed"
    elseif status == hipErrorArrayIsMapped
        return "array is already mapped"
    elseif status == hipErrorAlreadyMapped
        return "already mapped"
    elseif status == hipErrorNoBinaryForGpu
        return "no binary for GPU"
    elseif status == hipErrorAlreadyAcquired
        return "already acquired"
    elseif status == hipErrorNotMapped
        return "not mapped"
    elseif status == hipErrorNotMappedAsArray
        return "not mapped as array"
    elseif status == hipErrorNotMappedAsPointer
        return "not mapped as pointer"
    elseif status == hipErrorECCNotCorrectable
        return "ECC is not correctable"
    elseif status == hipErrorUnsupportedLimit
        return "unsupported limit"
    elseif status == hipErrorContextAlreadyInUse
        return "context is already in use"
    elseif status == hipErrorPeerAccessUnsupported
        return "peer access not supported"
    elseif status == hipErrorInvalidKernelFile # in CUDA CUDA_ERROR_INVALID_PTX
        return "invalid kernel file"
    elseif status == hipErrorInvalidGraphicsContext
        return "invalid graphics context"
    elseif status == hipErrorInvalidSource
        return "invalid source"
    elseif status == hipErrorFileNotFound
        return "file not found"
    elseif status == hipErrorSharedObjectSymbolNotFound
        return "shared object symbol not found"
    elseif status == hipErrorSharedObjectInitFailed
        return "shared object initialization failed"
    elseif status == hipErrorOperatingSystem
        return "operating system"
    elseif status == hipErrorSetOnActiveProcess
        return "set on active process"
    elseif status == hipErrorInvalidHandle
        return "invalid handle"
    elseif status == hipErrorNotFound
        return "not found"
    elseif status == hipErrorIllegalAddress
        return "illegal address"
    elseif status == hipErrorInvalidSymbol
        return "invalid symbol"
    # runtime errors:
    elseif status == hipErrorMissingConfiguration
        return "missing configuration"
    elseif status == hipErrorMemoryAllocation
        return "error allocating memory"
    elseif status == hipErrorInitializationError
        return "initialization error"
    elseif status == hipErrorLaunchFailure
        return "an exception occurred on the device while executing a kernel"
    elseif status == hipErrorPriorLaunchFailure
        return "failure before launch"
    elseif status == hipErrorLaunchTimeOut
        return "launch timed out"
    elseif status == hipErrorLaunchOutOfResources
        return "out of resources for launch"
    elseif status == hipErrorInvalidDeviceFunction
        return "invalid device function"
    elseif status == hipErrorInvalidConfiguration
        return "invalid configuration"
    elseif status == hipErrorInvalidDevice
        return "DeviceID must be in range 0...#compute-devices"
    elseif status == hipErrorInvalidValue
        return "one or more arguments outside of acceptable range"
    elseif status == hipErrorInvalidDevicePointer
        return "invalid device pointer"
    elseif status == hipErrorInvalidMemcpyDirection
        return "invalid memory copy direction"
    elseif status == hipErrorInvalidResourceHandle
        return "resource handle (hipEvent_t or hipStream_t) invalid"
    elseif status == hipErrorNotReady # not actually an error
        return "asynchronous operations not completed"
    elseif status == hipErrorNoDevice
        return "no device found"
    elseif status == hipErrorPeerAccessAlreadyEnabled
        return "peer access was already enabled from the current device"
    elseif status == hipErrorPeerAccessNotEnabled
        return "peer access was never enabled from the current device"
    elseif status == hipErrorRuntimeMemory
        return "HSA runtime memory call returned error"
    elseif status == hipErrorRuntimeOther
        return "HSA runtime error"
    elseif status == hipErrorHostMemoryAlreadyRegistered
        return "tried to lock a page-lockded memory"
    elseif status == hipErrorHostMemoryNotRegistered
        return "tried to unlock a non-page-locked memory"
    elseif status == hipErrorMapBufferObjectFailed
        return "IPC memory attach failed from ROCr"
    elseif status == hipErrorAssert
        return "kernel calls produced assert"
    elseif status == hipErrorNotSupported
        return "hip API is not supported/implemented"
    else
        return "unknown error ($(UInt32(status)))"
    end
end

function check(err::hipError_t)
    if err != hipSuccess && err != hipErrorNotReady
        throw(HIPError(err))
    end
end
