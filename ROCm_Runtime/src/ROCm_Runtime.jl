module ROCm_Runtime

# Provides the ROCm runtime (HIP, HSA) and the vendor libraries by shipping
# AMD's TheRock distribution tarballs as lazy artifacts, selected by GPU
# architecture and ROCm version through platform augmentation (see `.pkg/`).
# The artifact is a complete ROCm root, laid out like a regular installation.
#
# Setting the "local" preference of this package switches AMDGPU.jl to a local
# ROCm installation instead (see `AMDGPU.set_rocm_version!`); no artifact is
# downloaded or resolved in that case.

using Artifacts, LazyArtifacts, Libdl

# preferences handling and platform selection, shared with Pkg's artifact
# selection hook (`.pkg/select_artifacts.jl`)
include(joinpath(@__DIR__, "..", ".pkg", "platform_augmentation.jl"))

export libamdhip64, libhsa_runtime64, libhiprtc, libamd_comgr
export libMIOpen, libhipblaslt, libhiptensor, librocblas, librocfft, librocrand, librocsolver, librocsparse

global artifact_dir::String = ""
global libamdhip64::String = ""
global libhsa_runtime64::String = ""
global libhiprtc::String = ""
global libamd_comgr::String = ""
global librocblas::String = ""
global librocsparse::String = ""
global librocsolver::String = ""
global librocrand::String = ""
global librocfft::String = ""
global libhipblaslt::String = ""
global libhiptensor::String = ""
global libMIOpen::String = ""

is_available() = !isempty(artifact_dir)

# Resolve the artifact for this host, or "" if no bundle matches (e.g. no
# supported GPU detected, or a local ROCm was requested).
function find_artifact_dir()::String
    local_preference === true && return ""
    dir = try
        @artifact_str("ROCm_Runtime", augment_platform!(HostPlatform()))
    catch err
        @debug "Could not resolve the ROCm_Runtime artifact" exception=(err, catch_backtrace())
        return ""
    end
    # Windows bundles wrap everything in a top-level directory, Linux ones don't.
    entries = readdir(dir)
    if length(entries) == 1 && startswith(only(entries), "therock-dist-")
        dir = joinpath(dir, only(entries))
    end
    return dir
end

# Locate a library in the artifact's library directory, matching both
# unversioned (`libfoo.so`) and versioned (`libfoo.so.N`) names.
function get_library(name::String)::String
    libdir = joinpath(artifact_dir, Sys.iswindows() ? "bin" : "lib")
    isdir(libdir) || return ""
    for file in readdir(libdir)
        if startswith(file, name) && occursin("." * Libdl.dlext, file)
            return joinpath(libdir, file)
        end
    end
    return ""
end

# Claimed from the bundle before LD_LIBRARY_PATH can resolve them elsewhere.
# Leaves first, as (subdirectory of the library directory, prefix, open all).
# HSA must precede HIP, or HIP's `libhsa-runtime64.so.1` binds outside the
# bundle; the vendor libraries here are ones other vendor libraries pull in.
const PRELOAD_LIBRARIES = [
    ("rocm_sysdeps/lib", "librocm_sysdeps_",        true),
    ("llvm/lib",         "libLLVM",                 false),
    ("llvm/lib",         "libclang-cpp",            false),
    ("",                 "librocprofiler-register", false),
    ("",                 "libhsa-runtime64",        false),
    ("",                 "libamd_comgr",            false),
    ("",                 "libhiprtc",               false),
    ("",                 "librocm_kpack",           false),
    ("",                 "libamdhip64",             false),
    ("",                 "libroctx64",              false),
    ("",                 "libhipblaslt",            false),
    ("",                 "librocblas",              false),
]

# path => :loaded / :failed, prefix => :absent. Shown by `AMDGPU.versioninfo()`.
global preload_log::Vector{Pair{String,Symbol}} = Pair{String,Symbol}[]

