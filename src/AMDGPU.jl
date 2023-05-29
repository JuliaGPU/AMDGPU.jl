module AMDGPU

using CEnum
using Libdl
using LLVM, LLVM.Interop
using GPUCompiler
using GPUArrays
using Adapt
import LinearAlgebra
import Core: LLVMPtr

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

struct KernelState
    exception_flag::Ptr{Cvoid}
    output_context::Ptr{Cvoid}
    printf_output_context::Ptr{Cvoid}
    malloc_hc::Ptr{Cvoid}
    free_hc::Ptr{Cvoid}
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
    include(joinpath("runtime", "hip-execution.jl"))
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
import .Device: malloc, signal_exception, report_exception, report_oom, report_exception_frame, report_exception_name
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
    import Core: LLVMPtr

    using ..GPUCompiler
    using ..LLVM
    using Printf

    import ..AMDGPU
    import ..AMDGPU: AS
    import ..Runtime
    import ..Device
    import ..HIP
    import ..Mem

    include(joinpath("compiler", "device-libs.jl"))
    include(joinpath("compiler", "utils.jl"))
    include(joinpath("compiler", "exceptions.jl"))
    include(joinpath("compiler", "output_context.jl"))
    include(joinpath("compiler", "dynamic_memory.jl"))
    include(joinpath("compiler", "codegen.jl"))
end

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
    y[i] += x[i]
    return nothing
end

function set_one!(x)
    i = workitemIdx().x + (workgroupIdx().x - 1) * workgroupDim().x
    x[i] += 3
    return nothing
end

function printing()
    Device.@rocprintln("Hello world!")
    return nothing
end

function fprinting()
    i = workgroupIdx().x
    Device.@rocprintf("Hello world from %d grid.\n", i)
    return nothing
end

function dyn_mem()
    bytesize::Csize_t = 128
    ptr = Device.malloc(bytesize)
    Device.@rocprintf(
        "Device malloc %u bytes @ %u address.\n",
        bytesize, UInt64(ptr))
    Device.free(ptr)
    return nothing
end

function ppp()
    ptr = Device.alloc_string(Val(Symbol("HEY!")))
    str = Device.device_string_to_host(reinterpret(Ptr{Cchar}, ptr))
    Device.@rocprintf("String %s\n", str)
    Device.free(reinterpret(Ptr{Cvoid}, str))
    return nothing
end

"""
TODO
- tests
- perform pointer relocation
"""

function test()
    @roc ppp()
    AMDGPU.synchronize()

    @roc dyn_mem()
    AMDGPU.synchronize()

    @roc f()
    AMDGPU.synchronize()

    @roc printing()
    AMDGPU.synchronize()

    @roc gridsize=8 groupsize=1 fprinting()
    AMDGPU.synchronize()

    x = ROCArray(fill(Int32(0), 128))
    @roc groupsize=128 set_one!(x)
    AMDGPU.synchronize()
    @show Array(x)

    y = ROCArray(fill(Int32(1), 128))
    @roc groupsize=128 vadd(x, y)
    AMDGPU.synchronize()
    @show Array(x)
    @show Array(y)

    x = AMDGPU.ones(Float32, 16)
    @show x
    @show sum(sin.(x))
    @show sin.(x)

    x = ROCArray(fill(Int32(0), 1))
    @roc gridsize=2 groupsize=1 set_one!(x)
    AMDGPU.synchronize()

    return
end

end
