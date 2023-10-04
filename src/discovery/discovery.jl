module ROCmDiscovery

using Preferences
using Libdl

include("utils.jl")

"""
    enable_artifacts!(flag::Bool = true)

Pass `true` to switch from system-wide ROCm installtion to artifacts.
When using artifacts, system-wide installation is not needed at all.
"""
function enable_artifacts!(flag::Bool = true; show_message::Bool = true)
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

"""
    use_devlibs_jll!(flag::Bool = true)

Pass `true` to use device libraries from artifacts and
the rest of the libraries from system-wide ROCm installation (mixed-mode).

This allows using ROCm 5.5+ which internally use LLVM 16+, but
device libraries from artifacts are built with LLVM 15 which makes them
compatible with Julia.
"""
function use_devlibs_jll!(flag::Bool = true)
    @set_preferences!("use_devlibs_jll" => flag)
    @info """
    Switched `use_devlibs_jll` to `$flag`.
    Restart Julia session for the changes to take effect.
    """
end

use_devlibs_jll()::Bool = @load_preference("use_devlibs_jll", false)

if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
    disable_artifacts = parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "true"))
    if !disable_artifacts && Base.libllvm_version >= v"16"
        error("No supported artifacts for LLVM 16+. See: https://github.com/JuliaGPU/AMDGPU.jl/issues/440.")
    end
    enable_artifacts!(!disable_artifacts; show_message=false)
end

function get_artifact_library(pkg::Symbol, libname::Symbol)::String
    succ, res = safe_exec("import $pkg; println($pkg.$libname)")
    (succ && ispath(res)) || return ""
    return res
end

function get_library(
    libname::String; rocm_paths::Vector{String},
    artifact_library::Symbol, artifact_field::Union{Nothing, Symbol} = nothing,
    ext::String = dlext,
)
    if use_artifacts()
        artifact_field = artifact_field ≡ nothing ? Symbol(libname) : artifact_field
        get_artifact_library(artifact_library, artifact_field)
    else
        find_rocm_library(libname, rocm_paths, ext)
    end
end

function get_ld_lld(;
    from_artifact::Bool, artifact_library::Symbol, artifact_field::Symbol,
)
    if from_artifact || Sys.iswindows() # TODO temprorary fix for Windows
        get_artifact_library(artifact_library, artifact_field)
    else
        find_ld_lld()
    end
end

function get_device_libs(;
    artifact_library::Symbol = :ROCmDeviceLibs_jll,
    artifact_field::Symbol = :bitcode_path,
)
    if use_artifacts() || use_devlibs_jll()
        get_artifact_library(artifact_library, artifact_field)
    else
        find_device_libs()
    end
end

export use_artifacts, enable_artifacts!, use_devlibs_jll, use_devlibs_jll!
export lld_artifact, lld_path, libhsaruntime, libdevice_libs, libhip
export librocblas, librocsparse, librocsolver, librocalution
export librocrand, librocfft, libMIOpen_path
export julia_exeflags

function __init__()
    rocm_paths = use_artifacts() ? String[] : find_roc_paths()

    try
        # Core.
        lld_path = get_ld_lld(; from_artifact=false,
            artifact_library=:LLD_jll, artifact_field=:lld_path)
        lld_artifact = false
        if isempty(lld_path)
            lld_path = get_ld_lld(; from_artifact=true,
                artifact_library=:LLD_jll, artifact_field=:lld_path)
            lld_artifact = true
        end
        global lld_path = lld_path
        global lld_artifact = lld_artifact

        global libhsaruntime = get_library("libhsa-runtime64";
            rocm_paths, artifact_library=:hsa_rocr_jll,
            artifact_field=:libhsa_runtime64, ext="so.1")
        global libdevice_libs = get_device_libs()

        # HIP.
        global libhip = get_library("libamdhip64";
            rocm_paths, artifact_library=:HIP_jll)
        # HIP-based libraries.
        global librocblas = get_library("librocblas";
            rocm_paths, artifact_library=:rocBLAS_jll)
        global librocsparse = get_library("librocsparse";
            rocm_paths, artifact_library=:rocSPARSE_jll)
        global librocsolver = get_library("librocsolver";
            rocm_paths, artifact_library=:rocSOLVER_jll)
        global librocalution = get_library("librocalution";
            rocm_paths, artifact_library=:rocALUTION_jll)
        global librocrand = get_library("librocrand";
            rocm_paths, artifact_library=:rocRAND_jll)
        global librocfft = get_library("librocfft";
            rocm_paths, artifact_library=:rocFFT_jll)
        global libMIOpen_path = get_library("libMIOpen";
            rocm_paths, artifact_library=:MIOpen_jll)
    catch err
        @error "ROCm discovery failed!" exception=(err, catch_backtrace())
    end
end

end
