module MIOpen

using ..AMDGPU
import AMDGPU.Runtime.Mem
import AMDGPU: ROCArray, ROCDevice, LockedObject
import AMDGPU: HandleCache, HIP, library_state
import .HIP: hipStream_t

using CEnum
using GPUArrays

if AMDGPU.use_artifacts && AMDGPU.functional(:MIOpen)
    using MIOpen_jll
    const libMIOpen_path = MIOpen_jll.libMIOpen_path
else
    const libMIOpen_path = AMDGPU.libMIOpen
end

include("low_level.jl")

const STATUS_DESCRIPTORS = Dict(
    miopenStatusSuccess => "Success",
    miopenStatusNotInitialized => "Not initialized",
    miopenStatusInvalidValue => "Invalid value",
    miopenStatusBadParm => "Bad parameter",
    miopenStatusAllocFailed => "Allocation failed",
    miopenStatusInternalError => "Internal error",
    miopenStatusNotImplemented => "Not implemented",
    miopenStatusUnknownError => "Unknown error",
    miopenStatusUnsupportedOp => "Unsupported operation",
    miopenStatusGpuOperationsSkipped => "GPU operations skipped")

const DATA_TYPES = Dict(
    Float16 => miopenHalf,
    Float32 => miopenFloat,
    Float64 => miopenDouble,
    Int8 => miopenInt8,
    Int32 => miopenInt32)

# MIOPEN supports only these types.
const MIOPENFloat = Union{Float16, Float32}

function status_string(status)
    s = get(STATUS_DESCRIPTORS, status, nothing)
    isnothing(s) ? "Unknown error code `$status`" : s
end

struct MIOpenException <: Exception
    status::miopenStatus_t
end

function Base.showerror(io::IO, exception::MIOpenException)
    print(io, """
    MIOpenException:
    - status: $(exception.status)
    - description: $(status_string(exception.status))
    """)
end

function check(status)
    if status != miopenStatusSuccess
        throw(MIOpenException(status))
    end
end

miopen_data_type(t) = DATA_TYPES[t]

function version()
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

const IDLE_HANDLES = HandleCache{HIPContext, miopenHandle_t}()

lib_state() = library_state(
    :MIOpen, miopenHandle_t, IDLE_HANDLES,
    create_handle, destroy_handle!,
    (nh, s) -> check(miopenSetStream(nh, s)))

handle() = lib_state().handle
stream() = lib_state().stream

# TODO use ROCArray instead of Workspace
mutable struct Workspace
    data::Mem.HIPBuffer
    function Workspace(dev::ROCDevice, bytesize)
        data, _ = Mem.HIPBuffer(bytesize; stream=AMDGPU.stream())
        w = new(data)
        finalizer(w_ -> Mem.free(w_.data; stream=AMDGPU.stream()), w)
        w
    end
end

include("descriptors.jl")
include("convolution.jl")
include("pooling.jl")
include("softmax.jl")
include("activations.jl")
include("batchnorm.jl")

end
