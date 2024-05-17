module AMDGPU

using Adapt
using CEnum
using GPUCompiler
using GPUArrays
using Libdl
using LLVM, LLVM.Interop
using Preferences
using Printf

import Atomix: @atomic, @atomicswap, @atomicreplace
import Core: LLVMPtr
import LinearAlgebra
import PrettyTables

const Maybe{T} = Union{Nothing, T}

export @roc, roc, rocconvert
export HIPDevice, has_rocm_gpu
export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export DenseROCArray, DenseROCVector, DenseROCMatrix, StridedROCMatrix

struct LockedObject{T}
    lock::ReentrantLock
    payload::T
end

LockedObject(payload) = LockedObject(ReentrantLock(), payload)

function Base.lock(f, x::LockedObject)
    Base.@lock x.lock begin
        return f(x.payload)
    end
end

# TODO simplify
struct KernelState
    # Exception reporting buffers.
    exception_flag::Ptr{Int32}
    gate::Ptr{UInt64}
    buffers_counter::Ptr{Int32}
    str_buffers_counter::Ptr{Int32}
    buffers::Ptr{Ptr{Cvoid}}
    string_buffers::Ptr{Ptr{Cvoid}}
    n_buffers::Int32
    n_str_buffers::Int32

    # Malloc/free hostcalls.
    malloc_hc::Ptr{Cvoid}
    free_hc::Ptr{Cvoid}

    # Print hostcalls.
    output_context::Ptr{Cvoid}
    printf_output_context::Ptr{Cvoid}
end

# Load binary dependencies.
include("discovery/discovery.jl")
using .ROCmDiscovery

include("utils.jl")

include(joinpath("hsa", "HSA.jl"))
include(joinpath("hip", "HIP.jl"))
import .HIP: HIPContext, HIPDevice, HIPStream
export HIPContext, HIPDevice, HIPStream

include("cache.jl")

include("runtime/Runtime.jl")
import .Runtime
import .Runtime: Mem, ROCDim, ROCDim3

include("memory.jl")

const ci_cache = GPUCompiler.CodeCache()
Base.Experimental.@MethodTable(method_table)

# Device sources must load _before_ the compiler infrastructure,
# because of generated functions.
include("device/Device.jl")
import .Device: malloc, signal_exception, report_exception, report_oom
import .Device: report_exception_frame, report_exception_name
import .Device: ROCDeviceArray, AS, HostCall, HostCallHolder, hostcall!
import .Device: @ROCDynamicLocalArray, @ROCStaticLocalArray
import .Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
import .Device: threadIdx, blockIdx, blockDim
import .Device: sync_workgroup, sync_workgroup_count, sync_workgroup_and, sync_workgroup_or
import .Device: @rocprint, @rocprintln, @rocprintf

export ROCDeviceArray, @ROCDynamicLocalArray, @ROCStaticLocalArray
export @rocprint, @rocprintln, @rocprintf
export workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
export sync_workgroup, sync_workgroup_count, sync_workgroup_and, sync_workgroup_or

include("compiler/Compiler.jl")
import .Compiler
import .Compiler: hipfunction

include("tls.jl")
include("highlevel.jl")
include("reflection.jl")
include("array.jl")
include("gpuarrays.jl")
include("conversions.jl")
include("broadcast.jl")
include("exception_handler.jl")

include("kernels/mapreduce.jl")
include("kernels/indexing.jl")
include("kernels/accumulate.jl")
include("kernels/sorting.jl")
include("kernels/reverse.jl")

allowscalar(x::Bool) = GPUArrays.allowscalar(x)

include(joinpath("blas", "rocBLAS.jl"))
include(joinpath("solver", "rocSOLVER.jl"))
include(joinpath("sparse", "rocSPARSE.jl"))
include(joinpath("rand", "rocRAND.jl"))
include(joinpath("fft", "rocFFT.jl"))
include(joinpath("dnn", "MIOpen.jl"))

include("random.jl")

include("ROCKernels.jl")
import .ROCKernels: ROCBackend
export ROCBackend

function __init__()
    atexit() do
        Runtime.RT_EXITING[] = true
    end

    if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
        env_use_artifacts = !parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "true"))
        if use_artifacts() != env_use_artifacts
            enable_artifacts!(env_use_artifacts)
            @warn """
            The environment variable JULIA_AMDGPU_DISABLE_ARTIFACTS does not match the value from preferences.
            Forcing the preferences value to $(env_use_artifacts); please restart Julia for changes to take effect.
            """
        end
    end

    # Quiet path first, in case this system doesn't have AMD GPUs
    if Sys.islinux() && !ispath("/dev/kfd")
        @debug "/dev/kfd not available (no AMD GPU), skipping initialization"
        return
    end

    # Verbose path, something is misconfigured
    if Sys.islinux()
        if !isempty(libhsaruntime)
            # Initialize the HSA runtime.
            status = HSA.init()
            if status == HSA.STATUS_SUCCESS
                # Register shutdown hook.
                atexit(() -> HSA.shut_down())
            else
                @warn "HSA initialization failed with code $status"
            end
        else
            @warn """
            HSA runtime is unavailable, compilation and runtime functionality will be disabled.
            """
            if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
                print_build_diagnostics()
                error("Failed to load HSA runtime, but HSA must load, bailing out")
            end
        end
    end

    # Check whether ld.lld was found
    if !functional(:lld)
        @warn """
        LLD is unavailable, compilation functionality will be disabled.
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
        """
        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to find Device Libs, but Device Libs must exist, bailing out")
        end
    end

    # Check whether HIP is available
    if functional(:hip)
        HIP.devices()
    else
        @warn """
        HIP library is unavailable, HIP integration will be disabled.
        """
        if parse(Bool, get(ENV, "JULIA_AMDGPU_HIP_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to load HIP runtime, but HIP must load, bailing out")
        end
    end

    # Check whether external libraries are available.
    hiplibs = (
        ("rocBLAS", :rocblas), ("rocSPARSE", :rocsparse),
        ("rocSOLVER", :rocsolver), ("rocALUTION", :rocalution),
        ("rocRAND", :rocrand), ("rocFFT", :rocfft), ("MIOpen", :MIOpen))
    for (name, symbol) in hiplibs
        if !functional(symbol)
            @warn "$name is unavailable, functionality will be disabled."
        end
    end
end

end
