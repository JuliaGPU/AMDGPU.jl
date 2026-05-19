module rocSPARSE

using Adapt: Adapt, adapt
using Base.Broadcast: Broadcasted
using CEnum: @cenum
using LinearAlgebra
using LinearAlgebra: HermOrSym, BlasComplex, BlasFloat, BlasReal, MulAddMul, AdjOrTrans
using SparseArrays
using SparseArrays: nonzeroinds, nonzeros, rowvals, getcolptr, dimlub
using GPUArrays
using ..AMDGPU
using ..AMDGPU: @allowscalar
using ..AMDGPU: ROCArrayStyle, threadIdx, blockIdx, blockDim

import SparseArrays: SparseVector, SparseMatrixCSC
import AMDGPU: librocsparse, HandleCache, HIP, library_state, ROCVector
import AMDGPU.Device: ROCDeviceVector
import .HIP: HIPContext, HIPStream, hipStream_t

const SparseChar = Char

# core library
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

function version()
    ver = Ref{Cint}()
    rocsparse_get_version(handle(), ver)
    major = ver[] ÷ 100000
    minor = (ver[] ÷ 100) % 1000
    patch = ver[] % 100
    return VersionNumber(major, minor, patch)
end

include("array.jl")
include("util.jl")
include("types.jl")

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
