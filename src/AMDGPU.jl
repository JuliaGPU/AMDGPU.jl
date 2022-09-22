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
include(joinpath(dirname(@__DIR__), "deps", "bindeps.jl"))

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
    import ..LinearAlgebra
    import ..AMDGPU
    import .AMDGPU: method_table

    # Device sources must load _before_ the compiler infrastructure
    # because of generated functions.
    include(joinpath("device", "addrspaces.jl"))
    include(joinpath("device", "globals.jl"))
    include(joinpath("device", "strings.jl"))
    include(joinpath("device", "exceptions.jl"))
    include(joinpath("device", "gcn.jl"))
    include(joinpath("device", "runtime.jl"))
    include(joinpath("device", "quirks.jl"))
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
    if Threads.atomic_add!(HSA_REFCOUNT, UInt(1)) > typemax(UInt)-10
        Core.println("HSA_REFCOUNT OVERFLOW!")
        exit(1)
    end
end
function hsaunref!()
    if Threads.atomic_sub!(HSA_REFCOUNT, UInt(1)) == 1
        HSA.shut_down()
    end
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
    if hsa_configured
        # Make sure we load the right library
        push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
        # TODO: Do the same (if possible) for the debug library

        # Initialize the HSA runtime
        HSA_REFCOUNT[] = 0
        status = HSA.init()
        if status == HSA.STATUS_SUCCESS
            hsaref!()
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
        HSA runtime is unavailable, compilation and runtime functionality will be disabled.
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
        LLD is unavailable, compilation functionality will be disabled.
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
        Device libraries are unavailable, device intrinsics will be disabled.
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
        HIP library is unavailable, HIP integration will be disabled.
        Reason: $hip_build_reason
        """

        if parse(Bool, get(ENV, "JULIA_AMDGPU_HIP_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to load HIP runtime, but HIP must load, bailing out")
        end
    end

    # Check whether external libraries are available
    for ((name, pkg), purpose) in zip(rocm_ext_libs,
                                      ("dense BLAS",
                                       "sparse BLAS",
                                       "linear solver",
                                       "fancy linear solver",
                                       "RNG",
                                       "FFT",
                                       "DNN/convolution"))
        if use_artifacts && pkg !== nothing && !functional(name)
            # These are numerous and thus noisy
            build_reason = Symbol(name, :_build_reason)
            @debug """
            $pkg is unavailable, $purpose functionality will be disabled.
            Reason: $(@eval $build_reason)
            """
        end
    end

    # Load optional OpenCL integrations
    @require OpenCL="08131aa3-fb12-5dee-8b74-c09406e224a2" include("opencl.jl")
end

end # module
