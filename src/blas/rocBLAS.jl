module rocBLAS

using ..AMDGPU
import AMDGPU: librocblas, AnyROCArray
import AMDGPU: HandleCache, HIP, library_state
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

function create_handle()
    handle_ref = Ref{rocblas_handle}()
    @check rocblas_create_handle(handle_ref)
    handle_ref[]
end

function destroy_handle!(handle)
    @check rocblas_destroy_handle(handle)
end

# cache for created, but unused handles
const IDLE_HANDLES = HandleCache{HIPContext, rocblas_handle}()

lib_state() = library_state(
    :rocBLAS, rocblas_handle, IDLE_HANDLES,
    create_handle, destroy_handle!,
    (nh, s) -> check(rocblas_set_stream(nh, s)))

handle() = lib_state().handle
stream() = lib_state().stream

if AMDGPU.functional(:rocblas)
    @eval rocblas_check_functional() = nothing
else
    @eval rocblas_check_functional() =
        throw(ArgumentError("rocBLAS is not functional"))
end

end
