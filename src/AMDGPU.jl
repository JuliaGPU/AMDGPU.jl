module AMDGPU

using Adapt
using CEnum
using GPUCompiler
using GPUArrays
using Libdl
using LLVM, LLVM.Interop
using Preferences
using Printf

import LinearAlgebra
import Core: LLVMPtr

export HIPDevice
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
    exception_flag::Ptr{Int}
    gate::Ptr{UInt32}
    buffers_counter::Ptr{Int32}
    str_buffers_counter::Ptr{Int32}
    buffers::Ptr{Ptr{Cvoid}}
    string_buffers::Ptr{Ptr{Cvoid}}
    n_buffers::Int
    n_str_buffers::Int
end

# struct KernelState
#     exception_flag::Ptr{Cvoid}
#     output_context::Ptr{Cvoid}
#     printf_output_context::Ptr{Cvoid}
#     malloc_hc::Ptr{Cvoid}
#     free_hc::Ptr{Cvoid}
# end

# Load HSA Runtime.
const libhsaruntime = "libhsa-runtime64.so.1"
include(joinpath("hsa", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

# Load binary dependencies.
include("discovery_utils.jl")
include("rocm_discovery.jl")
populate_globals!(bindeps_setup())

# Utilities
include("utils.jl")

# Load HIP
include(joinpath("hip", "HIP.jl"))
import .HIP: HIPContext, HIPDevice, HIPStream
export HIPContext, HIPDevice, HIPStream

include("cache.jl")

module Runtime
    using ..CEnum
    using ..GPUCompiler

    import ..Adapt
    import Preferences: @load_preference, @set_preferences!
    import TimespanLogging
    import TimespanLogging: timespan_start, timespan_finish

    import ..HSA
    import ..HIP
    import ..AMDGPU
    import ..AMDGPU: getinfo, LockedObject
    import .HIP: HIPDevice

    struct Adaptor end

    const RT_LOCK = Threads.ReentrantLock()
    const RT_EXITING = Ref{Bool}(false)

    include(joinpath("runtime", "logging.jl"))
    include(joinpath("runtime", "error.jl"))
    include(joinpath("runtime", "hsa_device.jl"))
    include(joinpath("runtime", "device.jl"))
    include(joinpath("runtime", "dims.jl"))

    module Mem
        using Preferences

        import AMDGPU
        import AMDGPU: HIP, HSA
        import AMDGPU: Runtime
        import .HIP: HIPDevice
        import .Runtime: ROCDim, ROCDim3, check

        const refcounts_lock = Threads.ReentrantLock()

        abstract type AbstractAMDBuffer end

        include(joinpath("runtime", "memory", "utils.jl"))
        include(joinpath("runtime", "memory", "hip.jl"))
        include(joinpath("runtime", "memory", "refcount.jl"))
    end

    include(joinpath("runtime", "execution.jl"))
    include(joinpath("runtime", "hip-execution.jl"))
    include(joinpath("runtime", "fault.jl"))
end

import .Runtime: Mem

const ci_cache = GPUCompiler.CodeCache()
Base.Experimental.@MethodTable(method_table)

module Device
    using ..GPUCompiler
    using ..LLVM
    using ..LLVM.Interop

    import Core: LLVMPtr
    import ..LinearAlgebra

    import ..HSA
    import ..HIP
    import ..Runtime
    import ..Mem
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
    import LLD_jll

    using ..GPUCompiler
    using ..LLVM
    using Printf

    import ..AMDGPU
    import ..AMDGPU: AS
    import ..Runtime
    import ..Device
    import ..HIP
    import ..Mem

    include(joinpath("compiler", "zeroinit_lds.jl"))
    include(joinpath("compiler", "device_libs.jl"))
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
        if use_artifacts() != env_use_artifacts
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
            Runtime.fetch_hsa_devices()
            devs = Runtime.fetch_devices()
            Runtime.set_default_device!(first(devs))

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
    if !functional(:hip)
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
        if use_artifacts() && pkg !== nothing && !functional(name)
            # These are numerous and thus noisy
            build_reason = getfield(AMDGPU, Symbol(name, :_build_reason))
            @debug """
            $pkg is unavailable, $purpose functionality will be disabled.
            Reason: $build_reason.
            """
        end
    end
end

"""
TODO
- pointer relocation
- wrapp more HIP calls in retry/reclaim?
"""

struct ExceptionHolder
    exception_flag::Mem.HostBuffer # Main buffer where printf context is written.
    gate::ROCArray{UInt64}
    buffers_counter::ROCArray{Int32}
    str_buffers_counter::ROCArray{Int32}

    errprintf_buffers::Vector{Mem.HostBuffer} # Buffers used by `@errprintf`.
    string_buffers::Vector{Mem.HostBuffer} # Buffers used for storing device strings on the host.

    errprintf_buffers_dev::ROCArray{Ptr{Cvoid}} # Pointers of `errprintf_buffers` on the device.
    string_buffers_dev::ROCArray{Ptr{Cvoid}} # Pointers of `string_buffers` on the device.

    function ExceptionHolder()
        buf_len = 2^11 # 2 KiB
        str_len = 2^11 # 2 KiB
        n_buffers = 50
        n_str_buffers = 100

        exception_flag = Mem.HostBuffer(sizeof(Int32), HIP.hipHostAllocMapped)
        gate = ROCArray(UInt64[0])
        buffers_counter = ROCArray(Int32[0])
        str_buffers_counter = ROCArray(Int32[0])

        errprintf_buffers = [
            Mem.HostBuffer(buf_len, HIP.hipHostAllocMapped)
            for _ in 1:n_buffers]
        str_buffers = [
            Mem.HostBuffer(str_len, HIP.hipHostAllocMapped)
            for _ in 1:n_str_buffers]

        errprintf_buffers_dev = ROCArray(Mem.device_ptr.(errprintf_buffers))
        str_buffers_dev = ROCArray(Mem.device_ptr.(str_buffers))

        new(
            exception_flag, gate, buffers_counter, str_buffers_counter,
            errprintf_buffers, str_buffers,
            errprintf_buffers_dev, str_buffers_dev)
    end
end

# TODO
# - do not override the error
# - reset holder after reading an error
# - guard str buffers with ⊡ gate.
# - pointer relocation

const GLOBAL_EXCEPTION_HOLDER = Dict{HIPDevice, ExceptionHolder}()

function exception_holder(dev::HIPDevice)
    get!(() -> ExceptionHolder(), GLOBAL_EXCEPTION_HOLDER, dev)
end

function has_exception(dev::HIPDevice)::Bool
    ex = exception_holder(dev)
    ptr = Base.unsafe_convert(Ptr{Int32}, ex.exception_flag)
    unsafe_load(ptr) != 0
end

function get_exception_string(dev::HIPDevice)::String
    ex = exception_holder(dev)
    n_strings = Array(ex.buffers_counter)[1]

    exception_str = ""
    for i in 1:n_strings
        ptr = reinterpret(
            LLVMPtr{Device.ROCPrintfBuffer, AS.Global},
            ex.errprintf_buffers[i].ptr)
        fmt, all_args = unsafe_load(ptr)

        if isempty(all_args)
            exception_str = "$(exception_str)$(fmt)\n"
        else
            format = Printf.Format(fmt)
            @assert length(all_args) == 1
            for args in all_args
                args = map(x -> x isa Cstring ? unsafe_string(x) : x, args)
                str = Printf.format(format, args...)
                exception_str = "$(exception_str)$(str)"
            end
        end
    end
    return exception_str
end

function KernelState(dev::HIPDevice)
    ex = exception_holder(dev)
    KernelState(
        Mem.device_ptr(ex.exception_flag),
        pointer(ex.gate),
        pointer(ex.buffers_counter),
        pointer(ex.str_buffers_counter),

        pointer(ex.errprintf_buffers_dev),
        pointer(ex.string_buffers_dev),
        length(ex.errprintf_buffers_dev),
        length(ex.string_buffers_dev))
end

function f(x)
    x[2] = 0
    nothing
end

function main()
    ex = exception_holder(AMDGPU.device())
    @show ex.buffers_counter
    @show ex.str_buffers_counter
    @show ex.gate

    x = ROCArray{Int32}(undef, 1)
    @roc gridsize=64 groupsize=128 f(x)

    AMDGPU.synchronize()

    @show x

    @show ex.buffers_counter
    @show ex.str_buffers_counter
    @show ex.gate
    return
end

function ooo()
    gridsize = 64
    groupsize = 128

    w = UInt32[]
    for gd in 1:gridsize, gp in 1:groupsize
        x::UInt32 = gp + (gd - 1) * groupsize
        v = Device.morton_code(x, UInt32(1), UInt32(1))
        @show gd, gp, v
        if v in w
            break
        end
        push!(w, v)
    end
    return
end

end
