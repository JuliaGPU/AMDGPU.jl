module AMDGPU

using Adapt
using BFloat16s
using CEnum
using GPUCompiler
using GPUArrays
using GPUArrays: allowscalar
using Libdl
using LLVM
using Preferences
using Printf

import KernelInterface
import UnsafeAtomics
import Atomix
import Atomix: @atomic, @atomicswap, @atomicreplace
import Core: LLVMPtr
import LinearAlgebra
import PrettyTables


# Julia has several notions of `sizeof`
# - Base.sizeof is the size of an object in memory
# - Base.aligned_sizeof is the size of an object in an array/inline alloced
# Both of them are equivalent for immutable objects, but differ for mutable singtons and Symbol
# We use `aligned_sizeof` since we care about the size of a type in an array
@static if VERSION < v"1.11.0"
   @generated function aligned_sizeof(::Type{T}) where T
        return :($(Base.aligned_sizeof(T)))
   end
else
    import Base: aligned_sizeof
end

const Maybe{T} = Union{Nothing, T}

"""
If `true`, then synchronizes immediately after every Julia kernel launch
(launched by `@roc` macro).
Meant to be used together with `HIP_LAUNCH_BLOCKING=1`.
"""
const LAUNCH_BLOCKING::Ref{Bool} = Ref{Bool}(false)

export @roc, roc, rocconvert
export HIPDevice, has_rocm_gpu
export ROCArray, ROCVector, ROCMatrix, ROCVecOrMat, ROCRef
export DenseROCArray, DenseROCVector, DenseROCMatrix, DenseROCVecOrMat,
       StridedROCArray, StridedROCVector, StridedROCMatrix, StridedROCVecOrMat,
       AnyROCArray, AnyROCVector, AnyROCMatrix, AnyROCVecOrMat

struct LockedObject{T}
    lock::ReentrantLock
    payload::T
end
LockedObject(payload) = LockedObject(ReentrantLock(), payload)

# Load binary dependencies.
include("libs.jl")
include("system_scope_fences.jl")

include("utils.jl")

include("hsa/HSA.jl")
include("hip/HIP.jl")

using .HIP
using .HIP: HIPContext, HIPDevice, HIPStream
export HIPContext, HIPDevice, HIPStream

include("cache.jl")

include("runtime/Runtime.jl")
import .Runtime
import .Runtime: Mem, ROCDim, ROCDim3

include("memory.jl")

Base.Experimental.@MethodTable(method_table)

# Needs to be before Device since sync uses this. GPUCompiler emits `device` as LLVM's
# `agent`, and `subgroup` as `wavefront`.
const syncscope_agent = UnsafeAtomics.device
const syncscope_workgroup = UnsafeAtomics.workgroup
const syncscope_wavefront = UnsafeAtomics.subgroup

# Referenced by the generated `kernel_state()`, and generators run in the world they are
# defined in, so this has to precede the device code.
struct KernelState
    exception_info::Ptr{UInt64}
    # the handle of the launched kernel, which identifies it in the exception info
    kernel::Ptr{Cvoid}
    malloc_hc::Ptr{Cvoid}
    free_hc::Ptr{Cvoid}
    output_context::Ptr{Cvoid}
    printf_output_context::Ptr{Cvoid}
end

# Device sources must load _before_ the compiler infrastructure,
# because of generated functions.
include("device/Device.jl")
import .Device: malloc, exception_site, report_oom
import .Device: ROCDeviceArray, AS, HostCall, HostCallHolder, hostcall!
import .Device: @ROCDynamicLocalArray, @ROCStaticLocalArray
import .Device: workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
import .Device: threadIdx, blockIdx, blockDim
import .Device: sync_workgroup, sync_wavefront, sync_workgroup_count, sync_workgroup_and, sync_workgroup_or
import .Device: @rocprint, @rocprintln, @rocprintf

export ROCDeviceArray, @ROCDynamicLocalArray, @ROCStaticLocalArray
export @rocprint, @rocprintln, @rocprintf
export workitemIdx, workgroupIdx, workgroupDim, gridItemDim, gridGroupDim
export sync_workgroup, sync_workgroup_count, sync_workgroup_and, sync_workgroup_or

include("compiler/Compiler.jl")
import .Compiler
import .Compiler: hipfunction, compiler_config

include("tls.jl")
include("highlevel.jl")
include("reflection.jl")
include("array.jl")
include("conversions.jl")
include("refpointer.jl")
include("broadcast.jl")
include("exception_handler.jl")

include("blas/rocBLAS.jl")
include("solver/rocSOLVER.jl")
include("sparse/rocSPARSE.jl")
include("tensor/hipTENSOR.jl")
include("rand/rocRAND.jl")
include("fft/rocFFT.jl")
include("dnn/MIOpen.jl")

include("random.jl")

# KernelInterface
include("ROCKernels.jl")
import .ROCKernels: ROCBackend
export ROCBackend

include("precompile.jl")

