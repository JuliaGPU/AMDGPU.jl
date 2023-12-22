module ROCmDiscovery

using ROCmDeviceLibs_jll
using Preferences
using Libdl

include("utils.jl")

"""
    use_artifacts!(flag::Bool = true)

Pass `true` to switch from system-wide ROCm installtion to artifacts.
When using artifacts, system-wide installation is not needed at all.
"""
function use_artifacts!(flag::Bool = true; show_message::Bool = true)
    if flag && Base.libllvm_version >= v"16"
        error("No supported artifacts for LLVM 16+. See: https://github.com/JuliaGPU/AMDGPU.jl/issues/440.")
    end
    @set_preferences!("use_artifacts" => flag)
    if show_message
        @info """
        Switched `use_artifacts` to `$flag`.
        Restart Julia session for the changes to take effect.
        """
    end
end

use_artifacts()::Bool = @load_preference("use_artifacts", false)

@static if use_artifacts()
    import hsa_rocr_jll
end

if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
    disable_artifacts = parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "true"))
    if !disable_artifacts && Base.libllvm_version >= v"16"
        error("No supported artifacts for LLVM 16+. See: https://github.com/JuliaGPU/AMDGPU.jl/issues/440.")
    end
    use_artifacts!(!disable_artifacts; show_message=false)
end

function get_artifact_library(pkg::Symbol, libname::Symbol)::String
    succ, res = safe_exec("import $pkg; println($pkg.$libname)")
    (succ && ispath(res)) || return ""
    return res
end

function get_library(
    libname::String; rocm_path::String,
    artifact_library::Symbol, artifact_field::Union{Nothing, Symbol} = nothing,
    ext::String = dlext,
)
    if use_artifacts()
        artifact_field = artifact_field ≡ nothing ? Symbol(libname) : artifact_field
        get_artifact_library(artifact_library, artifact_field)
    else
        find_rocm_library(libname, rocm_path, ext)
    end
end

function get_ld_lld(rocm_path::String;
    from_artifact::Bool, artifact_library::Symbol, artifact_field::Symbol,
)
    if from_artifact
        get_artifact_library(artifact_library, artifact_field)
    else
        find_ld_lld(rocm_path)
    end
end

function get_device_libs(from_artifact::Bool; rocm_path::String)
    if from_artifact && ROCmDeviceLibs_jll.is_available()
        ROCmDeviceLibs_jll.bitcode_path
    else
        find_device_libs(rocm_path)
    end
end

export use_artifacts, use_artifacts!
export lld_artifact, lld_path, libhsaruntime, libdevice_libs, libhip
export librocblas, librocsparse, librocsolver, librocalution
export librocrand, librocfft, libMIOpen_path
export julia_exeflags

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

function __init__()
    ENV["AMD_LOG_LEVEL"] = 4

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

    rocm_path = use_artifacts() ? "" : find_roc_path()
    lib_prefix = Sys.islinux() ? "lib" : ""

    try
        global libhsaruntime = if Sys.islinux()
            get_library("libhsa-runtime64";
                    rocm_path, artifact_library=:hsa_rocr_jll,
                    artifact_field=:libhsa_runtime64, ext="so.1")
        else
            ""
        end

        # Linker.
        lld_path = get_ld_lld(rocm_path; from_artifact=false,
            artifact_library=:LLD_jll, artifact_field=:lld_path)
        lld_artifact = false
        if isempty(lld_path)
            lld_path = get_ld_lld(rocm_path; from_artifact=true,
                artifact_library=:LLD_jll, artifact_field=:lld_path)
            lld_artifact = true
        end
        global lld_path = lld_path
        global lld_artifact = lld_artifact

        # HIP.
        global libhip = get_library(
            Sys.islinux() ? "libamdhip64" : "amdhip64";
            rocm_path, artifact_library=:HIP_jll)

        from_artifact = if isempty(libhip)
            use_artifacts()
        else
            # Detect HIP version, which will influence what device libraries to use.
            hip_version = Base.thisminor(_hip_runtime_version())
            hip_version > v"5.4" ? true : use_artifacts()
        end
        # If ROCm 5.5+ - use artifact device libraries.
        global libdevice_libs = get_device_libs(from_artifact; rocm_path)

        # HIP-based libraries.
        global librocblas = get_library(lib_prefix * "rocblas";
            rocm_path, artifact_library=:rocBLAS_jll)
        global librocsparse = get_library(lib_prefix * "rocsparse";
            rocm_path, artifact_library=:rocSPARSE_jll)
        global librocsolver = get_library(lib_prefix * "rocsolver";
            rocm_path, artifact_library=:rocSOLVER_jll)
        global librocalution = get_library(lib_prefix * "rocalution";
            rocm_path, artifact_library=:rocALUTION_jll)
        global librocrand = get_library(lib_prefix * "rocrand";
            rocm_path, artifact_library=:rocRAND_jll)
        global librocfft = get_library(lib_prefix * "rocfft";
            rocm_path, artifact_library=:rocFFT_jll)
        global libMIOpen_path = get_library(lib_prefix * "MIOpen";
            rocm_path, artifact_library=:MIOpen_jll)
    catch err
        @error """ROCm discovery failed!
        Discovered ROCm path: $rocm_path.
        Use `ROCM_PATH` env variable to specify ROCm directory.

        """ exception=(err, catch_backtrace())
    end
end

end
