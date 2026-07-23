# Enumerate `<root>/core-<version>` subdirectories (ROCm 7.14+ packaging),
# sorted newest-version first. Returns absolute paths.
function rocm_core_dirs(path::String)::Vector{String}
    isdir(path) || return String[]
    cores = Tuple{VersionNumber, String}[]
    for entry in readdir(path)
        startswith(entry, "core-") || continue
        full = joinpath(path, entry)
        isdir(full) || continue
        v = tryparse(VersionNumber, chopprefix(entry, "core-"))
        v === nothing && continue
        push!(cores, (v, full))
    end
    sort!(cores; by=first, rev=true)
    return String[c[2] for c in cores]
end

# True if `dir` holds the HIP runtime library, matching both the unversioned
# `libamdhip64.so` and versioned `libamdhip64.so.N` (a minimal, gfx-specific
# install may ship only the latter, without the `-dev` symlink).
function has_hip_lib(dir::String, libname::String)::Bool
    isdir(dir) || return false
    return any(f -> startswith(f, libname), readdir(dir))
end

# use amdhip as query for a valid rocm_path
function check_rocm_path(path::String)
    libname = (Sys.islinux() ? "libamdhip64" : "amdhip64") * "." * dlext
    path2 = path
    isfile(joinpath(path2, libname)) && @goto success
    path2 = joinpath(path, "lib")
    isfile(joinpath(path2, libname)) && @goto success
    path2 = joinpath(path, "bin")
    isfile(joinpath(path2, libname)) && @goto success
    path2 = joinpath(path, "lib64")
    isfile(joinpath(path2, libname)) && @goto success
    # Check Debian/Ubuntu multiarch lib paths (e.g. /usr/lib/x86_64-linux-gnu)
    if Sys.islinux()
        for triplet in ("x86_64-linux-gnu", "aarch64-linux-gnu", "i386-linux-gnu")
            path2 = joinpath(path, "lib", triplet)
            isfile(joinpath(path2, libname)) && @goto success
        end
    end
    # ROCm 7.14+ nests libraries under `<root>/core-<version>/lib`. A full
    # metapackage install also exposes them via `<root>/lib` (handled above via
    # a compat symlink), but a minimal, gfx-specific install may not, so probe
    # the versioned core dirs directly, newest first.
    if Sys.islinux()
        for core in rocm_core_dirs(path)
            path2 = joinpath(core, "lib")
            has_hip_lib(path2, libname) && @goto success
        end
    end
    return ""

    @label success
    @assert isdir(path2)
    return path2
end

# Find libdir of ROCm directory.
function find_roc_path()::String
    env_dir = get(ENV, "ROCM_PATH", "")
    if isdir(env_dir)
        rocm_path = check_rocm_path(env_dir)
        rocm_path != "" && return rocm_path
    end

    if Sys.islinux()
        hipconfig = Sys.which("hipconfig")
        if !isnothing(hipconfig)
            rocm_path = read(`$hipconfig --rocmpath`, String)
            rocm_path = check_rocm_path(rocm_path)
            isdir(rocm_path) && return rocm_path
        end
        rocm_path = check_rocm_path("/opt/rocm")
        isdir(rocm_path) && return rocm_path
        rocm_path = check_rocm_path("/usr")
        isdir(rocm_path) && return rocm_path
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

# use hip.bc as query for a valid device libs dir
function check_device_libs(path::String)
    if isdir(path)
        file_path = joinpath(path, "hip" * ".bc")
        if !ispath(file_path)
            file_path = joinpath(path, "hip"* ".amdgcn.bc")
            if !ispath(file_path)
                # failed to find matching bitcode file
                return ""
            end
        end
        return path
    else
        return ""
    end
end

function find_device_libs(rocm_path::String)::String
    env_dir = get(ENV, "ROCM_PATH", "")
    if isdir(env_dir)
        for cand in (
            joinpath(env_dir, "amdgcn", "bitcode"),
            # ROCm 7.14+ nests device bitcode under lib/llvm/.
            joinpath(env_dir, "lib", "llvm", "amdgcn", "bitcode"),
        )
            path = check_device_libs(cand)
            isdir(path) && return path
        end
    end
    # Might be set by tools like Spack or the user
    hip_devlibs_path = get(ENV, "HIP_DEVICE_LIB_PATH", "")
    hip_devlibs_path !== "" && return hip_devlibs_path
    devlibs_path = get(ENV, "DEVICE_LIB_PATH", "")
    devlibs_path !== "" && return devlibs_path
    # Try using hipconfig to find the device libraries.
    # Try the canonical location (`rocm_path` is the libdir).
    for cand in (
        joinpath(rocm_path, "amdgcn", "bitcode"),
        # ROCm 7.14+ nests device bitcode under llvm/.
        joinpath(rocm_path, "llvm", "amdgcn", "bitcode"),
    )
        canonical_dir = check_device_libs(cand)
        isdir(canonical_dir) && return canonical_dir
    end
    # Fedora might put it in a weird place
    hipconfig = Sys.which("hipconfig")
    if !isnothing(hipconfig)
        clang_path = read(`$hipconfig --hipclangpath`, String)
        lib_path = joinpath(clang_path ,".." , "lib","clang")
        if isdir(lib_path)
            lib_path = joinpath(lib_path, only(readdir(lib_path)))
            lib_path = joinpath(lib_path, "amdgcn", "bitcode")
            lib_path = check_device_libs(lib_path)
            isdir(lib_path) && return lib_path
        end
    end
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
    libdir = joinpath(rocm_path, rel_libdir)
    isdir(libdir) || return ""
    for file in readdir(libdir; join=true)
        fname = basename(file)
        matched = startswith(fname, lib) && contains(fname, ext)
        matched && return file
    end
    return ""
end

function find_ld_lld(rocm_path::String)::String
    lld_name = "ld.lld" * (Sys.iswindows() ? ".exe" : "")

    dirs = (joinpath(rocm_path,"llvm", "bin"), joinpath(rocm_path,"bin"))
    hipconfig = Sys.which("hipconfig")
    if !isnothing(hipconfig)
        clang_path = read(`$hipconfig --hipclangpath`, String)
        dirs = (dirs ..., clang_path)
    end
    for dir in dirs
        exp_ld_path = joinpath(dir, lld_name)
        ispath(exp_ld_path) || continue
        try
            tmpfile = tempname(;cleanup=false)
            run(pipeline(`$exp_ld_path -v`; stdout=tmpfile))
            vstr = read(tmpfile, String)
            rm(tmpfile)
            # Match first version number in the output, e.g. "AMD LLD 15.0.0 ..." or "Ubuntu LLD 21.0.0 ..."
            m = match(r"(\d+\.\d+(?:\.\d+)?)", vstr)
            if m !== nothing && VersionNumber(m.captures[1]) >= v"6.0.0"
                return exp_ld_path
            end
        catch
            @warn "bindeps: Failed running ld.lld in $exp_ld_path"
        end
    end
    return ""
end
