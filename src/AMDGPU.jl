module AMDGPU

### Imports ###

using CEnum
using Setfield
using Libdl
using LLVM, LLVM.Interop
using GPUArrays
using GPUCompiler
using Adapt
using Requires
import LinearAlgebra

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, profile, get_first_isa, launch!
export get_default_agent, get_default_queue

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc, roczeros, rocones, rocfill
export HSAArray

### Binary Dependencies ###

include(joinpath(dirname(@__DIR__), "deps", "deps.jl"))

### HSA Runtime ###

include(joinpath(@__DIR__, "hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

include("extras.jl")
include("error.jl")
include("agent.jl")
include("queue.jl")
include("signal.jl")
include("executable.jl")
include("kernel.jl")
include("memory.jl")
# TODO: Remove me:
include("hsaarray.jl")

@enum DeviceRuntime HSA_rt OCL_rt
const RUNTIME = Ref{DeviceRuntime}(HSA_rt)
#=
if get(ENV, "AMDGPUNATIVE_OPENCL", "") != ""
    RUNTIME[] = OCL_rt
end
=#
include("runtime.jl")

struct Adaptor end

# Device sources must load _before_ the compiler infrastructure
# because of generated functions.
include(joinpath("device", "tools.jl"))
include(joinpath("device", "pointer.jl"))
include(joinpath("device", "array.jl"))
include(joinpath("device", "gcn.jl"))
include(joinpath("device", "runtime.jl"))
include(joinpath("device", "llvm.jl"))
include(joinpath("device", "globals.jl"))

include("compiler.jl")
include("execution_utils.jl")
include("execution.jl")
include("exceptions.jl")
include("reflection.jl")

### ROCArray ###

#include("memory.jl")
include("array.jl")
#include("subarray.jl")
#include("utils.jl")
#include("indexing.jl")
#include("broadcast.jl")
#include("matmul.jl")
#include("mapreduce.jl")
#include("gpuarray_interface.jl")

roc(xs) = adapt(ROCArray{Float32}, xs)
allowscalar(x::Bool) = nothing

### External Libraries ###

# TODO: add check
include("hip/HIP.jl")
librocblas !== nothing     && include("blas/rocBLAS.jl")
librocfft !== nothing      && include("fft/rocFFT.jl")
#librocsparse !== nothing  && include("sparse/rocSPARSE.jl")
#librocalution !== nothing && include("solver/rocALUTION.jl")
#librocrand !== nothing    && include("rand/rocRAND.jl")
#libmiopen !== nothing     && include("dnn/MIOpen.jl")

### Initialization and Shutdown ###

atexit() do
    configured && HSA.shut_down()
end
function __init__()
    deps_failed() = @warn """
        AMDGPU dependencies have not been built, some functionality may be missing.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        """

    # We want to always be able to load the package
    if !configured
        deps_failed()
        return
    end

    # Make sure we load the library found by the last `] build`
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
    # TODO: Do the same (if possible) for the debug library

    # Initialize the HSA runtime
    HSA.init() |> check

    # Populate the default agent
    agents = get_agents(:gpu)
    if length(agents) > 0
        DEFAULT_AGENT[] = first(agents)
    end

    try
        # Try to load device libs if possible
        check_deps()
        @assert configured
    catch err
        deps_failed()
    end

    # Load optional OpenCL integrations
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")

    # Ensure external libraries are up to date
    function check_library(name, path)
        path === nothing && return
        if !ispath(path)
            @warn "$name library has changed. Please run Pkg.build(\"AMDGPU\") and restart Julia."
        end
    end
    check_library("rocBLAS", librocblas)
    check_library("rocSPARSE", librocsparse)
    check_library("rocALUTION", librocalution)
    check_library("rocFFT", librocfft)
    check_library("rocRAND", librocrand)
    check_library("MIOpen", libmiopen)
end

end # module
