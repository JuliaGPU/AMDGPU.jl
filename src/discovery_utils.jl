function detect_projects()
    amdgpu_project = normpath(joinpath(@__DIR__, ".."))
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

julia_exeflags(projects = detect_projects()) =
    String["--startup-file=no", "--project=$(projects.julia_project)"]

function julia_cmd_projects(jl_str)
    projects = detect_projects()

    cmd = Base.julia_cmd()
    append!(cmd.exec, julia_exeflags(projects))

    (;amdgpu_project, current_project, julia_project) = projects
    if current_project !== nothing
        jl_str = "push!(LOAD_PATH, \"$current_project\");" * jl_str
    end
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
        String(read(path))
    end
    return success, error_str
end

function safe_import(pkg)
    loaded, error_str = safe_exec("import $pkg")
    loaded || return loaded, false, error_str

    @eval import $pkg
    available = @eval(isdefined($pkg, :is_available)) && @eval($pkg.is_available())
    return loaded, available, error_str
end

function find_rocm_library(lib, dirs, ext=dlext)
    path = Libdl.find_library(lib)
    if path != ""
        return Libdl.dlpath(path)
    end
    for dir in dirs
        files = readdir(dir)
        for file in files
            matched = startswith(basename(file), lib*".$ext")
            if matched
                return joinpath(dir, file)
            end
        end
    end
    return ""
end

function find_roc_paths()
    paths = split(get(ENV, "LD_LIBRARY_PATH", ""), ":")
    paths = filter(path -> path != "", paths)
    paths = map(Base.Filesystem.abspath, paths)
    push!(paths, "/opt/rocm/lib") # shim for Ubuntu rocm packages...
    if haskey(ENV, "ROCM_PATH")
        push!(paths, joinpath(ENV["ROCM_PATH"], "lib"))
    end
    return filter(isdir, paths)
end

function find_rocm_library(libs::Vector, dirs)
    for lib in libs
        path = find_rocm_library(lib, dirs)
        if path != ""
            return path
        end
    end
    return ""
end

function find_ld_lld()
    paths = split(get(ENV, "PATH", ""), ":")
    paths = filter(path -> path != "", paths)
    paths = map(Base.Filesystem.abspath, paths)
    basedir = get(ENV, "ROCM_PATH", "/opt/rocm")
    ispath(joinpath(basedir, "llvm/bin/ld.lld")) &&
        push!(paths, joinpath(basedir, "llvm/bin/"))
    ispath(joinpath(basedir, "hcc/bin/ld.lld")) &&
        push!(paths, joinpath(basedir, "/hcc/bin/"))
    ispath(joinpath(basedir, "opencl/bin/x86_64/ld.lld")) &&
        push!(paths, joinpath(basedir, "opencl/bin/x86_64/"))
    for path in paths
        exp_ld_path = joinpath(path, "ld.lld")
        if ispath(exp_ld_path)
            try
                tmpfile = mktemp()
                run(pipeline(`$exp_ld_path -v`; stdout=tmpfile[1]))
                vstr = read(tmpfile[1], String)
                rm(tmpfile[1])
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

function find_device_libs()
    # Might be set by tools like Spack or the user
    hip_devlibs_path = get(ENV, "HIP_DEVICE_LIB_PATH", "")
    hip_devlibs_path !== "" && return hip_devlibs_path
    devlibs_path = get(ENV, "DEVICE_LIB_PATH", "")
    devlibs_path !== "" && return devlibs_path

    # The canonical location
    if isdir("/opt/rocm/amdgcn/bitcode")
        return "/opt/rocm/amdgcn/bitcode"
    end

    # Search relative to LD_LIBRARY_PATH entries
    paths = split(get(ENV, "LD_LIBRARY_PATH", ""), ":")
    paths = filter(path -> path != "", paths)
    paths = map(Base.Filesystem.abspath, paths)
    for path in paths
        bitcode_path = joinpath(path, "../amdgcn/bitcode/")
        if ispath(bitcode_path)
            if isfile(joinpath(bitcode_path, "ocml.bc")) ||
               isfile(joinpath(bitcode_path, "ocml.amdgcn.bc"))
               return bitcode_path
            end
        end
    end
    return nothing
end

function populate_globals!(config)
    for (key,val) in config
        @eval const $key = $val
    end
end
