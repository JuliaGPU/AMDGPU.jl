module rocSPARSE

using Adapt: Adapt, adapt
using Base.Broadcast: Broadcasted
using CEnum: @cenum
using LinearAlgebra
using LinearAlgebra: HermOrSym, BlasComplex, BlasFloat, BlasReal
using SparseArrays
using SparseArrays: nonzeroinds, dimlub

using ..AMDGPU
using ..AMDGPU: @allowscalar
using ..AMDGPU: ROCArrayStyle, threadIdx, blockIdx, blockDim

import AMDGPU: librocsparse, HandleCache, HIP, library_state
import AMDGPU.Device: ROCDeviceVector
import .HIP: HIPContext, HIPStream, hipStream_t

const SparseChar = Char

# core library
include("librocsparse_common.jl")
include("error.jl")
include("librocsparse.jl")
include("librocsparse_deprecated.jl")

function create_handle()
    AMDGPU.functional(:rocsparse) || error("rocSPARSE is not available")

    handle_ref = Ref{rocsparse_handle}()
    rocsparse_create_handle(handle_ref)
    handle_ref[]
end

const IDLE_HANDLES = HandleCache{HIPContext, rocsparse_handle}()

lib_state() = library_state(
    :rocSPARSE, rocsparse_handle, IDLE_HANDLES,
    create_handle, rocsparse_destroy_handle, rocsparse_set_stream)

handle() = lib_state().handle
stream() = lib_state().stream

include("array.jl")
include("util.jl")
include("types.jl")

# native functionality
include("device.jl")
include("broadcast.jl")

# low-level wrappers
include("helpers.jl")
include("level1.jl")
include("level2.jl")
include("level3.jl")
include("extra.jl")
include("preconditioners.jl")
include("conversions.jl")
include("generic.jl")

# high-level integrations
include("interfaces.jl")
include("linalg.jl")

end