function find_libraries(subdir::String, prefix::String, every::Bool)::Vector{String}
    dir = joinpath(artifact_dir, Sys.iswindows() ? "bin" : "lib", subdir)
    isdir(dir) || return String[]
    paths = String[]
    # `every` marks a family prefix; otherwise the prefix is a whole library
    # name, and must not also match a longer one (`libhiprtc-builtins`).
    for file in readdir(dir)  # sorted, so `libfoo.so` precedes `libfoo.so.N`
        startswith(file, every ? prefix : prefix * ".") &&
            occursin("." * Libdl.dlext, file) || continue
        push!(paths, joinpath(dir, file))
        every || break
    end
    return paths
end

function preload_bundle()
    Sys.islinux() || return
    empty!(preload_log)
    seen = Set{String}()
    for (subdir, prefix, every) in PRELOAD_LIBRARIES
        paths = find_libraries(subdir, prefix, every)
        if isempty(paths)
            push!(preload_log, joinpath(subdir, prefix * "*") => :absent)
            continue
        end
        for path in paths
            resolved = try realpath(path) catch; path end
            resolved in seen && continue
            push!(seen, resolved)
            try
                # RTLD_LOCAL (Julia's default) already claims the soname.
                Libdl.dlopen(path)
                push!(preload_log, path => :loaded)
            catch err
                push!(preload_log, path => :failed)
                @debug "Could not preload $path" exception=(err, catch_backtrace())
            end
        end
    end
    return
end

# Variables that point comgr at another ROCm's device libraries. Reported, not
# removed: which one a bundle honours has moved between ROCm releases.
const REDIRECT_ENV = ["LLVM_PATH", "HIP_DEVICE_LIB_PATH", "DEVICE_LIB_PATH"]

redirect_env() = [name => ENV[name] for name in REDIRECT_ENV if haskey(ENV, name)]

# ROCm libraries mapped from outside the bundle: two ROCm versions live at once.
const FOREIGN_LIBRARY_NAMES = [
    "libamd_comgr", "libhsa-runtime64", "libamdhip64", "libhiprtc",
    "librocprofiler-register", "librocm_kpack", "libLLVM", "libclang-cpp",
    # Vendor libraries: one can pull another in, and the soname collides across
    # ROCm versions, so these mix silently unless the bundle claims them first.
    "librocblas", "librocsparse", "librocsolver", "librocrand", "librocfft",
    "libhipblaslt", "libhiptensor", "libMIOpen", "libroctx64",
]

function foreign_libraries()::Vector{String}
    isempty(artifact_dir) && return String[]
    julia_dir = dirname(Sys.BINDIR)  # Julia ships its own libLLVM
    return filter(Libdl.dllist()) do path
        any(n -> startswith(basename(path), n), FOREIGN_LIBRARY_NAMES) &&
            !startswith(path, artifact_dir) && !startswith(path, julia_dir)
    end
end

function __init__()
    global artifact_dir = find_artifact_dir()
    is_available() || return

    lib_prefix = Sys.islinux() ? "lib" : ""

    global libamdhip64 = get_library(Sys.islinux() ? "libamdhip64" : "amdhip64")
    global libhsa_runtime64 = Sys.islinux() ? get_library("libhsa-runtime64") : ""
    global libhiprtc = get_library(lib_prefix * "hiprtc")
    global libamd_comgr = get_library(lib_prefix * "amd_comgr")

    global librocblas = get_library(lib_prefix * "rocblas")
    global librocsparse = get_library(lib_prefix * "rocsparse")
    global librocsolver = get_library(lib_prefix * "rocsolver")
    global librocrand = get_library(lib_prefix * "rocrand")
    global librocfft = get_library(lib_prefix * "rocfft")
    global libhipblaslt = get_library(lib_prefix * "hipblaslt")
    global libhiptensor = get_library(lib_prefix * "hiptensor")
    global libMIOpen = get_library(lib_prefix * "MIOpen")

    # Must precede `AMDGPU.__init__`, which loads HSA and HIP.
    preload_bundle()
end

end
