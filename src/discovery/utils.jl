"""
Find root ROCm directory.
"""
function find_roc_path()::String
    env_dir = get(ENV, "ROCM_PATH", "")
    isdir(env_dir) && return env_dir

    if Sys.islinux()
        isdir("/opt/rocm") && return "/opt/rocm" # shim for Ubuntu rocm packages.
    elseif Sys.iswindows()
        disk_dir = dirname(dirname(homedir())) # Disk C root directory.
        rocm_dir = joinpath(disk_dir, "Program Files", "AMD", "ROCm")
        if isdir(rocm_dir)
            version_dirs = readdir(rocm_dir; join=true)
            if length(version_dirs) > 1
                @warn """
                Multiple ROCm versions detected, selecting first.
                Use `ROCM_PATH` env variable to specify exact ROCm directory.
                """
            end
            return first(version_dirs)
        end
    end
    return ""
end

function find_device_libs(rocm_path::String)::String
    env_dir = get(ENV, "ROCM_PATH", "")
    if isdir(env_dir)
        path = joinpath(env_dir, "amdgcn", "bitcode")
        isdir(path) && return path
    end

    # Might be set by tools like Spack or the user
    hip_devlibs_path = get(ENV, "HIP_DEVICE_LIB_PATH", "")
    hip_devlibs_path !== "" && return hip_devlibs_path
    devlibs_path = get(ENV, "DEVICE_LIB_PATH", "")
    devlibs_path !== "" && return devlibs_path

    # Try the canonical location.
    canonical_dir = joinpath(rocm_path, "amdgcn", "bitcode")
    isdir(canonical_dir) && return canonical_dir
    return ""
end

function find_rocm_library(libs::Vector; rocm_path::String, ext::String = dlext)::String
    for lib in libs
        path = find_rocm_library(lib, rocm_path, ext)
        isempty(path) || return path
    end
    return ""
end

function find_rocm_library(lib::String; rocm_path::String, ext::String = dlext)::String
    libdir = joinpath(rocm_path, Sys.islinux() ? "lib" : "bin")
    isdir(libdir) || return ""

    for file in readdir(libdir; join=true)
        fname = basename(file)
        matched = startswith(fname, lib) && endswith(fname, ext)
        matched && return file
    end
    return ""
end

function find_ld_lld(rocm_path::String)::String
    lld_name = "ld.lld" * (Sys.iswindows() ? ".exe" : "")
    for subdir in (joinpath("llvm", "bin"), "bin")
        exp_ld_path = joinpath(rocm_path, subdir, lld_name)
        ispath(exp_ld_path) || continue
        try
            tmpfile = tempname(;cleanup=false)
            run(pipeline(`$exp_ld_path -v`; stdout=tmpfile))
            vstr = read(tmpfile, String)
            rm(tmpfile)
            vstr = replace(vstr, "AMD " => "")
            vstr_splits = split(vstr, ' ')
            if VersionNumber(vstr_splits[2]) >= v"6.0.0"
                return exp_ld_path
            end
        catch
            @warn "bindeps: Failed running ld.lld in $exp_ld_path"
        end
    end
    return ""
end
