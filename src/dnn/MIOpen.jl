module MIOpen

import AMDGPU
import AMDGPU.Runtime.Mem
import AMDGPU: ROCArray, ROCDevice, LockedObject

using CEnum
using GPUArrays

@static if AMDGPU.use_artifacts
    using MIOpen_jll
    const libMIOpen_path = MIOpen_jll.libMIOpen_path
else
    const libMIOpen_path = AMDGPU.libMIOpen
end


include("low_level.jl")

const HANDLE = LockedObject(Ref{miopenHandle_t}(C_NULL))

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

function handle()
    lock(HANDLE) do hdl
        if hdl[] == C_NULL
            new_handle = create_handle()
            atexit(() -> destroy_handle!(new_handle))
            hdl[] = new_handle
        end
        hdl[]
    end
end

mutable struct Workspace
    data::Mem.Buffer
    function Workspace(dev::ROCDevice, bytesize)
        w = new(Mem.alloc(dev, bytesize))
        finalizer(w_ -> Mem.free(w_.data), w)
        w
    end
end

include("descriptors.jl")
include("convolution.jl")
include("pooling.jl")
include("softmax.jl")
include("activations.jl")
include("batchnorm.jl")

function main()
    n_features = 3
    x = AMDGPU.rand(Float32, 4, 4, n_features, 2);
    γ = AMDGPU.ones(Float32, n_features)
    β = AMDGPU.zeros(Float32, n_features)
    μ = AMDGPU.zeros(Float32, n_features)
    ν = AMDGPU.ones(Float32, n_features)

    y, μ_saved, ν_saved = batchnorm_training(
        x, γ, β, μ, ν; n_features, iteration=1)

    display(y); println()
    display(γ); println()
    display(β); println()
    display(μ); println()
    display(ν); println()
    nothing
end

end