# Another ROCm in the environment keeps HIP from starting or breaks compilation far from
# the cause, so name it up front. Returns whether foreign ROCm libraries are loaded.
function warn_foreign_rocm(; quiet::Bool = false)
    local_rocm && return false

    redirects = ROCm_Runtime.redirect_env()
    isempty(redirects) || quiet || @warn """These variables point at another ROCm's device \
        libraries, which take precedence over the artifact's. Compilation may fail or \
        give wrong results, often reported as an unrelated error. Unset them, or use \
        that ROCm with `AMDGPU.set_rocm_version!(; local_rocm=true)`.""" redirects

    foreign = ROCm_Runtime.foreign_libraries()
    isempty(foreign) && return false
    quiet && return true
    # a tool library loaded by the HSA runtime brings its own ROCm along
    tools = isempty(get(ENV, "HSA_TOOLS_LIB", "")) ? "" : " or HSA_TOOLS_LIB"
    @warn """Libraries of another ROCm are loaded next to the artifact's. HIP may fail to \
        start, and compilation may fail or give wrong results, often reported as an \
        unrelated error. The usual cause is LD_LIBRARY_PATH$tools pointing at that ROCm \
        (a module, a uenv, a container), to be unset before Julia starts. Otherwise, use \
        that ROCm with `AMDGPU.set_rocm_version!(; local_rocm=true)`.
        $(join(("  " * path for path in foreign), "\n"))"""
    return true
end

# Start the HIP runtime (by enumerating the devices) and return whether that worked.
# A failure flags HIP as not functional (see `functional`) instead of failing the load,
# which would put `versioninfo()` out of reach and break precompiling dependents.
function init_hip!(enumerate_devices = HIP.devices)
    failure = try
        enumerate_devices()
        nothing
    catch err
        err
    end
    failure === nothing || (HIP_INIT_ERROR[] = sprint(showerror, failure))

    # precompilation workers stay quiet: the session loading the dependent reports
    quiet = ccall(:jl_generating_output, Cint, ()) != 0
    # after the start attempt, failed or not: this reports what HIP pulled in
    foreign = warn_foreign_rocm(; quiet)
    failure === nothing && return true
    quiet && return false

    msg = "HIP could not be initialized: GPU functionality is disabled " *
        "(`AMDGPU.functional()` returns `false`)."
    if failure isa HIP.HIPError && failure.code == HIP.hipErrorNoDevice
        msg *= " HIP reports any failed start as \"no device found\"."
    end
    if foreign
        msg *= " The other ROCm reported above is the likely cause."
    else
        msg *= " Check that the GPUs are visible to this process (ROCR_VISIBLE_DEVICES, " *
            "HIP_VISIBLE_DEVICES" *
            (Sys.islinux() ? ", access to /dev/kfd and /dev/dri/renderD*" : "") * ")."
    end
    msg *= " Start Julia with AMD_LOG_LEVEL=3 for HIP's own log."
    @warn msg exception=failure
    return false
end

function __init__()
    force_emulated = parse(Bool, get(ENV, "JULIA_AMDGPU_FORCE_EMULATED_SIGNALS", "0"))
    Device.EMULATED_SIGNALS[] = force_emulated || isempty(libhsa_runtime64)

    # Used to shutdown hostcalls if any is running.
    atexit(() -> begin Runtime.RT_EXITING[] = true end)

    if Sys.islinux() && isdir("/sys/class/kfd/kfd/topology/nodes/")
        for node_id in readdir("/sys/class/kfd/kfd/topology/nodes/")
            node_name = readchomp(joinpath("/sys/class/kfd/kfd/topology/nodes/", node_id, "name"))
            # CPU nodes don't have names.
            isempty(node_name) && continue

            if node_name == "navy_flounder"
                ENV["HSA_OVERRIDE_GFX_VERSION"] = "10.3.0"
                break
            end
        end
    end

    # before HIP initializes, which reads `AMD_OPT_FLUSH` once
    configure_system_scope_fences!(visible_gpus(kfd_gpu_nodes()))

    if haskey(ENV, "HIP_LAUNCH_BLOCKING")
        launch_blocking = parse(Bool, ENV["HIP_LAUNCH_BLOCKING"])
        LAUNCH_BLOCKING[] = launch_blocking
        if launch_blocking
            @info "`HIP_LAUNCH_BLOCKING` is set to `true`. " *
                "Synchronizing immediately after every Julia & HIP kernel launch."
        end
    end

    # ROCm only exists for Linux and Windows: stay quiet elsewhere.
    if !Sys.islinux() && !Sys.iswindows()
        @debug "ROCm does not support this platform, skipping initialization"
        return
    end

    # Only worth reporting where a GPU is actually present: without GPU, not
    # resolving an artifact is the expected outcome rather than a problem.
    if !local_rocm && !ROCm_Runtime.is_available() &&
            (!Sys.islinux() || ispath("/dev/kfd"))
        warn_unresolved_rocm_artifact()
    end

    # Device libraries are needed for compiling device code even without a GPU.
    global libdevice_libs = find_device_libs()

    if Sys.islinux()
        if !ispath("/dev/kfd")
            @debug "/dev/kfd not available (no AMD GPU), skipping initialization"
            return
        end

        if !isempty(libhsa_runtime64)
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
            error("Failed to find the kernel linker, but it must exist, bailing out")
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
        if !init_hip!() && parse(Bool, get(ENV, "JULIA_AMDGPU_HIP_MUST_LOAD", "0"))
            Sys.islinux() && print_build_diagnostics()
            error("Failed to initialize the HIP runtime, but HIP must load, bailing out")
        end
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
