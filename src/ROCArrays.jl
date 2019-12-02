module ROCArrays

using AMDGPUnative
import AMDGPUnative: AS
import HSARuntime
import HSARuntime: HSAAgent, Mem, get_region

using GPUArrays

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc, roczeros, rocones, rocfill

import LinearAlgebra

using Adapt

## initialization

const ext = joinpath(dirname(@__DIR__), "deps", "ext.jl")
isfile(ext) || error("ROCArrays.jl has not been built, please run Pkg.build(\"ROCArrays\").")
include(ext)
if !configured
    # default (non-functional) values for critical variables,
    # making it possible to _load_ the package at all times.
    const librocblas = nothing
    const librocsparse = nothing
    const librocalution = nothing
    const librocfft = nothing
    const librocrand = nothing
    const libmiopen = nothing
end

#include("memory.jl")
include("array.jl")
#include("subarray.jl")
#include("utils.jl")
#include("indexing.jl")
#include("broadcast.jl")
#include("matmul.jl")
#include("mapreduce.jl")
include("flux.jl") # FIXME: Remove me

#include("gpuarray_interface.jl")

# many libraries need to be initialized per-device (per-context, really, but
# we assume users of ROCArrays and/or AMDGPUnative only use a single context),
# so keep track of the active one.
#const active_context = Ref{ROCContext}()

# TODO: add check
include("hip/HIP.jl")
librocblas !== nothing    && include("blas/rocBLAS.jl")
#librocsparse !== nothing  && include("sparse/rocSPARSE.jl")
#librocalution !== nothing && include("solver/rocALUTION.jl")
librocfft !== nothing     && include("fft/rocFFT.jl")
#librocrand !== nothing    && include("rand/rocRAND.jl")
#libmiopen !== nothing     && include("dnn/MIOpen.jl")

#include("nnlib.jl")

#include("deprecated.jl")

function __init__()
    if !configured
        @warn("ROCArrays.jl has not been successfully built, and will not work properly.")
        @warn("Please run Pkg.build(\"ROCArrays\") and restart Julia.")
        return
    end

    function check_library(name, path)
        path === nothing && return
        if !ispath(path)
            error("$name library has changed. Please run Pkg.build(\"ROCArrays\") and restart Julia.")
        end
    end
    check_library("rocBLAS", librocblas)
    check_library("rocSPARSE", librocsparse)
    check_library("rocALUTION", librocalution)
    check_library("rocFFT", librocfft)
    check_library("rocRAND", librocrand)
    check_library("MIOpen", libmiopen)

    # update the active context when we switch devices
    #= FIXME
    callback = (::HSAAgent, ctx::ROCContext) -> begin
        active_context[] = ctx

        # wipe the active handles
        isdefined(ROCArrays, :rocBLAS)   && (rocBLAS._handle[] = C_NULL)
        isdefined(ROCArrays, :rocSOLVER) && (rocSOLVER._dense_handle[] = C_NULL)
        isdefined(ROCArrays, :rocRAND)   && (rocRAND._generator[] = nothing)
        isdefined(ROCArrays, :MIOpen)    && (MIOpen._handle[] = C_NULL)
    end
    push!(AMDGPUnative.device!_listeners, callback)

    # a device might be active already
    existing_ctx = CUDAdrv.CuCurrentContext()
    if existing_ctx !== nothing
        active_context[] = existing_ctx
    end

    __init_memory__()
    =#
end

end # module
