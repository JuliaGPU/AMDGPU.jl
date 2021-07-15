module rocSPARSE

using ..AMDGPU
import AMDGPU: wait!, mark!

using LinearAlgebra

include("librocsparse_types.jl")
# include("error.jl")

const _handle = Ref{rocsparse_handle}(C_NULL)
function handle()
    if _handle[] == C_NULL
        handle = rocsparse_create_handle()
        atexit(()->rocsparse_destroy_handle(handle))
        _handle[] = handle
    end
    return _handle[]
end

include("librocsparse.jl")
#include("util.jl")
# include("wrappers.jl")
# include("highlevel.jl")

function version()
    version = rocsparse_get_version(handle())
    patch = version % 100
    minor = div(version, 100) % 1000
    major = div(version, 100000)
    VersionNumber(string(major, ".", minor, ".", patch))
end

end
