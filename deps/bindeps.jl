# copied from CUDAdrv/deps/build.jl

using Libdl
import Base: @invokelatest
using Preferences

enable_artifacts!(flag::Bool=true) =
    @set_preferences!("use_artifacts" => flag)
if haskey(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS")
    enable_artifacts!(!parse(Bool, get(ENV, "JULIA_AMDGPU_DISABLE_ARTIFACTS", "false")))
end
const use_artifacts = @load_preference("use_artifacts", true)

## library finding

function find_roc_paths()
    paths = split(get(ENV, "LD_LIBRARY_PATH", ""), ":")
    paths = filter(path->path != "", paths)
    paths = map(Base.Filesystem.abspath, paths)
    push!(paths, "/opt/rocm/lib") # shim for Ubuntu rocm packages...
    if haskey(ENV, "ROCM_PATH")
        push!(paths, joinpath(ENV["ROCM_PATH"], "lib"))
    end
    return filter(isdir, paths)
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
    paths = filter(path->path != "", paths)
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
    paths = filter(path->path != "", paths)
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
julia_exeflags(projects=detect_projects()) =
    String["--startup-file=no",
           "--project=$(projects.julia_project)"]
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

function populate_globals!(config)
    for (key,val) in config
        @eval const $key = $val
    end
end

const rocm_ext_libs = [
    (:rocblas, :rocBLAS_jll),
    (:rocsparse, :rocSPARSE_jll),
    (:rocsolver, nothing),
    (:rocalution, nothing),
    (:rocrand, :rocRAND_jll),
    (:rocfft, nothing),
    (:MIOpen, :MIOpen_jll),
]

function bindeps_setup()
    config = Dict{Symbol,Any}(
        :use_artifacts => use_artifacts,
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
        :device_libs_build_reason => "unknown",
    )
    for (name, _) in rocm_ext_libs
        lib = Symbol(:lib, string(name))
        config[lib] = nothing
        config[Symbol(name, :_configured)] = false
        config[Symbol(name, :_build_reason)] = "unknown"
    end

    ## discover stuff

    # check that we're running Linux
    if !Sys.islinux()
        @debug "Not running Linux, which is the only platform currently supported by the ROCm Runtime."
        config[:build_reason] = "Unsupported OS: $(repr(Sys.KERNEL))"
        @goto populate
    end

    # Skip build if KFD is not available
    if !ispath("/dev/kfd")
        @debug "/dev/kfd not available, cannot use ROCm Runtime."
        @goto populate
    end

    # Find some paths for library search
    roc_dirs = find_roc_paths()

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
        if !loaded
            return loaded, false, error_str
        end
        @eval import $pkg
        available = @eval(isdefined($pkg, :is_available)) && @eval($pkg.is_available())
        return loaded, available, error_str
    end

    # Find HSA runtime v1
    if use_artifacts
        loaded, available, error_str = safe_import(:hsa_rocr_jll)
        if loaded
            if available
                config[:libhsaruntime_path] = hsa_rocr_jll.libhsa_runtime64
                config[:hsa_configured] = true
            else
                config[:hsa_build_reason] = "hsa_rocr_jll is not available on this platform"
            end
        else
            iob = IOBuffer()
            println(iob, "`import hsa_rocr_jll` failed:")
            print(iob, error_str)
            config[:hsa_build_reason] = String(take!(iob))
        end
    else
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
    if !config[:hsa_configured]
        @goto populate
    end

    ### Find ld.lld
    if use_artifacts
        loaded, available, error_str = safe_import(:LLD_jll)
        if loaded
            if available || (Base.libllvm_version < v"14" && @invokelatest(LLD_jll.LLVM_jll.is_available()))
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

    ### Find device libraries
    if use_artifacts
        loaded, available, error_str = safe_import(:ROCmDeviceLibs_jll)
        if loaded
            if available
                config[:device_libs_path] = ROCmDeviceLibs_jll.bitcode_path
                config[:device_libs_configured] = true
            else
                config[:device_libs_build_reason] = "ROCmDeviceLibs_jll is not available on this platform"
            end
        else
            iob = IOBuffer()
            println(iob, "`import ROCmDeviceLibs_jll` failed:")
            print(iob, error_str)
            config[:device_libs_build_reason] = String(take!(iob))
        end
    else
        device_libs_path = find_device_libs()
        if !isempty(something(device_libs_path, ""))
            # TODO: Validate bitcode files
            config[:device_libs_path] = device_libs_path
            config[:device_libs_configured] = true
        else
            config[:device_libs_build_reason] = "Couldn't find bitcode files"
        end
    end

    ### Find HIP
    if use_artifacts
        loaded, available, error_str = safe_import(:HIP_jll)
        if loaded
            if available
                config[:libhip_path] = HIP_jll.libamdhip64
                config[:hip_configured] = true
            else
                config[:hip_build_reason] = "HIP_jll is not available on this platform"
            end
        else
            iob = IOBuffer()
            println(iob, "`import HIP_jll` failed:")
            print(iob, error_str)
            config[:hip_build_reason] = String(take!(iob))
        end
    else
        libhip_path = find_rocm_library(["libamdhip64", "libhip_hcc"], roc_dirs)
        if !isempty(something(libhip_path, ""))
            loaded, error_str = safe_exec("using Libdl; dlopen(\"$libhip_path\")")
            if loaded
                config[:libhip_path] = libhip_path
                config[:hip_configured] = true
            else
                iob = IOBuffer()
                println(iob, "Loading HIP failed:")
                print(iob, error_str)
                config[:hip_build_reason] = String(take!(iob))
            end
        else
            config[:hip_build_reason] = "Could not find `libamdhip64` or `libhip_hcc` libraries"
        end
    end
    if config[:hip_configured]
        ### Find HIP-based libraries
        @sync for (name, pkg) in rocm_ext_libs
            @async begin
            lib = Symbol(:lib, string(name))
            if use_artifacts
                if pkg !== nothing
                    loaded, available, error_str = safe_import(pkg)
                    if loaded
                        if available
                            config[lib] = getfield(@eval($pkg), lib)
                            config[Symbol(name, :_configured)] = true
                        else
                            config[Symbol(name, :_build_reason)] = "$pkg is not available on this platform"
                        end
                    else
                        iob = IOBuffer()
                        println(iob, "`import $pkg` failed:")
                        print(iob, error_str)
                        config[Symbol(name, :_build_reason)] = String(take!(iob))
                    end
                end
            else
                libpath = find_rocm_library(string(lib), roc_dirs)
                if !isempty(something(libpath, ""))
                    loaded, error_str = safe_exec("using Libdl; dlopen(\"$libpath\")")
                    if loaded
                        config[lib] = libpath
                        config[Symbol(name, :_configured)] = true
                    else
                        iob = IOBuffer()
                        println(iob, "Loading `$lib` failed:")
                        print(iob, error_str)
                        config[Symbol(name, :_build_reason)] = String(take!(iob))
                    end
                else
                    config[Symbol(name, :_build_reason)] = "Could not find `$lib` library"
                end
            end
            end # @async
        end
    end

    config[:configured] = true

    @label populate
    populate_globals!(config)
end

# Load binary dependencies
bindeps_setup()
