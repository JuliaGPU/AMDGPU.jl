module MIOpen

using ..AMDGPU
import AMDGPU.Runtime.Mem
import AMDGPU: ROCArray, ROCDevice, LockedObject
import AMDGPU: HandleCache, HIP
import .HIP: HIPContext, HIPStream, hipContext_t, hipStream_t, hipEvent_t

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

function library_state()
    tls = AMDGPU.task_local_state()

    LibraryState = @NamedTuple{handle::miopenHandle_t, stream::HIPStream}
    states = get!(task_local_storage(), :MIOpen) do
        Dict{HIPContext, LibraryState}()
    end::Dict{HIPContext, LibraryState}

    @noinline function new_state(tls)
        new_handle = pop!(() -> create_handle(), IDLE_HANDLES, tls.context)

        finalizer(current_task()) do task
            push!(IDLE_HANDLES, tls.context, new_handle) do
                context!(tls.context) do
                    destroy_handle!(new_handle)
                end
            end
        end
        miopenSetStream(new_handle, tls.stream) |> check

        (; handle=new_handle, tls.stream)
    end
    state = get!(() -> new_state(tls), states, tls.context)

    @noinline function update_stream(tls, state)
        miopenSetStream(state.handle, tls.stream)
    end
    if state.stream != tls.stream
        states[tls.context] = state = update_stream(tls, state)
    end

    return state
end

handle() = library_state().handle
stream() = library_state().stream

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

end
