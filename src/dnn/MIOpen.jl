module MIOpen

import AMDGPU
import AMDGPU.Runtime.Mem

using AMDGPU: ROCArray, ROCDevice
using CEnum
using GPUArrays
using MIOpen_jll

const libMIOpen_path = MIOpen_jll.libMIOpen_path

include("low_level.jl")

const HANDLE = Ref{miopenHandle_t}(C_NULL)

function get_status_string(status)
    if     status == miopenStatusSuccess return "Success"
    elseif status == miopenStatusNotInitialized return "Not initialized"
    elseif status == miopenStatusInvalidValue return "Invalid value"
    elseif status == miopenStatusBadParm return "Bad parameter"
    elseif status == miopenStatusAllocFailed return "Allocation failed"
    elseif status == miopenStatusInternalError return "Internal error"
    elseif status == miopenStatusNotImplemented return "Not implemented"
    elseif status == miopenStatusUnknownError return "Unknown error"
    elseif status == miopenStatusUnsupportedOp return "Unsupported operation"
    elseif status == miopenStatusGpuOperationsSkipped return "GPU operations skipped" end
    error("Invalid status code: $status")
end

function check(status)
    if status != miopenStatusSuccess
        status_string = get_status_string(status)
        error("MIOpen return status [code=$status]: $status_string")
    end
end

function get_miopen_data_type(t)
    if     t == Float16 return miopenHalf
    elseif t == Float32 return miopenFloat
    elseif t == Float64 return miopenDouble
    elseif t == Int8    return miopenInt8
    elseif t == Int32   return miopenInt32 end
    error("Unsupported data type: $t")
end

function get_version()
    major, minor, patch = Ref{Csize_t}(0), Ref{Csize_t}(0), Ref{Csize_t}(0)
    miopenGetVersion(major, minor, patch) |> check
    VersionNumber(major[], minor[], patch[])
end

function create_handle()::miopenHandle_t
    handle = Ref{miopenHandle_t}()
    miopenCreate(handle) |> check
    handle[]
end

function destroy_handle!(handle::miopenHandle_t)
    miopenDestroy(handle) |> check
    nothing
end

function get_handle()
    global HANDLE
    if HANDLE[] == C_NULL
        handle = create_handle()
        atexit(() -> destroy_handle!(handle))
        HANDLE[] = handle
    end
    HANDLE[]
end

include("descriptors.jl")
include("convolution.jl")

end
