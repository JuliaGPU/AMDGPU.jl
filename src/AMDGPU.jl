module AMDGPU

### Imports ###

using CEnum
using Libdl
using LLVM, LLVM.Interop
using GPUCompiler
using GPUArrays
using Adapt
using Requires
import LinearAlgebra
import Core: LLVMPtr

### Exports ###

export ROCDevice, ROCQueue, ROCExecutable, ROCKernel, ROCSignal
export has_rocm_gpu

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc

# Load HSA Runtime
const libhsaruntime = "libhsa-runtime64.so.1"
include(joinpath(@__DIR__, "hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

# Load binary dependencies
include(joinpath(dirname(@__DIR__), "deps", "loaddeps.jl"))

# Utilities
include("utils.jl")

# Load HIP
const libhip = "libamdhip64.so"
if functional(:hip)
include(joinpath(@__DIR__, "hip", "HIP.jl"))
end

module Runtime
    using ..CEnum
    using Setfield
    import ..HSA
    import ..Adapt
    using ..GPUCompiler

    import ..AMDGPU

    struct Adaptor end

    const RT_LOCK = Threads.ReentrantLock()
    const RT_EXITING = Ref{Bool}(false)

    include("error.jl")
    include("thread-utils.jl")
    include("device.jl")
    include("queue.jl")
    include("signal.jl")
    include("dims.jl")
    module Mem
        include("memory.jl")
    end
    include("executable.jl")
    include("kernel.jl")
    include("kernel-signal.jl")
    include("launch.jl")
    include("execution.jl")
    include("sync.jl")
    include("safe-load.jl")
end # module Runtime
import .Runtime: Mem

const ci_cache = GPUCompiler.CodeCache()
Base.Experimental.@MethodTable(method_table)

module Device
    import ..HSA
    import ..Runtime
    import ..Mem
    import Core: LLVMPtr
    using ..GPUCompiler
    using ..LLVM
    using ..LLVM.Interop
    import ..AMDGPU
    import .AMDGPU: method_table

    # Device sources must load _before_ the compiler infrastructure
    # because of generated functions.
    include(joinpath("device", "addrspaces.jl"))
    include(joinpath("device", "gcn.jl"))
    include(joinpath("device", "runtime.jl"))
    include(joinpath("device", "llvm.jl"))
    include(joinpath("device", "globals.jl"))
    include(joinpath("device", "strings.jl"))
    include(joinpath("device", "exceptions.jl"))
end
import .Device: malloc, signal_exception, report_exception, report_oom, report_exception_frame
import .Device: ROCDeviceArray, AS, HostCall, hostcall!
import .Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
import .Device: threadIdx, blockIdx, blockDim
import .Device: sync_workgroup
import .Device: @rocprint, @rocprintln, @rocprintf

export ROCDeviceArray
export @rocprint, @rocprintln, @rocprintf
export workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
export sync_workgroup

module Compiler
    using ..GPUCompiler
    using ..LLVM
    import ..Adapt
    import Core: LLVMPtr
    using Printf

    import ..AMDGPU
    import ..AMDGPU: AS
    import ..Runtime
    import ..Device
    import .Runtime: ROCDevice, ROCModule, ROCFunction
    import .Runtime: Adaptor
    import .Runtime: Mem

    include("devlibs.jl")
    include("compiler_utils.jl")
    include("compiler.jl")
end # module Compiler

include("highlevel.jl")
include("reflection.jl")

### ROCArray ###

import .Runtime: Mem

include("array.jl")
include("conversions.jl")
#include("subarray.jl")
#include("indexing.jl")
include("broadcast.jl")
#include("matmul.jl")
include("mapreduce.jl")
#include("gpuarray_interface.jl")

allowscalar(x::Bool) = GPUArrays.allowscalar(x)

include("deprecations.jl")

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

# Load ROCm external libraries
if functional(:hip)
functional(:rocblas)      && include(joinpath(@__DIR__, "blas", "rocBLAS.jl"))
#functional(:rocsparse)  && include("sparse/rocSPARSE.jl")
#functional(:rocsolver)   && include("solver/rocSOLVER.jl")
#functional(:rocalution) && include("solver/rocALUTION.jl")
if functional(:rocrand)
include(joinpath(@__DIR__, "rand", "rocRAND.jl"))
include(joinpath(@__DIR__, "random.jl"))
end
functional(:rocfft)      && include(joinpath(@__DIR__, "fft", "rocFFT.jl"))
#functional(:miopen)     && include("dnn/MIOpen.jl")

# Ensure external libraries are up to date
function check_library(name, path)
    path === nothing && return
    if !ispath(path)
        @warn "$name library has changed. Please run Pkg.build(\"AMDGPU\") and restart Julia."
    end
end
check_library("rocBLAS", librocblas)
check_library("rocSPARSE", librocsparse)
check_library("rocSOLVER", librocsolver)
check_library("rocALUTION", librocalution)
check_library("rocRAND", librocrand)
check_library("rocFFT", librocfft)
check_library("MIOpen", libmiopen)
end # functional(:hip)

function __init__()
    atexit() do
        Runtime.RT_EXITING[] = true
    end

    # Quiet path first, in case this system doesn't have AMD GPUs
    if !ispath("/dev/kfd")
        @debug "/dev/kfd not available, silently skipping initialization"
        return
    end
    has_gpu = false
    if isdir("/sys/class/kfd/kfd/topology/nodes/")
        for node_id in readdir("/sys/class/kfd/kfd/topology/nodes/")
            # CPU nodes don't have names
            if !isempty(readchomp(joinpath("/sys/class/kfd/kfd/topology/nodes/", node_id, "name")))
                has_gpu = true
            end
        end
    end
    if !has_gpu
        @debug "No GPUs found, silently skipping initialization"
        return
    end

    # Verbose path, something is misconfigured
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

            # Select the default device
            for device in Runtime.fetch_devices()
                if !isassigned(Runtime.DEFAULT_DEVICE) && device_type(device) == :gpu
                    Runtime.DEFAULT_DEVICE[] = device
                    break
                end
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

        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to load HSA runtime, but HSA must load, bailing out")
        end
    end

    # Check whether ld.lld was found
    if !functional(:lld)
        @warn """
        ld.lld was not found, compilation functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $lld_build_reason
        """

        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to find ld.lld, but ld.lld must exist, bailing out")
        end
    end

    # Check whether device intrinsics are available
    if !functional(:device_libs)
        @warn """
        ROCm-Device-Libs were not found, device intrinsics will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $device_libs_build_reason
        """

        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to find Device Libs, but Device Libs must exist, bailing out")
        end
    end

    # Check whether HIP is available
    if functional(:hip)
        push!(Libdl.DL_LOAD_PATH, dirname(libhip_path))
    else
        @warn """
        HIP library has not been built, HIP integration will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $hip_build_reason
        """

        if parse(Bool, get(ENV, "JULIA_AMDGPU_HIP_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to load HIP runtime, but HIP must load, bailing out")
        end
    end

    # Check whether external libraries are available
    if use_artifacts && !functional(:rocrand)
        @warn """
        rocRAND_jll failed to load, RNG functionality will be unavailable.
        Please run Pkg.build("AMDGPU") and reload AMDGPU.
        Reason: $rocrand_build_reason
        """
    end

    # Load optional OpenCL integrations
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")
end

end # module
