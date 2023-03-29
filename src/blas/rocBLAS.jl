module rocBLAS

using ..AMDGPU
import AMDGPU: wait!, mark!, librocblas, AnyROCArray
import AMDGPU: HandleCache
import AMDGPU: HIP
import .HIP: HIPContext, HIPStream, hipContext_t, hipStream_t, hipEvent_t

using LinearAlgebra
using CEnum

include("librocblas.jl")
include("error.jl")
include("wrappers.jl")
include("highlevel.jl")

function rocblas_get_version_string()
    vec = zeros(UInt8, 64)
    str = reinterpret(Cstring, pointer(vec))
    rocblas_get_version_string(vec, 64) |> check
    return unsafe_string(str)
end

function version()
    VersionNumber(join(split(rocblas_get_version_string(), '.')[1:3], '.'))
end

# Copied from CUDA.jl/lib/cublas/CUBLAS.jl

# cache for created, but unused handles
const idle_handles = HandleCache{HIPContext, rocblas_handle}()

function handle()
    rocblas_check_functional()

    tls = AMDGPU.task_local_state()

    # every task maintains library state per device
    LibraryState = @NamedTuple{handle::rocblas_handle, stream::HIPStream}
    states = get!(task_local_storage(), :rocBLAS) do
        Dict{HIPContext,LibraryState}()
    end::Dict{HIPContext,LibraryState}

    # get library state
    @noinline function new_state(tls)
        new_handle = pop!(idle_handles, tls.context) do
            handle_ref = Ref{rocblas_handle}()
            @check rocblas_create_handle(handle_ref)
            handle_ref[]
        end

        finalizer(current_task()) do task
            push!(idle_handles, tls.context, new_handle) do
                context!(tls.context) do
                    @check rocblas_destroy_handle(new_handle)
                end
            end
        end

        @check rocblas_set_stream(new_handle, tls.stream)

        (; handle=new_handle, tls.stream)
    end
    state = get!(states, tls.context) do
        new_state(tls)
    end

    # update stream
    @noinline function update_stream(tls, state)
        @check rocblas_set_stream(state.handle, tls.stream)
        (; state.handle, stream=tls.stream)
    end
    if state.stream != tls.stream
        states[tls.context] = state = update_stream(tls, state)
    end

    return state.handle
end

function stream(handle::rocblas_handle)
    stream_ref = Ref{hipStream_t}()
    rocblas_get_stream(handle, stream_ref)
    return HIPStream(stream_ref[])
end

if AMDGPU.functional(:rocblas)
    @eval rocblas_check_functional() = nothing
else
    @eval rocblas_check_functional() =
        throw(ArgumentError("rocBLAS is not functional"))
end

end
