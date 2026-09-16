module ROCm_Runtime_Discovery

# Discovery of a local ROCm installation, as an alternative to the artifacts
# shipped by the ROCm_Runtime subpackage.
#
# This package replicates the API of ROCm_Runtime (the HIP/HSA runtime and
# the vendor libraries) for a local ROCm installation. It is only loaded when
# the user opts into that through the "local" preference of ROCm_Runtime;
# by default the artifacts are used instead. `ld.lld` is not discovered here:
# it is always provided by AMDGPU_LLVM_Backend_jll.

using Libdl

# same names as ROCm_Runtime
export libamdhip64, libhsa_runtime64, libhiprtc, libamd_comgr
export libMIOpen, libhipblaslt, libhiptensor, librocblas, librocfft, librocrand, librocsolver, librocsparse

include("utils.jl")

global rel_libdir::String = Sys.islinux() ? "" : "bin"

global libhsa_runtime64::String = ""
global libamdhip64::String = ""
global libhiprtc::String = ""
global libamd_comgr::String = ""
# The local device bitcode libraries are discovered but unexported: AMDGPU.jl
# uses the downgraded AMDGPU_LLVM_Backend_jll ones and only falls back to these
# (which target a newer LLVM than Julia's) when that downgrade fails.
global libdevice_libs::String = ""
global librocblas::String = ""
global librocsparse::String = ""
global librocsolver::String = ""
global librocrand::String = ""
global librocfft::String = ""
global libhipblaslt::String = ""
global libhiptensor::String = ""
global libMIOpen::String = ""

const available = Ref{Bool}(false)
is_available() = available[]

function __init__()
    rocm_path = find_roc_path()
    lib_prefix = Sys.islinux() ? "lib" : ""

    try
        global libhsa_runtime64 = Sys.islinux() ?
            find_rocm_library("libhsa-runtime64"; rocm_path, ext="so.1") :
            ""

        # HIP runtime.
        global libamdhip64 = find_rocm_library(Sys.islinux() ? "libamdhip64" : "amdhip64"; rocm_path)
        global libhiprtc = find_rocm_library((Sys.islinux() ? "lib" : "") * "hiprtc"; rocm_path)
        global libamd_comgr = find_rocm_library((Sys.islinux() ? "lib" : "") * "amd_comgr"; rocm_path)

        # Device bitcode libraries (fallback only, see above).
        global libdevice_libs = find_device_libs(rocm_path)

        # HIP-based libraries.
        global librocblas = find_rocm_library(lib_prefix * "rocblas"; rocm_path)
        global librocsparse = find_rocm_library(lib_prefix * "rocsparse"; rocm_path)
        global librocsolver = find_rocm_library(lib_prefix * "rocsolver"; rocm_path)
        global librocrand = find_rocm_library(lib_prefix * "rocrand"; rocm_path)
        global librocfft = find_rocm_library(lib_prefix * "rocfft"; rocm_path)
        global libhipblaslt = find_rocm_library(lib_prefix * "hipblaslt"; rocm_path)
        global libhiptensor = find_rocm_library(lib_prefix * "hiptensor"; rocm_path)
        global libMIOpen = find_rocm_library(lib_prefix * "MIOpen"; rocm_path)

        available[] = !isempty(libamdhip64)
    catch err
        @error """ROCm discovery failed!
        Discovered ROCm path: $rocm_path.
        Use `ROCM_PATH` env variable to specify ROCm directory.

        """ exception=(err, catch_backtrace())
    end
end

end
