module ROCmDiscovery

export lld_artifact, lld_path, libhsaruntime, libdevice_libs, libhip
export librocblas, librocsparse, librocsolver
export librocrand, librocfft, libMIOpen_path, librocprofiler64v2

using LLD_jll
using ROCmDeviceLibs_jll
using Preferences
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
    LLD_jll.is_available() || return (lld_path, false)
    return (LLD_jll.lld_path, true)
end

function get_device_libs(from_artifact::Bool; rocm_path::String)
    if from_artifact && ROCmDeviceLibs_jll.is_available()
        ROCmDeviceLibs_jll.bitcode_path
    else
        find_device_libs(rocm_path)
    end
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

global rel_libdir::String = ""
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
        global libMIOpen_path = find_rocm_library(lib_prefix * "MIOpen"; rocm_path)
        global librocprofiler64v2 = find_rocm_library(lib_prefix * "rocprofiler64v2"; rocm_path)
    catch err
        @error """ROCm discovery failed!
        Discovered ROCm path: $rocm_path.
        Use `ROCM_PATH` env variable to specify ROCm directory.

        """ exception=(err, catch_backtrace())
    end
end

end
