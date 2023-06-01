const rocm_ext_libs = [
    (:rocblas, :rocBLAS_jll),
    (:rocsparse, :rocSPARSE_jll),
    (:rocsolver, nothing),
    (:rocalution, nothing),
    (:rocrand, :rocRAND_jll),
    (:rocfft, nothing),
    (:MIOpen, :MIOpen_jll)]

function enable_artifacts!(flag::Bool = true; show_message::Bool = true)
    @set_preferences!("use_artifacts" => flag)
    if show_message
        @info """
        Switched `use_artifacts` to `$flag`.
        Restart Julia session for the changes to take effect.
        """
    end
end

use_artifacts()::Bool = @load_preference("use_artifacts", true)

if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
    disable_artifacts = parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "false"))
    enable_artifacts!(!disable_artifacts; show_message=false)
end

function find_artifact_library!(config, pkg; name::Symbol, lib::Symbol)
    if pkg !== nothing
        loaded, available, error_str = safe_import(pkg)
        if loaded
            if available
                config[Symbol(:lib, name)] = getfield(@eval($pkg), lib)
                config[Symbol(name, :_configured)] = true
            else
                config[Symbol(name, :_build_reason)] = "`$pkg` is not available on this platform."
            end
        else
            iob = IOBuffer()
            println(iob, "`import $pkg` failed:")
            print(iob, error_str)
            config[Symbol(name, :_build_reason)] = String(take!(iob))
        end
    end
end

function find_system_library!(
    config, name::Symbol; lib, dirs = find_roc_paths(), ext = dlext,
)
    lib_path = find_rocm_library(lib, dirs, ext)
    if !isempty(something(lib_path, ""))
        loaded, error_str = safe_exec("using Libdl; dlopen(\"$lib_path\")")
        if loaded
            config[Symbol(:lib, name)] = lib_path
            config[Symbol(name, :_configured)] = true
        else
            iob = IOBuffer()
            println(iob, "Loading `$lib_path` failed:")
            print(iob, error_str)
            config[Symbol(name, :_build_reason)] = String(take!(iob))
        end
    else
        config[Symbol(name, :_build_reason)] = "Could not find `$lib` libraries."
    end
end

function find_hsa_runtime!(config)
    if use_artifacts()
        loaded, available, error_str = safe_import(:hsa_rocr_jll)
        if loaded
            if available
                config[:libhsaruntime_path] = hsa_rocr_jll.libhsa_runtime64
                config[:hsa_configured] = true
            else
                config[:hsa_build_reason] = "hsa_rocr_jll is not available on this platform."
            end
        else
            iob = IOBuffer()
            println(iob, "`import hsa_rocr_jll` failed:")
            print(iob, error_str)
            config[:hsa_build_reason] = String(take!(iob))
        end
    else
        roc_dirs = find_roc_paths()
        libhsaruntime_path = find_rocm_library("libhsa-runtime64", roc_dirs, "so.1")
        if !isempty(something(libhsaruntime_path, ""))
            loaded, error_str = safe_exec("using Libdl; dlopen(\"$libhsaruntime_path\")")
            if loaded
                config[:libhsaruntime_path] = libhsaruntime_path
                config[:hsa_configured] = true
            else
                iob = IOBuffer()
                println(iob, "Loading `libhsa-runtime64` v1 failed:")
                print(iob, error_str)
                config[:hsa_build_reason] = String(take!(iob))
            end
        else
            config[:hsa_build_reason] = "Could not find `libhsa-runtime64` v1 library"
        end
    end
end

function find_ld_lld!(config)
    if use_artifacts()
        loaded, available, error_str = safe_import(:LLD_jll)
        if loaded
            if available
                if isdefined(LLD_jll, :lld_path)
                    config[:lld_path] = LLD_jll.lld_path
                    config[:lld_artifact] = true
                    config[:lld_configured] = true
                else
                    config[:lld_build_reason] = "LLD_jll does not export `lld_path`"
                end
            else
                config[:lld_build_reason] = "LLD_jll is not available on this platform"
            end
        else
            iob = IOBuffer()
            println(iob, "`import LLD_jll` failed:")
            print(iob, error_str)
            config[:lld_build_reason] = String(take!(iob))
        end
    else
        lld_path = find_ld_lld()
        if !isempty(something(lld_path, ""))
            # TODO: Validate ld.lld can compile programs
            config[:lld_path] = lld_path
            config[:lld_configured] = true
        else
            config[:lld_build_reason] = "Could not find `ld.lld` executable"
        end
    end
end

function find_device_libs!(config)
    if use_artifacts()
        find_artifact_library!(
            config, :ROCmDeviceLibs_jll;
            name=:device_libs, lib=:bitcode_path)
    else
        device_libs_path = find_device_libs()
        if !isempty(something(device_libs_path, ""))
            # TODO: Validate bitcode files
            config[:libdevice_libs] = device_libs_path
            config[:device_libs_configured] = true
        else
            config[:device_libs_build_reason] = "Couldn't find bitcode files"
        end
    end
end

function find_hip!(config)
    if use_artifacts()
        find_artifact_library!(config, :HIP_jll; name=:hip, lib=:libamdhip64)
    else
        find_system_library!(config, :hip; lib=["libamdhip64", "libhip_hcc"])
    end
end

function find_hip_based_libs!(config, rocm_ext_libs)
    @sync for (name, pkg) in rocm_ext_libs
        @async begin
            lib = Symbol(:lib, string(name))
            if use_artifacts()
                find_artifact_library!(config, pkg; name, lib)
            else
                find_system_library!(config, name; lib=string(lib))
            end
        end
    end
end

function bindeps_setup()
    config = Dict{Symbol, Any}(
        :configured => false,
        :build_reason => "unknown",

        :lld_configured => false,
        :lld_build_reason => "unknown",
        :lld_artifact => false,

        :hsa_configured => false,
        :hsa_build_reason => "unknown",

        :hip_configured => false,
        :hip_build_reason => "unknown",

        :device_libs_configured => false,
        :device_libs_build_reason => "unknown")

    for (name, _) in rocm_ext_libs
        lib = Symbol(:lib, string(name))
        config[lib] = nothing
        config[Symbol(name, :_configured)] = false
        config[Symbol(name, :_build_reason)] = "unknown"
    end

    if !Sys.islinux()
        @warn "AMDGPU.jl only supports Linux OS."
        config[:build_reason] = "Unsupported OS: $(repr(Sys.KERNEL))"
        return config
    end
    if !ispath("/dev/kfd")
        @warn "/dev/kfd is not available. Cannot use ROCm Runtime."
    end

    find_hsa_runtime!(config)
    config[:hsa_configured] || return config

    find_ld_lld!(config)
    config[:lld_configured] || return config

    find_device_libs!(config)
    config[:device_libs_configured] || return config

    find_hip!(config)
    if config[:hip_configured]
        find_hip_based_libs!(config, rocm_ext_libs)
    end
    config[:configured] = true
    return config
end
