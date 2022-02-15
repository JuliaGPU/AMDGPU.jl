module rocBLAS

using ..AMDGPU
import AMDGPU: wait!, mark!, librocblas

using LinearAlgebra

include("librocblas_types.jl")
include("error.jl")

const _handle = Ref{rocblas_handle}(C_NULL)
function handle()
    if _handle[] == C_NULL
        handle = rocblas_create_handle()
        atexit(()->rocblas_destroy_handle(handle))
        _handle[] = handle
    end
    return _handle[]
end

include("librocblas.jl")
#include("util.jl")
include("wrappers.jl")
include("highlevel.jl")

function version()
    VersionNumber(join(split(rocblas_get_version_string(), '.')[1:3], '.'))
end

end
