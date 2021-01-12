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
import Core: LLVMPtr

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, profile, get_first_isa, launch!
export get_default_agent, get_default_queue

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc, roczeros, rocones, rocfill
export HSAArray

### HSA Runtime ###

include(joinpath(@__DIR__, "hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

struct Adaptor end

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

include("array.jl")
#include("subarray.jl")
#include("utils.jl")
#include("indexing.jl")
#include("broadcast.jl")
#include("matmul.jl")
#include("mapreduce.jl")
#include("gpuarray_interface.jl")

allowscalar(x::Bool) = nothing

### Initialization and Shutdown ###

const HSA_REFCOUNT = Threads.Atomic{UInt}(0)
hsaref!() = Threads.atomic_add!(HSA_REFCOUNT, UInt(1))
function hsaunref!()
    if Threads.atomic_cas!(HSA_REFCOUNT, UInt(1), UInt(0)) == UInt(1)
        HSA.shut_down()
    else
        Threads.atomic_sub!(HSA_REFCOUNT, UInt(1))
    end
end

function __init__()
    # Load binary dependencies
    include(joinpath(dirname(@__DIR__), "deps", "loaddeps.jl"))

    if hsa_configured
        # Make sure we load the library found by the last `] build`
        push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
        # TODO: Do the same (if possible) for the debug library

        # Initialize the HSA runtime
        status = HSA.init()
        if status == HSA.STATUS_SUCCESS
            hsaref!()
            # Register shutdown hook
            atexit() do
                hsaunref!()
            end

            # Populate the default agent
            agents = get_agents(:gpu)
            if length(agents) > 0
                DEFAULT_AGENT[] = first(agents)
            end

            # Load ROCm external libraries
            if ext_libs_configured
                libhip !== nothing         && include(joinpath(@__DIR__, "hip", "HIP.jl"))
                librocblas !== nothing     && include(joinpath(@__DIR__, "blas", "rocBLAS.jl"))
                librocfft !== nothing      && include(joinpath(@__DIR__, "fft", "rocFFT.jl"))
                #librocsparse !== nothing  && include("sparse/rocSPARSE.jl")
                #librocalution !== nothing && include("solver/rocALUTION.jl")
                librocrand !== nothing && include(joinpath(@__DIR__, "rand", "rocRAND.jl"))
                #libmiopen !== nothing     && include("dnn/MIOpen.jl")

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
            else
                @warn """
                ROCm external libraries have not been built, runtime functionality will be unavailable.
                Please run Pkg.build("AMDGPU") and reload AMDGPU.
                """
            end
        else
            @warn "HSA initialization failed with code $status"
        end
        # we need to load it after rocRAND.jl
        include(joinpath(@__DIR__, "random.jl"))
    else
        @warn """
        HSA runtime has not been built, runtime functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        """
    end

    # Check whether device intrinsics are available
    if !ispath(device_libs_path)
        @warn """
        ROCm-Device-Libs have not been downloaded, device intrinsics will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        """
    end

    # Load optional OpenCL integrations
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")
end

end # module
