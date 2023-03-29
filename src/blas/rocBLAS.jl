module rocBLAS

using ..AMDGPU
import AMDGPU: wait!, mark!, librocblas, AnyROCArray

using LinearAlgebra
using CEnum

include("librocblas.jl")
include("error.jl")
include("wrappers.jl")
include("highlevel.jl")

function rocblas_create_handle()
    handle = Ref{rocblas_handle}()
    rocblas_create_handle(handle) |> check
    handle[]
end

const _handle = Ref{rocblas_handle}(C_NULL)
function handle()
    if _handle[] == C_NULL
        handle = rocblas_create_handle()
        atexit(()->rocblas_destroy_handle(handle))
        _handle[] = handle
    end
    return _handle[]
end

function rocblas_get_version_string()
    vec = zeros(UInt8, 64)
    str = reinterpret(Cstring, pointer(vec))
    rocblas_get_version_string(vec, 64) |> check
    return unsafe_string(str)
end

function version()
    VersionNumber(join(split(rocblas_get_version_string(), '.')[1:3], '.'))
end

function stream(handle::rocblas_handle)
    stream_ref = Ref{hipStream_t}()
    rocblas_get_stream(handle, stream_ref) |> check
    stream_ref[]
end

end
