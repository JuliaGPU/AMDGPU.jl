module AMDGPU

### Imports ###

using CEnum
using Libdl
using LLVM, LLVM.Interop
using GPUCompiler
using GPUArrays
using Adapt
import LinearAlgebra
import Core: LLVMPtr

### Exports ###

export ROCDevice, ROCQueue, ROCExecutable, ROCKernel, ROCSignal
export has_rocm_gpu

export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat
export roc

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

# Load HSA Runtime.
const libhsaruntime = "libhsa-runtime64.so.1"
include(joinpath("hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

# Load binary dependencies
include(joinpath(dirname(@__DIR__), "deps", "bindeps.jl"))

# Utilities
include("utils.jl")

# Load HIP
const libhip = "libamdhip64.so"
include(joinpath("hip", "HIP.jl"))
import .HIP: HIPContext, HIPDevice, HIPStream
export HIPContext, HIPDevice, HIPStream

include("cache.jl")

module Runtime
    using ..CEnum
    using Setfield
    import ..HSA
    import ..Adapt
    using ..GPUCompiler
    import Preferences: @load_preference, @set_preferences!
    import TimespanLogging
    import TimespanLogging: timespan_start, timespan_finish

    import ..AMDGPU
    import ..AMDGPU: getinfo, LockedObject, HIP

    struct Adaptor end

    const RT_LOCK = Threads.ReentrantLock()
    const RT_EXITING = Ref{Bool}(false)

    include(joinpath("runtime", "logging.jl"))
    include(joinpath("runtime", "error.jl"))
    include(joinpath("runtime", "thread-utils.jl"))
    include(joinpath("runtime", "device.jl"))
    include(joinpath("runtime", "linked-list.jl"))
    include(joinpath("runtime", "queue.jl"))
    include(joinpath("runtime", "signal.jl"))
    include(joinpath("runtime", "dims.jl"))
    module Mem
        import AMDGPU
        import AMDGPU: HSA
        if AMDGPU.hip_configured
            import AMDGPU: HIP
        end
        import AMDGPU: Runtime
        import .Runtime: ROCDevice, ROCSignal, ROCMemoryRegion, ROCMemoryPool, ROCDim, ROCDim3
        import .Runtime: DEVICES, check, get_region, get_memory_pool, get_handle

        using Preferences

        abstract type AbstractAMDBuffer end

        include(joinpath("runtime", "memory", "utils.jl"))
        include(joinpath("runtime", "memory", "memory.jl"))
        include(joinpath("runtime", "memory", "pooled.jl"))
        include(joinpath("runtime", "memory", "hip.jl"))
        include(joinpath("runtime", "memory", "refcount.jl"))
    end
    include(joinpath("runtime", "executable.jl"))
    include(joinpath("runtime", "hashing.jl"))
    include(joinpath("runtime", "kernel.jl"))
    include(joinpath("runtime", "kernel-signal.jl"))
    include(joinpath("runtime", "launch.jl"))
    include(joinpath("runtime", "execution.jl"))
    include(joinpath("runtime", "sync.jl"))
    include(joinpath("runtime", "fault.jl"))
end # module Runtime
import .Runtime: Mem
import .Runtime: ROCDevice, ROCQueue

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
import .Device: @ROCDynamicLocalArray, @ROCStaticLocalArray
import .Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
import .Device: threadIdx, blockIdx, blockDim
import .Device: sync_workgroup
import .Device: @rocprint, @rocprintln, @rocprintf

export ROCDeviceArray, @ROCDynamicLocalArray, @ROCStaticLocalArray
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
    import ..HIP
    import .Runtime: ROCDevice, ROCModule, ROCFunction
    import .Runtime: Adaptor
    import .Runtime: Mem

    include(joinpath("compiler", "device-libs.jl"))
    include(joinpath("compiler", "utils.jl"))
    include(joinpath("compiler", "global-hooks.jl"))
    include(joinpath("compiler", "codegen.jl"))
    include(joinpath("compiler", "hip_codegen.jl"))
    include(joinpath("compiler", "occupancy.jl"))
end # module Compiler

include("tls.jl")
include("highlevel.jl")
include("reflection.jl")

### ROCArray ###

import .Runtime: Mem

include("array.jl")
include("conversions.jl")
include("broadcast.jl")
include("mapreduce.jl")

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
include(joinpath("blas", "rocBLAS.jl"))
#include(joinpath("sparse", "rocSPARSE.jl")
#include(joinpath("solver", "rocSOLVER.jl")
#include(joinpath("solver", "rocALUTION.jl")
include(joinpath("rand", "rocRAND.jl"))
include(joinpath("fft", "rocFFT.jl"))
include(joinpath("dnn", "MIOpen.jl"))

include("random.jl")

# KernelAbstractions
include("ROCKernels.jl")
import .ROCKernels: ROCBackend
export ROCBackend

function __init__()
    atexit() do
        Runtime.RT_EXITING[] = true
    end

    if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
        env_use_artifacts = !parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "false"))
        if use_artifacts != env_use_artifacts
            enable_artifacts!(env_use_artifacts)
            @warn """
            The environment variable JULIA_AMDGPU_DISABLE_ARTIFACTS does not match the value from preferences.
            Forcing the preferences value to $(env_use_artifacts); please restart Julia for changes to take effect.
            """
        end
    end

    # Quiet path first, in case this system doesn't have AMD GPUs
    if !ispath("/dev/kfd")
        @debug "/dev/kfd not available (no AMD GPU), skipping initialization"
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

            # Setup HSA fault handler
            Runtime.setup_fault_handler()
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
    descriptions = (
        "dense BLAS", "sparse BLAS", "linear solver",
        "fancy linear solver", "RNG", "FFT", "DNN/convolution")
    for ((name, pkg), purpose) in zip(rocm_ext_libs, descriptions)
        if use_artifacts && pkg !== nothing && !functional(name)
            # These are numerous and thus noisy
            build_reason = getfield(AMDGPU, Symbol(name, :_build_reason))
            @debug """
            $pkg is unavailable, $purpose functionality will be disabled. Reason: $build_reason
            """
        end
    end
