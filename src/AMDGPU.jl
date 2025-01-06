module AMDGPU

using Adapt
using CEnum
using GPUCompiler
using GPUArrays
using Libdl
using LLVM, LLVM.Interop
using Preferences
using Printf

import AcceleratedKernels as AK
import UnsafeAtomics
import UnsafeAtomicsLLVM
import Atomix
import Atomix: @atomic, @atomicswap, @atomicreplace
import Core: LLVMPtr
import LinearAlgebra
import PrettyTables

const Maybe{T} = Union{Nothing, T}

"""
If `true`, then synchronizes immediately after every Julia kernel launch
(launched by `@roc` macro).
Meant to be used together with `HIP_LAUNCH_BLOCKING=1`.
"""
const LAUNCH_BLOCKING::Ref{Bool} = Ref{Bool}(false)

export @roc, roc, rocconvert
export HIPDevice, has_rocm_gpu
export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export DenseROCArray, DenseROCVector, DenseROCMatrix, StridedROCMatrix

struct LockedObject{T}
    lock::ReentrantLock
    payload::T
end
LockedObject(payload) = LockedObject(ReentrantLock(), payload)

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

using .HIP
using .HIP: HIPContext, HIPDevice, HIPStream
export HIPContext, HIPDevice, HIPStream

include("cache.jl")

include("runtime/Runtime.jl")
import .Runtime
import .Runtime: Mem, ROCDim, ROCDim3

include("memory.jl")

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

# Enable hardware FP atomics for +/- ops.
const ROCIndexableRef{Indexable <: ROCDeviceArray} = Atomix.IndexableRef{Indexable}

function Atomix.modify!(ref::ROCIndexableRef, op::OP, x, ord) where {
    OP <: Union{typeof(+), typeof(-)}
}
    x = Atomix.asstorable(ref, x)
    ptr = Atomix.pointer(ref)
    root = Atomix.gcroot(ref)
    GC.@preserve root UnsafeAtomics.modify!(ptr, op, x, ord, Val(:agent))
end

include("ROCKernels.jl")
import .ROCKernels: ROCBackend
export ROCBackend

# include("cache_allocator.jl")

function __init__()
    # Used to shutdown hostcalls if any is running.
    atexit(() -> begin Runtime.RT_EXITING[] = true end)

    if haskey(ENV, "HIP_LAUNCH_BLOCKING")
        launch_blocking = parse(Bool, ENV["HIP_LAUNCH_BLOCKING"])
        LAUNCH_BLOCKING[] = launch_blocking
        if launch_blocking
            @info "`HIP_LAUNCH_BLOCKING` is set to `true`. " *
                "Synchronizing immediately after every Julia & HIP kernel launch."
        end
    end

    if Sys.islinux()
        if !ispath("/dev/kfd")
            @debug "/dev/kfd not available (no AMD GPU), skipping initialization"
            return
        end

        if !isempty(libhsaruntime)
            status = HSA.init()
            status == HSA.STATUS_SUCCESS ?
                atexit(() -> HSA.shut_down()) :
                @warn "HSA initialization failed with code $status"
        else
            @warn "HSA runtime is unavailable, compilation and runtime functionality will be disabled."
            if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
                print_build_diagnostics()
                error("Failed to load HSA runtime, but HSA must load, bailing out")
            end
        end
    end

    if !functional(:lld)
        @warn "LLD is unavailable, compilation functionality will be disabled."
        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to find ld.lld, but ld.lld must exist, bailing out")
        end
    end

    if !functional(:device_libs)
        @warn "Device libraries are unavailable, device intrinsics will be disabled."
        if parse(Bool, get(ENV, "JULIA_AMDGPU_CORE_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to find Device Libs, but Device Libs must exist, bailing out")
        end
    end

    if functional(:hip)
        HIP.devices()
    else
        @warn "HIP library is unavailable, HIP integration will be disabled."
        if parse(Bool, get(ENV, "JULIA_AMDGPU_HIP_MUST_LOAD", "0"))
            print_build_diagnostics()
            error("Failed to load HIP runtime, but HIP must load, bailing out")
        end
    end

    hiplibs = (
        ("rocBLAS", :rocblas), ("rocSPARSE", :rocsparse), ("rocSOLVER", :rocsolver),
        ("rocRAND", :rocrand), ("rocFFT", :rocfft), ("MIOpen", :MIOpen))
    for (name, symbol) in hiplibs
        functional(symbol) || @warn "$name is unavailable, functionality will be disabled."
    end
end

end
