module rocSparse

# using ..APIUtils

using ..AMDGPU
using ..AMDGPU: librocsparse
# using ..AMDGPU: CUstream
# using ..AMDGPU: unsafe_free!, @retry_reclaim, initialize_context, i32, @allowscalar
using ..AMDGPU: @allowscalar

using CEnum: @cenum

using LinearAlgebra
using LinearAlgebra: HermOrSym

using Adapt: Adapt, adapt

using SparseArrays

const SparseChar = Char


# core library
include("librocsparse_common.jl")
include("error.jl")
include("librocsparse.jl")

const _handle = Ref{rocsparse_handle}(C_NULL)
function handle()
    if _handle[] == C_NULL
        rocsparse_create_handle(_handle)
        atexit(()->rocsparse_destroy_handle(_handle[]))
    end
    return _handle[]
end



include("array.jl")
include("util.jl")
include("types.jl")
include("linalg.jl")

# low-level wrappers
include("helpers.jl")
include("management.jl")
include("level1.jl")
include("level2.jl")
include("level3.jl")
include("extra.jl")
include("preconditioners.jl")
include("conversions.jl")
include("generic.jl")

# high-level integrations
include("interfaces.jl")

# native functionality
include("device.jl")
include("broadcast.jl")

end
