# Selection of the ROCm library provider.
#
# By default the ROCm runtime (HIP, HSA) and the vendor libraries (rocBLAS et
# al.) come from the ROCm_Runtime subpackage, which ships AMD's TheRock
# distribution as lazy artifacts. Setting its "local" preference (see
# `AMDGPU.set_rocm_version!`) switches them to a local ROCm installation,
# discovered through ROCm_Runtime_Discovery; that package is not loaded at all
# otherwise.
#
# `ld.lld` and the device libraries always come from their JLLs: `ld.lld` has
# to match the LLVM version device code is generated with, and local device
# libraries target a newer LLVM than Julia's and would need to be downgraded.

import AMDGPU_LLVM_Backend_jll
import ROCmDeviceLibs_jll
import ROCm_Runtime

const local_rocm = ROCm_Runtime.local_preference === true
if local_rocm
    import ROCm_Runtime_Discovery
end

global libhsaruntime::String = ""
global libhip::String = ""
global lld_path::String = ""
global libdevice_libs::String = ""
global librocblas::String = ""
global librocsparse::String = ""
global librocsolver::String = ""
global librocrand::String = ""
global librocfft::String = ""
global libMIOpen::String = ""

function __init_libs__()
    if local_rocm
        global libhip = ROCm_Runtime_Discovery.libamdhip64
        global libhsaruntime = ROCm_Runtime_Discovery.libhsa_runtime64
        global librocblas = ROCm_Runtime_Discovery.librocblas
        global librocsparse = ROCm_Runtime_Discovery.librocsparse
        global librocsolver = ROCm_Runtime_Discovery.librocsolver
        global librocrand = ROCm_Runtime_Discovery.librocrand
        global librocfft = ROCm_Runtime_Discovery.librocfft
        global libMIOpen = ROCm_Runtime_Discovery.libMIOpen
    elseif ROCm_Runtime.is_available()
        global libhip = ROCm_Runtime.libamdhip64
        global libhsaruntime = Sys.islinux() ?
            ROCm_Runtime.libhsa_runtime64 : ""
        global librocblas = ROCm_Runtime.librocblas
        global librocsparse = ROCm_Runtime.librocsparse
        global librocsolver = ROCm_Runtime.librocsolver
        global librocrand = ROCm_Runtime.librocrand
        global librocfft = ROCm_Runtime.librocfft
        global libMIOpen = ROCm_Runtime.libMIOpen
    end

    if AMDGPU_LLVM_Backend_jll.is_available()
        global lld_path = AMDGPU_LLVM_Backend_jll.lld_path
    end

    if ROCmDeviceLibs_jll.is_available()
        global libdevice_libs = ROCmDeviceLibs_jll.bitcode_path
    end
end

"""
    AMDGPU.set_rocm_version!([version::VersionNumber]; [local_rocm::Bool])

Configure the active project to use a specific ROCm version from a specific
source.

If `local_rocm` is set, the ROCm runtime and libraries will be used from the
local system, otherwise they will be downloaded from an artifact source. In the
case of a local ROCm, `version` informs AMDGPU.jl which version that is (this
may be useful if auto-detection fails). In the case of artifact sources,
`version` controls which version will be downloaded and used.

When not specifying either the `version` or the `local_rocm` argument, the
default behavior will be used, which is to use the most recent compatible
artifacts. Note that this will override any preferences that may be configured
in a higher-up depot; to clear preferences nondestructively, use
[`AMDGPU.reset_rocm_version!`](@ref) instead.
"""
function set_rocm_version!(version::Union{Nothing,VersionNumber}=nothing;
                           local_rocm::Union{Nothing,Bool}=nothing)
    Preferences.set_preferences!(ROCm_Runtime,
        "version" => isnothing(version) ? nothing : "$(version.major).$(version.minor)";
        force=true)
    Preferences.set_preferences!(ROCm_Runtime,
        "local" => isnothing(local_rocm) ? nothing : string(local_rocm);
        force=true)

    io = IOBuffer()
    print(io, "Configured the active project to use ")
    if version !== nothing
        print(io, "ROCm $(version.major).$(version.minor)")
    else
        print(io, "the default ROCm")
    end
    if local_rocm !== nothing
        print(io, local_rocm ? " from the local system" : " from artifact sources")
    end
    print(io, "; please re-start Julia for this to take effect.")
    @info String(take!(io))
end

"""
    AMDGPU.reset_rocm_version!()

Reset the ROCm version preferences in the active project to the default, which
is to use the most recent compatible artifacts, unless a higher-up depot has
configured a different preference. To force use of the default behavior for the
local project, use [`AMDGPU.set_rocm_version!`](@ref) with no arguments.
"""
function reset_rocm_version!()
    Preferences.delete_preferences!(ROCm_Runtime, "version"; force=true)
    Preferences.delete_preferences!(ROCm_Runtime, "local"; force=true)
    @info "Reset ROCm version preference, please re-start Julia for this to take effect."
end
