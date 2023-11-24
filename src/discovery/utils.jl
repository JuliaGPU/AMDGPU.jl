function detect_projects()
    amdgpu_project = normpath(joinpath(@__DIR__, "..", ".."))
    current_project = Base.ACTIVE_PROJECT[]
    julia_project = if Base.JLOptions().project != C_NULL
        unsafe_string(Base.JLOptions().project)
    elseif current_project !== nothing
        current_project
    else
        amdgpu_project
    end
    return (;amdgpu_project, current_project, julia_project)
end

julia_exeflags(projects = detect_projects()) = String[
    "--startup-file=no",
    "--project=$(projects.julia_project)",
    "--threads=$(Threads.nthreads())"]

function julia_cmd_projects(jl_str)
    projects = detect_projects()

    cmd = Base.julia_cmd()
    append!(cmd.exec, julia_exeflags(projects))

    (;amdgpu_project, current_project, julia_project) = projects

    if current_project !== nothing
    current_project = replace(current_project, "\\" => "/")
        jl_str = "push!(LOAD_PATH, \"$current_project\");" * jl_str
    else
        # If Julia is using global project, instantiate `julia_project`.
        # Otherwise, we'll fail to discover artifacts.
        jl_str = "import Pkg; Pkg.instantiate(;io=devnull); " * jl_str
    end
    amdgpu_project = replace(amdgpu_project, "\\" => "/")
    jl_str = "push!(LOAD_PATH, \"$amdgpu_project\");" * jl_str
    append!(cmd.exec, ("-e", jl_str))
    return cmd
end

function safe_exec(str)
    cmd = julia_cmd_projects(str)
    success = false
    error_str = mktemp() do path, _
        p = run(pipeline(cmd; stdout=path, stderr=path); wait=false)
        wait(p)
        success = p.exitcode == 0
        strip(String(read(path)))
    end
    return success, error_str
end

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

function find_device_libs(rocm_path::String)
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

function find_rocm_library(libs::Vector, rocm_path::String, ext::String = dlext)
    for lib in libs
        path = find_rocm_library(lib, rocm_path, ext)
        isempty(path) || return path
    end
    return ""
end

function find_rocm_library(lib::String, rocm_path::String, ext::String = dlext)
    path = Libdl.find_library(lib)
    isempty(path) || return Libdl.dlpath(path)

    libdir = joinpath(rocm_path, Sys.islinux() ? "lib" : "bin")
    if isdir(libdir)
        files = readdir(libdir)
        for file in files
            matched = startswith(basename(file), lib * ".$ext")
            matched && return joinpath(libdir, file)
        end
    end
    return ""
end

function find_ld_lld(rocm_path::String)
    lld_name = "ld.lld" * (Sys.iswindows() ? ".exe" : "")
    for subdir in (joinpath("llvm", "bin"), "bin")
        exp_ld_path = joinpath(rocm_path, subdir, lld_name)
        if ispath(exp_ld_path)
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
                @debug "bindeps: Failed running ld.lld in $exp_ld_path"
            end
        end
    end
    return ""
end
