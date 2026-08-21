module ROCmDiscovery

export lld_artifact, lld_path, libhsaruntime, libdevice_libs, libhip
export librocblas, librocsparse, librocsolver
export librocrand, librocfft, libMIOpen_path
export libhiptensor

using AMDGPU_LLVM_Backend_jll
using LLVMDowngrader_jll
using Preferences
using Scratch
using Libdl

include("utils.jl")

function get_artifact_library(pkg::Symbol, libname::Symbol)::String
    succ, res = safe_exec("import $pkg; println($pkg.$libname)")
    (succ && ispath(res)) || return ""
    return res
end

function get_ld_lld(rocm_path::String)::Tuple{String, Bool}
    lld_path = find_ld_lld(rocm_path)
    isempty(lld_path) || return (lld_path, false)
    AMDGPU_LLVM_Backend_jll.is_available() || return (lld_path, false)
    return (AMDGPU_LLVM_Backend_jll.lld_path, true)
end

# bitcode versions `llvm-downgrade` can target.
# The 15 target emits opaque pointers, but GPUCompiler uses typed pointers on LLVM 15 and 16
# (Julia 1.10 and 1.11), so both use the 14 target instead.
const DOWNGRADE_TARGETS = (v"5", v"7", v"14", #=v"15",=# v"18")

# downgrade the device libs to the latest LLVM version Julia supports
function downgrade_device_libs(src_dir::String)::String
    target = maximum(Iterators.filter(<=(Base.libllvm_version), DOWNGRADE_TARGETS))
    # ensure this is rebuilt if any of the relevant jlls or the target changes
    scratch_name = replace(string(
        "device_libs-", pkgversion(AMDGPU_LLVM_Backend_jll),
        "-", first(basename(AMDGPU_LLVM_Backend_jll.artifact_dir), 8),
        "-downgrader-", pkgversion(LLVMDowngrader_jll),
        "-", first(basename(LLVMDowngrader_jll.artifact_dir), 8),
        "-llvm-", target.major), "+" => "_") # artifact versions include +, which Scratch does not like
    dir = @get_scratch!(scratch_name)
    marker = joinpath(dir, "downgrade_complete")
    isfile(marker) && return dir

    # Use a temp dir, so concurrent processes don't interfere
    mktempdir(dirname(dir)) do tmp
        for file in readdir(src_dir)
            endswith(file, ".bc") || continue
            run(`$(LLVMDowngrader_jll.llvm_downgrade()) --bitcode-version=$(target.major).$(target.minor) -o $(joinpath(tmp, file)) $(joinpath(src_dir, file))`)
        end
        for file in readdir(tmp)
            mv(joinpath(tmp, file), joinpath(dir, file); force=true)
        end
    end
    touch(marker)
    return dir
end

function get_device_libs(from_artifact::Bool; rocm_path::String)
    if from_artifact &&
        AMDGPU_LLVM_Backend_jll.is_available() &&
        isdefined(AMDGPU_LLVM_Backend_jll, :bitcode_path) &&
        LLVMDowngrader_jll.is_available()

        try
            return downgrade_device_libs(AMDGPU_LLVM_Backend_jll.bitcode_path)
        catch err
            @warn """Failed to downgrade artifact device libraries, \
            falling back to system-wide device libraries.
            """ exception=(err, catch_backtrace())
        end
    end
    return find_device_libs(rocm_path)
end

function _hip_runtime_version()
    v_ref = Ref{Cint}()
    res = ccall((:hipRuntimeGetVersion, libhip), UInt32, (Ptr{Cint},), v_ref)
    res > 0 && error("Failed to get HIP runtime version.")

    v = v_ref[]
    major = v ÷ 10_000_000
    minor = (v ÷ 100_000) % 100
    patch = v % 100000
    VersionNumber(major, minor, patch)
end

global rel_libdir::String = Sys.islinux() ? "" : "bin"
global libhsaruntime::String = ""
global lld_path::String = ""
global lld_artifact::Bool = false
global libhip::String = ""
global libdevice_libs::String = ""
global librocblas::String = ""
global librocsparse::String = ""
global librocsolver::String = ""
global librocrand::String = ""
global librocfft::String = ""
global libhiptensor::String = ""
global libMIOpen_path::String = ""

function __init__()

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

    rocm_path = find_roc_path()
    lib_prefix = Sys.islinux() ? "lib" : ""

    try
        global libhsaruntime = Sys.islinux() ?
            find_rocm_library("libhsa-runtime64"; rocm_path, ext="so.1") :
            ""

        # Linker.
        lld_path, lld_artifact = get_ld_lld(rocm_path)
        global lld_path = lld_path
        global lld_artifact = lld_artifact
        global libhip = find_rocm_library(Sys.islinux() ? "libamdhip64" : "amdhip64"; rocm_path)

        # Always load artifact device libraries.
        from_artifact = true
        global libdevice_libs = get_device_libs(from_artifact; rocm_path)

        # HIP-based libraries.
        global librocblas = find_rocm_library(lib_prefix * "rocblas"; rocm_path)
        global librocsparse = find_rocm_library(lib_prefix * "rocsparse"; rocm_path)
        global librocsolver = find_rocm_library(lib_prefix * "rocsolver"; rocm_path)
        global librocrand = find_rocm_library(lib_prefix * "rocrand"; rocm_path)
        global librocfft = find_rocm_library(lib_prefix * "rocfft"; rocm_path)
        global libhiptensor = find_rocm_library(lib_prefix * "hiptensor"; rocm_path)
        global libMIOpen_path = find_rocm_library(lib_prefix * "MIOpen"; rocm_path)
    catch err
        @error """ROCm discovery failed!
        Discovered ROCm path: $rocm_path.
        Use `ROCM_PATH` env variable to specify ROCm directory.

        """ exception=(err, catch_backtrace())
    end
end

end
