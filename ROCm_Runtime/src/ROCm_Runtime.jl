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

# The bundle's libraries name their ROCm dependencies by soname and carry a
# DT_RUNPATH, which the loader searches only after LD_LIBRARY_PATH. A ROCm on
# LD_LIBRARY_PATH (a module, a uenv, AMD's containers) therefore displaces the
# bundle's copies of whatever HIP pulls in transitively, mixing two ROCm
# releases in one process (https://github.com/ROCm/TheRock/issues/7426). The
# loader reads LD_LIBRARY_PATH once at start-up, so this cannot be undone from
# inside the process; it is detected and reported instead (see below), and has
# to be fixed in the environment.

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
end

end