end

f() = return

function vadd(y, x)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    @inbounds y[i] += x[i]
    return nothing
end

function set_one!(x)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    @inbounds x[i] += Int32(3)
    return nothing
end

function tt()
    stream = AMDGPU.stream()

    # fun = Compiler.hipfunction(f)
    # HIP.hipModuleLaunchKernel(
    #     fun, 1, 1, 1, 1, 1, 1,
    #     0, stream, Ptr{Ptr{Cvoid}}(), Ptr{Ptr{Cvoid}}()) |> HIP.check
    # AMDGPU.synchronize()

    x = ROCArray{Int32}(undef, 128)
    fill!(x, 0)

    fun_args = map(rocconvert, (x,))
    fun_tt = Tuple{map(Core.Typeof, fun_args)...}
    fun = Compiler.hipfunction(set_one!, fun_tt)

    args_refs = [Base.RefValue(i) for i in fun_args]
    args_ptrs = [Base.unsafe_convert(Ptr{Cvoid}, i) for i in args_refs]
    @show Array(x)
    HIP.hipModuleLaunchKernel(
        fun, 128, 1, 1, 1, 1, 1,
        0, stream, args_ptrs, Ptr{Ptr{Cvoid}}()) |> HIP.check
    AMDGPU.synchronize()
    @show Array(x)

    # y = ROCArray{Int32}(undef, 128)
    # fill!(x, 1)
    # fill!(y, 1)

    # fun_args = map(rocconvert, (x, y))
    # fun_tt = Tuple{map(Core.Typeof, fun_args)...}
    # fun = Compiler.hipfunction(vadd, fun_tt)

    # args_refs = [Base.RefValue(i) for i in fun_args]
    # args_ptrs = [Base.unsafe_convert(Ptr{Cvoid}, i) for i in args_refs]
    # HIP.hipModuleLaunchKernel(
    #     fun, 128, 1, 1, 1, 1, 1,
    #     0, stream, args_ptrs, Ptr{Ptr{Cvoid}}()) |> HIP.check
    # AMDGPU.synchronize()

    # @show Array(x)
    # @show Array(y)

    return
end

end # module
