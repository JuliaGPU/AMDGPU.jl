module rocBLAS

using ..AMDGPU
import AMDGPU: wait!, mark!, librocblas, AnyROCArray
import AMDGPU: HandleCache
import AMDGPU.HIP: HIPContext, HIPStream

using LinearAlgebra

include("librocblas_types.jl")
include("error.jl")
include("librocblas.jl")
include("wrappers.jl")
include("highlevel.jl")

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
            rocblas_create_handle()
        end

        finalizer(current_task()) do task
            push!(idle_handles, tls.context, new_handle) do
                context!(tls.context) do
                    rocblas_destroy_handle(new_handle)
                end
            end
        end

        rocblas_set_stream(new_handle, tls.stream)

        (; handle=new_handle, tls.stream)
    end
    state = get!(states, tls.context) do
        new_state(tls)
    end

    # update stream
    @noinline function update_stream(tls, state)
        rocblas_set_stream(state.handle, tls.stream)
        (; state.handle, stream=tls.stream)
    end
    if state.stream != tls.stream
        states[tls.context] = state = update_stream(tls, state)
    end

    return state.handle
end

if AMDGPU.functional(:rocblas)
    @eval rocblas_check_functional() = nothing
else
    @eval rocblas_check_functional() =
        throw(ArgumentError("rocBLAS is not functional"))
end

end
