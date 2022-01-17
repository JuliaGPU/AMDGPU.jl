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
using Printf
import Core: LLVMPtr

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSASignal
export get_agents, profile, get_first_isa_string, launch!
export get_default_agent, get_default_queue
export has_rocm_gpu

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc

### HSA Runtime ###

const libhsaruntime = "libhsa-runtime64.so.1"
include(joinpath(@__DIR__, "hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

struct Adaptor end

const RT_LOCK = Threads.ReentrantLock()

include("extras.jl")
include("error.jl")
include("agent.jl")
include("queue.jl")
include("signal.jl")
include("executable.jl")
include("kernel.jl")
include("memory.jl")

@enum DeviceRuntime HSA_rt OCL_rt
const RUNTIME = Ref{DeviceRuntime}(HSA_rt)
#=
if get(ENV, "AMDGPUNATIVE_OPENCL", "") != ""
    RUNTIME[] = OCL_rt
end
=#
include("runtime.jl")
include("statussignal.jl")
include("sync.jl")

# Device sources must load _before_ the compiler infrastructure
# because of generated functions.
include(joinpath("device", "tools.jl"))
include(joinpath("device", "pointer.jl"))
include(joinpath("device", "array.jl"))
include(joinpath("device", "gcn.jl"))
include(joinpath("device", "runtime.jl"))
include(joinpath("device", "llvm.jl"))
include(joinpath("device", "globals.jl"))

include("query.jl")
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
include("broadcast.jl")
#include("matmul.jl")
include("mapreduce.jl")
#include("gpuarray_interface.jl")
include("compat.jl")

allowscalar(x::Bool) = GPUArrays.allowscalar(x)

### Initialization and Shutdown ###

const HSA_REFCOUNT = Threads.Atomic{UInt}(0)
function hsaref!()
    #=
    if Threads.atomic_add!(HSA_REFCOUNT, UInt(1)) > typemax(UInt)-10
        Core.println("HSA_REFCOUNT OVERFLOW!")
        exit(1)
    end
    =#
end
function hsaunref!()
    #=
    if Threads.atomic_sub!(HSA_REFCOUNT, UInt(1)) == 1
        HSA.shut_down()
    end
    =#
end

# Load binary dependencies
include(joinpath(dirname(@__DIR__), "deps", "loaddeps.jl"))

# Load HIP
const libhip = "libamdhip64.so"
include(joinpath(@__DIR__, "hip", "HIP.jl"))

# Load ROCm external libraries
if hip_configured
librocblas !== nothing     && include(joinpath(@__DIR__, "blas", "rocBLAS.jl"))
librocfft !== nothing      && include(joinpath(@__DIR__, "fft", "rocFFT.jl"))
#librocsparse !== nothing  && include("sparse/rocSPARSE.jl")
#librocalution !== nothing && include("solver/rocALUTION.jl")
if librocrand !== nothing
include(joinpath(@__DIR__, "rand", "rocRAND.jl"))
include(joinpath(@__DIR__, "random.jl"))
end
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
end # hip_configured

# Utilities
include("utils.jl")

function __init__()
    if !configured && build_reason != "unknown"
        if build_reason == "Build did not occur"
            @warn """
            AMDGPU.jl has not been built
            Please run Pkg.build("AMDGPU") and restart Julia
            """
            return
        end

        # Some other reason
        @warn """
        Build failed to start!
        Reason: $build_reason
        """
        return
    end
    if hsa_configured
        # Make sure we load the library found by the last `] build`
        push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
        # TODO: Do the same (if possible) for the debug library

        # Initialize the HSA runtime
        HSA_REFCOUNT[] = 0
        status = HSA.init()
        if status == HSA.STATUS_SUCCESS
            hsaref!()
            HSA_REFCOUNT[] = 1
            # Register shutdown hook
            atexit() do
                hsaunref!()
            end

            # Populate the default agent
            agents = get_agents(:gpu)
            if length(agents) > 0
                DEFAULT_AGENT[] = first(agents)
            end
        else
            @warn "HSA initialization failed with code $status"
        end
    else
        @warn """
        HSA runtime has not been built, runtime functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $hsa_build_reason
        """

        if parse(Bool, get(ENV, "JULIA_AMDGPU_HSA_MUST_LOAD", "0"))
            println("Diagnostics:")
            println("-- deps/build.log")
            println(String(read(joinpath(@__DIR__, "..", "deps", "build.log"))))
            println("-- deps/ext.jl")
            println(String(read(joinpath(@__DIR__, "..", "deps", "ext.jl"))))
            println("-- permissions")
            run(`ls -lah /dev/kfd`)
            run(`ls -lah /dev/dri`)
            run(`id`)
        end
    end

    # Check whether ld.lld was found
    if !lld_configured
        @warn """
        ld.lld was not found, compilation functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $lld_build_reason
        """
    end

    if hip_configured
        push!(Libdl.DL_LOAD_PATH, dirname(libhip_path))
    else
        @warn """
        HIP library has not been built, runtime functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $hip_build_reason
        """
    end

    # Check whether device intrinsics are available
    if !device_libs_configured
        @warn """
        ROCm-Device-Libs were not found, device intrinsics will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $device_libs_build_reason
        """
    end

    # Check whether external libraries are available
    if use_artifacts && !rocrand_configured
        @warn """
        rocRAND failed to load, RNG functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $rocrand_build_reason
        """
    end

    # Load optional OpenCL integrations
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")

    # Load optional @requires packages
    @require ForwardDiff="f6369f11-7733-5829-9624-2563aa707210" include("forwarddiff.jl")
end

end # module
